"""
Big Clock server — serves static files + lock-screen API.
  python server.py          → http://localhost:8888
  POST /api/lock            → triggers Windows lock (Win+L)

On any Windows PC: double-click start.bat or run `python server.py`.
"""
import http.server
import json
import os
import sys
import webbrowser

PORT = int(os.environ.get('PORT', 8888))

# Windows lock support (safe import — non-Windows just skips)
try:
    import ctypes
    _lock = lambda: ctypes.windll.user32.LockWorkStation()
except AttributeError:
    _lock = None


class Handler(http.server.SimpleHTTPRequestHandler):
    def do_OPTIONS(self):
        self.send_response(200)
        self._cors()
        self.end_headers()

    def do_POST(self):
        if self.path == '/api/lock':
            if _lock is None:
                self._json(501, {'error': 'Lock not supported on this OS'})
                return
            try:
                _lock()
                self._json(200, {'ok': True})
            except Exception as e:
                self._json(500, {'error': str(e)})
        else:
            self.send_response(404)
            self.end_headers()

    def _json(self, code, data):
        self.send_response(code)
        self._cors()
        self.send_header('Content-Type', 'application/json')
        self.end_headers()
        self.wfile.write(json.dumps(data).encode())

    def _cors(self):
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type')


if __name__ == '__main__':
    # Serve from the directory where server.py lives
    os.chdir(os.path.dirname(os.path.abspath(__file__)))

    with http.server.HTTPServer(('', PORT), Handler) as httpd:
        url = f'http://localhost:{PORT}'
        print(f'Big Clock running at {url}')
        print('Lock screen API available at POST /api/lock')
        print('Press Ctrl+C to stop.\n')
        webbrowser.open(url)
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print('\nStopped.')

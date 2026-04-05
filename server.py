"""
Tiny lock-screen API server.
Run alongside the main static server:
  python server.py
Listens on port 9999. The browser calls POST /lock to invoke Win+L.
"""
import http.server
import json
import ctypes

PORT = 9999

class LockHandler(http.server.BaseHTTPRequestHandler):
    def do_OPTIONS(self, *_):
        self.send_response(200)
        self._cors()
        self.end_headers()

    def do_POST(self):
        if self.path == '/lock':
            try:
                ctypes.windll.user32.LockWorkStation()
                self.send_response(200)
                self._cors()
                self.send_header('Content-Type', 'application/json')
                self.end_headers()
                self.wfile.write(json.dumps({'ok': True}).encode())
            except Exception as e:
                self.send_response(500)
                self._cors()
                self.send_header('Content-Type', 'application/json')
                self.end_headers()
                self.wfile.write(json.dumps({'error': str(e)}).encode())
        else:
            self.send_response(404)
            self.end_headers()

    def _cors(self):
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type')

    def log_message(self, fmt, *args):
        pass  # silent

with http.server.HTTPServer(('127.0.0.1', PORT), LockHandler) as httpd:
    print(f'Lock API listening on http://127.0.0.1:{PORT}/lock')
    httpd.serve_forever()

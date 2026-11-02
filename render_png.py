import os
import subprocess
import time

base_dir = os.path.abspath(os.path.dirname(__file__))
svg_file = os.path.join(base_dir, 'docs', 'CIRDEMS_Chen_ER_Diagram.svg')
png_file = os.path.join(base_dir, 'docs', 'CIRDEMS_Chen_ER_Diagram.png')
user_data = os.path.join(os.environ.get('TEMP', r'C:\Temp'), 'edge_shot_profile')

print(f"SVG: {svg_file}")
print(f"PNG: {png_file}")

cmd = [
    r'C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe',
    '--headless',
    '--disable-gpu',
    f'--user-data-dir={user_data}',
    '--window-size=1040,720',
    f'--screenshot={png_file}',
    f'file:///{svg_file.replace(os.sep, "/")}'
]

proc = subprocess.run(cmd, capture_output=True, text=True)
print("Return code:", proc.returncode)
print("Output:", proc.stdout)
print("Error:", proc.stderr)
print("PNG exists:", os.path.exists(png_file), "Size:", os.path.getsize(png_file) if os.path.exists(png_file) else 0)

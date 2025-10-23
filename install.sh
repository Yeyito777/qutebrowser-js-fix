#!/usr/bin/env bash

set -euo pipefail

repo_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
venv_dir="${HOME}/.local/share/qutebrowser-venv"
venv_python="${venv_dir}/bin/python"
launcher_dir="${HOME}/.local/bin"
launcher_path="${launcher_dir}/qutebrowser"

echo "[+] creating virtualenv at ${venv_dir}"
python -m venv --system-site-packages "${venv_dir}" >/dev/null

echo "[+] upgrading pip/wheel"
"${venv_python}" -m pip install --upgrade pip wheel >/dev/null

echo "[+] installing qutebrowser from ${repo_dir}"
"${venv_python}" -m pip install --upgrade "${repo_dir}" >/dev/null

echo "[+] writing launcher ${launcher_path}"
mkdir -p "${launcher_dir}"
cat >"${launcher_path}" <<EOF
#!/usr/bin/env bash
exec ${venv_dir}/bin/python -m qutebrowser "\$@"
EOF
chmod +x "${launcher_path}"

echo
echo "Install complete. Launch with: ${launcher_path}"

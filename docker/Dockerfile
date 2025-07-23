FROM debian:bookworm

RUN bash <<EOT
set -euxo pipefail

apt-get update
apt-get upgrade -y
apt-get install -y bash git curl ca-certificates gcc
apt-get autoremove --purge

EOT

RUN bash <<EOT
set -euxo pipefail
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
EOT


ENV PATH=/root/.cargo/bin/:${PATH}
RUN bash <<EOT
set -euxo pipefail

rustup component add rust-std-wasm32-unknown-unknown
curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh
EOT

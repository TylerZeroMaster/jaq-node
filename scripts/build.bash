args=(build --target nodejs --no-pack)

profile="${1:-}"
if [[ "$profile" == "release" ]]; then
    args+=(--release)
elif [[ "$profile" == "dev" ]]; then
    args+=(--dev)
else
    echo "Unknown profile: $profile" >&2
    exit 117
fi

wasm-pack "${args[@]}"

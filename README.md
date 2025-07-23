# jaq-node

jaq-node is a nodejs wasm interface for [jaq](https://github.com/01mf02/jaq).

This interface was adapted from [jaq-play](https://github.com/01mf02/jaq/tree/main/jaq-play).

## Usage

```typescript
import { run } from './jaq_node';

export interface Settings {
  raw_input?: boolean;
  slurp?: boolean;
  null_input?: boolean;
  raw_output?: boolean;
  compact?: boolean;
  indent?: number;
  tab?: boolean;
}

export const newJaqFilter = (settings: Settings = {}) => ({
  query: (filter: string, ...input: unknown[]) =>
    run(filter, input.map((i) => JSON.stringify(i)).join('\n'), settings).map(
      (result: string) => JSON.parse(result),
    ),
  queryRaw: (filter: string, input: string) => run(filter, input, settings),
});

const jaq = newJaqFilter({ compact: true });

const obj = {
  a: {
    b: {
      c: {
        d: 1
      }
    }
  }
};

const d = jaq.query('.. | select(.d? != null)', obj);

console.log(d); // {"d": 1}
```

You can pass multiple inputs too: an array of outputs is returned.

```typescript
const firstItems = jaq.query('.[0]', [0], [1], [2], [3]);
console.log(firstItems); // [0,1,2,3]
```

## Build

The [build script](./scripts/build.bash) contains the options I use.

You will need rustc, wasm-pack, and rust-std-wasm32-unknown-unknown.

The [Dockerfile](./docker/Dockerfile) should have everything you need. You can run the build script with docker/podman by running `./docker/bash ./scripts/build.bash`.

The build script accepts a single argument: the profile (`dev` or `release`).

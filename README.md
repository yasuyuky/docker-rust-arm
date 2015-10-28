
# Docker Image for cross compilation in rust

target:arm-unknown-linux-gnueabihf

# Usage

Change directory to your project root.

Then you enter into docker image.

```
docker run -it --rm -v ${PWD}:/source yasuyuky/rust-arm
```

and following commands works


```
cargo build --target=arm-unknown-linux-gnueabihf
```

```
rustc --target=arm-unknown-linux-gnueabihf -C linker=arm-linux-gnueabihf-gcc-4.8 foo.rs
```

# License

MIT

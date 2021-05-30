# from https://github.com/GoogleContainerTools/distroless/blob/main/examples/rust/Dockerfile
# build with `docker build -t rust-thot .` or with `CI=true dive build -t rust-thot .` to chain with dive analysis
# run with `docker run -p 8080:8080 -it --rm rust-thot`
# call with `curl -i http://127.0.0.1:8080/api/status`
FROM docker.io/library/rust:1.52.0 as build-env
WORKDIR /app
ADD . /app
RUN cargo build --release --target=x86_64-unknown-linux-gnu

FROM gcr.io/distroless/cc
COPY --from=build-env /app/target/x86_64-unknown-linux-gnu/release/thot /app
CMD ["/app"]
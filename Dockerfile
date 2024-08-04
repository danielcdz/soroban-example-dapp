# Based on Preview 7
# https://soroban.stellar.org/docs/reference/releases
FROM ubuntu:22.04

ENV PATH="/root/.cargo/bin:${PATH}"
ENV PATH="$PATH:/workspace/target/bin"
ENV IS_USING_DOCKER=true
ENV SOROBAN_CLI_REVISION="c7fb7e08ba8efa9828d9df863d991558f269e35b"
ENV GIT_REVISION=$SOROBAN_CLI_REVISION

RUN apt update && \
    apt install -y curl build-essential && \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && \
    rustup target add wasm32-unknown-unknown

WORKDIR /workspace

COPY .cargo /root/.cargo

RUN cargo install_soroban 

WORKDIR /workspace/target/bin

CMD ["./soroban", "--version"]

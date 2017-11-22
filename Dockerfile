FROM elixir:1.5.2

RUN apt update && \
    apt install -y graphicsmagick && \
    mkdir /app

WORKDIR /app

ADD . /app

RUN mix local.hex --force && \
    mix deps.get && \
    mix local.rebar --force

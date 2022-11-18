FROM elixir:latest

RUN apt-get update && \
  apt-get install -y libreoffice

RUN mkdir /app
COPY . /app
WORKDIR /app

RUN apt-get install -y python3-pip
RUN pip3 install unoserver

RUN mix local.hex --force

RUN mix local.rebar --force

RUN mix deps.get

RUN MIX_ENV=prod mix do compile

CMD ["/app/entrypoint.sh"]

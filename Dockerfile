FROM elixir:1.9

RUN mix local.hex --force && mix local.rebar

RUN apt-get update && apt-get install -y inotify-tools wget dpkg

RUN cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

RUN wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && dpkg -i erlang-solutions_1.0_all.deb \
&& apt-get update \
&& apt-get install esl-erlang -y
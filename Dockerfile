FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive \
    POSTGRES_USER=stephen \
    POSTGRES_PASSWORD=password \
    RAILS_ENV=production
COPY . /app
WORKDIR /app

RUN apt update && \
    apt install -y build-essential ruby ruby-dev libpq-dev libyaml-dev && \
    yes 1 | apt install -y postgresql && \
    service postgresql start && \
    su - postgres -c "yes '${POSTGRES_PASSWORD}' | createuser -P -s '${POSTGRES_USER}'" && \
    gem install bundle rails && \
    bundle3.0 install && \
    bin/rails db:create && \
    bin/rails db:migrate && \
    bin/rake assets:precompile

EXPOSE 3000
ENTRYPOINT [ "/app/entrypoint.sh" ]

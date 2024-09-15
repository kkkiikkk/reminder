FROM ruby:3.3.4

WORKDIR /app

RUN apt-get update && apt-get install -y tzdata
ENV TZ=Europe/Kyiv

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

RUN chmod +x /app/bin/reminder

CMD ["ruby", "/app/bin/reminder"]

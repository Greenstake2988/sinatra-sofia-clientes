
FROM ruby:3.1.2

WORKDIR /sinatra
COPY . /sinatra
RUN bundle install
RUN rake db:create
RUN rake db:migrate

EXPOSE 4567

CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "4567"]
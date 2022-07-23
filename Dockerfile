FROM ruby:3.0

RUN curl https://deb.nodesource.com/setup_12.x | bash
RUN curl https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# установка библиотек для работы приложения (сейчас отсутствуют)
RUN apt-get update -qq && apt-get install -y yarn nodejs

ENV APP_PATH=/usr/src
WORKDIR $APP_PATH

# устаналивает гемы, необходимые приложению
COPY Gemfile* $APP_PATH/
RUN bundle

# копирует код приложения
COPY . .

# сообщает на каком порту работает приложение
EXPOSE 3000

# устанавливает команду по умолчанию
CMD ["rails", "server", "-b", "0.0.0.0"]
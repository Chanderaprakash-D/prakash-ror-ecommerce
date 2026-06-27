FROM public.ecr.aws/docker/library/ruby:3.2.11

RUN apt-get update -qq && apt-get install -y \
    build-essential \
    default-mysql-client \
    default-libmysqlclient-dev \
    nodejs \
    wget \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN wget -q https://s3.amazonaws.com/amazoncloudwatch-agent/debian/amd64/latest/amazon-cloudwatch-agent.deb \
    && dpkg -i amazon-cloudwatch-agent.deb \
    && rm amazon-cloudwatch-agent.deb

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

COPY cloudwatch/amazon-cloudwatch-agent.json /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

EXPOSE 3000

CMD ["/app/start.sh"]
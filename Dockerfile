FROM python:3.10.6-slim-bullseye
COPY . /app
WORKDIR /app

RUN pip install -U datasette
RUN datasette inspect webvid.db --inspect-file inspect-data.json
ENV PORT 8080
EXPOSE 8080
CMD datasette serve --host 0.0.0.0 -p 8080 -i webvid.db --cors --inspect-file inspect-data.json --metadata metadata.json --plugins-dir plugins/ --port $PORT

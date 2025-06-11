FROM python:3-alpine
RUN pip install --no-cache-dir jinja2-cli
WORKDIR /data
ENTRYPOINT ["jinja2"]
CMD ["--help"]
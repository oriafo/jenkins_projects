FROM python:3.9.17-slim-bullseye AS testing_jenkins
WORKDIR /app
COPY . ./
EXPOSE 4300
ENTRYPOINT [ "python3", "myfile.py" ]dock
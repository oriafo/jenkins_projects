FROM python:3.9.17-slim-bullseye AS testing_jenkins
WORKDIR /app
COPY . ./
EXPOSE 4300
ENTRYPOINT [ "python3", "myfile.py" ]
#its best practice for you to create a user rather than using sudo.
#Create the user and add him to the docker group so as to have docker permission than is already onthe group.
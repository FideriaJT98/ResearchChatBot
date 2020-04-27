# ResearchChatBot
A julia chatbot with tensorflow and web scraping

## Prerequisites
- Access to this repository on GitHub.

### Get Repo
Clone this Github repo on the dev machine as follows:

```
$ git clone https://github.com/FideriaJT98/ResearchChatBot.git
```

You should now see a folder containing the contents of this repo:
```
$ls
DockerFile start.jl
```
This Dockerfile file compile with reference to https://www.tensorflow.org/install/source#docker_linux_builds


### Docker build and run
```
$docker build -t chatbot:nust .
```

### Docker run container
-d : is to run the container in the background
-p : is to publish the Port 80 of the container to the 8080 port of the host so that we can access the website in our host browser
```
$docker run -it -d -p 8888:8888 --name mybot chatbot:nust
$docker run -t -d -p 8000:80 --name mybot chatbot:nust
```

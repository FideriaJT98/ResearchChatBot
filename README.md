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
Currently using a Jupyter Notebook Tensorflow image for testing, will change to devel image later

### Docker build and run
```
$docker build -t chatbot:nust .
```

### Docker run container
-d : is to run the container in the background
First -p : is to publish the Port 80 of the container to the 8000 port of the host so that we can access the chatbot website in 
our host browser on http://127.0.0.1:8000/
Second -p : is to publish Jupyter Notebook
```
$docker run -it -d -p 8000:80 -p 8888:8888 --name mybot chatbot:nust
```

Temp run, without saving container
```
$docker run -it --rm -p 8888:8888 -p 8000:80 chatbot:nust
```

## Resources

Docker

- [Install Docker](https://docs.docker.com/engine/installation/) locally.
- Check out the [Docker docs](https://docs.docker.com/).


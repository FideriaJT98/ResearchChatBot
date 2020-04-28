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

Temp run, removes the container after
```
$docker run -it --rm -p 8888:8888 -p 8000:80 chatbot:nust
```
This will fire up your Jupyter notebook using the final command in the Dockerfile to http://127.0.0.1:8888/


Permanently Run, Keeps container
```
$docker run -it -d -p 8000:80 -p 8888:8888 --name mybot chatbot:nust
```
-d : is to run the container in the background
This will fire up your Jupyter notebook using the final command in the Dockerfile to http://127.0.0.1:8888/



## Resources

Docker

- [Install Docker](https://docs.docker.com/engine/installation/) locally.
- Check out the [Docker docs](https://docs.docker.com/).

| [Tensorlow](images/tensoflow.png) | images/tensoflow.png |


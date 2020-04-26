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
ls
$ git DockerFile start.jl
```
This Dockerfile tells Docker how to build a Docker "image" for our chatbot


### Docker build and run
```
$docker build -t chatbot:nust .
$docker run -t -d -p 8000:80 --name mybot chatbot:nust
```

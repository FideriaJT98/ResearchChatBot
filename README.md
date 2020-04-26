# ResearchChatBot
A julia chatbot with tensorflow and web scraping

## Prerequisites

- Ability to `ssh` into a remote machine.
- An IP for a remote machine (this should have been given to you at the beginning of the workshop).
- Access to this repository on GitHub (we will clone it later on the remote machine).

## 1. Prepare a Julia program and Docker image for model training
Clone this Github repo on the dev machine as follows:

```
$ git clone https://github.com/FideriaJT98/ResearchChatBot.git
```

### Docker build and run
```
$docker build -t chatbot:nust .
$docker run -t -d -p 8000:80 --name mybot chatbot:nust
```

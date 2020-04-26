# ResearchChatBot
A julia chatbot with tensorflow and web scraping

![alt text](Images/screenshot.PNG)

### Docker build and run
```bash
docker build -t chatbot:nust .
docker run -t -d -p 8000:80 --name mybot chatbot:nust
```

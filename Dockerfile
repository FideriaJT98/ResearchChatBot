FROM python:3

EXPOSE 8000
EXPOSE 80

#RUN wget https://julialang-s3.julialang.org/bin/linux/x64/1.4/julia-1.4.1-linux-x86_64.tar.gz   --download it myself

RUN pip install nltk

COPY . .

RUN tar xf julia-1.4.1-linux-x86_64.tar.gz

CMD [ "/julia-1.4.1/bin/julia", "start.jl"]
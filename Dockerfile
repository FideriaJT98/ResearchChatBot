#Source https://www.tensorflow.org/install/source
FROM tensorflow/tensorflow:devel

EXPOSE 8000
EXPOSE 80

COPY . .

RUN pip install nltk
RUN wget https://julialang-s3.julialang.org/bin/linux/x64/1.4/julia-1.4.1-linux-x86_64.tar.gz   --download it myself
RUN tar xf julia-1.4.1-linux-x86_64.tar.gz

CMD [ "/julia-1.4.1/bin/julia", "start.jl"]
#FROM tensorflow/tensorflow:devel               #for development
FROM tensorflow/tensorflow:nightly-py3-jupyter  #for testing for now, in Jupyter Notebook 

EXPOSE 8000
EXPOSE 80

COPY . .

#-------------------------------------------------------------------------------------------------

#Install Julia and NLTK
RUN pip install nltk
#RUN apt-get install wget                                                                        
#RUN wget https://julialang-s3.julialang.org/bin/linux/x64/1.4/julia-1.4.1-linux-x86_64.tar.gz   #Ive downloaded it myself
RUN tar xf julia-1.4.1-linux-x86_64.tar.gz
RUN /julia-1.4.1/bin/julia --version                                                            # proved difficult to change the location 

RUN /julia-1.4.1/bin/julia -e "using Pkg; Pkg.add(\"IJulia"); "                                               
 
#-------------------------------------------------------------------------------------------------

CMD ["bash"]
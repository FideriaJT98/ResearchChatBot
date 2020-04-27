#for testing for now, in Jupyter Notebook 
FROM tensorflow/tensorflow:nightly-py3-jupyter  

EXPOSE 8000
EXPOSE 80
EXPOSE 8888

COPY . .

#-------------------------------------------------------------------------------------------------

#Install Julia and NLTK
RUN pip install nltk
#RUN apt-get install wget                                                                        
#RUN wget https://julialang-s3.julialang.org/bin/linux/x64/1.4/julia-1.4.1-linux-x86_64.tar.gz   
RUN tar xf julia-1.4.1-linux-x86_64.tar.gz
RUN pwd 
RUN /tf/julia-1.4.1/bin/julia --version                                                             

RUN /tf/julia-1.4.1/bin/julia -e "using Pkg; Pkg.add(\"IJulia\"); Pkg.add(\"Genie\"); Pkg.add(\"PyCall\"); Pkg.add(\"JSON\"); Pkg.add(\"TensorFlow\"); Pkg.add(\"TextAnalysis\"); Pkg.build(\"TextAnalysis\"); "    

#-------------------------------------------------------------------------------------------------

# CMD ["bash"]
CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root"]
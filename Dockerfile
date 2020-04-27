FROM tensorflow/tensorflow:devel

EXPOSE 8000
EXPOSE 80

COPY . .

#-------------------------------------------------------------------------------------------------
#Install Julia and NLTK
RUN pip install nltk
RUN wget https://julialang-s3.julialang.org/bin/linux/x64/1.4/julia-1.4.1-linux-x86_64.tar.gz   # or download it myself and copy it to container
RUN tar xf julia-1.4.1-linux-x86_64.tar.gz
RUN /julia-1.4.1/bin/julia --version                                                            # unnecesary to change location of julia

#-------------------------------------------------------------------------------------------------
RUN ./configure  # answer prompts or use defaults
RUN bazel build --config=opt //tensorflow/tools/pip_package:build_pip_package
RUN ./bazel-bin/tensorflow/tools/pip_package/build_pip_package /mnt               # create package
RUN chown $HOST_PERMS /mnt/tensorflow-version-tags.whl
chown $HOST_PERMS /mnt/tensorflow-version-tags.whl

#-------------------------------------------------------------------------------------------------
#Install and verify the package within the container:
RUN pip uninstall tensorflow # remove current version
RUN pip install /mnt/tensorflow-version-tags.whl
RUN cd /tmp  # don't import from source directory
RUN python -c "import tensorflow as tf; print(tf.__version__)"

#-------------------------------------------------------------------------------------------------
#Start our ChatBot
CMD [ "/julia-1.4.1/bin/julia", "start.jl"]
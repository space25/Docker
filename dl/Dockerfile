FROM ubuntu

RUN apt-get update -y &&\
    apt-get upgrade -y &&\
    apt-get autoremove &&\
    apt-get install -y python3 python3-dev python3-pip

RUN pip3 install --upgrade youtube_dl coursera-dl
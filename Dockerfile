FROM ubuntu:bionic

COPY ./sources.list /etc/apt/
# Install python and pip
ENV DEBIAN_FRONTEND noninteractive
# RUN add-apt-repository ppa:alex-p/tesseract-ocr
RUN apt-get update

RUN apt-get install -y python3 python3-pip bash
RUN apt-get -y install apt tesseract-ocr libtesseract-dev libsm6 libxext6 python3-tk poppler-utils tesseract-ocr-rus
RUN apt-get install -y tesseract-ocr-rus

ADD ./requirements.txt /tmp/requirements.txt


# Install dependencies
RUN pip3 install --no-cache-dir -r /tmp/requirements.txt
RUN pip3 install opencv-python pdftabextract

# RUN apk
# Add our code
ADD ./ /opt/webapp/
WORKDIR /opt/webapp

# Expose is NOT supported by Heroku
EXPOSE 5000

# Run the image as a non-root user
# RUN adduser -D myuser
# USER myuser

# Run the app.  CMD is required to run on Heroku
# $PORT is set by Heroku
CMD python3 scanner.py

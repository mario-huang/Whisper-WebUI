FROM python:3.10

WORKDIR /Whisper-WebUI

RUN apt-get update && \
    apt-get install -y curl git ffmpeg
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

COPY . .
RUN pip install --no-cache-dir -r requirements.txt

CMD [ "python", "app.py", "--colab", "True" ]

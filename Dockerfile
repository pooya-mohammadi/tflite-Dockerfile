FROM python:3.9-bullseye

LABEL author="Pooya Mohammadi https://github.com/pooya-mohammadi"


# os and opencv libraries
RUN apt-get update -y \
  && apt install libgl1-mesa-glx -y \
  && apt-get install 'ffmpeg' 'libsm6' 'libxext6'  -y \
  && python -m pip install --no-cache-dir --upgrade pip

RUN python -m pip install --no-cache-dir --upgrade pip \
  &&  pip install --no-cache-dir numpy==1.21.4 \
  &&  pip install --no-cache-dir tflite_runtime==2.5.0 \


COPY . /app
WORKDIR /app

RUN pip install --no-cache-dir -r requirements.txt

# guncorn input variables should be changed based on each project
CMD gunicorn --workers=2 -b 0.0.0.0:660 entry_point:app --worker-class sync

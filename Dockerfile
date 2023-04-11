FROM tensorflow/tensorflow:2.4.1-gpu

COPY . /
RUN rm /etc/apt/sources.list.d/cuda.list
RUN rm /etc/apt/sources.list.d/nvidia-ml.list
RUN apt-key del 7fa2af80
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/3bf863cc.pub
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/7fa2af80.pub
RUN apt-get update && apt-get install -y ffmpeg libsm6 libxext6 libgl1 libglib2.0-0 curl
RUN python3.6 -m pip install --upgrade pip
RUN pip install -r requirements.txt
RUN python3.6 setup.py install

RUN extractor='extractor_2.h5' \
  && extractor_path='/usr/local/lib/python3.6/site-packages/fawkes/model' \
  && mkdir -p "${extractor_path}" \
  && curl -fsSL --output "${extractor_path}/${extractor}" "https://mirror.cs.uchicago.edu/fawkes/files/${extractor}"

RUN extractor='extractor_0.h5' \
  && extractor_path='/usr/local/lib/python3.6/site-packages/fawkes/model' \
  && mkdir -p "${extractor_path}" \
  && curl -fsSL --output "${extractor_path}/${extractor}" "https://mirror.cs.uchicago.edu/fawkes/files/${extractor}"

RUN chmod -R ugo=rwX /usr/local/lib/python3.6/site-packages/fawkes/model

ENTRYPOINT [ "python", "/fawkes/protection.py" ]

# How to build:
#   docker build -t fawkes .
# How to run:
#   docker run --rm --gpus all fawkes
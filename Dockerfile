FROM tensorflow/tensorflow:2.4.1-gpu

COPY . /
RUN pip install -r requirements.txt
RUN python setup.py install

ENTRYPOINT [ "python", "/fawkes/protection.py" ]

# How to build:
#   docker build -t xavier/fawkes:latest .
# How to run:
#   docker --rm --gpus all xavier/fawkes:latest -h
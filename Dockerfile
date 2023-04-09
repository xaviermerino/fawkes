FROM tensorflow/tensorflow:2.4.1-gpu

COPY . /
RUN pip install -r requirements.txt
RUN python setup.py install

ENTRYPOINT [ "python", "/fawkes/protection.py" ]
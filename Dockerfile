FROM python:3.7-slim
COPY requirements.txt /
RUN pip install -r requirements.txt
COPY . /app
WORKDIR /app
ENTRYPOINT ["python", "main.py"]
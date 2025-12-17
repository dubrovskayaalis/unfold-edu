# gateway/Dockerfile
FROM python:3.11-slim

WORKDIR /app

# Системные зависимости (если понадобятся)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
 && rm -rf /var/lib/apt/lists/*

# Копируем requirements (создай gateway/requirements.txt)
COPY gateway/requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt

# Копируем код gateway и orchestrator + services
COPY gateway /app/gateway
COPY orchestrator /app/orchestrator
COPY services /app/services
COPY proto /app/proto

# Убедимся, что Python сможет импортировать модули
ENV PYTHONPATH=/app

EXPOSE 50051

# Переменные окружения (можно переопределить в docker-compose)
ENV ARTIFACT_PUBLIC_BASE=http://artifact-server:8080/artifacts

# Запуск gRPC сервера
CMD ["python", "/app/gateway/server.py"]

# Use Python 3.12 slim image as base
FROM python:3.12-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Railway provides $PORT automatically
ENV PORT=8000

# Expose is optional (Railway ignores it, but keep for clarity)
EXPOSE 8000

# Start uvicorn directly
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]

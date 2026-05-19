FROM python:3.11-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first for better caching
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY main.py .

# Expose port 7860 (Hugging Face Spaces default)
EXPOSE 7860

# Run the application on port 7860 for Hugging Face Spaces compatibility
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "7860"]

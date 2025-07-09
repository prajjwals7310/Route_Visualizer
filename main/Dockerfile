FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Install dependencies: git, bash (for script)
RUN apt-get update && apt-get install -y git bash && rm -rf /var/lib/apt/lists/*

# Copy entire project into container
COPY . .

# Remove old virtual environment if exists, then create new one
RUN if [ -d "env" ]; then rm -rf env; fi && \
    python3 -m venv env && \
    . env/bin/activate && \
    pip install --no-cache-dir -r requirements.txt

# Make main.sh executable
RUN chmod +x main.sh

# Expose Flask port
EXPOSE 9000

# Run script in virtual environment
CMD ["/bin/bash", "-c", ". env/bin/activate && ./main.sh"]

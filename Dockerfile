# Use the official Python 3.11 image as a base
FROM python:3.11

# Set the working directory in the container
WORKDIR /app

# Clone the public Git repository
RUN git clone https://github.com/sravan-thumma/TaskWeaver.git

# Install virtualenv
RUN pip install virtualenv

# Create a virtual environment
RUN python -m venv venv

# Activate the virtual environment
SHELL ["/bin/bash", "-c"]
RUN source venv/bin/activate

# Set the working directory to the cloned repository
WORKDIR /app/TaskWeaver/

# Install dependencies
RUN pip install -r requirements.txt

# Define the new content as a JSON string
ENV NEW_CONTENT "{\"llm.api_base\": \"https://api.openai.com/v1\", \"llm.api_key\": \"\", \"llm.model\": \"gpt-4-1106-preview\"}"

# Replace the content of the file with the defined string
RUN sed -i "s|old_content|${NEW_CONTENT}|g" /app/TaskWeaver/project/taskweaver_config.json

# Set the working directory to the cloned repository
WORKDIR /app/TaskWeaver/playground/UI

# Expose port 8000
EXPOSE 8000

# Run the command to start the application
CMD ["chainlit", "run", "app.py"]

FROM elixir:latest

# Set environment variables
ENV MIX_ENV=dev

# Install Hex and Rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Create and set the working directory
WORKDIR /app

# Copy mix files and fetch dependencies
COPY mix.exs mix.lock ./
RUN mix deps.get

# Copy the rest of the application code
COPY . .

# Compile the application
RUN mix compile

# Run database setup and start the application
CMD ["bash", "-c", "mix ecto.create && mix ecto.migrate && mix run --no-halt"]
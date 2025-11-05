# fastapi-module-registry

A FastAPI-based project with Dockerized deployment, automated testing, and GitHub Actions CI.

## Features

- FastAPI backend
- Docker and Docker Compose support
- Automated tests via `test.sh`
- GitHub Actions workflow for CI/CD
- Environment configuration via `.env` files

## Getting Started

### Prerequisites

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)
- [Python 3.12](https://www.python.org/downloads/release/python-3120/) (for local development)
- [jq](https://stedolan.github.io/jq/) (for test output formatting)

### Setup

1. **Clone the repository:**
   ```sh
   git clone git@github.com:ninoslavjaric/fastapi-module-registry.git
   cd fastapi-module-registry
   ```

2. **Configure environment variables:**
   - Copy `.env.example` to `.env` and fill in the values:
     ```sh
     cp .env.example .env
     # Edit .env as needed
     ```

### Running Locally

#### With Docker

Build and run the app:
```sh
docker build --build-arg PORT=<your-port> -t fa .
docker run -v /tmp/out:/tmp/out -p <your-port>:<your-port> --env-file .env -t fa
```

#### With Docker Compose

```sh
docker compose up --build
```

### Testing

Run tests inside the Docker container:
```sh
./deploy.sh test
```
Test output will be saved in `/tmp/out` and printed to the console.

### CI/CD

- GitHub Actions workflow is defined in `.github/workflows/test.yml`.
- On push, PR, or manual dispatch, the workflow:
  - Builds the Docker image
  - Runs tests via `deploy.sh test`
  - Publishes test output to the workflow summary

### Project Structure

```
.
├── app/                        # Application code
│   ├── main.py                 # FastAPI app entrypoint
│   ├── api/                    # API routers/endpoints
│   ├── models/                 # Pydantic models and/or ORM models
│   ├── services/               # Business logic and service layer
│   ├── bin/
│   │   └── test.sh             # Test script (integration tests via curl)
│   └── ...                     # Other FastAPI modules, dependencies, utils, etc.
├── deploy.sh                   # Deployment and test runner script
├── Dockerfile
├── docker-compose.yml
├── requirements.txt
├── .env.example
└── .github/
    └── workflows/
        └── test.yml            # CI workflow
```

#### `app/` directory

- `main.py`: FastAPI application entrypoint.
- `api/`: Contains API routers (e.g., `/ping`, `/module/` endpoints).
- `models/`: Pydantic schemas and/or ORM models for data validation and persistence.
- `services/`: Business logic, service classes, or utility functions.
- `bin/test.sh`: Script to start the app and run integration tests using `curl`.
- Other modules: Additional FastAPI components, dependencies, or utilities.

### Environment Variables

Set in `.env` (see `.env.example`):

- `APP_NAME`
- `PORT`
- `DB_URL`
- `DEBUG`

### License

MIT License.

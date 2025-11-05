import os
from sqlalchemy.orm import sessionmaker, Session, declarative_base
from sqlalchemy import create_engine

Base = declarative_base()

DB_URL = os.getenv("DB_URL", "sqlite:////tmp/registry.db")

engine = create_engine(
    url=DB_URL, future=True, echo=False
)

session = sessionmaker(
    bind=engine, autoflush=False, autocommit=False, future=True
)


def get_db():
    try:
        with session() as db:
            yield db
    finally:
        db.close()

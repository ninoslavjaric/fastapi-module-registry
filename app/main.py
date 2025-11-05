from fastapi import FastAPI, Depends
from sqlalchemy import text, orm
from app.database import get_db, Base, engine
from app.routes import module
import time
import os

app: FastAPI = FastAPI(title=os.getenv("APP_NAME", "API Registry"), version="1.0.0")

@app.get("/ping")
def healthcheck(db: orm.Session = Depends(get_db)):
    start_time = time.perf_counter()
    try:
        db.execute(text("SELECT 1"))
        process_time = time.perf_counter() - start_time
        return {"status": "ok", "latency_ms": round(process_time, 2)}
    except Exception as e:
        return {"status": "error", "db": str(e)}

if __name__ == "app.main":
    if os.getenv("DEBUG", 0):
        Base.metadata.create_all(bind=engine)
    app.include_router(module.router)
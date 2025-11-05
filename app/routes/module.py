from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app import crud, schemas, database

router = APIRouter(prefix="/module")

@router.post("/", response_model=schemas.ModuleOut)
def create_module(module: schemas.ModuleIn, db: Session = Depends(database.get_db)):
    return crud.create_module(db, module)

@router.get("/", response_model=list[schemas.ModuleOut])
def list_modules(db: Session = Depends(database.get_db)):
    return crud.list_modules(db)

@router.get("/{module_id}", response_model=schemas.ModuleOut)
def get_module(module_id: int, db: Session = Depends(database.get_db)):
    db_module = crud.get_module(db, module_id)
    if not db_module:
        raise HTTPException(status_code=404, detail="Module not found")
    return db_module

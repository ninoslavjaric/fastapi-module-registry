from sqlalchemy.orm import Session
from . import models, schemas

def create_module(db: Session, data: schemas.ModuleIn) -> models.Module:
    row = models.Module(name=data.name, url=str(data.url))
    db.add(row)
    db.commit()
    db.refresh(row)
    return row

def list_modules(db: Session) -> list[models.Module]:
    return db.query(models.Module).all()

def get_module(db: Session, module_id: int) -> models.Module | None:
    return db.query(models.Module).filter(models.Module.id == module_id).first()

def delete_module(db: Session, module_id: int) -> bool:
    row = get_module(db, module_id)
    if not row:
        return False
    db.delete(row)
    db.commit()
    return True
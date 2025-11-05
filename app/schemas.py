from pydantic import BaseModel, AnyUrl

class ModuleIn(BaseModel):
    name: str
    url: AnyUrl

class ModuleOut(ModuleIn):
    id: int
    class Config:
        from_attributes = True
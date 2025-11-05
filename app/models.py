from sqlalchemy import Column, Integer, String
from app.database import Base

class Module(Base):
    __tablename__ = "modules"
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    url  = Column(String, nullable=False)

--1

select top 5000 *
into ArticleLukaMirkovic
from Article

select * from ArticleLukaMirkovic

ALTER TABLE ArticleLukaMirkovic
ADD CONSTRAINT PK_ArticleLukaMirkovic_Id PRIMARY KEY (Id)

CREATE NONCLUSTERED INDEX IX_ArticleLukaMirkovic_ExpiryDate ON
ArticleLukaMirkovic(ExpireDate) INCLUDE (Id,Title)
CREATE NONCLUSTERED INDEX IX_ArticleLukaMirkovic_Sponsor_Id ON
ArticleLukaMirkovic(Sponsor_Id) INCLUDE (Id,Title)

ALTER TABLE ArticleLukaMirkovic
ADD CONSTRAINT FK_ArticleLukaMirkovic_Image_Id FOREIGN KEY (Image_Id)
REFERENCES [File](Id)

--2

select top 5000 *
into FirmLukaMirkovic
from Firm

ALTER TABLE FirmLukaMirkovic
ADD CONSTRAINT PK_FirmLukaMirkovic_Id PRIMARY KEY (Id)

CREATE NONCLUSTERED INDEX IX_FirmLukaMirkovic_Name ON
FirmLukaMirkovic([Name]) INCLUDE (Id)

ALTER TABLE FirmLukaMirkovic
ADD CONSTRAINT FK_FirmLukaMirkovic_Address_Id FOREIGN KEY (Address_Id)
REFERENCES [Address](Id)

ALTER TABLE FirmLukaMirkovic
ADD CONSTRAINT FK_FirmLukaMirkovic_Logo_Id FOREIGN KEY (Logo_Id)
REFERENCES [File](Id)

ALTER TABLE FirmLukaMirkovic
ADD CONSTRAINT FK_FirmLukaMirkovic_IconRecognition_Id FOREIGN KEY (IconRecognition_Id)
REFERENCES [File](Id)

ALTER TABLE FirmLukaMirkovic
ADD CONSTRAINT FK_FirmLukaMirkovic_IconRecognition2_Id FOREIGN KEY (IconRecognition2_Id)
REFERENCES [File](Id)
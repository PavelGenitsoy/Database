USE master
GO
SELECT * FROM sys.symmetric_keys WHERE name='##MS_ServiceMasterKey##'
GO

USE DataBaseLaba
GO
CREATE MASTER KEY ENCRYPTION BY PASSWORD='1111'
GO

GO
CREATE CERTIFICATE Certificate1 WITH SUBJECT = 'Protect Data'
GO

GO
CREATE SYMMETRIC KEY SymmetricKey1 WITH ALGORITHM = AES_128
ENCRYPTION BY CERTIFICATE Certificate1
GO

GO
ALTER TABLE STUDENTS ADD RegistrationAddressEncrypt VARBINARY(MAX) NULL
GO

GO
OPEN SYMMETRIC KEY SymmetricKey1
DECRYPTION BY CERTIFICATE Certificate1
GO
UPDATE STUDENTS SET RegistrationAddressEncrypt = EncryptByKey (Key_GUID('SymmetricKey1'),RegistrationAddress) FROM STUDENTS
GO
CLOSE SYMMETRIC KEY SymmetricKey1
GO

GO
OPEN SYMMETRIC KEY SymmetricKey1
DECRYPTION BY CERTIFICATE Certificate1
GO
SELECT RegistrationAddressEncrypt AS 'Encrypted RegistrationAddress',
CONVERT(nvarchar, DecryptByKey(RegistrationAddressEncrypt)) AS 'Decrypted RegistrationAddress'
FROM STUDENTS
CLOSE SYMMETRIC KEY SymmetricKey1
GO

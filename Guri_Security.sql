use Guri_Security;
Go

Create Table Adresat
(
Id char(4) not null,
Rruga nvarchar(55) not null,
Qyteti nvarchar(35) not null,
Shteti nvarchar(35) not null,
Kodi_Postal int not null,
primary key (Id)
);

Create Table Zona
(
Id int not null,
Emri nvarchar(55) not null,
Regjioni nvarchar(35) not null,
Pershkrimi nvarchar(100),
primary key (Id)
);

Create Table Arsyeja_Anulimit
(
Id int not null identity(1,1),
Data date not null,
Pershkrimi nvarchar(65),
primary key(Id)
);

Create Table Klienti 
(
SSN int not null identity(1,1),
Emri nvarchar(20) not null,
Mbiemri nvarchar(20) not null,
Emri_Prindit nvarchar(20) not null,
Gjinia char(1) not null,
Datelindja date not null,
Adrese_Id char(4) not null,
Telefoni varchar(25) not null,
Email varchar(55) not null,
Menyra_Pageses varchar(15) not null,
Banka nvarchar(20)
primary key (SSN),
foreign key (Adrese_Id) references dbo.Adresat(Id)
);

Create Table Menaxheri
(
Id int not null identity(1,1),
Emri nvarchar(20) not null,
Mbiemri nvarchar(20) not null,
Pozita nvarchar(20) not null,
Adrese_Id char(4) not null,
Telefoni varchar(25) not null,
Email varchar(55) not null,
M_Zona_Id int not null,
Paga real not null,
Data_punesimit date not null,
primary key (Id),
foreign key (Adrese_Id) references dbo.Adresat(Id),
foreign key (M_Zona_Id) references dbo.Zona(Id)
);

Create Table Pajisjet
(
SN varchar(15) not null,
Emri nvarchar(20) not null,
Prodhuesi nvarchar(20) not null,
Lloji nvarchar(20),
Statusi varchar(15) not null,
Data_Prodhimit date not null,
Lokacioni nvarchar(35),
Data_Instalimit date,
primary key(SN)
);

Create Table Kontratat
(
Id int not null,
Klient_SSN int not null,
Data date not null,
Periudha varchar(15) not null,
Totali real not null,
Termet_Id int not null,
primary key(Id),
foreign key (Klient_SSN) references dbo.Klienti(SSN),
);




Create Table Terminet
(
Id int not null,
Klienti_SSN int not null,
Kontrat_Id int not null,
Data date not null,
Koha time,
Zona_Id int not null,
Statusi nvarchar(20) not null,
Anulimi_Id int,
primary key(Id),
foreign key(Klienti_SSN) references dbo.Klienti(SSN),
foreign key(Kontrat_Id) references dbo.Kontratat(Id),
foreign key(Zona_Id) references dbo.Zona(Id),
foreign key(Anulimi_Id) references dbo.Arsyeja_Anulimit(Id)
);



Create Table Instalimet
(
Id int not null,
Termin_Id int not null,
Menaxheri_Id int not null,
Data date not null,
Koha time,
Pajisjet nvarchar(20) not null,
Pajisjet_Instaluara int,
Shenime nvarchar(60),
primary key(Id),
foreign key (Termin_Id) references dbo.Terminet(Id),
foreign key (Menaxheri_Id) references dbo.Menaxheri(Id)
); 

Create Table Pajisjet_Instalim
(
Id int not null,
Instalimet_Id int not null,
Pajisja_SN varchar(15) not null,
Klienti_SSN int not null,
Data date not null,
Statusi varchar(10) not null,
primary key (Id),
foreign key(Instalimet_Id) references dbo.Instalimet(Id),
foreign key (Pajisja_SN) references dbo.Pajisjet(SN),
foreign key (Klienti_SSN) references dbo.Klienti(SSN)
);




Create Table Historia_Pajisjeve 
(
Id int not null,
Pajisja_SN varchar(15) not null,
Klienti_SSN int not null,
Instalimet_Id int not null,
Periudha_Perdorimit varchar(15) not null,
Statusi varchar(15) not null,
Intervenimi nvarchar(20) not null,
primary key(Id),
foreign key (Pajisja_SN) references dbo.Pajisjet(SN),
foreign key (Klienti_SSN) references dbo.Klienti(SSN),
foreign key (Instalimet_Id) references dbo.Instalimet(Id)
);




Create Table Pajisjet_Dispozicion 
(
Id int not null,
Pajisja_SN varchar(15) not null,
Klienti_SSN int not null,
Instalimet_Id int not null,
Disponueshmeria char(2) not null,
Data date not null,
Arsyeja nvarchar(30) not null,
primary key(Id),
foreign key (Pajisja_SN) references dbo.Pajisjet(SN),
foreign key (Klienti_SSN) references dbo.Klienti(SSN),
foreign key (Instalimet_Id) references dbo.Instalimet(Id)
);






Create Table Faturat
(
Id varchar(15) not null,
Klienti_SSN int not null,
Tipi_Fatures nvarchar(15) not null,
Cmimi real not null,
TVSH_Perqindja real not null,
TVSH real not null,
Pagesa_Totale real not null,
Data date not null,
Afati_Pageses date not null,
Statusi varchar(15) not null,
primary key (Id),
);


Create Table Pagesat
(
Id varchar(15) not null,
Fatura_Id varchar(15),
Menyra_Pageses nvarchar(10) not null,
Banka nvarchar(20),
Data_Pageses date not null,
Statusi varchar(15) not null,
Data_Fletepageses date not null,
primary key(Id),
foreign key (Fatura_Id) references dbo.Faturat(Id)
);

Insert into Adresat(Id,Rruga,Qyteti,Shteti,Kodi_Postal)
values 
('6f5','Mbreteresha Teute','Mitrovice','Kosove',40000),
('fc2','Melihate Rama','Mitrovice','Kosove',40000),
('208','Shaban Shabani','Vushtrri','Kosove',42000),
('0fe','Ali Zasella','Gjakove','Kosove',50000),
('e03','Martiret e Studimes','Mitrovice','Kosove',40000),
('a27','Kalabria','Prishtine','Kosove',10000),
('09e','Ilirida','Mitrovice','Kosove',40000),
('3fd','Afrim Zhitia','Prizren','Kosove',20000),
('ead','George Bush','Prishtine','Kosove',10000),
('33b','Florida','Prishtine','Kosove',10000),
('7b3','Ulpiana','Prishtine','Kosove',10000),
('93c','Rruga B','Ferizaj','Kosove',70000),
('292','Dardania','Prishtine','Kosove',10000),
('770','Isa Boletini','Ferizaj','Kosove',70000),
('3ba','Ukshin Hoti','Vushtrri','Kosove',42000);

Insert into Termet_Kushtet(Teksti)
values('1. Scope of Services:
Guri Security shall provide security services as detailed in the service agreement, including but not limited to surveillance, access control, and emergency response.
3. Confidentiality:
Guri Security and its agents shall treat all information obtained during the provision of security services as confidential and shall not disclose such information without the client’‘s explicit consent.
4. Compliance with Laws:
Guri Security commits to providing security services in compliance with all applicable laws and regulations.
5. Insurance:
Guri Security agrees to maintain adequate insurance coverage for its security personnel and operations.
6. Client Cooperation:
The client shall cooperate with Guri Security to facilitate the provision of security services, including providing necessary access and information.
7. Payment Terms:
Payment for security services shall be made in accordance with the terms outlined in the service agreement.
8. Termination:
Either party may terminate the service agreement with written notice if the other party breaches a material term of the agreement.
9. Liability:
Guri Security shall not be liable for any loss, damage, or injury arising from circumstances beyond its control.
10. Governing Law:
This agreement shall be governed by and construed in accordance with the laws of [Your Jurisdiction].');

Insert into Zona(Id,Emri,Regjioni,Pershkrimi)
values 
(74759,'Lagjia e Boshnjakeve','Mitrovice','Afer MTS'),
(67448,'Qendra','Prishtine','Qafa'),
(63869,'Shatervani','Prizren','Qebaptore Syla'),
(74685,'Sudodoll','Mitrovice','Afer Teqes'),
(34239,'Shipol','Mitrovice','Lokali Radisheva'),
(57826,'Dragodan','Prishtine','Perballe Ambasades'),
(45364,'Bardh i vogel','Fushe Kosove','Aeroporti ushtarak'),
(59577,'Vaganice','Mitrovice','Shkolla Skenderbeu'),
(72537,'Nertili','Gjakove','Bizhuteria Akili'),
(83379,'Sheshi','Lipjan','Mobilshop OneTech');

Insert into Arsyeja_Anulimit(Data,Pershkrimi)
values ('2023/12/12','Mosmarreveshje'),
('2024/01/19','Shendetsore'),
('2024/01/26','Mosmarreveshje'),
('2024/2/1','Cmimi'),
('2024/2/5','Shendetsore'),
('2024/2/8','Dokumentacion'),
('2024/02/19','Cmimi'),
('2024/02/26','Dokumentacion'),
('2024/4/3','Cmimi'),
('2024/4/8','Cmimi');

Insert into Klienti(Emri,Mbiemri,Emri_Prindit,Gjinia,Datelindja,Adrese_Id,Telefoni,Email,Menyra_Pageses,Banka)
values ('Artan','Bahtiri','Mehdi','M','1979/08/28','208','+38338327652','Artan.Bahtiri@gmail.com','Cash','TEB'),
('Njomza','Pula','Agron','F','1979/10/04','0fe','+38343117130','Njomza.Pula@gmail.com','Cash','NLB'),
('Aida','Sagojeva','Faik','F','1981/04/30','e03','+38347797949','Aida.Sagojeva@gmail.com','Cash','NLB'),
('Burhan','Rrustemi','Naim','M','1982/11/03','a27','+38328151709','Burhan.Rrustemi@gmail.com','Kartele','BKT'),
('Uliks','Abazi','Enver','M','1985/03/07','09e','+38344287714','Uliks.Abazi@gmail.com','Kartele','ProCredit'),
('Fahri','Gjinovci','Kadri','M','1985/04/03','3fd','+38344165781','Fahri.Gjinovci@gmail.com','Cash','BKT'),
('Jusuf','Ibrahimi','Njazi','M','1985/10/10','ead','+38344288582','Jusuf.Ibrahimi@gmail.com','Kartele','BPB'),
('Valmir','Saraqi','Abit','M','1987/11/17','33b','+38346161662','Valmir.Saraqi@gmail.com','Kartele','BPB'),
('Donjet','Grepi','Sabri','M','1988/12/06','7b3','+38345557794','Donjet.Grepi@gmail.com','Cash','BPB'),
('Tringa','Bajraktari','Fidan','F','1988/12/29','93c','+38345676010','Tringa.Bajraktari@gmail.com','Kartele','TEB');


Insert into Menaxheri(Emri,Mbiemri,Pozita,Adrese_Id,Telefoni,Email,M_Zona_Id,Paga,Data_punesimit)
values ('Shkurta', 'Tafani', 'Ekzekutiv', '6f5', '+383290819297', 'Shkurta.Tafani@gmail.com', '74759', '1,427.00 €', '2009/6/11'),
('Aferdita', 'Ndreu', 'Financiar', 'fc2', '+383390108761', 'Aferdita.Ndreu@gmail.com', '67448', '970.00 €', '2009/10/26'),
('Fatjona', 'Kola', 'Shitjes', '208', '+38347824607', 'Fatjona.Kola@gmail.com', '63869', '750.00 €', '2010/04/16'),
('Adena', 'Tota', 'Marketing', '292', '+38345769265', 'Adena.Tota@gmail.com', '74685', '820.00 €', '2010/5/10'),
('Bukuroshe', 'Toska', 'Gjeneral', '770', '+38328085234', 'Bukuroshe.Toska@gmail.com', '34239', '1,240.00 €', '2011/3/7'),
('Gëzim', 'Çerkezi', 'Drejtor', '3ba', '+38329955700', 'Gëzim.Çerkezi@gmail.com', '57826', '1,560.00 €', '2012/11/14'),
('Luan', 'Asllani', 'Lokal', 'ead', '+38338467280', 'Luan.Asllani@gmail.com', '45364', '1,030.00 €', '2013/01/29'),
('Ajola', 'Tafa', 'Marketing', '33b', '+38347409655', 'Ajola.Tafa@gmail.com', '59577', '820.00 €', '2013/09/26'),
('Ledion', 'Gashi', 'Shitjes', '7b3', '+383390384547', 'Ledion.Gashi@gmail.com', '72537', '750.00 €', '2013/10/31'),
('Grelion', 'Balliu', 'Marketing', '93c', '+38329730460', 'Grelion.Balliu@gmail.com', '83379', '820.00 €', '2013/12/24');

Insert into Pajisjet(SN,Emri,Prodhuesi,Lloji,Statusi,Data_Prodhimit,Lokacioni,Data_Instalimit)
values 
('SN-25267476', 'Kamere', 'Bosch', NULL, 'Funksional', '2012/5/4', 'Mitrovice', '2015/9/9'),
('SN-72227967', 'Sensor', 'HoneyWell', 'Levizjes', 'Funksional', '2013/03/18', 'Prishtine', '2016/2/1'),
('SN-95825774', 'Dry', 'HoneyWell', 'Smart', 'Jo-funksional', '2015/3/11', 'Prishtine', '2016/8/8'),
('SN-28426968', 'Sensor', 'Bosch', 'Temperature', 'Funksional', '2015/5/1', 'Mitrovice', '2016/9/22'),
('SN-58793396', 'Kamere', 'Bosch', 'Termike', 'Jo-funksional', '2016/2/5', 'Gjakove', '2020/3/20'),
('SN-43345762', 'Sensor', 'UTC', 'Drite', 'Funksional', '2017/08/21', 'Prizren', '2020/4/30'),
('SN-59957947', 'Sensor', 'Assa', 'Tymi', 'Funksional', '2017/08/24', 'Lipjan', '2020/07/13'),
('SN-78897753', 'Kamere', 'UTC', NULL, 'Funksional', '2018/1/3', 'Ferizaj', '2020/9/15'),
('SN-35397455', 'Zile', 'Bosch', 'Alarmi', 'Funksional', '2018/4/4', 'Prishtine', '2021/04/28'),
('SN-83544344', 'Sensor', 'Bosch', 'Goditjes', 'Funksional', '2018/04/13', 'Prishtine', '2022/12/9');

Insert into Kontratat(Id,Klient_SSN,Data,Periudha,Totali,Termet_Id)
values 
(66662, 1, '2008/11/26', '6-Muaj', '539.94 €', 1),
(88598, 2, '2009/1/9', '1-Vit', '1,019.88 €', 1),
(79692, 3, '2019/05/15', '3-Vite', '2,699.64 €', 1),
(74838, 4, '2019/08/23', '9-Muaj', '809.91 €', 1),
(58993, 5, '2020/5/11', '5-vite', '4,199.40 €', 1),
(35898, 6, '2014/11/7', '1-Vit', '1,019.88 €', 1),
(79265, 7, '2015/02/26', '1-Vit', '1,019.88 €', 1),
(97857, 8, '2015/06/24', '6-Muaj', '539.94 €', 1),
(77334, 9, '2020/5/11', '6-Muaj', '539.94 €', 1),
(66425, 10, '2022/3/10', '6-Muaj', '539.94 €', 1);


Insert into Terminet(Id,Klienti_SSN,Kontrat_Id,Data,Koha,Zona_Id,Statusi,Anulimi_Id)
values 
(726, 1, 66662, '2023/08/13', '10:00 AM', 74759, 'Perfunduar', NULL),
(339, 2, 88598, '2023/12/18', '10:15 AM', 67448, 'Caktuar', NULL),
(388, 3, 79692, '2023/10/21', '10:30 AM', 63869, 'Perfunduar', NULL),
(655, 4, 74838, '2023/12/27', '10:45 AM', 74685, 'Anuluar', 4),
(859, 5, 58993, '2023/12/28', '11:00 AM', 34239, 'Caktuar', NULL),
(986, 6, 35898, '2023/01/05', '2:00 PM', 57826, 'Perfunduar', NULL),
(894, 7, 79265, '2024/01/08', '2:15 PM', 45364, 'Caktuar', NULL),
(578, 8, 97857, '2024/01/15', '3:00 PM', 59577, 'Anuluar', 2),
(798, 9, 77334, '2024/01/17', '3:15 PM', 72537, 'Caktuar', NULL),
(633, 10,66425, '2024/01/18', '4:00 PM', 83379, 'Caktuar', NULL);


Insert into Instalimet(Id,Termin_Id,Menaxheri_Id,Data,Koha,Pajisjet,Pajisjet_Instaluara,Shenime)
values 
(338882, 726, 1, '2015/06/16', '9:00 AM', 'Kamere', 4, 'Perfunduar'),
(393548, 339, 2, '2015/10/21', '10:00 AM', 'Kamere', 18, 'Perfunduar'),
(728865, 388, 3, '2016/04/22', '10:30 AM', 'Sensor', 9, 'Defekt 2 sensor'),
(497266, 655, 4, '2016/11/01', '11:00 AM', 'Dry', 3, 'Perfunduar'),
(473966, 859, 5, '2018/12/28', '11:30 AM', 'Sensor', 6, 'Perfunduar'),
(579979, 986, 6, '2020/03/12', '12:00 PM', 'Sensor', 36, 'Perfunduar'),
(376486, 894, 7, '2020/04/02', '12:30 PM', 'Sensor', 8, 'Anuluar'),
(553455, 578, 8, '2020/08/25', '1:00 PM', 'Sensor', 23, 'Anuluar'),
(733888, 798, 9, '2020/12/21', '2:00 PM', 'Kamere', 2, 'Defekt 1 kamere'),
(288382, 633, 10, '2021/04/05', '2:30 PM', 'Kamere', 5, 'Perfunduar');

Insert into Pajisjet_Instalim(Id,Instalimet_Id,Pajisja_SN,Klienti_SSN,Data,Statusi)
values 
(2547, 338882, 'SN-25267476', 1, '2024/01/19', 'Aktiv'),
(6379, 393548, 'SN-72227967', 2, '2024/02/29', 'Aktiv'),
(6499, 728865, 'SN-95825774', 3, '2024/03/07', 'Aktiv'),
(4356, 497266, 'SN-28426968', 4, '2024/03/11', 'Inaktiv'),
(7252, 473966, 'SN-58793396', 5, '2024/03/14', 'Inaktiv'),
(9778, 579979, 'SN-43345762', 6, '2024/03/27', 'Aktiv'),
(2459, 376486, 'SN-59957947', 7, '2024/04/05', 'Aktiv'),
(6323, 553455, 'SN-78897753', 8, '2024/04/09', 'Aktiv'),
(4852, 733888, 'SN-35397455', 9, '2024/04/18', 'Aktiv'),
(4257, 288382, 'SN-83544344', 10, '2024/05/06', 'Inaktiv');


Insert into Historia_Pajisjeve(Id,Pajisja_SN,Klienti_SSN,Instalimet_Id,Periudha_Perdorimit,Statusi,Intervenimi)
values 
(9973, 'SN-25267476', 1, 338882, '2 vite', 'Funksional', 'Instalim'),
(8736, 'SN-72227967', 2, 393548, '3 muaj', 'Funksional', 'Instalim'),
(4299, 'SN-95825774', 3, 728865, '1 vit', 'Funksional', 'Instalim'),
(4678, 'SN-28426968', 4, 497266, '6 muaj', 'Jo funksional', 'Riparim'),
(5527, 'SN-58793396', 5, 473966, '8 muaj', 'Funksional', 'Instalim'),
(2562, 'SN-43345762', 6, 579979, '3 vite', 'Funksional', 'Instalim'),
(5943, 'SN-59957947', 7, 376486, '1 vit', 'Funksional', 'Instalim'),
(7785, 'SN-78897753', 8, 553455, '1 muaj', 'Jo funksional', 'Riparim'),
(7838, 'SN-35397455', 9, 733888, '9 muaj', 'Jo funksional', 'Cmontim'),
(9624, 'SN-83544344', 10, 288382, '4 vite', 'Funksional', 'Instalim');

Insert into Pajisjet_Dispozicion(Id,Pajisja_SN,Klienti_SSN,Instalimet_Id,Disponueshmeria,Data,Arsyeja)
values 
(74994, 'SN-25267476', 1, 338882, 'PO', '2024/02/14', 'Djegie'),
(87968, 'SN-72227967', 2, 393548, 'PO', '2024/03/12', 'Demtim'),
(33575, 'SN-95825774', 3, 728865, 'PO', '2024/03/14', 'Djegie'),
(88765, 'SN-28426968', 4, 497266, 'JO', '2024/03/18', 'Demtim'),
(43638, 'SN-58793396', 5, 473966, 'PO', '2024/03/26', 'Lagie'),
(24725, 'SN-43345762', 6, 579979, 'JO', '2024/03/27', 'Demtim'),
(29779, 'SN-59957947', 7, 376486, 'JO', '2024/04/04', 'Djegie'),
(87445, 'SN-78897753', 8, 553455, 'PO', '2024/04/11', 'Demtim'),
(38379, 'SN-35397455', 9, 733888, 'PO', '2024/04/24', 'Demtim'),
(58253, 'SN-83544344', 10, 288382, 'JO', '2024/05/08', 'Lagie');

Insert into Faturat(Id,Klienti_SSN,Tipi_Fatures,Cmimi,TVSH_Perqindja,TVSH,Pagesa_Totale,Data,Afati_Pageses,Statusi)
values 
('INV-4696949423', 1, 'Instalim', '469.75 €', '13.00%', '70.19 €', '539.94 €', '2023/02/03', '2023/12/27', 'Paguar'),
('INV-4455964374', 2, 'Mirembajtje', '958.69 €', '6.00%', '61.19 €', '1,019.88 €', '2023/02/23', '2024/01/08', 'Paguar'),
('INV-8328777598', 3, 'Mirembajtje', '2,537.67 €', '6.00%', '161.97 €', '2,699.64 €', '2023/02/27', '2024/01/09', 'Paguar'),
('INV-7784966549', 4, 'Mirembajtje', '761.32 €', '6.00%', '48.59 €', '809.91 €', '2023/03/16', '2024/01/16', 'Pa paguar'),
('INV-5643653843', 5, 'Mirembajtje', '3,947.44 €', '6.00%', '251.96 €', '4,199.40 €', '2023/03/24', '2024/01/18', 'Paguar'),
('INV-4938744574', 6, 'Instalim', '887.30 €', '13.00%', '132.58 €', '1,019.88 €', '2023/04/03', '2024/01/22', 'Pa paguar'),
('INV-8923994998', 7, 'Mirembajtje', '958.69 €', '6.00%', '61.19 €', '1,019.88 €', '2023/04/18', '2024/01/23', 'Pa paguar'),
('INV-6423558596', 8, 'Instalim', '469.75 €', '13.00%', '70.19 €', '539.94 €', '2023/05/04', '2024/01/26', 'Paguar'),
('INV-5692748268', 9, 'Instalim', '469.75 €', '13.00%', '70.19 €', '539.94 €', '2023/05/05', '2024/01/30', 'Paguar'),
('INV-9825492684', 10, 'Mirembajtje', '507.55 €', '6.00%', '32.39 €', '539.94 €', '2023/05/11', '2024/02/01', 'Paguar');


Insert into Pagesat (Id,Fatura_Id,Menyra_Pageses,Banka,Data_Pageses,Statusi,Data_Fletepageses)
values
('PAY-4977348632', 'INV-4696949423', 'Cash', 'TEB', '2023/02/03', 'Paguar', '2023/02/08'),
('PAY-5594687753', 'INV-4455964374', 'Kartele', 'NLB', '2023/02/23', 'Paguar', '2023/02/10'),
('PAY-6565674669', 'INV-8328777598', 'Cash', 'NLB', '2023/02/27', 'Paguar', '2023/02/16'),
('PAY-5264439242', 'INV-7784966549', 'Cash', 'BKT', '2023/03/16', 'Pa paguar', '2023/03/06'),
('PAY-4686474556', 'INV-5643653843', 'Kartele', 'ProCredit', '2023/03/24', 'Paguar', '2023/03/13'),
('PAY-7869872637', 'INV-4938744574', 'Kartele', 'BKT', '2023/04/03', 'Pa paguar', '2023/04/04'),
('PAY-9865863774', 'INV-8923994998', 'Kartele', 'BPB', '2023/04/18', 'Pa paguar', '2023/04/07'),
('PAY-2532393228', 'INV-6423558596', 'Kartele', 'BPB', '2023/05/04', 'Paguar', '2023/04/17'),
('PAY-2283257987', 'INV-5692748268', 'Kartele', 'BPB', '2023/05/05', 'Paguar', '2023/04/20'),
('PAY-5324737334', 'INV-9825492684', 'Cash', 'TEB', '2023/05/11', 'Paguar', '2023/05/17');


create table Bankat (
ID int not null identity(1,1),
Banka varchar(30),
primary key (ID)
);

 insert into Bankat(Banka)
 values ('TEB'),
('NLB'),
('PRIMA BANK'),
('REIFESSEN BANK'),
('PRO CREDIT BANK'),
('BKT'),
('BPB'),
('AFK'),
('FINCA'),
('BANKA EKONOMIKE'),
('BKP');

create table Prodhuesit (
ID int not null identity(1,1),
Prodhuesi varchar(50),
primary key (ID)
);

 insert into Prodhuesit(Prodhuesi)
 values ('Bosch'),
('Rohde & Schwarz USA, Inc.'),
('UTC'),
('HoneyWell'),
('Assa'),
('Trellix'),
('Broadcom'),
('Cisco'),
('Intetics'),
('Microsoft'),
('Panorays');



ALTER TABLE Pagesat
ADD Temp  real;
select * from Pagesat;
-- Step 3: Drop the existing CHAR column
ALTER TABLE Faturat
DROP COLUMN Tipi_Fatures;
-- Step 4: Rename the temporary column to the original column name
EXEC sp_rename 'Pagesat.Temp', 'Totali', 'COLUMN'
-- Assuming you have two tables: Orders and Customers
-- Adding a foreign key on the CustomerID column in the Orders table
ALTER TABLE Pagesat
ADD CONSTRAINT FK_Menaxheri_ID
FOREIGN KEY (MenaxheriID)
REFERENCES Menaxheri(Id);

---------------------------QUERIES-----------------------------

--1. Listoni të gjithë sensorët që nuk janë në përdorim nga klientët.
SELECT
    Pajisjet.SN,
    CASE
        WHEN Pajisjet.Statusi = 1 THEN 'Aktiv'
        WHEN Pajisjet.Statusi = 0 THEN 'Inaktiv'
    END AS DisplayedStatus
FROM
    Pajisjet
WHERE
    Pajisjet.SN NOT IN (
        SELECT Pajisjet_Instalim.Pajisja_SN
        FROM Pajisjet_Instalim
        WHERE Pajisjet_Instalim.Klienti_SSN IS NOT NULL
    );

--2. Cilët klientë (SSN-të dhe emrat e tyre) kanë paguar fatura të instalimit në vlerë mbi 200 Euro dhe fatura të mirëmbatjes në vlerë mbi 110 Euro?
SELECT DISTINCT
    Klienti.SSN,
    Klienti.Emri,
    Klienti.Mbiemri,
    CASE
        WHEN Faturat.Tipi_Fatures = 1 THEN 'Instalim'
        WHEN Faturat.Tipi_Fatures = 0 THEN 'Mirembajtje'
    END AS DisplayedTipiFatures
FROM
    Klienti
JOIN
    Faturat ON Klienti.SSN = Faturat.Klienti_SSN
WHERE
    (Faturat.Tipi_Fatures = 1 AND Faturat.Pagesa_Totale > 550)
    OR (Faturat.Tipi_Fatures = 0 AND Faturat.Pagesa_Totale > 1500);




--3. Paraqitni të gjitha terminet instaluese që janë caktuar për nesër për Prishtinë.
SELECT
    Data,
    Koha,
    CASE
        WHEN Zona_Id = 57826 THEN 'Prishtine'
    END AS Zona
FROM
    Terminet
WHERE
    CONVERT(DATE, Data) = CONVERT(DATE, GETDATE() + 1)
    AND Zona_Id = 57826;








--4. Listoni ID-të e menaxherëve (primar) të cilët dje kanë pasur dy ose më shumë instalime në pikat e tyre përgjegjëse tek klientët ndërsa sot nuk kanë pasur asnjë.
WITH Instalimet_djeshme AS (
    SELECT DISTINCT
        Menaxheri.Id AS MenaxheriId
    FROM
        Menaxheri
    JOIN
        Instalimet ON Menaxheri.Id = Instalimet.Menaxheri_Id WHERE CONVERT(DATE, Instalimet.Data) = CONVERT(DATE, GETDATE() - 1) GROUP BY Menaxheri.Id
    HAVING COUNT(DISTINCT Instalimet.Id) >= 2 AND Menaxheri.Id NOT IN (
            SELECT DISTINCT Menaxheri.Id FROM Menaxheri
            JOIN Instalimet ON Menaxheri.Id = Instalimet.Menaxheri_Id WHERE CONVERT(DATE, Instalimet.Data) = CONVERT(DATE, GETDATE())
        )
)

SELECT Menaxheri.*, Instalimet.* FROM Menaxheri
JOIN
    Instalimet ON Menaxheri.Id = Instalimet.Menaxheri_Id WHERE Menaxheri.Id IN (SELECT MenaxheriId FROM Instalimet_djeshme);






--5. Listoni top 5 menaxherët me numër maksimal të instalimeve tek klientët në 3 muajt e fundit. Lista të paraqes të dhënat e menaxherit duke përfshirë edhe emrin e zonës 
--ku punon dhe numrin e instalimeve të klientëve që ka realizuar si menaxher primar.
SELECT TOP 5 Menaxheri.Id, Menaxheri.Emri, Menaxheri.Mbiemri,Zona.Emri Zona,Zona.Regjioni,
       COUNT(DISTINCT Instalimet.Id) AS Numri_Instalimeve
FROM Menaxheri
JOIN Instalimet ON Menaxheri.Id= Instalimet.Menaxheri_Id
JOIN Zona ON Menaxheri.M_Zona_Id= Zona.Id	
WHERE Instalimet.Data >= DATEADD(MONTH, -3, GETDATE())
GROUP BY Menaxheri.Id, Menaxheri.Emri, Menaxheri.Mbiemri, Zona.Emri,Zona.Regjioni
ORDER BY Numri_Instalimeve DESC;







--6. Për secilin zonë paraqitni (në një listë të vetme):
--• numrin e menaxherëve që punojnë në atë zonë,
--• pagën mesatare,
--• numrin e instalimeve dhe të mirëmbatjeve mujore aktive të klientëve të realizuara në këtë vit
--• shumën e faturuar (vlerën pa TVSH dhe me TVSH) nga instalimet dhe mirëmbatjet mujore të klientëve të realizuara në këtë vit
--• shumën e pagesave të realizuara në këtë vit.

SELECT Zona.Emri,
    COUNT(DISTINCT Menaxheri.Id) AS Numri_Menaxhereve,
    AVG(Menaxheri.Paga) AS Paga_Mesatare,
    Count(Instalime.NumriAktiv) AS Aktive_Mujore,
    SUM(Fatura.CmimiTotal) AS Shuma_Totale,
    SUM(Fatura.CmimiTotal_TVSH) AS ShumaTotale_TVSH,
	SUM(CASE WHEN Pagesat.Statusi = 1 THEN Pagesat.Totali ELSE 0 END) AS Shuma_Paguar
FROM Zona LEFT JOIN Menaxheri ON Zona.Id = Menaxheri.M_Zona_Id
LEFT JOIN (SELECT Menaxheri_Id, COUNT(Id) AS NumriAktiv FROM Instalimet WHERE YEAR(Data) = YEAR(GETDATE()) GROUP BY Menaxheri_Id) AS Instalime ON Menaxheri.Id = Instalime.Menaxheri_Id
LEFT JOIN (SELECT MenaxheriId, SUM(Cmimi) AS CmimiTotal, SUM(Cmimi + TVSH) AS CmimiTotal_TVSH
    FROM Faturat WHERE YEAR(Data) = YEAR(GETDATE()) GROUP BY MenaxheriId) AS Fatura ON Menaxheri.Id = Fatura.MenaxheriId
LEFT JOIN Pagesat ON Menaxheri.Id = Pagesat.MenaxheriId GROUP BY Zona.Emri;


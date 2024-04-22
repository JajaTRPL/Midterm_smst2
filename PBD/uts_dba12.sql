--1 Buatlah 3 tabel sesuai desain berikut!
CREATE TABLE mahasiswa (
  nim CHAR(18) PRIMARY KEY,
  nama VARCHAR2(20),
  tanggal_lahir DATE,
  jenis_kelamin CHAR(1),
  IPK FLOAT
);

CREATE TABLE matakuliah (
  id_mk CHAR(5) PRIMARY KEY,
  nama VARCHAR2(100),
  semester NUMBER(2)
);

CREATE TABLE krs (
  id_KRS CHAR(5) PRIMARY KEY,
  id_mk CHAR(5),
  nim CHAR(18),
  FOREIGN KEY (id_mk) REFERENCES matakuliah(id_mk),
  FOREIGN KEY (nim) REFERENCES mahasiswa(nim)
);

--2 Ubah kolom nama pada tabel matakuliah menjadi VARCHAR2(100)	 
ALTER TABLE matakuliah
MODIFY (nama VARCHAR2(100));

insert into mahasiswa values ('21/473285/SV/18820', 'Nadya', to_date('2002-07-01','YYYY-MM-DD'), 'P', 3.56);
insert into mahasiswa values ('23/298888/SV/19802', 'Sodiq', to_date('2004-07-01','YYYY-MM-DD'), 'L', 3.70);
insert into mahasiswa values ('22/543231/SV/17770', 'Mukti', to_date('2003-07-01','YYYY-MM-DD'), 'P', 3.56);
insert into mahasiswa values ('22/543323/SV/17777', 'Siti', to_date('2004-01-05','YYYY-MM-DD'), 'P', 3.82);
insert into mahasiswa values ('21/473286/SV/18821', 'Danang', to_date('2002-05-15','YYYY-MM-DD'), 'L', 3.40);
insert into mahasiswa values ('22/298888/SV/18820', 'Amir', to_date('2004-07-01','YYYY-MM-DD'), 'L', 3.78);

insert into matakuliah values ('MK001', 'Praktikum Basis Data', 2);
insert into matakuliah values ('MK002', 'Pengantar Teknologi Informasi', 1);
insert into matakuliah values ('MK003', 'Matematika Diskrit', 1);
insert into matakuliah values ('MK004', 'Praktikum Pemrograman', 1);
insert into matakuliah values ('MK005', 'Metode Penelitian', 4);
insert into matakuliah values ('MK006', 'Verifikasi dan Validasi', 4);
insert into matakuliah values ('MK007', 'PMLD 2', 6);
insert into matakuliah values ('MK008', 'Bahasa Inggris 1',1);
insert into matakuliah values ('MK009', 'Ide Kreatif dan Kewirausahaan',6);
insert into matakuliah values ('MK010', 'Pemrograman Web',2);
						 
insert into KRS values ('KRS01', 'MK001', '23/298888/SV/19802');
insert into KRS values ('KRS02', 'MK002', '23/298888/SV/19802');
insert into KRS values ('KRS03', 'MK003','23/298888/SV/19802');
insert into KRS values ('KRS04', 'MK005', '22/543323/SV/17777');
insert into KRS values ('KRS05', 'MK009', '21/473286/SV/18821');
insert into KRS values ('KRS06', 'MK005', '22/543231/SV/17770');
insert into KRS values ('KRS07', 'MK005', '22/298888/SV/18820');
insert into KRS values ('KRS08', 'MK009', '21/473285/SV/18820');

--3 Ubah kolom nama pada tabel matakuliah menjadi VARCHAR2(100)	 
SELECT * FROM matakuliah 
WHERE MOD(semester, 2) = 0;

--4 Tampilkan semua mata kuliah yang ditawarkan di semester genap!
SELECT COUNT(*) AS jumlah_mata_kuliah FROM matakuliah 
WHERE semester = 1;

--5 Tampilkan jumlah mata kuliah yang harus diambil mahasiswa semester 1!
SELECT MIN(IPK) AS ipk_terendah FROM mahasiswa;

--6 Tampilkan berapa ipk terendah dari ipk seluruh mahasiswa! 
SELECT nim, nama, jenis_kelamin FROM mahasiswa 
WHERE jenis_kelamin = 'P' AND nim LIKE '22/%';

--7 Tampilkan data (nim,nama, jenis kelamin) mahasiswa perempuan yang ada di angkatan 2022!
SELECT nim, nama, tanggal_lahir, (SYSDATE - tanggal_lahir)/365 AS umur FROM mahasiswa 
WHERE (SYSDATE - tanggal_lahir)/365 > 21 ORDER BY umur ASC;

--8 Tampilkan data semua mahasiswa dan semua mata kuliah yang diambil oleh tiap mahasiswa!
SELECT m.nim, m.nama, mk.nama AS nama_matakuliah FROM mahasiswa m 
JOIN KRS k ON m.nim = k.nim JOIN matakuliah mk ON k.id_mk = mk.id_mk;

--9 Tampilkan data mahasiswa (nim, nama) yang mengambil kelas Metode Penelitian!
SELECT m.nim, m.nama FROM mahasiswa m JOIN KRS k ON m.nim = k.nim 
JOIN matakuliah mk ON k.id_mk = mk.id_mk WHERE mk.nama = 'Metode Penelitian';

--10 Tampilkan data mata kuliah yang tidak memiliki mahasiswa urutkan berdasarkan semester!
SELECT mk.* FROM matakuliah mk LEFT JOIN KRS k ON mk.id_mk = k.id_mk 
WHERE k.id_mk IS NULL ORDER BY mk.semester;

--Bonus Tampilkan data mahasiswa dengan ipk terendah!
SELECT * FROM mahasiswa WHERE IPK = (SELECT MIN(IPK) FROM mahasiswa);
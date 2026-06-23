-- ================================
-- MINI PROJECT: Analisis Populasi Dunia
-- Dataset: countries, population_2020, population_forecast
-- ================================

-- 1. RINGKASAN UMUM POPULASI 2020
SELECT
  COUNT(*) AS total_negara,
  SUM(p.`Population 2020`) AS total_populasi_dunia,
  ROUND(AVG(p.`Population 2020`), 0) AS rata_populasi_per_negara,
  MAX(p.`Population 2020`) AS populasi_terbesar,
  MIN(p.`Population 2020`) AS populasi_terkecil
FROM `praxis-road-456312-p3.latihan_SQL.population_2020` p

-- 2. JUMLAH NEGARA PER BENUA
SELECT 
  c.string_field_2 AS benua,
  COUNT(*) AS jumlah_negara
FROM `praxis-road-456312-p3.latihan_SQL.countries` c
GROUP BY benua
ORDER BY jumlah_negara DESC

-- 3. TOP 10 NEGARA POPULASI TERBESAR 2020
SELECT 
  c.string_field_0 AS negara,
  c.string_field_2 AS benua,
  c.string_field_1 AS ibukota,
  p.`Population 2020` AS populasi
FROM `praxis-road-456312-p3.latihan_SQL.countries` c
LEFT JOIN `praxis-road-456312-p3.latihan_SQL.population_2020` p
ON c.string_field_0 = p.`Country _or dependency_`
ORDER BY p.`Population 2020` DESC
LIMIT 10

-- 4. RATA-RATA POPULASI PER BENUA
SELECT 
  c.string_field_2 AS benua,
  COUNT(*) AS jumlah_negara,
  ROUND(AVG(p.`Population 2020`), 0) AS rata_populasi,
  MAX(p.`Population 2020`) AS populasi_terbesar,
  MIN(p.`Population 2020`) AS populasi_terkecil
FROM `praxis-road-456312-p3.latihan_SQL.countries` c
LEFT JOIN `praxis-road-456312-p3.latihan_SQL.population_2020` p
ON c.string_field_0 = p.`Country _or dependency_`
GROUP BY benua
ORDER BY rata_populasi DESC

-- 5. RANKING TOP 3 NEGARA PER BENUA
SELECT 
  c.string_field_2 AS benua,
  c.string_field_0 AS negara,
  p.`Population 2020` AS populasi,
  RANK() OVER(PARTITION BY c.string_field_2 ORDER BY p.`Population 2020` DESC) AS ranking
FROM `praxis-road-456312-p3.latihan_SQL.countries` c
LEFT JOIN `praxis-road-456312-p3.latihan_SQL.population_2020` p
ON c.string_field_0 = p.`Country _or dependency_`
QUALIFY RANK() OVER(PARTITION BY c.string_field_2 ORDER BY p.`Population 2020` DESC) <= 3

-- 6. KATEGORISASI NEGARA BERDASARKAN POPULASI
SELECT 
  c.string_field_0 AS negara,
  c.string_field_2 AS benua,
  p.`Population 2020` AS populasi,
  CASE
    WHEN p.`Population 2020` >= 100000000 THEN 'Sangat Padat (>100 juta)'
    WHEN p.`Population 2020` BETWEEN 10000000 AND 99999999 THEN 'Padat (10-100 juta)'
    WHEN p.`Population 2020` BETWEEN 1000000 AND 9999999 THEN 'Sedang (1-10 juta)'
    ELSE 'Kecil (<1 juta)'
  END AS kategori_populasi
FROM `praxis-road-456312-p3.latihan_SQL.countries` c
LEFT JOIN `praxis-road-456312-p3.latihan_SQL.population_2020` p
ON c.string_field_0 = p.`Country _or dependency_`
ORDER BY p.`Population 2020` DESC

-- 7. TREN POPULASI DUNIA 2020-2050
SELECT 
  Year,
  Population,
  CASE
    WHEN Population >= 9000000000 THEN 'Sangat Tinggi (>9 miliar)'
    WHEN Population BETWEEN 8000000000 AND 8999999999 THEN 'Tinggi (8-9 miliar)'
    WHEN Population BETWEEN 7000000000 AND 7999999999 THEN 'Sedang (7-8 miliar)'
    ELSE 'Rendah (<7 miliar)'
  END AS kategori
FROM `praxis-road-456312-p3.latihan_SQL.population_forecast`
WHERE Year != 'July 1)'
ORDER BY Year ASC
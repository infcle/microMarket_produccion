SELECT *
FROM producto as p
INNER JOIN producto_etiquetado as pe ON p.id_prod = pe.id_prod
where pe.id_compra = 11
ORDER BY p.idseccion
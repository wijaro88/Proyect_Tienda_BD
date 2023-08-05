-- ejercicio 1
SELECT id_cliente FROM cliente WHERE barrio = 'Monterrey';
-- ejercicio 2
SELECT sku,nombre FROM producto WHERE precio < 15; 
-- ejercicio 3
SELECT cliente.id_cliente, cliente.nombre, venta_producto.cantidad, producto.nombre AS descripcion_producto
FROM cliente
JOIN venta ON cliente.id_cliente = venta.id_cliente
JOIN venta_producto ON venta.id_venta = venta_producto.id_venta
JOIN producto ON venta_producto.sku = producto.sku
WHERE venta_producto.cantidad > 10;
--ejercicio 4
SELECT cliente.id_cliente, cliente.nombre
FROM cliente 
LEFT JOIN venta  ON cliente.id_cliente = venta.id_cliente
WHERE venta.id_venta IS NULL;
--ejercicio 5
SELECT cliente.id_cliente, cliente.nombre FROM "cliente" 
WHERE NOT EXISTS (
    SELECT producto.sku
    FROM producto 
    WHERE NOT EXISTS (
        SELECT venta_producto.sku
        FROM venta_producto
        WHERE venta_producto.id_venta IN (
            SELECT venta.id_venta
            FROM venta 
            WHERE venta.id_cliente = cliente.id_cliente
        )
        AND venta_producto.sku = producto.sku
    )
);
--ejercicio 6
SELECT cliente.id_cliente, cliente.nombre, SUM(venta_producto.cantidad) AS total_cantidad 
FROM cliente
LEFT JOIN venta  ON cliente.id_cliente = venta.id_cliente
LEFT JOIN venta_producto  ON venta.id_venta = venta_producto.id_venta GROUP BY cliente.id_cliente, cliente.nombre
order by  total_cantidad ;
--ejercicio 7
SELECT producto.sku, venta_producto.id_venta
FROM producto 
LEFT JOIN venta_producto  ON producto.sku = venta_producto.sku
LEFT JOIN venta  ON venta_producto.id_venta = venta.id_venta
LEFT JOIN cliente  ON venta.id_cliente = cliente.id_cliente AND cliente.barrio = 'Guadalajara'
WHERE cliente.id_cliente IS NULL;
--ejercicio 8
SELECT p.sku
FROM producto AS p
INNER JOIN venta_producto AS vp ON p.sku = vp.sku
INNER JOIN venta AS v ON vp.id_venta = v.id_venta
INNER JOIN cliente AS c ON v.id_cliente = c.id_cliente
WHERE c.barrio = 'Monterrey'
AND p.sku IN (
    SELECT p2.sku
    FROM producto AS p2
    INNER JOIN venta_producto AS vp2 ON p2.sku = vp2.sku
    INNER JOIN venta AS v2 ON vp2.id_venta = v2.id_venta
    INNER JOIN cliente AS c2 ON v2.id_cliente = c2.id_cliente
    WHERE c2.barrio = 'Cancún'
);
--ejercicio 9
SELECT cliente.barrio
FROM cliente 
INNER JOIN venta  ON cliente.id_cliente = venta.id_cliente
INNER JOIN venta_producto  ON venta.id_venta = venta_producto.id_venta
INNER JOIN producto  ON venta_producto.sku = producto.sku
GROUP BY cliente.barrio
HAVING COUNT(DISTINCT producto.sku) = (SELECT COUNT(*) FROM producto);



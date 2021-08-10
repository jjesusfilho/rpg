
## Primeira abordagem
select * from (
  select *,
  row_number() over (partition by cyl order by cyl) linha
  from mtcars) dups
where dups.linha > 1;

## Segunda abordagem 

DELETE FROM tablename
WHERE id IN (
  SELECT
  id
  FROM (
    SELECT
    id,
    row_number() OVER w as rnum
    FROM tablename
    WINDOW w AS (
      PARTITION BY column1, column2, column3
      ORDER BY id
    )
    
  ) t
  WHERE t.rnum > 1);


## Terceira abordagem


WITH x AS (SELECT      t_location dup, min(ctid)
           
           FROM         t_location
           
           GROUP BY 1
           
           HAVING count(*) > 1
           
)

DELETE FROM    t_location

USING     x

WHERE     (t_location) = (dup)

AND t_location.ctid <> x.min


##


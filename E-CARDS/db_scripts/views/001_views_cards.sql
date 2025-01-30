CREATE VIEW vw_cards AS
SELECT 
    c.id,
    c.hp,
    c.name,
    t.type_name,
    s.stage_name,
    c.Informações,
    c.attack,
    c.damage,
    c.weak,
    c.resistance,
    c.retreat,
    c.cardNumberInCollection,
    col.collectionsSetName,
    col.releaseDate,
    col.totalCardsInCollection
FROM 
    tbl_cards c
    JOIN tbl_types t ON c.type_id = t.type_id
    JOIN tbl_stages s ON c.stage_id = s.stage_id
    JOIN tbl_collections col ON c.collection_id = col.id;
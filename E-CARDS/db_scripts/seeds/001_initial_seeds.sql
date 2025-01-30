INSERT INTO tbl_collections (collectionsSetName, releaseDate, totalCardsInCollection)
VALUES
       ('Base Set', '1999-01-09', 102),
       ('Jungle', '1999-06-16', 64),
       ('Fossil', '1999-10-10', 62);

INSERT INTO tbl_types (type_name)
VALUES
       ('Grass'),
       ('Fire'),
       ('Water'),
       ('Lightning'),
       ('Psychic'),
       ('Fighting'),
       ('Darkness'),
       ('Metal'),
       ('Fairy'),
       ('Dragon'),
       ('Colorless');

INSERT INTO tbl_stages (stage_name)
VALUES
       ('Basic'),
       ('Stage 1'),
       ('Stage 2');

INSERT INTO tbl_cards (hp, name, type_id, stage_id, Informações, attack, damage, weak, resistance, retreat, cardNumberInCollection, collection_id)
VALUES
       (40, 'Bulbasaur', (SELECT type_id FROM tbl_types WHERE type_name = 'Grass'), (SELECT stage_id FROM tbl_stages WHERE stage_name = 'Basic'), 'A Grass-type Pokémon.', 'Tackle', '10', 'Fire', 'Water', '1', 1, (SELECT id FROM tbl_collections WHERE collectionsSetName = 'Base Set')),
       (50, 'Charmeleon', (SELECT type_id FROM tbl_types WHERE type_name = 'Fire'), (SELECT stage_id FROM tbl_stages WHERE stage_name = 'Stage 1'), 'A Fire-type Pokémon.', 'Slash', '30', 'Water', 'None', '1', 24, (SELECT id FROM tbl_collections WHERE collectionsSetName = 'Base Set')),
       (30, 'Squirtle', (SELECT type_id FROM tbl_types WHERE type_name = 'Water'), (SELECT stage_id FROM tbl_stages WHERE stage_name = 'Basic'), 'A Water-type Pokémon.', 'Bubble', '10', 'Electric', 'None', '1', 7, (SELECT id FROM tbl_collections WHERE collectionsSetName = 'Base Set'));

INSERT INTO tbl_card_owners (owner_name, card_id)
VALUES
       ('Ash Ketchum', (SELECT id FROM tbl_cards WHERE name = 'Bulbasaur')),
       ('Misty', (SELECT id FROM tbl_cards WHERE name = 'Squirtle')),
       ('Brock', (SELECT id FROM tbl_cards WHERE name = 'Charmeleon'));

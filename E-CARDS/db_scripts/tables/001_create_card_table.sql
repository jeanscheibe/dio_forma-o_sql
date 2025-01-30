CREATE TABLE tbl_collections (
    id INT AUTO_INCREMENT PRIMARY KEY,
    collectionsSetName VARCHAR(100) NOT NULL,
    releaseDate DATE NOT NULL,
    totalCardsInCollection INT NOT NULL
);

CREATE TABLE tbl_types (
    type_id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL
);

CREATE TABLE tbl_stages (
    stage_id INT AUTO_INCREMENT PRIMARY KEY,
    stage_name VARCHAR(50) NOT NULL
);

CREATE TABLE tbl_cards (
    id INT AUTO_INCREMENT PRIMARY KEY,
    hp INT,
    name VARCHAR(100) NOT NULL,
    type_id INT,
    stage_id INT,
    Informações TEXT,
    attack VARCHAR(100),
    damage VARCHAR(50),
    weak VARCHAR(50),
    resistance VARCHAR(50),
    retreat VARCHAR(50),
    cardNumberInCollection INT NOT NULL,
    collection_id INT,
    CONSTRAINT fk_type_cards FOREIGN KEY(type_id) REFERENCES tbl_types(type_id),
    CONSTRAINT fk_stage_cards FOREIGN KEY(stage_id) REFERENCES tbl_stages(stage_id),
    CONSTRAINT fk_collection_cards FOREIGN KEY(collection_id) REFERENCES tbl_collections(id)
);

CREATE INDEX idx_cards_collection_id ON tbl_cards (collection_id);

CREATE TABLE tbl_card_owners (
    owner_id INT AUTO_INCREMENT PRIMARY KEY,
    owner_name VARCHAR(100) NOT NULL,
    card_id INT,
    CONSTRAINT fk_card_id FOREIGN KEY(card_id) REFERENCES tbl_cards(id)
);

CREATE INDEX idx_card_owners_card_id ON tbl_card_owners (card_id);

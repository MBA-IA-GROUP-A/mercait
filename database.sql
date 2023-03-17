create database if not exists ecommerce;
use ecommerce;
CREATE TABLE IF NOT EXISTS `categories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `key` VARCHAR(255) NOT NULL,
  `label` VARCHAR(255) NOT NULL,
  `active` INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`))
ENGINE = InnoDB DEFAULT CHARSET = utf8;


-- -----------------------------------------------------
-- Table `products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `products` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `description` TEXT NULL,
  `category` INT NOT NULL,
  `price` INT NOT NULL DEFAULT 0,
  `stock` INT NOT NULL DEFAULT 0,
  `created_at` TIMESTAMP NOT NULL DEFAULT NOW(),
  `updated_at` TIMESTAMP NOT NULL DEFAULT NOW(),
  `deleted_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_products_categories_idx` (`category` ASC),
  CONSTRAINT `fk_products_categories`
    FOREIGN KEY (`category`)
    REFERENCES `categories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB DEFAULT CHARSET = utf8;


-- -----------------------------------------------------
-- Table `users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT NOW(),
  `updated_at` TIMESTAMP NOT NULL DEFAULT NOW(),
  `deleted_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB DEFAULT CHARSET = utf8;


-- -----------------------------------------------------
-- Table `address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `label` VARCHAR(255) NOT NULL,
  `zipcode` VARCHAR(10) NOT NULL,
  `country` VARCHAR(4) NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  `number` VARCHAR(10) NULL,
  `complement` VARCHAR(255) NULL,
  `city` VARCHAR(255) NOT NULL,
  `state` VARCHAR(10) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT NOW(),
  `updated_at` TIMESTAMP NOT NULL DEFAULT NOW(),
  `deleted_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB DEFAULT CHARSET = utf8;


-- -----------------------------------------------------
-- Table `users_has_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `users_has_address` (
  `users_id` INT NOT NULL,
  `address_id` INT NOT NULL,
  PRIMARY KEY (`users_id`, `address_id`),
  INDEX `fk_users_has_address_address1_idx` (`address_id` ASC),
  INDEX `fk_users_has_address_users1_idx` (`users_id` ASC),
  CONSTRAINT `fk_users_has_address_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_has_address_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB DEFAULT CHARSET = utf8;


-- -----------------------------------------------------
-- Table `status_order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `status_order` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `label` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB DEFAULT CHARSET = utf8;


-- -----------------------------------------------------
-- Table `orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `orders` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user` INT NOT NULL,
  `total` INT NOT NULL DEFAULT 0,
  `status` INT NOT NULL,
  `address` INT NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT NOW(),
  `updated_at` TIMESTAMP NOT NULL DEFAULT NOW(),
  `deleted_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_orders_users1_idx` (`user` ASC),
  INDEX `fk_orders_status_order1_idx` (`status` ASC),
  CONSTRAINT `fk_orders_users1`
    FOREIGN KEY (`user`)
    REFERENCES `users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_address1`
    FOREIGN KEY (`address`)
    REFERENCES `address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_status_order1`
    FOREIGN KEY (`status`)
    REFERENCES `status_order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB DEFAULT CHARSET = utf8;


-- -----------------------------------------------------
-- Table `order_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `order_items` (
  `order` INT NOT NULL,
  `product` INT NOT NULL,
  `quantity` INT NOT NULL DEFAULT 0,
  `price` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`order`, `product`),
  INDEX `fk_order_items_products1_idx` (`product` ASC),
  CONSTRAINT `fk_order_items_orders1`
    FOREIGN KEY (`order`)
    REFERENCES `orders` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_items_products1`
    FOREIGN KEY (`product`)
    REFERENCES `products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB DEFAULT CHARSET = utf8;


INSERT INTO `categories` (`key`, `label`, `active`) VALUES
('books', 'Books', 1),
('electronics', 'Electronics', 1),
('clothing', 'Clothing', 1),
('beauty', 'Beauty', 1),
('jewelry', 'Jewelry', 1),
('toys', 'Toys', 1),
('sporting_goods', 'Sporting Goods', 1),
('home_decor', 'Home Decor', 1),
('food_and_beverage', 'Food & Beverage', 1),
('music', 'Music', 1),
('movies', 'Movies', 1),
('games', 'Games', 1),
('pet_supplies', 'Pet Supplies', 1),
('office_supplies', 'Office Supplies', 1),
('automotive', 'Automotive', 1),
('tools_and_home_improvement', 'Tools & Home Improvement', 1),
('baby', 'Baby', 1),
('health', 'Health', 1),
('outdoor', 'Outdoor', 1),
('travel', 'Travel', 1);

INSERT INTO `status_order` (`label`) VALUES ('pending'), ('processing'), ('shipped'), ('delivered'), ('cancelled');

-- Inserts for Users table
INSERT INTO `users` (`name`, `email`) VALUES
  ('John Smith', 'john.smith@example.com'),
  ('Jane Doe', 'jane.doe@example.com'),
  ('Bob Johnson', 'bob.johnson@example.com'),
  ('Alice Brown', 'alice.brown@example.com'),
  ('David Lee', 'david.lee@example.com'),
  ('Karen Kim', 'karen.kim@example.com'),
  ('Tom Wilson', 'tom.wilson@example.com'),
  ('Sara Lee', 'sara.lee@example.com'),
  ('Jack Lee', 'jack.lee@example.com'),
  ('Emily Smith', 'emily.smith@example.com'),
  ('Daniel Kim', 'daniel.kim@example.com'),
  ('Olivia Brown', 'olivia.brown@example.com'),
  ('Jessica Lee', 'jessica.lee@example.com'),
  ('Michael Wilson', 'michael.wilson@example.com'),
  ('Sophia Kim', 'sophia.kim@example.com'),
  ('Kevin Smith', 'kevin.smith@example.com'),
  ('Amy Johnson', 'amy.johnson@example.com'),
  ('Eric Brown', 'eric.brown@example.com'),
  ('Grace Lee', 'grace.lee@example.com'),
  ('Vinícius Marcili', 'vinipetter@gmail.com');

INSERT INTO `address` (`zipcode`, `country`, `address`, `number`, `complement`, `city`, `state`, `label`) VALUES 
('11111-111', 'BR', 'Rua Alegria', '123', NULL, 'São Paulo', 'SP', 'Casa'),
('22222-222', 'BR', 'Avenida Liberdade', '456', NULL, 'Rio de Janeiro', 'RJ', 'Casa'),
('33333-333', 'BR', 'Rua da Praia', '789', 'Loja 2', 'Salvador', 'BA', 'Casa'),
('44444-444', 'BR', 'Rua da Amizade', '555', 'Sala 3', 'Belo Horizonte', 'MG', 'Casa'),
('55555-555', 'BR', 'Rua dos Sonhos', '888', NULL, 'Curitiba', 'PR', 'Casa'),
('66666-666', 'BR', 'Avenida Central', '777', 'Loja 1', 'Fortaleza', 'CE', 'Casa'),
('77777-777', 'BR', 'Rua da Paz', '246', NULL, 'Recife', 'PE', 'Casa'),
('88888-888', 'BR', 'Avenida dos Girassóis', '1200', 'Apto. 501', 'Goiania', 'GO', 'Casa'),
('99999-999', 'BR', 'Rua da Harmonia', '330', NULL, 'Porto Alegre', 'RS', 'Casa'),
('12345-678', 'BR', 'Avenida Paulista', '1000', 'Conjunto 1503', 'São Paulo', 'SP', 'Casa'),
('23456-789', 'BR', 'Rua das Flores', '200', NULL, 'Florianópolis', 'SC', 'Casa'),
('34567-890', 'BR', 'Avenida Brasil', '500', 'Loja 5', 'Rio de Janeiro', 'RJ', 'Casa'),
('45678-901', 'BR', 'Rua do Sol', '100', NULL, 'Natal', 'RN', 'Casa'),
('56789-012', 'BR', 'Avenida Atlântica', '1500', 'Apartamento 2001', 'Rio de Janeiro', 'RJ', 'Casa'),
('67890-123', 'BR', 'Rua das Pedras', '300', NULL, 'Búzios', 'RJ', 'Casa'),
('78901-234', 'BR', 'Avenida Sete de Setembro', '600', 'Sala 10', 'Salvador', 'BA', 'Casa'),
('89012-345', 'BR', 'Rua do Carmo', '400', NULL, 'Recife', 'PE', 'Casa'),
('90123-456', 'BR', 'Avenida Beira-Mar', '800', 'Apartamento 1003', 'Fortaleza', 'CE', 'Casa'),
('01234-567', 'BR', 'Rua da Consolação', '700', 'Conjunto 305', 'São Paulo', 'SP', 'Casa'),
('12345-678', 'BR', 'Avenida Rui Barbosa', '900', NULL, 'Recife', 'PE', 'Casa');


INSERT INTO `users_has_address` VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15),
(16, 16),
(17, 17),
(18, 18),
(19, 19),
(20, 20);

 INSERT INTO `products` (`name`,`description`,`category`,`price`,`stock`) VALUES
 ('T-shirt','A simple and comfortable T-shirt',1,20,100),
 ('Jeans','Classic blue jeans',1,50,50),
 ('Sneakers','Sporty and stylish sneakers',1,80,30),
 ('Hoodie','A warm and cozy hoodie',1,40,80),
 ('Running Shoes','Lightweight and comfortable shoes for running',1,70,20),
 ('Shorts','Comfortable and lightweight shorts',1,30,60),
 ('Backpack','A durable and spacious backpack',2,50,40),
 ('Suitcase','A high-quality and stylish suitcase',2,100,30),
 ('Messenger Bag','A versatile and stylish bag',2,60,50),
 ('Wallet','A sleek and minimalist wallet',2,20,100),
 ('Briefcase','A professional and elegant briefcase',2,80,20),
 ('Smartphone','A powerful and high-end smartphone',3,1000,10),
 ('Tablet','A portable and versatile tablet',3,600,20),
 ('Laptop','A high-performance and reliable laptop',3,1200,5),
 ('Smartwatch','A stylish and feature-packed smartwatch',3,300,30),
 ('Headphones','Premium noise-cancelling headphones',3,350,20),
 ('Camera','A professional-grade camera with advanced features',4,2000,5),
 ('Lens','A high-quality lens for professional photography',4,1000,10),
 ('Tripod','A sturdy and reliable tripod for cameras',4,150,30),
 ('Flash','A powerful external flash for cameras',4,200,20),
 ('Drone','A high-tech drone for aerial photography and videography',4,1500,3),
 ('Coffee Maker','A high-quality and easy-to-use coffee maker',5,100,30),
 ('Kettle','A stylish and efficient electric kettle',5,50,50),
 ('Toaster','A reliable and functional toaster',5,40,80),
 ('Blender','A powerful and versatile blender',5,80,20),
 ('Mixer','A high-performance and durable mixer',5,120,10),
 ('Knife Set','A set of high-quality and sharp knives',6,150,20),
 ('Cutting Board','A durable and easy-to-clean cutting board',6,30,50),
 ('Cookware Set','A comprehensive set of high-quality cookware',6,300,10),
 ('Spatula','A versatile and durable spatula',6,10,100),
 ('Nike Air Force 1','Leather and synthetic upper with textile lining, rubber outsole.',6,110,15),
 ('Adidas Originals Superstar','Leather and synthetic upper with rubber outsole.',6,90,20),
 ('Puma Calibrate Runner','Textile upper with rubber outsole.',6,80,25),
 ('Reebok Classic Leather','Leather upper with rubber outsole.',6,70,30),
 ('Converse Chuck Taylor All Star','Canvas upper with rubber outsole.',6,50,40),
 ('Timberland 6 Inch Premium Boot','Leather upper with rubber outsole.',6,180,10),
 ('New Balance 574 Core','Suede and mesh upper with rubber outsole.',6,100,20),
 ('Vans Old Skool','Canvas and suede upper with rubber outsole.',6,65,30),
 ('Asics Gel-Kayano 27','Mesh upper with rubber outsole.',6,160,15),
 ('Salomon Speedcross 5','Mesh and synthetic upper with rubber outsole.',6,130,20),
 ('Nike Mercurial Superfly 7 Elite','Synthetic upper with rubber outsole.',7,300,5),
 ('Adidas Predator 20.1 FG','Synthetic upper with rubber outsole.',7,250,10),
 ('Puma Future Z 1.1 FG/AG','Synthetic upper with rubber outsole.',7,220,15),
 ('Under Armour Magnetico Pro FG','Synthetic upper with rubber outsole.',7,200,20),
 ('Mizuno Morelia Neo III β','K-Leather upper with rubber outsole.',7,180,25),
 ('Wilson Evolution Indoor Basketball','Composite leather cover with cushion core technology.',8,60,30),
 ('Spalding NBA Street Basketball','Rubber cover with deep channel design.',8,25,40),
 ('Molten BGG Basketball','Synthetic leather cover with butyl bladder.',8,45,35),
 ('Nike Premier Team FIFA Soccer Ball','Machine-stitched TPU cover with reinforced rubber bladder.',9,40,30),
 ('Adidas Tango Sala Futsal Ball','Machine-stitched PU cover with butyl bladder.',9,30,40),
 ("The Hitchhiker's Guide to the Galaxy",'A science fiction comedy series written by Douglas Adams',10,20,50),
 ('To Kill a Mockingbird','A classic novel written by Harper Lee',10,18,30),
 ('1984','A dystopian novel written by George Orwell',10,22,25),
 ('Pride and Prejudice','A romantic novel written by Jane Austen',10,16,35),
 ('The Lord of the Rings','An epic high fantasy novel written by J. R. R. Tolkien',10,25,20),
 ('Apple iPhone 13','The latest smartphone from Apple',11,1100,10),
 ('Samsung Galaxy S21','The flagship smartphone from Samsung',11,900,15),
 ('Sony WH-1000XM4','Noise-cancelling wireless headphones from Sony',11,350,20),
 ('Amazon Echo Dot (4th gen)','A smart speaker with Alexa voice assistant',11,50,30),
 ('Google Nest Learning Thermostat','A smart thermostat that learns your habits',11,250,5),
 ('Nike Air Zoom Pegasus 38','A popular running shoe from Nike',12,120,25),
 ('Adidas Ultraboost 21','A running shoe with responsive cushioning from Adidas',12,150,20),
 ('Spalding NBA Official Game Ball','The official basketball used in NBA games',12,100,15),
 ('Wilson Pro Staff RF97 Tennis Racquet','A tennis racquet used by Roger Federer',12,200,10),
 ('Mizuno Pro Limited Edition Baseball Glove','A high glove',20,300,10),
 ('Samsung Galaxy S21','5G smartphone with 6.2-inch display, 128GB storage, and 8GB RAM',13,999,50),
 ('Apple Watch Series 7','Smartwatch with always-on Retina display and various health and fitness features',14,379,30),
 ('Dell XPS 13','13-inch laptop with 11th Gen Intel Core i7 processor, 16GB RAM, and 512GB SSD',15,1299,20),
 ('Sony WH-1000XM4','Wireless noise-cancelling headphones with up to 30 hours of battery life',16,349,40),
 ('Nintendo Switch OLED','Handheld gaming console with OLED display and improved audio',17,349,25),
 ('GoPro HERO10 Black','Action camera with 5.3K video, 20MP photos, and HyperSmooth 4.0 stabilization',18,499,15),
 ('Canon EOS R5','Full-frame mirrorless camera with 45MP sensor and 8K video recording',19,3899,10),
 ('Bose QuietComfort Earbuds','True wireless earbuds with noise-cancellation and up to 6 hours of battery life',20,279,30),
 ('Razer Blade 15','15-inch gaming laptop with 10th Gen Intel Core i7 processor and NVIDIA GeForce RTX 3060 GPU',15,1799,15),
 ('LG OLED CX','55-inch 4K TV with OLED display and support for Dolby Vision IQ and Dolby Atmos',12,1499,10),
 ('Microsoft Surface Laptop 4','13.5-inch touchscreen laptop with AMD Ryzen 7 processor and 16GB RAM',15,1499,20),
 ('Samsung T7 Touch','Portable SSD with fingerprint security and up to 1TB storage capacity',11,189,50),
 ('Apple iPad mini','7.9-inch tablet with A15 Bionic chip and 5G connectivity',11,499,30),
 ('Beats Studio Buds','True wireless earbuds with active noise-cancellation and up to 8 hours of battery life',20,149,40),
 ('LG Gram 17','17-inch ultrabook with 11th Gen Intel Core i7 processor and up to 19.5 hours of battery life',15,1499,10),
 ('Nikon Z6 II','Full-frame mirrorless camera with 24.5MP sensor and 4K UHD video recording',19,1999,10),
 ('DJI Mini 2','Ultra-compact drone with 4K video and 31-minute flight time',11,449,20),
 ('Breville Barista Express','Semi-automatic espresso machine with built-in conical burr grinder',11,699,15),
 ('Fitbit Luxe','Fitness tracker with color display and up to 5 days of battery life',14,149,50),
 ('Wireless Headphones','Noise-canceling headphones with a long battery life',5,120,50),
 ('Smart Watch','Fitness tracker with heart rate monitor and sleep tracking',8,150,30),
 ('Bluetooth Speaker','Portable speaker with rich sound quality',7,80,20),
 ('Laptop Stand','Ergonomic stand for laptops and notebooks',9,35,100),
 ('Smart Plug','Wifi-enabled plug to control appliances remotely',11,25,70),
 ('Camping Tent','Waterproof and lightweight tent for 2 people',12,100,10),
 ('Air Fryer','Healthy way to fry food without oil',14,70,15),
 ('Robot Vacuum','Smart vacuum with mapping and scheduling features',13,250,5),
 ('Wireless Mouse','Ergonomic and responsive mouse for office or gaming use',6,45,40),
 ('Electric Shaver','Cordless shaver with multiple attachments and wet/dry use',4,90,25),
 ('Sous Vide Machine','Precision cooker for perfect cooking results',10,150,20),
 ('Baby Stroller','Lightweight and foldable stroller for infants and toddlers',16,200,5),
 ('Yoga Mat','Eco-friendly and non-slip mat for yoga and fitness',15,30,50),
 ('Dash Cam','High-resolution dash cam for car safety and security',18,120,10),
 ('Solar Charger','Portable charger with solar panels for outdoor use',17,50,30);

 INSERT INTO orders (id, user, total, status, address) VALUES (1, 20, 28000, 2, 1);
INSERT INTO order_items (`order`, product, quantity, price) VALUES (1, 1, 2, 2000), (1, 2, 1, 5000), (1, 3, 1, 8000), (1, 4, 1, 4000), (1, 5, 1, 7000);


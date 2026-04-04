-- ============================================================
-- FIRST AID ASSISTANT - DATABASE SCHEMA
-- Author: Ngumimi Bethel Tuse
-- ============================================================


-- ------------------------------------------------------------
-- TABLE: categories
-- Severity levels for procedures
-- ------------------------------------------------------------
CREATE TABLE categories (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

INSERT INTO categories (name, description) VALUES
    ('Emergency',       'Life-threatening. Call emergency services immediately.'),
    ('Minor',           'Can be managed at home with basic first aid.'),
    ('Minor-Emergency', 'May escalate. Monitor closely and seek help if worsens.');


-- ------------------------------------------------------------
-- TABLE: type
-- Medical type categories for procedures
-- ------------------------------------------------------------
CREATE TABLE type (
    type_id   INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL
);

INSERT INTO type (type_name) VALUES
    ('Skin reaction'),
    ('Neurological'),
    ('Respiratory'),
    ('Musculoskeletal'),
    ('Eye injury'),
    ('Burns'),
    ('Toxicological (Poisoning)'),
    ('Allergy'),
    ('Cardiovascular'),
    ('General');


-- ------------------------------------------------------------
-- TABLE: procedures
-- Core first aid procedures
-- ------------------------------------------------------------
CREATE TABLE procedures (
    id             INT AUTO_INCREMENT PRIMARY KEY,
    title          VARCHAR(255) NOT NULL,
    category       ENUM('Emergency', 'Minor', 'Minor-Emergency') NOT NULL,
    category_id    INT NOT NULL DEFAULT 1,
    type_id        INT,
    symptoms       TEXT,
    steps          TEXT NOT NULL,
    warnings       TEXT,
    call_emergency TINYINT(1) DEFAULT 0,
    is_offline_ready TINYINT(1) DEFAULT 1,
    CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES categories(id),
    CONSTRAINT fk_type     FOREIGN KEY (type_id)     REFERENCES type(type_id)
);

INSERT INTO procedures (title, category, category_id, type_id, symptoms, steps, warnings, call_emergency) VALUES
    (
        'Choking', 'Emergency', 1, 3,
        'Inability to speak or breathe, weak or forceful coughing, skin and lips turning blue or gray due to lack of oxygen, loss of consciousness',
        '1. Stand behind the person. 2. Wrap arms around waist. 3. Perform abdominal thrusts.',
        'Do NOT do blind finger sweeps. Do NOT give water. Do NOT leave the person alone. Do NOT do abdominal thrusts on infants.',
        1
    ),
    (
        'Minor Burn', 'Minor', 2, 6,
        'Redness, pain, small blisters, localised swelling',
        '1. Run cool (not cold) water over the burn for 10 to 20 minutes.',
        'Do NOT use ice. Do NOT apply butter or toothpaste. Do NOT burst blisters. Do NOT use fluffy cotton.',
        0
    ),
    (
        'Nosebleed', 'Minor', 2, 10,
        'Bright red blood flowing from one or both nostrils, sensation of liquid in the back of the throat, metallic taste, pain, dizziness',
        '1. Sit upright and lean forward slightly. 2. Pinch the soft part of your nose shut for 10 to 15 minutes. 3. Breathe through your mouth and avoid blowing your nose for several hours.',
        'Do NOT tilt head backwards. Do NOT stuff tissue into nostril. Do NOT blow nose immediately after. Do NOT resume physical activity right away.',
        0
    ),
    (
        'Severe Bleeding', 'Emergency', 1, 9,
        'Weak rapid pulse, pale cold clammy skin, intense thirst, dizziness, confusion or loss of consciousness, rapid breathing',
        '1. Apply firm direct pressure with a clean cloth. 2. Keep the pressure constant until help arrives. 3. If blood soaks through, add more cloth on top rather than removing the original.',
        'Do NOT remove original cloth even if soaked. Do NOT apply tourniquet unless trained. Do NOT leave person alone. Do NOT give food or water.',
        1
    ),
    (
        'Seizure', 'Emergency', 1, 2,
        'Shaking, muscle spasms, loss of consciousness, staring into space',
        '1. Ease the person to the floor and turn them gently onto one side. 2. Clear the area of hard or sharp objects. 3. Place something soft and flat under their head. 4. Do NOT put anything in their mouth or try to restrain them.',
        'Do NOT restrain the person. Do NOT put anything in their mouth. Do NOT give water or medication during seizure. Do NOT leave them alone until fully conscious.',
        1
    ),
    (
        'Anaphylaxis', 'Emergency', 1, 8,
        'Hives, swelling of throat or tongue, difficulty breathing, rapid pulse',
        '1. Call emergency services immediately. 2. Use an epinephrine auto-injector (EpiPen) if available. 3. Lay the person flat with legs raised. 4. If symptoms do not improve after 5 to 15 minutes, a second injection may be needed.',
        'Do NOT let the person stand or walk. Do NOT use antihistamines instead of epinephrine. Do NOT assume one EpiPen is enough. Do NOT leave them alone even if symptoms improve.',
        1
    ),
    (
        'Broken Bones', 'Emergency', 1, 4,
        'Immediate sharp pain, significant swelling, bruising and tenderness around the injury site, visible deformity',
        '1. Do not try to realign the bone. 2. Stop any bleeding by applying pressure with a clean cloth. 3. Immobilise the area using a splint or sling. 4. Apply ice packs wrapped in a cloth to reduce swelling.',
        'Do NOT try to realign the bone. Do NOT move the person if spine injury is suspected. Do NOT apply ice directly to skin. Do NOT give food or water in case surgery is needed.',
        1
    ),
    (
        'Snake Bite', 'Emergency', 1, 7,
        'Puncture marks, redness, swelling, intense pain, nausea',
        '1. Keep the person calm and still to slow the spread of venom. 2. Position the bite site at or below heart level. 3. Remove tight clothing or jewellery before swelling starts. 4. Do NOT cut the wound or try to suck out venom.',
        'Do NOT cut the wound or suck out venom. Do NOT apply tourniquet or ice. Do NOT give alcohol or medication. Do NOT try to catch the snake.',
        1
    ),
    (
        'Spider Bite', 'Minor-Emergency', 3, 7,
        'Redness, pain, itching or swelling',
        '1. Wash the area with soap and water. 2. Apply a cool compress to reduce pain and swelling. 3. Elevate the bite site. 4. Seek immediate medical help if symptoms like muscle cramps, fever or difficulty breathing occur.',
        'Do NOT squeeze or scratch the bite. Do NOT apply heat. Do NOT try to suck out venom. Do NOT ignore worsening symptoms.',
        0
    ),
    (
        'Poison Ivy', 'Minor-Emergency', 3, 1,
        'Itchy red rash, blisters, swelling, streaky marks on skin',
        '1. Rinse skin with soap and water immediately. 2. Remove and wash all clothing that touched the plant. 3. Apply calamine lotion or hydrocortisone cream to relieve itching. 4. Take antihistamines to reduce allergic reaction. 5. Avoid scratching to prevent infection.',
        'Do not touch your face or eyes after contact. See a doctor if rash spreads to face, eyes or genitals.',
        0
    ),
    (
        'Rash', 'Minor-Emergency', 3, 1,
        'Red or pink skin, itching, bumps, blisters, dry or scaly patches',
        '1. Identify and remove the cause if possible. 2. Wash the affected area gently with mild soap and water. 3. Apply a cool damp cloth to soothe irritation. 4. Use over the counter hydrocortisone cream for itching. 5. Avoid scratching the affected area.',
        'Seek medical attention if rash spreads rapidly, is accompanied by fever, or affects breathing.',
        0
    ),
    (
        'Opioid Overdose', 'Emergency', 1, 7,
        'Unresponsive, slow or stopped breathing, blue lips or fingertips, pinpoint pupils, gurgling sounds, limp body',
        '1. Call emergency services immediately. 2. Administer naloxone if available according to instructions. 3. Place person in recovery position if breathing. 4. Perform CPR if not breathing and you are trained. 5. Stay with the person until help arrives.',
        'Do not leave the person alone. Do not inject saltwater or ice. Even if they recover after naloxone, they still need emergency care.',
        1
    ),
    (
        'Severe Burn', 'Emergency', 1, 6,
        'Large or deep burn, white or charred skin, burn on face, hands, feet or joints, burn covering large area of body',
        '1. Call emergency services immediately. 2. Do not remove burned clothing stuck to skin. 3. Cover loosely with a clean non fluffy material. 4. Do not apply ice, butter or cream. 5. Keep the person warm to prevent shock. 6. Do not burst any blisters.',
        'Never use ice, iced water or any creams on severe burns. Do not remove clothing stuck to the burn.',
        1
    ),
    (
        'Shock', 'Emergency', 1, 9,
        'Pale cold clammy skin, rapid weak pulse, fast shallow breathing, dizziness, nausea, confusion, loss of consciousness',
        '1. Call emergency services immediately. 2. Lay the person down and raise their legs above heart level unless injured. 3. Keep them warm with a blanket. 4. Do not give them anything to eat or drink. 5. Loosen any tight clothing. 6. Monitor breathing and pulse until help arrives.',
        'Do not raise legs if you suspect a head, neck, spine or leg injury. Do not leave the person alone.',
        1
    ),
    (
        'Scorpion Sting', 'Emergency', 1, 7,
        'Sharp pain at sting site, numbness or tingling, swelling, nausea, difficulty breathing, muscle spasms',
        '1. Stay calm and keep the person still. 2. Wash the sting area with soap and water. 3. Apply a cool compress to reduce swelling. 4. Take over the counter pain relief if available. 5. Keep the stung limb at heart level.',
        'Seek emergency care immediately if the person is a child, elderly, or shows difficulty breathing or muscle spasms. Do not apply a tourniquet.',
        1
    ),
    (
        'Stroke', 'Emergency', 1, 2,
        'Face drooping on one side, arm weakness, slurred or confused speech, sudden severe headache, vision problems, loss of balance',
        '1. Use the FAST test: Face drooping, Arm weakness, Speech difficulty, Time to call emergency. 2. Call emergency services immediately. 3. Note the time symptoms started. 4. Keep them calm and comfortable. 5. Do not give food or water. 6. Monitor breathing until help arrives.',
        'Do not give aspirin unless instructed by emergency services. Time is critical — every minute matters with a stroke.',
        1
    ),
    (
        'Sprain', 'Minor', 2, 4,
        'Pain around a joint, swelling, bruising, limited range of motion, muscle spasms around the joint',
        '1. Follow RICE: Rest the injured area. Ice the area for 20 minutes every 2 hours. Compress with a bandage to reduce swelling. Elevate the injured limb above heart level. 2. Take over the counter pain relief if needed.',
        'Seek medical attention if the person cannot bear weight, the area is severely swollen, or you suspect a fracture.',
        0
    ),
    (
        'Black Eye', 'Minor', 2, 5,
        'Bruising and swelling around the eye, pain, redness, temporary blurred vision',
        '1. Apply a cold compress gently to the area for 15 to 20 minutes. 2. Repeat every hour for the first day. 3. Take over the counter pain relief for discomfort. 4. Keep head elevated to reduce swelling. 5. Avoid putting pressure on the eye.',
        'Seek medical attention if there is vision loss, blood inside the eye, severe headache, or the person lost consciousness.',
        0
    ),
    (
        'Asthma Attack', 'Emergency', 1, 3,
        'Wheezing or whistling sound when breathing, shortness of breath, chest tightness, rapid breathing, difficulty speaking in full sentences, coughing that worsens at night',
        '1. Sit the person upright, leaning slightly forward. 2. Stay calm and reassure them. 3. Help them use their reliever inhaler (usually blue). 4. Ask them to take one puff every 30 to 60 seconds, up to 10 puffs. 5. If no improvement after 10 puffs or no inhaler available, call emergency services immediately. 6. If symptoms improve, rest and monitor closely.',
        'Do NOT lay the person flat. Do NOT leave them alone. Do NOT give preventer inhaler during an attack, only the reliever. Do NOT ignore symptoms that do not improve within 15 minutes.',
        1
    );


-- ------------------------------------------------------------
-- TABLE: abcdes
-- The ABCDEs of first aid reference
-- ------------------------------------------------------------
CREATE TABLE abcdes (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    letter      VARCHAR(5)  NOT NULL,
    title       VARCHAR(50) NOT NULL,
    description TEXT        NOT NULL
);

INSERT INTO abcdes (letter, title, description) VALUES
    ('A', 'Airway',      'Ensure the airway is open and clear. Tilt the head back and lift the chin to open the airway.'),
    ('B', 'Breathing',   'Check if the person is breathing normally. Look for chest rise, listen for breath sounds.'),
    ('C', 'Circulation', 'Check for a pulse. If absent, begin CPR immediately.'),
    ('D', 'Disability',  'Assess the level of consciousness. Use AVPU: Alert, Voice, Pain, Unresponsive.'),
    ('E', 'Exposure',    'Expose the body to check for injuries, bleeding or rashes. Keep the patient warm.');


-- ------------------------------------------------------------
-- TABLE: first_aid_kit
-- Essential first aid kit items
-- ------------------------------------------------------------
CREATE TABLE first_aid_kit (
    id      INT AUTO_INCREMENT PRIMARY KEY,
    item    VARCHAR(100) NOT NULL,
    purpose TEXT         NOT NULL
);

INSERT INTO first_aid_kit (item, purpose) VALUES
    ('Adhesive bandages',  'Cover small cuts and wounds'),
    ('Sterile gauze pads', 'Cover larger wounds and control bleeding'),
    ('Medical tape',       'Secure bandages and dressings'),
    ('Antiseptic wipes',   'Clean wounds to prevent infection'),
    ('Disposable gloves',  'Protect yourself when treating others'),
    ('CPR face shield',    'Safely perform rescue breathing'),
    ('Scissors',           'Cut bandages, tape or clothing'),
    ('Tweezers',           'Remove splinters or debris from wounds'),
    ('Oral Thermometer',   'Check body temperature'),
    ('Pain relievers',     'Manage pain and fever'),
    ('Ibuprofen',          'Effective for swelling, sprains, muscle aches and injuries');
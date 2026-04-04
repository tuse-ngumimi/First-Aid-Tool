from database_conn import get_db_connection

SYNONYMS = {
    'cant breathe': ['choking', 'asthma', 'anaphylaxis'],
    'not breathing': ['choking', 'cardiac arrest'],
    'chest pain': ['anaphylaxis', 'cardiac arrest', 'heart attack'],
    'allergic reaction': ['anaphylaxis'],
    'broken arm': ['broken bones'],
    'broken leg': ['broken bones'],
    'nose bleeding': ['nosebleed'],
    'feels faint': ['fainting', 'shock'],
    'passed out': ['fainting', 'unconscious'],
    'heart attack': ['cardiac arrest', 'heart attack'],
    'overdose': ['opioid overdose'],
    'rash': ['poison ivy', 'rash'],
    'muscle spasms': ['seizure'],
    'swelling': ['broken bones', 'sprain']
}

def normalise_keyword(keyword):
    keyword_lower = keyword.lower()
    result = SYNONYMS.get(keyword_lower, keyword_lower)
    return result if isinstance(result, list) else [result]

def search_procedure(keyword):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    keywords = normalise_keyword(keyword)

    placeholders =  " OR ".join(
        ["(p.title LIKE %s OR p.symptoms LIKE %s)" for _ in keywords]
    )

    query = f"""
        SELECT p.title, p.category, p.symptoms, p.steps,
        p.warnings, p.call_emergency, t.type_name
        FROM procedures p
        LEFT JOIN type t ON p.type_id = t.type_id
        WHERE {placeholders}
    """

    params = []
    for term in keywords:
        search_term = f"%{term}%"
        params.extend([search_term, search_term])

    try:
        cursor.execute(query, params)
        results = cursor.fetchall()
        return results
    finally:
        cursor.close()
        conn.close()

def get_all_types():
    """Returns all types from the type table"""
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    try:
        cursor.execute("SELECT type_id, type_name FROM type ORDER BY type_name")
        return cursor.fetchall()
    finally:
        cursor.close()
        conn.close() 


def get_procedures_by_type(type_id):
    """Returns all procedures belonging to a specific type."""
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
 
    query = """
        SELECT p.title, p.category, p.symptoms, p.steps, p.warnings,
               p.call_emergency, t.type_name
        FROM procedures p
        LEFT JOIN type t ON p.type_id = t.type_id
        WHERE p.type_id = %s
        ORDER BY p.title
    """
 
    try:
        cursor.execute(query, (type_id,))
        return cursor.fetchall()
    finally:
        cursor.close()
        conn.close()
        

def get_abcdes():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    try:
        cursor.execute("SELECT letter, title, description FROM abcdes ORDER BY id")
        return cursor.fetchall()
    
    finally:
        cursor.close()
        conn.close()


def get_first_aid_kit():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    try:
      cursor.execute("SELECT item, purpose FROM first_aid_kit ORDER BY id")
      return cursor.fetchall()

    finally:
      cursor.close()
      conn.close()

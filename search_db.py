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
    'heart attack': ['cardiac arrest', 'heart attack'],
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
        ["(title LIKE %s OR symptoms LIKE %s)" for _ in keywords]
    )

    query = f"""
        SELECT title, category, symptoms, steps, warnings, call_emergency
        FROM procedures
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

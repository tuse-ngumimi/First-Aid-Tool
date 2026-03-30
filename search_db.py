from database_conn import get_db_connection

SYNONYMS = {
        'cant breathe': 'choking',
        'not breathing': 'choking',
        'chest pain': 'anaphylaxis',
        'allergic reaction': 'anaphylaxis',
        'broken arm': 'broken bones',
        'nose bleeding': 'nosebleed',
}

def normalise_keyword(keyword):
    keyword_lower = keyword.lower()
    return SYNONYMS.get(keyword_lower, keyword_lower)

def search_procedure(keyword):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    query = """
        SELECT title, category, symptoms, steps, warnings, call_emergency
        FROM procedures
        WHERE title LIKE %s
        OR symptoms LIKE %s
    """

    normalised = normalise_keyword(keyword)
    search_term = f"%{normalised}%"


    try:
        cursor.execute(query, (search_term, search_term))
        results = cursor.fetchall()
        return results
    finally:
        cursor.close()
        conn.close()
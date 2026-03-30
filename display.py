def display_procedure(procedure):

    if procedure['call_emergency']:
        print('CALL EMERGENCY SERVICES IMMEDIATELY')
        print()

    print(f"CONDITION: {procedure['title']}")
    print(f"CATEGORY: {procedure['category']}")

    print("\nSYMPTOMS:")
    print(f"  {procedure['symptoms']}")

    print("\nWHAT TO DO:")
    steps = procedure['steps'].split('.')
    for step in steps:
        step = step.strip()
        if step:
            print(f"  {step}.")

    if procedure['warnings']:
        print("\nWARNINGS:")
        print(f"  {procedure['warnings']}")

    print()
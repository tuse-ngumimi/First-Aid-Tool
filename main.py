import search_db
import display


def show_menu():
    print("FIRST AID ASSISTANT")
    print("-" * 34)
    print("  1. ABCDEs of First Aid")
    print("  2. Search for Emergency Procedure")
    print("  3. First Aid Kit Checklist")
    print("  4. Exit")
    print("-" * 34)


def handle_abcdes():
    try: 
            results =  search_db.get_abcdes()
    except Exception as e:
            print(f"Error in fetching data: {e}\n")
            return

    print("-" * 34)
    print(f"  THE ABCDEs OF FIRST AID")
    print("-" * 34)

    for row in results:
        print(f"\n  [{row['letter']}] {row['title'].upper()}")
        print(f"      {row['description']}")

    print("\n" + "-" * 34)
    print(f"Press enter to return to the main menu...")

def handle_search():
    while True:
       print("\n  Type a condition or symptom to search.")
       print("  Type 'back' to return to the main menu.\n")
 
       keyword = input("  Search: ").strip()
 
       if keyword.lower() == 'back':
            break
 
       if not keyword:
            print("  Please enter a search term.\n")
            continue
 
       try:
            results = search_db.search_procedure(keyword)
       except Exception as e:
            print(f"  Database error: {e}\n")
            continue
 
       if not results:
            print(f"  No results found for '{keyword}'. Try a different term.\n")
            continue
 
       if len(results) > 1:
            print(f"\n  Found {len(results)} results:")
            for i, r in enumerate(results, 1):
                print(f"    {i}. {r['title']} ({r['category']})")
 
            choice = input("\n  Enter number to view: ").strip()
            if choice.isdigit() and 1 <= int(choice) <= len(results):
                display.display_procedure(results[int(choice) - 1])
            else:
                print("  Invalid choice.\n")
       else:
            display.display_procedure(results[0])
        
def handle_first_aid_kit():
   try:
        results = search_db.get_first_aid_kit()
   except Exception as e:
        print(f" Error fetching data: {e}\n")
        return
 
   print("\n" + "-" * 34)
   print("  FIRST AID KIT CHECKLIST")
   print("-" * 34)
 
   for i, row in enumerate(results, 1):
        print(f"\n  {i}. {row['item']}")
        print(f"     → {row['purpose']}")
 
   print("\n" + "-" * 34)
   input("\nPress Enter to return to the main menu...")
 

def main():
    print("\nWelcome to the First Aid Assistant!\n") 
    print("Your quick guide in any emergency.\n")
 
    while True:
        show_menu()
        choice = input("\n  Enter your choice (1-4): ").strip()  

        if choice == "1":
             handle_abcdes()
        elif choice == "2":
             handle_search()
        elif choice == "3":
             handle_first_aid_kit()
        elif choice == '4':
            print("Stay safe. Goodbye!\n")
            break
        else:
            print("\n  Invalid choice. Please enter a number between 1 and 4.\n")
             


if __name__ == "__main__":
     main()
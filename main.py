import search_db
import display


def main():
    print("FIRST AID ASSISTANT")
    print("-" * 34)
    print("  1. ABCDEs of First Aid")
    print("  2. Search for Emergency Procedure")
    print("  3. First Aid Kit Checklist")
    print("  4. Exit")
    print("-" * 34)


    def abcdes_menu():
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

    
    while True:
        keyword = input("Search: ").strip()

        if keyword.lower() == 'close':
            print("Closing First Aid Assistant...")
            break

        if not keyword:
            print("Please enter a search term.\n")
            continue

        try:
            results = search_db.search_procedure(keyword)
        except Exception as e:
            print(f" Database error: {e}\n")
            continue

        if not results:
            print(f"No results found for '{keyword}'. Try a different term.\n")
            continue

        if len(results) > 1:
            print(f"\nFound {len(results)} results:")
            for i, r in enumerate(results, 1):
                print(f"  {i}. {r['title']} ({r['category']})")

            choice = input("\nEnter number to view: ").strip()
            if choice.isdigit() and 1 <= int(choice) <= len(results):
                display.display_procedure(results[int(choice) - 1])
            else:
                print("Invalid choice.\n")
        else:
            display.display_procedure(results[0])


if __name__ == "__main__":
    main()
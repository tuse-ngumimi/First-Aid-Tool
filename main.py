import search_db
import display


def main():
    print("FIRST AID ASSISTANT")
    print("Type a condition or symptom to search.")
    print("Type 'close' to exit.\n")

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
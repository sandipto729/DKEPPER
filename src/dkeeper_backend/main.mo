import List "mo:base/List";
import Debug "mo:base/Debug";
import Int "mo:base/Int";

actor DKEPPER {

  public type Note = {
    title : Text;
    content : Text;
  };

  stable var notes : List.List<Note> = List.nil<Note>();

  // Add a new note
  public func addNote(titleText : Text, contentText : Text) {
    let newNote : Note = {
      title = titleText;
      content = contentText;
    };

    notes := List.push(newNote, notes);
    Debug.print(debug_show (notes));
  };

  //get all notes
  public query func getNotes() : async [Note] {
    Debug.print(debug_show (notes));
    return List.toArray(notes);

  };

  //delete a note using id
  public func deleteNote(id : Int) : async () {
    // Helper function to remove an element at the specified index
    func removeAt<A>(lst : List.List<A>, idx : Int, curr : Int) : List.List<A> {
      switch (lst) {
        case (null) null;
        case (?(head, tail)) {
          if (curr == idx) {
            removeAt(tail, idx, curr + 1);
          } else {
            ?(head, removeAt(tail, idx, curr + 1));
          };
        };
      };
    };

    notes := removeAt(notes, id, 0);
    Debug.print(debug_show (notes));
  };

};

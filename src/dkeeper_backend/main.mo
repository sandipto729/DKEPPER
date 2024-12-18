import List "mo:base/List";
import Debug "mo:base/Debug";

actor DKEPPER {

  public type Note = {
    title : Text;
    content : Text;
  };

  var notes : List.List<Note> = List.nil<Note>();

  // Add a new note
  public func addNote(titleText : Text, contentText : Text){
    let newNote:Note={
      title=titleText;
      content=contentText;
    };

    notes:=List.push(newNote, notes);
    Debug.print(debug_show(notes));
  };

  //get all notes
  public query func getNotes() : async [Note] {
    Debug.print(debug_show(notes));
    return List.toArray(notes);

  };

};

import React, { useState, useEffect } from "react";
import Header from "./component/header";
import Footer from "./component/footer";
import Note from "./component/note";
import CreateArea from "./component/createArea";
import { dkeeper_backend } from "../../declarations/dkeeper_backend";

function App() {
  const [notes, setNotes] = useState([]);

  const addNote = async (newNote) => {
    try{
      await dkeeper_backend.addNote(newNote.title, newNote.content);
      setNotes(prevNotes => {
        return [newNote, ...prevNotes];
      });
    }
    catch(error){
      console.log(error);
    }  
  }

  const deleteNote= async function(id) {
    try{
      await dkeeper_backend.deleteNote(id);
      setNotes(prevNotes => {
        return prevNotes.filter((noteItem, index) => {
          return index !== id;
        });
      });
    }
    catch(error){
      console.log(error);
    }  
  }

  const getNotes = async () => {
    try{
      const notes = await dkeeper_backend.getNotes();
      setNotes(notes);
    }
    catch(error){
      console.log(error);
    }
  }
  useEffect(() => {
    getNotes();
  }, []);

  return (
    <div>
      <Header />
      <CreateArea onAdd={addNote} />
      {notes.map((noteItem, index) => {
        return (
          <Note
            key={index}
            id={index}
            title={noteItem.title}
            content={noteItem.content}
            onDelete={deleteNote}
          />
        );
      })}
      <Footer />
    </div>
  );
}

export default App;

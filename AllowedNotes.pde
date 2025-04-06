import java.util.Collections;
import java.util.Comparator;
class AllowedNotes {
  HashMap<String, Integer> noteMap;

  AllowedNotes() {
    noteMap = new HashMap<String, Integer>();
    addRange("", 0); addRange("C1", 24); addRange("D1", 26); addRange("E1", 28); addRange("F1", 29);
    addRange("G1", 31); addRange("A1", 33); addRange("B1", 35);
    addRange("C2", 36); addRange("D2", 38); addRange("E2", 40); addRange("F2", 41);
    addRange("G2", 43); addRange("A2", 45); addRange("B2", 47);
    addRange("C3", 48); addRange("D3", 50); addRange("E3", 52); addRange("F3", 53);
    addRange("G3", 55); addRange("A3", 57); addRange("B3", 59);
    addRange("C4", 60); addRange("D4", 62); addRange("E4", 64); addRange("F4", 65);
    addRange("G4", 67); addRange("A4", 69); addRange("B4", 71);
    addRange("C5", 72); addRange("D5", 74); addRange("E5", 76); addRange("F5", 77);
    addRange("G5", 79); addRange("A5", 81); addRange("B5", 83);
    addRange("C6", 84); addRange("D6", 86); addRange("E6", 88); addRange("F6", 89);
    addRange("G6", 91); addRange("A6", 93); addRange("B6", 95);
    addRange("C7", 96); addRange("D7", 98); addRange("E7", 100); addRange("F7", 101);
    addRange("G7", 103); addRange("A7", 105); addRange("B7", 107);
    addRange("C8", 108);
  }

  void addRange(String name, int midi) {
    noteMap.put(name, midi);
  }

ArrayList<NoteCircle> getNoteCircles() {
  ArrayList<NoteCircle> list = new ArrayList<NoteCircle>();

  for (String name : noteMap.keySet()) {
    list.add(new NoteCircle(name, noteMap.get(name)));
  }

  // 🔢 Sort the list by MIDI value (low to high)
  Collections.sort(list, new Comparator<NoteCircle>() {
    public int compare(NoteCircle a, NoteCircle b) {
      return a.midi - b.midi;
    }
  });

  return list;
}

}

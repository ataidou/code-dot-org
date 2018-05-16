import { PropTypes } from 'react';

// Reducer for section data in teacher dashboard.
// Tab specific reducers can import actions from this file
// if they need to respond to a section changing.

// Action type constants
export const SET_SECTION = 'sectionData/SET_SECTION';

// Action creators
export const setSection = (section) => {
  // Sort section.students by name.
  const sortedStudents = section.students.sort((a, b) => a.name.localeCompare(b.name));

  // Filter data to match sectionDataPropType
  const filteredSectionData = {
    id: section.id,
    script: section.script,
    students: sortedStudents,
  };
  return { type: SET_SECTION, section: filteredSectionData };
};

/**
 * Shape for the section
 * The section we get directly from angular right now. This gives us a
 * different shape than some other places we use sections. For now, I'm just
 * going to document the parts of section that we use here
 */
export const sectionDataPropType = PropTypes.shape({
  id: PropTypes.number.isRequired,
  script: PropTypes.object,
  students: PropTypes.arrayOf(PropTypes.shape({
    id: PropTypes.number.isRequired,
    name: PropTypes.string.isRequired,
  })).isRequired
});

// Initial state of sectionDataRedux
const initialState = {
  section: {},
};

export default function sectionData(state=initialState, action) {
  if (action.type === SET_SECTION) {
    return {
      ...state,
      section: action.section,
    };
  }

  return state;
}

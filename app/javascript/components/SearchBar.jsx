import React, { useState, useEffect } from 'react';
import axios from 'axios';
import debounce from 'lodash.debounce';

const SearchBar = ({ onSearchResults }) => {
  const [searchQuery, setSearchQuery] = useState('');

  const debouncedSearch = debounce(async (query) => {
    if (query.trim() !== '') {
      try {
        const response = await axios.get(`/products`, {
          params: { search: query },
        });
        onSearchResults(response.data);
      } catch (error) {
        debugger
        console.error('Error fetching products:', error);
      }
    } else {
      const response = await axios.get(`/products`);
      onSearchResults(response.data);
    }
  }, 500);

  const handleChange = (event) => {
    setSearchQuery(event.target.value);
    debouncedSearch(event.target.value);
  };

  return (
    <div className="row">
      <div className="col-sm-4">
        <input
          type="text"
          placeholder="Search products..."
          value={searchQuery}
          onChange={handleChange}
          className="search-input form-control"
        />
      </div>
    </div>
  );
};

export default SearchBar;

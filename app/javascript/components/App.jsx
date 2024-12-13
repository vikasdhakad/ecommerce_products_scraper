import React, { useState, useEffect } from 'react';
import ProductForm from '../components/ProductForm';
import SearchBar from './SearchBar';
import ProductList from '../components/ProductList';
import axios from 'axios';

function App() {
  const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  axios.defaults.headers['X-CSRF-Token'] = csrfToken;

  const [products, setProducts] = useState([]);

  const handleSearchResults = (results) => {
    setProducts(results);
  };

  const handleScrape = (url) => {
    axios.post('/products', { url }).then(() => {
      location.reload();
    });
  };

  useEffect(() => {
    axios.get('/products').then((response) => {
      setProducts(response.data);
    });
  }, []);

  return (
    <div className="container-fluid">
      <div className="mt-2">
        <ProductForm onScrape={handleScrape} />
      </div>
      <div className="mt-4 ml-3">
        <SearchBar onSearchResults={handleSearchResults} />      
      </div>
      <div className="mt-2">
        <ProductList products={products} />
      </div>
    </div>
  );
}

export default App;

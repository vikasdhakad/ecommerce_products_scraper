import React, { useState } from 'react';

function ProductForm({ onScrape }) {
  const [url, setUrl] = useState('');

  const handleSubmit = (e) => {
    e.preventDefault();
    onScrape(url);
    setUrl('');
  };

  return (
    <div className="mt-3">
      <form onSubmit={handleSubmit} className="row">
        <div className="col-sm-3">
          <input
            type="text"
            value={url}
            onChange={(e) => setUrl(e.target.value)}
            placeholder="Enter product URL"
            className="form-control"
          />
          
        </div>
        <div className="col-sm-3">
          <button className="btn btn-sm btn-primary ml-3" type="submit">
            Scrape Product
          </button>
        </div>
      </form>
    </div>
  );
}

export default ProductForm;

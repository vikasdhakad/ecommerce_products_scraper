import React, { useEffect } from 'react';
import axios from 'axios';

function ProductCard({ product }) {
  useEffect(() => {
    const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
    tooltipTriggerList.forEach(tooltipTriggerEl => {
      new window.bootstrap.Tooltip(tooltipTriggerEl);
    });

    return () => {
      tooltipTriggerList.forEach(tooltipTriggerEl => {
        const tooltip = window.bootstrap.Tooltip.getInstance(tooltipTriggerEl);
        if (tooltip) {
          tooltip.dispose();
        }
      });
    };
  }, []);

  const reFetchProduct = (id) => {
    axios.post(`/products/${id}/refetch`).then(() => {
      location.reload();
    }).catch((error) => {
      console.error('Failed to refetch product:', error);
    });
  };

  return (
    <div className="col-sm-3">
      <div className="card">
        <img src={product.image_url} alt={product.title} className="card-img-top" style={{ height: '100px', maxHeight: '100px', width: 'auto', objectFit: 'contain' }} />
        <div className="card-body">
          <h5 
            className="card-title product-title" 
            data-bs-toggle="tooltip" 
            data-bs-placement="top" 
            title={product.title} 
            style={{ whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis', position: 'relative'}}
          >
            {product.title}
          </h5>
          <p className="card-text">{product.description.length > 60 ? product.description.slice(0, 60) + '...' : product.description}</p>
          <div className='d-flex justify-content-between'>
            <p className="card-text"><strong>Price:</strong> ${product.price}</p>
            <p className="card-text"><strong>Size:</strong> {product.size}</p>
          </div>
          <p className="card-text"><strong>Category:</strong> {product.category.name}</p>
          {
            new Date(product.last_scraped_at) < new Date(Date.now() - 7 * 24 * 60 * 60 * 1000) ? (
              <a href="javascript:void(0)" className="btn btn-sm btn-danger" onClick={() => reFetchProduct(product.id)}>Refetch Or Update Product</a>
            ) : (
              ''
            )
          }
        </div>
      </div>
    </div>
  );
}

export default ProductCard;

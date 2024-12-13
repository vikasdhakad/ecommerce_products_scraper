import React, { useEffect, useState } from 'react';
import ProductCard from './ProductCard';
import axios from 'axios';

const ProductList = ({ products }) => {
  if (products.length === 0) {
    return <p>No products found</p>;
  }

  return (
    <div>
      <div className="row mt-4">
        {products.map((product) => (
          <ProductCard key={product.id} product={product} />
        ))}
      </div>
    </div>
  );
}

export default ProductList;

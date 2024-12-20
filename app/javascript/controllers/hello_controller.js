import { Controller } from "@hotwired/stimulus"

import React from 'react';
import { createRoot } from 'react-dom/client';
import App from '../components/App';

export default class extends Controller {
  connect() {
    const app = document.getElementById('app')
    createRoot(app).render(<App />)
  }
}

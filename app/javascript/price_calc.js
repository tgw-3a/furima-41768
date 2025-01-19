function price_calc() {
  if (document.getElementById('item-price') != null) {
    const priceInput = document.getElementById('item-price');

    priceInput.addEventListener('input', () => {
      const price = (priceInput.value);
      const priceFee = document.getElementById('add-tax-price');
      const priceProfit = document.getElementById('profit');

      let fee = Math.floor(price * 0.1);
      let profit = price - fee;

      priceFee.innerHTML = fee.toLocaleString();
      priceProfit.innerHTML = profit.toLocaleString();
    });
  };
};

window.document.addEventListener('turbo:load', price_calc);
window.document.addEventListener('turbo:render', price_calc);
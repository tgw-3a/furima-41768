let payjp = null;

const pay = () => {
  if (!payjp){
    const publicKey = gon.public_key
    payjp = Payjp(publicKey);
  };
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  const form = document.getElementById('charge-form');

  form.addEventListener("submit", (e) => {
    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
      } else {
        const token = response.id;
        const renderDom = document.getElementById("charge-form")
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }
      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();
      document.getElementById('charge-form').submit();
    });
    e.preventDefault();
  });
};

const order = () => {
  if (document.location.pathname.endsWith('/orders')) {
    pay();
  };
};

window.document.addEventListener("turbo:load", order);
window.document.addEventListener("turbo:render", order);
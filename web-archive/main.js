import "./style.css";

const years = [21, 22];

const months = [
  ["January", 31],
  ["February", 29],
  ["March", 31],
  ["April", 30],
  ["May", 31],
  ["June", 30],
  ["July", 31],
  ["August", 31],
  ["September", 30],
  ["October", 31],
  ["November", 30],
  ["December", 31],
];

for (let y of years) {
  let data ='';
  y === years[1] ? data = '' : data = 'data/';
  const x = document.querySelector(`#y${y}`);
  x.innerHTML = `<h2 class='text-xl mb-2'>20${y}</h2>`;
  let i = 1;
  for (let m of months) {
    let month = "";
    if (i < 10) {
      month = `0${i++}`;
    } else {
      month = `${i++}`;
    }
    let x1 = `<div class='clear-both'>
            <select name="20${y}-${m[0]}" 
            class='float-right form-select rounded  mb-2
            block border-0 border-b-4 border-gray-200 w-full
            focus:ring-0 focus:border-black'>`;
    x1 += `<option value="#">${m[0]}</option>`;
    let j = 1;
    for (let d = 1; d <= m[1]; d++) {
      let day = "";
      if (j < 10) {
        day = `0${j++}`;
      } else {
        day = `${d}`;
      }
      x1+= `<option data-bs-toggle="modal" data-bs-target="#exampleModal" value="https://www.outrageGIS.com/${data}weather/img/animation/${y}${month}${day}">${y}${month}${day}</option>`;
    }
    x1 += `</select></div>`;
    x.innerHTML += x1;
  }
}

const selection = document.querySelector('select')
  addEventListener('change', function(e) {
    window.open(e.target.value);
  })

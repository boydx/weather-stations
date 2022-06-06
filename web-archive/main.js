import "./style.css";

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
const years = [21, 22];


for (let y of years) {
  let data ='';
  y === years[1] ? data = '' : data = 'data/';
  const x = document.querySelector(`#y${y}`);
  x.innerHTML = `<h2>20${y}</h2>`;
  let i = 1;
  for (let m of months) {
    let month = "";
    if (i < 10) {
      month = `0${i++}`;
    } else {
      month = `${i++}`;
    }
    let x1 = `<div>${m[0]}: <select name="20${y}-${m[0]}" class=''>`;
    x1 += `<option value="#">Select day</option>`;
    let j = 1;
    for (let d = 1; d <= m[1]; d++) {
      let day = "";
      if (j < 10) {
        day = `0${j++}`;
      } else {
        day = `${d}`;
      }
      x1+= `<option value="https://www.outrageGIS.com/${data}weather/img/animation/${y}${month}${day}">${y}${month}${day}</option>`;
    }
    x1 += `</select></div>`;
    x.innerHTML += x1;
  }
  
}

document.querySelectorAll('select').forEach(x => {
  addEventListener('change', function(e) {
    console.log(e.target.value);
    window.open(e.target.value);
  })
})

// function MM_jumpMenu(targ, selObj, restore) {
//   //v3.0
//   eval(targ + ".location='" + selObj.options[selObj.selectedIndex].value + "'");
//   if (restore) selObj.selectedIndex = 0;
// }

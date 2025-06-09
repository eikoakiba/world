function get_mode() {
  let l = localStorage.getItem("mode")

  if (l == null) localStorage.setItem("mode", "white")

  return l
}

function white_mode() {
  document.body.style.background = "white"
  document.body.style.color = "black"
}

function dark_mode() {
  document.body.style.background = "black"
  document.body.style.color = "white"
  // document.body.style.textContent = "body { background: black; color:white; } pre {color: white;}"
}

function dark_mode_toggle() {
  if (get_mode() == "white") {
    dark_mode()
    localStorage.setItem("mode", "black")
    // document.body.style.textContent = "body { background: black; color:white; } pre {color: white;}"
  } else if (get_mode() == "black") {
    white_mode()
    localStorage.setItem("mode", "white")
  }
}

console.log(localStorage.getItem("mode"))
if (get_mode() == "white") {
  white_mode()
} else if (get_mode() == "black") {
  dark_mode()
}

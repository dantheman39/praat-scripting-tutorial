const menuImg = document.getElementById("menuImage");

menuImg.onclick = function() {
  const navDiv = document.getElementById("navDiv");
  if (navDiv.style.visibility === "hidden") {
    navDiv.style.visibility = "visible";
  } else {
    navDiv.style.visibility = "hidden";
  }
};

const grid = document.querySelector(".grid");
const baseUrl =
  "https://raw.githubusercontent.com/vimlinuz/wall-archive/refs/heads/main/";
const dataUrl =
  "https://raw.githubusercontent.com/vimlinuz/wall-archive/refs/heads/main/docs/generated.json";

const wallsPerPage = 10;
let offset = 0;
let walls;
let wallsCount;

async function getData() {
  return fetch(dataUrl)
    .then((response) => {
      return response.json();
    })
    .catch((err) => {
      throw new Error(`Failed to fetch wallpapers: ${err.status}`);
    });
}

function loadMore() {
  const end = Math.min(offset + wallsPerPage, wallsCount);
  let html = "";
  for (let i = offset; i < end; i++) {
    const link = baseUrl + walls[i];
    html += `
      <a href="${link}" target="_blank" rel="noopener noreferrer">
        <img src="${link}" alt="${link}" loading="lazy" decoding="async" />
      </a>`;
  }
  grid.insertAdjacentHTML("beforeend", html);
  offset = end;
}

function fillViewport() {
  loadMore();
  if (grid.getBoundingClientRect().height <= window.innerHeight && offset < wallsCount) {
    fillViewport();
  }
}

(async () => {
  getData()
    .then((data) => {
      walls = data.files;
      wallsCount = walls.length;
      fillViewport();
      window.addEventListener("scrollend", loadMore);
    })
    .catch((err) => {
      console.error(err);
      grid.style.cssText = "display: flex; justify-content: center;";
      grid.innerHTML = `<p style="color:#f55">Failed to load wallpapers.</p>`;
    });
})();

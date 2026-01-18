const map = new maplibregl.Map({
  container: 'map',
  style: "https://tiles.openfreemap.org/styles/liberty",
  center: [-0.1278, 51.5074], // London
  zoom: 13
});



map.on("load", () => {
    map.addSource("points", {
        type: "vector",
        tiles: [
            "http://localhost:8000/tiles/{z}/{x}/{y}.pbf"
        ],
        minzoom: 0,
        maxzoom: 14
    });

    map.addLayer({
    id: "points-layer",
    type: "circle",
    source: "points",
    "source-layer": "points",
    paint: {
        "circle-radius": [
        "interpolate",
        ["linear"],
        ["zoom"],
        0, 2,
        6, 3,
        10, 5
        ],
        "circle-color": "#5e63ffff",
        "circle-opacity": 0.6
    }
    });


});
map.on("click", "points-layer", (e) => {
  const f = e.features?.[0];
  if (!f) return;

  const km = (Number(f.properties.dist_m) / 1000).toFixed(2);

const lat = e.lngLat.lat.toFixed(6);
const lon = e.lngLat.lng.toFixed(6);

new maplibregl.Popup()
    .setLngLat(e.lngLat)
    .setHTML(`<b>Distance to center:</b> ${km} km<br/><b>ID:</b> ${f.properties.id}<br/><b>Lat:</b> ${lat}<br/><b>Lon:</b> ${lon}`)
    .addTo(map);
});
map.on("mouseenter", "points-layer", () => map.getCanvas().style.cursor = "pointer");
map.on("mouseleave", "points-layer", () => map.getCanvas().style.cursor = "");



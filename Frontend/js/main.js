window.addEventListener('DOMContentLoaded', (event) => {
    getVisitCOunt();
})

const funtionApi = "";

const getVisitCOunt = () => {
    let count = 30;
    fetch(funtionApi).then((response) => {
        return response.json();
    }).then((response) => {
        count = response.count;
        document.getElementById("counter").innerText = count;
    }).catch((error) => {
        console.log(error);
    });
}
return count;
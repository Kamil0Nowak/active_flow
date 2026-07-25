// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

Turbo.setConfirmMethod((message, element) => {
    const dialog = document.getElementById("turbo-confirm")
    const messageEl = document.getElementById("turbo-confirm-message")

    if (messageEl) {
        messageEl.textContent = message
    }

    dialog.showModal()

    return new Promise((resolve) => {
        dialog.addEventListener("close", () => resolve(dialog.returnValue === "confirm"))
    }, { once: true } )
})
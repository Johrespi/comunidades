import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  
    
    static targets = ["form"]

    connect() {
    
    }

    confirmSubmission(){
        const confirmed = window.confirm("Estás seguro de que deseas crear esta comunidad?")
        if(!confirmed){
            event.preventDefault();
        }
    }

    confirmSubmissionEvent(){
        const confirmed = window.confirm("Estás seguro de que deseas crear este evento?")
        if(!confirmed){
            event.preventDefault();
        }
    }
}
import { LightningElement, api } from 'lwc';

export default class ScoreInformation extends LightningElement {
//api decorator
    @api score;
    @api attemptId;
    @api numberOfQuestions;

    get numberOfQuestionsCorrect(){
        return Math.floor((this.score/100)) * this.numberOfQuestions;
    }

    get numberOfQuestionsIncorrect(){
        return this.numberOfQuestions - this.numberOfQuestionsCorrect;
    }

    handleDeleteAttempt(){
        const deleteEvent = new CustomEvent('deleteattempt', {
            detail: this.attemptId
        });
        //deleteattempt will be referenced in parent file where c tags are 
        //dispatch function sends event up to parent
        this.dispatchEvent(deleteEvent);
    }
}
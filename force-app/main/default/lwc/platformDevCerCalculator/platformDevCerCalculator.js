import { LightningElement, track } from 'lwc';
const devFundWeight =  0.23;
const processAutoWeight = 0.30;
const userIntWeight = 0.25;
const testDebugWeight = 0.22;
const passingScore = 68;
//variables that dont change - used as global variables outside of main class

export default class PlatformDevCerCalculator extends LightningElement {

    devFundamentalScore = 50;
    processAutomationScore = 50;
    userInterfaceScore = 50;
    testingScore = 50;

    certificationScore = 90;
    numberOfQuestions = 60;

    showResource = false;
    showGoodJob = false;

    @track attemptHistory=[
        {Id: 1, Score:50},
        {Id: 2, Score:68},
        {Id: 3, Score:70},
        {Id: 4, Score:90},
    ];

    //only local variables use this keyword 

    calculateScore(){
        let devFundWeightScore = this.devFundamentalScore * devFundWeight;
        let processAutoWeightScore = this.processAutomationScore * processAutoWeight;
        let userIntWeightScore = this.userInterfaceScore * userIntWeight;
        let testDebugWeightScore = this.testingScore * testDebugWeight;

        this.certificationScore = devFundWeightScore + processAutoWeightScore + userIntWeightScore + testDebugWeightScore;
        
        this.showResourceIfFailed();
        this.addAttemptHistory(this.certificationScore);

    }

    handleChange(event){
        console.log(event);
        console.log(event.target); 
        let value = Number(event.target.value); // convert value you enter into a number so javascript knows its not a string
        const inputName = event.target.name; // the input name you are currently on 
        if(inputName === "devFundamentals"){
            this.devFundamentalScore = value; //the value you enter into that input name
        } else if(inputName === "processAuto"){
            this.processAutomationScore = value;
        } else if(inputName === "userInterface"){
            this.userInterfaceScore = value;
        } else if(inputName === "testDebugDeploy"){
            this.testingScore = value;
        }
    }

//method to make resources section condionally visible
    showResourceIfFailed(){
        if(this.certificationScore < passingScore){
            this.showResource = true;
        }else {
            this.showResource = false;
        }
        this.showGoodJob = !this.showResource
    }

    addAttemptHistory(score){
        const attempt = 
            {
                Id: this.attemptHistory.length + 1, Score:score
            }
            //unique Id above
        this.attemptHistory = [...this.attemptHistory, attempt] // ... spread operator - takes everything in object expanded, and then add the original attempt inside
    }

}
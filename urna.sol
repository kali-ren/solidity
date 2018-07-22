pragma solidity ^0.4.18;

/* backend para o projeto de monografia */ 

contract Hellomundo {
    
    struct Eleitor{
        uint id;
        address carteiraEleitor;
        bool votou;
    }
    //["0x72656e616e",'0x66696c697065']
    Eleitor[] eleitores;
    mapping (address => uint) mapa;
    
    mapping (bytes32 => uint8) votesReceived;
    bytes32[] candidateList;
    
    constructor(bytes32[] candidateNames) public {
        candidateList = candidateNames;
    }
    
    function totalVotesFor(bytes32 candidate) public view returns (uint8) {
        require(_validCandidate(candidate));
        return votesReceived[candidate];
  }    
    
    function voteForCandidate(bytes32 candidate) public {
        require(_validCandidate(candidate));
        uint index = mapa[msg.sender] - 1;
        if(eleitorValido(msg.sender) > 0 && eleitores[index].votou == false){
            votesReceived[candidate] += 1;
            eleitores[index].votou = true;	
        }    
    }
    
    function _validCandidate(bytes32 _candidate) private returns (bool) {
        for(uint i = 0; i < candidateList.length; i++) {
            if(candidateList[i] == _candidate) {
                return true;
            }
        }
        return false;
    }        
    
    function addEleitor(uint _id, address _carteiraEleitor) public{
        if(_adminValidation(msg.sender) && mapa[_carteiraEleitor]==0){
            uint index = eleitores.push(Eleitor(_id,_carteiraEleitor,false));
            mapa[_carteiraEleitor] = index;
        }
    }
    
    function eleitorValido(address _carteiraEleitor) public view returns (uint){//eleitor valido
        uint index = mapa[_carteiraEleitor] - 1;
        if(mapa[_carteiraEleitor] > 0 && eleitores[index].votou == false)
            return mapa[_carteiraEleitor];
        return 0;
    }
    
    function arraySize() public view returns (uint){
        return eleitores.length;
    }
    
    function mapaElemento(address _discoInferno) public view returns (uint){
        return mapa[_discoInferno];
    } 
    
    function _tamanho() private returns (uint){
        return eleitores.length;
    }
    
    function _adminValidation(address carteiraAdmin) private pure returns (bool){
        if(carteiraAdmin == 0xca35b7d915458ef540ade6068dfe2f44e8fa733c){
            return true;
        }
        return false;
    } 
}

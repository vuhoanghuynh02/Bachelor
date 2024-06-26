# multiAgents.py
# --------------
# Licensing Information:  You are free to use or extend these projects for
# educational purposes provided that (1) you do not distribute or publish
# solutions, (2) you retain this notice, and (3) you provide clear
# attribution to UC Berkeley, including a link to http://ai.berkeley.edu.
# 
# Attribution Information: The Pacman AI projects were developed at UC Berkeley.
# The core projects and autograders were primarily created by John DeNero
# (denero@cs.berkeley.edu) and Dan Klein (klein@cs.berkeley.edu).
# Student side autograding was added by Brad Miller, Nick Hay, and
# Pieter Abbeel (pabbeel@cs.berkeley.edu).


from util import manhattanDistance
from game import Directions
import random, util

from game import Agent

class ReflexAgent(Agent):
    """
    A reflex agent chooses an action at each choice point by examining
    its alternatives via a state evaluation function.

    The code below is provided as a guide.  You are welcome to change
    it in any way you see fit, so long as you don't touch our method
    headers.
    """


    def getAction(self, gameState):
        """
        You do not need to change this method, but you're welcome to.

        getAction chooses among the best options according to the evaluation function.

        Just like in the previous project, getAction takes a GameState and returns
        some Directions.X for some X in the set {NORTH, SOUTH, WEST, EAST, STOP}
        """
        # Collect legal moves and successor states
        legalMoves = gameState.getLegalActions()

        # Choose one of the best actions
        scores = [self.evaluationFunction(gameState, action) for action in legalMoves]
        bestScore = max(scores)
        bestIndices = [index for index in range(len(scores)) if scores[index] == bestScore]
        chosenIndex = random.choice(bestIndices) # Pick randomly among the best

        "Add more of your code here if you want to"

        return legalMoves[chosenIndex]

    def evaluationFunction(self, currentGameState, action):
        """
        Design a better evaluation function here.

        The evaluation function takes in the current and proposed successor
        GameStates (pacman.py) and returns a number, where higher numbers are better.

        The code below extracts some useful information from the state, like the
        remaining food (newFood) and Pacman position after moving (newPos).
        newScaredTimes holds the number of moves that each ghost will remain
        scared because of Pacman having eaten a power pellet.

        Print out these variables to see what you're getting, then combine them
        to create a masterful evaluation function.
        """
        # Useful information you can extract from a GameState (pacman.py)
        successorGameState = currentGameState.generatePacmanSuccessor(action)
        newPos = successorGameState.getPacmanPosition()
        newFood = successorGameState.getFood()
        newGhostStates = successorGameState.getGhostStates()
        newScaredTimes = [ghostState.scaredTimer for ghostState in newGhostStates]

        "*** YOUR CODE HERE ***"

        return betterEvaluationFunction(successorGameState)



def scoreEvaluationFunction(currentGameState):
    """
    This default evaluation function just returns the score of the state.
    The score is the same one displayed in the Pacman GUI.

    This evaluation function is meant for use with adversarial search agents
    (not reflex agents).
    """
    return currentGameState.getScore()

class MultiAgentSearchAgent(Agent):
    """
    This class provides some common elements to all of your
    multi-agent searchers.  Any methods defined here will be available
    to the MinimaxPacmanAgent, AlphaBetaPacmanAgent & ExpectimaxPacmanAgent.

    You *do not* need to make any changes here, but you can if you want to
    add functionality to all your adversarial search agents.  Please do not
    remove anything, however.

    Note: this is an abstract class: one that should not be instantiated.  It's
    only partially specified, and designed to be extended.  Agent (game.py)
    is another abstract class.
    """

    def __init__(self, evalFn = 'betterEvaluationFunction', depth = '2'):
        self.index = 0 # Pacman is always agent index 0
        self.evaluationFunction = util.lookup(evalFn, globals())
        self.depth = int(depth)

class MinimaxAgent(MultiAgentSearchAgent):
    """
    Your minimax agent (question 2)
    """

    def getAction(self, gameState):
        """
        Returns the minimax action from the current gameState using self.depth
        and self.evaluationFunction.

        Here are some method calls that might be useful when implementing minimax.

        gameState.getLegalActions(agentIndex):
        Returns a list of legal actions for an agent
        agentIndex=0 means Pacman, ghosts are >= 1

        gameState.generateSuccessor(agentIndex, action):
        Returns the successor game state after an agent takes an action

        gameState.getNumAgents():
        Returns the total number of agents in the game

        gameState.isWin():
        Returns whether or not the game state is a winning state

        gameState.isLose():
        Returns whether or not the game state is a losing state
        """
        "*** YOUR CODE HERE ***"
        #util.raiseNotDefined()

        def minimax_search(state, agentIndex, depth):
            # if in min layer and last ghost
            if agentIndex == state.getNumAgents():
                # if reached max depth, evaluate state
                if depth == self.depth:
                    return self.evaluationFunction(state)
                # otherwise start new max layer with bigger depth
                else:
                    return minimax_search(state, 0, depth + 1)
            # if not min layer and last ghost
            else:
                moves = state.getLegalActions(agentIndex)
                # if nothing can be done, evaluate the state
                if len(moves) == 0:
                    return self.evaluationFunction(state)
                # get all the minimax values for the next layer with each node being a possible state after a move
                next = (minimax_search(state.generateSuccessor(agentIndex, m), agentIndex + 1, depth) for m in moves)

                # if max layer, return max of layer below
                if agentIndex == 0:
                    return max(next)
                # if min layer, return min of layer below
                else:
                    return min(next)
        # select the action with the greatest minimax value
        result = max(gameState.getLegalActions(0), key=lambda x: minimax_search(gameState.generateSuccessor(0, x), 1, 1))

        return result        

class AlphaBetaAgent(MultiAgentSearchAgent):
    """
    Your minimax agent with alpha-beta pruning (question 3)
    """

    def getAction(self, gameState):
        """
        Returns the minimax action using self.depth and self.evaluationFunction
        """
        "*** YOUR CODE HERE ***"
        # util.raiseNotDefined()
        
        from random import shuffle
        def alphabeta(state):
            bestValue = float('-inf')
            bestAction = None
            shuffled_actions = state.getLegalActions(0)
            shuffle(shuffled_actions)
            print(shuffled_actions)
            value = []
            for action in shuffled_actions:
                succ = minValue(state.generateSuccessor(0, action), 1, 1, bestValue, float('inf'))
                value.append(succ)
                if bestAction is None or succ > bestValue:
                    bestValue = succ
                    bestAction = action
            print(value)
            return bestAction

        def minValue(state, agentIdx, depth, alpha, beta):
            if agentIdx == state.getNumAgents():
                if depth == self.depth:
                    return self.evaluationFunction(state)
                else:
                    return maxValue(state, 0, depth + 1, alpha, beta)
            value = float('inf')
            shuffled_actions = state.getLegalActions(agentIdx)
            shuffle(shuffled_actions)
            for action in shuffled_actions:
                succ = minValue(state.generateSuccessor(agentIdx, action), agentIdx + 1, depth, alpha, beta)
                value = min(value, succ)
                if value <= alpha:
                    return value
                beta = min(beta, value)

            if value != float('inf'):
                return value
            else:
                return self.evaluationFunction(state)


        def maxValue(state, agentIdx, depth, alpha, beta):
            value = float('-inf')
            shuffled_actions = state.getLegalActions(agentIdx)
            shuffle(shuffled_actions)
            for action in shuffled_actions:
                succ = minValue(state.generateSuccessor(agentIdx, action), agentIdx + 1, depth, alpha, beta)
                value = max(value, succ)
                if value >= beta:
                    return value
                alpha = max(alpha, value)
                
            if value != float('-inf'):
                return value
            else:
                return self.evaluationFunction(state)

        action = alphabeta(gameState)

        return action



class ExpectimaxAgent(MultiAgentSearchAgent):
    """
      Your expectimax agent (question 4)
    """

    def getAction(self, gameState):
        """
        Returns the expectimax action using self.depth and self.evaluationFunction

        All ghosts should be modeled as choosing uniformly at random from their
        legal moves.
        """
        "*** YOUR CODE HERE ***"
        # util.raiseNotDefined()
        
        from statistics import mean
        def expectimax_search(state, agentIndex, depth):
            # if in mean layer and last ghost
            if agentIndex == state.getNumAgents():
                # if reached max depth, evaluate state
                if depth == self.depth:
                    return self.evaluationFunction(state)
                # otherwise start new max layer with bigger depth
                else:
                    return expectimax_search(state, 0, depth + 1)
            # if not mean layer and last ghost
            else:
                moves = state.getLegalActions(agentIndex)
                # if nothing can be done, evaluate the state
                if len(moves) == 0:
                    return self.evaluationFunction(state)
                # get all the expectimax values for the next layer with each node being a possible state after a move
                next = (expectimax_search(state.generateSuccessor(agentIndex, m), agentIndex + 1, depth) for m in moves)

                # if max layer, return max of layer below
                if agentIndex == 0:
                    return max(next)
                # if mean layer, return mean of layer below
                else:
                    return mean(next)
        # select the action with the greatest expectimax value
        result = max(gameState.getLegalActions(0), key=lambda x: expectimax_search(gameState.generateSuccessor(0, x), 1, 1))

        return result        

def betterEvaluationFunction(currentGameState):
    """
    Your extreme ghost-hunting, pellet-nabbing, food-gobbling, unstoppable
    evaluation function (question 5).

    DESCRIPTION: <write something here so we know what you did>
    """
    "*** YOUR CODE HERE ***"
    #util.raiseNotDefined()

    BIG = 1 << 31
    SMALL = 1 / BIG
    newPos = currentGameState.getPacmanPosition()
    newFood = currentGameState.getFood()
    newGhostStates = currentGameState.getGhostStates()
    newCapsules = currentGameState.getCapsules()
    newScaredTimes = [ghostState.scaredTimer for ghostState in newGhostStates]
    
    firstClosestGhost = BIG
    secondClosestGhost = BIG
    thirdClosestGhost = BIG
    for ghost in newGhostStates:
        if ghost.getPosition() == tuple(newPos) and (ghost.scaredTimer == 0):
            return float('-inf')
        elif ghost.scaredTimer > 2:
            distance = manhattanDistance(newPos, ghost.getPosition())
            if distance < firstClosestGhost:
                thirdClosestGhost = secondClosestGhost
                secondClosestGhost = firstClosestGhost
                firstClosestGhost = distance
            elif distance < secondClosestGhost:
                thirdClosestGhost = secondClosestGhost
                secondClosestGhost = distance
            elif distance < thirdClosestGhost:
                thirdClosestGhost = distance
    firstClosestGhost = BIG / (firstClosestGhost + SMALL)
    secondClosestGhost = BIG / (secondClosestGhost + SMALL)
    thirdClosestGhost = BIG / (thirdClosestGhost + SMALL)

    foodList = newFood.asList() + list(newCapsules)
    firstClosestFood = BIG
    secondClosestFood = BIG
    thirdClosestFood = BIG
    for food in foodList:
        distance = manhattanDistance(newPos, food)
        if distance < firstClosestFood:
            thirdClosestFood = secondClosestFood
            secondClosestFood = firstClosestFood
            firstClosestFood = distance
        elif distance < secondClosestFood:
            thirdClosestFood = secondClosestFood
            secondClosestFood = distance
        elif distance < thirdClosestFood:
            thirdClosestFood = distance
    firstClosestFood = BIG / (firstClosestFood + SMALL)
    secondClosestFood = BIG / (secondClosestFood + SMALL)
    thirdClosestFood = BIG / (thirdClosestFood + SMALL)

    score = currentGameState.getScore() * BIG
    numFood = (BIG - len(foodList)) * BIG
    foodDistance = 0.6 * firstClosestFood + 0.3 * secondClosestFood + 0.1 * thirdClosestFood
    ghostDistance = 0.6 * firstClosestGhost + 0.3 * secondClosestGhost + 0.1 * thirdClosestGhost
    ghostDistance *= - 2
    foodDistance *= 1
    return score + ghostDistance + foodDistance + numFood

# Abbreviation
better = betterEvaluationFunction

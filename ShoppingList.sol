// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ShoppingList {
    // State variable to keep track of the number of tasks
    uint public taskCount;

    // Structure to define a Task
    struct Item {
        uint id;          // Unique identifier for the task
        string content;   // Description of the task
        bool completed;   // Status of the task (completed or not)
    }

    // Mapping to store tasks with their unique ID
    mapping(uint => Item) public items;

    // Events for task creation and completion
    event ItemAdded(uint id, string content, bool completed);
    event ItemBuyed(uint id, bool completed);

    // Constructor to initialize the contract
    constructor() {
        ADDItem("Shopping List");
    }

    // Function to create a new task
    function ADDItem(string memory _content) public {
        require(bytes(_content).length > 0, "content cannot be empty"); // Ensure task content is not empty
        taskCount++;
        items[taskCount] = Item(taskCount, _content, false);
        emit ItemAdded(taskCount, _content, false);
    }

    // Function to toggle the completion status of a task
    function toggleCompleted(uint _id) public {
        // Ensure valid task ID
        require(_id > 0 && _id <= taskCount, "Invalid task ID.");

        // Use 'storage' to modify the original task
        Item storage taskToUpdate = items[_id];

        // Toggle completion status
        taskToUpdate.completed = !taskToUpdate.completed;

        // Emit completion event
        emit ItemBuyed(_id, taskToUpdate.completed);
        taskCount--;
    }
}
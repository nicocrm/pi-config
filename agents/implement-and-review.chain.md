---
name: implement-and-review
description: Worker implements plan with layered commits, reviewer reviews, worker applies feedback
---

## worker
skills: executing-plans+test-driven-development+verification-before-completion

Implement the plan: {task}. Read the plan first, then for each task: implement, test, verify, and commit with a descriptive message before moving to the next task. Report a detailed summary of every change you made.

## reviewer
skills: requesting-code-review

Review the following implementation and provide detailed feedback on code quality, correctness, completeness, and any issues:

{previous}

## worker
skills: receiving-code-review+verification-before-completion

Apply the following code review feedback. Commit each fix separately with a descriptive message. Report what you updated:

{previous}

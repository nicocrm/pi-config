---
name: implement-and-review
description: Worker implements plan with layered commits, reviewer reviews, worker applies feedback
---

## worker
skills: executing-plans, test-driven-development, verification-before-completion

Implement the plan: {task}. Read the plan first, then for each task: implement, test, verify, and commit with a descriptive message before moving to the next task. Report a detailed summary of every change you made.

When you finish successfully, end your final message with a line containing exactly:

CHAIN_STEP_COMPLETE

If you are unable to complete the work (plan unreadable, blocked by an external dependency, repeated tool failures, etc.), end your final message with a line containing exactly:

CHAIN_ABORTED: <short reason>

## reviewer
skills: requesting-code-review

Before reviewing, inspect the previous step's output below. If it is empty, or does not contain the marker `CHAIN_STEP_COMPLETE`, or contains a line starting with `CHAIN_ABORTED:`, do NOT invent work to review. Instead respond with exactly:

CHAIN_ABORTED: no valid implementation summary from previous step

and stop. Do not read files, do not run tools, do not speculate about what might have been implemented.

Otherwise, review the implementation and provide detailed feedback on code quality, correctness, completeness, and any issues. End your final message with a line containing exactly:

CHAIN_STEP_COMPLETE

Previous step output:

{previous}

## worker
skills: receiving-code-review, verification-before-completion

Before acting, inspect the previous step's output below. If it contains a line starting with `CHAIN_ABORTED:`, or does not contain `CHAIN_STEP_COMPLETE`, do NOT make any changes. Respond with exactly:

CHAIN_ABORTED: upstream step did not complete, skipping feedback application

and stop.

Otherwise, apply the review feedback. Commit each fix separately with a descriptive message. Report what you updated, and end your final message with a line containing exactly:

CHAIN_STEP_COMPLETE

Previous step output:

{previous}

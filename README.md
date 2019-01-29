# dafni-starter

A minimal starter repo for data analysis for neuroimaging class (c84dan) at the University of Nottingham.

## Exercises

### A. First interactions with ``git`` and ``github``

1. Open the file ``2019-01-16-notes.md`` up in your text editor of choice and make some changes

2. Try out a basic a basic cycle of, keeping in mind that tab-completion works if things have been set up correctly (no need to type everything out fully...)
```bash
# made some changes to text file
git status
git add 2019-01-16-notes.md
git commit -m 'some message for log'
git status
git log
```

### B. Jot down notes on ``matlab`` code for next session (a new file!)

Make a new file and add it to the repository. To get started, let's just stick to simple text files with some comments in. I like writing  **markdown**, but if you can't be bothered with the syntax highlighting, just stick to simple text. Let's do a simple plan / brain storming for how we are going to write some ``matlab`` code in the next 3 sessions:

- create a file called ``matlab-plans.md`` in your favourite editor

- check out the fact that this also works: 😀 🐵 💤   (compare ``more`` and ``cat`` in the terminal app)

- write down a list of things you'll need to know/find out so your matlab code can read in some image data from the scanner

- for matlab session 1, we just want to read ``nifti`` files and inspect them. Jot down some ideas.

- what are the commands you need to **add** this new file to the staging area? Has the change been **committed** yet? If not, what do you need to do? And how can you check?

- how can you send local changes in your repository to sync it up to the repo to ``github.com``?

<details><summary>Hint 1 - the add/commit loop</summary><p>

Remember that we need to **add** the file to the staging area and then **commit** it into the repo with a message.
</p></details>

<details><summary>Solution</summary><p>

<pre>
<code>
# assuming matlab-plans.md
git add matlab-plans.md
git status # check, optional!
git commit -m 'adds new file with the battle plan'
# look at git messages on command prompt
</code>
</pre>

</p></details>

### C. Modify your notes.

- edit ``matlab-plans.md`` in your favourite editor. You can add some details about how we'll read in the data
- you just learnt that the functions you'll use to read the image data are part of a matlab toolbox called ``mrTools`` - we'll be using ``mlrImageReadNifti()``
- if you are using markdown, you can also try adding a note that has a code snippet (remember - you can start a code block with three `` ` `` marks in a row - and end it the same way).
```matlab
addpath(genpath("/Volumes/practicals/ds1/mrTools/")) % to add path for mrTools
```
- now record this change as a new commit. Then push it to the remote repo on ``github.com``


### D. A new branch

Next, we'll try to work on a change / new feature on our notes without disturbing the status quo of what we currently have. This is best done my creating a new **branch**.

```bash
# make sure we are in the current
git checkout -b new-thing
# look at command prompt and
git status
# do some editing, then e.g. add a new file
echo -e "# new things\n\nSome material for my new file" > more-notes.md
git status
git add more-notes.md
git commit -m 'adds new file starter'
```

-  What happens if we try to ``git push`` this change? Do you understand the message you can see in the Terminal?

- How can you switch back to the original (``master``) branch?
- How can you bring in the changes you made on the ``new-thing`` branch into the main working branch?

<details><summary>Solution</summary><p>

<pre>
<code>
# for switching branches
git checkout master
ls
git checkout new-thing
# for getting changes into MASTER branch
# first switch to the branch where you want to end up
git checkout master
git merge new-thing   # and merge in changes from elsewhere
# git will work out if there are clashes or if
# it can automatically merge
</code>
</pre>

</p></details>

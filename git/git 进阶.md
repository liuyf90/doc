

## git 进阶

​																																								**刘宇飞 整理**



在工作中发现了大量的GIT使用问题,我觉得不仅仅是态度问题,可能是技能问题,头脑中没有建立正确的GIT提交模型,乱用、瞎试的现象大量存在.我今天不给大家讲操作,基本的clone、push、commit语句在网上一搜一大把,我讲这个的目的是让你们在头脑中建立模型,为此我结合网上的资料,做了大量的图例来讲清楚.



可以说掌握今天这几个用法,80%的git场景就覆盖了.

### 1. git commit

Git 仓库中的提交记录保存的是你的目录下所有文件的快照，就像是把整个目录复制，然后再粘贴一样，但比复制粘贴优雅许多！

Git 希望提交记录尽可能地轻量，因此在你每次进行提交时，它并不会盲目地复制整个目录。条件允许的情况下，它会将当前版本与仓库中的上一个版本进行对比，并把所有的差异打包到一起作为一个提交记录。

Git 还保存了提交的历史记录。这也是为什么大多数提交记录的上面都有父节点的原因 —— 我们会在图示中用箭头来表示这种关系。对于项目组的成员来说，维护提交历史对大家都有好处。

关于提交记录太深入的东西咱们就不再继续探讨了，现在你可以把提交记录看作是项目的快照。提交记录非常轻量，可以快速地在这些提交记录之间切换！



![image-20200102095008639](https://tva1.sinaimg.cn/large/006tNbRwly1gaiin7nacrj305a02yq2v.jpg)

​				 

```
git commit -m "init"
```



![image-20200102100132557](https://tva1.sinaimg.cn/large/006tNbRwly1gaiinbq963j305e04z747.jpg)



### 2. git branch

Git 的分支也非常轻量。它们只是简单地指向某个提交纪录 —— 仅此而已。所以许多 Git 爱好者传颂：

**早建分支！多用分支！**


这是因为即使创建再多分的支也不会造成储存或内存上的开销，并且按逻辑分解工作到不同的分支要比维护那些特别臃肿的分支简单多了。

在将分支和提交记录结合起来后，我们会看到两者如何协作。现在只要记住使用分支其实就相当于在说：“我想基于这个提交以及它所有的父提交进行新的工作。”

![image-20200102095008639](https://tva1.sinaimg.cn/large/006tNbRwly1gaiineiy3vj305a02yq2v.jpg)

```
git branch newImage
```
![branch1](https://tva1.sinaimg.cn/large/006tNbRwly1gaiio46riaj305a02yjr9.jpg)



```
git commit
```

![branch2](https://tva1.sinaimg.cn/large/006tNbRwly1gaiio2stmzj305m0503yg.jpg)

* **注意**:

  哎呀！为什么 `master` 分支前进了，但 `newImage` 分支还待在原地呢？！这是因为我们没有“在”这个新分支上，看到 `master` 分支上的那个星号（*）了吗？这表示当前所在的分支是 `master`。

```
git checkout newImage
git commit
```

![branch3](https://tva1.sinaimg.cn/large/006tNbRwly1gaiinthao3j305a02zq2t.jpg)

---

![branch4](https://tva1.sinaimg.cn/large/006tNbRwly1gaiintw1fwj305v04zdfs.jpg)



有个更简洁的方式：如果你想创建一个新的分支同时切换到新创建的分支的话，可以通过以下来实现。
```
git checkout -b <your branchName> 
```


* 思考:

  ```
  git checkout c1
  ```

  **允许吗? checkout某一个提交记录(Hash)中.**

  

### 3.Git merge

好了! 我们已经知道如何提交以及如何使用分支了。接下来咱们看看如何将两个分支合并到一起。就是说我们新建一个分支，在其上开发某个新功能，开发完成后再合并回主线。

咱们先来看一下第一种方法 —— `git merge`。在 Git 中合并两个分支时会产生一个特殊的提交记录，它有两个父节点。翻译成自然语言相当于：“我要把这两个父节点本身及它们所有的祖先都包含进来。”

<u>*我准备了两个分支，每个分支上各有一个独有的提交。这意味着没有一个分支包含了我们修改的所有内容。咱们通过合并这两个分支来解决这个问题。我们要把 `bugFix` 合并到 `master` 里*</u>

![merge1](https://tva1.sinaimg.cn/large/006tNbRwly1gaiinrzz6lj30gg05ogln.jpg)



```
git merge bugFix
```

![merge2](https://tva1.sinaimg.cn/large/006tNbRwly1gaiio1u3fjj30gi093aa7.jpg)

首先，`master` 现在指向了一个拥有两个父节点的提交记录。假如从 `master` 开始沿着箭头向上看，在到达起点的路上会经过所有的提交记录。这意味着 `master`包含了对代码库的所有修改。 

* 思考:

  ```
  git checkout bugFix; git merge master;
  ```

  <i><u>因为 `master` 继承自 `bugFix`，Git 什么都不用做，只是简单地把 `bugFix` 移动到 `master` 所指向的那个提交记录。</u></i>

### 4. git rebase

第二种合并分支的方法是 `git rebase`。Rebase 实际上就是取出一系列的提交记录，“复制”它们，然后在另外一个地方逐个的放下去。

Rebase 的优势就是可以创造更线性的提交历史，这听上去有些难以理解。如果只允许使用 Rebase 的话，代码库的提交历史将会变得异常清晰。

![rebase1](https://tva1.sinaimg.cn/large/006tNbRwly1gaiio0hcgfj30gd05oq2z.jpg)

```
git rebase master
```

![rebase2](https://tva1.sinaimg.cn/large/006tNbRwly1gaiio4o1v2j30cg08adfx.jpg)

现在 bugFix 分支上的工作在 master 的最顶端，同时我们也得到了一个更线性的提交序列。

注意，提交记录 C3 依然存在（树上那个半透明的节点），而 C3' 是我们 Rebase 到 master 分支上的 C3 的副本。

* 思考:

  ```
  git checkout master; git commit
  ```

  结果是?

  

  那怎么更新master?

  ```
  git checkout master; git rebase bugFix
  ```

  ![rebase3](https://tva1.sinaimg.cn/large/006tNbRwly1gaiio1e5tmj308d08amx7.jpg)

  <i>由于 `bugFix` 继承自 `master`，所以 Git 只是简单的把 `master` 分支的引用向前移动了一下而已。</i>

  

### 5. 分离HEAD

回顾一下第二节的思考问题.答案是可行.

我们首先看一下 “HEAD”。 HEAD 是一个对当前检出记录的符号引用 —— 也就是指向你正在其基础上进行工作的提交记录。

HEAD 总是指向当前分支上最近一次提交记录。大多数修改提交树的 Git 命令都是从改变 HEAD 的指向开始的。

HEAD 通常情况下是指向分支名的（如 bugFix）。在你提交时，改变了 bugFix 的状态，这一变化通过 HEAD 变得可见。

![image-20200102095008639](https://tva1.sinaimg.cn/large/006tNbRwly1gaiinzi309j305a02ywef.jpg)

```
git checkout c1; git checkout master; git commit; git checkout c2;
```

![HEAD1](https://tva1.sinaimg.cn/large/006tNbRwly1gaiinsyoxlj30yk05jwex.jpg)

<u><i>如果想看 HEAD 指向，可以通过 `cat .git/HEAD` 查看， 如果 HEAD 指向的是一个引用，还可以用 `git symbolic-ref HEAD` 查看它的指向。</i></u>

分离的 HEAD 就是让其指向了某个具体的提交记录而不是分支名。在命令执行之前的状态如下所示：

HEAD -> master -> C1

HEAD 指向 master， master 指向 C1

```
git checkout c1
```

现在变成了

HEAD -> C1

```
C1在真实的GIt中是以哈希值存储的,哈希值在真实的 Git 世界中也会更长（基于 SHA-1，共 40 位）。C1的提交记录的哈希值可能是 fed2da64c0efc5293610bdd892f82a58e8cbc5d8。
比较令人欣慰的是，Git 对哈希的处理很智能。你只需要提供能够唯一标识提交记录的前几个字符即可。因此我可以仅输入fed2 而不是上面的一长串字符。
```

### 6. 相对引用1

通过指定提交记录哈希值的方式在 Git 中移动不太方便。在实际应用时你就不得不用 `git log` 来查查看提交记录的哈希值,而采用相对引用则非常给力，这里介绍两个简单的用法：

- 使用 `^` 向上移动 1 个提交记录
- 使用 `~` 向上移动多个提交记录，如 `~3`

![move1](https://tva1.sinaimg.cn/large/006tNbRwly1gaiio02u3qj304z05bdfq.jpg)

*<u>首先看看操作符 (^)。把这个符号加在引用名称的后面，表示让 Git 寻找指定提交记录的父提交。</u>*

*<u>所以 `master^` 相当于“`master` 的父节点”。</u>*

*<u>`master^^` 是 `master` 的第二个父节点</u>*

*现在咱们切换到 master 的父节点*

```
git checkout master^
```

![move2](https://tva1.sinaimg.cn/large/006tNbRwly1gaiinxd98cj309g05b748.jpg)

---
**再看一个例子**:

![move3](https://tva1.sinaimg.cn/large/006tNbRwly1gaiio2g8jdj306507xwef.jpg)

```
git checkout c3;git checkout HEAD^;git checkout HEAD^;git checkout HEAD^
```

![HEAD2](https://tva1.sinaimg.cn/large/006tNbRwly1gaiinz3saqj317b098t9j.jpg)



**思考:  下面可行吗?**

```
git checkout master^
```

###   7. 相对引用2

如果你想在提交树中向上移动很多步的话，敲那么多 `^` 貌似也挺烦人的，Git 当然也考虑到了这一点，于是又引入了操作符 `~`。

用 `~` 一次后退四步。

![move4](https://tva1.sinaimg.cn/large/006tNbRwly1gaiio0z5k3j306b0akmx5.jpg)

```
git checkout HEAD~4
```

![move5](https://tva1.sinaimg.cn/large/006tNbRwly1gaiinudgjtj306s0bhgln.jpg)

**强制移动分支的位置**

我使用相对引用最多的就是移动分支。可以直接使用 `-f` 选项让分支指向另一个提交。例如:

![move6](https://tva1.sinaimg.cn/large/006tNbRwly1gaiiny580ij306b0ak74a.jpg)

```
git branch -f bugFix HEAD~3
```

![move7](https://tva1.sinaimg.cn/large/006tNbRwly1gaiinsihx9j306s0akmx7.jpg)

**思考:  下面可行吗?**

```
git branch -f bugFix master ~3
```



### 8. 撤销变更

在 Git 里撤销变更的方法很多。和提交一样，撤销变更由底层部分（暂存区的独立文件或者片段）和上层部分（变更到底是通过哪种方式被撤销的）组成。我们主要关注的是后者。

主要有两种方法用来撤销变更 —— 一是 `git reset`，还有就是 `git revert`。接下来逐个进行讲解。

![reset](https://tva1.sinaimg.cn/large/006tNbRwly1gaiinykyahj306305bdfq.jpg)

```
git reset HEAD~1
```

![reset2](https://tva1.sinaimg.cn/large/006tNbRwly1gaiio38219j306705b746.jpg)

  Git 把 master 分支移回到 `C1`；现在我们的本地代码库根本就不知道有 `C2` 这个提交了。

（注：在reset后， `C2` 所做的变更还在，但是处于未加入暂存区状态。）



为了撤销更改并**分享**给别人，我们需要使用 `git revert`。

![reset](https://tva1.sinaimg.cn/large/006tNbRwly1gaiinykyahj306305bdfq.jpg)

```
git revert HEAD
```

![reset3](https://tva1.sinaimg.cn/large/006tNbRwly1gaiinws37ij306b07tdfs.jpg)



在我们要撤销的提交记录后面居然多了一个新提交！这是因为新提交记录 `C2'` 引入了**更改** —— 这些更改刚好是用来撤销 `C2` 这个提交的。也就是说 `C2'` 的状态与 `C1` 是相同的。

revert 之后就可以把你的更改推送到远程仓库与别人分享啦。

**总结**:

	* 本地库,没提交前用reset
	* 远程库,用revert覆盖

**思考**: 以下是否可行? 

```
git revert c1
```

### 8 . Cherry-pick

接下来要讨论的这个话题是“整理提交记录” —— 开发人员有时会说“我想要把这个提交放到这里, 那个提交放到刚才那个提交的后面”, 而接下来就讲的就是它的实现方式，非常清晰、灵活，还很生动。

命令形式为:
```
git cherry-pick <提交号>...
```
如果你想将一些提交复制到当前所在的位置（`HEAD`）下面的话， Cherry-pick 是最直接的方式了。我个人非常喜欢 `cherry-pick`，因为它特别简单。

![chreey1](https://tva1.sinaimg.cn/large/006tNbRwly1gaiio3q97fj309g0anjrh.jpg)

```
git chreey-pick c2 c4
```

![chreey2](https://tva1.sinaimg.cn/large/006tNbRwly1gaiinuuda5j309c0anaa8.jpg)



### 总结

到现在我们已经学习了 Git 的基础知识 —— 提交、分支以及在提交树上移动。 这些概念涵盖了 Git 80% 的功能，同样也足够满足开发者的日常需求

归根结底,我们要在脑子里形成“提交树”的概念,再复杂的工作流都是在树上的移动.

留一个作业,大家思考,在脑子里用学过的知识来完成,最好把步骤写下来,理清思路,如果能写出答案,那么基本上你就掌握了git的思想.

![answer](https://tva1.sinaimg.cn/large/006tNbRwly1gaiinrn2haj305h08oq2z.jpg)

通过我们的学习,把它变成如下:

![answer2](https://tva1.sinaimg.cn/large/006tNbRwly1gaiinwb2szj30fl08twet.jpg)
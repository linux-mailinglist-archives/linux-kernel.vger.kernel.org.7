Return-Path: <linux-kernel+bounces-797478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7127CB410EA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 01:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CD4B161BA0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 23:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AE02EA143;
	Tue,  2 Sep 2025 23:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5WwwJlL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E8F2E92CF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 23:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756856902; cv=none; b=Dv6Z9exB6oUqhWIMuSw4RYyFsAT/XOGTEkwZkidbaKmlCDP++Bsnegh04MJdgTlDp+P2arQUcTwZEHaaxDqc1bT7zx7JEz2OUbJRE7LHHt5t/YtksY4TchvEFwBFGbSQhHwhpKKIOwQovQ/hdPkoyc8lfEoJEgYHO3wWAvow8lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756856902; c=relaxed/simple;
	bh=BWLghahBqaJ4gjCr2oVXE1SMh3ZXn7rz3wGqJz+D4b4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LqwT0H9WM8CjEmv154CZ5sIdRRy2kkwTnM9SsXNXi3/l3k1UokcLejkAUqQpL6WcEvOO/21Re7fmErKKPpVyRmuezmsZWIXgD4p2PetMgvF7jh4owYsXn6xLsWirHDrOXii1fN7Z7zcLubaYkCYMNq+bUV3SdhTvw5lolUugQMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5WwwJlL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1494DC4CEF4;
	Tue,  2 Sep 2025 23:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756856902;
	bh=BWLghahBqaJ4gjCr2oVXE1SMh3ZXn7rz3wGqJz+D4b4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r5WwwJlLAfiBYmAqieFgmYTHNDN3qWZGGATT/Kvu4fkFsDXG6Rnbb/qDoSi9ohj5y
	 WwObwEEHZuHAn+9MJh4tt2V5/mGXVHR4hYK0u/H4CkpPogpfNv9f5P+9ge+49qmMvr
	 JXigSJrnfUldKf1bN3w4adx5bBhHqTbrXG0qJai6mWN9UTUo3ckrqjwBxPQlllQP34
	 6o9TH/n1tXIWKM5RKSh/PMqpr5rHJU0vGYZc4aSNR0cO9h/7I97eA/L0TdRKJ3d7uv
	 B4pGU/Kq7KVO1FWYpthGuer2qDPVtA3KgKZQfNL0VTJ57K1ZyL82DNtFTm2y/IapNy
	 h5hQJEPYCY6Zw==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/4] sched_ext: Make explicit scx_task_iter_relock() calls unnecessary
Date: Tue,  2 Sep 2025 13:48:03 -1000
Message-ID: <20250902234817.279206-2-tj@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902234817.279206-1-tj@kernel.org>
References: <20250902234817.279206-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During tasks iteration, the locks can be dropped using
scx_task_iter_unlock() to perform e.g. sleepable allocations. Afterwards,
scx_task_iter_relock() has to be called prior to other iteration operations,
which is error-prone. This can be easily automated by tracking whether
scx_tasks_lock is held in scx_task_iter and re-acquiring when necessary. It
already tracks whether the task's rq is locked after all.

- Add scx_task_iter->list_locked which remembers whether scx_tasks_lock is
  held.

- Rename scx_task_iter->locked to scx_task_iter->locked_task to better
  distinguish it from ->list_locked.

- Replace scx_task_iter_relock() with __scx_task_iter_maybe_relock() which
  is automatically called by scx_task_iter_next() and scx_task_iter_stop().

- Drop explicit scx_task_iter_relock() calls.

The resulting behavior should be equivalent.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 7dedc9a16281..7f799345c899 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1488,10 +1488,11 @@ struct bpf_iter_scx_dsq {
  */
 struct scx_task_iter {
 	struct sched_ext_entity		cursor;
-	struct task_struct		*locked;
+	struct task_struct		*locked_task;
 	struct rq			*rq;
 	struct rq_flags			rf;
 	u32				cnt;
+	bool				list_locked;
 };
 
 /**
@@ -1519,15 +1520,16 @@ static void scx_task_iter_start(struct scx_task_iter *iter)
 
 	iter->cursor = (struct sched_ext_entity){ .flags = SCX_TASK_CURSOR };
 	list_add(&iter->cursor.tasks_node, &scx_tasks);
-	iter->locked = NULL;
+	iter->locked_task = NULL;
 	iter->cnt = 0;
+	iter->list_locked = true;
 }
 
 static void __scx_task_iter_rq_unlock(struct scx_task_iter *iter)
 {
-	if (iter->locked) {
-		task_rq_unlock(iter->rq, iter->locked, &iter->rf);
-		iter->locked = NULL;
+	if (iter->locked_task) {
+		task_rq_unlock(iter->rq, iter->locked_task, &iter->rf);
+		iter->locked_task = NULL;
 	}
 }
 
@@ -1537,24 +1539,24 @@ static void __scx_task_iter_rq_unlock(struct scx_task_iter *iter)
  *
  * If @iter is in the middle of a locked iteration, it may be locking the rq of
  * the task currently being visited in addition to scx_tasks_lock. Unlock both.
- * This function can be safely called anytime during an iteration.
+ * This function can be safely called anytime during an iteration. The next
+ * iterator operation will automatically restore the necessary locking.
  */
 static void scx_task_iter_unlock(struct scx_task_iter *iter)
 {
 	__scx_task_iter_rq_unlock(iter);
-	spin_unlock_irq(&scx_tasks_lock);
+	if (iter->list_locked) {
+		iter->list_locked = false;
+		spin_unlock_irq(&scx_tasks_lock);
+	}
 }
 
-/**
- * scx_task_iter_relock - Lock scx_tasks_lock released by scx_task_iter_unlock()
- * @iter: iterator to re-lock
- *
- * Re-lock scx_tasks_lock unlocked by scx_task_iter_unlock(). Note that it
- * doesn't re-lock the rq lock. Must be called before other iterator operations.
- */
-static void scx_task_iter_relock(struct scx_task_iter *iter)
+static void __scx_task_iter_maybe_relock(struct scx_task_iter *iter)
 {
-	spin_lock_irq(&scx_tasks_lock);
+	if (!iter->list_locked) {
+		spin_lock_irq(&scx_tasks_lock);
+		iter->list_locked = true;
+	}
 }
 
 /**
@@ -1567,6 +1569,7 @@ static void scx_task_iter_relock(struct scx_task_iter *iter)
  */
 static void scx_task_iter_stop(struct scx_task_iter *iter)
 {
+	__scx_task_iter_maybe_relock(iter);
 	list_del_init(&iter->cursor.tasks_node);
 	scx_task_iter_unlock(iter);
 }
@@ -1584,10 +1587,12 @@ static struct task_struct *scx_task_iter_next(struct scx_task_iter *iter)
 	struct list_head *cursor = &iter->cursor.tasks_node;
 	struct sched_ext_entity *pos;
 
+	__scx_task_iter_maybe_relock(iter);
+
 	if (!(++iter->cnt % SCX_TASK_ITER_BATCH)) {
 		scx_task_iter_unlock(iter);
 		cond_resched();
-		scx_task_iter_relock(iter);
+		__scx_task_iter_maybe_relock(iter);
 	}
 
 	list_for_each_entry(pos, cursor, tasks_node) {
@@ -1650,7 +1655,7 @@ static struct task_struct *scx_task_iter_next_locked(struct scx_task_iter *iter)
 		return NULL;
 
 	iter->rq = task_rq_lock(p, &iter->rf);
-	iter->locked = p;
+	iter->locked_task = p;
 
 	return p;
 }
@@ -5713,7 +5718,6 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 		ret = scx_init_task(p, task_group(p), false);
 		if (ret) {
 			put_task_struct(p);
-			scx_task_iter_relock(&sti);
 			scx_task_iter_stop(&sti);
 			scx_error(sch, "ops.init_task() failed (%d) for %s[%d]",
 				  ret, p->comm, p->pid);
@@ -5723,7 +5727,6 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 		scx_set_task_state(p, SCX_TASK_READY);
 
 		put_task_struct(p);
-		scx_task_iter_relock(&sti);
 	}
 	scx_task_iter_stop(&sti);
 	scx_cgroup_unlock();
-- 
2.51.0



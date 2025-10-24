Return-Path: <linux-kernel+bounces-868916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CFDC067FF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 628F33AB12A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD9231DDBC;
	Fri, 24 Oct 2025 13:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQtJ8PW3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37AA31D735
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761312358; cv=none; b=HyVQYJJ8I2FhJmZfxlW4HRiyFEGAmP3kAA27fChmmaTgNLPKXUUPu8desmZ3D31p3cvgydmqZrGpVcp2afMmr8ci3iD5UVT0gIpWNz6wSUF+eKjPt8LOR0E+dyYBaR2h25x1CwKTt54Lwo9VqY3Hw2165dGHP9F6S8rJdydtz30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761312358; c=relaxed/simple;
	bh=irB9aTJNJxPQEQmFjs1xlRPckhqcedUk8MTId94ZJfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XehFCUwgUDqBZgTaU9UVlT9a2kL0G2WTExh6RqXhKTk/rqWST77C8p3w15su4aVuZPhiYKrN15Aerql5L2opFWXN2TCU19p3yiHRifRr89QbYaEbGtV6fkY2i0CGQkM8UecH80Qfev2uBAbXXkFSQPaKlpzOYAbXrmg5npwYpPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQtJ8PW3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C18C4CEF1;
	Fri, 24 Oct 2025 13:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761312357;
	bh=irB9aTJNJxPQEQmFjs1xlRPckhqcedUk8MTId94ZJfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sQtJ8PW3x3kpeK/sii5QA+78Nn1/5uXHXLQ2M1BqNFSx0yXcTDg4H3MrJd1Jr85oP
	 qemebu71nncsL7zxQmFeBwjxXhGjFPBMSlLFo12evI+AtUN5tvJpeABLyuF/5Y8Rj+
	 yUA7O/vKGUrjjck886osViRY0XR+7q616tkmBj/+dtCkrhzhlCZOJpwKbMQj5AmOae
	 gJJIp98d0f1QKtY/sEyWN2QcIlnwZz3ao3CR52C2+nUcPKQENG25L5qLPDnHggLXzq
	 bEqqXZTrB7X/WoE3pEz45iStF4X9+9XvhJbOAGw8vG1OScMM2XM1VZabfNtVnJVXVM
	 iz2Blrul3kz+w==
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH 3/6] timers/migration: Fix imbalanced NUMA trees
Date: Fri, 24 Oct 2025 15:25:33 +0200
Message-ID: <20251024132536.39841-4-frederic@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024132536.39841-1-frederic@kernel.org>
References: <20251024132536.39841-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a CPU from a new node boots, the old root may happen to be
connected to the new root even if their node mismatch, as depicted in
the following scenario:

1) CPU 0 boots and creates the first group for node 0.

   [GRP0:0]
    node 0
      |
    CPU 0

2) CPU 1 from node 1 boots and creates a new top that corresponds to
   node 1, but it also connects the old root from node 0 to the new root
   from node 1 by mistake.

             [GRP1:0]
              node 1
            /        \
           /          \
   [GRP0:0]             [GRP0:1]
    node 0               node 1
      |                    |
    CPU 0                CPU 1

3) This eventually leads to an imbalanced tree where some node 0 CPUs
   migrate node 1 timers (and vice versa) way before reaching the
   crossnode groups, resulting in more frequent remote memory accesses
   than expected.

                      [GRP2:0]
                      NUMA_NO_NODE
                     /             \
             [GRP1:0]              [GRP1:1]
              node 1               node 0
            /        \                |
           /          \             [...]
   [GRP0:0]             [GRP0:1]
    node 0               node 1
      |                    |
    CPU 0...              CPU 1...

A balanced tree should only contain groups having children that belong
to the same node:

                      [GRP2:0]
                      NUMA_NO_NODE
                     /             \
             [GRP1:0]              [GRP1:0]
              node 0               node 1
            /        \             /      \
           /          \           /        \
   [GRP0:0]          [...]      [...]    [GRP0:1]
    node 0                                node 1
      |                                     |
    CPU 0...                              CPU 1...

In order to fix this, the hierarchy must be unfolded up to the crossnode
level as soon as a node mismatch is detected. For example the stage 2
above should lead to this layout:

                      [GRP2:0]
                      NUMA_NO_NODE
                     /             \
             [GRP1:0]              [GRP1:1]
              node 0               node 1
              /                         \
             /                           \
        [GRP0:0]                        [GRP0:1]
        node 0                           node 1
          |                                |
       CPU 0                             CPU 1

This means that not only GRP1:0 must be created but also GRP1:1 and
GRP2:0 in order to prepare a balanced tree for next CPUs to boot.

Fixes: 7ee988770326 ("timers: Implement the hierarchical pull model")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/timer_migration.c | 231 +++++++++++++++++++---------------
 1 file changed, 127 insertions(+), 104 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 5f8aef94ca0f..49635a2b7ee2 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -420,6 +420,8 @@ static struct list_head *tmigr_level_list __read_mostly;
 static unsigned int tmigr_hierarchy_levels __read_mostly;
 static unsigned int tmigr_crossnode_level __read_mostly;
 
+static struct tmigr_group *tmigr_root;
+
 static DEFINE_PER_CPU(struct tmigr_cpu, tmigr_cpu);
 
 #define TMIGR_NONE	0xFF
@@ -522,11 +524,9 @@ struct tmigr_walk {
 
 typedef bool (*up_f)(struct tmigr_group *, struct tmigr_group *, struct tmigr_walk *);
 
-static void __walk_groups(up_f up, struct tmigr_walk *data,
-			  struct tmigr_cpu *tmc)
+static void __walk_groups_from(up_f up, struct tmigr_walk *data,
+			       struct tmigr_group *child, struct tmigr_group *group)
 {
-	struct tmigr_group *child = NULL, *group = tmc->tmgroup;
-
 	do {
 		WARN_ON_ONCE(group->level >= tmigr_hierarchy_levels);
 
@@ -544,6 +544,12 @@ static void __walk_groups(up_f up, struct tmigr_walk *data,
 	} while (group);
 }
 
+static void __walk_groups(up_f up, struct tmigr_walk *data,
+			  struct tmigr_cpu *tmc)
+{
+	__walk_groups_from(up, data, NULL, tmc->tmgroup);
+}
+
 static void walk_groups(up_f up, struct tmigr_walk *data, struct tmigr_cpu *tmc)
 {
 	lockdep_assert_held(&tmc->lock);
@@ -1498,21 +1504,6 @@ static void tmigr_init_group(struct tmigr_group *group, unsigned int lvl,
 	s.seq = 0;
 	atomic_set(&group->migr_state, s.state);
 
-	/*
-	 * If this is a new top-level, prepare its groupmask in advance.
-	 * This avoids accidents where yet another new top-level is
-	 * created in the future and made visible before the current groupmask.
-	 */
-	if (list_empty(&tmigr_level_list[lvl])) {
-		group->groupmask = BIT(0);
-		/*
-		 * The previous top level has prepared its groupmask already,
-		 * simply account it as the first child.
-		 */
-		if (lvl > 0)
-			group->num_children = 1;
-	}
-
 	timerqueue_init_head(&group->events);
 	timerqueue_init(&group->groupevt.nextevt);
 	group->groupevt.nextevt.expires = KTIME_MAX;
@@ -1567,22 +1558,51 @@ static struct tmigr_group *tmigr_get_group(unsigned int cpu, int node,
 	return group;
 }
 
+static bool tmigr_init_root(struct tmigr_group *group, bool activate)
+{
+	if (!group->parent && group != tmigr_root) {
+		/*
+		 * This is the new top-level, prepare its groupmask in advance
+		 * to avoid accidents where yet another new top-level is
+		 * created in the future and made visible before this groupmask.
+		 */
+		group->groupmask = BIT(0);
+		WARN_ON_ONCE(activate);
+
+		return true;
+	}
+
+	return false;
+
+}
+
 static void tmigr_connect_child_parent(struct tmigr_group *child,
 				       struct tmigr_group *parent,
 				       bool activate)
 {
-	struct tmigr_walk data;
+	if (tmigr_init_root(parent, activate)) {
+		/*
+		 * The previous top level had prepared its groupmask already,
+		 * simply account it in advance as the first child. If some groups
+		 * have been created between the old and new root due to node
+		 * mismatch, the new root's child will be intialized accordingly.
+		 */
+		parent->num_children = 1;
+	}
 
-	if (activate) {
+	/* Connecting old root to new root ? */
+	if (!parent->parent && activate) {
 		/*
-		 * @child is the old top and @parent the new one. In this
-		 * case groupmask is pre-initialized and @child already
-		 * accounted, along with its new sibling corresponding to the
-		 * CPU going up.
+		 * @child is the old top, or in case of node mismatch, some
+		 * intermediate group between the old top and the new one in
+		 * @parent. In this case the @child must be pre-accounted above
+		 * as the first child. Its new inactive sibling corresponding
+		 * to the CPU going up has been accounted as the second child.
 		 */
-		WARN_ON_ONCE(child->groupmask != BIT(0) || parent->num_children != 2);
+		WARN_ON_ONCE(parent->num_children != 2);
+		child->groupmask = BIT(0);
 	} else {
-		/* Adding @child for the CPU going up to @parent. */
+		/* Common case adding @child for the CPU going up to @parent. */
 		child->groupmask = BIT(parent->num_children++);
 	}
 
@@ -1594,56 +1614,28 @@ static void tmigr_connect_child_parent(struct tmigr_group *child,
 	smp_store_release(&child->parent, parent);
 
 	trace_tmigr_connect_child_parent(child);
-
-	if (!activate)
-		return;
-
-	/*
-	 * To prevent inconsistent states, active children need to be active in
-	 * the new parent as well. Inactive children are already marked inactive
-	 * in the parent group:
-	 *
-	 * * When new groups were created by tmigr_setup_groups() starting from
-	 *   the lowest level (and not higher then one level below the current
-	 *   top level), then they are not active. They will be set active when
-	 *   the new online CPU comes active.
-	 *
-	 * * But if a new group above the current top level is required, it is
-	 *   mandatory to propagate the active state of the already existing
-	 *   child to the new parent. So tmigr_connect_child_parent() is
-	 *   executed with the formerly top level group (child) and the newly
-	 *   created group (parent).
-	 *
-	 * * It is ensured that the child is active, as this setup path is
-	 *   executed in hotplug prepare callback. This is exectued by an
-	 *   already connected and !idle CPU. Even if all other CPUs go idle,
-	 *   the CPU executing the setup will be responsible up to current top
-	 *   level group. And the next time it goes inactive, it will release
-	 *   the new childmask and parent to subsequent walkers through this
-	 *   @child. Therefore propagate active state unconditionally.
-	 */
-	data.childmask = child->groupmask;
-
-	/*
-	 * There is only one new level per time (which is protected by
-	 * tmigr_mutex). When connecting the child and the parent and set the
-	 * child active when the parent is inactive, the parent needs to be the
-	 * uppermost level. Otherwise there went something wrong!
-	 */
-	WARN_ON(!tmigr_active_up(parent, child, &data) && parent->parent);
 }
 
-static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
+static int tmigr_setup_groups(unsigned int cpu, unsigned int node,
+			      struct tmigr_group *start, bool activate)
 {
 	struct tmigr_group *group, *child, **stack;
-	int i, top = 0, err = 0;
-	struct list_head *lvllist;
+	int i, top = 0, err = 0, start_lvl = 0;
+	bool root_mismatch = false;
 
 	stack = kcalloc(tmigr_hierarchy_levels, sizeof(*stack), GFP_KERNEL);
 	if (!stack)
 		return -ENOMEM;
 
-	for (i = 0; i < tmigr_hierarchy_levels; i++) {
+	if (start) {
+		stack[start->level] = start;
+		start_lvl = start->level + 1;
+	}
+
+	if (tmigr_root)
+		root_mismatch = tmigr_root->numa_node != node;
+
+	for (i = start_lvl; i < tmigr_hierarchy_levels; i++) {
 		group = tmigr_get_group(cpu, node, i);
 		if (IS_ERR(group)) {
 			err = PTR_ERR(group);
@@ -1656,23 +1648,25 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
 
 		/*
 		 * When booting only less CPUs of a system than CPUs are
-		 * available, not all calculated hierarchy levels are required.
+		 * available, not all calculated hierarchy levels are required,
+		 * unless a node mismatch is detected.
 		 *
 		 * The loop is aborted as soon as the highest level, which might
 		 * be different from tmigr_hierarchy_levels, contains only a
-		 * single group.
+		 * single group, unless the nodes mismatch below tmigr_crossnode_level
 		 */
-		if (group->parent || list_is_singular(&tmigr_level_list[i]))
+		if (group->parent)
+			break;
+		if ((!root_mismatch || i >= tmigr_crossnode_level) &&
+		    list_is_singular(&tmigr_level_list[i]))
 			break;
 	}
 
 	/* Assert single root without parent */
 	if (WARN_ON_ONCE(i >= tmigr_hierarchy_levels))
 		return -EINVAL;
-	if (WARN_ON_ONCE(!err && !group->parent && !list_is_singular(&tmigr_level_list[top])))
-		return -EINVAL;
 
-	for (; i >= 0; i--) {
+	for (; i >= start_lvl; i--) {
 		group = stack[i];
 
 		if (err < 0) {
@@ -1692,48 +1686,63 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
 			tmc->tmgroup = group;
 			tmc->groupmask = BIT(group->num_children++);
 
+			tmigr_init_root(group, activate);
+
 			trace_tmigr_connect_cpu_parent(tmc);
 
 			/* There are no children that need to be connected */
 			continue;
 		} else {
 			child = stack[i - 1];
-			/* Will be activated at online time */
-			tmigr_connect_child_parent(child, group, false);
+			tmigr_connect_child_parent(child, group, activate);
 		}
+	}
 
-		/* check if uppermost level was newly created */
-		if (top != i)
-			continue;
+	if (err < 0)
+		goto out;
 
-		WARN_ON_ONCE(top == 0);
-
-		lvllist = &tmigr_level_list[top];
+	if (activate) {
+		struct tmigr_walk data;
 
 		/*
-		 * Newly created root level should have accounted the upcoming
-		 * CPU's child group and pre-accounted the old root.
+		 * To prevent inconsistent states, active children need to be active in
+		 * the new parent as well. Inactive children are already marked inactive
+		 * in the parent group:
+		 *
+		 * * When new groups were created by tmigr_setup_groups() starting from
+		 *   the lowest level, then they are not active. They will be set active
+		 *   when the new online CPU comes active.
+		 *
+		 * * But if new groups above the current top level are required, it is
+		 *   mandatory to propagate the active state of the already existing
+		 *   child to the new parents. So tmigr_active_up() activates the
+		 *   new parents while walking up from the old root to the new.
+		 *
+		 * * It is ensured that @start is active, as this setup path is
+		 *   executed in hotplug prepare callback. This is executed by an
+		 *   already connected and !idle CPU. Even if all other CPUs go idle,
+		 *   the CPU executing the setup will be responsible up to current top
+		 *   level group. And the next time it goes inactive, it will release
+		 *   the new childmask and parent to subsequent walkers through this
+		 *   @child. Therefore propagate active state unconditionally.
 		 */
-		if (group->num_children == 2 && list_is_singular(lvllist)) {
-			/*
-			 * The target CPU must never do the prepare work, except
-			 * on early boot when the boot CPU is the target. Otherwise
-			 * it may spuriously activate the old top level group inside
-			 * the new one (nevertheless whether old top level group is
-			 * active or not) and/or release an uninitialized childmask.
-			 */
-			WARN_ON_ONCE(cpu == raw_smp_processor_id());
+		WARN_ON_ONCE(!start->parent);
+		data.childmask = start->groupmask;
+		__walk_groups_from(tmigr_active_up, &data, start, start->parent);
+	}
 
-			lvllist = &tmigr_level_list[top - 1];
-			list_for_each_entry(child, lvllist, list) {
-				if (child->parent)
-					continue;
-
-				tmigr_connect_child_parent(child, group, true);
-			}
+	/* Root update */
+	if (list_is_singular(&tmigr_level_list[top])) {
+		group = list_first_entry(&tmigr_level_list[top],
+					 typeof(*group), list);
+		WARN_ON_ONCE(group->parent);
+		if (tmigr_root) {
+			/* Old root should be the same or below */
+			WARN_ON_ONCE(tmigr_root->level > top);
 		}
+		tmigr_root = group;
 	}
-
+out:
 	kfree(stack);
 
 	return err;
@@ -1741,12 +1750,26 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
 
 static int tmigr_add_cpu(unsigned int cpu)
 {
+	struct tmigr_group *old_root = tmigr_root;
 	int node = cpu_to_node(cpu);
 	int ret;
 
-	mutex_lock(&tmigr_mutex);
-	ret = tmigr_setup_groups(cpu, node);
-	mutex_unlock(&tmigr_mutex);
+	guard(mutex)(&tmigr_mutex);
+
+	ret = tmigr_setup_groups(cpu, node, NULL, false);
+
+	/* Root has changed? Connect the old one to the new */
+	if (ret >= 0 && old_root && old_root != tmigr_root) {
+		/*
+		 * The target CPU must never do the prepare work, except
+		 * on early boot when the boot CPU is the target. Otherwise
+		 * it may spuriously activate the old top level group inside
+		 * the new one (nevertheless whether old top level group is
+		 * active or not) and/or release an uninitialized childmask.
+		 */
+		WARN_ON_ONCE(cpu == raw_smp_processor_id());
+		ret = tmigr_setup_groups(-1, old_root->numa_node, old_root, true);
+	}
 
 	return ret;
 }
-- 
2.51.0



Return-Path: <linux-kernel+bounces-889231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 10214C3D089
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 19:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AEAD73512D9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 18:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D31B34DB54;
	Thu,  6 Nov 2025 18:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qP5LWF/N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73EB2BDC0F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 18:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762452757; cv=none; b=S4yGsnA8c69bAQFKwtg8tJKm8ii7oAxsr3APsU5XZxoujmZXPMZgfccqvuukRv16X8wJ6dByXkT4ce8uIDXTqJfL0r5HZLi9CxPuK3MoHJPF76dfAWDUImqJV7wzKa8dhlXBxeK1786Tk5wnIeOvGktyAKewj2jCaAs8aHgtzi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762452757; c=relaxed/simple;
	bh=j0baMIJpFG/QRZRX1egnx5Da+S9JJD3aqt5kUE57y7Y=;
	h=Date:Message-ID:From:To:Cc:Subject; b=WwTXpTYRubCh1xIto1xijhbM5jpLPLnXkju6sjzC5JcxU72FrLfmuIhNsNOUJ+LclPt+IKP8E7b2ex3b6NrrTT3ostfFdJBitN3/p8h+DQ0EcCwSgFXIrzrM4/8STGvRRj9dJ87AffbneazGcknyg5/7BSszNXPL5D/xQpfRqEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qP5LWF/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C025C4CEF7;
	Thu,  6 Nov 2025 18:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762452757;
	bh=j0baMIJpFG/QRZRX1egnx5Da+S9JJD3aqt5kUE57y7Y=;
	h=Date:From:To:Cc:Subject:From;
	b=qP5LWF/Np6Y0caMLbyCKAlAU4re8Ak1DxIsyWiJnlds2+Ote/tq3aD1jUzauf48UX
	 VjFxOGERZQld7CLFpXtCd0XOcR4IgtZE+8NL4UIo9+rWL47koZOu2CIWlIuvXiQHXj
	 nmEoJSxxW4jxgR7hso8ZrVfU1QTnpQBcNl2a0ROwsB0kkUVZ0yF8FkPL611vuYPadK
	 1bUN2uFFct8Yea4zeKJvxtk7j712FYoDJbaaWWRlCtfRhmAFlJS0Mq5oufNPIefhes
	 QYu0FCAoZUqyrIJ7pI34opcWmtHmRDah0WC8jj07GqRQH447IxGp+0BxfHymCqLCN9
	 Ge3lTOrFug07Q==
Date: Thu, 06 Nov 2025 08:12:36 -1000
Message-ID: <99e1ba732f01b0082d48c6466aea214e@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Calvin Owens <calvin@wbinvd.org>
Cc: linux-kernel@vger.kernel.org, Dan Schatzberg <dschatzberg@meta.com>, Peter Zijlstra <peterz@infradead.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 cgroup/for-6.19] cgroup: Fix sleeping from invalid context warning on PREEMPT_RT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

cgroup_task_dead() is called from finish_task_switch() which runs with
preemption disabled and doesn't allow scheduling even on PREEMPT_RT. The
function needs to acquire css_set_lock which is a regular spinlock that can
sleep on RT kernels, leading to "sleeping function called from invalid
context" warnings.

css_set_lock is too large in scope to convert to a raw_spinlock. However,
the unlinking operations don't need to run synchronously - they just need
to complete after the task is done running.

On PREEMPT_RT, defer the work through irq_work. While the work doesn't need
to happen immediately, it can't be delayed indefinitely either as the dead
task pins the cgroup and task_struct can be pinned indefinitely. Use the
lazy version of irq_work to allow batching and lower impact while ensuring
timely completion.

v2: Use IRQ_WORK_INIT_LAZY instead of immediate irq_work and add explanation
    for why the work can't be delayed indefinitely (Sebastian Andrzej Siewior).

Fixes: d245698d727a ("cgroup: Defer task cgroup unlink until after the task is done switching out")
Reported-by: Calvin Owens <calvin@wbinvd.org>
Link: https://lore.kernel.org/r/20251104181114.489391-1-calvin@wbinvd.org
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched.h  |    5 +++-
 kernel/cgroup/cgroup.c |   55 ++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 58 insertions(+), 2 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1324,7 +1324,10 @@ struct task_struct {
 	struct css_set __rcu		*cgroups;
 	/* cg_list protected by css_set_lock and tsk->alloc_lock: */
 	struct list_head		cg_list;
-#endif
+#ifdef CONFIG_PREEMPT_RT
+	struct llist_node		cg_dead_lnode;
+#endif	/* CONFIG_PREEMPT_RT */
+#endif	/* CONFIG_CGROUPS */
 #ifdef CONFIG_X86_CPU_RESCTRL
 	u32				closid;
 	u32				rmid;
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -290,6 +290,7 @@ static void kill_css(struct cgroup_subsy
 static int cgroup_addrm_files(struct cgroup_subsys_state *css,
 			      struct cgroup *cgrp, struct cftype cfts[],
 			      bool is_add);
+static void cgroup_rt_init(void);

 #ifdef CONFIG_DEBUG_CGROUP_REF
 #define CGROUP_REF_FN_ATTRS	noinline
@@ -6360,6 +6361,7 @@ int __init cgroup_init(void)
 	BUG_ON(ss_rstat_init(NULL));

 	get_user_ns(init_cgroup_ns.user_ns);
+	cgroup_rt_init();

 	cgroup_lock();

@@ -6990,7 +6992,7 @@ void cgroup_task_exit(struct task_struct
 	} while_each_subsys_mask();
 }

-void cgroup_task_dead(struct task_struct *tsk)
+static void do_cgroup_task_dead(struct task_struct *tsk)
 {
 	struct css_set *cset;
 	unsigned long flags;
@@ -7016,6 +7018,57 @@ void cgroup_task_dead(struct task_struct
 	spin_unlock_irqrestore(&css_set_lock, flags);
 }

+#ifdef CONFIG_PREEMPT_RT
+/*
+ * cgroup_task_dead() is called from finish_task_switch() which doesn't allow
+ * scheduling even in RT. As the task_dead path requires grabbing css_set_lock,
+ * this lead to sleeping in the invalid context warning bug. css_set_lock is too
+ * big to become a raw_spinlock. The task_dead path doesn't need to run
+ * synchronously but can't be delayed indefinitely either as the dead task pins
+ * the cgroup and task_struct can be pinned indefinitely. Bounce through lazy
+ * irq_work to allow batching while ensuring timely completion.
+ */
+static DEFINE_PER_CPU(struct llist_head, cgrp_dead_tasks);
+static DEFINE_PER_CPU(struct irq_work, cgrp_dead_tasks_iwork);
+
+static void cgrp_dead_tasks_iwork_fn(struct irq_work *iwork)
+{
+	struct llist_node *lnode;
+	struct task_struct *task, *next;
+
+	lnode = llist_del_all(this_cpu_ptr(&cgrp_dead_tasks));
+	llist_for_each_entry_safe(task, next, lnode, cg_dead_lnode) {
+		do_cgroup_task_dead(task);
+		put_task_struct(task);
+	}
+}
+
+static void __init cgroup_rt_init(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		init_llist_head(per_cpu_ptr(&cgrp_dead_tasks, cpu));
+		per_cpu(cgrp_dead_tasks_iwork, cpu) =
+			IRQ_WORK_INIT_LAZY(cgrp_dead_tasks_iwork_fn);
+	}
+}
+
+void cgroup_task_dead(struct task_struct *task)
+{
+	get_task_struct(task);
+	llist_add(&task->cg_dead_lnode, this_cpu_ptr(&cgrp_dead_tasks));
+	irq_work_queue(this_cpu_ptr(&cgrp_dead_tasks_iwork));
+}
+#else	/* CONFIG_PREEMPT_RT */
+static void __init cgroup_rt_init(void) {}
+
+void cgroup_task_dead(struct task_struct *task)
+{
+	do_cgroup_task_dead(task);
+}
+#endif	/* CONFIG_PREEMPT_RT */
+
 void cgroup_task_release(struct task_struct *task)
 {
 	struct cgroup_subsys *ss;


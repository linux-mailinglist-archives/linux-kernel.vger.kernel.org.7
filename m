Return-Path: <linux-kernel+bounces-887156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BD75BC3769C
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 20:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 461164E6789
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 19:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4FD2C11CD;
	Wed,  5 Nov 2025 19:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjjLFvke"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30B82957B6
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 19:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762369436; cv=none; b=C+O89nbKpsmsc2AQ5uKelLC7reCIiM4IZN3x7EIbm+iWofyoNVNC3MtWkEBmw/1O+2/46ofIaSUR6MPsJt98CRuS4JBPXHDa8z7GUAJgt1ZFUF2aK/EnmWwsM0mRgRm6TcVQLIxKf2N39ZuiC/VQYaTrmI07NhOJLsGysYQZ8kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762369436; c=relaxed/simple;
	bh=niYhEoHRhZUPBk11GJXa5Sq99AdxbtJMFQAmOBGX3ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JsnLxP0Bhg4TCHW6JeoBNM32dFjf/N4YclMnHM3JxeeXcVGBmuklaSPtyZMvXacm55rqaNqqzPR9cNhyl4Gh1Waej0u6ANnFq2oe+5yfjO3NK4sppz4L+OZB4r4oYtECVUl4DG9KJL9tDNiLWTTVYQqrC83c/3ikJ2WYB1PrWXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjjLFvke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3317EC4CEF5;
	Wed,  5 Nov 2025 19:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762369436;
	bh=niYhEoHRhZUPBk11GJXa5Sq99AdxbtJMFQAmOBGX3ic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MjjLFvkeXZdDGdpGDznA/H9Wyw2PfqXbMA0/iCcdQkTJBCQs6Ye8BeGGRVKzYrrH1
	 fJFTssTBzysAGWBXnu4OVhehvsk2jCVCMllFRMzwxajbeuz0AzL7dcDpi5oySNcv4i
	 UYgtPJiXWcj+BGnELgzJtFsxs1YevAUD/RMRWj5RSaRdBaP2/7gwJ6/rKvs9E/P191
	 RW95B2bln02IP2v2jX1dofNnN2/beiRUA3Ue3KsQ6Ktf11TTo/GyaY4LMcAs9QrwZM
	 fLOOTfDuH7Z1jAA2/SZejtcG+MQ/Y11w6qhXBdJbZbyrqsOKot7DxaZa2NREDHED7L
	 Lu39pXlamXJRg==
Date: Wed, 5 Nov 2025 09:03:55 -1000
From: Tejun Heo <tj@kernel.org>
To: Calvin Owens <calvin@wbinvd.org>
Cc: linux-kernel@vger.kernel.org, Dan Schatzberg <dschatzberg@meta.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH cgroup/for-6.19] cgroup: Fix sleeping from invalid context
 warning on PREEMPT_RT
Message-ID: <aQufmyZ7X7NdfiCL@slm.duckdns.org>
References: <20251104181114.489391-1-calvin@wbinvd.org>
 <aQpUY7fEp6_ZqGel@slm.duckdns.org>
 <aQtqXfMfy8SWjS67@mozart.vkv.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQtqXfMfy8SWjS67@mozart.vkv.me>

cgroup_task_dead() is called from finish_task_switch() which runs with
preemption disabled and doesn't allow scheduling even on PREEMPT_RT. The
function needs to acquire css_set_lock which is a regular spinlock that can
sleep on RT kernels, leading to "sleeping function called from invalid
context" warnings.

css_set_lock is too large in scope to convert to a raw_spinlock. However,
the unlinking operations don't need to run synchronously - they just need
to complete after the task is done running.

On PREEMPT_RT, defer the work through irq_work.

Fixes: d245698d727a ("cgroup: Defer task cgroup unlink until after the task is done switching out")
Reported-by: Calvin Owens <calvin@wbinvd.org>
Link: https://lore.kernel.org/r/20251104181114.489391-1-calvin@wbinvd.org
Signed-off-by: Tejun Heo <tj@kernel.org>
---
Hello,

Calvin, this seems to work fine here but can you please try it out?
Sebastian, Peter, does this look okay to you guys?

Thanks.

 include/linux/sched.h  |    5 +++-
 kernel/cgroup/cgroup.c |   53 ++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 56 insertions(+), 2 deletions(-)

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
@@ -7016,6 +7018,55 @@ void cgroup_task_dead(struct task_struct
 	spin_unlock_irqrestore(&css_set_lock, flags);
 }
 
+#ifdef CONFIG_PREEMPT_RT
+/*
+ * cgroup_task_dead() is called from finish_task_switch() which doesn't allow
+ * scheduling even in RT. As the task_dead path requires grabbing css_set_lock,
+ * this lead to sleeping in the invalid context warning bug. css_set_lock is too
+ * big to become a raw_spinlock. The task_dead path doesn't need to run
+ * synchronously. Bounce through irq_work instead.
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
+		init_irq_work(per_cpu_ptr(&cgrp_dead_tasks_iwork, cpu),
+			      cgrp_dead_tasks_iwork_fn);
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


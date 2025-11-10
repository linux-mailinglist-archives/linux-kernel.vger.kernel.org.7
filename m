Return-Path: <linux-kernel+bounces-892277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B1428C44BF2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 02:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C4A293459EF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 01:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D41618DB01;
	Mon, 10 Nov 2025 01:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PiNaYkMO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9917C34D38B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762739256; cv=none; b=lBv9ki5m4tniHOwGu+kzCAbJCWbX+Vh0bb2vrxSSAyOPmJJMHwCT3El5C0wd6LopfQYOPsg/MCtqzl+L72aciQH3qFSTBLVjLjgMaFPsQ6QcLiQzz2ab9zpZf2ldunieFUhpweM0tNlaP43lkt8DaF2WKQvaWc6nrYtitk+Ohuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762739256; c=relaxed/simple;
	bh=FulMp6Eem6PG6+92p6Suhc/Bk0S30dBxL+B3O6SN9vU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f40G02ZL+5halsmhnqg9TuaLhZv4XkHOn6QJjhJBcQzC0Df6LRw7TiP26+KtsuLoq8T/2D3/dZgyx8EysKXwwMR/eJOArAWD15XdnSrASlpIq6WH7iLNXn1ImAPpz61HXJANMY8o+cQ1v6wU8CLhIBekgpDo8DVyAZ5fNwUopG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PiNaYkMO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762739253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1mW+VFOxHLx1G37VL3/ek86NigQzHVKgkRFvwy3hb64=;
	b=PiNaYkMOkWzIdhjtJNoOPcyNCRMFrjff1e712OTFf14RTaGCy2Ob6RQPchgFAJyWGBHiEa
	uNCmPmnBkQxU9QWHlyeT+HStO1CLNLToxkk1HJ0AubLHmrFHib8OOD6RRFHgUvoWozo6Tl
	SaiXRpq/SJju+bN7u5YGgOvyOPFyIUs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-HxlT3WwBMsmk_q3rTshKvA-1; Sun,
 09 Nov 2025 20:47:29 -0500
X-MC-Unique: HxlT3WwBMsmk_q3rTshKvA-1
X-Mimecast-MFC-AGG-ID: HxlT3WwBMsmk_q3rTshKvA_1762739248
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B00D1800451;
	Mon, 10 Nov 2025 01:47:27 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.58])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E426A30001B9;
	Mon, 10 Nov 2025 01:47:19 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCHv5] sched/deadline: Walk up cpuset hierarchy to decide root domain when hot-unplug
Date: Mon, 10 Nov 2025 09:47:06 +0800
Message-ID: <20251110014706.8118-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

*** Bug description ***
When testing kexec-reboot on a 144 cpus machine with
isolcpus=managed_irq,domain,1-71,73-143 in kernel command line, I
encounter the following bug:

[   97.114759] psci: CPU142 killed (polled 0 ms)
[   97.333236] Failed to offline CPU143 - error=-16
[   97.333246] ------------[ cut here ]------------
[   97.342682] kernel BUG at kernel/cpu.c:1569!
[   97.347049] Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
[...]

In essence, the issue originates from the CPU hot-removal process, not
limited to kexec. It can be reproduced by writing a SCHED_DEADLINE
program that waits indefinitely on a semaphore, spawning multiple
instances to ensure some run on CPU 72, and then offlining CPUs 1–143
one by one. When attempting this, CPU 143 failed to go offline.
  bash -c 'taskset -cp 0 $$ && for i in {1..143}; do echo 0 > /sys/devices/system/cpu/cpu$i/online 2>/dev/null; done'

Tracking down this issue, I found that dl_bw_deactivate() returned
-EBUSY, which caused sched_cpu_deactivate() to fail on the last CPU.
But that is not the fact, and contributed by the following factors:
When a CPU is inactive, cpu_rq()->rd is set to def_root_domain. For an
blocked-state deadline task (in this case, "cppc_fie"), it was not
migrated to CPU0, and its task_rq() information is stale. So its rq->rd
points to def_root_domain instead of the one shared with CPU0.  As a
result, its bandwidth is wrongly accounted into a wrong root domain
during domain rebuild.

*** Issue ***
The key point is that root_domain is only tracked through active rq->rd.
To avoid using a global data structure to track all root_domains in the
system, there should be a method to locate an active CPU within the
corresponding root_domain.

*** Solution ***
To locate the active cpu, the following rules for deadline
sub-system is useful
  -1.any cpu belongs to a unique root domain at a given time
  -2.DL bandwidth checker ensures that the root domain has active cpus.

Now, let's examine the blocked-state task P.
If P is attached to a cpuset that is a partition root, it is
straightforward to find an active CPU.
If P is attached to a cpuset that has changed from 'root' to 'member',
the active CPUs are grouped into the parent root domain. Naturally, the
CPUs' capacity and reserved DL bandwidth are taken into account in the
ancestor root domain. (In practice, it may be unsafe to attach P to an
arbitrary root domain, since that domain may lack sufficient DL
bandwidth for P.) Again, it is straightforward to find an active CPU in
the ancestor root domain.

This patch groups CPUs into isolated and housekeeping sets. For the
housekeeping group, it walks up the cpuset hierarchy to find active CPUs
in P's root domain and retrieves the valid rd from cpu_rq(cpu)->rd.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Pierre Gondois <pierre.gondois@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org
---
v4 -> v5:
  Move the housekeeping part into deadline.c (Thanks for Waiman's suggestion)
  Use cpuset_cpus_allowed() instead of introducing new cpuset function (Thanks for Ridong's suggestion)

 kernel/sched/deadline.c | 50 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 72c1f72463c75..7555b7af49486 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2879,11 +2879,43 @@ void __init init_sched_dl_class(void)
 					GFP_KERNEL, cpu_to_node(i));
 }
 
+/*
+ * This function always returns a non-empty bitmap in @cpus. This is because
+ * if a root domain has reserved bandwidth for DL tasks, the DL bandwidth
+ * check will prevent CPU hotplug from deactivating all CPUs in that domain.
+ */
+static void dl_get_task_effective_cpus(struct task_struct *p, struct cpumask *cpus)
+{
+	const struct cpumask *hk_msk;
+
+	hk_msk = housekeeping_cpumask(HK_TYPE_DOMAIN);
+	if (housekeeping_enabled(HK_TYPE_DOMAIN)) {
+		if (!cpumask_intersects(p->cpus_ptr, hk_msk)) {
+			/*
+			 * CPUs isolated by isolcpu="domain" always belong to
+			 * def_root_domain.
+			 */
+			cpumask_andnot(cpus, cpu_active_mask, hk_msk);
+			return;
+		}
+	}
+
+	/*
+	 * If a root domain holds a DL task, it must have active CPUs. So
+	 * active CPUs can always be found by walking up the task's cpuset
+	 * hierarchy up to the partition root.
+	 */
+	cpuset_cpus_allowed(p, cpus);
+}
+
+/* The caller should hold cpuset_mutex */
 void dl_add_task_root_domain(struct task_struct *p)
 {
 	struct rq_flags rf;
 	struct rq *rq;
 	struct dl_bw *dl_b;
+	unsigned int cpu;
+	struct cpumask msk;
 
 	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
 	if (!dl_task(p) || dl_entity_is_special(&p->dl)) {
@@ -2891,16 +2923,22 @@ void dl_add_task_root_domain(struct task_struct *p)
 		return;
 	}
 
-	rq = __task_rq_lock(p, &rf);
-
+	/*
+	 * Get an active rq, whose rq->rd traces the correct root
+	 * domain.
+	 * And the caller should hold cpuset_mutex, which gurantees
+	 * the cpu remaining in the cpuset until rq->rd is fetched.
+	 */
+	dl_get_task_effective_cpus(p, &msk);
+	cpu = cpumask_first_and(cpu_active_mask, &msk);
+	BUG_ON(cpu >= nr_cpu_ids);
+	rq = cpu_rq(cpu);
 	dl_b = &rq->rd->dl_bw;
-	raw_spin_lock(&dl_b->lock);
 
+	raw_spin_lock(&dl_b->lock);
 	__dl_add(dl_b, p->dl.dl_bw, cpumask_weight(rq->rd->span));
-
 	raw_spin_unlock(&dl_b->lock);
-
-	task_rq_unlock(rq, p, &rf);
+	raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
 }
 
 void dl_clear_root_domain(struct root_domain *rd)
-- 
2.49.0



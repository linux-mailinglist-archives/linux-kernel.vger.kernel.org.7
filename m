Return-Path: <linux-kernel+bounces-854980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 946FABDFE14
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E3D1541882
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3634333EB01;
	Wed, 15 Oct 2025 17:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KNqrQDHS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FaGmoJnP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFF0342C9E
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760549395; cv=none; b=bZJTcIkgxpoLUKQAObD2px76omA7ZM0KLKhZhV9qwjAYy20/vPryIG0eEkoaEX/w1n2ylIQkjmLnLjSPZ3AWXqbNu1we2B2PcborW1gJH37Jg0TAHdtEYWFQUmcEOuH99dLzSGKFv8xy/c3BOWGrMyh+MNkAmqnXWxSyQc2qC8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760549395; c=relaxed/simple;
	bh=5D0C1mmQsDAxcuzxoXCEVjtkgh+jZcBXlKnMVVKR6tQ=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=SnoSlPpFSyUBuqiQ30ai45r1sViFH1FAUdTu+w6eZ3vEoPGGrp7ljdCRM2UpyXSSC20aoNSqJsqom9QLJYX5YXOZAJo4SdtABq5NBGYPVVrur3iXX+Dijt4i01c1j+G+raOXWA3Adjbvh6J566+5t7m8GuMR4VVDdhzQXTpmvak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KNqrQDHS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FaGmoJnP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251015172835.190173603@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760549391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=pFVciMXUyxyULBxl1v3fLMw6h0CcuKGrvokqooQX3wk=;
	b=KNqrQDHS2yqMqDY+mjoAjK8spHSOnJiyAQBfOZI+u5p9TDuVC4QnfAw4XKJa59Nd1VquVr
	8s5bWtUXl45zp/XvIkLVjgI/lLyi1nuMAUxPjfyjwATRbZQvqBMPKMIjne308mewrfLzj0
	EVYfH3CF5/ebMW1A5Mbd4fBPdAvqnCj27keybyH6CQ/TPNNWJxYAld1sAHBaUJlYRfRVms
	om0nKXtFBYRw6jH1yhLmLi9wl4iJQ0Unf6Rju/YIDk34Ljci4EBOoMUMDjAYU3W5Vab6zP
	hZMHTaWpBzs+ev/Yxbb9+GmoNRTI3Tu4BJe2NDO4R62L6V46Jf+1HPOK66ON7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760549391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=pFVciMXUyxyULBxl1v3fLMw6h0CcuKGrvokqooQX3wk=;
	b=FaGmoJnPRSn3eZom8LcojLl+984lhEkBN9qC0TPXSgelN8qq+ibqOvxXPkyAgUqGlUo97U
	AM7qIpMuhmnApsCw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Michael Jeanson <mjeanson@efficios.com>,
 Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Florian Weimer <fweimer@redhat.com>,
 Tim Chen <tim.c.chen@intel.com>,
 TCMalloc Team <tcmalloc-eng@google.com>
Subject: [patch 14/19] sched/mmcid: Introduce per task/CPU ownership
 infrastrcuture
References: <20251015164952.694882104@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Oct 2025 19:29:50 +0200 (CEST)

The MM CID management has two fundamental requirements:

  1) It has to guarantee that at no given point in time the same CID is
     used by concurrent tasks in userspace.

  2) The CID space must not exceed the number of possible CPUs in a
     system. While most allocators (glibc, tcmalloc, jemalloc) do not
     care about that, there seems to be at least some LTTng library
     depending on it.

The CID space compaction itself is not a functional correctness
requirement, it is only a useful optimization mechanism to reduce the
memory foot print in unused user space pools.

The optimal CID space is:

    min(nr_tasks, nr_cpus_allowed);

Where @nr_tasks is the number of actual user space threads associated to
the mm and @nr_cpus_allowed is the superset of all task affinities. It is
growth only as it would be insane to take a racy snapshot of all task
affinities when the affinity of one task changes just do redo it 2
milliseconds later when the next task changes it's affinity.

That means that as long as the number of tasks is lower or equal than the
number of CPUs allowed, each task owns a CID. If the number of tasks
exceeds the number of CPUs allowed it switches to per CPU mode, where the
CPUs own the CIDs and the tasks borrow them as long as they are scheduled
in.

For transition periods CIDs can go beyond the optimal space as long as they
don't go beyond the number of possible CPUs.

The current upstream implementation tries to keep the CID with the task
even in overcommit situations, which complicates task migration. It also
has to do the CID space consolidation work from a task work in the exit to
user space path. As that work is assigned to a random task related to a MM
this can inflict unwanted exit latencies.

This can be done differently by implementing a strict CID ownership
mechanism. Either the CIDs are owned by the tasks or by the CPUs. The
latter provides less locality when tasks are heavily migrating, but there
is no justification to optimize for overcommit scenarios and thereby
penalazing everyone else.

Provide the basic infrastructure to implement this:

  - Change the UNSET marker to BIT(31) from ~0U
  - Add the ONCPU marker as BIT(30)

That allows to check for ownership trivialy and provides a simple check for
UNSET as well.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/rseq_types.h |    3 ++-
 include/linux/sched.h      |    6 +++---
 kernel/sched/core.c        |    7 +++++++
 kernel/sched/sched.h       |   44 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 56 insertions(+), 4 deletions(-)

--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -92,7 +92,8 @@ struct rseq_data { };
 
 #ifdef CONFIG_SCHED_MM_CID
 
-#define MM_CID_UNSET	(~0U)
+#define MM_CID_UNSET	BIT(31)
+#define MM_CID_ONCPU	BIT(30)
 
 /**
  * struct sched_mm_cid - Storage for per task MM CID data
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2291,16 +2291,16 @@ void sched_mm_cid_before_execve(struct t
 void sched_mm_cid_after_execve(struct task_struct *t);
 void sched_mm_cid_fork(struct task_struct *t);
 void sched_mm_cid_exit(struct task_struct *t);
-static inline int task_mm_cid(struct task_struct *t)
+static __always_inline int task_mm_cid(struct task_struct *t)
 {
-	return t->mm_cid.cid;
+	return t->mm_cid.cid & ~MM_CID_ONCPU;
 }
 #else
 static inline void sched_mm_cid_before_execve(struct task_struct *t) { }
 static inline void sched_mm_cid_after_execve(struct task_struct *t) { }
 static inline void sched_mm_cid_fork(struct task_struct *t) { }
 static inline void sched_mm_cid_exit(struct task_struct *t) { }
-static inline int task_mm_cid(struct task_struct *t)
+static __always_inline int task_mm_cid(struct task_struct *t)
 {
 	/*
 	 * Use the processor id as a fall-back when the mm cid feature is
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10418,6 +10418,13 @@ void call_trace_sched_update_nr_running(
  *
  * The mm::mm_cid:pcpu per CPU storage is protected by the CPUs runqueue
  * lock.
+ *
+ * CID ownership:
+ *
+ * A CID is either owned by a task (stored in task_struct::mm_cid.cid) or
+ * by a CPU (stored in mm::mm_cid.pcpu::cid). CIDs owned by CPUs have the
+ * MM_CID_ONCPU bit set. This bit is filtered out by task_cid() when it
+ * is actualy handed over to user space in the RSEQ memory.
  */
 
 /*
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3534,6 +3534,50 @@ extern void sched_dynamic_update(int mod
 extern const char *preempt_modes[];
 
 #ifdef CONFIG_SCHED_MM_CID
+
+static __always_inline bool cid_on_cpu(unsigned int cid)
+{
+	return cid & MM_CID_ONCPU;
+}
+
+static __always_inline unsigned int cpu_cid_to_cid(unsigned int cid)
+{
+	return cid & ~MM_CID_ONCPU;
+}
+
+static __always_inline unsigned int cid_to_cpu_cid(unsigned int cid)
+{
+	return cid | MM_CID_ONCPU;
+}
+
+static __always_inline bool cid_on_task(unsigned int cid)
+{
+	/* True if neither MM_CID_ONCPU nor MM_CID_UNSET set */
+	return cid < MM_CID_ONCPU;
+}
+
+static __always_inline void mm_drop_cid(struct mm_struct *mm, unsigned int cid)
+{
+	clear_bit(cid, mm_cidmask(mm));
+}
+
+static __always_inline void mm_unset_cid_on_task(struct task_struct *t)
+{
+	unsigned int cid = t->mm_cid.cid;
+
+	t->mm_cid.cid = MM_CID_UNSET;
+	if (cid_on_task(cid))
+		mm_drop_cid(t->mm, cid);
+}
+
+static __always_inline void mm_drop_cid_on_cpu(struct mm_struct *mm, struct mm_cid_pcpu *pcp)
+{
+	/* Clear the ONCPU bit, but do not set UNSET in the per CPU storage */
+	pcp->cid = cpu_cid_to_cid(pcp->cid);
+	mm_drop_cid(mm, pcp->cid);
+}
+
+/* Active implementation */
 static inline void init_sched_mm_cid(struct task_struct *t)
 {
 	struct mm_struct *mm = t->mm;



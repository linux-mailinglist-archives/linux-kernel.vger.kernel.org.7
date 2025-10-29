Return-Path: <linux-kernel+bounces-876125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E79D8C1AA57
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB9D51A221B1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224242139CE;
	Wed, 29 Oct 2025 13:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="11kdUagI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MiCbPjB9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E4134D4E2
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743367; cv=none; b=dQpgmfCiNdVhCglSaLSIPI0TVYGZDVjbV5w+s2GY1A6T5AvW4AD+GLJO+yuJAg0AMAs9oFdtb+nGl3H3Rkp+adLx5fTqBXVWouWWLbJ7RjPwDYJVJFmbd1t3iT4zQNLloogQiNfQz6h2hqWyeEd8LmNrQ60VnlHMtTybzdofPcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743367; c=relaxed/simple;
	bh=LhoeG5Sl5U1YvG2tcNa1+c1VLUr8frqFbogewBECCaE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=cWQwMsu3nqxytrXguP1SRL7QgNYI0jmmHfA2XEr0iQkafqKpAXv8P7Kmemq6OBAxOKPTH3N3UgI2snOOoSV3chR02fa9w3LwpN3747kQb/krWjJFPRib2L0CFwU79aeVM8GxxhSK+mazwLF83GrbUqOBNRZ9TDLsfZmAGRmZefE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=11kdUagI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MiCbPjB9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251029124516.221091724@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761743363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=sr7XuKZQPrnCIhneABHVkNv/cYzkTVEaqBtcQ7pzXPw=;
	b=11kdUagIe/bz9DsBqLmlyo3KRlptIr1RrzI0AuAuR/DwoDCLIjUJkfIiaFkAMn+cdadNsi
	mVHvdZH5jSUQkk1oqgAcJuzlqTHE1d4zP9OrhU056yQ8EtetPb50bCh8sHiKw9IHEIVd1S
	NWvLtcd1TqflzrDKrInHkgrDsCFiHfOWMRaXnNmKGL4PKZQBYXtSQlDagmAQkkS3pcARxW
	VFbD9wTOijv035OS9NEUjHC91AIkATwFLEDU7Rtyl2uDIgOKR9bn2gA9VW9Ueg0tg2fHzJ
	q4QT0/d8fQtc1tKqGgw1DdZITJeHqCRwBEDetLag1VCyZuDptEjMOKkAiLJ7wA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761743363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=sr7XuKZQPrnCIhneABHVkNv/cYzkTVEaqBtcQ7pzXPw=;
	b=MiCbPjB9jPDW5eW1BS7SkNnj/jqHT4Ljxj8hMhTS2sbeY/amoxICh32LP87LfehvPAqH4z
	mDtTXXle7YB+14CQ==
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
 Yury Norov <yury.norov@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [patch V3 15/20] sched/mmcid: Introduce per task/CPU ownership
 infrastrcuture
References: <20251029123717.886619142@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Oct 2025 14:09:22 +0100 (CET)

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
  - Add the TRANSIT marker as BIT(29)

That allows to check for ownership trivialy and provides a simple check for
UNSET as well. The TRANSIT marker is required to prevent CID space
exhaustion when switching from per CPU to per task mode.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Add the TRANSIT(ion) bit
---
 include/linux/rseq_types.h |    4 ++-
 include/linux/sched.h      |    6 ++--
 kernel/sched/core.c        |   10 +++++++
 kernel/sched/sched.h       |   59 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 75 insertions(+), 4 deletions(-)

--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -92,7 +92,9 @@ struct rseq_data { };
 
 #ifdef CONFIG_SCHED_MM_CID
 
-#define MM_CID_UNSET	(~0U)
+#define MM_CID_UNSET	BIT(31)
+#define MM_CID_ONCPU	BIT(30)
+#define MM_CID_TRANSIT	BIT(29)
 
 /**
  * struct sched_mm_cid - Storage for per task MM CID data
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2299,16 +2299,16 @@ void sched_mm_cid_before_execve(struct t
 void sched_mm_cid_after_execve(struct task_struct *t);
 void sched_mm_cid_fork(struct task_struct *t);
 void sched_mm_cid_exit(struct task_struct *t);
-static inline int task_mm_cid(struct task_struct *t)
+static __always_inline int task_mm_cid(struct task_struct *t)
 {
-	return t->mm_cid.cid;
+	return t->mm_cid.cid & ~(MM_CID_ONCPU | MM_CID_TRANSIT);
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
@@ -10384,6 +10384,16 @@ void call_trace_sched_update_nr_running(
  *
  * The mm::mm_cid:pcpu per CPU storage is protected by the CPUs runqueue
  * lock.
+ *
+ * CID ownership:
+ *
+ * A CID is either owned by a task (stored in task_struct::mm_cid.cid) or
+ * by a CPU (stored in mm::mm_cid.pcpu::cid). CIDs owned by CPUs have the
+ * MM_CID_ONCPU bit set. During transitioning from CPU to task ownership
+ * mode, MM_CID_TRANSIT is set on the per task CIDs. When this bit is set
+ * the task needs to drop the CID into the pool when scheduling out.  Both
+ * bits (ONCPU and TRANSIT) are filtered out by task_cid() when the CID is
+ * actualy handed over to user space in the RSEQ memory.
  */
 
 /*
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3539,6 +3539,65 @@ extern void sched_dynamic_update(int mod
 extern const char *preempt_modes[];
 
 #ifdef CONFIG_SCHED_MM_CID
+
+static __always_inline bool cid_on_cpu(unsigned int cid)
+{
+	return cid & MM_CID_ONCPU;
+}
+
+static __always_inline bool cid_in_transit(unsigned int cid)
+{
+	return cid & MM_CID_TRANSIT;
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
+static __always_inline unsigned int cid_to_transit_cid(unsigned int cid)
+{
+	return cid | MM_CID_TRANSIT;
+}
+
+static __always_inline unsigned int cid_from_transit_cid(unsigned int cid)
+{
+	return cid & ~MM_CID_TRANSIT;
+}
+
+static __always_inline bool cid_on_task(unsigned int cid)
+{
+	/* True if none of the MM_CID_ONCPU, MM_CID_TRANSIT, MM_CID_UNSET bits is set */
+	return cid < MM_CID_TRANSIT;
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



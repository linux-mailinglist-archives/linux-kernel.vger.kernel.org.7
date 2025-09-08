Return-Path: <linux-kernel+bounces-806813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12004B49C11
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2D674E8048
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5B731E0E7;
	Mon,  8 Sep 2025 21:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uW4wqEFG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yc52Wj7A"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C212431DD9B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 21:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757367140; cv=none; b=rf9L0BhAj6KEz+lpAwth9dwK5d5BjoLsm5TwcAA38ZGzQKHyPvXuPl8BbLuoH8b4uFRq3d8dRtW86xK0Ktsw/DhV66ubxN/0+7VpomN37tuLtqosx/sqqcI6bmDMgL8hmLHJD5WAKDkhZeMAtISR+15ed26PtRC+3KFVCFZfmsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757367140; c=relaxed/simple;
	bh=KoFx7H48QgTYYZ1ncCsTwgCB2WRGHMMPmefaGvA2e+c=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=kLofPeQ4ESCJXl9vxbksFRreNVmueSZfed5XQotfp9wbPvq94XNtLcTXcU4UknXJrosDHMqU7fQ9s3R8gs7CdTigwdcOWOAOQEtLj0z81hdSBOl5Ol2VCsXzj07WKMoedqYVre4aCujFHG3v1+gb29e2/sDHnSdqsjAJ2Vn43S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uW4wqEFG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yc52Wj7A; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250908212926.738408636@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757367134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=RgAO6SRDFgdUFTLBQFmDwz0XnqoZQI0kcYu14GHCI2E=;
	b=uW4wqEFGS0dI8fBxB3ykQURoj7X/2SUoy7IfXW2vRX9+Ion8LuFnL+Kb2hOkfNQbVQ2smV
	k+QeI0n9lPt0xIBHvDBzGH1UmQ5M7SToGIiVd4a8TMXoQdlusd0ZWHu1csXSTDJC1AKMT2
	AvVUi81OBpXJPKkH5sxDJhmfG+tevwFbwAfLB2zUu6i9n18qYbmr++WzdXLLOuFIcEWf89
	VuOn8w6Nu/6qqOM0nhXSaVCy0UhMzd85Os6FXqQzE+84bFBOnrgcU/8fM4/HGGTSOSFiML
	V0rRePfvN4z6wvGAMaIU4j8oU+spOBzAVp9NRxTPCuohfU9PDHJ66vUw/6+6rQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757367134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=RgAO6SRDFgdUFTLBQFmDwz0XnqoZQI0kcYu14GHCI2E=;
	b=yc52Wj7ADnCvSGWJuOibXcLyZ/XFRSrt/P8HbOUsuXRPvLrzxjfBOy8cb5sSsfZoUjexzS
	0BEl/YMmRKaxeLBQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Jens Axboe <axboe@kernel.dk>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [patch V4 23/36] rseq: Provide and use rseq_set_ids()
References: <20250908212737.353775467@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  8 Sep 2025 23:32:12 +0200 (CEST)

Provide a new and straight forward implementation to set the IDs (CPU ID,
Node ID and MM CID), which can be later inlined into the fast path.

It does all operations in one user_rw_masked_begin() section and retrieves
also the critical section member (rseq::cs_rseq) from user space to avoid
another user..begin/end() pair. This is in preparation for optimizing the
fast path to avoid extra work when not required.

Use it to replace the whole related zoo in rseq.c

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: Fixed the node ID comparison in the debug path - Mathieu
---
 fs/binfmt_elf.c            |    2 
 include/linux/rseq_entry.h |  101 +++++++++++++++++++++
 include/linux/sched.h      |   10 --
 kernel/rseq.c              |  208 ++++++---------------------------------------
 4 files changed, 134 insertions(+), 187 deletions(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -46,7 +46,7 @@
 #include <linux/cred.h>
 #include <linux/dax.h>
 #include <linux/uaccess.h>
-#include <linux/rseq.h>
+#include <uapi/linux/rseq.h>
 #include <asm/param.h>
 #include <asm/page.h>
 
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -38,6 +38,8 @@ DECLARE_PER_CPU(struct rseq_stats, rseq_
 #include <linux/rseq.h>
 #include <linux/uaccess.h>
 
+#include <uapi/linux/rseq.h>
+
 #include <linux/tracepoint-defs.h>
 
 #ifdef CONFIG_TRACEPOINTS
@@ -75,6 +77,7 @@ DECLARE_STATIC_KEY_MAYBE(CONFIG_RSEQ_DEB
 #endif
 
 bool rseq_debug_update_user_cs(struct task_struct *t, struct pt_regs *regs, unsigned long csaddr);
+bool rseq_debug_validate_ids(struct task_struct *t);
 
 static __always_inline void rseq_note_user_irq_entry(void)
 {
@@ -196,6 +199,50 @@ bool rseq_debug_update_user_cs(struct ta
 	user_access_end();
 	return false;
 }
+
+/*
+ * On debug kernels validate that user space did not mess with it if
+ * DEBUG_RSEQ is enabled, but don't on the first exit to user space. In
+ * that case cpu_cid is ~0. See fork/execve.
+ */
+bool rseq_debug_validate_ids(struct task_struct *t)
+{
+	struct rseq __user *rseq = t->rseq.usrptr;
+	u32 cpu_id, uval, node_id;
+
+	if (t->rseq.ids.cpu_cid == ~0)
+		return true;
+
+	/*
+	 * Look it up outside of the user access section as cpu_to_node()
+	 * can end up in debug code.
+	 */
+	node_id = cpu_to_node(t->rseq.ids.cpu_id);
+
+	if (!user_read_masked_begin(rseq))
+		return false;
+
+	unsafe_get_user(cpu_id, &rseq->cpu_id_start, efault);
+	if (cpu_id != t->rseq.ids.cpu_id)
+		goto die;
+	unsafe_get_user(uval, &rseq->cpu_id, efault);
+	if (uval != cpu_id)
+		goto die;
+	unsafe_get_user(uval, &rseq->node_id, efault);
+	if (uval != node_id)
+		goto die;
+	unsafe_get_user(uval, &rseq->mm_cid, efault);
+	if (uval != t->rseq.ids.mm_cid)
+		goto die;
+	user_access_end();
+	return true;
+die:
+	t->rseq.event.fatal = true;
+efault:
+	user_access_end();
+	return false;
+}
+
 #endif /* RSEQ_BUILD_SLOW_PATH */
 
 /*
@@ -281,6 +328,60 @@ rseq_update_user_cs(struct task_struct *
 	user_access_end();
 	return false;
 }
+
+/*
+ * Updates CPU ID, Node ID and MM CID and reads the critical section
+ * address, when @csaddr != NULL. This allows to put the ID update and the
+ * read under the same uaccess region to spare a seperate begin/end.
+ *
+ * As this is either invoked from a C wrapper with @csaddr = NULL or from
+ * the fast path code with a valid pointer, a clever compiler should be
+ * able to optimize the read out. Spares a duplicate implementation.
+ *
+ * Returns true, if the operation was successful, false otherwise.
+ *
+ * In the failure case task::rseq_event::fatal is set when invalid data
+ * was found on debug kernels. It's clear when the failure was an unresolved page
+ * fault.
+ *
+ * If inlined into the exit to user path with interrupts disabled, the
+ * caller has to protect against page faults with pagefault_disable().
+ *
+ * In preemptible task context this would be counterproductive as the page
+ * faults could not be fully resolved. As a consequence unresolved page
+ * faults in task context are fatal too.
+ */
+static rseq_inline
+bool rseq_set_ids_get_csaddr(struct task_struct *t, struct rseq_ids *ids,
+			     u32 node_id, u64 *csaddr)
+{
+	struct rseq __user *rseq = t->rseq.usrptr;
+
+	if (static_branch_unlikely(&rseq_debug_enabled)) {
+		if (!rseq_debug_validate_ids(t))
+			return false;
+	}
+
+	if (!user_rw_masked_begin(rseq))
+		return false;
+
+	unsafe_put_user(ids->cpu_id, &rseq->cpu_id_start, efault);
+	unsafe_put_user(ids->cpu_id, &rseq->cpu_id, efault);
+	unsafe_put_user(node_id, &rseq->node_id, efault);
+	unsafe_put_user(ids->mm_cid, &rseq->mm_cid, efault);
+	if (csaddr)
+		unsafe_get_user(*csaddr, &rseq->rseq_cs, efault);
+	user_access_end();
+
+	/* Cache the new values */
+	t->rseq.ids.cpu_cid = ids->cpu_cid;
+	rseq_stat_inc(rseq_stats.ids);
+	rseq_trace_update(t, ids);
+	return true;
+efault:
+	user_access_end();
+	return false;
+}
 
 static __always_inline void rseq_exit_to_user_mode(void)
 {
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -42,7 +42,6 @@
 #include <linux/posix-timers_types.h>
 #include <linux/restart_block.h>
 #include <linux/rseq_types.h>
-#include <uapi/linux/rseq.h>
 #include <linux/seqlock_types.h>
 #include <linux/kcsan.h>
 #include <linux/rv.h>
@@ -1402,15 +1401,6 @@ struct task_struct {
 #endif /* CONFIG_NUMA_BALANCING */
 
 	struct rseq_data		rseq;
-#ifdef CONFIG_DEBUG_RSEQ
-	/*
-	 * This is a place holder to save a copy of the rseq fields for
-	 * validation of read-only fields. The struct rseq has a
-	 * variable-length array at the end, so it cannot be used
-	 * directly. Reserve a size large enough for the known fields.
-	 */
-	char				rseq_fields[sizeof(struct rseq)];
-#endif
 
 #ifdef CONFIG_SCHED_MM_CID
 	int				mm_cid;		/* Current cid in mm */
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -88,13 +88,6 @@
 # define RSEQ_EVENT_GUARD	preempt
 #endif
 
-/* The original rseq structure size (including padding) is 32 bytes. */
-#define ORIG_RSEQ_SIZE		32
-
-#define RSEQ_CS_NO_RESTART_FLAGS (RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT | \
-				  RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL | \
-				  RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE)
-
 DEFINE_STATIC_KEY_MAYBE(CONFIG_RSEQ_DEBUG_DEFAULT_ENABLE, rseq_debug_enabled);
 
 static inline void rseq_control_debug(bool on)
@@ -227,159 +220,9 @@ static int __init rseq_debugfs_init(void
 __initcall(rseq_debugfs_init);
 #endif /* CONFIG_DEBUG_FS */
 
-#ifdef CONFIG_DEBUG_RSEQ
-static struct rseq *rseq_kernel_fields(struct task_struct *t)
-{
-	return (struct rseq *) t->rseq_fields;
-}
-
-static int rseq_validate_ro_fields(struct task_struct *t)
-{
-	static DEFINE_RATELIMIT_STATE(_rs,
-				      DEFAULT_RATELIMIT_INTERVAL,
-				      DEFAULT_RATELIMIT_BURST);
-	u32 cpu_id_start, cpu_id, node_id, mm_cid;
-	struct rseq __user *rseq = t->rseq.usrptr;
-
-	/*
-	 * Validate fields which are required to be read-only by
-	 * user-space.
-	 */
-	if (!user_read_access_begin(rseq, t->rseq.len))
-		goto efault;
-	unsafe_get_user(cpu_id_start, &rseq->cpu_id_start, efault_end);
-	unsafe_get_user(cpu_id, &rseq->cpu_id, efault_end);
-	unsafe_get_user(node_id, &rseq->node_id, efault_end);
-	unsafe_get_user(mm_cid, &rseq->mm_cid, efault_end);
-	user_read_access_end();
-
-	if ((cpu_id_start != rseq_kernel_fields(t)->cpu_id_start ||
-	    cpu_id != rseq_kernel_fields(t)->cpu_id ||
-	    node_id != rseq_kernel_fields(t)->node_id ||
-	    mm_cid != rseq_kernel_fields(t)->mm_cid) && __ratelimit(&_rs)) {
-
-		pr_warn("Detected rseq corruption for pid: %d, name: %s\n"
-			"\tcpu_id_start: %u ?= %u\n"
-			"\tcpu_id:       %u ?= %u\n"
-			"\tnode_id:      %u ?= %u\n"
-			"\tmm_cid:       %u ?= %u\n",
-			t->pid, t->comm,
-			cpu_id_start, rseq_kernel_fields(t)->cpu_id_start,
-			cpu_id, rseq_kernel_fields(t)->cpu_id,
-			node_id, rseq_kernel_fields(t)->node_id,
-			mm_cid, rseq_kernel_fields(t)->mm_cid);
-	}
-
-	/* For now, only print a console warning on mismatch. */
-	return 0;
-
-efault_end:
-	user_read_access_end();
-efault:
-	return -EFAULT;
-}
-
-/*
- * Update an rseq field and its in-kernel copy in lock-step to keep a coherent
- * state.
- */
-#define rseq_unsafe_put_user(t, value, field, error_label)			\
-	do {									\
-		unsafe_put_user(value, &t->rseq.usrptr->field, error_label);	\
-		rseq_kernel_fields(t)->field = value;				\
-	} while (0)
-
-#else
-static int rseq_validate_ro_fields(struct task_struct *t)
-{
-	return 0;
-}
-
-#define rseq_unsafe_put_user(t, value, field, error_label)		\
-	unsafe_put_user(value, &t->rseq.usrptr->field, error_label)
-#endif
-
-static int rseq_update_cpu_node_id(struct task_struct *t)
-{
-	struct rseq __user *rseq = t->rseq.usrptr;
-	u32 cpu_id = raw_smp_processor_id();
-	u32 node_id = cpu_to_node(cpu_id);
-	u32 mm_cid = task_mm_cid(t);
-
-	rseq_stat_inc(rseq_stats.ids);
-
-	/* Validate read-only rseq fields on debug kernels */
-	if (rseq_validate_ro_fields(t))
-		goto efault;
-	WARN_ON_ONCE((int) mm_cid < 0);
-
-	if (!user_write_access_begin(rseq, t->rseq.len))
-		goto efault;
-
-	rseq_unsafe_put_user(t, cpu_id, cpu_id_start, efault_end);
-	rseq_unsafe_put_user(t, cpu_id, cpu_id, efault_end);
-	rseq_unsafe_put_user(t, node_id, node_id, efault_end);
-	rseq_unsafe_put_user(t, mm_cid, mm_cid, efault_end);
-
-	/* Cache the user space values */
-	t->rseq.ids.cpu_id = cpu_id;
-	t->rseq.ids.mm_cid = mm_cid;
-
-	/*
-	 * Additional feature fields added after ORIG_RSEQ_SIZE
-	 * need to be conditionally updated only if
-	 * t->rseq_len != ORIG_RSEQ_SIZE.
-	 */
-	user_write_access_end();
-	trace_rseq_update(t);
-	return 0;
-
-efault_end:
-	user_write_access_end();
-efault:
-	return -EFAULT;
-}
-
-static int rseq_reset_rseq_cpu_node_id(struct task_struct *t)
+static bool rseq_set_ids(struct task_struct *t, struct rseq_ids *ids, u32 node_id)
 {
-	struct rseq __user *rseq = t->rseq.usrptr;
-	u32 cpu_id_start = 0, cpu_id = RSEQ_CPU_ID_UNINITIALIZED, node_id = 0,
-	    mm_cid = 0;
-
-	/*
-	 * Validate read-only rseq fields.
-	 */
-	if (rseq_validate_ro_fields(t))
-		goto efault;
-
-	if (!user_write_access_begin(rseq, t->rseq.len))
-		goto efault;
-
-	/*
-	 * Reset all fields to their initial state.
-	 *
-	 * All fields have an initial state of 0 except cpu_id which is set to
-	 * RSEQ_CPU_ID_UNINITIALIZED, so that any user coming in after
-	 * unregistration can figure out that rseq needs to be registered
-	 * again.
-	 */
-	rseq_unsafe_put_user(t, cpu_id_start, cpu_id_start, efault_end);
-	rseq_unsafe_put_user(t, cpu_id, cpu_id, efault_end);
-	rseq_unsafe_put_user(t, node_id, node_id, efault_end);
-	rseq_unsafe_put_user(t, mm_cid, mm_cid, efault_end);
-
-	/*
-	 * Additional feature fields added after ORIG_RSEQ_SIZE
-	 * need to be conditionally reset only if
-	 * t->rseq_len != ORIG_RSEQ_SIZE.
-	 */
-	user_write_access_end();
-	return 0;
-
-efault_end:
-	user_write_access_end();
-efault:
-	return -EFAULT;
+	return rseq_set_ids_get_csaddr(t, ids, node_id, NULL);
 }
 
 static bool rseq_handle_cs(struct task_struct *t, struct pt_regs *regs)
@@ -407,6 +250,8 @@ static bool rseq_handle_cs(struct task_s
 void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
 {
 	struct task_struct *t = current;
+	struct rseq_ids ids;
+	u32 node_id;
 	bool event;
 	int sig;
 
@@ -453,6 +298,8 @@ void __rseq_handle_notify_resume(struct
 	scoped_guard(RSEQ_EVENT_GUARD) {
 		event = t->rseq.event.sched_switch;
 		t->rseq.event.sched_switch = false;
+		ids.cpu_id = task_cpu(t);
+		ids.mm_cid = task_mm_cid(t);
 	}
 
 	if (!IS_ENABLED(CONFIG_DEBUG_RSEQ) && !event)
@@ -461,7 +308,8 @@ void __rseq_handle_notify_resume(struct
 	if (!rseq_handle_cs(t, regs))
 		goto error;
 
-	if (unlikely(rseq_update_cpu_node_id(t)))
+	node_id = cpu_to_node(ids.cpu_id);
+	if (!rseq_set_ids(t, &ids, node_id))
 		goto error;
 	return;
 
@@ -502,13 +350,33 @@ void rseq_syscall(struct pt_regs *regs)
 }
 #endif
 
+static bool rseq_reset_ids(void)
+{
+	struct rseq_ids ids = {
+		.cpu_id		= RSEQ_CPU_ID_UNINITIALIZED,
+		.mm_cid		= 0,
+	};
+
+	/*
+	 * If this fails, terminate it because this leaves the kernel in
+	 * stupid state as exit to user space will try to fixup the ids
+	 * again.
+	 */
+	if (rseq_set_ids(current, &ids, 0))
+		return true;
+
+	force_sig(SIGSEGV);
+	return false;
+}
+
+/* The original rseq structure size (including padding) is 32 bytes. */
+#define ORIG_RSEQ_SIZE		32
+
 /*
  * sys_rseq - setup restartable sequences for caller thread.
  */
 SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len, int, flags, u32, sig)
 {
-	int ret;
-
 	if (flags & RSEQ_FLAG_UNREGISTER) {
 		if (flags & ~RSEQ_FLAG_UNREGISTER)
 			return -EINVAL;
@@ -519,9 +387,8 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
 			return -EINVAL;
 		if (current->rseq.sig != sig)
 			return -EPERM;
-		ret = rseq_reset_rseq_cpu_node_id(current);
-		if (ret)
-			return ret;
+		if (!rseq_reset_ids())
+			return -EFAULT;
 		rseq_reset(current);
 		return 0;
 	}
@@ -571,17 +438,6 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
 	if (put_user_masked_u64(0UL, &rseq->rseq_cs))
 		return -EFAULT;
 
-#ifdef CONFIG_DEBUG_RSEQ
-	/*
-	 * Initialize the in-kernel rseq fields copy for validation of
-	 * read-only fields.
-	 */
-	if (get_user(rseq_kernel_fields(current)->cpu_id_start, &rseq->cpu_id_start) ||
-	    get_user(rseq_kernel_fields(current)->cpu_id, &rseq->cpu_id) ||
-	    get_user(rseq_kernel_fields(current)->node_id, &rseq->node_id) ||
-	    get_user(rseq_kernel_fields(current)->mm_cid, &rseq->mm_cid))
-		return -EFAULT;
-#endif
 	/*
 	 * Activate the registration by setting the rseq area address, length
 	 * and signature in the task struct.



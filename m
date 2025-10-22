Return-Path: <linux-kernel+bounces-864985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 096F5BFBFF3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E59454177E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C0934C810;
	Wed, 22 Oct 2025 12:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="svVHlTbF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dzrJpEM/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641DA34B42C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137553; cv=none; b=j7W37lKctE9dOPJdMNQiw+m+4pNGun1Ow3FpMlo3hzmxp4Sy6/A29Rd4wxFI4zeTLLk8Vi4x7T+uhhWqLIDY8YLipDwt/3lhVNs/MJlY54XsGicIQyowtF1jlLIXZOuGjgBkT0uq6DTCeB4W11+6O3bcA011LiAdH4TZug6vfpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137553; c=relaxed/simple;
	bh=wnpyS7MR6j5AX9Njs9cGtEsemOrL9f0wJ2cL5/IM25U=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=SpbuBmnzj0mTjXRiwbnTfag6uUgnTms7QsaF0etmr8U9e8zkZLV502v4so/xLMLxAHjAcLeff8W10vPyD1ku5iVvVXOedH7P460TNDQGiA+sSu0rR85QVG9oI6VK/QuKqiMTnCHfiXID8Tn4XTrWyA54qru5/ilDrCtFVT4MicI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=svVHlTbF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dzrJpEM/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022121942.601153876@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=qfsvAMLyGa4KdByhzd8WrGTjVPetwm5tPiglFumOTYs=;
	b=svVHlTbF2CDJmvEYv7uE1bcAIZmfYJFGUiZ6hLt/XjYNl9UBeqrtX3wBMuKrZ8KySODKis
	UqlaakDuN7EI1hEb3OxaQ57xJMoZBFhbD+OjT+Ho2OPLm4Svfn6bzgL3qgwU12eicmjRry
	58GfxXKSHrBY60WJShSx+wvT+EP7uv+DTijDq4GmV4xU9nB25+hcLb5z9/ITdWJBwhLiRk
	U78zPYaCCrMyl7j6CzcENR+44wo+WVVrpmLfJMXBqQUTAXxBwFBgJ9ycBMBW/RDnC9DiIG
	ByRil9cej0asEqdnnL49lDsa3BpPpy5MULSyrrEzlH88MfaaVPtbu0XihHq+gQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=qfsvAMLyGa4KdByhzd8WrGTjVPetwm5tPiglFumOTYs=;
	b=dzrJpEM/QJ2VSRXQyu/KW8Op150TjgO8VmiGhX4jPnJYdETZKT0zKTaXs5nfOHq602v9br
	LdA47KrcZraQ/eDw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Jens Axboe <axboe@kernel.dk>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 x86@kernel.org,
 Sean Christopherson <seanjc@google.com>,
 Wei Liu <wei.liu@kernel.org>
Subject: [patch V5 19/31] rseq: Provide and use rseq_update_user_cs()
References: <20251022121836.019469732@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:52:24 +0200 (CEST)

Provide a straight forward implementation to check for and eventually
clear/fixup critical sections in user space.

The non-debug version does only the minimal sanity checks and aims for
efficiency.

There are two attack vectors, which are checked for:

  1) An abort IP which is in the kernel address space. That would cause at
     least x86 to return to kernel space via IRET.

  2) A rogue critical section descriptor with an abort IP pointing to some
     arbitrary address, which is not preceded by the RSEQ signature.

If the section descriptors are invalid then the resulting misbehaviour of
the user space application is not the kernels problem.

The kernel provides a run-time switchable debug slow path, which implements
the full zoo of checks including termination of the task when one of the
gazillion conditions is not met.

Replace the zoo in rseq.c with it and invoke it from the TIF_NOTIFY_RESUME
handler. Move the remainders into the CONFIG_DEBUG_RSEQ section, which will
be replaced and removed in a subsequent step.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V5: Update comments and fix typos - Mathieu
V3: Brought back the signature check along with a comment - Mathieu
---
 include/linux/rseq_entry.h |  206 +++++++++++++++++++++++++++++++++++++
 include/linux/rseq_types.h |   11 +-
 kernel/rseq.c              |  244 +++++++++++++--------------------------------
 3 files changed, 290 insertions(+), 171 deletions(-)
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -36,6 +36,7 @@ DECLARE_PER_CPU(struct rseq_stats, rseq_
 #ifdef CONFIG_RSEQ
 #include <linux/jump_label.h>
 #include <linux/rseq.h>
+#include <linux/uaccess.h>
 
 #include <linux/tracepoint-defs.h>
 
@@ -67,12 +68,217 @@ static inline void rseq_trace_ip_fixup(u
 
 DECLARE_STATIC_KEY_MAYBE(CONFIG_RSEQ_DEBUG_DEFAULT_ENABLE, rseq_debug_enabled);
 
+#ifdef RSEQ_BUILD_SLOW_PATH
+#define rseq_inline
+#else
+#define rseq_inline __always_inline
+#endif
+
+bool rseq_debug_update_user_cs(struct task_struct *t, struct pt_regs *regs, unsigned long csaddr);
+
 static __always_inline void rseq_note_user_irq_entry(void)
 {
 	if (IS_ENABLED(CONFIG_GENERIC_IRQ_ENTRY))
 		current->rseq.event.user_irq = true;
 }
 
+/*
+ * Check whether there is a valid critical section and whether the
+ * instruction pointer in @regs is inside the critical section.
+ *
+ *  - If the critical section is invalid, terminate the task.
+ *
+ *  - If valid and the instruction pointer is inside, set it to the abort IP
+ *
+ *  - If valid and the instruction pointer is outside, clear the critical
+ *    section address.
+ *
+ * Returns true, if the section was valid and either fixup or clear was
+ * done, false otherwise.
+ *
+ * In the failure case task::rseq_event::fatal is set when a invalid
+ * section was found. It's clear when the failure was an unresolved page
+ * fault.
+ *
+ * If inlined into the exit to user path with interrupts disabled, the
+ * caller has to protect against page faults with pagefault_disable().
+ *
+ * In preemptible task context this would be counterproductive as the page
+ * faults could not be fully resolved. As a consequence unresolved page
+ * faults in task context are fatal too.
+ */
+
+#ifdef RSEQ_BUILD_SLOW_PATH
+/*
+ * The debug version is put out of line, but kept here so the code stays
+ * together.
+ *
+ * @csaddr has already been checked by the caller to be in user space
+ */
+bool rseq_debug_update_user_cs(struct task_struct *t, struct pt_regs *regs,
+			       unsigned long csaddr)
+{
+	struct rseq_cs __user *ucs = (struct rseq_cs __user *)(unsigned long)csaddr;
+	u64 start_ip, abort_ip, offset, cs_end, head, tasksize = TASK_SIZE;
+	unsigned long ip = instruction_pointer(regs);
+	u64 __user *uc_head = (u64 __user *) ucs;
+	u32 usig, __user *uc_sig;
+
+	scoped_user_rw_access(ucs, efault) {
+		/*
+		 * Evaluate the user pile and exit if one of the conditions
+		 * is not fulfilled.
+		 */
+		unsafe_get_user(start_ip, &ucs->start_ip, efault);
+		if (unlikely(start_ip >= tasksize))
+			goto die;
+		/* If outside, just clear the critical section. */
+		if (ip < start_ip)
+			goto clear;
+
+		unsafe_get_user(offset, &ucs->post_commit_offset, efault);
+		cs_end = start_ip + offset;
+		/* Check for overflow and wraparound */
+		if (unlikely(cs_end >= tasksize || cs_end < start_ip))
+			goto die;
+
+		/* If not inside, clear it. */
+		if (ip >= cs_end)
+			goto clear;
+
+		unsafe_get_user(abort_ip, &ucs->abort_ip, efault);
+		/* Ensure it's "valid" */
+		if (unlikely(abort_ip >= tasksize || abort_ip < sizeof(*uc_sig)))
+			goto die;
+		/* Validate that the abort IP is not in the critical section */
+		if (unlikely(abort_ip - start_ip < offset))
+			goto die;
+
+		/*
+		 * Check version and flags for 0. No point in emitting
+		 * deprecated warnings before dying. That could be done in
+		 * the slow path eventually, but *shrug*.
+		 */
+		unsafe_get_user(head, uc_head, efault);
+		if (unlikely(head))
+			goto die;
+
+		/* abort_ip - 4 is >= 0. See abort_ip check above */
+		uc_sig = (u32 __user *)(unsigned long)(abort_ip - sizeof(*uc_sig));
+		unsafe_get_user(usig, uc_sig, efault);
+		if (unlikely(usig != t->rseq.sig))
+			goto die;
+
+		/* rseq_event.user_irq is only valid if CONFIG_GENERIC_IRQ_ENTRY=y */
+		if (IS_ENABLED(CONFIG_GENERIC_IRQ_ENTRY)) {
+			/* If not in interrupt from user context, let it die */
+			if (unlikely(!t->rseq.event.user_irq))
+				goto die;
+		}
+		unsafe_put_user(0ULL, &t->rseq.usrptr->rseq_cs, efault);
+		instruction_pointer_set(regs, (unsigned long)abort_ip);
+		rseq_stat_inc(rseq_stats.fixup);
+		break;
+	clear:
+		unsafe_put_user(0ULL, &t->rseq.usrptr->rseq_cs, efault);
+		rseq_stat_inc(rseq_stats.clear);
+		abort_ip = 0ULL;
+	}
+
+	if (unlikely(abort_ip))
+		rseq_trace_ip_fixup(ip, start_ip, offset, abort_ip);
+	return true;
+die:
+	t->rseq.event.fatal = true;
+efault:
+	return false;
+}
+
+#endif /* RSEQ_BUILD_SLOW_PATH */
+
+/*
+ * This only ensures that abort_ip is in the user address space and
+ * validates that it is preceded by the signature.
+ *
+ * No other sanity checks are done here, that's what the debug code is for.
+ */
+static rseq_inline bool
+rseq_update_user_cs(struct task_struct *t, struct pt_regs *regs, unsigned long csaddr)
+{
+	struct rseq_cs __user *ucs = (struct rseq_cs __user *)(unsigned long)csaddr;
+	unsigned long ip = instruction_pointer(regs);
+	u64 start_ip, abort_ip, offset;
+	u32 usig, __user *uc_sig;
+
+	rseq_stat_inc(rseq_stats.cs);
+
+	if (unlikely(csaddr >= TASK_SIZE)) {
+		t->rseq.event.fatal = true;
+		return false;
+	}
+
+	if (static_branch_unlikely(&rseq_debug_enabled))
+		return rseq_debug_update_user_cs(t, regs, csaddr);
+
+	scoped_user_rw_access(ucs, efault) {
+		unsafe_get_user(start_ip, &ucs->start_ip, efault);
+		unsafe_get_user(offset, &ucs->post_commit_offset, efault);
+		unsafe_get_user(abort_ip, &ucs->abort_ip, efault);
+
+		/*
+		 * No sanity checks. If user space screwed it up, it can
+		 * keep the pieces. That's what debug code is for.
+		 *
+		 * If outside, just clear the critical section.
+		 */
+		if (ip - start_ip >= offset)
+			goto clear;
+
+		/*
+		 * Two requirements for @abort_ip:
+		 *   - Must be in user space as x86 IRET would happily return to
+		 *     the kernel.
+		 *   - The four bytes preceding the instruction at @abort_ip must
+		 *     contain the signature.
+		 *
+		 * The latter protects against the following attack vector:
+		 *
+		 * An attacker with limited abilities to write, creates a critical
+		 * section descriptor, sets the abort IP to a library function or
+		 * some other ROP gadget and stores the address of the descriptor
+		 * in TLS::rseq::rseq_cs. An RSEQ abort would then evade ROP
+		 * protection.
+		 */
+		if (abort_ip >= TASK_SIZE || abort_ip < sizeof(*uc_sig))
+			goto die;
+
+		/* The address is guaranteed to be >= 0 and < TASK_SIZE */
+		uc_sig = (u32 __user *)(unsigned long)(abort_ip - sizeof(*uc_sig));
+		unsafe_get_user(usig, uc_sig, efault);
+		if (unlikely(usig != t->rseq.sig))
+			goto die;
+
+		/* Invalidate the critical section */
+		unsafe_put_user(0ULL, &t->rseq.usrptr->rseq_cs, efault);
+		/* Update the instruction pointer */
+		instruction_pointer_set(regs, (unsigned long)abort_ip);
+		rseq_stat_inc(rseq_stats.fixup);
+		break;
+	clear:
+		unsafe_put_user(0ULL, &t->rseq.usrptr->rseq_cs, efault);
+		rseq_stat_inc(rseq_stats.clear);
+		abort_ip = 0ULL;
+	}
+
+	if (unlikely(abort_ip))
+		rseq_trace_ip_fixup(ip, start_ip, offset, abort_ip);
+	return true;
+die:
+	t->rseq.event.fatal = true;
+efault:
+	return false;
+}
+
 static __always_inline void rseq_exit_to_user_mode(void)
 {
 	struct rseq_event *ev = &current->rseq.event;
--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -14,10 +14,12 @@ struct rseq;
  * @sched_switch:	True if the task was scheduled out
  * @user_irq:		True on interrupt entry from user mode
  * @has_rseq:		True if the task has a rseq pointer installed
+ * @error:		Compound error code for the slow path to analyze
+ * @fatal:		User space data corrupted or invalid
  */
 struct rseq_event {
 	union {
-		u32				all;
+		u64				all;
 		struct {
 			union {
 				u16		events;
@@ -28,6 +30,13 @@ struct rseq_event {
 			};
 
 			u8			has_rseq;
+			u8			__pad;
+			union {
+				u16		error;
+				struct {
+					u8	fatal;
+				};
+			};
 		};
 	};
 };
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -382,175 +382,18 @@ static int rseq_reset_rseq_cpu_node_id(s
 	return -EFAULT;
 }
 
-/*
- * Get the user-space pointer value stored in the 'rseq_cs' field.
- */
-static int rseq_get_rseq_cs_ptr_val(struct rseq __user *rseq, u64 *rseq_cs)
-{
-	if (!rseq_cs)
-		return -EFAULT;
-
-#ifdef CONFIG_64BIT
-	if (get_user(*rseq_cs, &rseq->rseq_cs))
-		return -EFAULT;
-#else
-	if (copy_from_user(rseq_cs, &rseq->rseq_cs, sizeof(*rseq_cs)))
-		return -EFAULT;
-#endif
-
-	return 0;
-}
-
-/*
- * If the rseq_cs field of 'struct rseq' contains a valid pointer to
- * user-space, copy 'struct rseq_cs' from user-space and validate its fields.
- */
-static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
-{
-	struct rseq_cs __user *urseq_cs;
-	u64 ptr;
-	u32 __user *usig;
-	u32 sig;
-	int ret;
-
-	ret = rseq_get_rseq_cs_ptr_val(t->rseq.usrptr, &ptr);
-	if (ret)
-		return ret;
-
-	/* If the rseq_cs pointer is NULL, return a cleared struct rseq_cs. */
-	if (!ptr) {
-		memset(rseq_cs, 0, sizeof(*rseq_cs));
-		return 0;
-	}
-	/* Check that the pointer value fits in the user-space process space. */
-	if (ptr >= TASK_SIZE)
-		return -EINVAL;
-	urseq_cs = (struct rseq_cs __user *)(unsigned long)ptr;
-	if (copy_from_user(rseq_cs, urseq_cs, sizeof(*rseq_cs)))
-		return -EFAULT;
-
-	if (rseq_cs->start_ip >= TASK_SIZE ||
-	    rseq_cs->start_ip + rseq_cs->post_commit_offset >= TASK_SIZE ||
-	    rseq_cs->abort_ip >= TASK_SIZE ||
-	    rseq_cs->version > 0)
-		return -EINVAL;
-	/* Check for overflow. */
-	if (rseq_cs->start_ip + rseq_cs->post_commit_offset < rseq_cs->start_ip)
-		return -EINVAL;
-	/* Ensure that abort_ip is not in the critical section. */
-	if (rseq_cs->abort_ip - rseq_cs->start_ip < rseq_cs->post_commit_offset)
-		return -EINVAL;
-
-	usig = (u32 __user *)(unsigned long)(rseq_cs->abort_ip - sizeof(u32));
-	ret = get_user(sig, usig);
-	if (ret)
-		return ret;
-
-	if (current->rseq.sig != sig) {
-		printk_ratelimited(KERN_WARNING
-			"Possible attack attempt. Unexpected rseq signature 0x%x, expecting 0x%x (pid=%d, addr=%p).\n",
-			sig, current->rseq.sig, current->pid, usig);
-		return -EINVAL;
-	}
-	return 0;
-}
-
-static bool rseq_warn_flags(const char *str, u32 flags)
+static bool rseq_handle_cs(struct task_struct *t, struct pt_regs *regs)
 {
-	u32 test_flags;
+	struct rseq __user *urseq = t->rseq.usrptr;
+	u64 csaddr;
 
-	if (!flags)
-		return false;
-	test_flags = flags & RSEQ_CS_NO_RESTART_FLAGS;
-	if (test_flags)
-		pr_warn_once("Deprecated flags (%u) in %s ABI structure", test_flags, str);
-	test_flags = flags & ~RSEQ_CS_NO_RESTART_FLAGS;
-	if (test_flags)
-		pr_warn_once("Unknown flags (%u) in %s ABI structure", test_flags, str);
-	return true;
-}
-
-static int rseq_check_flags(struct task_struct *t, u32 cs_flags)
-{
-	u32 flags;
-	int ret;
-
-	if (rseq_warn_flags("rseq_cs", cs_flags))
-		return -EINVAL;
-
-	/* Get thread flags. */
-	ret = get_user(flags, &t->rseq.usrptr->flags);
-	if (ret)
-		return ret;
-
-	if (rseq_warn_flags("rseq", flags))
-		return -EINVAL;
-	return 0;
-}
-
-static int clear_rseq_cs(struct rseq __user *rseq)
-{
-	/*
-	 * The rseq_cs field is set to NULL on preemption or signal
-	 * delivery on top of rseq assembly block, as well as on top
-	 * of code outside of the rseq assembly block. This performs
-	 * a lazy clear of the rseq_cs field.
-	 *
-	 * Set rseq_cs to NULL.
-	 */
-#ifdef CONFIG_64BIT
-	return put_user(0UL, &rseq->rseq_cs);
-#else
-	if (clear_user(&rseq->rseq_cs, sizeof(rseq->rseq_cs)))
-		return -EFAULT;
-	return 0;
-#endif
-}
-
-/*
- * Unsigned comparison will be true when ip >= start_ip, and when
- * ip < start_ip + post_commit_offset.
- */
-static bool in_rseq_cs(unsigned long ip, struct rseq_cs *rseq_cs)
-{
-	return ip - rseq_cs->start_ip < rseq_cs->post_commit_offset;
-}
-
-static int rseq_ip_fixup(struct pt_regs *regs, bool abort)
-{
-	unsigned long ip = instruction_pointer(regs);
-	struct task_struct *t = current;
-	struct rseq_cs rseq_cs;
-	int ret;
-
-	rseq_stat_inc(rseq_stats.cs);
-
-	ret = rseq_get_rseq_cs(t, &rseq_cs);
-	if (ret)
-		return ret;
-
-	/*
-	 * Handle potentially not being within a critical section.
-	 * If not nested over a rseq critical section, restart is useless.
-	 * Clear the rseq_cs pointer and return.
-	 */
-	if (!in_rseq_cs(ip, &rseq_cs)) {
-		rseq_stat_inc(rseq_stats.clear);
-		return clear_rseq_cs(t->rseq.usrptr);
-	}
-	ret = rseq_check_flags(t, rseq_cs.flags);
-	if (ret < 0)
-		return ret;
-	if (!abort)
-		return 0;
-	ret = clear_rseq_cs(t->rseq.usrptr);
-	if (ret)
-		return ret;
-	rseq_stat_inc(rseq_stats.fixup);
-	trace_rseq_ip_fixup(ip, rseq_cs.start_ip, rseq_cs.post_commit_offset,
-			    rseq_cs.abort_ip);
-	instruction_pointer_set(regs, (unsigned long)rseq_cs.abort_ip);
-	return 0;
+	scoped_user_read_access(urseq, efault)
+		unsafe_get_user(csaddr, &urseq->rseq_cs, efault);
+	if (likely(!csaddr))
+		return true;
+	return rseq_update_user_cs(t, regs, csaddr);
+efault:
+	return false;
 }
 
 /*
@@ -567,8 +410,8 @@ static int rseq_ip_fixup(struct pt_regs
 void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
 {
 	struct task_struct *t = current;
-	int ret, sig;
 	bool event;
+	int sig;
 
 	/*
 	 * If invoked from hypervisors before entering the guest via
@@ -618,8 +461,7 @@ void __rseq_handle_notify_resume(struct
 	if (!IS_ENABLED(CONFIG_DEBUG_RSEQ) && !event)
 		return;
 
-	ret = rseq_ip_fixup(regs, event);
-	if (unlikely(ret < 0))
+	if (!rseq_handle_cs(t, regs))
 		goto error;
 
 	if (unlikely(rseq_update_cpu_node_id(t)))
@@ -632,6 +474,68 @@ void __rseq_handle_notify_resume(struct
 }
 
 #ifdef CONFIG_DEBUG_RSEQ
+/*
+ * Unsigned comparison will be true when ip >= start_ip, and when
+ * ip < start_ip + post_commit_offset.
+ */
+static bool in_rseq_cs(unsigned long ip, struct rseq_cs *rseq_cs)
+{
+	return ip - rseq_cs->start_ip < rseq_cs->post_commit_offset;
+}
+
+/*
+ * If the rseq_cs field of 'struct rseq' contains a valid pointer to
+ * user-space, copy 'struct rseq_cs' from user-space and validate its fields.
+ */
+static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
+{
+	struct rseq __user *urseq = t->rseq.usrptr;
+	struct rseq_cs __user *urseq_cs;
+	u32 __user *usig;
+	u64 ptr;
+	u32 sig;
+	int ret;
+
+	if (get_user(ptr, &rseq->rseq_cs))
+		return -EFAULT;
+
+	/* If the rseq_cs pointer is NULL, return a cleared struct rseq_cs. */
+	if (!ptr) {
+		memset(rseq_cs, 0, sizeof(*rseq_cs));
+		return 0;
+	}
+	/* Check that the pointer value fits in the user-space process space. */
+	if (ptr >= TASK_SIZE)
+		return -EINVAL;
+	urseq_cs = (struct rseq_cs __user *)(unsigned long)ptr;
+	if (copy_from_user(rseq_cs, urseq_cs, sizeof(*rseq_cs)))
+		return -EFAULT;
+
+	if (rseq_cs->start_ip >= TASK_SIZE ||
+	    rseq_cs->start_ip + rseq_cs->post_commit_offset >= TASK_SIZE ||
+	    rseq_cs->abort_ip >= TASK_SIZE ||
+	    rseq_cs->version > 0)
+		return -EINVAL;
+	/* Check for overflow. */
+	if (rseq_cs->start_ip + rseq_cs->post_commit_offset < rseq_cs->start_ip)
+		return -EINVAL;
+	/* Ensure that abort_ip is not in the critical section. */
+	if (rseq_cs->abort_ip - rseq_cs->start_ip < rseq_cs->post_commit_offset)
+		return -EINVAL;
+
+	usig = (u32 __user *)(unsigned long)(rseq_cs->abort_ip - sizeof(u32));
+	ret = get_user(sig, usig);
+	if (ret)
+		return ret;
+
+	if (current->rseq.sig != sig) {
+		printk_ratelimited(KERN_WARNING
+			"Possible attack attempt. Unexpected rseq signature 0x%x, expecting 0x%x (pid=%d, addr=%p).\n",
+			sig, current->rseq.sig, current->pid, usig);
+		return -EINVAL;
+	}
+	return 0;
+}
 
 /*
  * Terminate the process if a syscall is issued within a restartable



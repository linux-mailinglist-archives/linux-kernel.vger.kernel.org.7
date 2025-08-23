Return-Path: <linux-kernel+bounces-783249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1155DB32AF5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B2251C20420
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2732EA163;
	Sat, 23 Aug 2025 16:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ogoNHNLN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ls9VTPnZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30342F0693
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755967199; cv=none; b=BJ1XvH6le41t7VP6DDNDMUPinWk8Vu7zH587Xy03c85yXNAbytlJ4y/qhJ15y+rCIxHVwdECgWnfYmxiZE+6O8WrtjOAbjAjyafjKnD3SeV985ed7mzBIX0VllTdz6RtbHbrIvWuMBqJsB1ICdScKWen4UuCCEoUQV5Pu19UFpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755967199; c=relaxed/simple;
	bh=Saea/lUEebGbpIlJsRI6zr571NOidClqZ9Qtwfy62Q0=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=SmQQ4CzQK2Mb/hSpdJsB/XA31sfdtDr9iWSFhvzlDaeIBb9HtCJYu9mwyTJGps0+xOZ763tbn4l51WS2tljE3mBBIoFcKOMOKC2d1vW1L8YLMYYWJzs9ipSV5UhjZ4uY2sHh4zdXkvFl1aQMf7WV9F2+V6qGb2hREBcnBK6341I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ogoNHNLN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ls9VTPnZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250823161654.485063556@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755967195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=6wU70L6aiH6anSVUcj0JFrwe/8y9sXXw0wXa0Km/v3I=;
	b=ogoNHNLNhIERodVAnL7CvwIpuseoU00IuGhnCLrFKtLfm1MVgFUS3SpcfsNFwmlYh2G4F8
	L15xu017QKIpDzm6sItoAfo/3szPJTuaih+7B/zJu7q2tSHDP0IxyS1QjW+JNzmr9fnEHd
	F1KySzJnkfKTQfFwPOiCUhfLemC7659za4kx/tITJV7Qmiw2WqUsaB8Cp1TQzHXrWMnXrt
	QNII1zIIYZO3EB3OYK5geHyG0zaXvT3MrFfUBPeefVrMPdLioG1i5aR/9SBTNspelAR/nq
	Vq+pWx49EwCJXKSnRUqljqm/SykJkNUfy/f0ZG6yzfwQpJ4EYOIChCgYEXtJHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755967195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=6wU70L6aiH6anSVUcj0JFrwe/8y9sXXw0wXa0Km/v3I=;
	b=ls9VTPnZURR26/1eP5ePS0vov2EkzpZ0/9IDuW64GD0rKdjf72VWSzVUvjmCOGjFfjkvJB
	fABzW6eJOWJBF9AA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
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
Subject: [patch V2 19/37] rseq: Provide and use rseq_update_user_cs()
References: <20250823161326.635281786@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sat, 23 Aug 2025 18:39:53 +0200 (CEST)

Provide a straight forward implementation to check for and eventually
clear/fixup critical sections in user space.

The non-debug version does not any sanity checks and aims for efficiency.

The only attack vector, which needs to be reliably prevented is an abort IP
which is in the kernel address space. That would cause at least x86 to
return to kernel space via IRET. Instead of a check, just mask the address
and be done with it.

The magic signature check along with it's obscure "possible attack" printk
is just voodoo security. If an attacker manages to manipulate the abort_ip
member in the critical section descriptor, then it can equally manipulate
any other indirection in the application. If user space truly cares about
the security of the critical section descriptors, then it should set them
up once and map the descriptor memory read only. There is no justification
for voodoo security in the kernel fast path to encourage user space to be
careless under a completely non-sensical "security" claim.

If the section descriptors are invalid then the resulting misbehaviour of
the user space application is not the kernels problem.

The kernel provides a run-time switchable debug slow path, which implements
the full zoo of checks (except the silly attack message) including
termination of the task when one of the gazillion conditions is not met.

Replace the zoo in rseq.c with it and invoke it from the TIF_NOTIFY_RESUME
handler. Move the reminders into the CONFIG_DEBUG_RSEQ section, which will
be replaced and removed in a subsequent step.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/rseq_entry.h |  194 ++++++++++++++++++++++++++++++++++++
 include/linux/rseq_types.h |   11 +-
 kernel/rseq.c              |  238 +++++++++++++--------------------------------
 3 files changed, 273 insertions(+), 170 deletions(-)

--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -36,6 +36,7 @@ DECLARE_PER_CPU(struct rseq_stats, rseq_
 #ifdef CONFIG_RSEQ
 #include <linux/jump_label.h>
 #include <linux/rseq.h>
+#include <linux/uaccess.h>
 
 #include <linux/tracepoint-defs.h>
 
@@ -69,12 +70,205 @@ static inline void rseq_trace_ip_fixup(u
 
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
 		current->rseq_event.user_irq = true;
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
+bool rseq_debug_update_user_cs(struct task_struct *t, struct pt_regs *regs, unsigned long csaddr)
+{
+	struct rseq_cs __user *ucs = (struct rseq_cs __user *)(unsigned long)csaddr;
+	u64 start_ip, abort_ip, offset, cs_end, head, tasksize = TASK_SIZE;
+	unsigned long ip = instruction_pointer(regs);
+	u64 __user *uc_head = (u64 __user *) ucs;
+	u32 usig, __user *uc_sig;
+
+	if (!user_rw_masked_begin(ucs))
+		return false;
+
+	/*
+	 * Evaluate the user pile and exit if one of the conditions is not
+	 * fulfilled.
+	 */
+	unsafe_get_user(start_ip, &ucs->start_ip, fail);
+	if (unlikely(start_ip >= tasksize))
+		goto die;
+	/* If outside, just clear the critical section. */
+	if (ip < start_ip)
+		goto clear;
+
+	unsafe_get_user(offset, &ucs->post_commit_offset, fail);
+	cs_end = start_ip + offset;
+	/* Check for overflow and wraparound */
+	if (unlikely(cs_end >= tasksize || cs_end < start_ip))
+		goto die;
+
+	/* If not inside, clear it. */
+	if (ip >= cs_end)
+		goto clear;
+
+	unsafe_get_user(abort_ip, &ucs->abort_ip, fail);
+	/* Ensure it's "valid" */
+	if (unlikely(abort_ip >= tasksize || abort_ip < sizeof(*uc_sig)))
+		goto die;
+	/* Validate that the abort IP is not in the critical section */
+	if (unlikely(abort_ip - start_ip < offset))
+		goto die;
+
+	/*
+	 * Check version and flags for 0. No point in emitting deprecated
+	 * warnings before dying. That could be done in the slow path
+	 * eventually, but *shrug*.
+	 */
+	unsafe_get_user(head, uc_head, fail);
+	if (unlikely(head))
+		goto die;
+
+	/* abort_ip - 4 is >= 0. See abort_ip check above */
+	uc_sig = (u32 __user *)(unsigned long)(abort_ip - sizeof(*uc_sig));
+	unsafe_get_user(usig, uc_sig, fail);
+	if (unlikely(usig != t->rseq_sig))
+		goto die;
+
+	/* rseq_event.user_irq is only valid if CONFIG_GENERIC_IRQ_ENTRY=y */
+	if (IS_ENABLED(CONFIG_GENERIC_IRQ_ENTRY)) {
+		/* If not in interrupt from user context, let it die */
+		if (unlikely(!t->rseq_event.user_irq))
+			goto die;
+	}
+
+	unsafe_put_user(0ULL, &t->rseq->rseq_cs, fail);
+	user_access_end();
+
+	instruction_pointer_set(regs, (unsigned long)abort_ip);
+
+	rseq_stat_inc(rseq_stats.fixup);
+	rseq_trace_ip_fixup(ip, start_ip, offset, abort_ip);
+	return true;
+clear:
+	unsafe_put_user(0ULL, &t->rseq->rseq_cs, fail);
+	user_access_end();
+	rseq_stat_inc(rseq_stats.clear);
+	return true;
+die:
+	t->rseq_event.fatal = true;
+fail:
+	user_access_end();
+	return false;
+}
+#endif /* RSEQ_BUILD_SLOW_PATH */
+
+/*
+ * This only ensures that abort_ip is in the user address space by masking it.
+ * No other sanity checks are done here, that's what the debug code is for.
+ */
+static rseq_inline bool
+rseq_update_user_cs(struct task_struct *t, struct pt_regs *regs, unsigned long csaddr)
+{
+	struct rseq_cs __user *ucs = (struct rseq_cs __user *)(unsigned long)csaddr;
+	unsigned long ip = instruction_pointer(regs);
+	u64 start_ip, abort_ip, offset;
+
+	rseq_stat_inc(rseq_stats.cs);
+
+	if (unlikely(csaddr >= TASK_SIZE)) {
+		t->rseq_event.fatal = true;
+		return false;
+	}
+
+	if (static_branch_unlikely(&rseq_debug_enabled))
+		return rseq_debug_update_user_cs(t, regs, csaddr);
+
+	if (!user_rw_masked_begin(ucs))
+		return false;
+
+	unsafe_get_user(start_ip, &ucs->start_ip, fail);
+	unsafe_get_user(offset, &ucs->post_commit_offset, fail);
+	unsafe_get_user(abort_ip, &ucs->abort_ip, fail);
+
+	/*
+	 * No sanity checks. If user space screwed it up, it can
+	 * keep the pieces. That's what debug code is for.
+	 *
+	 * If outside, just clear the critical section.
+	 */
+	if (ip - start_ip >= offset)
+		goto clear;
+
+	/*
+	 * Force it to be in user space as x86 IRET would happily return to
+	 * the kernel. Can't use TASK_SIZE as a mask because that's not
+	 * necessarily a power of two. Just make sure it's in the user
+	 * address space. Let the pagefault handler sort it out.
+	 *
+	 * Use LONG_MAX and not LLONG_MAX to keep it correct for 32 and 64
+	 * bit architectures.
+	 */
+	abort_ip &= (u64)LONG_MAX;
+
+	/* Invalidate the critical section */
+	unsafe_put_user(0ULL, &t->rseq->rseq_cs, fail);
+	user_access_end();
+
+	/* Update the instruction pointer */
+	instruction_pointer_set(regs, (unsigned long)abort_ip);
+
+	rseq_stat_inc(rseq_stats.fixup);
+	rseq_trace_ip_fixup(ip, start_ip, offset, abort_ip);
+	return true;
+clear:
+	unsafe_put_user(0ULL, &t->rseq->rseq_cs, fail);
+	user_access_end();
+	rseq_stat_inc(rseq_stats.clear);
+	return true;
+
+fail:
+	user_access_end();
+	return false;
+}
+
 static __always_inline void rseq_exit_to_user_mode(void)
 {
 	struct rseq_event *ev = &current->rseq_event;
--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -11,10 +11,12 @@
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
@@ -25,6 +27,13 @@ struct rseq_event {
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
@@ -382,175 +382,15 @@ static int rseq_reset_rseq_cpu_node_id(s
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
-	ret = rseq_get_rseq_cs_ptr_val(t->rseq, &ptr);
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
-	if (current->rseq_sig != sig) {
-		printk_ratelimited(KERN_WARNING
-			"Possible attack attempt. Unexpected rseq signature 0x%x, expecting 0x%x (pid=%d, addr=%p).\n",
-			sig, current->rseq_sig, current->pid, usig);
-		return -EINVAL;
-	}
-	return 0;
-}
-
-static bool rseq_warn_flags(const char *str, u32 flags)
+static bool rseq_handle_cs(struct task_struct *t, struct pt_regs *regs)
 {
-	u32 test_flags;
+	u64 csaddr;
 
-	if (!flags)
+	if (get_user_masked_u64(&csaddr, &t->rseq->rseq_cs))
 		return false;
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
-	ret = get_user(flags, &t->rseq->flags);
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
-		return clear_rseq_cs(t->rseq);
-	}
-	ret = rseq_check_flags(t, rseq_cs.flags);
-	if (ret < 0)
-		return ret;
-	if (!abort)
-		return 0;
-	ret = clear_rseq_cs(t->rseq);
-	if (ret)
-		return ret;
-	rseq_stat_inc(rseq_stats.fixup);
-	trace_rseq_ip_fixup(ip, rseq_cs.start_ip, rseq_cs.post_commit_offset,
-			    rseq_cs.abort_ip);
-	instruction_pointer_set(regs, (unsigned long)rseq_cs.abort_ip);
-	return 0;
+	if (likely(!csaddr))
+		return true;
+	return rseq_update_user_cs(t, regs, csaddr);
 }
 
 /*
@@ -567,8 +407,8 @@ static int rseq_ip_fixup(struct pt_regs
 void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
 {
 	struct task_struct *t = current;
-	int ret, sig;
 	bool event;
+	int sig;
 
 	/*
 	 * If invoked from hypervisors before entering the guest via
@@ -618,8 +458,7 @@ void __rseq_handle_notify_resume(struct
 	if (!IS_ENABLED(CONFIG_DEBUG_RSEQ) && !event)
 		return;
 
-	ret = rseq_ip_fixup(regs, event);
-	if (unlikely(ret < 0))
+	if (!rseq_handle_cs(t, regs))
 		goto error;
 
 	if (unlikely(rseq_update_cpu_node_id(t)))
@@ -632,6 +471,67 @@ void __rseq_handle_notify_resume(struct
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
+	struct rseq_cs __user *urseq_cs;
+	u64 ptr;
+	u32 __user *usig;
+	u32 sig;
+	int ret;
+
+	if (get_user_masked_u64(&ptr, &t->rseq->rseq_cs))
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
+	if (current->rseq_sig != sig) {
+		printk_ratelimited(KERN_WARNING
+			"Possible attack attempt. Unexpected rseq signature 0x%x, expecting 0x%x (pid=%d, addr=%p).\n",
+			sig, current->rseq_sig, current->pid, usig);
+		return -EINVAL;
+	}
+	return 0;
+}
 
 /*
  * Terminate the process if a syscall is issued within a restartable



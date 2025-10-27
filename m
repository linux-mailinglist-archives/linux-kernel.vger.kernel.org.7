Return-Path: <linux-kernel+bounces-871107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF30C0C76F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E5D40404D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919E21C862D;
	Mon, 27 Oct 2025 08:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="37PXP75Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nmzYVHVT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DF42ECE97
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554704; cv=none; b=AbHHIUIqLh7EkV7YiBSk8XzkmWLf4C+gd77nliEY9nkmqbGifnS5kA7WEeu/0r/dsx9qRmrSf2NU3CN1z7H2u1yVWTULxrk7MGqWoccpbGb4BYmlFXF7ydBo0iQmQmaZqI0oqOMnobXETYr2T9ePwltDj/S1gFvFkcJVELiYp4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554704; c=relaxed/simple;
	bh=o8+anuL765YDWkk9Rva3WdYqhOZW6a1Ijwwe0cH/gYI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=LuZvYaODI5A7lYDYdRstlKj27eji5BCYOQ9IJIVGRwG9TmVS6iOXh0JIDKwclW+GAFMACe5Q00zlCAsA0Ps9Kp3CuAODcpOz3getlG3H8QolnIY14uJy8v21NwaHUlVNP2TULitGtyeGu2qUTUUpoGdszKK823G5ncrcGIV4EBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=37PXP75Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nmzYVHVT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251027084307.212510692@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761554701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=kLGu5WotexOEVXsBMru+GZK4x5QTJRGoqn6jv1HQqss=;
	b=37PXP75YEqC9b71Q9wGTzoinPRuU1oCR6/MEdB9ySSh3dMU9XSdKO5bbVNW6SbBeTPtf1F
	ltjnAdqwADEpVcPWaOvlcqB+XIHMfpjdNyXEGzqsunzEnUb56Je54YrBv2sq8Xz5lX5AJ1
	cX294hQE161wyqI5iqj8FRO2NUkVRKU/A+3knmrUU9Rp4GjxhUltaoX3ecOWIXs7nK0yP8
	xOHAG38OGr4IOd/lgDzwFBMiqe/yCbIu5acgAdTyYrjuXtzFg5cw+PZEZfUYdrcTteqI5D
	s0oQFanw0FwhZVGBS/0+Io350Bhs9uI+62xJj19tGi7kOkasYmgIqLjkvPsZ0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761554701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=kLGu5WotexOEVXsBMru+GZK4x5QTJRGoqn6jv1HQqss=;
	b=nmzYVHVTgq9zTKd4aDMnOzKgqTNIXLX0z7bp4j168JTIbZzdJ60rexVw7CH383J5qhrahM
	VUI0LutfjdmMgODg==
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
Subject: [patch V6 20/31] rseq: Replace the original debug implementation
References: <20251027084220.785525188@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Oct 2025 09:45:00 +0100 (CET)

Just utilize the new infrastructure and put the original one to rest.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

---
 kernel/rseq.c |   81 ++++++++--------------------------------------------------
 1 file changed, 12 insertions(+), 69 deletions(-)
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -475,84 +475,27 @@ void __rseq_handle_notify_resume(struct
 
 #ifdef CONFIG_DEBUG_RSEQ
 /*
- * Unsigned comparison will be true when ip >= start_ip, and when
- * ip < start_ip + post_commit_offset.
- */
-static bool in_rseq_cs(unsigned long ip, struct rseq_cs *rseq_cs)
-{
-	return ip - rseq_cs->start_ip < rseq_cs->post_commit_offset;
-}
-
-/*
- * If the rseq_cs field of 'struct rseq' contains a valid pointer to
- * user-space, copy 'struct rseq_cs' from user-space and validate its fields.
- */
-static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
-{
-	struct rseq __user *urseq = t->rseq.usrptr;
-	struct rseq_cs __user *urseq_cs;
-	u32 __user *usig;
-	u64 ptr;
-	u32 sig;
-	int ret;
-
-	if (get_user(ptr, &rseq->rseq_cs))
-		return -EFAULT;
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
-/*
  * Terminate the process if a syscall is issued within a restartable
  * sequence.
  */
 void rseq_syscall(struct pt_regs *regs)
 {
-	unsigned long ip = instruction_pointer(regs);
 	struct task_struct *t = current;
-	struct rseq_cs rseq_cs;
+	u64 csaddr;
 
-	if (!t->rseq.usrptr)
+	if (!t->rseq.event.has_rseq)
+		return;
+	if (!get_user(csaddr, &t->rseq.usrptr->rseq_cs))
+		goto fail;
+	if (likely(!csaddr))
 		return;
-	if (rseq_get_rseq_cs(t, &rseq_cs) || in_rseq_cs(ip, &rseq_cs))
-		force_sig(SIGSEGV);
+	if (unlikely(csaddr >= TASK_SIZE))
+		goto fail;
+	if (rseq_debug_update_user_cs(t, regs, csaddr))
+		return;
+fail:
+	force_sig(SIGSEGV);
 }
-
 #endif
 
 /*



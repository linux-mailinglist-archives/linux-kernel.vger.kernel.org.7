Return-Path: <linux-kernel+bounces-864984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFADBFBFE7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB9E1540977
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E233491C2;
	Wed, 22 Oct 2025 12:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="reeSskdn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="awTGPpBM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EC834B41F
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137551; cv=none; b=ZgxNVUFgozEDJd6fVrr/7F/nzHSRdOwUG002mfyRh3iz9QIWdhO1o6hDfvAx7FvGj1oqzGd0z8G+I8OCnUuT0oCaZ6jPGny0SMv+xn79g6S0YttwVWcWoyaoUyLfD/9uqwt2HPlSq6pusdT2O/dnRmvM17Yf5vXkYKUeUymS1o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137551; c=relaxed/simple;
	bh=o8+anuL765YDWkk9Rva3WdYqhOZW6a1Ijwwe0cH/gYI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=QFrX7s3Z09CvH8Rh2mbCN9hI85dFs/ZknFuWxYrmEwBn+y3Ne7zciYXGDLHzbI5jK7ol3L8iqxPvInMdbfAke0r+o73B5XTxr/S0hu/OoXifAPKb9Fhde+RspadX4ts/CN/VCurn/YAlWHP1Vkll9p4pQ8YXCeMa8UHYFmzg534=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=reeSskdn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=awTGPpBM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022121942.661644079@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=kLGu5WotexOEVXsBMru+GZK4x5QTJRGoqn6jv1HQqss=;
	b=reeSskdnvdkEYBDCKf39qLIpsXHzG7KQoobS7f9PW4ZRuxZg1lXKyNPb5o8bU9QX1gGle4
	A70cXXnHbXD1dFmYsLFFSth7WY+EpAqh6Rh6XlBvD8XSPrqNf17zBHw/C/IxllDex1Vxg+
	WNnIgC9TXC1pLxS70eVdZ9gVhYmkwixaTyOLg/f0LRbYCVBgSjnrk9/5/3ZWOWWRHFeQ6f
	XbpGZtFwi9J7/MDT1MfeZzpVlk/27UjPifc46meTqbNHrPJymIoB6f98Hun0qpbRNUaZbU
	u/Vv+WqNvrenxZZJc89EYCErnJgDt9adDQz6ifW0a3NBJ4ctLFhCXTJYBnj7+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=kLGu5WotexOEVXsBMru+GZK4x5QTJRGoqn6jv1HQqss=;
	b=awTGPpBMj6tFvyi/odVaL53sbYLJSPfntjXF45oB66uKwKYkPHRpwSosVsmj8AC59VOYye
	dPRwPF1ddNfnjOBQ==
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
Subject: [patch V5 20/31] rseq: Replace the original debug implementation
References: <20251022121836.019469732@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:52:25 +0200 (CEST)

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



Return-Path: <linux-kernel+bounces-806809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3579DB49C0E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BF831B20C1E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A4F3164A1;
	Mon,  8 Sep 2025 21:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ct0UNu1K";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5X9Kc9v/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DDA2E091E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 21:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757367130; cv=none; b=s7xhX74kVV28H6N2O4juwWLH6DNCwFQyXQqtMVYhrDF8G+czZzFRKOlcp2pozD1iJHTuMWtUKMjro4/9rCoPNcJgWnNQqJLUUceqLAkNB6IWKGI6ZCz/5BdCKNvJCB82t+F3YwbXj589b2c57695bONJ1Iy4YNVFwipX62yC97E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757367130; c=relaxed/simple;
	bh=e4ZpUEUGMBOoN05ZGSlJj/H1uRu7SOjIhOo7I28YoN0=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=o+ynTAFcev0wcTJ2N02gnh3QPLsputQg9fgmaI0ufywkAAdjyKmgJ2zg8hd3bj4ZXxE5lThVthYLD5KFs8Hw9Q+DiHSPAZCc5qAcpuZ1z8nCVDimhzjuQNvz7TDN4P3vtzJJcR9r/JVGLKxr2Pe/KRUL+RjMWMMDiRovYAWbAGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ct0UNu1K; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5X9Kc9v/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250908212926.546181943@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757367127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=uE0PtsFW7NVSXU1hhzsSStqrPFo4MlHlfFxx2uIN998=;
	b=ct0UNu1KujMIk09kcFrw+8yuEYKcxweei3wTauLN23sk9oB32Yc3f287k12Uwg6aVWjPep
	Jw3Ug9q4JFcy2arp+yfDwt8/mcz4+vfOxW+tJ//2CbVer+hH28gJQpXfwXCutwvehY/VGH
	yK86pWwtTw1Uwqj1UFwbIxz0iFLxXuKyNkq00FFIIixApmbH9drdGwqv8q2TMUq0pXQt6E
	BfWTII2ETvfGS9Wme5H58Q6rJjFkJ0CrkbKfkHV43hroZEINynrP0AzpK9Ljle8mIbKTCI
	JFXhIT3hyE1uwc3vJDNJzu1IITKO9HCz5/8t9z6AfDfB0juCJbFPT6s+Ar/Hdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757367127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=uE0PtsFW7NVSXU1hhzsSStqrPFo4MlHlfFxx2uIN998=;
	b=5X9Kc9v/QlDa9eb0JXSNniXBJRm1SYFCE8Gz+khHU7yz5/fFKYVM7MJGKjfnzPDEEYG/rj
	l7QZeLRGIF14/zBw==
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
Subject: [patch V4 20/36] rseq: Replace the original debug implementation
References: <20250908212737.353775467@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  8 Sep 2025 23:32:06 +0200 (CEST)

Just utilize the new infrastructure and put the original one to rest.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

---
 kernel/rseq.c |   80 ++++++++--------------------------------------------------
 1 file changed, 12 insertions(+), 68 deletions(-)

--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -472,83 +472,27 @@ void __rseq_handle_notify_resume(struct
 
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
-	struct rseq_cs __user *urseq_cs;
-	u64 ptr;
-	u32 __user *usig;
-	u32 sig;
-	int ret;
-
-	if (get_user_masked_u64(&ptr, &t->rseq.usrptr->rseq_cs))
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
+	if (get_user_masked_u64(&csaddr, &t->rseq.usrptr->rseq_cs))
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



Return-Path: <linux-kernel+bounces-864966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23324BFBFE2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F21795E656B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070F23491E6;
	Wed, 22 Oct 2025 12:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LqhaLvQo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AhCdgNuX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEEB348897
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137529; cv=none; b=Q9zZ/jUvEjpKu/jEUBSpoC0ALRPLG61uNbJjjGMIDvxsP6xesTpH5A6PxGQb84drUAGMZsYc3dmrZiCNYJlEa7amM2JRJ1/6VioeofoO31V29NvuCmjk3Y/n1pnL31QWVaGYAGIlb90teKSCLITHMDDLerqLsfstKbmG1JwIufg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137529; c=relaxed/simple;
	bh=HcnqdHsvaXUK49IWIHRp6yZ7E75n5eA1mWiYnxksauY=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=nSXGSVz5wFPdeH4vqUZK1T9uIHRHNMKCEF1XZVFe6JotZxWTkR9AH41N92pLU57turO6mOYIJ8tXafRQuwIIv+U9mw4hXtt/7YeoJJskhcMFgH6yAiqeHkhI2uzO4XnZRZelm1XXGeXOifjd2uH8UxPq3jPPeICQVdPh5aZ3Muw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LqhaLvQo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AhCdgNuX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022121941.497801463@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=kKWzqcQeo1xGt/k7+VIul31KkT1uc4ygM+hcAgzVCDQ=;
	b=LqhaLvQoLg7+1c8HDGE6pe7oo4lasijvW+yh5L9D/yA2TeazxWBdtx3JJdKctJrtQc6633
	5tPHjwB/xTluwAS7dwytBAF0GdPkg9xHbmnAnoNjlIf+wsN3qmIOV0uaEUAVL1eqx5BqSY
	pWRtffDxKIGCWqijVac0YR177mtuBrD6pTMfq8PNCrdzFOmGBzwB5L9qEuOAcwsTGJROQu
	56bRBlOfm/2Xevl1ZgiEwJA0Rbxw2f5qMIIfGc+cU+ughMfufmwLxdaKIXajq+uvFJfNz7
	LxQZlNK7L6z558kvpSpeyCR9Sm96XMcqkfuQQsS/0DVSfgf3u1Frclzw3OwpHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=kKWzqcQeo1xGt/k7+VIul31KkT1uc4ygM+hcAgzVCDQ=;
	b=AhCdgNuXmhs9rknFch4/lX5xWUznlnFjyjRq/0VRmM+Ln8g5Lu5eegjdel05MdBitVMSWr
	jFp/GsZrpfddUPCQ==
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
Subject: [patch V5 02/31] rseq: Condense the inline stubs
References: <20251022121836.019469732@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:52:03 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

Scrolling over tons of pointless

{
}

lines to find the actual code is annoying at best.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

---
 include/linux/rseq.h |   47 ++++++++++++-----------------------------------
 1 file changed, 12 insertions(+), 35 deletions(-)
---
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -101,44 +101,21 @@ static inline void rseq_execve(struct ta
 	t->rseq_event_mask = 0;
 }
 
-#else
-
-static inline void rseq_set_notify_resume(struct task_struct *t)
-{
-}
-static inline void rseq_handle_notify_resume(struct ksignal *ksig,
-					     struct pt_regs *regs)
-{
-}
-static inline void rseq_signal_deliver(struct ksignal *ksig,
-				       struct pt_regs *regs)
-{
-}
-static inline void rseq_preempt(struct task_struct *t)
-{
-}
-static inline void rseq_migrate(struct task_struct *t)
-{
-}
-static inline void rseq_fork(struct task_struct *t, u64 clone_flags)
-{
-}
-static inline void rseq_execve(struct task_struct *t)
-{
-}
+#else /* CONFIG_RSEQ */
+static inline void rseq_set_notify_resume(struct task_struct *t) { }
+static inline void rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs) { }
+static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs *regs) { }
+static inline void rseq_preempt(struct task_struct *t) { }
+static inline void rseq_migrate(struct task_struct *t) { }
+static inline void rseq_fork(struct task_struct *t, u64 clone_flags) { }
+static inline void rseq_execve(struct task_struct *t) { }
 static inline void rseq_exit_to_user_mode(void) { }
-#endif
+#endif  /* !CONFIG_RSEQ */
 
 #ifdef CONFIG_DEBUG_RSEQ
-
 void rseq_syscall(struct pt_regs *regs);
-
-#else
-
-static inline void rseq_syscall(struct pt_regs *regs)
-{
-}
-
-#endif
+#else /* CONFIG_DEBUG_RSEQ */
+static inline void rseq_syscall(struct pt_regs *regs) { }
+#endif /* !CONFIG_DEBUG_RSEQ */
 
 #endif /* _LINUX_RSEQ_H */



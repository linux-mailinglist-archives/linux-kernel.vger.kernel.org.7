Return-Path: <linux-kernel+bounces-871089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8BDC0C712
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F165E4F1ABF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D022D2F6194;
	Mon, 27 Oct 2025 08:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1rtP0E25";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qC6MbZI3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA9B302CDF
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554662; cv=none; b=klUUeUiOVq7Y6iFYXNtzvRZNR1i25DWcrTQV5hoSmnVOJNAqPkF5X9K5XhnrK4GrPa8JyK4OmVcfX2nbX5wa2a8SJ7ibcmasrYWHlB+EgNWnS3h178S+JkQsHMBT3eA46L1PSjTDyeRFA+FZUTKPylk9RAOvDnWvzpw0ANx7pxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554662; c=relaxed/simple;
	bh=HcnqdHsvaXUK49IWIHRp6yZ7E75n5eA1mWiYnxksauY=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=AJKzLiBtzZ0DM5RZchHxe7mtutX1Lt4Jl4uZBXAxAYhxWb3pM+qtGrB3aD5YW65Wd9RcHFx4Gdfl6Zwmc+RV/C9IhJvrkp+7MuLhmX3ufcjcTlTUJQSrefClQkN3WOQ93mg/xBQaQeKoT8xVYs7hkD4HJvGNixfL/Qds/Ub3Js4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1rtP0E25; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qC6MbZI3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251027084306.085971048@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761554659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=kKWzqcQeo1xGt/k7+VIul31KkT1uc4ygM+hcAgzVCDQ=;
	b=1rtP0E259WCtgzY+uc2N0qNA8CuUIHknWBbZ/BuSlZOgVEF8wIGCuY5DIq2HfCuFQaOCJQ
	MmmrwUYhgS1YsStVHtJCG/cjam+fN/dz0UHBgB2HotoDENesqFAFk2Mj75JhxFYWpsnT5z
	pFv7KGyao7HNHN5OK4HraKkQGMNIAxszoTICScXs0Vw7grJKDihhgJ/38hFAWpzbUv0DL9
	ko/Y42TDVmo1yBmEFg3DP5EYcyupFl08qCQ5NRzczR8JQyHXoERkhUqSAv9ZxwdaXL4g2W
	Wqj3EUyWFLDs3h60lDITxLyNU/cAC68pBNy2RftzEyA5gauwHtncuUZzSQFe9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761554659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=kKWzqcQeo1xGt/k7+VIul31KkT1uc4ygM+hcAgzVCDQ=;
	b=qC6MbZI3QBmiE1fpt7E8Hfu+Hn3iaF2u+wc1lWkKvRtg3E0UY4zJNxUpDaSjLt2qeputyS
	KzVU7zBWYt3NtFDA==
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
Subject: [patch V6 02/31] rseq: Condense the inline stubs
References: <20251027084220.785525188@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Oct 2025 09:44:18 +0100 (CET)

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



Return-Path: <linux-kernel+bounces-767146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 832B5B24FBB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FBEE7A4CE4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88702877FA;
	Wed, 13 Aug 2025 16:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xIq8jSRi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="01lVH/L1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C9F287512
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 16:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755102562; cv=none; b=cMbCM8881jYLlaDqakSVThBqZqhjvKk6fx5gYWxWIe3gqecgn/rfXYRp5cXzq/uiPAzQiSwLEPTZDaaX9gLEdzjpCMkc+g/IFmiAdZKtb6gxaFbqDBhsc8uDBDWDOmGom1xCnyTornSBacfcsp31eJWxbfgByb3tbKvHO9StCR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755102562; c=relaxed/simple;
	bh=GrcX8bKrMeUNwjVa2lQR8P7v7/02L5aEjqPuACi/KfU=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=fdgfsZonoSUw69+fVDPavpyyrzYYBy7uai27FMZvZ+K8LvxLy0tEzuHpsjuDGF/0tksDlaCFCdOoDuU3gO2HRS7Z4z483H16YIK6yiHtEd6unPsw4D5DAbQ7aUxlbZMtiLDChzHNrDw1RGrcFZzvQKwM6zYWdMy3F92/FHDQ0Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xIq8jSRi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=01lVH/L1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250813162823.909295085@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755102558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=y0ZQd/4MvG8zfCK2cfH/GZWcRhhoNxJYcSAnLn0wnGk=;
	b=xIq8jSRimyFwqDzRboxJ6Jf8wIag3KsmLAH9KCcnYV8ZplXFSOyAKU5nG1z9F8J2D15fOA
	l4ZBo1vSVxdeTF27OhqECjV3L/QnLwyItBVfYBBZZ5hjKX0jzJnnur7Nl6K6sFBrQxvFDY
	Ox1Ui/EAR+AQKPoWcCtybtY6T6b8nr105wN2YV6wTv3UCVZotsrhvD6BG3KcV+dE+Nkii3
	Z0wMWYUerFw97RsPso19ELMQPmgsuEhEriDKUyHYL7InEcmxAbd6ebWz4Ffp9RzRb+d2OP
	KhEjPJHTLE+BeRqYBFmzPKzt9KYQS6ntDjBffSpAlm+ubsYRbSD++tBOnBSJ9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755102558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=y0ZQd/4MvG8zfCK2cfH/GZWcRhhoNxJYcSAnLn0wnGk=;
	b=01lVH/L1IfjTFbFA9E9qvCMG0PFS7KNbV7B+dDDfqPhS5lFTuKbGxIDKFctL1KpRU4OKEP
	YQu8XdYJJFmQY3Cg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Wei Liu <wei.liu@kernel.org>,
 Jens Axboe <axboe@kernel.dk>
Subject: [patch 02/11] rseq: Condense the inline stubs
References: <20250813155941.014821755@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Aug 2025 18:29:17 +0200 (CEST)

Scrolling over tons of pointless

{
}

lines to find the actual code is annoying at best.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/rseq.h |   47 ++++++++++++-----------------------------------
 1 file changed, 12 insertions(+), 35 deletions(-)

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
-static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
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
+static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags) { }
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



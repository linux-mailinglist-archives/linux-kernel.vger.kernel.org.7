Return-Path: <linux-kernel+bounces-767157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45109B24FEF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B4B11880168
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFBC299950;
	Wed, 13 Aug 2025 16:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I6ZnOv7e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kk0X3F/d"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95F72989BF
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 16:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755102580; cv=none; b=dQ3zX00XKozPLlTATOaiuFaGvRlQTgGT7wZ7k6Vq3hcovW1ReMJ7RFFAXhYd0jE9gPZfkPhl71fsQmAl3/sURZS4UvndgrIMBm2RE8vYYz8sIbmhrw1JEW83GW/NjgZ1Hx67qVhBpJ9GTtGvCmWtubXFWoek9KYNdJQFOreHvSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755102580; c=relaxed/simple;
	bh=5rdYN6vj3qS0kTnRTIGmNPnuloWf1LcuC+Ww+TFABNE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=m+aANYytTPDk1+51tWhMUVQGu0/hVkNDVvPgtZBjDvrGFE4rT5i/ogLvaiWzM0NfKmM+UjlHLe7FWMlapFsUwgdvFUh9qcCN5TDC+iFF8NnQ9MsXa0U5LdMM+8VWj+V5hdCHakWo3jqWKMPImuYe0tbAdpoWNaVXWQOawyPyqas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I6ZnOv7e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Kk0X3F/d; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250813162824.356621744@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755102576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=fWcHtQhzCZGOeOX2ngjD4Pl0wJj/YhvxCFd7lvSBSUs=;
	b=I6ZnOv7ebtXulU1VvX6GdDhDwH6MIvdT6mx3VSR65EcnzAIJQkVrcl1+7KoEoYafe3Cxxh
	s93K8wZIDISMmEYX2s1ThhIFHWLxyntj0U37+r9JykFzmwsn0uTIofHAlwiNtuNkObIFzP
	AWcN13zvVYy9xRd+z1Lv6M1lJYvLNOzSf9yS4NxxldKoDWs0O6pp7/hkdTK1UZ+VCa7F0X
	LSWU3QLZEMvBsZsAGlrIIaEcT1aVzrk0wx5DrVAL8zWn4Vnb58XLWMEuCPpKQxaS3PaoJ3
	UNe1UgBhXDdbeg8Z2eN1asO+zruUSi9Y8SG2aDP9nlJIjbhmoZNCNh6qYX9SMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755102576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=fWcHtQhzCZGOeOX2ngjD4Pl0wJj/YhvxCFd7lvSBSUs=;
	b=Kk0X3F/dJimjxF++EoZQ4B+JeboTosbWgXF5Z9K3qwx0cHGeIZqF/e+4x9lfKbO+h4XLS2
	HZz744Ns/fxMRNCA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Wei Liu <wei.liu@kernel.org>,
 Jens Axboe <axboe@kernel.dk>,
 Peter Zijlstra <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>
Subject: [patch 09/11] entry: Provide exit_to_user_notify_resume()
References: <20250813155941.014821755@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Aug 2025 18:29:34 +0200 (CEST)

The TIF_NOTIFY_RESUME handler of restartable sequences is invoked as all
other functionality unconditionally when TIF_NOTIFY_RESUME is set for
what ever reason.

The invocation is already conditional on the rseq_event_pending bit being
set, but there is further room for improvement.

The actual invocation cannot be avoided when the event bit is set, but the
actual heavy lifting of accessing user space can be avoided, when the exit
to user mode loop is from a syscall unless it's a debug kernel. There is no
way for the RSEQ code to distinguish that case.

That's trivial for all architectures which use the generic entry code, but
for all others it's non-trivial work, which is beyond the scope of
this. The architectures, which want to benefit should convert their code
over to the generic entry code finally.

To prepare for that optimization rename resume_user_mode_work() to
exit_to_user_notify_resume() and add a @from_irq argument to it, which can
be supplied by the caller.

Let the generic entry code and all non-entry code users like hypervisors
and IO-URING use this new function and supply the correct information.

Any NOTIFY_RESUME work, which evaluates this new argument, has to make the
evaluation dependent on CONFIG_GENERIC_ENTRY because otherwise there is no
guarantee that the value is correct at all.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 drivers/hv/mshv_common.c         |    2 +-
 include/linux/resume_user_mode.h |   38 +++++++++++++++++++++++++++-----------
 io_uring/io_uring.h              |    2 +-
 kernel/entry/common.c            |    2 +-
 kernel/entry/kvm.c               |    2 +-
 5 files changed, 31 insertions(+), 15 deletions(-)

--- a/drivers/hv/mshv_common.c
+++ b/drivers/hv/mshv_common.c
@@ -155,7 +155,7 @@ int mshv_do_pre_guest_mode_work(ulong th
 		schedule();
 
 	if (th_flags & _TIF_NOTIFY_RESUME)
-		resume_user_mode_work(NULL);
+		exit_to_user_notify_resume(NULL, false);
 
 	return 0;
 }
--- a/include/linux/resume_user_mode.h
+++ b/include/linux/resume_user_mode.h
@@ -24,21 +24,22 @@ static inline void set_notify_resume(str
 		kick_process(task);
 }
 
-
 /**
- * resume_user_mode_work - Perform work before returning to user mode
- * @regs:		user-mode registers of @current task
+ * exit_to_user_notify_resume - Perform work before returning to user mode
+ * @regs:	user-mode registers of @current task
+ * @from_irq:	If true this is a return from interrupt, if false it's
+ *		a syscall return.
  *
- * This is called when %TIF_NOTIFY_RESUME has been set.  Now we are
- * about to return to user mode, and the user state in @regs can be
- * inspected or adjusted.  The caller in arch code has cleared
- * %TIF_NOTIFY_RESUME before the call.  If the flag gets set again
- * asynchronously, this will be called again before we return to
- * user mode.
+ * This is called when %TIF_NOTIFY_RESUME has been set to handle the exit
+ * to user work, which is multiplexed under this TIF bit. The bit is
+ * cleared and work is probed as pending. If the flag gets set again before
+ * exiting to user space caller will invoke this again.
  *
- * Called without locks.
+ * Any work invoked here, which wants to make decisions on @from_irq, must
+ * make these decisions dependent on CONFIG_GENERIC_ENTRY to retain the
+ * historical behaviour of resume_user_mode_work().
  */
-static inline void resume_user_mode_work(struct pt_regs *regs)
+static inline void exit_to_user_notify_resume(struct pt_regs *regs, bool from_irq)
 {
 	clear_thread_flag(TIF_NOTIFY_RESUME);
 	/*
@@ -62,4 +63,19 @@ static inline void resume_user_mode_work
 	rseq_handle_notify_resume(regs);
 }
 
+#ifndef CONFIG_GENERIC_ENTRY
+/**
+ * resume_user_mode_work - Perform work before returning to user mode
+ * @regs:		user-mode registers of @current task
+ *
+ * This is a wrapper around exit_to_user_notify_resume() for the existing
+ * call sites in architecture code, which do not use the generic entry
+ * code.
+ */
+static inline void resume_user_mode_work(struct pt_regs *regs)
+{
+	exit_to_user_notify_resume(regs, false);
+}
+#endif
+
 #endif /* LINUX_RESUME_USER_MODE_H */
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -365,7 +365,7 @@ static inline int io_run_task_work(void)
 	if (current->flags & PF_IO_WORKER) {
 		if (test_thread_flag(TIF_NOTIFY_RESUME)) {
 			__set_current_state(TASK_RUNNING);
-			resume_user_mode_work(NULL);
+			exit_to_user_notify_resume(NULL, false);
 		}
 		if (current->io_uring) {
 			unsigned int count = 0;
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -41,7 +41,7 @@ void __weak arch_do_signal_or_restart(st
 			arch_do_signal_or_restart(regs);
 
 		if (ti_work & _TIF_NOTIFY_RESUME)
-			resume_user_mode_work(regs);
+			exit_to_user_notify_resume(regs, from_irq);
 
 		/* Architecture specific TIF work */
 		arch_exit_to_user_mode_work(regs, ti_work);
--- a/kernel/entry/kvm.c
+++ b/kernel/entry/kvm.c
@@ -17,7 +17,7 @@ static int xfer_to_guest_mode_work(struc
 			schedule();
 
 		if (ti_work & _TIF_NOTIFY_RESUME)
-			resume_user_mode_work(NULL);
+			exit_to_user_notify_resume(NULL, false);
 
 		ret = arch_xfer_to_guest_mode_handle_work(vcpu, ti_work);
 		if (ret)



Return-Path: <linux-kernel+bounces-806823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D776FB49C21
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 167251BC7D8B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18294321F24;
	Mon,  8 Sep 2025 21:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HjEw6oHU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YsCa+Si9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00DB3218BE
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 21:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757367158; cv=none; b=ow1vS9WRSL+qv9qPBWehvOGvJYO5HMx7XNyjHvzSuhAJ2JmZTEL8U0ZrkVozIN6CyVrMk/9dSnsFmv5oiFMpY7zR39+ZLBYa7zYdmlpm6fMt339W/AAA48YO01BMmaQy0UsqVSOC2QJhFzP0xwb/utCWZH5Lm/83mRLRu3lMaDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757367158; c=relaxed/simple;
	bh=D41TsXswWi1h7fCIhAh4w78nT1FVYdZLHQHEhN6+SV4=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=pHzwhCCEHGhuQs1W/P2KOZ8Jx5TH7mUbV0iereEm8YsIT4lmWTVcnw5vNokBaW8j3K1wMRfz1QTnGCRzutrNWH9iBKuyseV3sblG1o0eiImenVUUMcDFstdyCnXzePKnKRTBpg9FHVSowlzivQnJiQ3bx2LC14MrYyVMRrWYzBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HjEw6oHU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YsCa+Si9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250908212927.373210812@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757367155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=i408iNVz0cQD0XGWMRRDI8YCykaA7EPqGZjvNuFzHV8=;
	b=HjEw6oHUhTvP0GfHa21D285xxXAfRl5mGIFC7SGmcQJERgqwSj1IU0cmGY2q6ag4Q+19XA
	NWVCGd5b6rY9dlByNJq6IUDa1P6vFurqvv876WHkQQsay9zfH1QWbBlcLvSGzT59sdKIYH
	vypJRtAiTvhMn2tx31QhlGKxlPTDa1ppB+n0NSf73FJnH2rHp6qPMx47h6rIgKmM+pYcnc
	LM2WfqmaIKierfRLve0gL/vPCiCqRdbUwYNtJzuUfO9VTiQxD1ROZ8OBAM7RNdSvvjh/gQ
	LnKr4cJ3kfArIoYIfUL0cpVaozVK9/FEbRJcfDTFgATc0qGmKqD0RyNfmfrKUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757367155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=i408iNVz0cQD0XGWMRRDI8YCykaA7EPqGZjvNuFzHV8=;
	b=YsCa+Si94r5avhr/hZp6NKifHufTYxfJ6QU1Dgq2PBb/iNDfJh819xY2G/9OhYZpOoZP4S
	i6K6HOksmzxRmDAQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Jens Axboe <axboe@kernel.dk>,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
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
 Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [patch V4 33/36] s390: Use generic TIF bits
References: <20250908212737.353775467@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  8 Sep 2025 23:32:34 +0200 (CEST)

No point in defining generic items and the upcoming RSEQ optimizations are
only available with this _and_ the generic entry infrastructure, which is
already used by s390. So no further action required here.

This leaves a comment about the AUDIT/TRACE/SECCOMP bits which are handled
by SYSCALL_WORK in the generic code, so they seem redundant, but that's a
problem for the s390 wizards to think about.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>

---
 arch/s390/Kconfig                   |    1 
 arch/s390/include/asm/thread_info.h |   44 ++++++++++++++----------------------
 2 files changed, 19 insertions(+), 26 deletions(-)

--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -199,6 +199,7 @@ config S390
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_EBPF_JIT if HAVE_MARCH_Z196_FEATURES
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
+	select HAVE_GENERIC_TIF_BITS
 	select HAVE_GUP_FAST
 	select HAVE_FENTRY
 	select HAVE_FTRACE_GRAPH_FUNC
--- a/arch/s390/include/asm/thread_info.h
+++ b/arch/s390/include/asm/thread_info.h
@@ -56,43 +56,35 @@ void arch_setup_new_exec(void);
 
 /*
  * thread information flags bit numbers
+ *
+ * Tell the generic TIF infrastructure which special bits s390 supports
  */
-#define TIF_NOTIFY_RESUME	0	/* callback before returning to user */
-#define TIF_SIGPENDING		1	/* signal pending */
-#define TIF_NEED_RESCHED	2	/* rescheduling necessary */
-#define TIF_NEED_RESCHED_LAZY	3	/* lazy rescheduling needed */
-#define TIF_UPROBE		4	/* breakpointed or single-stepping */
-#define TIF_PATCH_PENDING	5	/* pending live patching update */
-#define TIF_ASCE_PRIMARY	6	/* primary asce is kernel asce */
-#define TIF_NOTIFY_SIGNAL	7	/* signal notifications exist */
-#define TIF_GUARDED_STORAGE	8	/* load guarded storage control block */
-#define TIF_ISOLATE_BP_GUEST	9	/* Run KVM guests with isolated BP */
-#define TIF_PER_TRAP		10	/* Need to handle PER trap on exit to usermode */
-#define TIF_31BIT		16	/* 32bit process */
-#define TIF_MEMDIE		17	/* is terminating due to OOM killer */
-#define TIF_RESTORE_SIGMASK	18	/* restore signal mask in do_signal() */
-#define TIF_SINGLE_STEP		19	/* This task is single stepped */
-#define TIF_BLOCK_STEP		20	/* This task is block stepped */
-#define TIF_UPROBE_SINGLESTEP	21	/* This task is uprobe single stepped */
+#define HAVE_TIF_NEED_RESCHED_LAZY
+#define HAVE_TIF_RESTORE_SIGMASK
+
+#include <asm-generic/thread_info_tif.h>
+
+/* Architecture specific bits */
+#define TIF_ASCE_PRIMARY	16	/* primary asce is kernel asce */
+#define TIF_GUARDED_STORAGE	17	/* load guarded storage control block */
+#define TIF_ISOLATE_BP_GUEST	18	/* Run KVM guests with isolated BP */
+#define TIF_PER_TRAP		19	/* Need to handle PER trap on exit to usermode */
+#define TIF_31BIT		20	/* 32bit process */
+#define TIF_SINGLE_STEP		21	/* This task is single stepped */
+#define TIF_BLOCK_STEP		22	/* This task is block stepped */
+#define TIF_UPROBE_SINGLESTEP	23	/* This task is uprobe single stepped */
+
+/* These could move over to SYSCALL_WORK bits, no? */
 #define TIF_SYSCALL_TRACE	24	/* syscall trace active */
 #define TIF_SYSCALL_AUDIT	25	/* syscall auditing active */
 #define TIF_SECCOMP		26	/* secure computing */
 #define TIF_SYSCALL_TRACEPOINT	27	/* syscall tracepoint instrumentation */
 
-#define _TIF_NOTIFY_RESUME	BIT(TIF_NOTIFY_RESUME)
-#define _TIF_SIGPENDING		BIT(TIF_SIGPENDING)
-#define _TIF_NEED_RESCHED	BIT(TIF_NEED_RESCHED)
-#define _TIF_NEED_RESCHED_LAZY	BIT(TIF_NEED_RESCHED_LAZY)
-#define _TIF_UPROBE		BIT(TIF_UPROBE)
-#define _TIF_PATCH_PENDING	BIT(TIF_PATCH_PENDING)
 #define _TIF_ASCE_PRIMARY	BIT(TIF_ASCE_PRIMARY)
-#define _TIF_NOTIFY_SIGNAL	BIT(TIF_NOTIFY_SIGNAL)
 #define _TIF_GUARDED_STORAGE	BIT(TIF_GUARDED_STORAGE)
 #define _TIF_ISOLATE_BP_GUEST	BIT(TIF_ISOLATE_BP_GUEST)
 #define _TIF_PER_TRAP		BIT(TIF_PER_TRAP)
 #define _TIF_31BIT		BIT(TIF_31BIT)
-#define _TIF_MEMDIE		BIT(TIF_MEMDIE)
-#define _TIF_RESTORE_SIGMASK	BIT(TIF_RESTORE_SIGMASK)
 #define _TIF_SINGLE_STEP	BIT(TIF_SINGLE_STEP)
 #define _TIF_BLOCK_STEP		BIT(TIF_BLOCK_STEP)
 #define _TIF_UPROBE_SINGLESTEP	BIT(TIF_UPROBE_SINGLESTEP)





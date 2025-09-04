Return-Path: <linux-kernel+bounces-801771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D706CB4499B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A931584380
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCA02EBB84;
	Thu,  4 Sep 2025 22:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nBRLg1ID";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dg1Hsr/s"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51E9350854
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 22:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757024503; cv=none; b=NFyhfyVssbDDMoYSbUVebw0xm/2+OLr4AnyJwshVen9S7f6wNaCrh5x5Gy95wF+z8kg4NEQXSIwdCT5pxMit1iiALbCiLXgi/k+fUM07YbBfl4T1khG9k76lrYPDUYwtSFMUMjjk/LyIlTse2hHytgFDiVLIq45rdQ+qe8hwfIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757024503; c=relaxed/simple;
	bh=L1JWxnGadc4iAIpVHtydXa6Ji62JsSxxuMzlDkEfw/Y=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=YQQvrGcSUU7vSM6PqNeignpLO09N0rHjTThztF0qzoVzA/20Z2I/6qxnfv5oRpTzu0lpN5Df23oJOV/ad8d0CslxdpD2VWkwKUyann92v5IHTEeY3YqKWGWtEBbdJ/5RY9nJPYfMdxbj9KGoMEKSXMn/l5iwrmp9f/zwVhqadV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nBRLg1ID; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dg1Hsr/s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250904185721.354680904@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757024500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=NPojs8vSDXAaW1DX67rhjWR33zDU0JjtuxM0InbbPUQ=;
	b=nBRLg1IDTnMdFPI8q7q3lCaK6917optzbWOUCy/gdSV+JNGme3CdDlPnMjRJ0V9zxp1+CI
	uAj5O40xjHBQNeyITl9zK4zYtAShZeAU2gc+JU2yxus4n7pZyIELi6CHyXAJMTlZW6BDCy
	GpUWPEiOaN9qNSdjNV3wKd1wKYKUSfaj4nhrenD2Zg7C06Tx8p+Ql4zmkCFjrHd1KYIGXc
	0Hx1ll4MGrHbePYKQiieG2uD1+aWDtMKMTTkZKv3DlJzf1kOg/yNEjQSESoOsVvd3Bsmdv
	8E8ZkDFzfr1uswALGnHcszcHlSriZmzAUYKmupLJdpAFeTA+BOTPHcG5frVVLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757024500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=NPojs8vSDXAaW1DX67rhjWR33zDU0JjtuxM0InbbPUQ=;
	b=dg1Hsr/s8QM8Xw90NgYrR7im5ZZU6giEUHGXHvzHHAa0FRtQuXmRVj3VtZ/Yi73g/uv8Fi
	oJ0MLMnNnrLyKJBg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Jens Axboe <axboe@kernel.dk>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
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
 Huacai Chen <chenhuacai@kernel.org>
Subject: [patch V3 35/37] riscv: Use generic TIF bits
References: <20250904185336.943880027@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri,  5 Sep 2025 00:21:39 +0200 (CEST)

No point in defining generic items and the upcoming RSEQ optimizations are
only available with this _and_ the generic entry infrastructure, which is
already used by RISCV. So no further action required here.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>

---
 arch/riscv/Kconfig                   |    1 +
 arch/riscv/include/asm/thread_info.h |   29 ++++++++++++-----------------
 2 files changed, 13 insertions(+), 17 deletions(-)

--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -161,6 +161,7 @@ config RISCV
 	select HAVE_FUNCTION_GRAPH_FREGS
 	select HAVE_FUNCTION_TRACER if !XIP_KERNEL && HAVE_DYNAMIC_FTRACE
 	select HAVE_EBPF_JIT if MMU
+	select HAVE_GENERIC_TIF_BITS
 	select HAVE_GUP_FAST if MMU
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_FUNCTION_ERROR_INJECTION
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -107,23 +107,18 @@ int arch_dup_task_struct(struct task_str
  * - pending work-to-be-done flags are in lowest half-word
  * - other flags in upper half-word(s)
  */
-#define TIF_NEED_RESCHED	0	/* rescheduling necessary */
-#define TIF_NEED_RESCHED_LAZY	1       /* Lazy rescheduling needed */
-#define TIF_NOTIFY_RESUME	2	/* callback before returning to user */
-#define TIF_SIGPENDING		3	/* signal pending */
-#define TIF_RESTORE_SIGMASK	4	/* restore signal mask in do_signal() */
-#define TIF_MEMDIE		5	/* is terminating due to OOM killer */
-#define TIF_NOTIFY_SIGNAL	9	/* signal notifications exist */
-#define TIF_UPROBE		10	/* uprobe breakpoint or singlestep */
-#define TIF_32BIT		11	/* compat-mode 32bit process */
-#define TIF_RISCV_V_DEFER_RESTORE	12 /* restore Vector before returing to user */
 
-#define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
-#define _TIF_NEED_RESCHED_LAZY	(1 << TIF_NEED_RESCHED_LAZY)
-#define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
-#define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
-#define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
-#define _TIF_UPROBE		(1 << TIF_UPROBE)
-#define _TIF_RISCV_V_DEFER_RESTORE	(1 << TIF_RISCV_V_DEFER_RESTORE)
+/*
+ * Tell the generic TIF infrastructure which bits riscv supports
+ */
+#define HAVE_TIF_NEED_RESCHED_LAZY
+#define HAVE_TIF_RESTORE_SIGMASK
+
+#include <asm-generic/thread_info_tif.h>
+
+#define TIF_32BIT			16	/* compat-mode 32bit process */
+#define TIF_RISCV_V_DEFER_RESTORE	17	/* restore Vector before returing to user */
+
+#define _TIF_RISCV_V_DEFER_RESTORE	BIT(TIF_RISCV_V_DEFER_RESTORE)
 
 #endif /* _ASM_RISCV_THREAD_INFO_H */




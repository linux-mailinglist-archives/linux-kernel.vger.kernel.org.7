Return-Path: <linux-kernel+bounces-806825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C5BB49C22
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E6CB7AB9C4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D9A322523;
	Mon,  8 Sep 2025 21:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U6dwpFsM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uE8+TOCU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92102321F3E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 21:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757367163; cv=none; b=GcyaCch4rHSvkvn1+4Io10qj54Ff4EuXvtS4zD7IJfF6RFwX6k89DV7Yqt314sgHPP3YJa5STo9IdPs0/sF8aFEk3VEvlY5MRCoOtt5QpvUSF/DaKz+oEJD2qobYmsxuzHMAQWlt1VIiiboMCYxs8il/oUh8OWxmJ3uzawsKV8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757367163; c=relaxed/simple;
	bh=L1JWxnGadc4iAIpVHtydXa6Ji62JsSxxuMzlDkEfw/Y=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Fb36Q4QqpBJNCxopdLBgDKTUOQtJZ1+A9Jl55gAFIEXuFAiOQJp32whD3GgiH8Gudf4ssOjQte/sjREPHrRrAeIOk5HNsPGtKloV4ZrR1W4JDK/X7xH7NbN9bejUYxB49rUkT5wHXWYsLQLZyf3YT9P4yD/C8XgOvk4+Ikc1yBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U6dwpFsM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uE8+TOCU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250908212927.500173102@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757367159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=NPojs8vSDXAaW1DX67rhjWR33zDU0JjtuxM0InbbPUQ=;
	b=U6dwpFsMZ2UnmUr2LIXC3AFDxZnUQLytLBgOGb3hi7wf0gJN0SaDABAEfze9AN4tHS1p30
	DppC6lmgEwB+vfK7RGHA9N5YxP+Xc/GB3JdaFLYK4esuYIBF2k2HQLiE0CvWi8BErnCAQi
	RgchO5dVBUTEnN4rHoCAtzslwGobA9ZSJw0lvDAoJPtJLJSE0skoHnE5/JPuhmRrQUoSNo
	lDVPe7wnDI4zleRPYH25jsSITlYx2i3w8fzjpHCsWRFvvzYPjNml/iK4JNSWkUpVaA9Hz8
	dA/ZGyg3D91F3gz2fb0zd8Ukh8a+WnpSfbcYegGh3Sl85/JEvKcq18/09UH+yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757367159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=NPojs8vSDXAaW1DX67rhjWR33zDU0JjtuxM0InbbPUQ=;
	b=uE8+TOCUsa3+qa4lQ9GIkMwMABtrrthWGjvbJqAdNnwnnqHSCJo3a4y7ObxSazyYctTASO
	3lPcVKZS5UrqttBQ==
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
Subject: [patch V4 35/36] riscv: Use generic TIF bits
References: <20250908212737.353775467@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  8 Sep 2025 23:32:38 +0200 (CEST)

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




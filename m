Return-Path: <linux-kernel+bounces-783265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6A7B32B0B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0DA3AA43DB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684FA2F60A4;
	Sat, 23 Aug 2025 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JicB2gaf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lej8ZLT7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318C22F3C28
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 16:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755967240; cv=none; b=QvE44CsaLnsVso0mxQviS6DsR9AMMVqgBO0Fl+Tbwci25UF2ovLlX9DeuzGlINVKkLnUfAoanZ4AQkwuJjcZVVtj1Q89wAUfmwdeQSOO2q+C1JBFz3FEx913nD+tEgJHy/ZzWt0ZeQGfQygPYec3AJYiOuvaOb/WbMimMRKWoVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755967240; c=relaxed/simple;
	bh=uUZdYRO007okY0kRRm9tI62V39ZdXzdjmDVeHh9YJVM=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=jA7feQq0XmhVMaszAGhpqz5Whl/bccyPJYGU70xkUEAlytcUmMOC7+tyOkH5/KdDSEDxjhFs9oA9/e18S0BNRMhDoihPaWNDV0r7D2qUzfNLvxX4nqYjfcxc2cNTqStFvp6GyipeHcQEJq2+7B4Mk761stHWVUyYybs/9It2LvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JicB2gaf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lej8ZLT7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250823161655.514963233@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755967237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Ae2PcYVqy5iPrMWzBb6EWbaXpNh86xWAsNJ6qWOKNoo=;
	b=JicB2gafIs63i6Y7RKgv0z683+bG4xRDR7p4K5Aatuxjh+OrW4C8F9+Pbar561ccrV3UfS
	ACBW2b9EoxWGPeoCco6LyfoJJtyRn2nXe9W5Vx4lwhBTV/SCdZCFo6RDBThmyd/4ayu7R0
	iKyHwkUTy6UVyaFzuQBzFORz9+dMDVex0FxUn9pIImgouvTH5NdSSQNDiNcrwewko76/f4
	zXifMpx5FfjQKDukemjmSYPaeGb5D8iyGg4/IDC8F5tGEy18+8BQT+xWy1Rw9WOKViMPHH
	OK2rrLumPeL1YBhiK4w1dkaBWeld1V8/CRP2ZSNzunyf87Hi4y979F1HwhuN5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755967237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Ae2PcYVqy5iPrMWzBb6EWbaXpNh86xWAsNJ6qWOKNoo=;
	b=lej8ZLT7ZkooEcx0jQ+OlQUVoaETLLgph7gHjU4uBLqyr64zpD34/GwYvmEeMe7YPxj7ZG
	wTnh7GbKvEh0WZDA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
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
Subject: [patch V2 35/37] riscv: Use generic TIF bits
References: <20250823161326.635281786@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sat, 23 Aug 2025 18:40:36 +0200 (CEST)

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



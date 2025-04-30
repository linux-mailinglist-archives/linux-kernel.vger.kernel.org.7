Return-Path: <linux-kernel+bounces-626946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC6FAA4965
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 13:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ED431BC0EF9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 11:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6173A25D526;
	Wed, 30 Apr 2025 11:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DhO0ZHTQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PmTVa9yy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18EB25A658;
	Wed, 30 Apr 2025 11:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746010974; cv=none; b=EY+mNyx037LTvFK4QxUJcy9A71feq6q+wdRUBV6s8uzVKAjeZ2B6SmogG+UIER2lhjs9UO6GIHUHql2QwIr3mjzZ0Wvx95H4qNSLcxOGo/bVMEWi+GVlP1puParEaodOsy2ljMOIGBkjQrVuVeUbuCoxrMCsE4nkAu3pVkr3lCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746010974; c=relaxed/simple;
	bh=ERsSHF6cveMP56swmamcYhe2qaD2zoqTzJM+wQ07ysg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XcHGgjCTnXHiTgRCyZ284aqk6eReH5KrAnPj/MkfMALc3GdGcwI51BBNQhPf5aMSZW8b76CMJFI5pIUf+AGB3i1AXcVyqrYV6yLpGAelHQ/onbYdIh3RsKRMlI8OORo1Q8m0Mr8PGXdMAwMlZqmN36dVvlp6ib4dK26IAIXZ7ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DhO0ZHTQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PmTVa9yy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746010968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UPn4Z3qJtGRDNuo4zQemDZcbXpzyUcw6dR3h1cNGvUo=;
	b=DhO0ZHTQJGB1yq6TJFvu1aVpKUH5ke9js3vZM/Yc+9b4QDTtFiwEdfokJ3kfkUMQGUGm8a
	G5ScKInr1/fn8bhcYLnwv9LjVeWLbhRu9PNPlNadRSYN/8juCVYFK/5dwe7RwUAqt/EwfS
	tIZC6pUO0Zfk9sqxINjtQmPATf1WJmUC8pLFOTSD+MYWyG24s2AI2oFADgZ53F2+h/9RrM
	EdjzEnNuvKvVRMWe3rryP1MhezynPV+jXVjGqbxskt/0fqwnXoUlALQmrmgubB5Wi/95Py
	LdoiEHkaRZOrpLBezdscXzOQtTbdYQYeOh6byU6bQqb1SScYO+rKxopBhiRAfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746010968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UPn4Z3qJtGRDNuo4zQemDZcbXpzyUcw6dR3h1cNGvUo=;
	b=PmTVa9yy0a1hT276r0xctpkO3THnJjxXo6qRW2BGROHq38zgj5u+AVCfEwGyZ0EmZQ0diY
	FEPnCzEyyyUB0OCQ==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v6 15/22] x86/tracing: Remove redundant trace_pagefault_key
Date: Wed, 30 Apr 2025 13:02:30 +0200
Message-Id: <c73668e917883f8dd3e47037a1d0d25a9a7ee69b.1745999587.git.namcao@linutronix.de>
In-Reply-To: <cover.1745999587.git.namcao@linutronix.de>
References: <cover.1745999587.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

trace_pagefault_key is used to optimize the pagefault tracepoints when it
is disabled. However, tracepoints already have built-in static_key for this
exact purpose.

Remove this redundant key.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/include/asm/trace/common.h      | 12 ------------
 arch/x86/include/asm/trace/exceptions.h  | 18 ++++++------------
 arch/x86/include/asm/trace/irq_vectors.h |  1 -
 arch/x86/kernel/Makefile                 |  1 -
 arch/x86/kernel/tracepoint.c             | 21 ---------------------
 arch/x86/mm/fault.c                      |  3 ---
 6 files changed, 6 insertions(+), 50 deletions(-)
 delete mode 100644 arch/x86/include/asm/trace/common.h
 delete mode 100644 arch/x86/kernel/tracepoint.c

diff --git a/arch/x86/include/asm/trace/common.h b/arch/x86/include/asm/tra=
ce/common.h
deleted file mode 100644
index f0f9bcdb74d9..000000000000
--- a/arch/x86/include/asm/trace/common.h
+++ /dev/null
@@ -1,12 +0,0 @@
-#ifndef _ASM_TRACE_COMMON_H
-#define _ASM_TRACE_COMMON_H
-
-#ifdef CONFIG_TRACING
-DECLARE_STATIC_KEY_FALSE(trace_pagefault_key);
-#define trace_pagefault_enabled()			\
-	static_branch_unlikely(&trace_pagefault_key)
-#else
-static inline bool trace_pagefault_enabled(void) { return false; }
-#endif
-
-#endif
diff --git a/arch/x86/include/asm/trace/exceptions.h b/arch/x86/include/asm=
/trace/exceptions.h
index 6b1e87194809..34bc8214a2d7 100644
--- a/arch/x86/include/asm/trace/exceptions.h
+++ b/arch/x86/include/asm/trace/exceptions.h
@@ -6,10 +6,6 @@
 #define _TRACE_PAGE_FAULT_H
=20
 #include <linux/tracepoint.h>
-#include <asm/trace/common.h>
-
-extern int trace_pagefault_reg(void);
-extern void trace_pagefault_unreg(void);
=20
 DECLARE_EVENT_CLASS(x86_exceptions,
=20
@@ -34,15 +30,13 @@ DECLARE_EVENT_CLASS(x86_exceptions,
 		  (void *)__entry->address, (void *)__entry->ip,
 		  __entry->error_code) );
=20
-#define DEFINE_PAGE_FAULT_EVENT(name)				\
-DEFINE_EVENT_FN(x86_exceptions, name,				\
-	TP_PROTO(unsigned long address,	struct pt_regs *regs,	\
-		 unsigned long error_code),			\
-	TP_ARGS(address, regs, error_code),			\
-	trace_pagefault_reg, trace_pagefault_unreg);
+DEFINE_EVENT(x86_exceptions, page_fault_user,
+	TP_PROTO(unsigned long address,	struct pt_regs *regs, unsigned long error=
_code),
+	TP_ARGS(address, regs, error_code));
=20
-DEFINE_PAGE_FAULT_EVENT(page_fault_user);
-DEFINE_PAGE_FAULT_EVENT(page_fault_kernel);
+DEFINE_EVENT(x86_exceptions, page_fault_kernel,
+	TP_PROTO(unsigned long address,	struct pt_regs *regs, unsigned long error=
_code),
+	TP_ARGS(address, regs, error_code));
=20
 #undef TRACE_INCLUDE_PATH
 #undef TRACE_INCLUDE_FILE
diff --git a/arch/x86/include/asm/trace/irq_vectors.h b/arch/x86/include/as=
m/trace/irq_vectors.h
index 88e7f0f3bf62..7408bebdfde0 100644
--- a/arch/x86/include/asm/trace/irq_vectors.h
+++ b/arch/x86/include/asm/trace/irq_vectors.h
@@ -6,7 +6,6 @@
 #define _TRACE_IRQ_VECTORS_H
=20
 #include <linux/tracepoint.h>
-#include <asm/trace/common.h>
=20
 #ifdef CONFIG_X86_LOCAL_APIC
=20
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index b43eb7e384eb..e8e33ec684ba 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -139,7 +139,6 @@ obj-$(CONFIG_OF)			+=3D devicetree.o
 obj-$(CONFIG_UPROBES)			+=3D uprobes.o
=20
 obj-$(CONFIG_PERF_EVENTS)		+=3D perf_regs.o
-obj-$(CONFIG_TRACING)			+=3D tracepoint.o
 obj-$(CONFIG_SCHED_MC_PRIO)		+=3D itmt.o
 obj-$(CONFIG_X86_UMIP)			+=3D umip.o
=20
diff --git a/arch/x86/kernel/tracepoint.c b/arch/x86/kernel/tracepoint.c
deleted file mode 100644
index 03ae1caaa878..000000000000
--- a/arch/x86/kernel/tracepoint.c
+++ /dev/null
@@ -1,21 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2013 Seiji Aguchi <seiji.aguchi@hds.com>
- */
-#include <linux/jump_label.h>
-#include <linux/atomic.h>
-
-#include <asm/trace/exceptions.h>
-
-DEFINE_STATIC_KEY_FALSE(trace_pagefault_key);
-
-int trace_pagefault_reg(void)
-{
-	static_branch_inc(&trace_pagefault_key);
-	return 0;
-}
-
-void trace_pagefault_unreg(void)
-{
-	static_branch_dec(&trace_pagefault_key);
-}
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 296d294142c8..7e3e51fa1f95 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1455,9 +1455,6 @@ static __always_inline void
 trace_page_fault_entries(struct pt_regs *regs, unsigned long error_code,
 			 unsigned long address)
 {
-	if (!trace_pagefault_enabled())
-		return;
-
 	if (user_mode(regs))
 		trace_page_fault_user(address, regs, error_code);
 	else
--=20
2.39.5



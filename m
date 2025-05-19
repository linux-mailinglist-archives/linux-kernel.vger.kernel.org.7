Return-Path: <linux-kernel+bounces-653559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C093ABBB1F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 12:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABA44189170D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 10:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FF727979B;
	Mon, 19 May 2025 10:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OEEILpGc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t4572h2u"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E494B277038;
	Mon, 19 May 2025 10:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747650485; cv=none; b=P2GD7qhSycoM/so7q6IG+K172puMD4ur5H6hmdcfMxrtRtOMOX+0YHs0N+EAEpzXgj8wni49WM5KaTL9FKd/tvCOZ000UlB1KjaskrkCvlL1t5afLNViO2WY5vHZ04gAo5LHnio8t1aBjcYdS8GEZ0ajuMQtyW3iPCnbDm/TeYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747650485; c=relaxed/simple;
	bh=X9c4o1srAPJS4jJpzIEanJMP/2JsQCKDEEYxWOor5n0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lbnu+XfSZ/59Ypgx1vaR6hZIJh3FULnGzylp0z0r4hqdSvadtEUfXva5LM4L9uuFs0zcvkwODFpQO4HamoBxVHk4HYBOBu63he8JGLnBL0a+bn/BxjNuB3pT9Rp9fNJ5ujY8Yq4PCxmUGE+BANXAZhbNWRalLibBNk5Lpt6B6Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OEEILpGc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t4572h2u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747650479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Rsz08m+bw3GeEZ+Ch8OHtu4e+JTcBt4qFbYPKBHdss=;
	b=OEEILpGcniRhkWsb7x65nndryqppDUn5lom53LFaxkuJ++vQCzsudZ40EdqdzNLhbzx/ei
	amF0wDckZbPc8sLkk7xbqbmt5n1I5NcKIsD4MxJSOkXnAh9mL/FCxW9VqmrleFcQNkbnGL
	z/O99oM5ltPz0f4JsFIg7q7E8TFYOG/WBGe5Lu6x0C2brqvpp8cuh9yG7LeGqP7pTFtaTb
	4G4s3M8q7OsoJ3gamvjyKG4y3piqNEYfH4Ux0P3HUBV0LRYTuo9y4JPNYUSHVfoFqzhYgT
	icudbp2fFCYnqzBN9cGtxnTeSySHSLxnNU9gi51JcCkjRLfjzUtzqiZXy9WhjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747650479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Rsz08m+bw3GeEZ+Ch8OHtu4e+JTcBt4qFbYPKBHdss=;
	b=t4572h2uLJd1aG8IXhrWYIRJ/qAjwL9xjvITWS2cf/hCatJLn8ogZmfJ+u1DgS45GozKuG
	7oTFL+zq1flw9YDg==
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
Subject: [PATCH v9 15/22] x86/tracing, x86/mm: Remove redundant trace_pagefault_key
Date: Mon, 19 May 2025 12:27:33 +0200
Message-Id: <81985c244f49fba5328078fdfb29198442af0f67.1747649899.git.namcao@linutronix.de>
In-Reply-To: <cover.1747649899.git.namcao@linutronix.de>
References: <cover.1747649899.git.namcao@linutronix.de>
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
index 84cfa179802c..99a783fd4691 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -141,7 +141,6 @@ obj-$(CONFIG_OF)			+=3D devicetree.o
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



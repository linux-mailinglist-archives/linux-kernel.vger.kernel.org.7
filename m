Return-Path: <linux-kernel+bounces-724461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E97C4AFF339
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33FE91737A2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E54621D00D;
	Wed,  9 Jul 2025 20:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="aqImiENN"
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FF21F0995
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 20:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752094107; cv=none; b=AkrXWudYMnncvNkMwBZszCQORsWoBhcC2dFChMGcD5MX1bLPvEHH3Dk3VowXeHidAxIyjNt+mBq3n/KFDBi0XGbdnwoYsX4tyGz/iNDp04pG113JjEm8ddeISLsbg20er132NSXodLaMRLVyNfNzquBA7fcjpbI4+5icarmH6m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752094107; c=relaxed/simple;
	bh=nYgaYU0IrWe2u326RUgu8f5WCSeo4+Rn0sdJZDz0nhA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PEKCqyhvfsp+0WfKUDeyVwvmnlFMMHygZynioFJcf0mnjmj39cbHs9s7o+ZpOSMQ7CTTUa0jdRq7Ydx6IWe7y2lyTu1yd0oyCu5L6B0jqgKaMnIZYRwUsZbN7+q8ze1WhnJr3LsA7JiE76K8mBj7/a0G1YU6ed7fV/jfCQh/H88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=aqImiENN; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1752094097;
	bh=nYgaYU0IrWe2u326RUgu8f5WCSeo4+Rn0sdJZDz0nhA=;
	h=From:To:Cc:Subject:Date:From;
	b=aqImiENNPS7CvSNvHEvyoM3Q93inmucYHQTKK1a3cN53c2HmP9KYc7H0csVi2QMcV
	 mQscBbQr2ojoOz1RT1gTaPf6FUFVmcVvc2FF2j53AFql/3l6Ednb8LkbbLtGXx4aIW
	 joMqzQQ3g5EdnRSu4Wyp5sUR4+OSsYgGy6jNa/UgdziqZhjuashY2deVQv3Ec0Wo8J
	 HkYguQG6gcQlpjhv/CEBSJNExbJamqjJ2q9CmAw6PmDUw0q8KfuiwlDHK1KjqUBcW1
	 8A1GFN8R6QOY3z6XOskxra7vNP6KL8xvgENhs+EKA932c8ziZbeCj3a5M6IigUf1dc
	 8WTHIdZ2wU9YQ==
Received: from compudjdev.. (192-222-132-26.qc.cable.ebox.net [192.222.132.26])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4bcqnF2rCjzPMK;
	Wed,  9 Jul 2025 16:48:17 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [RFC PATCH] unwind_user: Fix userspace unwind iterator 32-bit compat handling
Date: Wed,  9 Jul 2025 16:47:57 -0400
Message-ID: <20250709204813.5302-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the stack unwind iterator to clean the overall design and fix
32-bit compat corner-cases that arise due to confusion over the semantic
of the struct unwind_user_state type field.

Observed Issue
==============

Before this refactor, the struct unwind_user_state type field identifies:

- Whether sframe is available in the current process, for at least
  portions of the address space,
- Whether frame pointers should be used for stack walk,
- Whether frame pointers should be used for stack walk in a 32-bit
  compat process.

It would be natural for the unwind iterator caller to expect the
"state->type" to contain the type of stack walk operation performed for
the most recent unwind iteration (unwind_user_next()), but it actually
acts as an internal cache and is unrelated to the current iteration,
which makes this field confusing.

It is not only confusing to the caller, but also the the implementation
of unwind_user_next(). Is has the following drawbacks:

- A 32-bit compat process will favor using frame pointers rather than
  sframe for its next unwind iterator, which is an unexpected priority
  order because sframe is more accurate than frame pointers when
  available.
- Because the "UNWIND_USER_TYPE_SFRAME" state type is unaware of 32-bit
  compat, handling of sframe would be broken on 32-bit compat because
  compat_fp_state() would return false, thus expecting 64-bit unsigned
  long types.

Moreover, only IA32 compat emulation is supported. x32 support appears
to be missing.

Cause
=====

Associating a semantic to a single enumeration field that consists of:

- many orthogonal properties, without listing all those properties
  (sframe vs frame pointer, compat vs non-compat) within each of the
  enumeration labels,
- an implicit priority,

leads to confusion in the unwind iterator implementation.

Using ifdef based on CONFIG_IA32_EMULATION and re-implementing a custom
"in_compat_mode" rather than using the pre-existing in_compat_syscall()
contributes to mishandling of x32 binaries.

Solution
========

Split this type field into three fields:

- A "current_type" field, which can be queried by the iterator caller
  and by architecture code to learn which method is used for the
  current unwind iteration,
- An "available_types" field, which is a bitmask of available user types.
  It is used internally by the iterator implementation.
- A "compat" field to track whether the unwind targets a 32-bit compat
  process.

This allows removing the "UNWIND_USER_TYPE_COMPAT_FP" label from the
unwind types, since it is now implicitly taken into account by the
"compat" field.

This approach will also make it easier to introduce new unwind types
in the future, such as an unwinder for JIT code.

Also use CONFIG_COMPAT ifdef rather than CONFIG_IA32_EMULATION, and
remove the in_compat_mode() custom macro in favor of
in_compat_syscall(). This aims to fix x32 support.

Known Drawbacks
===============

None.

[ This is based on linux-trace unwind/sframe ]

Fixes: 1abc29eeca39 ("unwind_user/sframe: Wire up unwind_user to sframe")
Fixes: ce8d69a1a578 ("unwind_user/x86: Enable compat mode frame pointer unwinding on x86")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Indu Bhagat <indu.bhagat@oracle.com>
Cc: "Jose E. Marchesi" <jemarch@gnu.org>
Cc: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Jens Remus <jremus@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 arch/Kconfig                             |   4 -
 arch/x86/Kconfig                         |   1 -
 arch/x86/include/asm/unwind_user.h       |   9 +-
 arch/x86/include/asm/unwind_user_types.h |   4 +-
 arch/x86/kernel/stacktrace.c             |   6 +-
 include/linux/unwind_user.h              |   9 --
 include/linux/unwind_user_types.h        |  25 ++++-
 kernel/unwind/user.c                     | 137 +++++++++++++----------
 8 files changed, 109 insertions(+), 86 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 86eec85cb898..c2f12135db92 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -442,10 +442,6 @@ config HAVE_UNWIND_USER_FP
 	bool
 	select UNWIND_USER
 
-config HAVE_UNWIND_USER_COMPAT_FP
-	bool
-	depends on HAVE_UNWIND_USER_FP
-
 config HAVE_UNWIND_USER_SFRAME
 	bool
 	select UNWIND_USER
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 8a382a6b9be3..05dbfa3eb8ea 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -302,7 +302,6 @@ config X86
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UACCESS_VALIDATION		if HAVE_OBJTOOL
 	select HAVE_UNSTABLE_SCHED_CLOCK
-	select HAVE_UNWIND_USER_COMPAT_FP	if IA32_EMULATION
 	select HAVE_UNWIND_USER_FP		if X86_64
 	select HAVE_UNWIND_USER_SFRAME		if X86_64
 	select HAVE_USER_RETURN_NOTIFIER
diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
index 19634a73612d..77f7af37aa82 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -3,6 +3,7 @@
 #define _ASM_X86_UNWIND_USER_H
 
 #include <linux/unwind_user_types.h>
+#include <linux/compat.h>
 
 #define ARCH_INIT_USER_FP_FRAME							\
 	.cfa_off	= (s32)sizeof(long) *  2,				\
@@ -10,7 +11,7 @@
 	.fp_off		= (s32)sizeof(long) * -2,				\
 	.use_fp		= true,
 
-#ifdef CONFIG_IA32_EMULATION
+#ifdef CONFIG_COMPAT
 
 #define ARCH_INIT_USER_COMPAT_FP_FRAME						\
 	.cfa_off	= (s32)sizeof(u32)  *  2,				\
@@ -18,14 +19,12 @@
 	.fp_off		= (s32)sizeof(u32)  * -2,				\
 	.use_fp		= true,
 
-#define in_compat_mode(regs) !user_64bit_mode(regs)
-
 void arch_unwind_user_init(struct unwind_user_state *state,
 			   struct pt_regs *regs);
 
 static inline void arch_unwind_user_next(struct unwind_user_state *state)
 {
-	if (state->type != UNWIND_USER_TYPE_COMPAT_FP)
+	if (!in_compat_syscall())
 		return;
 
 	state->ip += state->arch.cs_base;
@@ -35,7 +34,7 @@ static inline void arch_unwind_user_next(struct unwind_user_state *state)
 #define arch_unwind_user_init arch_unwind_user_init
 #define arch_unwind_user_next arch_unwind_user_next
 
-#endif /* CONFIG_IA32_EMULATION */
+#endif /* CONFIG_COMPAT */
 
 #include <asm-generic/unwind_user.h>
 
diff --git a/arch/x86/include/asm/unwind_user_types.h b/arch/x86/include/asm/unwind_user_types.h
index f93d535f900e..7b940520659e 100644
--- a/arch/x86/include/asm/unwind_user_types.h
+++ b/arch/x86/include/asm/unwind_user_types.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_UNWIND_USER_TYPES_H
 #define _ASM_X86_UNWIND_USER_TYPES_H
 
-#ifdef CONFIG_IA32_EMULATION
+#ifdef CONFIG_COMPAT
 
 struct arch_unwind_user_state {
 	unsigned long ss_base;
@@ -10,7 +10,7 @@ struct arch_unwind_user_state {
 };
 #define arch_unwind_user_state arch_unwind_user_state
 
-#endif /* CONFIG_IA32_EMULATION */
+#endif /* CONFIG_COMPAT */
 
 #include <asm-generic/unwind_user_types.h>
 
diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
index 8ef9d8c71df9..396897851b00 100644
--- a/arch/x86/kernel/stacktrace.c
+++ b/arch/x86/kernel/stacktrace.c
@@ -131,13 +131,13 @@ void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
 	}
 }
 
-#ifdef CONFIG_IA32_EMULATION
+#ifdef CONFIG_COMPAT
 void arch_unwind_user_init(struct unwind_user_state *state,
 			   struct pt_regs *regs)
 {
 	unsigned long cs_base, ss_base;
 
-	if (state->type != UNWIND_USER_TYPE_COMPAT_FP)
+	if (user_64bit_mode(regs))
 		return;
 
 	cs_base = insn_get_seg_base(regs, INAT_SEG_REG_CS);
@@ -155,4 +155,4 @@ void arch_unwind_user_init(struct unwind_user_state *state,
 	state->sp += ss_base;
 	state->fp += ss_base;
 }
-#endif /* CONFIG_IA32_EMULATION */
+#endif /* CONFIG_COMPAT */
diff --git a/include/linux/unwind_user.h b/include/linux/unwind_user.h
index 8a4af0214ecb..0308adb349fc 100644
--- a/include/linux/unwind_user.h
+++ b/include/linux/unwind_user.h
@@ -5,15 +5,6 @@
 #include <linux/unwind_user_types.h>
 #include <asm/unwind_user.h>
 
-#ifndef ARCH_INIT_USER_FP_FRAME
- #define ARCH_INIT_USER_FP_FRAME
-#endif
-
-#ifndef ARCH_INIT_USER_COMPAT_FP_FRAME
- #define ARCH_INIT_USER_COMPAT_FP_FRAME
- #define in_compat_mode(regs) false
-#endif
-
 /*
  * If an architecture needs to initialize the state for a specific
  * reason, for example, it may need to do something different
diff --git a/include/linux/unwind_user_types.h b/include/linux/unwind_user_types.h
index 4d50476e950e..fc440ae3a29b 100644
--- a/include/linux/unwind_user_types.h
+++ b/include/linux/unwind_user_types.h
@@ -9,11 +9,23 @@
 struct arch_unwind_user_state {};
 #endif
 
+
+/*
+ * unwind types, listed in priority order: lower numbers are attempted first if
+ * available.
+ */
+enum unwind_user_type_bits {
+	UNWIND_USER_TYPE_SFRAME_BIT =		0,
+	UNWIND_USER_TYPE_FP_BIT =		1,
+
+	_NR_UNWIND_USER_TYPE_BITS,
+};
+
 enum unwind_user_type {
-	UNWIND_USER_TYPE_NONE,
-	UNWIND_USER_TYPE_FP,
-	UNWIND_USER_TYPE_COMPAT_FP,
-	UNWIND_USER_TYPE_SFRAME,
+	/* Type "none" for the start of stack walk iteration. */
+	UNWIND_USER_TYPE_NONE =			0,
+	UNWIND_USER_TYPE_SFRAME =		(1U << UNWIND_USER_TYPE_SFRAME_BIT),
+	UNWIND_USER_TYPE_FP =			(1U << UNWIND_USER_TYPE_FP_BIT),
 };
 
 struct unwind_stacktrace {
@@ -33,7 +45,10 @@ struct unwind_user_state {
 	unsigned long sp;
 	unsigned long fp;
 	struct arch_unwind_user_state arch;
-	enum unwind_user_type type;
+	/* Unwind time used for the most recent unwind traversal iteration. */
+	enum unwind_user_type current_type;
+	/* Unwind types available in the current context. Bitmask of enum unwind_user_type. */
+	unsigned int available_types;
 	bool done;
 };
 
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index 6e7ca9f1293a..349bdd72390b 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -8,75 +8,48 @@
 #include <linux/unwind_user.h>
 #include <linux/uaccess.h>
 #include <linux/sframe.h>
+#include <linux/compat.h>
 
 static struct unwind_user_frame fp_frame = {
 	ARCH_INIT_USER_FP_FRAME
 };
 
+#ifdef CONFIG_COMPAT
 static struct unwind_user_frame compat_fp_frame = {
 	ARCH_INIT_USER_COMPAT_FP_FRAME
 };
+#endif
 
-static inline bool fp_state(struct unwind_user_state *state)
+static struct unwind_user_frame *get_fp_frame(void)
 {
-	return IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP) &&
-	       state->type == UNWIND_USER_TYPE_FP;
+#ifdef CONFIG_COMPAT
+	if (in_compat_syscall())
+		return &compat_fp_frame;
+#endif
+	return &fp_frame;
 }
 
 #define for_each_user_frame(state) \
 	for (unwind_user_start(state); !(state)->done; unwind_user_next(state))
 
-static inline bool compat_fp_state(struct unwind_user_state *state)
-{
-	return IS_ENABLED(CONFIG_HAVE_UNWIND_USER_COMPAT_FP) &&
-	       state->type == UNWIND_USER_TYPE_COMPAT_FP;
-}
-
-static inline bool sframe_state(struct unwind_user_state *state)
-{
-	return IS_ENABLED(CONFIG_HAVE_UNWIND_USER_SFRAME) &&
-	       state->type == UNWIND_USER_TYPE_SFRAME;
-}
-
-#define unwind_get_user_long(to, from, state)				\
+#define unwind_get_user_long(to, from)					\
 ({									\
 	int __ret;							\
-	if (compat_fp_state(state))					\
+	if (in_compat_syscall())					\
 		__ret = get_user(to, (u32 __user *)(from));		\
 	else								\
 		__ret = get_user(to, (unsigned long __user *)(from));	\
 	__ret;								\
 })
 
-static int unwind_user_next(struct unwind_user_state *state)
+static int unwind_user_next_common(struct unwind_user_state *state, struct unwind_user_frame *frame)
 {
-	struct unwind_user_frame *frame;
-	struct unwind_user_frame _frame;
-	unsigned long cfa = 0, fp, ra = 0;
+	unsigned long cfa, fp, ra = 0;
 	unsigned int shift;
 
-	if (state->done)
-		return -EINVAL;
-
-	if (compat_fp_state(state)) {
-		frame = &compat_fp_frame;
-	} else if (sframe_state(state)) {
-		/* sframe expects the frame to be local storage */
-		frame = &_frame;
-		if (sframe_find(state->ip, frame)) {
-			if (!IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP))
-				goto done;
-			frame = &fp_frame;
-		}
-	} else if (fp_state(state)) {
-		frame = &fp_frame;
-	} else {
-		goto done;
-	}
-
 	if (frame->use_fp) {
 		if (state->fp < state->sp)
-			goto done;
+			return -EINVAL;
 		cfa = state->fp;
 	} else {
 		cfa = state->sp;
@@ -87,30 +60,84 @@ static int unwind_user_next(struct unwind_user_state *state)
 
 	/* stack going in wrong direction? */
 	if (cfa <= state->sp)
-		goto done;
+		return -EINVAL;
 
 	/* Make sure that the address is word aligned */
-	shift = sizeof(long) == 4 || compat_fp_state(state) ? 2 : 3;
+	shift = (sizeof(long) == 4 || in_compat_syscall()) ? 2 : 3;
 	if ((cfa + frame->ra_off) & ((1 << shift) - 1))
-		goto done;
+		return -EINVAL;
 
 	/* Find the Return Address (RA) */
-	if (unwind_get_user_long(ra, cfa + frame->ra_off, state))
-		goto done;
+	if (unwind_get_user_long(ra, cfa + frame->ra_off))
+		return -EINVAL;
 
-	if (frame->fp_off && unwind_get_user_long(fp, cfa + frame->fp_off, state))
-		goto done;
+	if (frame->fp_off && unwind_get_user_long(fp, cfa + frame->fp_off))
+		return -EINVAL;
 
 	state->ip = ra;
 	state->sp = cfa;
 	if (frame->fp_off)
 		state->fp = fp;
+	return 0;
+}
 
-	arch_unwind_user_next(state);
+static int unwind_user_next_sframe(struct unwind_user_state *state)
+{
+	struct unwind_user_frame _frame, *frame;
+
+	/* sframe expects the frame to be local storage */
+	frame = &_frame;
+	if (sframe_find(state->ip, frame))
+		return -ENOENT;
+	return unwind_user_next_common(state, frame);
+}
 
+static int unwind_user_next_fp(struct unwind_user_state *state)
+{
+	return unwind_user_next_common(state, get_fp_frame());
+}
+
+static int unwind_user_next(struct unwind_user_state *state)
+{
+	unsigned long iter_mask = state->available_types;
+	unsigned int bit;
+
+	if (state->done)
+		return -EINVAL;
+
+	for_each_set_bit(bit, &iter_mask, _NR_UNWIND_USER_TYPE_BITS) {
+		enum unwind_user_type type = 1U << bit;
+
+		state->current_type = type;
+		switch (type) {
+		case UNWIND_USER_TYPE_SFRAME:
+			switch (unwind_user_next_sframe(state)) {
+			case 0:
+				goto end;
+			case -ENOENT:
+				continue;	/* Try next method. */
+			default:
+				goto done;
+			}
+		case UNWIND_USER_TYPE_FP:
+			if (!unwind_user_next_fp(state))
+				goto end;
+			else
+				goto done;
+		case UNWIND_USER_TYPE_NONE:
+			break;
+		}
+	}
+
+	/* No successful unwind method. */
+	goto done;
+
+end:
+	arch_unwind_user_next(state);
 	return 0;
 
 done:
+	state->current_type = UNWIND_USER_TYPE_NONE;
 	state->done = true;
 	return -EINVAL;
 }
@@ -126,14 +153,10 @@ static int unwind_user_start(struct unwind_user_state *state)
 		return -EINVAL;
 	}
 
-	if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_COMPAT_FP) && in_compat_mode(regs))
-		state->type = UNWIND_USER_TYPE_COMPAT_FP;
-	else if (current_has_sframe())
-		state->type = UNWIND_USER_TYPE_SFRAME;
-	else if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP))
-		state->type = UNWIND_USER_TYPE_FP;
-	else
-		state->type = UNWIND_USER_TYPE_NONE;
+	if (current_has_sframe())
+		state->available_types |= UNWIND_USER_TYPE_SFRAME;
+	if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP))
+		state->available_types |= UNWIND_USER_TYPE_FP;
 
 	state->ip = instruction_pointer(regs);
 	state->sp = user_stack_pointer(regs);
-- 
2.43.0



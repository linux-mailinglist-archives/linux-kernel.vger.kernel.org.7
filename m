Return-Path: <linux-kernel+bounces-618810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98772A9B3E7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 18:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66660465CCF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 16:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5692328A1CE;
	Thu, 24 Apr 2025 16:24:37 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA5B288C8F;
	Thu, 24 Apr 2025 16:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745511876; cv=none; b=sFjfUKC0XMHTgAw6RN6c8gshwejlRbswf2huNDVB2YJF19c7551odsDKBTCvlmFWaAaMufJJXprJTwE2jqPvlIMCSASpI15WEcb1ypPE7fUEuBS5j8tJ+Ge2JWEf7kqhBkxrdUC1hVEw/on4VCy9dp1GkkcQzleyAMk1Mk+7RpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745511876; c=relaxed/simple;
	bh=E1xBswCCqHl+PUt5flVe2+AT+3CNFiwEMEJiulAI1Fg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=eLBTSDsEJKJEnHe2B58L68UdZvRTHFBQoCTV17R/WZDT4MdBDZs4GwZ7WIts3P2CfFaWwRWdIXnTEi+Ux7VgK8UHFtPfsOJ+5plgI0PUQivZbqtKI0bBBnloJ+g9+meuTmLadb2r2AgYoSOGGh6dx84xzkATFraT8B1V2b/5R48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FEDFC4CEEB;
	Thu, 24 Apr 2025 16:24:36 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1u7zPE-0000000GyXg-0hiY;
	Thu, 24 Apr 2025 12:26:32 -0400
Message-ID: <20250424162632.016673714@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 24 Apr 2025 12:25:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org,
 Mark Brown <broonie@kernel.org>,
 linux-toolchains@vger.kernel.org,
 Jordan Rome <jordalgo@meta.com>,
 Sam James <sam@gentoo.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Jens Remus <jremus@linux.ibm.com>,
 Florian Weimer <fweimer@redhat.com>,
 Andy Lutomirski <luto@kernel.org>,
 Weinan Liu <wnliu@google.com>,
 Blake Jones <blakejones@google.com>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>
Subject: [PATCH v5 05/17] unwind_user: Add compat mode frame pointer support
References: <20250424162529.686762589@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

Add optional support for user space compat mode frame pointer unwinding.
If supported, the arch needs to enable CONFIG_HAVE_UNWIND_USER_COMPAT_FP
and define ARCH_INIT_USER_COMPAT_FP_FRAME.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/Kconfig                            |  4 +++
 include/asm-generic/Kbuild              |  2 ++
 include/asm-generic/unwind_user.h       | 15 +++++++++++
 include/asm-generic/unwind_user_types.h |  9 +++++++
 include/linux/unwind_user_types.h       |  3 +++
 kernel/unwind/user.c                    | 36 ++++++++++++++++++++++---
 6 files changed, 65 insertions(+), 4 deletions(-)
 create mode 100644 include/asm-generic/unwind_user_types.h

diff --git a/arch/Kconfig b/arch/Kconfig
index 0e3844c0e200..dbb1cc89e040 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -442,6 +442,10 @@ config HAVE_UNWIND_USER_FP
 	bool
 	select UNWIND_USER
 
+config HAVE_UNWIND_USER_COMPAT_FP
+	bool
+	depends on HAVE_UNWIND_USER_FP
+
 config HAVE_PERF_REGS
 	bool
 	help
diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index 8675b7b4ad23..b797a2434396 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -59,6 +59,8 @@ mandatory-y += tlbflush.h
 mandatory-y += topology.h
 mandatory-y += trace_clock.h
 mandatory-y += uaccess.h
+mandatory-y += unwind_user.h
+mandatory-y += unwind_user_types.h
 mandatory-y += vermagic.h
 mandatory-y += vga.h
 mandatory-y += video.h
diff --git a/include/asm-generic/unwind_user.h b/include/asm-generic/unwind_user.h
index 832425502fb3..385638ce4aec 100644
--- a/include/asm-generic/unwind_user.h
+++ b/include/asm-generic/unwind_user.h
@@ -2,8 +2,23 @@
 #ifndef _ASM_GENERIC_UNWIND_USER_H
 #define _ASM_GENERIC_UNWIND_USER_H
 
+#include <asm/unwind_user_types.h>
+
 #ifndef ARCH_INIT_USER_FP_FRAME
  #define ARCH_INIT_USER_FP_FRAME
 #endif
 
+#ifndef ARCH_INIT_USER_COMPAT_FP_FRAME
+ #define ARCH_INIT_USER_COMPAT_FP_FRAME
+ #define in_compat_mode(regs) false
+#endif
+
+#ifndef arch_unwind_user_init
+static inline void arch_unwind_user_init(struct unwind_user_state *state, struct pt_regs *reg) {}
+#endif
+
+#ifndef arch_unwind_user_next
+static inline void arch_unwind_user_next(struct unwind_user_state *state) {}
+#endif
+
 #endif /* _ASM_GENERIC_UNWIND_USER_H */
diff --git a/include/asm-generic/unwind_user_types.h b/include/asm-generic/unwind_user_types.h
new file mode 100644
index 000000000000..ee803de7c998
--- /dev/null
+++ b/include/asm-generic/unwind_user_types.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_GENERIC_UNWIND_USER_TYPES_H
+#define _ASM_GENERIC_UNWIND_USER_TYPES_H
+
+#ifndef arch_unwind_user_state
+struct arch_unwind_user_state {};
+#endif
+
+#endif /* _ASM_GENERIC_UNWIND_USER_TYPES_H */
diff --git a/include/linux/unwind_user_types.h b/include/linux/unwind_user_types.h
index 65bd070eb6b0..3ec4a097a3dd 100644
--- a/include/linux/unwind_user_types.h
+++ b/include/linux/unwind_user_types.h
@@ -3,10 +3,12 @@
 #define _LINUX_UNWIND_USER_TYPES_H
 
 #include <linux/types.h>
+#include <asm/unwind_user_types.h>
 
 enum unwind_user_type {
 	UNWIND_USER_TYPE_NONE,
 	UNWIND_USER_TYPE_FP,
+	UNWIND_USER_TYPE_COMPAT_FP,
 };
 
 struct unwind_stacktrace {
@@ -25,6 +27,7 @@ struct unwind_user_state {
 	unsigned long ip;
 	unsigned long sp;
 	unsigned long fp;
+	struct arch_unwind_user_state arch;
 	enum unwind_user_type type;
 	bool done;
 };
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index 73fd4e150dfd..92963f129c6a 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -13,12 +13,32 @@ static struct unwind_user_frame fp_frame = {
 	ARCH_INIT_USER_FP_FRAME
 };
 
+static struct unwind_user_frame compat_fp_frame = {
+	ARCH_INIT_USER_COMPAT_FP_FRAME
+};
+
 static inline bool fp_state(struct unwind_user_state *state)
 {
 	return IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP) &&
 	       state->type == UNWIND_USER_TYPE_FP;
 }
 
+static inline bool compat_state(struct unwind_user_state *state)
+{
+	return IS_ENABLED(CONFIG_HAVE_UNWIND_USER_COMPAT_FP) &&
+	       state->type == UNWIND_USER_TYPE_COMPAT_FP;
+}
+
+#define UNWIND_GET_USER_LONG(to, from, state)				\
+({									\
+	int __ret;							\
+	if (compat_state(state))					\
+		__ret = get_user(to, (u32 __user *)(from));		\
+	else								\
+		__ret = get_user(to, (u64 __user *)(from));		\
+	__ret;								\
+})
+
 int unwind_user_next(struct unwind_user_state *state)
 {
 	struct unwind_user_frame _frame;
@@ -28,7 +48,9 @@ int unwind_user_next(struct unwind_user_state *state)
 	if (state->done)
 		return -EINVAL;
 
-	if (fp_state(state))
+	if (compat_state(state))
+		frame = &compat_fp_frame;
+	else if (fp_state(state))
 		frame = &fp_frame;
 	else
 		goto the_end;
@@ -39,10 +61,10 @@ int unwind_user_next(struct unwind_user_state *state)
 	if (cfa <= state->sp)
 		goto the_end;
 
-	if (get_user(ra, (unsigned long *)(cfa + frame->ra_off)))
+	if (UNWIND_GET_USER_LONG(ra, cfa + frame->ra_off, state))
 		goto the_end;
 
-	if (frame->fp_off && get_user(fp, (unsigned long __user *)(cfa + frame->fp_off)))
+	if (frame->fp_off && UNWIND_GET_USER_LONG(fp, cfa + frame->fp_off, state))
 		goto the_end;
 
 	state->ip = ra;
@@ -50,6 +72,8 @@ int unwind_user_next(struct unwind_user_state *state)
 	if (frame->fp_off)
 		state->fp = fp;
 
+	arch_unwind_user_next(state);
+
 	return 0;
 
 the_end:
@@ -68,7 +92,9 @@ int unwind_user_start(struct unwind_user_state *state)
 		return -EINVAL;
 	}
 
-	if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP))
+	if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_COMPAT_FP) && in_compat_mode(regs))
+		state->type = UNWIND_USER_TYPE_COMPAT_FP;
+	else if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP))
 		state->type = UNWIND_USER_TYPE_FP;
 	else
 		state->type = UNWIND_USER_TYPE_NONE;
@@ -77,6 +103,8 @@ int unwind_user_start(struct unwind_user_state *state)
 	state->sp = user_stack_pointer(regs);
 	state->fp = frame_pointer(regs);
 
+	arch_unwind_user_init(state, regs);
+
 	return 0;
 }
 
-- 
2.47.2




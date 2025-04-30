Return-Path: <linux-kernel+bounces-627803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 711CAAA5542
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 22:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D33F44E5746
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 20:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D532980CF;
	Wed, 30 Apr 2025 20:01:08 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B162882C2;
	Wed, 30 Apr 2025 20:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746043264; cv=none; b=cX9Sja1Lr+aL2kyRJQWg9FnFYT3g7gp2+teMM7B3AEpDm4M2S87aynV/pl+s2giFG8A4jAx+bKXxGG1+06EuVNGrgfNzhjRw4ZCXZffWTg6tikAhLxUhIBqCMz/Bc+hma7iHp0TxZIgkcdZ0tF13qT/kWgJhOhy+NaWSjLLKZ48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746043264; c=relaxed/simple;
	bh=eATf4fZeNp3RnCSTULXp/Dl7q+fVeO6RbWAUiLtTQQY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=PYAi8/wY6kPHvCaFHRenmiZBLlZ7bIo2xH36yz48GmRFx83vi9UMJ08BQakX1n4xXb6YxhXKzH1muk3maYjh7Q6A7aZW8N52RnJcWUekez2yJ2dnajizRGMlnrzVTMpazPunPPPs7+AAlOwi4jmUjmUrH5Czx+8xhMBr8alZTLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5503AC4CEE7;
	Wed, 30 Apr 2025 20:01:04 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uADcC-00000001dQ1-2jDn;
	Wed, 30 Apr 2025 16:01:08 -0400
Message-ID: <20250430200108.499313094@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 30 Apr 2025 15:57:52 -0400
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
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Alexander Aring <aahringo@redhat.com>
Subject: [PATCH v7 06/18] unwind_user/x86: Enable compat mode frame pointer unwinding on x86
References: <20250430195746.827125963@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

Use ARCH_INIT_USER_COMPAT_FP_FRAME to describe how frame pointers are
unwound on x86, and implement the hooks needed to add the segment base
addresses.  Enable HAVE_UNWIND_USER_COMPAT_FP if the system has compat
mode compiled in.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/x86/Kconfig                         |  1 +
 arch/x86/include/asm/unwind_user.h       | 50 ++++++++++++++++++++++++
 arch/x86/include/asm/unwind_user_types.h | 17 ++++++++
 3 files changed, 68 insertions(+)
 create mode 100644 arch/x86/include/asm/unwind_user_types.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b5a85d2be5ee..35d3b01b65c6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -301,6 +301,7 @@ config X86
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UACCESS_VALIDATION		if HAVE_OBJTOOL
 	select HAVE_UNSTABLE_SCHED_CLOCK
+	select HAVE_UNWIND_USER_COMPAT_FP	if IA32_EMULATION
 	select HAVE_UNWIND_USER_FP		if X86_64
 	select HAVE_USER_RETURN_NOTIFIER
 	select HAVE_GENERIC_VDSO
diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
index 8597857bf896..bb1148111259 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -2,10 +2,60 @@
 #ifndef _ASM_X86_UNWIND_USER_H
 #define _ASM_X86_UNWIND_USER_H
 
+#include <linux/unwind_user_types.h>
+#include <asm/ptrace.h>
+#include <asm/perf_event.h>
+
 #define ARCH_INIT_USER_FP_FRAME							\
 	.cfa_off	= (s32)sizeof(long) *  2,				\
 	.ra_off		= (s32)sizeof(long) * -1,				\
 	.fp_off		= (s32)sizeof(long) * -2,				\
 	.use_fp		= true,
 
+#ifdef CONFIG_IA32_EMULATION
+
+#define ARCH_INIT_USER_COMPAT_FP_FRAME						\
+	.cfa_off	= (s32)sizeof(u32)  *  2,				\
+	.ra_off		= (s32)sizeof(u32)  * -1,				\
+	.fp_off		= (s32)sizeof(u32)  * -2,				\
+	.use_fp		= true,
+
+#define in_compat_mode(regs) !user_64bit_mode(regs)
+
+static inline void arch_unwind_user_init(struct unwind_user_state *state,
+					 struct pt_regs *regs)
+{
+	unsigned long cs_base, ss_base;
+
+	if (state->type != UNWIND_USER_TYPE_COMPAT_FP)
+		return;
+
+	scoped_guard(irqsave) {
+		cs_base = segment_base_address(regs->cs);
+		ss_base = segment_base_address(regs->ss);
+	}
+
+	state->arch.cs_base = cs_base;
+	state->arch.ss_base = ss_base;
+
+	state->ip += cs_base;
+	state->sp += ss_base;
+	state->fp += ss_base;
+}
+#define arch_unwind_user_init arch_unwind_user_init
+
+static inline void arch_unwind_user_next(struct unwind_user_state *state)
+{
+	if (state->type != UNWIND_USER_TYPE_COMPAT_FP)
+		return;
+
+	state->ip += state->arch.cs_base;
+	state->fp += state->arch.ss_base;
+}
+#define arch_unwind_user_next arch_unwind_user_next
+
+#endif /* CONFIG_IA32_EMULATION */
+
+#include <asm-generic/unwind_user.h>
+
 #endif /* _ASM_X86_UNWIND_USER_H */
diff --git a/arch/x86/include/asm/unwind_user_types.h b/arch/x86/include/asm/unwind_user_types.h
new file mode 100644
index 000000000000..d7074dc5f0ce
--- /dev/null
+++ b/arch/x86/include/asm/unwind_user_types.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_UNWIND_USER_TYPES_H
+#define _ASM_UNWIND_USER_TYPES_H
+
+#ifdef CONFIG_IA32_EMULATION
+
+struct arch_unwind_user_state {
+	unsigned long ss_base;
+	unsigned long cs_base;
+};
+#define arch_unwind_user_state arch_unwind_user_state
+
+#endif /* CONFIG_IA32_EMULATION */
+
+#include <asm-generic/unwind_user_types.h>
+
+#endif /* _ASM_UNWIND_USER_TYPES_H */
-- 
2.47.2




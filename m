Return-Path: <linux-kernel+bounces-893049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3DAC466C6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 932551890304
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EF930F55C;
	Mon, 10 Nov 2025 11:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NYDM4NAv"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DD421772A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775921; cv=none; b=ClS47pI0lnugQ1iQGBhCgT0bqcYupXI1wEu4AFHh5jEY+ZWkVR+hPsEZpZzsJDZ/+xxQx+Vexrjz3bt/E+nSimd2CyKwizpT9gZc6VU7mDUEqAVua19QjShQr4VbkEhajpEbWljyS8cPgOObNby2dR2Z9MNhCmY3a9TUZHdw/AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775921; c=relaxed/simple;
	bh=8CfEDA79lBcPx7H8WDnvleWLVndNz/te5099TGWHN+E=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Oo0I/zMPbU1Dc3r9j5vpPZZQT2GrzJriOopv8tV3xt3KXwrZUzIzwWe6XfnwjmqG7A6ipLQEBrNK6s+pJVbvwsEh6GK2Op+atsvfMe2oJiB4gDHzt/hUJACumGxk61/LfnxQyEJ2FuOYFXb5V0PgxNyWm0QZPKibcYy96nYJ7g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NYDM4NAv; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=gebqXZYQcid4lUxlN6M8ilOhWjiGcP2qN2BZztNPrlE=; b=NYDM4NAv+d5NFDK287Bxq/SqP5
	7oCmpho+K8OJHEP0toBHNsKLMqQVKkFUGlH3Pwg6Ps/+soszw7IYQlGpAlsehfVQdsv2Vzrqz/Bxi
	rgK5+or3uPjdaUwOZTJUoNONiBJGE6SSS/u9zXnB7W+0HuG7O5BPVnFix5ef6KPQg+zh/mbAqWK1J
	D2e6POxChOmGaBAQQB9r5+jxy+ZMH442rI/xGuC6pGgQRxrQdJX9AHdcUeLwo+zJai/c2Da8FwUy4
	EMYaad5b3DlCpdllw+f211dxlXWndzXWjuRn64cfaCFZEpw9JGdIIE+5jeU1wxhtKxWie8OH/CF67
	+xVMw6IA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIPfv-0000000AZel-3cDm;
	Mon, 10 Nov 2025 11:03:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 6DD26303061; Mon, 10 Nov 2025 12:58:33 +0100 (CET)
Message-ID: <20251110115758.456717741@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 10 Nov 2025 12:46:45 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 kees@kernel.org,
 acarmina@redhat.com,
 jpoimboe@kernel.org,
 mark.rutland@arm.com,
 torvalds@linuxfoundation.org,
 maciej.wieczor-retman@intel.com
Subject: [PATCH v2 12/12] x86_64/bug: Inline the UD1
References: <20251110114633.202485143@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

(Ab)use the static_call infrastructure to convert all:

  call __WARN_trap

instances into the desired:

  ud1 (%ecx), %rdi

eliminating the CALL/RET, but more importantly, fixing the
fact that all WARNs will have:

  RIP: 0010:__WARN_trap+0

Basically, by making it a static_call trampoline call, objtool will
collect the callsites, and then the inline rewrite will hit the
special case and replace the code with the magic instruction.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/bug.h    |    5 ++++-
 arch/x86/kernel/static_call.c |   13 +++++++++++--
 arch/x86/kernel/traps.c       |    4 ++++
 3 files changed, 19 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -137,9 +137,12 @@ do {									\
 #ifdef HAVE_ARCH_BUG_FORMAT_ARGS
 
 #ifndef __ASSEMBLY__
+#include <linux/static_call_types.h>
 struct bug_entry;
 extern void __WARN_trap(struct bug_entry *bug, ...);
 
+DECLARE_STATIC_CALL(WARN_trap, __WARN_trap);
+
 struct pt_regs;
 struct sysv_va_list { /* from AMD64 System V ABI */
 	unsigned int gp_offset;
@@ -171,7 +174,7 @@ extern void *__warn_args(struct arch_va_
 #define __WARN_print_arg(flags, format, arg...)				\
 do {									\
 	int __flags = (flags) | BUGFLAG_WARNING | BUGFLAG_ARGS ;	\
-	__WARN_trap(__WARN_bug_entry(__flags, format), ## arg);		\
+	static_call_mod(WARN_trap)(__WARN_bug_entry(__flags, format), ## arg); \
 	asm (""); /* inhibit tail-call optimization */			\
 } while (0)
 
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -26,6 +26,11 @@ static const u8 xor5rax[] = { 0x2e, 0x2e
 
 static const u8 retinsn[] = { RET_INSN_OPCODE, 0xcc, 0xcc, 0xcc, 0xcc };
 
+/*
+ * ud1    (%ecx),%rdi -- see __WARN_trap() / decode_bug()
+ */
+static const u8 warninsn[] = { 0x67, 0x48, 0x0f, 0xb9, 0x39 };
+
 static u8 __is_Jcc(u8 *insn) /* Jcc.d32 */
 {
 	u8 ret = 0;
@@ -69,7 +74,10 @@ static void __ref __static_call_transfor
 			emulate = code;
 			code = &xor5rax;
 		}
-
+		if (func == &__WARN_trap) {
+			emulate = code;
+			code = &warninsn;
+		}
 		break;
 
 	case NOP:
@@ -128,7 +136,8 @@ static void __static_call_validate(u8 *i
 	} else {
 		if (opcode == CALL_INSN_OPCODE ||
 		    !memcmp(insn, x86_nops[5], 5) ||
-		    !memcmp(insn, xor5rax, 5))
+		    !memcmp(insn, xor5rax, 5) ||
+		    !memcmp(insn, warninsn, 5))
 			return;
 	}
 
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -31,6 +31,7 @@
 #include <linux/kexec.h>
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
+#include <linux/static_call.h>
 #include <linux/timer.h>
 #include <linux/init.h>
 #include <linux/bug.h>
@@ -215,6 +216,9 @@ static inline unsigned long pt_regs_val(
 }
 
 #ifdef HAVE_ARCH_BUG_FORMAT_ARGS
+DEFINE_STATIC_CALL(WARN_trap, __WARN_trap);
+EXPORT_STATIC_CALL_TRAMP(WARN_trap);
+
 /*
  * Create a va_list from an exception context.
  */




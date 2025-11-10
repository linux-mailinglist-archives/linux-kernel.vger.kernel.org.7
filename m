Return-Path: <linux-kernel+bounces-893047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EF4C466BC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCF7F3BDB10
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEA130F538;
	Mon, 10 Nov 2025 11:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nbOQBLHU"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BA1309EFF
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775921; cv=none; b=ej76z7Snvujq17wX0paKa65R93PErsbvRcD6XAb/UmHfF0alU8HkQwij9ug0z+FfX5a5xFtnmRXvi6P7SEQ/sW94l8xO8n7vW9A2cOA0WsNh9XxioNh6dkLcbjmCW+v/yZpG6IV304qM+R3iIph8birbY3UYuyX4R7vQgGiigLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775921; c=relaxed/simple;
	bh=/JZxy1HGcM7cgpfx0YBlh4EuElgBFjdyunBC8J8MqeQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=WJ7lrIazBGl3GUjhvuNyTLTZnwzw8OdoMZ8UpH7L0dhyBtBSN9tlxQRv/Y5BpNmxD1L9nIbdh2jZ8F1cvzyqvszVhMQsXQfX0Pn+0WORIkbAS2+eBLUBNXOhK8+2exohQRCZtwJT7CEDP5XJ2I15doYK7sMk0Bzp7/PO23z3V9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nbOQBLHU; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=MRqwt0l5ljcBnQcjFs/lzNyhQMr3eZJJv7/K6l0LrOg=; b=nbOQBLHUfSEM2w8KoJCtA7jlOE
	59q9E5T3ec2q/MVasFGojZznLwjewhDnwwBEEVDuzIpU0OJzmprjwZYrfB3g4jnCAh9Bt50EwZTD2
	BOwpmrej9vlY0g/xdHleTezza6T9539DvPGtPlus4Bx6teji1ZHhdHlMyRBKGX3ktvENWsfyazy6m
	fnR4p24/8laS7od0UbcPYMKsG18vSBFWokwb1PQPktbh/CfuMUIrcQ3qXX/g31Ovk77JOmQW8tWsU
	+Gr4mbLyy94UKVZAQ8GRaX/lo1959z7vK4M+V/dvyU0FsSg7LJ5ioM0o2FO9NQDev1n+DhJvUWtwf
	WSHbBfcg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIPfv-0000000AZek-3Nq2;
	Mon, 10 Nov 2025 11:03:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 64D1A30303E; Mon, 10 Nov 2025 12:58:33 +0100 (CET)
Message-ID: <20251110115758.213813530@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 10 Nov 2025 12:46:43 +0100
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
Subject: [PATCH v2 10/12] x86_64/bug: Implement __WARN_printf()
References: <20251110114633.202485143@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

The basic idea is to have __WARN_printf() be a vararg function such
that the compiler can do the optimal calling convention for us. This
function body will be a #UD and then set up a va_list in the exception
from pt_regs.

But because the trap will be in a called function, the bug_entry must
be passed in. Have that be the first argument, with the format tucked
away inside the bug_entry.

The comments should clarify the real fun details.

The big downside is that all WARNs will now show:

 RIP: 0010:__WARN_trap:+0

One possible solution is to simply discard the top frame when
unwinding. A follow up patch takes care of this slightly differently
by abusing the x86 static_call implementation.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry.S     |    8 +++
 arch/x86/include/asm/bug.h |   60 +++++++++++++++++++++--
 arch/x86/kernel/traps.c    |  115 ++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 168 insertions(+), 15 deletions(-)

--- a/arch/x86/entry/entry.S
+++ b/arch/x86/entry/entry.S
@@ -32,6 +32,14 @@ SYM_FUNC_END(write_ibpb)
 /* For KVM */
 EXPORT_SYMBOL_GPL(write_ibpb);
 
+SYM_FUNC_START(__WARN_trap)
+	ANNOTATE_NOENDBR
+	ANNOTATE_REACHABLE
+	ud1 (%ecx), %_ASM_ARG1
+	RET
+SYM_FUNC_END(__WARN_trap)
+EXPORT_SYMBOL(__WARN_trap)
+
 .popsection
 
 /*
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -31,6 +31,7 @@
 #define BUG_UD2			0xfffe
 #define BUG_UD1			0xfffd
 #define BUG_UD1_UBSAN		0xfffc
+#define BUG_UD1_WARN		0xfffb
 #define BUG_UDB			0xffd6
 #define BUG_LOCK		0xfff0
 
@@ -58,14 +59,17 @@
 #define __BUG_ENTRY_FORMAT(format)
 #endif
 
+#ifdef CONFIG_X86_64
+#define HAVE_ARCH_BUG_FORMAT_ARGS
+#endif
+
 #define __BUG_ENTRY(format, file, line, flags)				\
 	__BUG_REL("1b")		"\t# bug_entry::bug_addr\n"		\
 	__BUG_ENTRY_FORMAT(format)					\
 	__BUG_ENTRY_VERBOSE(file, line)					\
 	"\t.word " flags	"\t# bug_entry::flags\n"
 
-#define _BUG_FLAGS_ASM(ins, format, file, line, flags, size, extra)	\
-	"1:\t" ins "\n"							\
+#define _BUG_FLAGS_ASM(format, file, line, flags, size, extra)		\
 	".pushsection __bug_table,\"aw\"\n\t"				\
 	ANNOTATE_DATA_SPECIAL						\
 	"2:\n\t"							\
@@ -82,7 +86,8 @@
 
 #define _BUG_FLAGS(cond_str, ins, flags, extra)				\
 do {									\
-	asm_inline volatile(_BUG_FLAGS_ASM(ins, "%c[fmt]", "%c[file]",	\
+	asm_inline volatile("1:\t" ins "\n"				\
+			    _BUG_FLAGS_ASM("%c[fmt]", "%c[file]",	\
 					   "%c[line]", "%c[fl]",	\
 					   "%c[size]", extra)		\
 		   : : [fmt] "i" (WARN_CONDITION_STR(cond_str)),	\
@@ -93,7 +98,8 @@ do {									\
 } while (0)
 
 #define ARCH_WARN_ASM(file, line, flags, size)				\
-	_BUG_FLAGS_ASM(ASM_UD2, "NULL", file, line, flags, size, "")
+	"1:\t " ASM_UD2 "\n"						\
+	_BUG_FLAGS_ASM("NULL", file, line, flags, size, "")
 
 #else
 
@@ -126,6 +132,52 @@ do {									\
 	instrumentation_end();						\
 } while (0)
 
+#ifdef HAVE_ARCH_BUG_FORMAT_ARGS
+
+#ifndef __ASSEMBLY__
+struct bug_entry;
+extern void __WARN_trap(struct bug_entry *bug, ...);
+
+struct pt_regs;
+struct sysv_va_list { /* from AMD64 System V ABI */
+	unsigned int gp_offset;
+	unsigned int fp_offset;
+	void *overflow_arg_area;
+	void *reg_save_area;
+};
+struct arch_va_list {
+	unsigned long regs[6];
+	struct sysv_va_list args;
+};
+extern void *__warn_args(struct arch_va_list *args, struct pt_regs *regs);
+#endif /* __ASSEMBLY__ */
+
+#define __WARN_bug_entry(flags, format) ({				\
+	struct bug_entry *bug;						\
+	asm_inline volatile("lea (2f)(%%rip), %[addr]\n1:\n"		\
+			    _BUG_FLAGS_ASM("%c[fmt]", "%c[file]",	\
+					   "%c[line]", "%c[fl]",	\
+					   "%c[size]", "")		\
+		   : [addr] "=r" (bug)					\
+		   : [fmt] "i" (format),				\
+		     [file] "i" (__FILE__),				\
+		     [line] "i" (__LINE__),				\
+		     [fl] "i" (flags),					\
+		     [size] "i" (sizeof(struct bug_entry)));		\
+	bug; })
+
+#define __WARN_print_arg(flags, format, arg...)				\
+do {									\
+	int __flags = (flags) | BUGFLAG_WARNING | BUGFLAG_ARGS ;	\
+	__WARN_trap(__WARN_bug_entry(__flags, format), ## arg);		\
+	asm (""); /* inhibit tail-call optimization */			\
+} while (0)
+
+#define __WARN_printf(taint, fmt, arg...) \
+	__WARN_print_arg(BUGFLAG_TAINT(taint), fmt, ## arg)
+
+#endif /* HAVE_ARCH_BUG_FORMAT_ARGS */
+
 #include <asm-generic/bug.h>
 
 #endif /* _ASM_X86_BUG_H */
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -102,25 +102,37 @@ __always_inline int is_valid_bugaddr(uns
  * UBSan{0}:     67 0f b9 00             ud1    (%eax),%eax
  * UBSan{10}:    67 0f b9 40 10          ud1    0x10(%eax),%eax
  * static_call:  0f b9 cc                ud1    %esp,%ecx
+ * __WARN_trap:  67 48 0f b9 39          ud1    (%ecx),%reg
  *
- * Notably UBSAN uses EAX, static_call uses ECX.
+ * Notable, since __WARN_trap can use all registers, the distinction between
+ * UD1 users is through R/M.
  */
 __always_inline int decode_bug(unsigned long addr, s32 *imm, int *len)
 {
 	unsigned long start = addr;
+	u8 v, reg, rm, rex = 0;
+	int type = BUG_UD1;
 	bool lock = false;
-	u8 v;
 
 	if (addr < TASK_SIZE_MAX)
 		return BUG_NONE;
 
-	v = *(u8 *)(addr++);
-	if (v == INSN_ASOP)
+	for (;;) {
 		v = *(u8 *)(addr++);
+		if (v == INSN_ASOP)
+			continue;
 
-	if (v == INSN_LOCK) {
-		lock = true;
-		v = *(u8 *)(addr++);
+		if (v == INSN_LOCK) {
+			lock = true;
+			continue;
+		}
+
+		if ((v & 0xf0) == 0x40) {
+			rex = v;
+			continue;
+		}
+
+		break;
 	}
 
 	switch (v) {
@@ -156,18 +168,33 @@ __always_inline int decode_bug(unsigned
 	if (X86_MODRM_MOD(v) != 3 && X86_MODRM_RM(v) == 4)
 		addr++;			/* SIB */
 
+	reg = X86_MODRM_REG(v) + 8*!!X86_REX_R(rex);
+	rm  = X86_MODRM_RM(v)  + 8*!!X86_REX_B(rex);
+
 	/* Decode immediate, if present */
 	switch (X86_MODRM_MOD(v)) {
 	case 0: if (X86_MODRM_RM(v) == 5)
-			addr += 4; /* RIP + disp32 */
+			addr += 4;	/* RIP + disp32 */
+
+		if (rm == 0)		/* (%eax) */
+			type = BUG_UD1_UBSAN;
+
+		if (rm == 1) {		/* (%ecx) */
+			*imm = reg;
+			type = BUG_UD1_WARN;
+		}
 		break;
 
 	case 1: *imm = *(s8 *)addr;
 		addr += 1;
+		if (rm == 0)		/* (%eax) */
+			type = BUG_UD1_UBSAN;
 		break;
 
 	case 2: *imm = *(s32 *)addr;
 		addr += 4;
+		if (rm == 0)		/* (%eax) */
+			type = BUG_UD1_UBSAN;
 		break;
 
 	case 3: break;
@@ -176,12 +203,73 @@ __always_inline int decode_bug(unsigned
 	/* record instruction length */
 	*len = addr - start;
 
-	if (X86_MODRM_REG(v) == 0)	/* EAX */
-		return BUG_UD1_UBSAN;
+	return type;
+}
 
-	return BUG_UD1;
+static inline unsigned long pt_regs_val(struct pt_regs *regs, int nr)
+{
+	int offset = pt_regs_offset(regs, nr);
+	if (WARN_ON_ONCE(offset < -0))
+		return 0;
+	return *((unsigned long *)((void *)regs + offset));
 }
 
+#ifdef HAVE_ARCH_BUG_FORMAT_ARGS
+/*
+ * Create a va_list from an exception context.
+ */
+void *__warn_args(struct arch_va_list *args, struct pt_regs *regs)
+{
+	/*
+	 * Register save area; populate with function call argument registers
+	 */
+	args->regs[0] = regs->di;
+	args->regs[1] = regs->si;
+	args->regs[2] = regs->dx;
+	args->regs[3] = regs->cx;
+	args->regs[4] = regs->r8;
+	args->regs[5] = regs->r9;
+
+	/*
+	 * From the ABI document:
+	 *
+	 * @gp_offset - the element holds the offset in bytes from
+	 * reg_save_area to the place where the next available general purpose
+	 * argument register is saved. In case all argument registers have
+	 * been exhausted, it is set to the value 48 (6*8).
+	 *
+	 * @fp_offset - the element holds the offset in bytes from
+	 * reg_save_area to the place where the next available floating point
+	 * argument is saved. In case all argument registers have been
+	 * exhausted, it is set to the value 176 (6*8 + 8*16)
+	 *
+	 * @overflow_arg_area - this pointer is used to fetch arguments passed
+	 * on the stack. It is initialized with the address of the first
+	 * argument passed on the stack, if any, and then always updated to
+	 * point to the start of the next argument on the stack.
+	 *
+	 * @reg_save_area - the element points to the start of the register
+	 * save area.
+	 *
+	 * Notably the vararg starts with the second argument and there are no
+	 * floating point arguments in the kernel.
+	 */
+	args->args.gp_offset = 1*8;
+	args->args.fp_offset = 6*8 + 8*16;
+	args->args.reg_save_area = &args->regs;
+	args->args.overflow_arg_area = (void *)regs->sp;
+
+	/*
+	 * If the exception came from __WARN_trap, there is a return
+	 * address on the stack, skip that. This is why any __WARN_trap()
+	 * caller must inhibit tail-call optimization.
+	 */
+	if ((void *)regs->ip == &__WARN_trap)
+		args->args.overflow_arg_area += 8;
+
+	return &args->args;
+}
+#endif /* HAVE_ARCH_BUG_FORMAT */
 
 static nokprobe_inline int
 do_trap_no_signal(struct task_struct *tsk, int trapnr, const char *str,
@@ -334,6 +422,11 @@ static noinstr bool handle_bug(struct pt
 		raw_local_irq_enable();
 
 	switch (ud_type) {
+	case BUG_UD1_WARN:
+		if (report_bug_entry((void *)pt_regs_val(regs, ud_imm), regs) == BUG_TRAP_TYPE_WARN)
+			handled = true;
+		break;
+
 	case BUG_UD2:
 		if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN) {
 			handled = true;




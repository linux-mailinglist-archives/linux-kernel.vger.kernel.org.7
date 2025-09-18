Return-Path: <linux-kernel+bounces-795213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C0DB3EE56
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 21:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73E342077B2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 19:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E16931A053;
	Mon,  1 Sep 2025 19:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ebpKc7fI"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03930244694
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 19:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756753995; cv=none; b=pl/SP22cHsboX5rqvCm9HJliCEnTwCoX8GsC4/SlYwLkMX25cT7F85TE5bD9EatiGrjOP7adwu629GXU7EUKevvd2CZM2qJ5/nDEW1YFL75xwM0U5ojpy2SK1osp/5QIz4u/xADmrdXQTcP3EQTzFndDTaVfi6eA5Xu4dK7YYSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756753995; c=relaxed/simple;
	bh=7ZPsW/uWi51wBoJ1uGOrc3szcfmVDh8lCFB8Q+YkGng=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jRf41jpaeXVmG+6usk4rnN1QqGGc9iLfOmdTes+0GLxsnDr5+j0CoQJYBOtIyR7PPkfalwyh01V+5o1uwFmpAYcmVX90xlAvtRwbgAbl+4BZOIs+LmbOd1foGENzba817lI1ObGnJKkcumGfk9dAc15bMj7m2bhuh99oPttxxuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ebpKc7fI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=yaQw4XtlO2l344Y2NMDQkIpGIzRV8RGkxYyCSPLap4Y=; b=ebpKc7fIKZemWZXpTCTw9pNpEz
	w0HHO9bwRZwTUIIk+S9ls4J/V1rwa/CRzzMkEr4+ECui+vGP3W0qsebV1CC/1DTWvqtRjP48OAtle
	jpzGoJgU2vchi3nqOHzntOoderUUqe8x8bKyP7iomVsrmQBiMfSWG2j7ubVfzfq1h/yMEpWG6axWw
	rysOu18fxrIKXiQdepUUIm5tdTdkZSEwt6V1M2ybwxQofmamfeHbz+vUYOJhUQss0p0PaBOWQRG8v
	SCLVYSKmjSROfUgL5k+OozluDc0kk2otAa0f8MBe8ZoOKzyuEWrTNhFo/rJf2j8scG5B2ekfwCJvv
	rY81Kcjw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ut9xj-0000000CQ17-3rtj;
	Mon, 01 Sep 2025 19:13:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5978C300342; Mon, 01 Sep 2025 21:13:07 +0200 (CEST)
Date: Mon, 1 Sep 2025 21:13:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc: kees@kernel.org, alyssa.milburn@intel.com, scott.d.constable@intel.com,
	joao@overdrivepizza.com, andrew.cooper3@citrix.com,
	samitolvanen@google.com, nathan@kernel.org,
	alexei.starovoitov@gmail.com, mhiramat@kernel.org, ojeda@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] x86,ibt: Use UDB instead of 0xEA
Message-ID: <20250901191307.GI4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


A while ago [0] FineIBT started using the 0xEA instruction to raise #UD.
All existing parts will generate #UD in 64bit mode on that instruction.

However; Intel/AMD have not blessed using this instruction, it is on
their 'reserved' opcode list for future use.

Peter Anvin worked the committees and got use of 0xD6 blessed, it
shall be called UDB (per the next SDM or so), and it being a single
byte instruction is easy to slip into a single byte immediate -- as
is done by this very patch.

Reworking the FineIBT code to use UDB wasn't entirely trivial. Notably
the FineIBT-BHI1 case ran out of bytes. In order to condense the
encoding some it was required to move the hash register from R10D to
EAX (thanks hpa!).

Per the x86_64 ABI, RAX is used to pass the number of vector registers
for vararg function calls -- something that should not happen in the
kernel. More so, the kernel is built with -mskip-rax-setup, which
should leave RAX completely unused, allowing its re-use.

Of note:

 - The ENDBR poison value is changed to: 0f 1f 40 d6 - nopl -42(%rax)
   which is a (distinct) valid 4 byte NOP and provides the UDB for the
   preamble.

 - The branches carry a not-taken hint where possible; additionally
   modern cores seem to prefer fall-through / not-taken - per Agner Fog.

 - For BPF; while the bpf2bpf tail-call uses RAX in its calling
   convention, that does not use CFI and is unaffected. Only the
   'regular' C->BPF transition is covered by CFI.

[0] 06926c6cdb95 ("x86/ibt: Optimize the FineIBT instruction sequence")

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---

Changes since RFC:
 - more comment updates
 - move UDB into NOP4 immediate for ENDBR poison
 - simplified reporting/recovery code
 - replaced a nop by using jcc.32
 - more actual testing


 arch/x86/include/asm/bug.h    |    9 +
 arch/x86/include/asm/cfi.h    |   14 +-
 arch/x86/include/asm/ibt.h    |   10 -
 arch/x86/kernel/alternative.c |  217 ++++++++++++++++++++++++------------------
 arch/x86/kernel/traps.c       |    8 -
 arch/x86/lib/bhi.S            |   58 +++++------
 arch/x86/lib/retpoline.S      |    4 
 arch/x86/net/bpf_jit_comp.c   |    6 -
 8 files changed, 178 insertions(+), 148 deletions(-)

--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -5,14 +5,19 @@
 #include <linux/stringify.h>
 #include <linux/instrumentation.h>
 #include <linux/objtool.h>
+#include <asm/asm.h>
 
 /*
  * Despite that some emulators terminate on UD2, we use it for WARN().
  */
-#define ASM_UD2		".byte 0x0f, 0x0b"
+#define ASM_UD2		_ASM_BYTES(0x0f, 0x0b)
 #define INSN_UD2	0x0b0f
 #define LEN_UD2		2
 
+#define ASM_UDB		_ASM_BYTES(0xd6)
+#define INSN_UDB	0xd6
+#define LEN_UDB		1
+
 /*
  * In clang we have UD1s reporting UBSAN failures on X86, 64 and 32bit.
  */
@@ -26,7 +31,7 @@
 #define BUG_UD2			0xfffe
 #define BUG_UD1			0xfffd
 #define BUG_UD1_UBSAN		0xfffc
-#define BUG_EA			0xffea
+#define BUG_UDB			0xffd6
 #define BUG_LOCK		0xfff0
 
 #ifdef CONFIG_GENERIC_BUG
--- a/arch/x86/include/asm/cfi.h
+++ b/arch/x86/include/asm/cfi.h
@@ -71,12 +71,10 @@
  *
  * __cfi_foo:
  *   endbr64
- *   subl 0x12345678, %r10d
- *   jz   foo
- *   ud2
- *   nop
+ *   subl 0x12345678, %eax
+ *   jne.32,pn foo+3
  * foo:
- *   osp nop3			# was endbr64
+ *   nopl -42(%rax)		# was endbr64
  *   ... code here ...
  *   ret
  *
@@ -86,9 +84,9 @@
  * indirect caller:
  *   lea foo(%rip), %r11
  *   ...
- *   movl $0x12345678, %r10d
- *   subl $16, %r11
- *   nop4
+ *   movl $0x12345678, %eax
+ *   lea  -0x10(%r11), %r11
+ *   nop5
  *   call *%r11
  *
  */
--- a/arch/x86/include/asm/ibt.h
+++ b/arch/x86/include/asm/ibt.h
@@ -59,10 +59,10 @@ static __always_inline __attribute_const
 static __always_inline __attribute_const__ u32 gen_endbr_poison(void)
 {
 	/*
-	 * 4 byte NOP that isn't NOP4 (in fact it is OSP NOP3), such that it
-	 * will be unique to (former) ENDBR sites.
+	 * 4 byte NOP that isn't NOP4, such that it will be unique to (former)
+	 * ENDBR sites. Additionally it carries UDB as immediate.
 	 */
-	return 0x001f0f66; /* osp nopl (%rax) */
+	return 0xd6401f0f; /* nopl -42(%rax) */
 }
 
 static inline bool __is_endbr(u32 val)
@@ -70,10 +70,6 @@ static inline bool __is_endbr(u32 val)
 	if (val == gen_endbr_poison())
 		return true;
 
-	/* See cfi_fineibt_bhi_preamble() */
-	if (IS_ENABLED(CONFIG_FINEIBT_BHI) && val == 0x001f0ff5)
-		return true;
-
 	val &= ~0x01000000U; /* ENDBR32 -> ENDBR64 */
 	return val == gen_endbr();
 }
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -147,10 +147,10 @@ static void *its_init_thunk(void *thunk,
 		/*
 		 * When ITS uses indirect branch thunk the fineibt_paranoid
 		 * caller sequence doesn't fit in the caller site. So put the
-		 * remaining part of the sequence (<ea> + JNE) into the ITS
+		 * remaining part of the sequence (UDB + JNE) into the ITS
 		 * thunk.
 		 */
-		bytes[i++] = 0xea; /* invalid instruction */
+		bytes[i++] = 0xd6; /* UDB */
 		bytes[i++] = 0x75; /* JNE */
 		bytes[i++] = 0xfd;
 
@@ -163,7 +163,7 @@ static void *its_init_thunk(void *thunk,
 		reg -= 8;
 	}
 	bytes[i++] = 0xff;
-	bytes[i++] = 0xe0 + reg; /* jmp *reg */
+	bytes[i++] = 0xe0 + reg; /* JMP *reg */
 	bytes[i++] = 0xcc;
 
 	return thunk + offset;
@@ -970,7 +970,7 @@ void __init_or_module noinline apply_ret
 		case JMP32_INSN_OPCODE:
 			/* Check for cfi_paranoid + ITS */
 			dest = addr + insn.length + insn.immediate.value;
-			if (dest[-1] == 0xea && (dest[0] & 0xf0) == 0x70) {
+			if (dest[-1] == 0xd6 && (dest[0] & 0xf0) == 0x70) {
 				WARN_ON_ONCE(cfi_mode != CFI_FINEIBT);
 				continue;
 			}
@@ -1300,9 +1300,8 @@ early_param("cfi", cfi_parse_cmdline);
  *
  * __cfi_\func:					__cfi_\func:
  *	movl   $0x12345678,%eax		// 5	     endbr64			// 4
- *	nop					     subl   $0x12345678,%r10d   // 7
- *	nop					     jne    __cfi_\func+6	// 2
- *	nop					     nop3			// 3
+ *	nop					     subl   $0x12345678,%eax    // 5
+ *	nop					     jne.d32,pn \func+3		// 7
  *	nop
  *	nop
  *	nop
@@ -1311,34 +1310,45 @@ early_param("cfi", cfi_parse_cmdline);
  *	nop
  *	nop
  *	nop
+ *	nop
+ * \func:					\func:
+ *	endbr64					     nopl -42(%rax)
  *
  *
  * caller:					caller:
- *	movl	$(-0x12345678),%r10d	 // 6	     movl   $0x12345678,%r10d	// 6
+ *	movl	$(-0x12345678),%r10d	 // 6	     movl   $0x12345678,%eax	// 5
  *	addl	$-15(%r11),%r10d	 // 4	     lea    -0x10(%r11),%r11	// 4
- *	je	1f			 // 2	     nop4			// 4
+ *	je	1f			 // 2	     nop5			// 5
  *	ud2				 // 2
  * 1:	cs call	__x86_indirect_thunk_r11 // 6	     call   *%r11; nop3;	// 6
  *
+ *
+ * Notably, the FineIBT sequences are crafted such that branches are presumed
+ * non-taken. This is based on Agner Fog's optimization manual, which states:
+ *
+ *  "Make conditional jumps most often not taken: The efficiency and throughput
+ *   for not-taken branches is better than for taken branches on most
+ *   processors. Therefore, it is good to place the most frequent branch first"
  */
 
 /*
  * <fineibt_preamble_start>:
  *  0:   f3 0f 1e fa             endbr64
- *  4:   41 81 <ea> 78 56 34 12  sub    $0x12345678, %r10d
- *  b:   75 f9                   jne    6 <fineibt_preamble_start+0x6>
- *  d:   0f 1f 00                nopl   (%rax)
+ *  4:   2d 78 56 34 12          sub    $0x12345678, %eax
+ *  9:   2e 0f 85 03 00 00 00    jne,pn 13 <fineibt_preamble_start+0x13>
+ * 10:   0f 1f 40 d6             nopl   -0x2a(%rax)
  *
- * Note that the JNE target is the 0xEA byte inside the SUB, this decodes as
- * (bad) on x86_64 and raises #UD.
+ * Note that the JNE target is the 0xD6 byte inside the NOPL, this decodes as
+ * UDB on x86_64 and raises #UD.
  */
 asm(	".pushsection .rodata				\n"
 	"fineibt_preamble_start:			\n"
 	"	endbr64					\n"
-	"	subl	$0x12345678, %r10d		\n"
+	"	subl	$0x12345678, %eax		\n"
 	"fineibt_preamble_bhi:				\n"
-	"	jne	fineibt_preamble_start+6	\n"
-	ASM_NOP3
+	"	cs jne.d32 fineibt_preamble_start+0x13	\n"
+	"#fineibt_func:					\n"
+	"	nopl	-42(%rax)			\n"
 	"fineibt_preamble_end:				\n"
 	".popsection\n"
 );
@@ -1349,20 +1359,20 @@ extern u8 fineibt_preamble_end[];
 
 #define fineibt_preamble_size (fineibt_preamble_end - fineibt_preamble_start)
 #define fineibt_preamble_bhi  (fineibt_preamble_bhi - fineibt_preamble_start)
-#define fineibt_preamble_ud   6
-#define fineibt_preamble_hash 7
+#define fineibt_preamble_ud   0x13
+#define fineibt_preamble_hash 5
 
 /*
  * <fineibt_caller_start>:
- *  0:   41 ba 78 56 34 12       mov    $0x12345678, %r10d
- *  6:   4d 8d 5b f0             lea    -0x10(%r11), %r11
- *  a:   0f 1f 40 00             nopl   0x0(%rax)
+ *  0:   b8 78 56 34 12          mov    $0x12345678, %eax
+ *  5:   4d 8d 5b f0             lea    -0x10(%r11), %r11
+ *  9:   0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
  */
 asm(	".pushsection .rodata			\n"
 	"fineibt_caller_start:			\n"
-	"	movl	$0x12345678, %r10d	\n"
+	"	movl	$0x12345678, %eax	\n"
 	"	lea	-0x10(%r11), %r11	\n"
-	ASM_NOP4
+	ASM_NOP5
 	"fineibt_caller_end:			\n"
 	".popsection				\n"
 );
@@ -1371,7 +1381,7 @@ extern u8 fineibt_caller_start[];
 extern u8 fineibt_caller_end[];
 
 #define fineibt_caller_size (fineibt_caller_end - fineibt_caller_start)
-#define fineibt_caller_hash 2
+#define fineibt_caller_hash 1
 
 #define fineibt_caller_jmp (fineibt_caller_size - 2)
 
@@ -1388,9 +1398,9 @@ extern u8 fineibt_caller_end[];
  * of adding a load.
  *
  * <fineibt_paranoid_start>:
- *  0:   41 ba 78 56 34 12       mov    $0x12345678, %r10d
- *  6:   45 3b 53 f7             cmp    -0x9(%r11), %r10d
- *  a:   4d 8d 5b <f0>           lea    -0x10(%r11), %r11
+ *  0:   b8 78 56 34 12          mov    $0x12345678, %eax
+ *  5:   41 3b 43 f5             cmp    -0x11(%r11), %eax
+ *  9:   2e 4d 8d 5b <f0>        cs lea -0x10(%r11), %r11
  *  e:   75 fd                   jne    d <fineibt_paranoid_start+0xd>
  * 10:   41 ff d3                call   *%r11
  * 13:   90                      nop
@@ -1402,9 +1412,10 @@ extern u8 fineibt_caller_end[];
  */
 asm(	".pushsection .rodata				\n"
 	"fineibt_paranoid_start:			\n"
-	"	movl	$0x12345678, %r10d		\n"
-	"	cmpl	-9(%r11), %r10d			\n"
-	"	lea	-0x10(%r11), %r11		\n"
+	"	mov	$0x12345678, %eax		\n"
+	"	cmpl	-11(%r11), %eax			\n"
+	"	cs lea	-0x10(%r11), %r11		\n"
+	"#fineibt_caller_size:                          \n"
 	"	jne	fineibt_paranoid_start+0xd	\n"
 	"fineibt_paranoid_ind:				\n"
 	"	call	*%r11				\n"
@@ -1520,51 +1531,67 @@ static int cfi_rand_preamble(s32 *start,
 	return 0;
 }
 
+/*
+ * Inline the bhi-arity 1 case:
+ *
+ * __cfi_foo:
+ *  0: f3 0f 1e fa             endbr64
+ *  4: 2d 78 56 34 12          sub    $0x12345678, %eax
+ *  9: 49 0f 45 fa             cmovne %rax, %rdi
+ *  d: 2e 75 03                jne,pn    foo+0x3
+ *
+ * foo:
+ * 10: 0f 1f 40 <d6>           nopl -42(%rax)
+ *
+ * Notably, this scheme is incompatible with permissive CFI
+ * because the CMOVcc is unconditional and RDI will have been
+ * clobbered.
+ */
+asm(	".pushsection .rodata				\n"
+	"fineibt_bhi1_start:				\n"
+	"	cmovne %rax, %rdi			\n"
+	"	cs jne fineibt_bhi1_func + 0x3		\n"
+	"fineibt_bhi1_func:				\n"
+	"	nopl -42(%rax)				\n"
+	"fineibt_bhi1_end:				\n"
+	".popsection					\n"
+);
+
+extern u8 fineibt_bhi1_start[];
+extern u8 fineibt_bhi1_end[];
+
+#define fineibt_bhi1_size (fineibt_bhi1_end - fineibt_bhi1_start)
+
 static void cfi_fineibt_bhi_preamble(void *addr, int arity)
 {
+	u8 bytes[MAX_INSN_SIZE];
+
 	if (!arity)
 		return;
 
 	if (!cfi_warn && arity == 1) {
-		/*
-		 * Crazy scheme to allow arity-1 inline:
-		 *
-		 * __cfi_foo:
-		 *  0: f3 0f 1e fa             endbr64
-		 *  4: 41 81 <ea> 78 56 34 12  sub     0x12345678, %r10d
-		 *  b: 49 0f 45 fa             cmovne  %r10, %rdi
-		 *  f: 75 f5                   jne     __cfi_foo+6
-		 * 11: 0f 1f 00                nopl    (%rax)
-		 *
-		 * Code that direct calls to foo()+0, decodes the tail end as:
-		 *
-		 * foo:
-		 *  0: f5                      cmc
-		 *  1: 0f 1f 00                nopl    (%rax)
-		 *
-		 * which clobbers CF, but does not affect anything ABI
-		 * wise.
-		 *
-		 * Notably, this scheme is incompatible with permissive CFI
-		 * because the CMOVcc is unconditional and RDI will have been
-		 * clobbered.
-		 */
-		const u8 magic[9] = {
-			0x49, 0x0f, 0x45, 0xfa,
-			0x75, 0xf5,
-			BYTES_NOP3,
-		};
-
-		text_poke_early(addr + fineibt_preamble_bhi, magic, 9);
-
+		text_poke_early(addr + fineibt_preamble_bhi,
+				fineibt_bhi1_start, fineibt_bhi1_size);
 		return;
 	}
 
-	text_poke_early(addr + fineibt_preamble_bhi,
-			text_gen_insn(CALL_INSN_OPCODE,
-				      addr + fineibt_preamble_bhi,
-				      __bhi_args[arity]),
-			CALL_INSN_SIZE);
+	/*
+	 * Replace the bytes at fineibt_preamble_bhi with a CALL instruction
+	 * that lines up exactly with the end of the preamble, such that the
+	 * return address will be foo+0.
+	 *
+	 * __cfi_foo:
+	 *  0: f3 0f 1e fa             endbr64
+	 *  4: 2d 78 56 34 12          sub    $0x12345678, %eax
+	 *  9: 2e 2e e8 DD DD DD DD    cs cs call __bhi_args[arity]
+	 */
+	bytes[0] = 0x2e;
+	bytes[1] = 0x2e;
+	__text_gen_insn(bytes + 2, CALL_INSN_OPCODE,
+			addr + fineibt_preamble_bhi + 2,
+			__bhi_args[arity], CALL_INSN_SIZE);
+
+	text_poke_early(addr + fineibt_preamble_bhi, bytes, 7);
 }
 
 static int cfi_rewrite_preamble(s32 *start, s32 *end)
@@ -1655,8 +1682,6 @@ static int cfi_rewrite_callers(s32 *star
 {
 	s32 *s;
 
-	BUG_ON(fineibt_paranoid_size != 20);
-
 	for (s = start; s < end; s++) {
 		void *addr = (void *)s + *s;
 		struct insn insn;
@@ -1707,13 +1732,18 @@ static int cfi_rewrite_callers(s32 *star
 	return 0;
 }
 
+#define FINEIBT_WARN(_f, _v) \
+	WARN_ONCE((_f) != (_v), "FineIBT: " #_f " %ld != %d\n", _f, _v)
+
 static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
 			    s32 *start_cfi, s32 *end_cfi, bool builtin)
 {
 	int ret;
 
-	if (WARN_ONCE(fineibt_preamble_size != 16,
-		      "FineIBT preamble wrong size: %ld", fineibt_preamble_size))
+	if (FINEIBT_WARN(fineibt_preamble_size, 20)			||
+	    FINEIBT_WARN(fineibt_preamble_bhi + fineibt_bhi1_size, 20)	||
+	    FINEIBT_WARN(fineibt_caller_size, 14)			||
+	    FINEIBT_WARN(fineibt_paranoid_size, 20))
 		return;
 
 	if (cfi_mode == CFI_AUTO) {
@@ -1823,11 +1853,11 @@ static void poison_cfi(void *addr)
 
 		/*
 		 * __cfi_\func:
-		 *	osp nopl (%rax)
-		 *	subl	$0, %r10d
-		 *	jz	1f
-		 *	ud2
-		 * 1:	nop
+		 *	nopl	-42(%rax)
+		 *	sub	$0, %eax
+		 *	jne	\func+3
+		 * \func:
+		 *	nopl	-42(%rax)
 		 */
 		poison_endbr(addr);
 		poison_hash(addr + fineibt_preamble_hash);
@@ -1853,12 +1883,14 @@ static void poison_cfi(void *addr)
 	}
 }
 
+#define fineibt_prefix_size (fineibt_preamble_size - ENDBR_INSN_SIZE)
+
 /*
- * When regs->ip points to a 0xEA byte in the FineIBT preamble,
+ * When regs->ip points to a 0xD6 byte in the FineIBT preamble,
  * return true and fill out target and type.
  *
  * We check the preamble by checking for the ENDBR instruction relative to the
- * 0xEA instruction.
+ * UDB instruction.
  */
 static bool decode_fineibt_preamble(struct pt_regs *regs, unsigned long *target, u32 *type)
 {
@@ -1868,10 +1900,10 @@ static bool decode_fineibt_preamble(stru
 	if (!exact_endbr((void *)addr))
 		return false;
 
-	*target = addr + fineibt_preamble_size;
+	*target = addr + fineibt_prefix_size;
 
 	__get_kernel_nofault(&hash, addr + fineibt_preamble_hash, u32, Efault);
-	*type = (u32)regs->r10 + hash;
+	*type = (u32)regs->ax + hash;
 
 	/*
 	 * Since regs->ip points to the middle of an instruction; it cannot
@@ -1909,12 +1941,12 @@ static bool decode_fineibt_bhi(struct pt
 	__get_kernel_nofault(&addr, regs->sp, unsigned long, Efault);
 	*target = addr;
 
-	addr -= fineibt_preamble_size;
+	addr -= fineibt_prefix_size;
 	if (!exact_endbr((void *)addr))
 		return false;
 
 	__get_kernel_nofault(&hash, addr + fineibt_preamble_hash, u32, Efault);
-	*type = (u32)regs->r10 + hash;
+	*type = (u32)regs->ax + hash;
 
 	/*
 	 * The UD2 sites are constructed with a RET immediately following,
@@ -1931,7 +1963,7 @@ static bool is_paranoid_thunk(unsigned l
 	u32 thunk;
 
 	__get_kernel_nofault(&thunk, (u32 *)addr, u32, Efault);
-	return (thunk & 0x00FFFFFF) == 0xfd75ea;
+	return (thunk & 0x00FFFFFF) == 0xfd75d6;
 
 Efault:
 	return false;
@@ -1939,8 +1971,7 @@ static bool is_paranoid_thunk(unsigned l
 
 /*
  * regs->ip points to a LOCK Jcc.d8 instruction from the fineibt_paranoid_start[]
- * sequence, or to an invalid instruction (0xea) + Jcc.d8 for cfi_paranoid + ITS
- * thunk.
+ * sequence, or to UDB + Jcc.d8 for cfi_paranoid + ITS thunk.
  */
 static bool decode_fineibt_paranoid(struct pt_regs *regs, unsigned long *target, u32 *type)
 {
@@ -1950,8 +1981,8 @@ static bool decode_fineibt_paranoid(stru
 		return false;
 
 	if (is_cfi_trap(addr + fineibt_caller_size - LEN_UD2)) {
-		*target = regs->r11 + fineibt_preamble_size;
-		*type = regs->r10;
+		*target = regs->r11 + fineibt_prefix_size;
+		*type = regs->ax;
 
 		/*
 		 * Since the trapping instruction is the exact, but LOCK prefixed,
@@ -1963,14 +1994,14 @@ static bool decode_fineibt_paranoid(stru
 	/*
 	 * The cfi_paranoid + ITS thunk combination results in:
 	 *
-	 *  0:   41 ba 78 56 34 12       mov    $0x12345678, %r10d
-	 *  6:   45 3b 53 f7             cmp    -0x9(%r11), %r10d
-	 *  a:   4d 8d 5b f0             lea    -0x10(%r11), %r11
+	 *  0:   b8 78 56 34 12          mov    $0x12345678, %eax
+	 *  5:   41 3b 43 f7             cmp    -11(%r11), %eax
+	 *  a:   2e 3d 8d 5b f0          cs lea -0x10(%r11), %r11
 	 *  e:   2e e8 XX XX XX XX	 cs call __x86_indirect_paranoid_thunk_r11
 	 *
 	 * Where the paranoid_thunk looks like:
 	 *
-	 *  1d:  <ea>                    (bad)
+	 *  1d:  <d6>                    udb
 	 *  __x86_indirect_paranoid_thunk_r11:
 	 *  1e:  75 fd                   jne 1d
 	 *  __x86_indirect_its_thunk_r11:
@@ -1979,8 +2010,8 @@ static bool decode_fineibt_paranoid(stru
 	 *
 	 */
 	if (is_paranoid_thunk(regs->ip)) {
-		*target = regs->r11 + fineibt_preamble_size;
-		*type = regs->r10;
+		*target = regs->r11 + fineibt_prefix_size;
+		*type = regs->ax;
 
 		regs->ip = *target;
 		return true;
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -97,7 +97,7 @@ __always_inline int is_valid_bugaddr(uns
  * Check for UD1 or UD2, accounting for Address Size Override Prefixes.
  * If it's a UD1, further decode to determine its use:
  *
- * FineIBT:      ea                      (bad)
+ * FineIBT:      d6                      udb
  * FineIBT:      f0 75 f9                lock jne . - 6
  * UBSan{0}:     67 0f b9 00             ud1    (%eax),%eax
  * UBSan{10}:    67 0f b9 40 10          ud1    0x10(%eax),%eax
@@ -130,9 +130,9 @@ __always_inline int decode_bug(unsigned
 		WARN_ON_ONCE(!lock);
 		return BUG_LOCK;
 
-	case 0xea:
+	case 0xd6:
 		*len = addr - start;
-		return BUG_EA;
+		return BUG_UDB;
 
 	case OPCODE_ESCAPE:
 		break;
@@ -341,7 +341,7 @@ static noinstr bool handle_bug(struct pt
 		}
 		fallthrough;
 
-	case BUG_EA:
+	case BUG_UDB:
 	case BUG_LOCK:
 		if (handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
 			handled = true;
--- a/arch/x86/lib/bhi.S
+++ b/arch/x86/lib/bhi.S
@@ -5,7 +5,7 @@
 #include <asm/nospec-branch.h>
 
 /*
- * Notably, the FineIBT preamble calling these will have ZF set and r10 zero.
+ * Notably, the FineIBT preamble calling these will have ZF set and eax zero.
  *
  * The very last element is in fact larger than 32 bytes, but since its the
  * last element, this does not matter,
@@ -36,7 +36,7 @@ SYM_INNER_LABEL(__bhi_args_1, SYM_L_LOCA
 	ANNOTATE_NOENDBR
 	UNWIND_HINT_FUNC
 	jne .Lud_1
-	cmovne %r10, %rdi
+	cmovne %rax, %rdi
 	ANNOTATE_UNRET_SAFE
 	ret
 	int3
@@ -53,8 +53,8 @@ SYM_INNER_LABEL(__bhi_args_2, SYM_L_LOCA
 	ANNOTATE_NOENDBR
 	UNWIND_HINT_FUNC
 	jne .Lud_1
-	cmovne %r10, %rdi
-	cmovne %r10, %rsi
+	cmovne %rax, %rdi
+	cmovne %rax, %rsi
 	ANNOTATE_UNRET_SAFE
 	ret
 	int3
@@ -64,9 +64,9 @@ SYM_INNER_LABEL(__bhi_args_3, SYM_L_LOCA
 	ANNOTATE_NOENDBR
 	UNWIND_HINT_FUNC
 	jne .Lud_1
-	cmovne %r10, %rdi
-	cmovne %r10, %rsi
-	cmovne %r10, %rdx
+	cmovne %rax, %rdi
+	cmovne %rax, %rsi
+	cmovne %rax, %rdx
 	ANNOTATE_UNRET_SAFE
 	ret
 	int3
@@ -76,10 +76,10 @@ SYM_INNER_LABEL(__bhi_args_4, SYM_L_LOCA
 	ANNOTATE_NOENDBR
 	UNWIND_HINT_FUNC
 	jne .Lud_2
-	cmovne %r10, %rdi
-	cmovne %r10, %rsi
-	cmovne %r10, %rdx
-	cmovne %r10, %rcx
+	cmovne %rax, %rdi
+	cmovne %rax, %rsi
+	cmovne %rax, %rdx
+	cmovne %rax, %rcx
 	ANNOTATE_UNRET_SAFE
 	ret
 	int3
@@ -89,11 +89,11 @@ SYM_INNER_LABEL(__bhi_args_5, SYM_L_LOCA
 	ANNOTATE_NOENDBR
 	UNWIND_HINT_FUNC
 	jne .Lud_2
-	cmovne %r10, %rdi
-	cmovne %r10, %rsi
-	cmovne %r10, %rdx
-	cmovne %r10, %rcx
-	cmovne %r10, %r8
+	cmovne %rax, %rdi
+	cmovne %rax, %rsi
+	cmovne %rax, %rdx
+	cmovne %rax, %rcx
+	cmovne %rax, %r8
 	ANNOTATE_UNRET_SAFE
 	ret
 	int3
@@ -110,12 +110,12 @@ SYM_INNER_LABEL(__bhi_args_6, SYM_L_LOCA
 	ANNOTATE_NOENDBR
 	UNWIND_HINT_FUNC
 	jne .Lud_2
-	cmovne %r10, %rdi
-	cmovne %r10, %rsi
-	cmovne %r10, %rdx
-	cmovne %r10, %rcx
-	cmovne %r10, %r8
-	cmovne %r10, %r9
+	cmovne %rax, %rdi
+	cmovne %rax, %rsi
+	cmovne %rax, %rdx
+	cmovne %rax, %rcx
+	cmovne %rax, %r8
+	cmovne %rax, %r9
 	ANNOTATE_UNRET_SAFE
 	ret
 	int3
@@ -125,13 +125,13 @@ SYM_INNER_LABEL(__bhi_args_7, SYM_L_LOCA
 	ANNOTATE_NOENDBR
 	UNWIND_HINT_FUNC
 	jne .Lud_2
-	cmovne %r10, %rdi
-	cmovne %r10, %rsi
-	cmovne %r10, %rdx
-	cmovne %r10, %rcx
-	cmovne %r10, %r8
-	cmovne %r10, %r9
-	cmovne %r10, %rsp
+	cmovne %rax, %rdi
+	cmovne %rax, %rsi
+	cmovne %rax, %rdx
+	cmovne %rax, %rcx
+	cmovne %rax, %r8
+	cmovne %rax, %r9
+	cmovne %rax, %rsp
 	ANNOTATE_UNRET_SAFE
 	ret
 	int3
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -134,10 +134,10 @@ SYM_CODE_END(__x86_indirect_jump_thunk_a
 .macro ITS_THUNK reg
 
 /*
- * If CFI paranoid is used then the ITS thunk starts with opcodes (0xea; jne 1b)
+ * If CFI paranoid is used then the ITS thunk starts with opcodes (1: udb; jne 1b)
  * that complete the fineibt_paranoid caller sequence.
  */
-1:	.byte 0xea
+1:	ASM_UDB
 SYM_INNER_LABEL(__x86_indirect_paranoid_thunk_\reg, SYM_L_GLOBAL)
 	UNWIND_HINT_UNDEFINED
 	ANNOTATE_NOENDBR
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -419,12 +419,12 @@ static void emit_fineibt(u8 **pprog, u8
 	u8 *prog = *pprog;
 
 	EMIT_ENDBR();
-	EMIT3_off32(0x41, 0x81, 0xea, hash);		/* subl $hash, %r10d	*/
+	EMIT1_off32(0x2d, hash);			/* subl $hash, %eax	*/
 	if (cfi_bhi) {
+		EMIT2(0x2e, 0x2e);			/* cs cs */
 		emit_call(&prog, __bhi_args[arity], ip + 11);
 	} else {
-		EMIT2(0x75, 0xf9);			/* jne.d8 .-7		*/
-		EMIT3(0x0f, 0x1f, 0x00);		/* nop3			*/
+		EMIT3_off32(0x2e, 0x0f, 0x85, 3);	/* jne.d32,pn 3		*/
 	}
 	EMIT_ENDBR_POISON();
 


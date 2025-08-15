Return-Path: <linux-kernel+bounces-770725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB91B27E41
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 12:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BB147BBD09
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A204B2FF16A;
	Fri, 15 Aug 2025 10:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J4ldmfbn"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFC11B042E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 10:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755253726; cv=none; b=ExNQZpuXvZ3SPbqHE/xzDZLUXErlUdNrETgpJagnBLjYEwhYvz6wPnNkNnNzRK2UmduIvSIDnk9MskYMsXzDq/6XE0H03wR6apqmijytBNL/LueJ5I1aNSESmEC9YTlUplaRJbasyh2fLb1v0m65WGHV7q8B8fVsz6aoBRs177Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755253726; c=relaxed/simple;
	bh=F7+kBQmMrgqweT5j/Ayd7l6rF5tTQ8vmSfvB1eYQ1AI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9mzUfvrItljyrIoMwXZLKZID6Fu+aiBSxveM2pvySzRp0XW+56XUvOT88wZQsBvjV+SVSAOE3kHoKQ8PQr4EQTI+vZpUxtVX17l2t1W8+1NwH7CT1efsmNuD2I5JYfF9eAOZp9a9MFinrW02W3BqGZF4+RxwIllCtSn2NEQeZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=J4ldmfbn; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1LnwgVyZccZniY9gdPodgSXBx1BvekZqzTCyCCeyeFc=; b=J4ldmfbnJvpKS9KahdQw3Ez+Y3
	iClcS1EiYwESTShK3oDGcIBYxKEODSi4aqxu4H1p+POJdGxXuIn2MR+w9HXL+GI/s4lqXmngsR5A9
	w9BA4gyODtpkf3FHv2945XcbRP/tXuRvoFLLlC8/deR+nBMzfRP9N6BK66Ec6C9nRoowvbqLSHBWr
	3sH2/r4OG+kN4KCofLTOD+j1jhOtgIyhEowu7XCnf4/IcB/dp5gLrmGoptgcfo6JPUhAZP12zZsta
	fmWNygUxH0/hTdxeg7dJXJusKYrdd427dcannspFAtsM/QnFnf3n1BxnJgCFlIcN59o2p1DPQWkFE
	Pw8o9y1g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umrfs-0000000BT3K-1qzE;
	Fri, 15 Aug 2025 10:28:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BF28E3001D6; Fri, 15 Aug 2025 12:28:39 +0200 (CEST)
Date: Fri, 15 Aug 2025 12:28:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, kees@kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, samitolvanen@google.com,
	nathan@kernel.org, alexei.starovoitov@gmail.com,
	mhiramat@kernel.org, ojeda@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] x86,ibt: Use UDB instead of 0xEA
Message-ID: <20250815102839.GD4068168@noisy.programming.kicks-ass.net>
References: <20250814111732.GW4067720@noisy.programming.kicks-ass.net>
 <2c121572-8fde-4288-80ca-ab79f2b22cce@zytor.com>
 <20250815074939.GA3419281@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815074939.GA3419281@noisy.programming.kicks-ass.net>

On Fri, Aug 15, 2025 at 09:49:39AM +0200, Peter Zijlstra wrote:
> On Thu, Aug 14, 2025 at 06:27:44PM -0700, H. Peter Anvin wrote:
> > On 2025-08-14 04:17, Peter Zijlstra wrote:
> > > Hi!
> > > 
> > > A while ago FineIBT started using the instruction 0xEA to generate #UD.
> > > All existing parts will generate #UD in 64bit mode on that instruction.
> > > 
> > > However; Intel/AMD have not blessed using this instruction, it is on
> > > their 'reserved' list for future use.
> > > 
> > > Peter Anvin worked the committees and got use of 0xD6 blessed, and it
> > > will be called UDB (per the next SDM or so).
> > > 
> > > Reworking the FineIBT code to use UDB wasn't entirely trivial, and I've
> > > had to switch the hash register to EAX in order to free up some bytes.
> > > 
> > > Per the x86_64 ABI, EAX is used to pass the number of vector registers
> > > for varargs -- something that should not happen in the kernel. More so,
> > > we build with -mskip-rax-setup, which should leave EAX completely unused
> > > in the calling convention.
> > > 
> > > The code boots and passes the LKDTM CFI_FORWARD_PROTO test for various
> > > combinations (non exhaustive so far).
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > 
> > Looks good to me (and using %eax will save one byte per call site as
> > well), but as per our IRC discussion, *my understanding* is that the
> > best possible performance (least branch predictor impact across
> > implementations) is to use a forward branch with a 2E prefix (jcc,pn in
> > GAS syntax) rather than a reverse branch, if space allows.
> 
> Oh right. I did see that comment on IRC and them promptly forgot about
> it again :/ I'll have a poke. Scott, do you agree? You being responsible
> for the backward jump and such.

On top of the other, to show the delta.

If we want a fwd branch, we can stick the D6 in the endbr poison nop.
That frees up more bytes again, but also that matches what I already did
for the bhi1 case, so less special cases is more better.

I've had to use cs prefixed jcc.d32, because our older toolchains don't
like the ,pn notation.

---
 arch/x86/include/asm/cfi.h    |  5 ++---
 arch/x86/include/asm/ibt.h    | 10 +++------
 arch/x86/kernel/alternative.c | 50 +++++++++++++++++++++----------------------
 arch/x86/net/bpf_jit_comp.c   |  3 +--
 4 files changed, 30 insertions(+), 38 deletions(-)

diff --git a/arch/x86/include/asm/cfi.h b/arch/x86/include/asm/cfi.h
index 9256908b5134..3fcfdd996962 100644
--- a/arch/x86/include/asm/cfi.h
+++ b/arch/x86/include/asm/cfi.h
@@ -72,10 +72,9 @@
  * __cfi_foo:
  *   endbr64
  *   subl 0x12345678, %eax
- *   nopl -42(%eax)
- *   jne  __cfi_foo+13
+ *   jne.32,pn foo+3
  * foo:
- *   osp nop3			# was endbr64
+ *   nopl -42(%rax)		# was endbr64
  *   ... code here ...
  *   ret
  *
diff --git a/arch/x86/include/asm/ibt.h b/arch/x86/include/asm/ibt.h
index 28d845257303..5e45d6424722 100644
--- a/arch/x86/include/asm/ibt.h
+++ b/arch/x86/include/asm/ibt.h
@@ -59,10 +59,10 @@ static __always_inline __attribute_const__ u32 gen_endbr(void)
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
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 66e26025b2d4..3fc0d1edab70 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1301,8 +1301,7 @@ early_param("cfi", cfi_parse_cmdline);
  * __cfi_\func:					__cfi_\func:
  *	movl   $0x12345678,%eax		// 5	     endbr64			// 4
  *	nop					     subl   $0x12345678,%eax    // 5
- *	nop					     nopl   -42(%eax)		// 5
- *	nop					     jne    __cfi_\func+13	// 2
+ *	nop					     jne.d32,pn \func+3		// 7
  *	nop
  *	nop
  *	nop
@@ -1311,6 +1310,9 @@ early_param("cfi", cfi_parse_cmdline);
  *	nop
  *	nop
  *	nop
+ *	nop
+ * \func:					\func:
+ *	endbr64					     nopl -42(%rax)
  *
  *
  * caller:					caller:
@@ -1326,8 +1328,8 @@ early_param("cfi", cfi_parse_cmdline);
  * <fineibt_preamble_start>:
  *  0:   f3 0f 1e fa             endbr64
  *  4:   2d 78 56 34 12          sub    $0x12345678, %eax
- *  b:   67 0f 1f 40 <d6>        nopl   -42(%eax)
- *  e:   75 fd                   jne    13 <fineibt_preamble_start+0xd>
+ *  9:   2e 0f 85 03 00 00 00    jne,pn 13 <fineibt_preamble_start+0x13>
+ * 10:   0f 1f 40 d6             nopl   -0x2a(%rax)
  *
  * Note that the JNE target is the 0xD6 byte inside the NOPL, this decodes as
  * UDB on x86_64 and raises #UD.
@@ -1337,8 +1339,9 @@ asm(	".pushsection .rodata				\n"
 	"	endbr64					\n"
 	"	subl	$0x12345678, %eax		\n"
 	"fineibt_preamble_bhi:				\n"
-	"	nopl	-42(%eax)			\n"
-	"	jne	fineibt_preamble_start+13	\n"
+	"	cs jne.d32 fineibt_preamble_start+0x13	\n"
+	"#fineibt_func:					\n"
+	"	nopl	-42(%rax)			\n"
 	"fineibt_preamble_end:				\n"
 	".popsection\n"
 );
@@ -1349,7 +1352,7 @@ extern u8 fineibt_preamble_end[];
 
 #define fineibt_preamble_size (fineibt_preamble_end - fineibt_preamble_start)
 #define fineibt_preamble_bhi  (fineibt_preamble_bhi - fineibt_preamble_start)
-#define fineibt_preamble_ud   13
+#define fineibt_preamble_ud   0x13
 #define fineibt_preamble_hash 5
 
 /*
@@ -1551,7 +1554,6 @@ extern u8 fineibt_bhi1_start[];
 extern u8 fineibt_bhi1_end[];
 
 #define fineibt_bhi1_size (fineibt_bhi1_end - fineibt_bhi1_start)
-#define fineibt_bhi1_ud   0x13
 
 static void cfi_fineibt_bhi_preamble(void *addr, int arity)
 {
@@ -1589,8 +1591,6 @@ static int cfi_rewrite_preamble(s32 *start, s32 *end)
 {
 	s32 *s;
 
-	BUG_ON(fineibt_bhi1_size != 11);
-
 	for (s = start; s < end; s++) {
 		void *addr = (void *)s + *s;
 		int arity;
@@ -1675,9 +1675,6 @@ static int cfi_rewrite_callers(s32 *start, s32 *end)
 {
 	s32 *s;
 
-	BUG_ON(fineibt_caller_size != 14);
-	BUG_ON(fineibt_paranoid_size != 20);
-
 	for (s = start; s < end; s++) {
 		void *addr = (void *)s + *s;
 		struct insn insn;
@@ -1728,13 +1725,18 @@ static int cfi_rewrite_callers(s32 *start, s32 *end)
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
@@ -1873,6 +1875,8 @@ static void poison_cfi(void *addr)
 	}
 }
 
+#define fineibt_prefix_size (fineibt_preamble_size - ENDBR_INSN_SIZE)
+
 /*
  * When regs->ip points to a 0xD6 byte in the FineIBT preamble,
  * return true and fill out target and type.
@@ -1885,16 +1889,10 @@ static bool decode_fineibt_preamble(struct pt_regs *regs, unsigned long *target,
 	unsigned long addr = regs->ip - fineibt_preamble_ud;
 	u32 hash;
 
-again:
-	if (!exact_endbr((void *)addr)) {
-		if (cfi_bhi && addr == regs->ip - fineibt_preamble_ud) {
-			addr = regs->ip - fineibt_bhi1_ud;
-			goto again;
-		}
+	if (!exact_endbr((void *)addr))
 		return false;
-	}
 
-	*target = addr + fineibt_preamble_size;
+	*target = addr + fineibt_prefix_size;
 
 	__get_kernel_nofault(&hash, addr + fineibt_preamble_hash, u32, Efault);
 	*type = (u32)regs->ax + hash;
@@ -1935,7 +1933,7 @@ static bool decode_fineibt_bhi(struct pt_regs *regs, unsigned long *target, u32
 	__get_kernel_nofault(&addr, regs->sp, unsigned long, Efault);
 	*target = addr;
 
-	addr -= fineibt_preamble_size;
+	addr -= fineibt_prefix_size;
 	if (!exact_endbr((void *)addr))
 		return false;
 
@@ -1975,7 +1973,7 @@ static bool decode_fineibt_paranoid(struct pt_regs *regs, unsigned long *target,
 		return false;
 
 	if (is_cfi_trap(addr + fineibt_caller_size - LEN_UD2)) {
-		*target = regs->r11 + fineibt_preamble_size;
+		*target = regs->r11 + fineibt_prefix_size;
 		*type = regs->ax;
 
 		/*
@@ -2004,7 +2002,7 @@ static bool decode_fineibt_paranoid(struct pt_regs *regs, unsigned long *target,
 	 *
 	 */
 	if (is_paranoid_thunk(regs->ip)) {
-		*target = regs->r11 + fineibt_preamble_size;
+		*target = regs->r11 + fineibt_prefix_size;
 		*type = regs->ax;
 
 		regs->ip = *target;
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index f54353ef3e51..5178ef1aa5c7 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -424,8 +424,7 @@ static void emit_fineibt(u8 **pprog, u8 *ip, u32 hash, int arity)
 		EMIT2(0x2e, 0x2e);			/* cs cs */
 		emit_call(&prog, __bhi_args[arity], ip + 11);
 	} else {
-		EMIT5(0x67, 0x0f, 0x1f, 0x40, 0xd6);	/* nopl -42(%eax)	*/
-		EMIT2(0x75, 0xfd);			/* jne.d8 .-3		*/
+		EMIT3_off32(0x2e, 0x0f, 0x85, 3);	/* jne.d32,pn 3		*/
 	}
 	EMIT_ENDBR_POISON();
 


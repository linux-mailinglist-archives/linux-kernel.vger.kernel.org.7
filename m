Return-Path: <linux-kernel+bounces-796183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE51B3FCF7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E978E18961F2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC462E613C;
	Tue,  2 Sep 2025 10:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o8k5ECI9"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E842283680
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 10:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756809995; cv=none; b=bqw/FGslVk5Vwz7Ue5PQBh+vpl2WipAowUgLr/WI8yHzDOGoq+ZPWrb/JOaCjE6aiyJRZ2d5uP9Ui7r4QiNH3mjudIYbcIqNpoSCfhUiDXJH8jiXCnIv2VWLGuGH3assyISN+zLHCBE8hRUElmpi6Dehij5rclEu5SBde1nLME8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756809995; c=relaxed/simple;
	bh=VBEsrLyR8yIAxbv5S9FTZVa4I0IJUe9uBblhyO0qaNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGKP4zpPlUGjfYzBqZqtGu+wCKAy4r5JqTIw6v3NMTq01fKziHFFqTXONhjGbj37wbTGMUsVKEJmZvlFDihv9UVvrUoi1p3/FriyJVYDsPh5/OxRKsHu4Ly9154UP4KvuXV7HTlUNgwlJgajBFjtkjExG/imQaN0cn82KQdgzrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=o8k5ECI9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Mn5y6BZ4jnVk1dzmXmVi/ipitm705LFhhS+2Fsmp7S4=; b=o8k5ECI9W14HETSnK7VFRkPe8U
	IhF5J9UEBFxjInfn3LWxi/YWusqsZxdRkxdGjj3r/33H1d0BX8TLQ2RuCEMwzAhNnegibKVQVmqeQ
	FqqQYgDnyqCY+5VPRolFj4/GuuyvEe156cp1sqNr0ktnYU+HUNXqFwVeZPXCj/ZNZ65rTmp1njy3m
	eaUIDZrp+s/jyZTcTg20xDVUOzK2faFoLC5lfpAyCHhjs1HvdjitM1GCCCn7icQmyxLfTbsT4yMDH
	D8CRGmePb1+N+A4YffFns5RUhKRx62axQsfZfXJ4Py18ya3+5o+pSkNM7mX+yN6tqCI7lYsqOjIz4
	RrUFmRjg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utOWy-00000004l2Q-2bzC;
	Tue, 02 Sep 2025 10:46:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F055E30039F; Tue, 02 Sep 2025 12:46:27 +0200 (CEST)
Date: Tue, 2 Sep 2025 12:46:27 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc: kees@kernel.org, alyssa.milburn@intel.com, scott.d.constable@intel.com,
	joao@overdrivepizza.com, andrew.cooper3@citrix.com,
	samitolvanen@google.com, nathan@kernel.org,
	alexei.starovoitov@gmail.com, mhiramat@kernel.org, ojeda@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86,ibt: Use UDB instead of 0xEA
Message-ID: <20250902104627.GM4068168@noisy.programming.kicks-ass.net>
References: <20250901191307.GI4067720@noisy.programming.kicks-ass.net>
 <20250902081915.GK3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902081915.GK3245006@noisy.programming.kicks-ass.net>

On Tue, Sep 02, 2025 at 10:19:15AM +0200, Peter Zijlstra wrote:

> Caller:
> 
>   FineIBT                               Paranoid-FineIBT
> 
>   fineibt_caller:                       fineibt_caller:
>     mov     $0x12345678, %eax             mov    $0x12345678, %eax
>     lea     -10(%r11), %r11               cmp    -0x11(%r11), %eax
>     nop5                                  cs lea -0x10(%r11), %r11
>   retpoline:                            retpoline:
>     cs call __x86_indirect_thunk_r11      jne    fineibt_caller+0xd
>                                           call   *%r11
>                                           nop
> 
> Notably this is before apply_retpolines() which will fix up the
> retpoline call -- since all parts with IBT also have eIBRS (lets
> ignore ITS). Typically the retpoline site is rewritten (when still
> intact) into:
> 
>     call *r11
>     nop3
> 

> And now I'm going to have to do a patch that makes apply_retpoline()
> do CS padding instead of NOP padding for CALL... 

Finding the exact prefix decode penalties for uarchs that have
eIBRS/BHI_NO is not a fun time. I've stuck to the general wisdom that 3
prefixes is mostly good (notably, the instruction at hand has no 0x0f
escape which is sometimes counted towards the prefix budget -- it can
have a REX prefix, but those are generally not counted towards the
prefix budget).

In general Intel P-cores do not have prefix decode penalties, but the
E-cores (or rather the Atom line) generally does. And since this all
runs on hybrid cores, the code must accommodate them.

I hate all this.

---
Subject: x86,retpoline: Optimize patch_retpoline()
From: Peter Zijlstra <peterz@infradead.org>
Date: Tue Sep 2 11:20:35 CEST 2025

Currently the very common retpoline: "CS CALL __x86_indirect_thunk_r11"
is transformed into "CALL *R11; NOP3" for eIBRS/BHI_NO parts.

Similarly, paranoid fineibt has: "CALL *R11; NOP".

Recognise that CS stuffing can avoid the extra NOP. However, due to
prefix decode penalties, make sure to not emit too many CS prefixes.
Notably: "CS CALL __x86_indirect_thunk_rax" must not become "CS CS CS
CS CALL *RAX". Prefix decode penalties are typically many more cycles
than decoding an extra NOP.

Additionally, if the retpoline is a tail-call, the "JMP *%\reg" should
be followed by INT3 for straight-line-speculation mitigation, since
emit_indirect() now has a length argument, move this into
emit_indirect() such that other users (paranoid-fineibt) also do this.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/alternative.c |   40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -715,18 +715,31 @@ static inline bool is_jcc32(struct insn
 /*
  * CALL/JMP *%\reg
  */
-static int emit_indirect(int op, int reg, u8 *bytes)
+static int emit_indirect(int op, int reg, u8 *bytes, int len)
 {
+	int cs = 0, bp = 0;
 	int i = 0;
 	u8 modrm;
 
+	/*
+	 * Set @len to the excess bytes after writing the instruction.
+	 */
+	len -= 2 + (reg >= 8);
+	WARN_ON_ONCE(len < 0);
+
 	switch (op) {
 	case CALL_INSN_OPCODE:
 		modrm = 0x10; /* Reg = 2; CALL r/m */
+		/*
+		 * Additional NOP is better than prefix decode penalty.
+		 */
+		if (len <= 3)
+			cs = len;
 		break;
 
 	case JMP32_INSN_OPCODE:
 		modrm = 0x20; /* Reg = 4; JMP r/m */
+		bp = !!len;
 		break;
 
 	default:
@@ -734,6 +747,9 @@ static int emit_indirect(int op, int reg
 		return -1;
 	}
 
+	while (cs--)
+		bytes[i++] = 0x2e; /* CS-prefix */
+
 	if (reg >= 8) {
 		bytes[i++] = 0x41; /* REX.B prefix */
 		reg -= 8;
@@ -745,6 +761,9 @@ static int emit_indirect(int op, int reg
 	bytes[i++] = 0xff; /* opcode */
 	bytes[i++] = modrm;
 
+	if (bp)
+		bytes[i++] = 0xcc; /* INT3 */
+
 	return i;
 }
 
@@ -918,20 +937,11 @@ static int patch_retpoline(void *addr, s
 		return emit_its_trampoline(addr, insn, reg, bytes);
 #endif
 
-	ret = emit_indirect(op, reg, bytes + i);
+	ret = emit_indirect(op, reg, bytes + i, insn->length - i);
 	if (ret < 0)
 		return ret;
 	i += ret;
 
-	/*
-	 * The compiler is supposed to EMIT an INT3 after every unconditional
-	 * JMP instruction due to AMD BTC. However, if the compiler is too old
-	 * or MITIGATION_SLS isn't enabled, we still need an INT3 after
-	 * indirect JMPs even on Intel.
-	 */
-	if (op == JMP32_INSN_OPCODE && i < insn->length)
-		bytes[i++] = INT3_INSN_OPCODE;
-
 	for (; i < insn->length;)
 		bytes[i++] = BYTES_NOP1;
 
@@ -1418,8 +1428,7 @@ asm(	".pushsection .rodata				\n"
 	"#fineibt_caller_size:                          \n"
 	"	jne	fineibt_paranoid_start+0xd	\n"
 	"fineibt_paranoid_ind:				\n"
-	"	call	*%r11				\n"
-	"	nop					\n"
+	"	cs call	*%r11				\n"
 	"fineibt_paranoid_end:				\n"
 	".popsection					\n"
 );
@@ -1721,8 +1730,9 @@ static int cfi_rewrite_callers(s32 *star
 			emit_paranoid_trampoline(addr + fineibt_caller_size,
 						 &insn, 11, bytes + fineibt_caller_size);
 		} else {
-			ret = emit_indirect(op, 11, bytes + fineibt_paranoid_ind);
-			if (WARN_ON_ONCE(ret != 3))
+			int len = fineibt_paranoid_size - fineibt_paranoid_ind;
+			ret = emit_indirect(op, 11, bytes + fineibt_paranoid_ind, len);
+			if (WARN_ON_ONCE(ret != len))
 				continue;
 		}
 


Return-Path: <linux-kernel+bounces-832621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 603D3B9FEFD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 646BB1C281C1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D55428726C;
	Thu, 25 Sep 2025 14:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r+X+7Kl+"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D674F1DE4F6
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758809516; cv=none; b=ZxSvuNw39vBPSm0CkHAqIFRwMMOXnsh2jS91gpALfSejp7s5GlRqBHB6wO5sc5PahrVMJ4PX0jBkzLiQWmNTwz4Zi6TYnt2VmzKALiN+whiy/+Bb32EYeZX7lgdxqheLCvvr6pk0S8ypuVyomfkJ/mAzvq8xUZGo4fzXIH5swZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758809516; c=relaxed/simple;
	bh=kCtXPReZnM+0JV+GWlovk4mpsRgmTAWTGW3VbucPyRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhkykZjYQBXDwq1LoqQgcGSPVqU6mcSTPYn3o/NwW7w0EG8V6M4Bx0d5apEJkQ6Lw3TrWbClIC5AC+mKJsH1gaiGgOKfXuEMMOSwYaLyuj6kzLNLltgzCPbFGP3g3KZO3zTnc4mxv3zrqjcuxQsODrhqPWkW8IXeiREGjus33Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=r+X+7Kl+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZAWrXcJ5WgsoJa6H6bzdN7Sikc+0AvBh3KRsC/9zvlY=; b=r+X+7Kl+oaPTSl+R0+F1Qzc1gH
	EJHJmOAqeb5ljFVcHlH6R8cGJOUQzFH66zghQHds0Bv2X/n9xtdJNwEuzbP84IQhnR8K0OuchyKBl
	3vBKU7C9UmK/oyJhJSi206QZcYO3m8ure2mwsgYw3Dgq/qrnxdVlWvUfDRkW6NuOm3EBgOJ2g0F3F
	yBkShVGxK6VpgIiYNbxB5M4tDfK+6l/abjcfIRoM5OkcUzn5KDwrhpgh0MTdlor3CI2FzdUvgJ1mU
	JsLzXs0HqeX52lgU339GvpQ1p+iaIfcxfTm7Dib/UMfobvXbvYrXSumqYhZcLOsG0JEE99uvF9r9D
	67EHiJlQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1mhH-00000005vkC-3Be9;
	Thu, 25 Sep 2025 14:11:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 48BFF300579; Thu, 25 Sep 2025 16:11:47 +0200 (CEST)
Date: Thu, 25 Sep 2025 16:11:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: alexandre.chartre@oracle.com, jpoimboe@kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 3/3] objtool/x86: Fix NOP decode
Message-ID: <20250925141147.GA4068168@noisy.programming.kicks-ass.net>
References: <20250925104251.GZ4067720@noisy.programming.kicks-ass.net>
 <a2f6775f-0be5-401b-bc01-effd3f428482@citrix.com>
 <20250925124332.GA3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925124332.GA3245006@noisy.programming.kicks-ass.net>

On Thu, Sep 25, 2025 at 02:43:32PM +0200, Peter Zijlstra wrote:

> But yes.. I happen to have an insn_is_nop() function that can be used on
> userspace, and that certainly wants to be taught about these... x86 is
> such a pain :/

This is the delta I ended up with for my insn_is_nop() function to
support *VEX*/REX2.

I'll post the whole thing later.

--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -138,6 +138,10 @@ struct insn {
 #define X86_VEX_V(vex)	(((vex) & 0x78) >> 3)	/* VEX3 Byte2, VEX2 Byte1 */
 #define X86_VEX_P(vex)	((vex) & 0x03)		/* VEX3 Byte2, VEX2 Byte1 */
 #define X86_VEX_M_MAX	0x1f			/* VEX3.M Maximum value */
+/* EVEX bit fields */
+#define X86_EVEX_R4(vex) ((vex) & 0x10)		/* EVEX Byte1 */
+#define X86_EVEX_B4(vex) ((vex) & 0x08)		/* EVEX Byte1 */
+#define X86_EVEX_X4(vex) ((vex) & 0x04)		/* EVEX Byte2 */
 /* XOP bit fields */
 #define X86_XOP_R(xop)	((xop) & 0x80)	/* XOP Byte2 */
 #define X86_XOP_X(xop)	((xop) & 0x40)	/* XOP Byte2 */
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -1689,33 +1689,62 @@ enum insn_mmio_type insn_decode_mmio(str
  */
 bool insn_is_nop(struct insn *insn)
 {
-	u8 rex, rex_b = 0, rex_x = 0, rex_r = 0, rex_w = 0;
+	u8 b3 = 0, x3 = 0, r3 = 0, w = 0;
+	u8 b4 = 0, x4 = 0, r4 = 0;
 	u8 modrm, modrm_mod, modrm_reg, modrm_rm;
 	u8 sib = 0, sib_scale, sib_index, sib_base;
 	insn_byte_t p;
+	u8 nrex, rex;
 	int i;
 
-	if (insn->rex_prefix.nbytes) {
-		rex = insn->rex_prefix.bytes[0];
-		rex_w = !!X86_REX_W(rex);
-		rex_r = !!X86_REX_R(rex);
-		rex_x = !!X86_REX_X(rex);
-		rex_b = !!X86_REX_B(rex);
+	if ((nrex = insn->rex_prefix.nbytes)) {
+		rex = insn->rex_prefix.bytes[nrex-1];
+
+		w  = !!X86_REX_W(rex);
+		r3 = !!X86_REX_R(rex);
+		x3 = !!X86_REX_X(rex);
+		b3 = !!X86_REX_B(rex);
+		if (nrex > 1) {
+			r4 = !!X86_REX2_R(rex);
+			x4 = !!X86_REX2_X(rex);
+			b4 = !!X86_REX2_B(rex);
+		}
+
+	} else switch (insn->vex_prefix.nbytes) {
+	case 2: /* VEX2 */
+		r3 =  !X86_VEX_R(insn->vex_prefix.bytes[1]);
+		break;
+	case 3: /* VEX3 */
+		r3 =  !X86_VEX_R(insn->vex_prefix.bytes[1]);
+		x3 =  !X86_VEX_X(insn->vex_prefix.bytes[1]);
+		b3 =  !X86_VEX_B(insn->vex_prefix.bytes[1]);
+		w  = !!X86_VEX_W(insn->vex_prefix.bytes[2]);
+		break;
+	case 4: /* EVEX */
+		r3 =  !X86_VEX_R(insn->vex_prefix.bytes[1]);
+		x3 =  !X86_VEX_X(insn->vex_prefix.bytes[1]);
+		b3 =  !X86_VEX_B(insn->vex_prefix.bytes[1]);
+		w  = !!X86_VEX_W(insn->vex_prefix.bytes[2]);
+		r4 =  !X86_EVEX_R4(insn->vex_prefix.bytes[1]);
+		b4 = !!X86_EVEX_B4(insn->vex_prefix.bytes[1]);
+		x4 =  !X86_EVEX_X4(insn->vex_prefix.bytes[2]);
+		break;
+	default: break;
 	}
 
 	if (insn->modrm.nbytes) {
 		modrm = insn->modrm.bytes[0];
 		modrm_mod = X86_MODRM_MOD(modrm);
-		modrm_reg = X86_MODRM_REG(modrm) + 8*rex_r;
-		modrm_rm  = X86_MODRM_RM(modrm)  + 8*rex_b;
+		modrm_reg = X86_MODRM_REG(modrm) + 8*r3 + 16*r4;
+		modrm_rm  = X86_MODRM_RM(modrm)  + 8*b3 + 16*b4;
 		modrm = 1;
 	}
 
 	if (insn->sib.nbytes) {
 		sib = insn->sib.bytes[0];
 		sib_scale = X86_SIB_SCALE(sib);
-		sib_index = X86_SIB_INDEX(sib) + 8*rex_x;
-		sib_base  = X86_SIB_BASE(sib)  + 8*rex_b;
+		sib_index = X86_SIB_INDEX(sib) + 8*x3 + 16*x4;
+		sib_base  = X86_SIB_BASE(sib)  + 8*b3 + 16*b4;
 		sib = 1;
 
 		modrm_rm = sib_base;
@@ -1729,7 +1758,7 @@ bool insn_is_nop(struct insn *insn)
 		if (modrm_mod != 3) /* register-direct */
 			return false;
 
-		if (insn->x86_64 && !rex_w) /* native size */
+		if (insn->x86_64 && !w) /* native size */
 			return false;
 
 		for_each_insn_prefix(insn, i, p) {
@@ -1743,7 +1772,7 @@ bool insn_is_nop(struct insn *insn)
 		if (modrm_mod == 0 || modrm_mod == 3) /* register-indirect with disp */
 			return false;
 
-		if (insn->x86_64 && !rex_w) /* native size */
+		if (insn->x86_64 && !w) /* native size */
 			return false;
 
 		if (insn->displacement.value != 0)
@@ -1760,7 +1789,7 @@ bool insn_is_nop(struct insn *insn)
 		return modrm_reg == modrm_rm; /* LEA 0(%reg), %reg */
 
 	case 0x90: /* NOP */
-		if (rex_b) /* XCHG %r8,%rax */
+		if (b3 || b4) /* XCHG %r8,%rax */
 			return false;
 
 		for_each_insn_prefix(insn, i, p) {


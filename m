Return-Path: <linux-kernel+bounces-825076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B94FB8AE29
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 20:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAE1758709E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 18:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF50253359;
	Fri, 19 Sep 2025 18:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="guDhhs5p"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD4324678C
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 18:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758305825; cv=none; b=PIOBRtDrHxBgb6tnFc/+hId4rsiI2UrBFcEgNfI57D4NH78UCvdZSa4Nl7ZWj/zOcRhtMc6QYs8fQltuUs4E/g7klMW8Hgv6g9bHmw+HE4X++V8z6fGTcX+noMnj/tqA4HduNER8ZM8G+KvcFHNa949xCCRTPvCZsGAYgc+CPk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758305825; c=relaxed/simple;
	bh=6H8DRYkITx0t9mOK8RYJWKONBj4iLpeHg7QIb/1qOLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+aOv6Wz+VL1Yud1Waiy+ppYyCTFJAR83E08r7n+a7n4WNppGgoJmzGbMvpmFdT4yFw538rkkMo7ckz1hx3Bz8MsNutx/LIXUE9lBQ/XdFsAuw3DxPq7/ASAkkTI608wrQ5IkSnYxC28dxVYmc8rR3fYmoi+docaSHYmLL022Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=guDhhs5p; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 94A8D40E01BB;
	Fri, 19 Sep 2025 18:16:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Wxnng_bB4nsj; Fri, 19 Sep 2025 18:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1758305812; bh=BQuY+K1ypTJTx2n0xbUdBAlzdTI/9TH/FRIgqi7Q14U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=guDhhs5pmEJZYm1U4nndG8F/xaNJHgEZjQeirWU9diUlLAmW/GgdRtTzyRco20llZ
	 K3Mk0EUQwk/geHWurdmpnjes3C1GxyKdrkOVGujIoOpoYyE/aViinGraSedTadEZmf
	 8hk1q6EAOG9M0vChK7C2VT01WHl6fHdPdiW3R79kkZfFIJjUC49lb+XVIL4OXenNBO
	 +QXUDcMURcGPF37rXToFD0KNgOkroDvwIUbbUbqHTZIZw5aYQYW++iVjVWuXcgnWxF
	 WAL2D2vjoMyH0Fu31ryVUIvIgVsaR5ZVbtKgWkkkiVHAx4QmNoKjfd8N2BGcV34y3p
	 tnMTdws8C9LfQls5roitS5G5bd6mxRhx4ARNjhyUOGQq2SP6w0Ro0jWsozXA3le3rX
	 odh95AQgmMnkSvwZoDNVic4oHn335mQVMPqxlLA3DckBOfFw50nv+vWS5VFAK3qV50
	 s+VLjj3U3+Z2kHExyJausLesUKFewPmHRDH5LF1CDJzEEfezmvwyMt9hmPXuuaK8YV
	 5Hs1xNx1RwBP50m0bEVshjZm8+uqMQ1tVfJ8fIW/81o8n/MZiDHPGqiGr3xBaNtQPS
	 gupJV0XIWWWgi8fMx9iKSWalKNcRTx1SCUOWPeZ2/U/xodv1cF6615VmyprafzkdTh
	 FZwjc3ZKYfzhi8iea5SBPy+g=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id BA13040E00DA;
	Fri, 19 Sep 2025 18:16:44 +0000 (UTC)
Date: Fri, 19 Sep 2025 20:16:35 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sean Christopherson <seanjc@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Dan Snyder <dansnyder@google.com>
Subject: Re: [PATCH 1/3] x86/umip: Check that the instruction opcode is at
 least two bytes
Message-ID: <20250919181635.GFaM2eA8GFtZ48sfb0@fat_crate.local>
References: <20250808172358.1938974-1-seanjc@google.com>
 <20250808172358.1938974-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250808172358.1938974-2-seanjc@google.com>

On Fri, Aug 08, 2025 at 10:23:56AM -0700, Sean Christopherson wrote:
> When checking for a potential UMIP violation on #GP, verify the decoder
> found at least two opcode bytes to avoid false positives when the kernel
> encounters an unknown instruction that starts with 0f.  Because the array
> of opcode.bytes is zero-initialized by insn_init(), peeking at bytes[1]
> will misinterpret garbage as a potential SLDT or STR instruction, and can
> incorrectly trigger emulation.
> 
> E.g. if a vpalignr instruction
> 
>    62 83 c5 05 0f 08 ff     vpalignr xmm17{k5},xmm23,XMMWORD PTR [r8],0xff
> 
> hits a #GP, the kernel emulates it as STR and squashes the #GP (and
> corrupts the userspace code stream).
> 
> Arguably the check should look for exactly two bytes, but no three byte
> opcodes use '0f 00 xx' or '0f 01 xx' as an escape, i.e. it should be
> impossible to get a false positive if the first two opcode bytes match
> '0f 00' or '0f 01'.  Go with a more conservative check with respect to the
> existing code to minimize the chances of breaking userspace, e.g. due to
> decoder weirdness.

So I did some staring... I guess this fix is trying to address our insn
decoder shortcoming and calls it "weirdness", right?

$ objdump -d a.out | awk -f ./arch/x86/tools/objdump_reformat.awk | ./arch/x86/tools/insn_decoder_test 
./arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
./arch/x86/tools/insn_decoder_test: warning:    0:      62 83 c5 05 0f 08 ff    vpalignr $0xff,(%r8),%xmm23,%xmm17{%k5}
./arch/x86/tools/insn_decoder_test: warning: objdump says 7 bytes, but insn_get_length() says 6
./arch/x86/tools/insn_decoder_test: warning: Decoded and checked 1 instructions with 1 failures

Looks like it.

a.out has:

0000000000000000 <.text>:
   0:   62 83 c5 05 0f 08 ff    vpalignr $0xff,(%r8),%xmm23,%xmm17{%k5}

I guess just adding the insn to the table doesn't fix it.

Masami?

---
diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index 262f7ca1fb95..a23ff3c16908 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -23,7 +23,7 @@
 #
 # AVX Superscripts
 #  (ev): this opcode requires EVEX prefix.
-#  (es): this opcode requires EVEX prefix and is SCALABALE.
+#  (es): this opcode requires EVEX prefix and is SCALABLE.
 #  (evo): this opcode is changed by EVEX prefix (EVEX opcode)
 #  (v): this opcode requires VEX prefix.
 #  (v1): this opcode only supports 128bit VEX.
@@ -867,7 +867,7 @@ AVXcode: 3
 0c: vblendps Vx,Hx,Wx,Ib (66)
 0d: vblendpd Vx,Hx,Wx,Ib (66)
 0e: vpblendw Vx,Hx,Wx,Ib (66),(v1)
-0f: palignr Pq,Qq,Ib | vpalignr Vx,Hx,Wx,Ib (66),(v1)
+0f: palignr Pq,Qq,Ib | vpalignr Vx,Hx,Wx,Ib (66),(v1) | vpalignr Vx,kz,Hx,Wx,Ib (ev)
 14: vpextrb Rd/Mb,Vdq,Ib (66),(v1)
 15: vpextrw Rd/Mw,Vdq,Ib (66),(v1)
 16: vpextrd/q Ey,Vdq,Ib (66),(v1)


> Fixes: 1e5db223696a ("x86/umip: Add emulation code for UMIP instructions")
> Reported-by: Dan Snyder <dansnyder@google.com>
> Analyzed-by; Nick Bray <ncbray@google.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kernel/umip.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
> index 5a4b21389b1d..406ac01ce16d 100644
> --- a/arch/x86/kernel/umip.c
> +++ b/arch/x86/kernel/umip.c
> @@ -156,8 +156,8 @@ static int identify_insn(struct insn *insn)
>  	if (!insn->modrm.nbytes)
>  		return -EINVAL;
>  
> -	/* All the instructions of interest start with 0x0f. */
> -	if (insn->opcode.bytes[0] != 0xf)
> +	/* The instructions of interest have 2-byte opcodes: 0F 00 or 0F 01. */
> +	if (insn->opcode.nbytes < 2 || insn->opcode.bytes[0] != 0xf)
>  		return -EINVAL;
>  
>  	if (insn->opcode.bytes[1] == 0x1) {
> -- 
> 2.50.1.703.g449372360f-goog
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


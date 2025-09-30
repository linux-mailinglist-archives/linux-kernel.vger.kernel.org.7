Return-Path: <linux-kernel+bounces-837266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD0ABABD26
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AEDE1926477
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765C3296BBF;
	Tue, 30 Sep 2025 07:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q6D/YVjN"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EE3242D7C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759217214; cv=none; b=RR6fH1t5oIOiAn02H8Bqc6Xz36kVYtcQ/7DNhhbopJd7ZIa3TeUmxefJZytRWkLBBh7ceOEpA0DlZzLTxqNPinAKabWB4LInPTp9pATNySQ0byjcvmL2GqDMfuzILJcdoXwJVhYoUvDt2DgtZxAg/WBa7TTQL+FgrLEJzUE+pZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759217214; c=relaxed/simple;
	bh=rg0sIGKCB8fN4y8saksrPSm30H7LW2WbPqIZvZwJX5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNmKN4qMWX3h7MJByVCiEOkDn2OmsK/v3E673TOGT9ZcNc93XN3nqZMit/Ajh2/A0MKPZaoHFGxfZoEMTaq+yuhggPDQe8j8RQYlHeXu95eGURW3YgrhtWWdFmFXTp9UCOvlJlTUiJosrxle7KhGH/nyA9MGXDhmqMHxDD1t/B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Q6D/YVjN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UQjIskjfBpWYrzoS8fNjRqzMswi2Aul0000FD54ha0Y=; b=Q6D/YVjNBKI8b8upThllk87pKc
	O6MtGokcvxJ1UyG5MSDmptmHGHYP9xv3CLY58PYdAxxu9akvH4R9SU04ua/SWZPaBUSPnwXM31aYo
	RiJuqRZa8vEeFpREkO03YSpaTaCIAOVmhtXTh9v8vYkGzOgqV37VFuwdQjSpbIGF6nN4NChbIIg/Q
	czvz3wlB2PlrHX5iIUG23QGDy6LGUGjEyaBhL13kemz/ajQiiw8D4YplsNEHMLGt2+xEbg0Sgpy72
	eQnrgsqm4rEHfSeL8v9883VKb5VtwPSY4S/fUExdXEBLpZX5en2xHxwJfN7btbKPIln5IHFRxqEBp
	C7NZpMrw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3Ul1-00000006Ruv-3VXV;
	Tue, 30 Sep 2025 07:26:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CC7F9300328; Tue, 30 Sep 2025 09:26:43 +0200 (CEST)
Date: Tue, 30 Sep 2025 09:26:43 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 3/3] x86/alternative: Patch a single alternative location
 only once
Message-ID: <20250930072643.GF3245006@noisy.programming.kicks-ass.net>
References: <20250929112947.27267-1-jgross@suse.com>
 <20250929112947.27267-4-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929112947.27267-4-jgross@suse.com>

On Mon, Sep 29, 2025 at 01:29:47PM +0200, Juergen Gross wrote:
> Instead of patching a single location potentially multiple times in
> case of nested ALTERNATIVE()s, do the patching only after having
> evaluated all alt_instr instances for that location.
> 
> This has multiple advantages:
> 
> - In case of replacing an indirect with a direct call using the
>   ALT_FLAG_DIRECT_CALL flag, there is no longer the need to have that
>   instance before any other instances at the same location (the
>   original instruction is needed for finding the target of the direct
>   call).
> 
> - In case of nested ALTERNATIVE()s there is no intermediate replacement
>   visible. This avoids any problems in case e.g. an interrupt is
>   happening between the single instances and the patched location is
>   used during handling the interrupt.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
> V2:
> - new patch
> ---
>  arch/x86/kernel/alternative.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 735cc017f2d3..ccf07131cd47 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -648,6 +648,8 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
>  	u8 insn_buff[MAX_PATCH_LEN];
>  	u8 *instr;
>  	struct alt_instr *a, *b;
> +	unsigned int instances = 0;
> +	bool patched = false;
>  
>  	DPRINTK(ALT, "alt table %px, -> %px", start, end);
>  
> @@ -677,9 +679,13 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
>  		 * padding for all alt_instr entries for this site (nested
>  		 * alternatives result in consecutive entries).
>  		 */
> -		for (b = a+1; b < end && instr_va(b) == instr_va(a); b++) {
> -			u8 len = max(a->instrlen, b->instrlen);
> -			a->instrlen = b->instrlen = len;
> +		if (!instances) {
> +			for (b = a+1; b < end && instr_va(b) == instr_va(a); b++) {
> +				u8 len = max(a->instrlen, b->instrlen);
> +				a->instrlen = b->instrlen = len;
> +			}
> +			instances = b - a;
> +			patched = false;
>  		}
>  
>  		instr = instr_va(a);
> @@ -692,14 +698,19 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
>  		 * - feature not present but ALT_FLAG_NOT is set to mean,
>  		 *   patch if feature is *NOT* present.
>  		 */
> -		if (!boot_cpu_has(a->cpuid) == !(a->flags & ALT_FLAG_NOT)) {
> -			memcpy(insn_buff, instr, a->instrlen);
> -			optimize_nops(instr, insn_buff, a->instrlen);
> -		} else {
> +		if (!boot_cpu_has(a->cpuid) != !(a->flags & ALT_FLAG_NOT)) {
>  			apply_one_alternative(instr, insn_buff, a);
> +			patched = true;
>  		}
>  
> -		text_poke_early(instr, insn_buff, a->instrlen);
> +		instances--;
> +		if (!instances) {
> +			if (!patched) {
> +				memcpy(insn_buff, instr, a->instrlen);
> +				optimize_nops(instr, insn_buff, a->instrlen);
> +			}
> +			text_poke_early(instr, insn_buff, a->instrlen);
> +		}
>  	}
>  
>  	kasan_enable_current();

I think you lost the optimize_nops() call for the patched case.

That is, note how apply_one_alternative() does 0x90 padding, but then
you only do optimize_nops() when !patched.


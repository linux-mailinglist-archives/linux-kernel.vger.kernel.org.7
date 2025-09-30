Return-Path: <linux-kernel+bounces-837321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F30BABF91
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6E131C6A4C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 08:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BA02F39A5;
	Tue, 30 Sep 2025 08:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W61QIwkN"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DCF24167A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 08:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759220095; cv=none; b=RT2SsZBC2qX46N45RCwU91AqmR659Uiap+Vti5YVh6299c0yIL3urDQCBWHQ+Y/7smjMVC4FqMFEwkvEvdpNQ/RLdGVd5iAKOEND+KMQ5h7u3N+SL2kU6ZFESwdF0VPf4TZ9w2lybedtjkesl4INxpCoqUm2OGUOeaMTrTrXP+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759220095; c=relaxed/simple;
	bh=G4l9DgFoag+cMwzXFggTtmUneVWS5LQqS8NQZD+7VRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpJlVN+ApCjwnlEktINnXxV3hb+NRG64Q6xEMrebaatlrFIwPnGlvDno/MATkHn1/CCSIbaE+KtqE5yZd/eeWh5SxGbV5koI59dILP6uOWtxwJFrFtNSn21eVZrrbNW76iGaBIydwRObnAzLUkWjqsgxvfgEwcDthnqn2K5d6oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W61QIwkN; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2nnBOuIqScZe6b8WuKloPPhC/MDVdeIe9XpfSiqBtIA=; b=W61QIwkN37S4sYlju6/idAlpf+
	ND8+Up0ByswfnuCnl2ZXRgB95VBjkxUAfZwsSK8HUeS26vd7YTxN+KJFO/FoKA0VuC6F/EE/Ck1tH
	jps1i4MTMjxYIIYhCu4RzqB5ShigolPbBBKJDz6+ZM3nRYXmibH/DlIwYnCSWDFvgfGuAjIIBulD0
	HnGUpcKBZkSYV4LhQbO4n+nI8WkPsOhsX6USX3pRcD9tIKlhsw4/lwGtWO3SwJfZhgiEZ/DkgcNaL
	ZqLCkZR/3yqkSkkpH6N1/DWxcx7aP6JpBoB+w0fV3XN6/wtalyMndjnuo7n3BYVzyuVrlrXyhDIZf
	R0D4UQcw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3VVU-0000000Ch0X-1RoL;
	Tue, 30 Sep 2025 08:14:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C75AE300220; Tue, 30 Sep 2025 10:14:42 +0200 (CEST)
Date: Tue, 30 Sep 2025 10:14:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, xin@zytor.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2 08/12] x86/extable: Add support for immediate form MSR
 instructions
Message-ID: <20250930081442.GG3245006@noisy.programming.kicks-ass.net>
References: <20250930070356.30695-1-jgross@suse.com>
 <20250930070356.30695-9-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930070356.30695-9-jgross@suse.com>

On Tue, Sep 30, 2025 at 09:03:52AM +0200, Juergen Gross wrote:
> From: "Xin Li (Intel)" <xin@zytor.com>
> 
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
> V2:
> - new patch, taken from the RFC v2 MSR refactor series by Xin Li
> ---
>  arch/x86/include/asm/msr.h | 18 ++++++++++++++++++
>  arch/x86/mm/extable.c      | 39 +++++++++++++++++++++++++++++++++-----
>  2 files changed, 52 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
> index 71f41af11591..cf5205300266 100644
> --- a/arch/x86/include/asm/msr.h
> +++ b/arch/x86/include/asm/msr.h
> @@ -56,6 +56,24 @@ static inline void do_trace_read_msr(u32 msr, u64 val, int failed) {}
>  static inline void do_trace_rdpmc(u32 msr, u64 val, int failed) {}
>  #endif
>  
> +/*
> + * Called only from an MSR fault handler, the instruction pointer points to
> + * the MSR access instruction that caused the fault.
> + */
> +static __always_inline bool is_msr_imm_insn(void *ip)
> +{
> +	/*
> +	 * A full decoder for immediate form MSR instructions appears excessive.
> +	 */
> +#ifdef CONFIG_X86_64
> +	const u8 msr_imm_insn_prefix[] = { 0xc4, 0xe7 };
> +
> +	return !memcmp(ip, msr_imm_insn_prefix, sizeof(msr_imm_insn_prefix));

This seems fragile. Those two bytes are basically the first two bytes of
VEX3 and only indicate VEX3.map7. Which is not very specific, but when
combined with the fact that this is an MSR exception, might just work.

Trouble is that it is also possible to encode the immediate form using
EVEX. If a toolchain were to do that, we'd fail to detect it.

(And there is segment prefix stuffing possible I suppose)

> +#else
> +	return false;
> +#endif
> +}
> +
>  /*
>   * __rdmsr() and __wrmsr() are the two primitives which are the bare minimum MSR
>   * accessors and should not have any tracing or other functionality piggybacking
> diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
> index 2fdc1f1f5adb..c021e4dbc69d 100644
> --- a/arch/x86/mm/extable.c
> +++ b/arch/x86/mm/extable.c
> @@ -166,23 +166,52 @@ static bool ex_handler_uaccess(const struct exception_table_entry *fixup,
>  static bool ex_handler_msr(const struct exception_table_entry *fixup,
>  			   struct pt_regs *regs, bool wrmsr, bool safe, int reg)
>  {
> +	bool imm_insn = is_msr_imm_insn((void *)regs->ip);
> +	u32 msr;
> +
> +	if (imm_insn)
> +		/*
> +		 * The 32-bit immediate specifying a MSR is encoded into
> +		 * byte 5 ~ 8 of an immediate form MSR instruction.
> +		 */
> +		msr = *(u32 *)(regs->ip + 5);
> +	else
> +		msr = (u32)regs->cx;

This seems to have fallen subject to the US tariff induced {} shortage
or something.

Also, EVEX form will have them in other bytes (one further, on account
of EVEX being 4 bytes, rather than 3).

Given this really isn't a fast path or anything, how about we just use
the instruction decoder? Something like:

	struct insn insn;
	u32 msr = (u32)regs->cx;

	ret = insn_decode_kernel(&insn, (void *)regs->ip);
	if (!ret && insn.vex_prefix.nbytes)
		msr = insn.immediate.value;

should do, I suppose. Isn't that both simpler and more robust?



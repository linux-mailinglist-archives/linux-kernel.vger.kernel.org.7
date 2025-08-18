Return-Path: <linux-kernel+bounces-773965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAA3B2ACF5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34008189989C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF86265609;
	Mon, 18 Aug 2025 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SCqeFIiW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x/vLP/be"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA7723C4E9
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 15:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755531532; cv=none; b=oBLgGOzfxtK8+jtrduaRLHCgTHLMyqlve8jZwKWz+PArDxik4CzCpWXxhx643OBaZhyZ0WDkNyibVMUUK0ZS5BjJZj3ID7Kn4nb+1fzwsuW2VbDoqRuPPAPzjcTagVd6xz5IdQwtXTJnlw6Bun1nsxXg/6dq8PAlcADWNmChmnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755531532; c=relaxed/simple;
	bh=up58hOgSOKi67XWwzFic+VH/u523boAeoSMCvDuQd3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLLBknEny+cHC9Rn5mFCxQx8C54Vae5kztArwoOhp2Ktuw4fmkkD9zxsucHf7TKEh03j0UWa3ZRMjNKluaAxX6Z2oEogy1odbusVA1laWI4iRwRJUhchRp4SDx9HKFNzajDM7JEGlYuZWDklVtgacMkcFIySxjIaQuw8pFc2fK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SCqeFIiW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x/vLP/be; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Aug 2025 17:38:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755531529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=74hSaxb6f6iJvzD3MoE/ujA4oXW3D/CA4ucXVtgWeBw=;
	b=SCqeFIiWLSNTEmTo1mzU5mNA2Wvu3ZgM2KrbjhO1Pf6qFoEuxBjODn980MDdhuE2FrcXBL
	Bq61jR6wqrqQpNU4K3C9mSlgD4NoQGINIjDrfxfvQN8lSS2iE6UbZV052UkGHKUP4U7OSj
	ZjMd+jx2MoD8g9vaYlWx4quazCKvdww1wUgn8wkPAPDoy5xozgZu5LPJ5XivmEuHcIxDAG
	0rWUNn/lAa2srTjj6pnz0N8TJjXKKnUEIvySmgu6F/6rrfIAFwdSUc2oFS4EKcTT29kMQ9
	C0xsVm8+dWdq0WMCDwFDLWYS5zW1ia+vcy5hBjrgPTeJ13fyl+hH7nwNEDDimw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755531529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=74hSaxb6f6iJvzD3MoE/ujA4oXW3D/CA4ucXVtgWeBw=;
	b=x/vLP/be87fuBdIthjflSM1B8anS7DiiVXJgZCM+UPrZ9xVFjiy1p+ms4eKAYWHckBBs5t
	pb2j1lwAn+ZEFvCg==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Sean Christopherson <seanjc@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	John Ogness <john.ogness@linutronix.de>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 28/34] x86/cacheinfo: Use parsed CPUID(0x80000005) and
 CPUID(0x80000006)
Message-ID: <aKNJB1uM4LIX3WDw@lx-t490>
References: <20250815070227.19981-1-darwi@linutronix.de>
 <20250815070227.19981-29-darwi@linutronix.de>
 <4a680b7d-2ecb-4579-a5ea-b612c08ebefa@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a680b7d-2ecb-4579-a5ea-b612c08ebefa@intel.com>

On Fri, 15 Aug 2025, Dave Hansen wrote:
>
> On 8/15/25 00:02, Ahmed S. Darwish wrote:
> > +static void legacy_amd_cpuid4(struct cpuinfo_x86 *c, int index, struct leaf_0x4_0 *regs)
> >  {
> > -	unsigned int dummy, line_size, lines_per_tag, assoc, size_in_kb;
> > -	union l1_cache l1i, l1d, *l1;
> > -	union l2_cache l2;
> > -	union l3_cache l3;
> > +	const struct leaf_0x80000005_0 *el5 = cpuid_leaf(c, 0x80000005);
> > +	const struct leaf_0x80000006_0 *el6 = cpuid_leaf(c, 0x80000006);
> > +	const struct cpuid_regs *el5_raw = (const struct cpuid_regs *)el5;
>
> Is there any way we could get rid of the casts? The lack of type safety
> on those always worries me. Maybe a helper like this:
>
>     const struct cpuid_regs *el5_raw = cpuid_leaf_raw(c, 0x80000006);
>
> (although that would probably just do casts internally).
>

Indeed.

I already have at <asm/cpuid/api.h>:

    /**
     * cpuid_leaf_regs() - Access parsed CPUID data in raw format
     * @_cpuinfo:	CPU capability structure reference ('struct cpuinfo_x86')
     * @_leaf:		CPUID leaf, in compile-time 0xN format
     *
     * Similar to cpuid_leaf(), but returns a raw 'struct cpuid_regs' pointer to
     * the parsed CPUID data instead of a "typed" <cpuid/leaf_types.h> pointer.
     */
    #define cpuid_leaf_regs(_cpuinfo, _leaf)				\
	((struct cpuid_regs *)(cpuid_leaf(_cpuinfo, _leaf)))

The only reason I didn't use it in this patch was to avoid a repetion.
But, you're correct, using the API is better than call-site casting.

Thus, the code shall be:

    const struct leaf_0x80000005_0 *el5 = cpuid_leaf(c, 0x80000005);
    const struct leaf_0x80000006_0 *el6 = cpuid_leaf(c, 0x80000006);
    const struct cpuid_regs *el5_raw = cpuid_leaf_regs(c, 0x80000005);

I'll do it like that in v5.

Thanks!
Ahmed


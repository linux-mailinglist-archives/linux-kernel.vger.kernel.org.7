Return-Path: <linux-kernel+bounces-790564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E85B3AA42
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE6DF7BAEF9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B0427933A;
	Thu, 28 Aug 2025 18:48:28 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7672727E4
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 18:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756406908; cv=none; b=iQoUYvY/A0tnmxrV7kKtjwgUCtF+w5p3wFxsiXqWd1QICeeuHwRxT2ET3BwICo114QbmoOr5wXyfxXqiHvqruXMkTGsYD5Ey+UPY2fyBD9p2IQhgXcM7fVRP4opugHggbtW+8b6f4F8i07KW2cxqyD5CmRkPQqUr3QGcKA2Uirg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756406908; c=relaxed/simple;
	bh=QZqRfOnd/mthr7SgmzudH6me1aqzl7OP8FHh2NQ2q7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLx5jBCBDmVYfTrvx8fyEbzyKUMMYDZLsbbT28pyO4zwT3jwxAn9I/1caKI34QuLurZI7imopanyg7jAlqAiloVFqyFyNb8zr139xzx/chnd5q3etUBsYOp6yzYZLwlIm6sFUOpCqNXM3QEU08P4iGbtdrmrqU7n7G1nQfPqz9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB2EC4CEEB;
	Thu, 28 Aug 2025 18:48:25 +0000 (UTC)
Date: Thu, 28 Aug 2025 19:48:23 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Yang Shi <yang@os.amperecomputing.com>, will@kernel.org,
	akpm@linux-foundation.org, Miko.Lenczewski@arm.com,
	dev.jain@arm.com, scott@os.amperecomputing.com, cl@gentwo.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v6 3/4] arm64: mm: support large block mapping when
 rodata=full
Message-ID: <aLCkd-E1wgszoZKd@arm.com>
References: <20250805081350.3854670-1-ryan.roberts@arm.com>
 <20250805081350.3854670-4-ryan.roberts@arm.com>
 <aLCNTsM-nn6SpfOO@arm.com>
 <5795892e-503e-496b-a5dd-be4776f15513@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5795892e-503e-496b-a5dd-be4776f15513@arm.com>

On Thu, Aug 28, 2025 at 06:45:32PM +0100, Ryan Roberts wrote:
> On 28/08/2025 18:09, Catalin Marinas wrote:
> > On Tue, Aug 05, 2025 at 09:13:48AM +0100, Ryan Roberts wrote:
> >> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> >> index abd9725796e9..f6cd79287024 100644
> >> --- a/arch/arm64/mm/mmu.c
> >> +++ b/arch/arm64/mm/mmu.c
> > [...]
> >> @@ -640,6 +857,16 @@ static inline void arm64_kfence_map_pool(phys_addr_t kfence_pool, pgd_t *pgdp) {
> >>  
> >>  #endif /* CONFIG_KFENCE */
> >>  
> >> +static inline bool force_pte_mapping(void)
> >> +{
> >> +	bool bbml2 = system_capabilities_finalized() ?
> >> +		system_supports_bbml2_noabort() : bbml2_noabort_available();
> >> +
> >> +	return (!bbml2 && (rodata_full || arm64_kfence_can_set_direct_map() ||
> >> +			   is_realm_world())) ||
> >> +		debug_pagealloc_enabled();
> >> +}
> >> +
> >>  static void __init map_mem(pgd_t *pgdp)
> >>  {
> >>  	static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
> >> @@ -665,7 +892,7 @@ static void __init map_mem(pgd_t *pgdp)
> >>  
> >>  	early_kfence_pool = arm64_kfence_alloc_pool();
> >>  
> >> -	if (can_set_direct_map())
> >> +	if (force_pte_mapping())
> >>  		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> >>  
> >>  	/*
> >> @@ -1367,7 +1594,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
> >>  
> >>  	VM_BUG_ON(!mhp_range_allowed(start, size, true));
> >>  
> >> -	if (can_set_direct_map())
> >> +	if (force_pte_mapping())
> >>  		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> >>  
> >>  	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
> > 
> > Not sure this works in a heterogeneous configuration.
> > bbml2_noabort_available() only checks the current/boot CPU which may
> > return true but if secondary CPUs don't have the feature, it results in
> > system_supports_bbml2_noabort() being false with force_pte_mapping()
> > also false in the early map_mem() calls.
> 
> The intent is that we eagerly create a block-mapped linear map at boot if the
> boot CPU supports BBML2. If, once we have determined that a secondary CPU
> doesn't support BBML2 (and therefore the system doesn't support it) then we
> repaint the linear map using page mappings.
> 
> The repainting mechanism is added in the next patch.

Ah, I haven't reached that patch yet ;).

> I've tested this with heterogeneous configs and I'm confident it does work.

Great. The downside is that such configuration is rare, the logic is
fairly complex and won't get tested much. Hardware with such
configuration will take a slight hit on the boot time.

I don't remember the discussions around Miko's patches adding the BBML2
feature - do we have such heterogeneous configurations or are they just
theoretical at this stage?

> FYI, I actually have a new version of this ready to go - I was hoping to post
> tomorrow, subject to performance results. I thought you were implying in a
> previous mail that you weren't interested in reviewing until it was based on top
> of an -rc. Perhaps I misunderstood. Let me know if you want me to hold off on
> posting that given you are now reviewing this version.

In general I prefer patches on top of a fixed -rc, especially if I need
to apply them locally. But I was wondering if you are waiting for review
feedback before rebasing, so I had a quick look ;).

Please post a new version. I'll have a look at that since you were
planning to update a few bits anyway.

-- 
Catalin


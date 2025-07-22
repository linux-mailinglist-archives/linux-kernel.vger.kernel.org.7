Return-Path: <linux-kernel+bounces-740466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA38B0D477
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8CE217B288
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C102D373B;
	Tue, 22 Jul 2025 08:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJKu2eJa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105032BEFE8
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 08:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753172611; cv=none; b=X9321txcM7N7VCPE3bu4tV2UtD6YFNXzISaYVDt/C4Z5dxeaZlzIZJxglYckRLTxWKQbYJ/aS//lTJT6Hk2GsccTjhMBSb8SM7CqBR0KEkVcwlxu45Xei8U95YUmPWHZ8TVmcSl/dYWKAyhFNTtkGvXFcSpJp0b/Ma3jlcVcYQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753172611; c=relaxed/simple;
	bh=Y7L/rRO5yyKs2AKEjD3Is669RR4GnyvoU1Va0/d4nes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxBsKBTlA/HsXSw6Q7NE0nIDBMmKv68X2yBVO0cUEFq8POc2YetpEv4XeI90ijiCKtUuTToCiquI9cztiNlovmUyw6AySnsdRpNjU2+LTohw4jjyR+w7HS0dhFQhGm12EABTxjSB4gO9bKSzgMLXpCWssVD7yumqA5hULD9nl2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJKu2eJa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65EAC4CEF4;
	Tue, 22 Jul 2025 08:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753172610;
	bh=Y7L/rRO5yyKs2AKEjD3Is669RR4GnyvoU1Va0/d4nes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vJKu2eJataVITCVflCr840wmheOuK4XZlYWs6rrrZpZ8f8334JvjTIPjTBtcg9wmK
	 hR5ceZw2sIh+Bc1ywwL2YvnTVUnnhu5pNNCs4fpc4ayWUqS5XcKkPeUvBsSeB5DxEG
	 0/CXdshl05qh+Ss1Nmh0QUeiSO3LavlTOlLASQnBZnEMPKLDhte/RyXse9forwWwKE
	 o1DDCseBL37p9rIcjs59P5Lc6q3DSY6ZZ9ZZTUuzJvC2FesBKpl29GOEAy1h/BDi/T
	 yLyGxV3knvDunrs7c0b1bDSieX44bXlDNDruNlVmKPYTgNSZqKxMJvWYJOHtQXJgYJ
	 leAGO78mPSmuQ==
Date: Tue, 22 Jul 2025 11:23:25 +0300
From: Mike Rapoport <rppt@kernel.org>
To: mawupeng <mawupeng1@huawei.com>
Cc: akpm@linux-foundation.org, ardb@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: ignore nomap memory during mirror init
Message-ID: <aH9KfV8XM5fNsR/Y@kernel.org>
References: <20250717085723.1875462-1-mawupeng1@huawei.com>
 <aHjQp9zPVPuPyP3B@kernel.org>
 <9688e968-e9af-4143-b550-16c02a0b4ceb@huawei.com>
 <aHj8mfecDhJJZW1Y@kernel.org>
 <8d604308-36d3-4b55-8ddb-b33f8b586c1a@huawei.com>
 <aHzjOxg_oPp06blC@kernel.org>
 <205873c9-b8cd-4aa7-822e-3c1d6a5a5ea7@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <205873c9-b8cd-4aa7-822e-3c1d6a5a5ea7@huawei.com>

On Mon, Jul 21, 2025 at 10:11:11AM +0800, mawupeng wrote:
> On 2025/7/20 20:38, Mike Rapoport wrote:
> > On Fri, Jul 18, 2025 at 09:37:48AM +0800, mawupeng wrote:
> >>
> >>
> >> On 2025/7/17 21:37, Mike Rapoport wrote:
> >>> On Thu, Jul 17, 2025 at 07:06:52PM +0800, mawupeng wrote:
> >>>>
> >>>> On 2025/7/17 18:29, Mike Rapoport wrote:
> >>>>> On Thu, Jul 17, 2025 at 04:57:23PM +0800, Wupeng Ma wrote:
> >>>>>> When memory mirroring is enabled, the BIOS may reserve memory regions
> >>>>>> at the start of the physical address space without the MR flag. This will
> >>>>>> lead to zone_movable_pfn to be updated to the start of these reserved
> >>>>>> regions, resulting in subsequent mirrored memory being ignored.
> >>>>>>
> >>>>>> Here is the log with efi=debug enabled:
> >>>>>>   efi:   0x084004000000-0x0842bf37ffff [Conventional|   |  |MR|...|WB|WT|WC|  ]
> >>>>>>   efi:   0x0842bf380000-0x0842c21effff [Loader Code |   |  |MR|...|WB|WT|WC|  ]
> >>>>>>   efi:   0x0842c21f0000-0x0847ffffffff [Conventional|   |  |MR|...|WB|WT|WC|  ]
> >>>>>>   efi:   0x085000000000-0x085fffffffff [Conventional|   |  |  |...|WB|WT|WC|  ]
> >>>>>> ...
> >>>>>>   efi:   0x084000000000-0x084003ffffff [Reserved    |   |  |  |...|WB|WT|WC|  ]
> >>>>>>
> >>>>>> Since this kind of memory can not be used by kernel. ignore nomap memory to fix
> >>>>>> this issue.
> >>>>
> >>>> Since the first non-mirror pfn of this node is 0x084000000000, then zone_movable_pfn 
> >>>> for this node will be updated to this. This will lead to Mirror Region 
> >>>>   - 0x084004000000-0x0842bf37ffff
> >>>>   - 0x0842bf380000-0x0842c21effff 
> >>>>   - 0x0842c21f0000-0x0847ffffffff
> >>>> be seen as non-mirror memory since zone_movable_pfn will be the start_pfn of this node
> >>>> in adjust_zone_range_for_zone_movable().
> >>>
> >>> What do you mean by "seen as non-mirror memory"?
> >>
> >> It mean these memory range will be add to movable zone.
> >>
> >>>
> >>> What is the problem with having movable zone on that node start at
> >>> 0x084000000000?
> >>>
> >>> Can you post the kernel log up to "Memory: nK/mK available" line for more
> >>> context?
> >>
> >> Memory: nK/mK available can not see be problem here, since there is nothing wrong
> >> with the total memory. However this problem can be shown via lsmem --output-all
> > 
> > I didn't ask for that particular line but for *up to that line*.
> >  
> >> w/o this patch
> >> [root@localhost ~]# lsmem --output-all
> >> RANGE                                  SIZE  STATE REMOVABLE         BLOCK NODE   ZONES
> >> 0x0000084000000000-0x00000847ffffffff   32G online       yes   67584-67839    0 Movable
> >> 0x0000085000000000-0x0000085fffffffff   64G online       yes   68096-68607    0 Movable
> >>
> >> w/ this patch
> >> [root@localhost ~]# lsmem --output-all
> >> RANGE                                  SIZE  STATE REMOVABLE         BLOCK NODE   ZONES
> >> 0x0000084000000000-0x00000847ffffffff   32G online       yes   8448-8479    0  Normal
> >> 0x0000085000000000-0x0000085fffffffff   64G online       yes   8512-8575    0 Movable
> > 
> > As I see the problem, you have a problematic firmware that fails to report
> > memory as mirrored because it reserved for firmware own use. This causes
> > for non-mirrored memory to appear before mirrored memory. And this breaks
> > an assumption in find_zone_movable_pfns_for_nodes() that mirrored memory
> > always has lower addresses than non-mirrored memory and you end up wiht
> > having all the memory in movable zone.
> 
> Yes.
> 
> > 
> > So to workaround this firmware issue you propose a hack that would skip
> > NOMAP regions while calculating zone_movable_pfn because your particular
> > firmware reports the reserved mirrored memory as NOMAP.
> > 
> > Why don't you simply pass "kernelcore=32G" on the command line and you'll
> > get the same result.
> 
> Since mirrored memory are in each node, not only one, "kernelcore=32G" can
> not fix this problem.

I don't see other nodes in lsmem output. And I asked for the kernel log
exactly to see how kernel sees the memory on the system.
 
Another question is do you really need ZONE_MOVABLE? Most of the time MM
core operates on the pageblock granularity and even if all the memory are
in ZONE_NORMAL the pageblocks are still movable.

-- 
Sincerely yours,
Mike.


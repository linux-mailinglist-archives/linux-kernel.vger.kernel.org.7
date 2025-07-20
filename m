Return-Path: <linux-kernel+bounces-738235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A3DB0B62C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 14:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 792CF1767A1
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 12:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC9E1F583A;
	Sun, 20 Jul 2025 12:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQU3ljgC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F0414883F
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 12:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753015105; cv=none; b=e3TD83L4XrxGH/4TO5JQAhPvAYeoehgH3z64arwUza0HDp16fNbIg79rct893yksSOuSzxnNqCbauBu3iY/pgTel17aIpb/MstyuFavbXp3zUoi2H9B3PY0tDiwB/W+li0+UAB3AwPsnRYPvcx5jOZSJzuevtgFFV+yIXDFGLqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753015105; c=relaxed/simple;
	bh=3U0HLcGYrlk1llQSOsm7NoFj2/bLDVh50DsU8t7Su/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKZsDC74OmxPL3ZdDIQ2c3hNpgu4MeFNqTcZoFw1aAb+WOI8+uuqL/P9Phxrjl2ColA7ScsBL2KK+X+bkaHmBiHhmKZ4zpYpz4elWUpnDJ2hyu2dzinfQMF6wtwapd0i4oPYt+TzHQuvzJ8vf9Y22bTeWwLj+ZCLe3JIwQYAarE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQU3ljgC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8803C4CEE7;
	Sun, 20 Jul 2025 12:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753015104;
	bh=3U0HLcGYrlk1llQSOsm7NoFj2/bLDVh50DsU8t7Su/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DQU3ljgCYyucZM+zhIVqhpvT+Y2gyGRqJ54n//8D2Zn1PHqyWSYp+onysy9VM7oDP
	 TAHiIq+pAA7YQaTfOlUz51wk3/l7A4DLo4dBqDjEfcpJKGIXN0AswafihFafjSyiL7
	 2sJiFjbpYdjoDsZgGPaq9o0oxvZVde9AICvRvZ4VZ4PHVJ/GVD6kKXzoFJcmTp9njQ
	 6t2VLaYjPgBG5vQrQaAtQBx29v8QRxXmeFgWzxQqf+6uubZwAYumuZ2N81DiZjUF/9
	 N5RY+WUQsn//PfyqmenApQmcl1bo3SEGzIlNNeExO12BRGwk4KuDpbJ5uPRGAOkoL3
	 wIIbCFLBBl5RQ==
Date: Sun, 20 Jul 2025 15:38:19 +0300
From: Mike Rapoport <rppt@kernel.org>
To: mawupeng <mawupeng1@huawei.com>
Cc: akpm@linux-foundation.org, ardb@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: ignore nomap memory during mirror init
Message-ID: <aHzjOxg_oPp06blC@kernel.org>
References: <20250717085723.1875462-1-mawupeng1@huawei.com>
 <aHjQp9zPVPuPyP3B@kernel.org>
 <9688e968-e9af-4143-b550-16c02a0b4ceb@huawei.com>
 <aHj8mfecDhJJZW1Y@kernel.org>
 <8d604308-36d3-4b55-8ddb-b33f8b586c1a@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d604308-36d3-4b55-8ddb-b33f8b586c1a@huawei.com>

On Fri, Jul 18, 2025 at 09:37:48AM +0800, mawupeng wrote:
> 
> 
> On 2025/7/17 21:37, Mike Rapoport wrote:
> > On Thu, Jul 17, 2025 at 07:06:52PM +0800, mawupeng wrote:
> >>
> >> On 2025/7/17 18:29, Mike Rapoport wrote:
> >>> On Thu, Jul 17, 2025 at 04:57:23PM +0800, Wupeng Ma wrote:
> >>>> When memory mirroring is enabled, the BIOS may reserve memory regions
> >>>> at the start of the physical address space without the MR flag. This will
> >>>> lead to zone_movable_pfn to be updated to the start of these reserved
> >>>> regions, resulting in subsequent mirrored memory being ignored.
> >>>>
> >>>> Here is the log with efi=debug enabled:
> >>>>   efi:   0x084004000000-0x0842bf37ffff [Conventional|   |  |MR|...|WB|WT|WC|  ]
> >>>>   efi:   0x0842bf380000-0x0842c21effff [Loader Code |   |  |MR|...|WB|WT|WC|  ]
> >>>>   efi:   0x0842c21f0000-0x0847ffffffff [Conventional|   |  |MR|...|WB|WT|WC|  ]
> >>>>   efi:   0x085000000000-0x085fffffffff [Conventional|   |  |  |...|WB|WT|WC|  ]
> >>>> ...
> >>>>   efi:   0x084000000000-0x084003ffffff [Reserved    |   |  |  |...|WB|WT|WC|  ]
> >>>>
> >>>> Since this kind of memory can not be used by kernel. ignore nomap memory to fix
> >>>> this issue.
> >>
> >> Since the first non-mirror pfn of this node is 0x084000000000, then zone_movable_pfn 
> >> for this node will be updated to this. This will lead to Mirror Region 
> >>   - 0x084004000000-0x0842bf37ffff
> >>   - 0x0842bf380000-0x0842c21effff 
> >>   - 0x0842c21f0000-0x0847ffffffff
> >> be seen as non-mirror memory since zone_movable_pfn will be the start_pfn of this node
> >> in adjust_zone_range_for_zone_movable().
> > 
> > What do you mean by "seen as non-mirror memory"?
> 
> It mean these memory range will be add to movable zone.
> 
> > 
> > What is the problem with having movable zone on that node start at
> > 0x084000000000?
> > 
> > Can you post the kernel log up to "Memory: nK/mK available" line for more
> > context?
> 
> Memory: nK/mK available can not see be problem here, since there is nothing wrong
> with the total memory. However this problem can be shown via lsmem --output-all

I didn't ask for that particular line but for *up to that line*.
 
> w/o this patch
> [root@localhost ~]# lsmem --output-all
> RANGE                                  SIZE  STATE REMOVABLE         BLOCK NODE   ZONES
> 0x0000084000000000-0x00000847ffffffff   32G online       yes   67584-67839    0 Movable
> 0x0000085000000000-0x0000085fffffffff   64G online       yes   68096-68607    0 Movable
> 
> w/ this patch
> [root@localhost ~]# lsmem --output-all
> RANGE                                  SIZE  STATE REMOVABLE         BLOCK NODE   ZONES
> 0x0000084000000000-0x00000847ffffffff   32G online       yes   8448-8479    0  Normal
> 0x0000085000000000-0x0000085fffffffff   64G online       yes   8512-8575    0 Movable

As I see the problem, you have a problematic firmware that fails to report
memory as mirrored because it reserved for firmware own use. This causes
for non-mirrored memory to appear before mirrored memory. And this breaks
an assumption in find_zone_movable_pfns_for_nodes() that mirrored memory
always has lower addresses than non-mirrored memory and you end up wiht
having all the memory in movable zone.

So to workaround this firmware issue you propose a hack that would skip
NOMAP regions while calculating zone_movable_pfn because your particular
firmware reports the reserved mirrored memory as NOMAP.

Why don't you simply pass "kernelcore=32G" on the command line and you'll
get the same result.

> As shown above, All memory in this node is added to Zone Movable even some range of the memory
> is mirror memory. With this patch, 0x0000084000000000-0x00000847ffffffff will be added to
> zone normal as expected since the MR attribute.

-- 
Sincerely yours,
Mike.


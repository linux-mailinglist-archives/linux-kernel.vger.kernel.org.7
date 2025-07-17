Return-Path: <linux-kernel+bounces-735371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C126B08E62
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 229711A66AB3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2338B2EBDC6;
	Thu, 17 Jul 2025 13:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mrly2IrG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848FE2E5421
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752759456; cv=none; b=lzGFGtCTX3KgWX5VMs4pDsl9OdOz/YmbIOm+4UbdZXS4zrvhgdzJbrgD8IIH7pi2g2RNhhD7qz9LMO+hiqZKgY21VQfBTkbJ8POu0/m1vL+qb1ysiYRTVP/WYParORUS5thbmq7WyZuXhhSCVHGjfAIzl5XMjkB4eWaTmrcdQH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752759456; c=relaxed/simple;
	bh=6T8wTmK1c/bVMEmHRiqoAWj+wBZhCiIYy+DHw9DywLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuEZIOMjKXyd2ZMztY2w5xkrThLGGv4ngQE3zoanpAEdujqnZ3wVGakGvLBtzh8Yq97f1zn9gedaBRx/y8ODYBdiR3Z7YHzRBAwu3pONPTRp55B3Gc0fDk5SStyZn3ZmxcONjXUAIwRgXqPy9fqwFx2TP1BH6aQriyUO6IySZSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mrly2IrG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D2AC4CEE3;
	Thu, 17 Jul 2025 13:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752759455;
	bh=6T8wTmK1c/bVMEmHRiqoAWj+wBZhCiIYy+DHw9DywLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mrly2IrGsVF07td0hpdpwDm5dfaMyj8qi5VpkuJIOVWyJsBDykEYH3FYVSni5s1lX
	 C5aNEKToNSqkQhU6cJyndq9XXz394kSMwYpWBM7Q9zjLqt0U5+slJ2Mq191OieIilR
	 WG/h8MiotXBEVEHxmyNuAjCWyj4aGZBUIY0WMmBWdI99iDE45tRAVK3Ely0k3wuLqz
	 MpmeZUqk8YGFnB+bTfMecGzqqf5gTJfFkJY20+8nX0oEQpv17bYvayoEnflxc+QQ66
	 SnQpQI0pbDMchTJJU5aeZYCUnS62WTvm1kqIB9ll0aWm/AYINwgAPoWFGewOFDU4rX
	 BK8Zu4YNV8EHw==
Date: Thu, 17 Jul 2025 16:37:29 +0300
From: Mike Rapoport <rppt@kernel.org>
To: mawupeng <mawupeng1@huawei.com>
Cc: akpm@linux-foundation.org, ardb@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: ignore nomap memory during mirror init
Message-ID: <aHj8mfecDhJJZW1Y@kernel.org>
References: <20250717085723.1875462-1-mawupeng1@huawei.com>
 <aHjQp9zPVPuPyP3B@kernel.org>
 <9688e968-e9af-4143-b550-16c02a0b4ceb@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9688e968-e9af-4143-b550-16c02a0b4ceb@huawei.com>

On Thu, Jul 17, 2025 at 07:06:52PM +0800, mawupeng wrote:
> 
> On 2025/7/17 18:29, Mike Rapoport wrote:
> > On Thu, Jul 17, 2025 at 04:57:23PM +0800, Wupeng Ma wrote:
> >> When memory mirroring is enabled, the BIOS may reserve memory regions
> >> at the start of the physical address space without the MR flag. This will
> >> lead to zone_movable_pfn to be updated to the start of these reserved
> >> regions, resulting in subsequent mirrored memory being ignored.
> >>
> >> Here is the log with efi=debug enabled:
> >>   efi:   0x084004000000-0x0842bf37ffff [Conventional|   |  |MR|...|WB|WT|WC|  ]
> >>   efi:   0x0842bf380000-0x0842c21effff [Loader Code |   |  |MR|...|WB|WT|WC|  ]
> >>   efi:   0x0842c21f0000-0x0847ffffffff [Conventional|   |  |MR|...|WB|WT|WC|  ]
> >>   efi:   0x085000000000-0x085fffffffff [Conventional|   |  |  |...|WB|WT|WC|  ]
> >> ...
> >>   efi:   0x084000000000-0x084003ffffff [Reserved    |   |  |  |...|WB|WT|WC|  ]
> >>
> >> Since this kind of memory can not be used by kernel. ignore nomap memory to fix
> >> this issue.
> 
> Since the first non-mirror pfn of this node is 0x084000000000, then zone_movable_pfn 
> for this node will be updated to this. This will lead to Mirror Region 
>   - 0x084004000000-0x0842bf37ffff
>   - 0x0842bf380000-0x0842c21effff 
>   - 0x0842c21f0000-0x0847ffffffff
> be seen as non-mirror memory since zone_movable_pfn will be the start_pfn of this node
> in adjust_zone_range_for_zone_movable().

What do you mean by "seen as non-mirror memory"?

What is the problem with having movable zone on that node start at
0x084000000000?

Can you post the kernel log up to "Memory: nK/mK available" line for more
context?
 
> So igore nomap memory to fix this problem.
> 
> > 
> > If the memory is nomap it won't be used by the kernel anyway.
> > What's the actual issue you are trying to fix?
> >  
> >> Signed-off-by: Wupeng Ma <mawupeng1@huawei.com>
> >> ---
> >>  mm/mm_init.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/mm/mm_init.c b/mm/mm_init.c
> >> index f2944748f526..1c36518f0fe4 100644
> >> --- a/mm/mm_init.c
> >> +++ b/mm/mm_init.c
> >> @@ -405,7 +405,7 @@ static void __init find_zone_movable_pfns_for_nodes(void)
> >>  		}
> >>  
> >>  		for_each_mem_region(r) {
> >> -			if (memblock_is_mirror(r))
> >> +			if (memblock_is_mirror(r) || memblock_is_nomap(r))
> >>  				continue;
> >>  
> >>  			nid = memblock_get_region_node(r);
> >> -- 
> >> 2.43.0
> >>
> > 
> 

-- 
Sincerely yours,
Mike.


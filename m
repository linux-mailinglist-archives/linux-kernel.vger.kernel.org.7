Return-Path: <linux-kernel+bounces-735074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD99B08A88
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 299CB3BDA38
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 10:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6895F28B417;
	Thu, 17 Jul 2025 10:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAXyXFrd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C747C29A327
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 10:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752748205; cv=none; b=c6ZaCvu/l7DQr9hugudt6R5RK+FWRlQ7YUzM1BT2Gf5nMT+XjsUb3jUdp+94DZX6N441b6GIaM3cGm0eGAEzF7gLgQzSZcZbireZY8STSefZZ2IMIBigOmiAwSAQTAk8D45QPpwDH07E0LM5aIOph1H2tVERe/NC/emBNa6mieo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752748205; c=relaxed/simple;
	bh=3/PF8dpMl5C8SP09gYB2TIgP3XqaOEcppN5FDF8vZdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMElK0+DXhWkXIuTffDvc0WHv+81YVox5AWtN6BqaxnYjk4BJQOJgCpHo0RpWIB2UMro+WbhQ65+KFevE7sEYTjm+THiY+fmEe7sNIi5DWvvam1hHaCHZdvmnJKd/HxtMoguoMP642Y7IpcCFRVfuzMnFm3GubAAYInV4AamzIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAXyXFrd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C95C4CEF0;
	Thu, 17 Jul 2025 10:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752748205;
	bh=3/PF8dpMl5C8SP09gYB2TIgP3XqaOEcppN5FDF8vZdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DAXyXFrdBEECSYvOEYdTsKDb5PaFQQvLIZLOb8Xsk0jhzywbA2YtGNws0RhCsOzUV
	 mdm7uW1l8pLLBPFv1rvTJ76fHQBno0bY5xkStGFJ8aeH6XtLBFDg1xbBxAmhFiJXmE
	 b0ndyn9E4c/zXPM4f2heljIKQGe6NLrdcVx8L8Yaf9LbGsYqPBvIpu488gIB5gQWCm
	 WrIzYAlYUe0qVKXaBPKiLd6c+GF0YLvRxBIAH5HdMoT9i1AWBQPjqQdGE8rr1sWeJs
	 IRombsIGGJxugI0Bu9opQSIpEXFE0oRn4lahKYZkmthYjIO08ylzgsvv1aSoY9GGaU
	 DQnji4mQn7rLg==
Date: Thu, 17 Jul 2025 13:29:59 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Wupeng Ma <mawupeng1@huawei.com>
Cc: akpm@linux-foundation.org, ardb@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: ignore nomap memory during mirror init
Message-ID: <aHjQp9zPVPuPyP3B@kernel.org>
References: <20250717085723.1875462-1-mawupeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717085723.1875462-1-mawupeng1@huawei.com>

On Thu, Jul 17, 2025 at 04:57:23PM +0800, Wupeng Ma wrote:
> When memory mirroring is enabled, the BIOS may reserve memory regions
> at the start of the physical address space without the MR flag. This will
> lead to zone_movable_pfn to be updated to the start of these reserved
> regions, resulting in subsequent mirrored memory being ignored.
> 
> Here is the log with efi=debug enabled:
>   efi:   0x084004000000-0x0842bf37ffff [Conventional|   |  |MR|...|WB|WT|WC|  ]
>   efi:   0x0842bf380000-0x0842c21effff [Loader Code |   |  |MR|...|WB|WT|WC|  ]
>   efi:   0x0842c21f0000-0x0847ffffffff [Conventional|   |  |MR|...|WB|WT|WC|  ]
>   efi:   0x085000000000-0x085fffffffff [Conventional|   |  |  |...|WB|WT|WC|  ]
> ...
>   efi:   0x084000000000-0x084003ffffff [Reserved    |   |  |  |...|WB|WT|WC|  ]
> 
> Since this kind of memory can not be used by kernel. ignore nomap memory to fix
> this issue.

If the memory is nomap it won't be used by the kernel anyway.
What's the actual issue you are trying to fix?
 
> Signed-off-by: Wupeng Ma <mawupeng1@huawei.com>
> ---
>  mm/mm_init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index f2944748f526..1c36518f0fe4 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -405,7 +405,7 @@ static void __init find_zone_movable_pfns_for_nodes(void)
>  		}
>  
>  		for_each_mem_region(r) {
> -			if (memblock_is_mirror(r))
> +			if (memblock_is_mirror(r) || memblock_is_nomap(r))
>  				continue;
>  
>  			nid = memblock_get_region_node(r);
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.


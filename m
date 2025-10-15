Return-Path: <linux-kernel+bounces-854128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD98BDD9BE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67DE64FECE4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352B23128C1;
	Wed, 15 Oct 2025 09:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="bpXnKfq0"
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC422C235F
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760519294; cv=none; b=LjcE3sW6fDhaD3xcVhPa8tvGpZeOCjrO9erZD61aGcbPr5ChGjEOQtDGBAkSryb/lzuSHqCBoWORbNm/0y1e2hqvQHW8HL79NU3DCVZz/4T1udqRbCVLNM5ZoZrCY2YI3uIbQuewE4DTq/JsEtJ5zPEPqNpXBJ2YDB96pyySJ+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760519294; c=relaxed/simple;
	bh=f9GbPlxkk7Vrk1DGWkH9F0TGCh57BpOvUaK8tg/EMdU=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YTGLILR24yFwlMHzSbzLG2IWvYSccuvVj8LvGyZ6r4HlykVGEQS5BEgvzcgWLXxiwaCSVoHDfoigFcl3lkJyhjgL3+BE5mp7cumEKYh55iS2HsndR4SEXbdAYOk0GtmN0IB/0ZJcGZyynLUoWqOTsdeX/++S/8P4+pG1cdK2q/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=bpXnKfq0; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=jBv4vZFGFDoCDQH8BpSpEQDx7bGnlZaAWGhk2rAOOXI=;
	b=bpXnKfq0SoHUJ6hQR1TRkhvV9iciBtK1ANxaaXo3cDcq4Bl+XQaKcdOl0bAJbhbY/HlcNrn7h
	1f9tUm0hCM4d7Ia/bB8LMscvCyAolG+dUY0TomHn+GcWuA6ufCynsMDsESK2EqM+N3Gk6twALkb
	wfqk+r2jkHuQJYaFvlL17oo=
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4cmlbm2Z8yzmV6g;
	Wed, 15 Oct 2025 17:07:48 +0800 (CST)
Received: from kwepemj100016.china.huawei.com (unknown [7.202.194.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 92CCF1A0188;
	Wed, 15 Oct 2025 17:08:08 +0800 (CST)
Received: from [10.174.178.114] (10.174.178.114) by
 kwepemj100016.china.huawei.com (7.202.194.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 15 Oct 2025 17:08:07 +0800
Message-ID: <a5349a28-bf32-4b26-a55f-af53f4c225b8@huawei.com>
Date: Wed, 15 Oct 2025 17:08:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <mawupeng1@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <lorenzo.stoakes@oracle.com>,
	<Liam.Howlett@oracle.com>, <vbabka@suse.cz>, <rppt@kernel.org>,
	<surenb@google.com>, <mhocko@suse.com>, <ziy@nvidia.com>,
	<axelrasmussen@google.com>, <yuanchu@google.com>, <weixugc@google.com>
Subject: Re: [RFC PATCH] mm: vmscan: wakeup kswapd during node_reclaim
To: <akpm@linux-foundation.org>, <david@redhat.com>, <jackmanb@google.com>,
	<hannes@cmpxchg.org>, <zhengqi.arch@bytedance.com>, <shakeel.butt@linux.dev>
References: <20251011062043.772549-1-mawupeng1@huawei.com>
From: mawupeng <mawupeng1@huawei.com>
In-Reply-To: <20251011062043.772549-1-mawupeng1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemj100016.china.huawei.com (7.202.194.10)

Hi Reviewers:
	kindly ping, cc more reviews.
	
On 2025/10/11 14:20, Wupeng Ma wrote:
> During testing, we observed that memory allocation with node_reclaim_mode
> enabled becomes extremely slow when a large allocation is attempted on a
> node whose free memory is mostly occupied by clean page cache.
> 
> The slowness arises because during node reclaim, only direct reclaim-like
> behavior is triggered — recycling only 32 pages at a time — without
> waking kswapd, even when the watermark levels and alloc_flags already
> satisfy the condition to activate kswapd.
> 
> This patch wakes kswapd during node reclaim, allowing background reclaim
> to bring free memory up to the high watermark and avoid excessive node
> reclaim overhead.
> 
> Signed-off-by: Wupeng Ma <mawupeng1@huawei.com>
> ---
>  mm/internal.h   | 14 ++++++++------
>  mm/page_alloc.c |  6 +++++-
>  mm/vmscan.c     | 19 +++++++++++++++++--
>  3 files changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 1561fc2ff5b8..5303123dd0a8 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1196,21 +1196,23 @@ static inline void mminit_verify_zonelist(void)
>  }
>  #endif /* CONFIG_DEBUG_MEMORY_INIT */
>  
> -#define NODE_RECLAIM_NOSCAN	-2
> -#define NODE_RECLAIM_FULL	-1
> -#define NODE_RECLAIM_SOME	0
> -#define NODE_RECLAIM_SUCCESS	1
> +#define NODE_RECLAIM_NOSCAN		-2
> +#define NODE_RECLAIM_FULL		-1
> +#define NODE_RECLAIM_SOME		0
> +#define NODE_RECLAIM_SUCCESS		1
> +#define NODE_RECLAIM_KSWAPD_SUCCESS	2
>  
>  #ifdef CONFIG_NUMA
>  extern int node_reclaim_mode;
>  
> -extern int node_reclaim(struct pglist_data *, gfp_t, unsigned int);
> +int node_reclaim(struct pglist_data *pgdat, gfp_t mask, unsigned int order,
> +		 int alloc_flags, struct zone *zone);
>  extern int find_next_best_node(int node, nodemask_t *used_node_mask);
>  #else
>  #define node_reclaim_mode 0
>  
>  static inline int node_reclaim(struct pglist_data *pgdat, gfp_t mask,
> -				unsigned int order)
> +		unsigned int order, int alloc_flags, struct zone *zone)
>  {
>  	return NODE_RECLAIM_NOSCAN;
>  }
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 600d9e981c23..2472000cab78 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3859,7 +3859,8 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
>  			    !zone_allows_reclaim(zonelist_zone(ac->preferred_zoneref), zone))
>  				continue;
>  
> -			ret = node_reclaim(zone->zone_pgdat, gfp_mask, order);
> +			ret = node_reclaim(zone->zone_pgdat, gfp_mask, order,
> +					   alloc_flags, zone);
>  			switch (ret) {
>  			case NODE_RECLAIM_NOSCAN:
>  				/* did not scan */
> @@ -3867,6 +3868,9 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
>  			case NODE_RECLAIM_FULL:
>  				/* scanned but unreclaimable */
>  				continue;
> +			case NODE_RECLAIM_KSWAPD_SUCCESS:
> +				/* kswapd reclaim enough */
> +				goto try_this_zone;
>  			default:
>  				/* did we reclaim enough */
>  				if (zone_watermark_ok(zone, order, mark,
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index b2fc8b626d3d..ebee8b6330a8 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -7680,9 +7680,11 @@ static unsigned long __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask,
>  	return sc->nr_reclaimed;
>  }
>  
> -int node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned int order)
> +int node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned int order,
> +		 int alloc_flags, struct zone *zone)
>  {
>  	int ret;
> +	enum zone_type highest_zoneidx = gfp_zone(gfp_mask);
>  	/* Minimum pages needed in order to stay on node */
>  	const unsigned long nr_pages = 1 << order;
>  	struct scan_control sc = {
> @@ -7693,7 +7695,7 @@ int node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned int order)
>  		.may_writepage = !!(node_reclaim_mode & RECLAIM_WRITE),
>  		.may_unmap = !!(node_reclaim_mode & RECLAIM_UNMAP),
>  		.may_swap = 1,
> -		.reclaim_idx = gfp_zone(gfp_mask),
> +		.reclaim_idx = highest_zoneidx,
>  	};
>  
>  	/*
> @@ -7729,6 +7731,19 @@ int node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned int order)
>  	if (test_and_set_bit_lock(PGDAT_RECLAIM_LOCKED, &pgdat->flags))
>  		return NODE_RECLAIM_NOSCAN;
>  
> +	if (alloc_flags & ALLOC_KSWAPD) {
> +		unsigned long mark;
> +
> +		wakeup_kswapd(zone, gfp_mask, order, highest_zoneidx);
> +
> +		mark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
> +		if (zone_watermark_ok(zone, order, mark, highest_zoneidx,
> +					alloc_flags)) {
> +			clear_bit_unlock(PGDAT_RECLAIM_LOCKED, &pgdat->flags);
> +			return NODE_RECLAIM_KSWAPD_SUCCESS;
> +		}
> +	}
> +
>  	ret = __node_reclaim(pgdat, gfp_mask, nr_pages, &sc) >= nr_pages;
>  	clear_bit_unlock(PGDAT_RECLAIM_LOCKED, &pgdat->flags);
>  



Return-Path: <linux-kernel+bounces-734555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DDEB08315
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 04:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F00521C25CEA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 02:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347721B3923;
	Thu, 17 Jul 2025 02:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XJPs6PiY"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35473DDAB
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 02:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752720394; cv=none; b=QioasA6yXvaKc1K+HLSJQndWyR3oYwV6/wIYCLvriFjEuhCQwajkJzQ1h/phVoJKIYFL7yOLpxdnDY8FmdOsXVQWkliL7IT959cyr/bv1QDAr0283UkcDynDLC+sfxNVVC8gnlBhVQuLXrYaPxsBcl3j6ZyTGKpIr1GIeKlzU6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752720394; c=relaxed/simple;
	bh=Q/ouETWgslrwXHAXOw5qr8Kna1AWuja4TwnLS+6DVDQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DMmEcaY3pPQeurDAGqCAGWnTBrQwEEz6xUFl/aNfXGEjaDCiLfr0KlJgPfQuBb+We+GkNVWFBfEfK6Ogubu9Kq6ZZ7pcB3qPKb6UtNcKlD2sZSg6GCnoHCQbo1/OGkAbdyEeSGefODJ49c/TYXNE97zjHHg6YqnGQI0W6WQAmq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XJPs6PiY; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752720390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JUo2hVC0vs4MzvmEw2bHFnvQ8HrEIxLo4ilwAk5EHtw=;
	b=XJPs6PiYxmBPjijpeWEaTev+QLaMW6mCVfn42eERr8lpYlFc0mJJVS3SDaR44+veAJwINi
	LQtpsW3ovJKeIJFz/c1Kjt3gbgj9TVOkbFsRUDduVxunjmdSdg9CWyXj8Ctbde5kSqE3/I
	ZuM+H4Rz4xTIyTGWvbOd6F0JvdkwyRU=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: akpm@linux-foundation.org,  mhocko@kernel.org,  hannes@cmpxchg.org,
  shakeel.butt@linux.dev,  yosryahmed@google.com,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] mm: introduce per-node proactive reclaim interface
In-Reply-To: <20250623185851.830632-5-dave@stgolabs.net> (Davidlohr Bueso's
	message of "Mon, 23 Jun 2025 11:58:51 -0700")
References: <20250623185851.830632-1-dave@stgolabs.net>
	<20250623185851.830632-5-dave@stgolabs.net>
Date: Wed, 16 Jul 2025 19:46:25 -0700
Message-ID: <87qzyfr0u6.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Davidlohr Bueso <dave@stgolabs.net> writes:

> This adds support for allowing proactive reclaim in general on a
> NUMA system. A per-node interface extends support for beyond a
> memcg-specific interface, respecting the current semantics of
> memory.reclaim: respecting aging LRU and not supporting
> artificially triggering eviction on nodes belonging to non-bottom
> tiers.
>
> This patch allows userspace to do:
>
>      echo "512M swappiness=10" > /sys/devices/system/node/nodeX/reclaim
>
> One of the premises for this is to semantically align as best as
> possible with memory.reclaim. During a brief time memcg did
> support nodemask until 55ab834a86a9 (Revert "mm: add nodes=
> arg to memory.reclaim"), for which semantics around reclaim
> (eviction) vs demotion were not clear, rendering charging
> expectations to be broken.
>
> With this approach:
>
> 1. Users who do not use memcg can benefit from proactive reclaim.
> The memcg interface is not NUMA aware and there are usecases that
> are focusing on NUMA balancing rather than workload memory footprint.
>
> 2. Proactive reclaim on top tiers will trigger demotion, for which
> memory is still byte-addressable. Reclaiming on the bottom nodes
> will trigger evicting to swap (the traditional sense of reclaim).
> This follows the semantics of what is today part of the aging process
> on tiered memory, mirroring what every other form of reclaim does
> (reactive and memcg proactive reclaim). Furthermore per-node proactive
> reclaim is not as susceptible to the memcg charging problem mentioned
> above.
>
> 3. Unlike the nodes= arg, this interface avoids confusing semantics,
> such as what exactly the user wants when mixing top-tier and low-tier
> nodes in the nodemask. Further per-node interface is less exposed to
> "free up memory in my container" usecases, where eviction is intended.
>
> 4. Users that *really* want to free up memory can use proactive reclaim
> on nodes knowingly to be on the bottom tiers to force eviction in a
> natural way - higher access latencies are still better than swap.
> If compelled, while no guarantees and perhaps not worth the effort,
> users could also also potentially follow a ladder-like approach to
> eventually free up the memory. Alternatively, perhaps an 'evict' option
> could be added to the parameters for both memory.reclaim and per-node
> interfaces to force this action unconditionally.
>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

small nit below

> ---
>  Documentation/ABI/stable/sysfs-devices-node |  9 ++++
>  drivers/base/node.c                         |  2 +
>  include/linux/swap.h                        | 16 +++++++
>  mm/vmscan.c                                 | 53 ++++++++++++++++++---
>  4 files changed, 74 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
> index a02707cb7cbc..2d0e023f22a7 100644
> --- a/Documentation/ABI/stable/sysfs-devices-node
> +++ b/Documentation/ABI/stable/sysfs-devices-node
> @@ -227,3 +227,12 @@ Contact:	Jiaqi Yan <jiaqiyan@google.com>
>  Description:
>  		Of the raw poisoned pages on a NUMA node, how many pages are
>  		recovered by memory error recovery attempt.
> +
> +What:		/sys/devices/system/node/nodeX/reclaim
> +Date:		June 2025
> +Contact:	Linux Memory Management list <linux-mm@kvack.org>
> +Description:
> +		Perform user-triggered proactive reclaim on a NUMA node.
> +		This interface is equivalent to the memcg variant.
> +
> +		See Documentation/admin-guide/cgroup-v2.rst
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 6d66382dae65..548b532a2129 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -659,6 +659,7 @@ static int register_node(struct node *node, int num)
>  	} else {
>  		hugetlb_register_node(node);
>  		compaction_register_node(node);
> +		reclaim_register_node(node);
>  	}
>  
>  	return error;
> @@ -675,6 +676,7 @@ void unregister_node(struct node *node)
>  {
>  	hugetlb_unregister_node(node);
>  	compaction_unregister_node(node);
> +	reclaim_unregister_node(node);
>  	node_remove_accesses(node);
>  	node_remove_caches(node);
>  	device_unregister(&node->dev);
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index bc0e1c275fc0..dac7ba98783d 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -431,6 +431,22 @@ extern unsigned long shrink_all_memory(unsigned long nr_pages);
>  extern int vm_swappiness;
>  long remove_mapping(struct address_space *mapping, struct folio *folio);
>  
> +#if defined(CONFIG_SYSFS) && defined(CONFIG_NUMA)
> +extern int reclaim_register_node(struct node *node);
> +extern void reclaim_unregister_node(struct node *node);
> +
> +#else
> +
> +static inline int reclaim_register_node(struct node *node)
> +{
> +	return 0;
> +}
> +
> +static inline void reclaim_unregister_node(struct node *node)
> +{
> +}
> +#endif /* CONFIG_SYSFS && CONFIG_NUMA */
> +
>  #ifdef CONFIG_NUMA
>  extern int sysctl_min_unmapped_ratio;
>  extern int sysctl_min_slab_ratio;
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index cdd9cb97fb79..f77feb75c678 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -94,10 +94,8 @@ struct scan_control {
>  	unsigned long	anon_cost;
>  	unsigned long	file_cost;
>  
> -#ifdef CONFIG_MEMCG
>  	/* Swappiness value for proactive reclaim. Always use sc_swappiness()! */
>  	int *proactive_swappiness;
> -#endif
>  
>  	/* Can active folios be deactivated as part of reclaim? */
>  #define DEACTIVATE_ANON 1
> @@ -121,7 +119,7 @@ struct scan_control {
>  	/* Has cache_trim_mode failed at least once? */
>  	unsigned int cache_trim_mode_failed:1;
>  
> -	/* Proactive reclaim invoked by userspace through memory.reclaim */
> +	/* Proactive reclaim invoked by userspace */
>  	unsigned int proactive:1;
>  
>  	/*
> @@ -7732,13 +7730,15 @@ static const match_table_t tokens = {
>  	{ MEMORY_RECLAIM_NULL, NULL },
>  };
>  
> -int user_proactive_reclaim(char *buf, struct mem_cgroup *memcg, pg_data_t *pgdat)
> +int user_proactive_reclaim(char *buf,
> +			   struct mem_cgroup *memcg, pg_data_t *pgdat)
>  {
>  	unsigned int nr_retries = MAX_RECLAIM_RETRIES;
>  	unsigned long nr_to_reclaim, nr_reclaimed = 0;
>  	int swappiness = -1;
>  	char *old_buf, *start;
>  	substring_t args[MAX_OPT_ARGS];
> +	gfp_t gfp_mask = GFP_KERNEL;
>  
>  	if (!buf || (!memcg && !pgdat))
>  		return -EINVAL;
> @@ -7792,11 +7792,29 @@ int user_proactive_reclaim(char *buf, struct mem_cgroup *memcg, pg_data_t *pgdat
>  			reclaim_options = MEMCG_RECLAIM_MAY_SWAP |
>  					  MEMCG_RECLAIM_PROACTIVE;
>  			reclaimed = try_to_free_mem_cgroup_pages(memcg,
> -						 batch_size, GFP_KERNEL,
> +						 batch_size, gfp_mask,
>  						 reclaim_options,
>  						 swappiness == -1 ? NULL : &swappiness);
>  		} else {
> -			return -EINVAL;
> +			struct scan_control sc = {
> +				.gfp_mask = current_gfp_context(gfp_mask),
> +				.reclaim_idx = gfp_zone(gfp_mask),
> +				.proactive_swappiness = swappiness == -1 ? NULL : &swappiness,
> +				.priority = DEF_PRIORITY,
> +				.may_writepage = !laptop_mode,
> +				.nr_to_reclaim = max(batch_size, SWAP_CLUSTER_MAX),
> +				.may_unmap = 1,
> +				.may_swap = 1,
> +				.proactive = 1,
> +			};
> +
> +			if (test_and_set_bit_lock(PGDAT_RECLAIM_LOCKED,
> +						  &pgdat->flags))
> +				return -EAGAIN;

Isn't EBUSY a better choice here?
At least to distinguish between no reclaimable memory left and
somebody else is abusing the same interface cases.


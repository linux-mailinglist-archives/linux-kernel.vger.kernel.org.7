Return-Path: <linux-kernel+bounces-839750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03936BB251D
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 04:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 674CA7AD1D4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 01:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6CB78F2B;
	Thu,  2 Oct 2025 02:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oSCc68e7"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBB954652
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 02:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759370452; cv=none; b=MnWqZsdtaVS4IMmQAcF4r+pW3MjMXKDC0a9hKQnMUVXMgxJUXv9RsW9coopXm7XX0wP6NLLkTGJcUd1pRg76LLg1Dzv6Cz4buM9dtPeGVQBuAAFBSVTmlVYkfI9Onv69XtUvpp6ZQ60V1gUo8yqGaKBQU5vLzUkR+ueSt4IKULg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759370452; c=relaxed/simple;
	bh=Va3UCHtqIP7o2Z+B/RwGNWzKZeGXXDyESgzg0NjZeZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qJM7hoc1eOvFfWFoHVWrCwm5OjORFTnjXzypjOD9tit6gUKDpp2Ox8xMLMBn99OmreKzRopbkHiJO9sZnMvR8wV03ucrHK1EKq1Mw7v8g/KD16VdojCGVK9LodBe2CfCqdGLEPp2yunu0Q2ZAsR5kDUrqzkaMH2Th8u1USNJAZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oSCc68e7; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7afdf764-35f4-47fb-9a26-14aba34ec1f2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759370446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7HMd5BXDmBs6kaRh+x8jnIISHs12jMw6ZyMyiwHHdes=;
	b=oSCc68e7KGmydUHYLfzlMlHBIAB4Zar/wunLVZUs1nwRE6om5Qp6TZA53LAGcD78L3yI8B
	MQS8sAfupFVYWVGc9FjaIyLZYCAdoSc2ue8ptzYT/+VobyO1RKblwn2ipDYYJwdurH8aME
	IFYwSd9O0YJgQgB5plCjN9bgun3DBNc=
Date: Thu, 2 Oct 2025 10:00:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] mm/page_owner: simplify zone iteration logic in
 init_early_allocated_pages()
To: Hu Song <husong@kylinos.cn>, Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250930092153.843109-1-husong@kylinos.cn>
 <20250930092153.843109-2-husong@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ye Liu <ye.liu@linux.dev>
In-Reply-To: <20250930092153.843109-2-husong@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/9/30 17:21, Hu Song 写道:
> From: Song Hu <husong@kylinos.cn>
>
> The current implementation uses nested loops: first iterating over all
> online nodes, then over zones within each node. This can be simplified
> by using the for_each_populated_zone() macro which directly iterates
> through all populated zones.
>
> This change:
> 1. Removes the intermediate init_zones_in_node() function
> 2. Simplifies init_early_allocated_pages() to use direct zone iteration
> 3. Updates init_pages_in_zone() to take only zone parameter and access
>    node_id via zone->zone_pgdat
>
> The functionality remains identical, but the code is cleaner and more
> maintainable.
>
> Signed-off-by: Song Hu <husong@kylinos.cn>


Reviewed-by: Ye Liu <liuye@kylinos.cn>

> ---
>  mm/page_owner.c | 23 +++++------------------
>  1 file changed, 5 insertions(+), 18 deletions(-)
>
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index bb88b72b6062..b170b27d87a1 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -757,7 +757,7 @@ static loff_t lseek_page_owner(struct file *file, loff_t offset, int orig)
>  	return file->f_pos;
>  }
>  
> -static void init_pages_in_zone(pg_data_t *pgdat, struct zone *zone)
> +static void init_pages_in_zone(struct zone *zone)
>  {
>  	unsigned long pfn = zone->zone_start_pfn;
>  	unsigned long end_pfn = zone_end_pfn(zone);
> @@ -824,28 +824,15 @@ static void init_pages_in_zone(pg_data_t *pgdat, struct zone *zone)
>  	}
>  
>  	pr_info("Node %d, zone %8s: page owner found early allocated %lu pages\n",
> -		pgdat->node_id, zone->name, count);
> -}
> -
> -static void init_zones_in_node(pg_data_t *pgdat)
> -{
> -	struct zone *zone;
> -	struct zone *node_zones = pgdat->node_zones;
> -
> -	for (zone = node_zones; zone - node_zones < MAX_NR_ZONES; ++zone) {
> -		if (!populated_zone(zone))
> -			continue;
> -
> -		init_pages_in_zone(pgdat, zone);
> -	}
> +		zone->zone_pgdat->node_id, zone->name, count);
>  }
>  
>  static void init_early_allocated_pages(void)
>  {
> -	pg_data_t *pgdat;
> +	struct zone *zone;
>  
> -	for_each_online_pgdat(pgdat)
> -		init_zones_in_node(pgdat);
> +	for_each_populated_zone(zone)
> +		init_pages_in_zone(zone);
>  }
>  
>  static const struct file_operations page_owner_fops = {

-- 
Thanks,
Ye Liu



Return-Path: <linux-kernel+bounces-841268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D186BB6AC6
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 14:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6222E189DBDF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 12:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DBD2EDD58;
	Fri,  3 Oct 2025 12:38:26 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A5C224AF2
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 12:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759495106; cv=none; b=qIh3UODl7onc5IGynzBkq/uk4jwpSNlLR85IHoajtLunBFd0beQJluJL5yLbIn6hb0rlk19XvcQzPuTGGZXAMXCUTVUs980ClL95RB+MzLTSwEvlt4/QUHwxwRDVZjF2ktfzmGVrhMizQNobxVyarbQhzYx8+C7++HLTfEhSeCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759495106; c=relaxed/simple;
	bh=uqIjr+IVXcLaQTN0F5ryEe9fYrE4OYJFlY+mWUcOP98=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iV/AmBQTMNMNDcAqyFJhH/5hLFwpWLgsuyMSwLMq5vjDjaeDNhuqG7s5/+eJYnZ7/2S4WSDFBITO8Ykau6PbbJcBez7tR1P6OnCxfPxRbgnp/jwp3ySfLwj0nVWO4XOqMZkA/EPf/Hn0IVCiZhe402eSas/74d3NLmm309D2Aj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cdSmY5XHdz6K8wc;
	Fri,  3 Oct 2025 20:35:09 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 1EC7F14038F;
	Fri,  3 Oct 2025 20:38:21 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 3 Oct
 2025 13:38:19 +0100
Date: Fri, 3 Oct 2025 13:38:18 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Bharata B Rao <bharata@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<dave.hansen@intel.com>, <gourry@gourry.net>, <hannes@cmpxchg.org>,
	<mgorman@techsingularity.net>, <mingo@redhat.com>, <peterz@infradead.org>,
	<raghavendra.kt@amd.com>, <riel@surriel.com>, <rientjes@google.com>,
	<sj@kernel.org>, <weixugc@google.com>, <willy@infradead.org>,
	<ying.huang@linux.alibaba.com>, <ziy@nvidia.com>, <dave@stgolabs.net>,
	<nifan.cxl@gmail.com>, <xuezhengchu@huawei.com>, <yiannis@zptcorp.com>,
	<akpm@linux-foundation.org>, <david@redhat.com>, <byungchul@sk.com>,
	<kinseyho@google.com>, <joshua.hahnjy@gmail.com>, <yuanchu@google.com>,
	<balbirs@nvidia.com>, <alok.rathore@samsung.com>
Subject: Re: [RFC PATCH v2 8/8] mm: sched: Move hot page promotion from
 NUMAB=2 to kpromoted
Message-ID: <20251003133818.000017af@huawei.com>
In-Reply-To: <20250910144653.212066-9-bharata@amd.com>
References: <20250910144653.212066-1-bharata@amd.com>
	<20250910144653.212066-9-bharata@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 10 Sep 2025 20:16:53 +0530
Bharata B Rao <bharata@amd.com> wrote:

> Currently hot page promotion (NUMA_BALANCING_MEMORY_TIERING
> mode of NUMA Balancing) does hot page detection (via hint faults),
> hot page classification and eventual promotion, all by itself and
> sits within the scheduler.
> 
> With the new hot page tracking and promotion mechanism being
> available, NUMA Balancing can limit itself to detection of
> hot pages (via hint faults) and off-load rest of the
> functionality to the common hot page tracking system.
> 
> pghot_record_access(PGHOT_HINT_FAULT) API is used to feed the
> hot page info. In addition, the migration rate limiting and
> dynamic threshold logic are moved to kpromoted so that the same
> can be used for hot pages reported by other sources too.
> 
> Signed-off-by: Bharata B Rao <bharata@amd.com>

Making a direct replacement without any fallback to previous method
is going to need a lot of data to show there are no important regressions.

So bold move if that's the intent! 

J
> ---
>  include/linux/pghot.h |   2 +
>  kernel/sched/fair.c   | 149 ++----------------------------------------
>  mm/memory.c           |  32 ++-------
>  mm/pghot.c            | 132 +++++++++++++++++++++++++++++++++++--
>  4 files changed, 142 insertions(+), 173 deletions(-)
> 

> diff --git a/mm/pghot.c b/mm/pghot.c
> index 9f7581818b8f..9f5746892bce 100644
> --- a/mm/pghot.c
> +++ b/mm/pghot.c
> @@ -9,6 +9,9 @@
>   *
>   * kpromoted is a kernel thread that runs on each toptier node and
>   * promotes pages from max_heap.
> + *
> + * Migration rate-limiting and dynamic threshold logic implementations
> + * were moved from NUMA Balancing mode 2.
>   */
>  #include <linux/pghot.h>
>  #include <linux/kthread.h>
> @@ -34,6 +37,9 @@ static bool kpromoted_started __ro_after_init;
>  
>  static unsigned int sysctl_pghot_freq_window = KPROMOTED_FREQ_WINDOW;
>  
> +/* Restrict the NUMA promotion throughput (MB/s) for each target node. */
> +static unsigned int sysctl_pghot_promote_rate_limit = 65536;

If the comment correlates with the value, this is 64 GiB/s?  That seems
unlikely if I guess possible.

> +
>  #ifdef CONFIG_SYSCTL
>  static const struct ctl_table pghot_sysctls[] = {
>  	{
> @@ -44,8 +50,17 @@ static const struct ctl_table pghot_sysctls[] = {
>  		.proc_handler	= proc_dointvec_minmax,
>  		.extra1		= SYSCTL_ZERO,
>  	},
> +	{
> +		.procname	= "pghot_promote_rate_limit_MBps",
> +		.data		= &sysctl_pghot_promote_rate_limit,
> +		.maxlen		= sizeof(unsigned int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +	},
>  };
>  #endif
> +
Put that in earlier patch to reduce noise here.

>  static bool phi_heap_less(const void *lhs, const void *rhs, void *args)
>  {
>  	return (*(struct pghot_info **)lhs)->frequency >
> @@ -94,11 +109,99 @@ static bool phi_heap_insert(struct max_heap *phi_heap, struct pghot_info *phi)
>  	return true;
>  }
>  
> +/*
> + * For memory tiering mode, if there are enough free pages (more than
> + * enough watermark defined here) in fast memory node, to take full

I'd use enough_wmark   Just because "more than enough" is a common
English phrase and I at least tripped over that sentence as a result!

> + * advantage of fast memory capacity, all recently accessed slow
> + * memory pages will be migrated to fast memory node without
> + * considering hot threshold.
> + */
> +static bool pgdat_free_space_enough(struct pglist_data *pgdat)
> +{
> +	int z;
> +	unsigned long enough_wmark;
> +
> +	enough_wmark = max(1UL * 1024 * 1024 * 1024 >> PAGE_SHIFT,
> +			   pgdat->node_present_pages >> 4);
> +	for (z = pgdat->nr_zones - 1; z >= 0; z--) {
> +		struct zone *zone = pgdat->node_zones + z;
> +
> +		if (!populated_zone(zone))
> +			continue;
> +
> +		if (zone_watermark_ok(zone, 0,
> +				      promo_wmark_pages(zone) + enough_wmark,
> +				      ZONE_MOVABLE, 0))
> +			return true;
> +	}
> +	return false;
> +}

> +
> +static void kpromoted_promotion_adjust_threshold(struct pglist_data *pgdat,

Needs documentation of the algorithm and the reasons for various choices.

I see it is a code move though so maybe that's a job for another day.

> +						 unsigned long rate_limit,
> +						 unsigned int ref_th,
> +						 unsigned long now)
> +{
> +	unsigned int start, th_period, unit_th, th;
> +	unsigned long nr_cand, ref_cand, diff_cand;
> +
> +	now = jiffies_to_msecs(now);
> +	th_period = KPROMOTED_PROMOTION_THRESHOLD_WINDOW;
> +	start = pgdat->nbp_th_start;
> +	if (now - start > th_period &&
> +	    cmpxchg(&pgdat->nbp_th_start, start, now) == start) {
> +		ref_cand = rate_limit *
> +			KPROMOTED_PROMOTION_THRESHOLD_WINDOW / MSEC_PER_SEC;
> +		nr_cand = node_page_state(pgdat, PGPROMOTE_CANDIDATE);
> +		diff_cand = nr_cand - pgdat->nbp_th_nr_cand;
> +		unit_th = ref_th * 2 / KPROMOTED_MIGRATION_ADJUST_STEPS;
> +		th = pgdat->nbp_threshold ? : ref_th;
> +		if (diff_cand > ref_cand * 11 / 10)
> +			th = max(th - unit_th, unit_th);
> +		else if (diff_cand < ref_cand * 9 / 10)
> +			th = min(th + unit_th, ref_th * 2);
> +		pgdat->nbp_th_nr_cand = nr_cand;
> +		pgdat->nbp_threshold = th;
> +	}
> +}
 +
>  static bool phi_is_pfn_hot(struct pghot_info *phi)
>  {
>  	struct page *page = pfn_to_online_page(phi->pfn);
> -	unsigned long now = jiffies;
>  	struct folio *folio;
> +	struct pglist_data *pgdat;
> +	unsigned long rate_limit;
> +	unsigned int latency, th, def_th;
> +	unsigned long now = jiffies;
>  
Avoid the reorder.  Just put it here in first place if you prefer this.





Return-Path: <linux-kernel+bounces-743454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B64B0FEDD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 04:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5E661CC2712
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 02:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA93C1A38F9;
	Thu, 24 Jul 2025 02:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="hnTrK6aU"
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0960413A41F
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 02:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753324798; cv=none; b=BdosNrmXoYJb8R4dOHQS3nIwIn/shGHK0lnpb4IUjHYwf3yHU8y2dlrDnBIOdLohdolXsmE/4vNt9xzzd+3xWagbOsOX2uDN0dcnsjPVs5Kbb53y0U3oArZ8Dgzd26rInM6CSGce7vpryXGOwX/V3cIW9mtowt/xL7vqXkf3kQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753324798; c=relaxed/simple;
	bh=uPlh/YWX4gV2j+/e8PX8tFDcfpt6QXFzRYCQvBZYddQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XaOkURKRWps9V0YRPQHfymy6sywh1xFP76fz60FXvM/N1M8hSMcJoXQopSFeQS9mXo9REyer2C+3YPP24b4AihLvIbNGLIP+0z/QWWEb85o8uFTJPmUDOJA/mYFJTy316le9B+5V7XJ/t1lbHWHE3hc7bOK1EtKxwwPGuomsKkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=hnTrK6aU; arc=none smtp.client-ip=139.138.36.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1753324796; x=1784860796;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uPlh/YWX4gV2j+/e8PX8tFDcfpt6QXFzRYCQvBZYddQ=;
  b=hnTrK6aUt/a+R5BeX06rR8iWkdNRxqLEdl0WMfKn9l9BkXHzgnbEq/RS
   O2aJBuGSvTzAetcYK5gGhlhnUmbpoTa6c2qIxrxnLLBgesKkFnHR9ThrC
   LqzDaNIkSjsV3WRVYlh+5l3+VAI9kjs39IreNUaZ7Jlm0w87vx5/BFzKw
   pZfohus0KYaE6bTFo76CZiKYu019VQ65Cq02QPQ53PImMj7TRsYk6ZzrD
   fFxxh5pRvOCdiW9q93M9m2xXGLHnRhxU0ywTrEhgMJO4CF7T22q4sgDWi
   lx34N1CVWmLVXWHLnsk0qBbF3lRpiyAZlzN9kVPS5loTLU8fkObe4cFvT
   w==;
X-CSE-ConnectionGUID: P2LuWKqKRvihFbcbtRInRg==
X-CSE-MsgGUID: bpaWRR2RTNOHeBwBjZTLYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="194633424"
X-IronPort-AV: E=Sophos;i="6.16,336,1744038000"; 
   d="scan'208";a="194633424"
Received: from unknown (HELO az2nlsmgr4.o.css.fujitsu.com) ([20.61.8.234])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 11:39:51 +0900
Received: from az2nlsmgm4.fujitsu.com (unknown [10.150.26.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgr4.o.css.fujitsu.com (Postfix) with ESMTPS id 327B142A307
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 02:39:51 +0000 (UTC)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm4.fujitsu.com (Postfix) with ESMTPS id 95E301000380
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 02:39:50 +0000 (UTC)
Received: from [192.168.22.105] (unknown [10.167.135.81])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id C9EC11A000B;
	Thu, 24 Jul 2025 10:39:40 +0800 (CST)
Message-ID: <85d83be2-02f8-4ef6-91c7-ff920e47d834@fujitsu.com>
Date: Thu, 24 Jul 2025 10:39:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3] mm: memory-tiering: Fix PGPROMOTE_CANDIDATE
 counting
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, lkp@intel.com,
 akpm@linux-foundation.org, y-goto@fujitsu.com, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
 vschneid@redhat.com, Li Zhijian <lizhijian@fujitsu.com>,
 Ben Segall <bsegall@google.com>
References: <20250722141650.1821721-1-ruansy.fnst@fujitsu.com>
 <87cy9r38ny.fsf@DESKTOP-5N7EMDA>
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <87cy9r38ny.fsf@DESKTOP-5N7EMDA>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/23 11:09, Huang, Ying 写道:
> Ruan Shiyang <ruansy.fnst@fujitsu.com> writes:
> 
>> From: Li Zhijian <lizhijian@fujitsu.com>
>>
>> ===
>> Changes since v2:
>>    1. According to Huang's suggestion, add a new stat to not count these
>>    pages into PGPROMOTE_CANDIDATE, to avoid changing the rate limit
>>    mechanism.
>> ===
> 
> This isn't the popular place for changelog, please refer to other patch
> email.

OK. I'll move this part down below.>
>> Goto-san reported confusing pgpromote statistics where the
>> pgpromote_success count significantly exceeded pgpromote_candidate.
>>
>> On a system with three nodes (nodes 0-1: DRAM 4GB, node 2: NVDIMM 4GB):
>>   # Enable demotion only
>>   echo 1 > /sys/kernel/mm/numa/demotion_enabled
>>   numactl -m 0-1 memhog -r200 3500M >/dev/null &
>>   pid=$!
>>   sleep 2
>>   numactl memhog -r100 2500M >/dev/null &
>>   sleep 10
>>   kill -9 $pid # terminate the 1st memhog
>>   # Enable promotion
>>   echo 2 > /proc/sys/kernel/numa_balancing
>>
>> After a few seconds, we observeed `pgpromote_candidate < pgpromote_success`
>> $ grep -e pgpromote /proc/vmstat
>> pgpromote_success 2579
>> pgpromote_candidate 0
>>
>> In this scenario, after terminating the first memhog, the conditions for
>> pgdat_free_space_enough() are quickly met, and triggers promotion.
>> However, these migrated pages are only counted for in PGPROMOTE_SUCCESS,
>> not in PGPROMOTE_CANDIDATE.
>>
>> To solve this confusing statistics, introduce this
>> PGPROMOTE_CANDIDATE_NOLIMIT to count the missed promotion pages.  And
>> also, not counting these pages into PGPROMOTE_CANDIDATE is to avoid
>> changing the existing algorithm or performance of the promotion rate
>> limit.
>>
>> Perhaps PGPROMOTE_CANDIDATE_NOLIMIT is not well named, please comment if
>> you have a better idea.
> 
> Yes.  Naming is hard.  I guess that the name comes from the promotion
> that isn't rate limited.  I have asked Deepseek that what is the good
> abbreviation for "not rate limited".  Its answer is "NRL".  I don't know
> whether it's good.  However, "NOT_RATE_LIMITED" appears too long.

"NRL" Sounds good to me.

I'm thinking another one: since it's not rate limited, it could be 
migrated quickly/fast.  How about PGPROMOTE_CANDIDATE_FAST?


> 
>>
>>
> 
> The empty line is unnecessary.

OK.>
>> Cc: Huang Ying <ying.huang@linux.alibaba.com>
> 
> Suggested-by: Huang Ying <ying.huang@linux.alibaba.com>

OK.


--
Thanks,
Ruan.

> 
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Juri Lelli <juri.lelli@redhat.com>
>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Ben Segall <bsegall@google.com>
>> Cc: Mel Gorman <mgorman@suse.de>
>> Cc: Valentin Schneider <vschneid@redhat.com>
>> Reported-by: Yasunori Gotou (Fujitsu) <y-goto@fujitsu.com>
>> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
>> Signed-off-by: Ruan Shiyang <ruansy.fnst@fujitsu.com>
>> ---
>>   include/linux/mmzone.h | 2 ++
>>   kernel/sched/fair.c    | 6 ++++--
>>   mm/vmstat.c            | 1 +
>>   3 files changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>> index 283913d42d7b..6216e2eecf3b 100644
>> --- a/include/linux/mmzone.h
>> +++ b/include/linux/mmzone.h
>> @@ -231,6 +231,8 @@ enum node_stat_item {
>>   #ifdef CONFIG_NUMA_BALANCING
>>   	PGPROMOTE_SUCCESS,	/* promote successfully */
>>   	PGPROMOTE_CANDIDATE,	/* candidate pages to promote */
>> +	PGPROMOTE_CANDIDATE_NOLIMIT,	/* candidate pages without considering
>> +					 * hot threshold */
>>   #endif
>>   	/* PGDEMOTE_*: pages demoted */
>>   	PGDEMOTE_KSWAPD,
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 7a14da5396fb..12dac3519c49 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -1940,11 +1940,14 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
>>   		struct pglist_data *pgdat;
>>   		unsigned long rate_limit;
>>   		unsigned int latency, th, def_th;
>> +		long nr = folio_nr_pages(folio);
>>   
>>   		pgdat = NODE_DATA(dst_nid);
>>   		if (pgdat_free_space_enough(pgdat)) {
>>   			/* workload changed, reset hot threshold */
>>   			pgdat->nbp_threshold = 0;
>> +			mod_node_page_state(pgdat, PGPROMOTE_CANDIDATE_NOLIMIT,
>> +					    nr);
>>   			return true;
>>   		}
>>   
>> @@ -1958,8 +1961,7 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
>>   		if (latency >= th)
>>   			return false;
>>   
>> -		return !numa_promotion_rate_limit(pgdat, rate_limit,
>> -						  folio_nr_pages(folio));
>> +		return !numa_promotion_rate_limit(pgdat, rate_limit, nr);
>>   	}
>>   
>>   	this_cpupid = cpu_pid_to_cpupid(dst_cpu, current->pid);
>> diff --git a/mm/vmstat.c b/mm/vmstat.c
>> index a78d70ddeacd..ca44a2dd5497 100644
>> --- a/mm/vmstat.c
>> +++ b/mm/vmstat.c
>> @@ -1272,6 +1272,7 @@ const char * const vmstat_text[] = {
>>   #ifdef CONFIG_NUMA_BALANCING
>>   	"pgpromote_success",
>>   	"pgpromote_candidate",
>> +	"pgpromote_candidate_nolimit",
>>   #endif
>>   	"pgdemote_kswapd",
>>   	"pgdemote_direct",
> 
> ---
> Best Regards,
> Huang, Ying



Return-Path: <linux-kernel+bounces-791457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72146B3B705
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 11:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 221EC203D40
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 09:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8AE302776;
	Fri, 29 Aug 2025 09:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="KWxQbN/E"
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD959304BBA
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756459214; cv=none; b=pb5AgcuxXOuMFOCS8ke8kD6Xn+DZ/bupIwBjf8iCAOt3KbjqSmvXeZOJs8iqX7TZ1hda9beAnNdVsYsOQbD7YAtC/83KDNjC/y4OFxO22kGMUt5Q4tOHcVDJ/I8CbCrYgnaiVZ51Je2vwYDaVeJ95tBEPX2p/UngYJzT4QrkZsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756459214; c=relaxed/simple;
	bh=9ZPMpcgc1IZqQe2khBwIzzgDVxe2HHh5Zmxc9x8f7/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E/5R4CvFIOG43uoT0MApZDFws1IuV3H4H9ju+y991Hgq/7MvSsQXv/x7h0TKdLUQGpxQ6G4y7Br0B70cdUNcCXtrTi34AvvJqXqQChyc5VEja2TKNCAy2jGqxhzmwc1qpRcsizDNsQPH3YJM7n2K1i+gQcgqzbpLMBTS82bm3Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=KWxQbN/E; arc=none smtp.client-ip=68.232.139.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1756459214; x=1787995214;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9ZPMpcgc1IZqQe2khBwIzzgDVxe2HHh5Zmxc9x8f7/w=;
  b=KWxQbN/E5cINpw85CtI4gEzVQoQ3MRKJOSVBVDRmCXVMWpu0yLRaA1MO
   uPBUwmW4MK5IOKksKbDNFQaP3orbfTbudiuEBQpQ1RAwnfJWC9KRmJRJF
   7HJKtOHpSoWAt5xelUFRzWr7iP4vZOeStbS4BdHPQb6V8uZP84+gmjakv
   VotUX2TaYicgKaGxe+wxMlSGoZhftJc75WbxgMUsCUsxvS2qHDpFujUGZ
   W8FXnyc9EsT2BIqgrY8ZLSbXG/CyLuuEvHdbUwJya61Mgoi2mqkcqBAsl
   ZsdTa1Ib4GgmPAm0inbXzhE863ICzbPiGjgG2BORLoTOxTYb5PXyuRhYS
   w==;
X-CSE-ConnectionGUID: dtpc5fGNTtSZ9FHQ4gVBQw==
X-CSE-MsgGUID: PlWkQPZSRQW1deuyq+wkWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="210347346"
X-IronPort-AV: E=Sophos;i="6.18,221,1751209200"; 
   d="scan'208";a="210347346"
Received: from unknown (HELO az2nlsmgr1.o.css.fujitsu.com) ([20.61.8.234])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 18:19:02 +0900
Received: from az2nlsmgm2.o.css.fujitsu.com (unknown [10.150.26.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgr1.o.css.fujitsu.com (Postfix) with ESMTPS id D4D2A1C00181
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:19:01 +0000 (UTC)
Received: from az2uksmom3.o.css.fujitsu.com (az2uksmom3.o.css.fujitsu.com [10.151.22.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm2.o.css.fujitsu.com (Postfix) with ESMTPS id 7EC711C0016C
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:19:01 +0000 (UTC)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by az2uksmom3.o.css.fujitsu.com (Postfix) with ESMTPS id 5FC3E100928A;
	Fri, 29 Aug 2025 09:18:59 +0000 (UTC)
Received: from [192.168.22.105] (unknown [10.167.135.81])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id D2B021A00E4;
	Fri, 29 Aug 2025 17:18:55 +0800 (CST)
Message-ID: <10659223-9bbe-468e-b458-ccd421590b7a@fujitsu.com>
Date: Fri, 29 Aug 2025 17:18:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm: memory-tiering: Fix PGPROMOTE_CANDIDATE counting
To: Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, lkp@intel.com,
 ying.huang@linux.alibaba.com, y-goto@fujitsu.com, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
 vschneid@redhat.com, Ben Segall <bsegall@google.com>,
 Li Zhijian <lizhijian@fujitsu.com>
References: <20250729035101.1601407-1-ruansy.fnst@fujitsu.com>
 <23765f70-e869-4ef6-8ddd-24c0b1548fb2@suse.cz>
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <23765f70-e869-4ef6-8ddd-24c0b1548fb2@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/8/29 17:08, Vlastimil Babka 写道:
> On 7/29/25 05:51, Ruan Shiyang wrote:
> 
> A process nit: your RFC v3 had:
> 
> From: Li Zhijian <lizhijian@fujitsu.com>
> 
> and this one doesn't.
> 
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
>> To solve this confusing statistics, introduce this PGPROMOTE_CANDIDATE_NRL
>> to count the missed promotion pages.  And also, not counting these pages
>> into PGPROMOTE_CANDIDATE is to avoid changing the existing algorithm or
>> performance of the promotion rate limit.
>>
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
>> Suggested-by: Huang Ying <ying.huang@linux.alibaba.com>
>> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> 
> So the S-o-b from Li doesn't match anything now.
> You can either reinstate that "From: Li ..." or add a "Co-developed-by: Li
> ..." right above the "S-o-b: Li ..." - that's for you two to decide who is
> the main author.

Thanks for pointing out.  I wasn't aware of this.

I'd like to add a Co-developed-by tag:

Co-developed-by: Li Zhijian

Then, should I resend a new version with is tag added?  Or you will do that for me?


--
Best regards,
Ruan.

> 
> More details in Documentation/process/submitting-patches.rst
> 
>> Signed-off-by: Ruan Shiyang <ruansy.fnst@fujitsu.com>
>> ---
>> Changes since RFC v3:
>>    1. change the naming of new added stat to PGPROMOTE_CANDIDATE_NRL.
>>    2. improve the description of the two stats.
>> ---
>>   include/linux/mmzone.h | 16 +++++++++++++++-
>>   kernel/sched/fair.c    |  5 +++--
>>   mm/vmstat.c            |  1 +
>>   3 files changed, 19 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>> index 283913d42d7b..4345996a7d5a 100644
>> --- a/include/linux/mmzone.h
>> +++ b/include/linux/mmzone.h
>> @@ -230,7 +230,21 @@ enum node_stat_item {
>>   #endif
>>   #ifdef CONFIG_NUMA_BALANCING
>>   	PGPROMOTE_SUCCESS,	/* promote successfully */
>> -	PGPROMOTE_CANDIDATE,	/* candidate pages to promote */
>> +	/**
>> +	 * Candidate pages for promotion based on hint fault latency.  This
>> +	 * counter is used to control the promotion rate and adjust the hot
>> +	 * threshold.
>> +	 */
>> +	PGPROMOTE_CANDIDATE,
>> +	/**
>> +	 * Not rate-limited (NRL) candidate pages for those can be promoted
>> +	 * without considering hot threshold because of enough free pages in
>> +	 * fast-tier node.  These promotions bypass the regular hotness checks
>> +	 * and do NOT influence the promotion rate-limiter or
>> +	 * threshold-adjustment logic.
>> +	 * This is for statistics/monitoring purposes.
>> +	 */
>> +	PGPROMOTE_CANDIDATE_NRL,
>>   #endif
>>   	/* PGDEMOTE_*: pages demoted */
>>   	PGDEMOTE_KSWAPD,
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 7a14da5396fb..4022c9c1f346 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -1940,11 +1940,13 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
>>   		struct pglist_data *pgdat;
>>   		unsigned long rate_limit;
>>   		unsigned int latency, th, def_th;
>> +		long nr = folio_nr_pages(folio);
>>   
>>   		pgdat = NODE_DATA(dst_nid);
>>   		if (pgdat_free_space_enough(pgdat)) {
>>   			/* workload changed, reset hot threshold */
>>   			pgdat->nbp_threshold = 0;
>> +			mod_node_page_state(pgdat, PGPROMOTE_CANDIDATE_NRL, nr);
>>   			return true;
>>   		}
>>   
>> @@ -1958,8 +1960,7 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
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
>> index a78d70ddeacd..bb0d2b330dd5 100644
>> --- a/mm/vmstat.c
>> +++ b/mm/vmstat.c
>> @@ -1272,6 +1272,7 @@ const char * const vmstat_text[] = {
>>   #ifdef CONFIG_NUMA_BALANCING
>>   	"pgpromote_success",
>>   	"pgpromote_candidate",
>> +	"pgpromote_candidate_nrl",
>>   #endif
>>   	"pgdemote_kswapd",
>>   	"pgdemote_direct",
> 



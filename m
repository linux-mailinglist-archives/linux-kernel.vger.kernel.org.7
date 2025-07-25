Return-Path: <linux-kernel+bounces-745190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D13B11657
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 04:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B971548673
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 02:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315A9226863;
	Fri, 25 Jul 2025 02:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="kn5zivBx"
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF7B846F
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 02:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753410059; cv=none; b=MMTGK4tkDgb32bxNOy2UCkDGitVI2ZCi7EilaXr5UcxaHyFkYXTGtTiRbobKljGCqC2M6na5dnsqZ00mZtS50hAjPGe22a8z23FfI76MuZN2wt6ui8nmNX+qFmGPx30bByv2yGeqLxPPVoMI89MTOQ+IsSnMP0WjPhbttWYMUtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753410059; c=relaxed/simple;
	bh=N8TtpA7lzF4PbRiXLF8Toc0Ps0/E7V/1pJKfeLjZlEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t40PkpztjxFfdI6H5z/yxyvBDNZqkpHAfaUdI1jeDVONeuOk9Xi9QiLsUnoo/6JOEV1ktIvJlZKNLLoJkgazKh0gFM1W7P0VI0U+o4fk/M37wDJLX4FsLTBc6MEzWc7aufS6E05enMMDlWiaQMTynbhIhP1saL4qplWRdRnAF40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=kn5zivBx; arc=none smtp.client-ip=139.138.61.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1753410057; x=1784946057;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=N8TtpA7lzF4PbRiXLF8Toc0Ps0/E7V/1pJKfeLjZlEE=;
  b=kn5zivBx6lPHiRsmz8WOzI4EqhosYEROcummbXDH8s+Tl/JiQlJflr+f
   kn9nAk0Bh2nhtgEPbPWQUrUnL8MwUANUjDWurVtfxKUiqTvrIA5y8wyJP
   P0LZlbo3xzyg9hSSVewUt26ydxd+6sSShj0mIA7Myez2bq4NKIGNuXsbB
   Pk2swZ5riKyWEitd3sodd0lZLwxshltP6jSqb2ysLv4j0xwqIg9Q6JPV8
   ZjkyLKcUl3ZbVrEQe1aiOihwISozbL9R7HS3S4Nq2N5TQpywlJJc8kkoc
   9fUbPm5xNIOHP1IaoPMzJagauLL7Pno8Y2ga56syn4THiZyojsPqxZH8O
   g==;
X-CSE-ConnectionGUID: eXrD5ORLQxaze2AJZ7Cd7w==
X-CSE-MsgGUID: Lb7Nx4SVRXGUyxsB/SNKgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="186234203"
X-IronPort-AV: E=Sophos;i="6.16,338,1744038000"; 
   d="scan'208";a="186234203"
Received: from unknown (HELO az2nlsmgr3.o.css.fujitsu.com) ([20.61.8.234])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 11:20:55 +0900
Received: from az2nlsmgm1.o.css.fujitsu.com (unknown [10.150.26.203])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgr3.o.css.fujitsu.com (Postfix) with ESMTPS id 188DA1000370
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 02:20:55 +0000 (UTC)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm1.o.css.fujitsu.com (Postfix) with ESMTPS id 82BD0C0037E
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 02:20:54 +0000 (UTC)
Received: from [192.168.22.105] (unknown [10.167.135.81])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id B010D1A006C;
	Fri, 25 Jul 2025 10:20:44 +0800 (CST)
Message-ID: <982da1b2-0024-4c01-b586-02c0b8a41e95@fujitsu.com>
Date: Fri, 25 Jul 2025 10:20:44 +0800
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
 <85d83be2-02f8-4ef6-91c7-ff920e47d834@fujitsu.com>
 <87wm7y3ur3.fsf@DESKTOP-5N7EMDA>
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <87wm7y3ur3.fsf@DESKTOP-5N7EMDA>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/24 15:36, Huang, Ying 写道:
> Shiyang Ruan <ruansy.fnst@fujitsu.com> writes:
> 
>> 在 2025/7/23 11:09, Huang, Ying 写道:
>>> Ruan Shiyang <ruansy.fnst@fujitsu.com> writes:
>>>
>>>> From: Li Zhijian <lizhijian@fujitsu.com>
>>>>
>>>> ===
>>>> Changes since v2:
>>>>     1. According to Huang's suggestion, add a new stat to not count these
>>>>     pages into PGPROMOTE_CANDIDATE, to avoid changing the rate limit
>>>>     mechanism.
>>>> ===
>>> This isn't the popular place for changelog, please refer to other
>>> patch
>>> email.
>>
>> OK. I'll move this part down below.>
>>>> Goto-san reported confusing pgpromote statistics where the
>>>> pgpromote_success count significantly exceeded pgpromote_candidate.
>>>>
>>>> On a system with three nodes (nodes 0-1: DRAM 4GB, node 2: NVDIMM 4GB):
>>>>    # Enable demotion only
>>>>    echo 1 > /sys/kernel/mm/numa/demotion_enabled
>>>>    numactl -m 0-1 memhog -r200 3500M >/dev/null &
>>>>    pid=$!
>>>>    sleep 2
>>>>    numactl memhog -r100 2500M >/dev/null &
>>>>    sleep 10
>>>>    kill -9 $pid # terminate the 1st memhog
>>>>    # Enable promotion
>>>>    echo 2 > /proc/sys/kernel/numa_balancing
>>>>
>>>> After a few seconds, we observeed `pgpromote_candidate < pgpromote_success`
>>>> $ grep -e pgpromote /proc/vmstat
>>>> pgpromote_success 2579
>>>> pgpromote_candidate 0
>>>>
>>>> In this scenario, after terminating the first memhog, the conditions for
>>>> pgdat_free_space_enough() are quickly met, and triggers promotion.
>>>> However, these migrated pages are only counted for in PGPROMOTE_SUCCESS,
>>>> not in PGPROMOTE_CANDIDATE.
>>>>
>>>> To solve this confusing statistics, introduce this
>>>> PGPROMOTE_CANDIDATE_NOLIMIT to count the missed promotion pages.  And
>>>> also, not counting these pages into PGPROMOTE_CANDIDATE is to avoid
>>>> changing the existing algorithm or performance of the promotion rate
>>>> limit.
>>>>
>>>> Perhaps PGPROMOTE_CANDIDATE_NOLIMIT is not well named, please comment if
>>>> you have a better idea.
>>> Yes.  Naming is hard.  I guess that the name comes from the
>>> promotion
>>> that isn't rate limited.  I have asked Deepseek that what is the good
>>> abbreviation for "not rate limited".  Its answer is "NRL".  I don't know
>>> whether it's good.  However, "NOT_RATE_LIMITED" appears too long.
>>
>> "NRL" Sounds good to me.
>>
>> I'm thinking another one: since it's not rate limited, it could be
>> migrated quickly/fast.  How about PGPROMOTE_CANDIDATE_FAST?
> 
> This sounds good to me, Thanks!

Gemini 2.5 gave me a more radical name for it:

/*
  * Candidate pages for promotion based on hint fault latency. This counter
  * is used by the feedback mechanism to control the promotion rate and
  * adjust the hot threshold.
  */
PGPROMOTE_CANDIDATE,
/*
  * Pages promoted aggressively to a fast-tier node when it has sufficient
  * free space. These promotions bypass the regular hotness checks and do
  * NOT influence the promotion rate-limiter or threshold-adjustment logic.
  * This is for statistics/monitoring purposes.
  */
PGPROMOTED_AGGRESSIVE,

I think this one is concise and easy to understand with the comments. What do 
you think?  If this one is not appropriate, then I will go with "_NRL" as you 
suggested.


--
Thanks,
Ruan.

> 
> ---
> Best Regards,
> Huang, Ying
> 
>>
>>>
>>>>
>>>>
>>> The empty line is unnecessary.
>>
>> OK.>
>>>> Cc: Huang Ying <ying.huang@linux.alibaba.com>
>>> Suggested-by: Huang Ying <ying.huang@linux.alibaba.com>
>>
>> OK.
>>
>>
>> --
>> Thanks,
>> Ruan.
>>
>>>
>>>> Cc: Ingo Molnar <mingo@redhat.com>
>>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>>> Cc: Juri Lelli <juri.lelli@redhat.com>
>>>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>>>> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
>>>> Cc: Steven Rostedt <rostedt@goodmis.org>
>>>> Cc: Ben Segall <bsegall@google.com>
>>>> Cc: Mel Gorman <mgorman@suse.de>
>>>> Cc: Valentin Schneider <vschneid@redhat.com>
>>>> Reported-by: Yasunori Gotou (Fujitsu) <y-goto@fujitsu.com>
>>>> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
>>>> Signed-off-by: Ruan Shiyang <ruansy.fnst@fujitsu.com>
>>>> ---
>>>>    include/linux/mmzone.h | 2 ++
>>>>    kernel/sched/fair.c    | 6 ++++--
>>>>    mm/vmstat.c            | 1 +
>>>>    3 files changed, 7 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>>>> index 283913d42d7b..6216e2eecf3b 100644
>>>> --- a/include/linux/mmzone.h
>>>> +++ b/include/linux/mmzone.h
>>>> @@ -231,6 +231,8 @@ enum node_stat_item {
>>>>    #ifdef CONFIG_NUMA_BALANCING
>>>>    	PGPROMOTE_SUCCESS,	/* promote successfully */
>>>>    	PGPROMOTE_CANDIDATE,	/* candidate pages to promote */
>>>> +	PGPROMOTE_CANDIDATE_NOLIMIT,	/* candidate pages without considering
>>>> +					 * hot threshold */
>>>>    #endif
>>>>    	/* PGDEMOTE_*: pages demoted */
>>>>    	PGDEMOTE_KSWAPD,
>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>> index 7a14da5396fb..12dac3519c49 100644
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -1940,11 +1940,14 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
>>>>    		struct pglist_data *pgdat;
>>>>    		unsigned long rate_limit;
>>>>    		unsigned int latency, th, def_th;
>>>> +		long nr = folio_nr_pages(folio);
>>>>      		pgdat = NODE_DATA(dst_nid);
>>>>    		if (pgdat_free_space_enough(pgdat)) {
>>>>    			/* workload changed, reset hot threshold */
>>>>    			pgdat->nbp_threshold = 0;
>>>> +			mod_node_page_state(pgdat, PGPROMOTE_CANDIDATE_NOLIMIT,
>>>> +					    nr);
>>>>    			return true;
>>>>    		}
>>>>    @@ -1958,8 +1961,7 @@ bool should_numa_migrate_memory(struct
>>>> task_struct *p, struct folio *folio,
>>>>    		if (latency >= th)
>>>>    			return false;
>>>>    -		return !numa_promotion_rate_limit(pgdat, rate_limit,
>>>> -						  folio_nr_pages(folio));
>>>> +		return !numa_promotion_rate_limit(pgdat, rate_limit, nr);
>>>>    	}
>>>>      	this_cpupid = cpu_pid_to_cpupid(dst_cpu, current->pid);
>>>> diff --git a/mm/vmstat.c b/mm/vmstat.c
>>>> index a78d70ddeacd..ca44a2dd5497 100644
>>>> --- a/mm/vmstat.c
>>>> +++ b/mm/vmstat.c
>>>> @@ -1272,6 +1272,7 @@ const char * const vmstat_text[] = {
>>>>    #ifdef CONFIG_NUMA_BALANCING
>>>>    	"pgpromote_success",
>>>>    	"pgpromote_candidate",
>>>> +	"pgpromote_candidate_nolimit",
>>>>    #endif
>>>>    	"pgdemote_kswapd",
>>>>    	"pgdemote_direct",
>>> ---
>>> Best Regards,
>>> Huang, Ying



Return-Path: <linux-kernel+bounces-743699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2210B1020E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC8523A5F70
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 07:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7293526B2DB;
	Thu, 24 Jul 2025 07:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="r6vgAEi5"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011A926738D
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 07:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753342622; cv=none; b=R5CvE8M/WDylihPAzikaupWF6Jnn9KDLX4Yiks0+2OEx3caaxP2braIBI+vJnIvlpYB/CxnNqtAOIhMs6U/OSppLvZzi+MfTm+jXkkccvdm7wCFh3h0aDC5wHbP94YIi0AbGl0byBWMq3sPbbHkPn2MnSZEPlyKunH65nZE2d8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753342622; c=relaxed/simple;
	bh=PvGLJeq0K9YhTyqqaktIUjdw5HD+7whbw0yBy3JSSvg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IkfZSXpCL4GlFeTV+Tr0LQGcJgM3emhsHBKZdJ1En8ksBz3CCAHK8ClKtd5JA507NL21/oJ6iVVBEoIpKtPXkJjxhQF5ti3PmD0tLZEPwzN3duh1dgo/BohAmHNEdZq9WjCBzl2OO8wR0+jonunYimQ1yn1ZH6Vco+3qUlAuq+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=r6vgAEi5; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753342611; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=P6saxIttai/NSTgVrkSSj21N3ELBMaOxdIJSLIFoS5k=;
	b=r6vgAEi5VajCOo2tY6PDP9jQno6S17LMRkMrJhAbxPXe3uAJBpGX6pJ9gIZJ2LJfmVyoQJHQJHWzE8pc+YMr+j/lDFIS4s64bjaYiqj87yJyew+ZCJ8vU2sIBLeDFPGPR8br8yuNPLsqRmFIvR+HA57nEwAkgTuOThZo6b4AHrM=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WjlKIg3_1753342609 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 24 Jul 2025 15:36:50 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc: linux-mm@kvack.org,  linux-kernel@vger.kernel.org,  lkp@intel.com,
  akpm@linux-foundation.org,  y-goto@fujitsu.com,  mingo@redhat.com,
  peterz@infradead.org,  juri.lelli@redhat.com,
  vincent.guittot@linaro.org,  dietmar.eggemann@arm.com,
  rostedt@goodmis.org,  mgorman@suse.de,  vschneid@redhat.com,  Li Zhijian
 <lizhijian@fujitsu.com>,  Ben Segall <bsegall@google.com>
Subject: Re: [PATCH RFC v3] mm: memory-tiering: Fix PGPROMOTE_CANDIDATE
 counting
In-Reply-To: <85d83be2-02f8-4ef6-91c7-ff920e47d834@fujitsu.com> (Shiyang
	Ruan's message of "Thu, 24 Jul 2025 10:39:40 +0800")
References: <20250722141650.1821721-1-ruansy.fnst@fujitsu.com>
	<87cy9r38ny.fsf@DESKTOP-5N7EMDA>
	<85d83be2-02f8-4ef6-91c7-ff920e47d834@fujitsu.com>
Date: Thu, 24 Jul 2025 15:36:48 +0800
Message-ID: <87wm7y3ur3.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Shiyang Ruan <ruansy.fnst@fujitsu.com> writes:

> =E5=9C=A8 2025/7/23 11:09, Huang, Ying =E5=86=99=E9=81=93:
>> Ruan Shiyang <ruansy.fnst@fujitsu.com> writes:
>>=20
>>> From: Li Zhijian <lizhijian@fujitsu.com>
>>>
>>> =3D=3D=3D
>>> Changes since v2:
>>>    1. According to Huang's suggestion, add a new stat to not count these
>>>    pages into PGPROMOTE_CANDIDATE, to avoid changing the rate limit
>>>    mechanism.
>>> =3D=3D=3D
>> This isn't the popular place for changelog, please refer to other
>> patch
>> email.
>
> OK. I'll move this part down below.>
>>> Goto-san reported confusing pgpromote statistics where the
>>> pgpromote_success count significantly exceeded pgpromote_candidate.
>>>
>>> On a system with three nodes (nodes 0-1: DRAM 4GB, node 2: NVDIMM 4GB):
>>>   # Enable demotion only
>>>   echo 1 > /sys/kernel/mm/numa/demotion_enabled
>>>   numactl -m 0-1 memhog -r200 3500M >/dev/null &
>>>   pid=3D$!
>>>   sleep 2
>>>   numactl memhog -r100 2500M >/dev/null &
>>>   sleep 10
>>>   kill -9 $pid # terminate the 1st memhog
>>>   # Enable promotion
>>>   echo 2 > /proc/sys/kernel/numa_balancing
>>>
>>> After a few seconds, we observeed `pgpromote_candidate < pgpromote_succ=
ess`
>>> $ grep -e pgpromote /proc/vmstat
>>> pgpromote_success 2579
>>> pgpromote_candidate 0
>>>
>>> In this scenario, after terminating the first memhog, the conditions for
>>> pgdat_free_space_enough() are quickly met, and triggers promotion.
>>> However, these migrated pages are only counted for in PGPROMOTE_SUCCESS,
>>> not in PGPROMOTE_CANDIDATE.
>>>
>>> To solve this confusing statistics, introduce this
>>> PGPROMOTE_CANDIDATE_NOLIMIT to count the missed promotion pages.  And
>>> also, not counting these pages into PGPROMOTE_CANDIDATE is to avoid
>>> changing the existing algorithm or performance of the promotion rate
>>> limit.
>>>
>>> Perhaps PGPROMOTE_CANDIDATE_NOLIMIT is not well named, please comment if
>>> you have a better idea.
>> Yes.  Naming is hard.  I guess that the name comes from the
>> promotion
>> that isn't rate limited.  I have asked Deepseek that what is the good
>> abbreviation for "not rate limited".  Its answer is "NRL".  I don't know
>> whether it's good.  However, "NOT_RATE_LIMITED" appears too long.
>
> "NRL" Sounds good to me.
>
> I'm thinking another one: since it's not rate limited, it could be
> migrated quickly/fast.  How about PGPROMOTE_CANDIDATE_FAST?

This sounds good to me, Thanks!

---
Best Regards,
Huang, Ying

>
>>=20
>>>
>>>
>> The empty line is unnecessary.
>
> OK.>
>>> Cc: Huang Ying <ying.huang@linux.alibaba.com>
>> Suggested-by: Huang Ying <ying.huang@linux.alibaba.com>
>
> OK.
>
>
> --
> Thanks,
> Ruan.
>
>>=20
>>> Cc: Ingo Molnar <mingo@redhat.com>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Cc: Juri Lelli <juri.lelli@redhat.com>
>>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>>> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
>>> Cc: Steven Rostedt <rostedt@goodmis.org>
>>> Cc: Ben Segall <bsegall@google.com>
>>> Cc: Mel Gorman <mgorman@suse.de>
>>> Cc: Valentin Schneider <vschneid@redhat.com>
>>> Reported-by: Yasunori Gotou (Fujitsu) <y-goto@fujitsu.com>
>>> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
>>> Signed-off-by: Ruan Shiyang <ruansy.fnst@fujitsu.com>
>>> ---
>>>   include/linux/mmzone.h | 2 ++
>>>   kernel/sched/fair.c    | 6 ++++--
>>>   mm/vmstat.c            | 1 +
>>>   3 files changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>>> index 283913d42d7b..6216e2eecf3b 100644
>>> --- a/include/linux/mmzone.h
>>> +++ b/include/linux/mmzone.h
>>> @@ -231,6 +231,8 @@ enum node_stat_item {
>>>   #ifdef CONFIG_NUMA_BALANCING
>>>   	PGPROMOTE_SUCCESS,	/* promote successfully */
>>>   	PGPROMOTE_CANDIDATE,	/* candidate pages to promote */
>>> +	PGPROMOTE_CANDIDATE_NOLIMIT,	/* candidate pages without considering
>>> +					 * hot threshold */
>>>   #endif
>>>   	/* PGDEMOTE_*: pages demoted */
>>>   	PGDEMOTE_KSWAPD,
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 7a14da5396fb..12dac3519c49 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -1940,11 +1940,14 @@ bool should_numa_migrate_memory(struct task_str=
uct *p, struct folio *folio,
>>>   		struct pglist_data *pgdat;
>>>   		unsigned long rate_limit;
>>>   		unsigned int latency, th, def_th;
>>> +		long nr =3D folio_nr_pages(folio);
>>>     		pgdat =3D NODE_DATA(dst_nid);
>>>   		if (pgdat_free_space_enough(pgdat)) {
>>>   			/* workload changed, reset hot threshold */
>>>   			pgdat->nbp_threshold =3D 0;
>>> +			mod_node_page_state(pgdat, PGPROMOTE_CANDIDATE_NOLIMIT,
>>> +					    nr);
>>>   			return true;
>>>   		}
>>>   @@ -1958,8 +1961,7 @@ bool should_numa_migrate_memory(struct
>>> task_struct *p, struct folio *folio,
>>>   		if (latency >=3D th)
>>>   			return false;
>>>   -		return !numa_promotion_rate_limit(pgdat, rate_limit,
>>> -						  folio_nr_pages(folio));
>>> +		return !numa_promotion_rate_limit(pgdat, rate_limit, nr);
>>>   	}
>>>     	this_cpupid =3D cpu_pid_to_cpupid(dst_cpu, current->pid);
>>> diff --git a/mm/vmstat.c b/mm/vmstat.c
>>> index a78d70ddeacd..ca44a2dd5497 100644
>>> --- a/mm/vmstat.c
>>> +++ b/mm/vmstat.c
>>> @@ -1272,6 +1272,7 @@ const char * const vmstat_text[] =3D {
>>>   #ifdef CONFIG_NUMA_BALANCING
>>>   	"pgpromote_success",
>>>   	"pgpromote_candidate",
>>> +	"pgpromote_candidate_nolimit",
>>>   #endif
>>>   	"pgdemote_kswapd",
>>>   	"pgdemote_direct",
>> ---
>> Best Regards,
>> Huang, Ying


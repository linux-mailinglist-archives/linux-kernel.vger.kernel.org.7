Return-Path: <linux-kernel+bounces-721226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB09AFC659
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65DE317DFFE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131532BEC52;
	Tue,  8 Jul 2025 08:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nOAidlAo"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBAE2BCF45
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 08:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751965030; cv=none; b=JJvbUOdmvCxOp6p1oxZpC0g5cYh/di3iKF/NQwWCATJxgkDa+pnrKCmh1hxFLY7fccUGS3hXW7a4XwJeD8gk5FNjlv2ifaCIzV1QHLt0QI6t8h625sABD+oxiLAC0xZiyirkrhdUzyE9XSvZTibco96YGpLQlSMdLzt9Nj4hVqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751965030; c=relaxed/simple;
	bh=X+MieOBj0oHIf+LtysuIm9clNgtG2AKYxi8YKRRGsys=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mFF3mDvhr8wUn1xvR5Q2YwT8c5t1C6+cgPxq63oaKDDDOrAWNeAht5/yI7ozpaezbuF81w/N91rvlObw5Jw0XTSZK0VkMifV0r2wwrmFUjB/FENSfNufnbC8Z6hRU1BI6hD/gnqTBz4Zyl31wa3YxR7+6Ud7VIWjcptbve4ufVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nOAidlAo; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751965018; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=A2vZYX1l0XQyQVoUTU1in7x9tGcoH47aWDnOLy5mo84=;
	b=nOAidlAozF2azXIuSHlNqy1JdSrw+qth3izAihDeP1LlCa9NzmbKsH9FVgjUQrZDV5Z/ZipGCe/hgJZ2p5LWNMo0EoSHNyCyap8XEQfUSsU67rAzMvetSy2BotjGjhOHorHiPVvuwHGUC0wqob25hs8iMtcwLxvi7myZvzDUkAs=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WiMopS5_1751965015 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 08 Jul 2025 16:56:56 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,  "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,  "Yasunori Gotou (Fujitsu)"
 <y-goto@fujitsu.com>,  Ingo Molnar <mingo@redhat.com>,  Peter Zijlstra
 <peterz@infradead.org>,  Juri Lelli <juri.lelli@redhat.com>,  Vincent
 Guittot <vincent.guittot@linaro.org>,  Dietmar Eggemann
 <dietmar.eggemann@arm.com>,  Steven Rostedt <rostedt@goodmis.org>,  Ben
 Segall <bsegall@google.com>,  Mel Gorman <mgorman@suse.de>,  Valentin
 Schneider <vschneid@redhat.com>,  "lkp@intel.com" <lkp@intel.com>
Subject: Re: [PATCH RFC v2] mm: memory-tiering: Fix PGPROMOTE_CANDIDATE
 accounting
In-Reply-To: <4f98ce21-39da-410b-bec0-2b6f240e550e@fujitsu.com> (Zhijian Li's
	message of "Tue, 8 Jul 2025 06:40:00 +0000")
References: <20250625021352.2291544-1-lizhijian@fujitsu.com>
	<e71873b6-78ac-4555-a6a5-e9b5fb3f9112@fujitsu.com>
	<87tt3nxz4x.fsf@DESKTOP-5N7EMDA>
	<ef637fe1-436e-4003-86fb-47f651433f7b@fujitsu.com>
	<87zfdfwg8h.fsf@DESKTOP-5N7EMDA>
	<4f98ce21-39da-410b-bec0-2b6f240e550e@fujitsu.com>
Date: Tue, 08 Jul 2025 16:56:54 +0800
Message-ID: <87wm8jukkp.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com> writes:

> On 08/07/2025 10:47, Huang, Ying wrote:
>> "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com> writes:
>> 
>>> On 08/07/2025 09:14, Huang, Ying wrote:
>>>> "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com> writes:
>>>>
>>>>> Hi,
>>>>>
>>>>>
>>>>> On 25/06/2025 10:13, Li Zhijian wrote:
>>>>>> V2:
>>>>>> Fix compiling error # Reported by LKP
>>>>>>
>>>>>> As Ying suggested, we need to assess whether this change causes regression.
>>>>>> However, considering the stringent conditions this patch involves,
>>>>>> properly evaluating it may be challenging, as the outcomes depend on your
>>>>>> perspective. Much like in a zero-sum game, if someone benefits, another
>>>>>> might lose.
>>>>>>
>>>>>> If there are subsequent results, I will update them here.
>>>>>
>>>>> I ran memhog + pmbench to evaluate the impact of the patch(3 runs [1] for each kernel).
>>>>>
>>>>> The results show an approximate 4% performance increase in pmbench after applying this patch.
>>>>>
>>>>> Average     pmbench-access            max-promotion-rate
>>>>> Before:     7956805 pages/sec                168301 pages/sec
>>>>> After:      8313666 pages/sec (+4.4%)        207149 pages/sec
>>>>
>>>> It's hard for me to understand why performance increases because of
>>>> higher promotion rate, while the expected behavior is more promotion
>>>> rate limiting.
>>>
>>> Good question.
>>>
>>> Above max-promotion-rate means the maximum rate during the WHOLE pmbench period which
>>> can not indicate the total promoted pages.
>>>
>>> Allow me to present each sample [0] recorded per second during the pmbench duration, as exemplified below:
>>>
>>>
>>>               |       AFTER             |VS |           BEFORE       |
>>> ------------+-------------------------+++++------------------------|
>>> | Timestamp |  pgprom/s   |  pgdem/s  |   |  pgprom/s  |  pgdem/s  |
>>> |-----------|-------------|-----------|---|------------|-----------|
>>> |     1     |   122977    |     0     |   |   123051   |     0     |
>>> |     2     |   50171     |     0     |   |   50159    |     0     |
>>> |     3     |     18      |     0     |   |     28     |     0     |
>>> |     4     |   16647     |     0     |   |     0      |     0     |
>>> |     5     | 207149.5    |     0     |   |   78895    |     0     |
>>> |     6     | 193411      | 161521    |   |  168301    |   8702    |
>>> |     7     |  52464      |  53989    |   |   42294    |  39108    |
>>> |     8     |   5133      |   2627    |   |     0      |     0     |
>>> |     9     |     24      |     8     |   |   3875     |   6213    |
>>> |    10     |     0       |     0     |   |  45513     |  43260    |
>>> |    11     |     0       |     0     |   |  36600     |  44982    |
>>> |    12     |     0       |     0     |   |  21091     |  11631    |
>>> |    13     |     0       |     0     |   |  12276     |  10719    |
>>> |    14     |     0       |     0     |   | 149699     | 149400    |
>>> |    15     |     0       |     0     |   |   4026     |   4933    |
>>> |    16     |     0       |     0     |   |   3780     |     0     |
>>> |    17     |     0       |     0     |   |     2      |     0     |
>>> |    18     |     0       |     0     |   |     0      |     0     |
>>> |    19     |     0       |     0     |   |     0      |     0     |
>>> |    20     |     0       |     0     |   |     0      |     0     |
>>> |    21     |     0       |     0     |   |    62      |     0     |
>>> |    22     |     0       |     0     |   |   2016     |     0     |
>>> |    23     |     0       |     0     |   |     0      |     0     |
>>> |    24     |     0       |     0     |   |    62      |     0     |
>>> |    25     |   8308      |     0     |   |     1      |     0     |
>>> |    26     |   220       |     0     |   |     0      |     0     |
>>> |    27     |     0       |     0     |   |  1995.05   |     0     |
>>> |    28     |     0       |     0     |   |     1      |     0     |
>>> |    29     |   5791      |     0     |   |     0      |     0     |
>>> |    30     |     0       |     0     |   |    62      |     0     |
>>> ------------+-------------------------+++++------------------------|
>>> |   total   | 662313.5    | 218145    |   | 743789.05  | 318948    |
>>> |    max    | 207149.5    | 161521    |   |  168301    | 149400    |
>>> ------------+-------------------------+++++------------------------|
>>> |   pmbench |        8416250          |VS |        8079500         |
>>>
>>>
>>> As far as I can tell, the higher pmbench scores applied-patch may be attributed to
>>> a reduction in the total number of promoted pages in the entire pmbench execution period.
>>> (Similar circumstances were observed in the results of other tests conducted)
>>>
>>>
>>>
>>> [0]
>>> before:
>>> https://github.com/zhijianli88/misc/blob/main/20250627/promotion-evaluation/without-patch/pmbench-1750988862.log
>>> https://github.com/zhijianli88/misc/blob/main/20250627/promotion-evaluation/without-patch/sar-1750988862.log
>>> after:
>>> https://github.com/zhijianli88/misc/blob/main/20250627/promotion-evaluation/with-patch/pmbench-1750988291.log
>>> https://github.com/zhijianli88/misc/blob/main/20250627/promotion-evaluation/with-patch/sar-1750988291.log
>>>
>> 
>> Check the usage of PGPROMOTE_CANDIDATE again.  It is used not only by
>> rate limiting, but also promotion threshold adjustment, please take a
>> look at numa_promotion_adjust_threshold().  Which may have larger
>> influence on performance.
>> 
>> After checking the threshold adjustment code, I think the changes in
>> this patch may confuse threshold adjustment.
>
>
> Indeed, I misunderstood the comment in the previous code:
> /* workload changed, reset hot threshold */.
>
> Originally, this logic only reset the threshold for the current interval.
> For the next cycle (60 seconds by default), the threshold is
> re-evaluated based on the historical PGPROMOTE_CANDIDATE counts.
> Therefore, the current change may affect threshold adjustment in subsequent cycles.
>
>
> Do you think there's still a case to push for this patch?
>
> For example, by collecting more data with longer pmbench runs (over two threshold cycles),
> or explicitly compensating nbp_rl_nr_cand and nbp_th_nr_cand to maintain existing
> behavior for both the rate limit and threshold logic? something like:
>
> if (pgdat_free_space_enough(pgdat)) {
>      /* workload changed, reset hot threshold */
>      pgdat->nbp_threshold = 0;
>      
>      mod_node_page_state(pgdat, PGPROMOTE_CANDIDATE, nr);
>      // compensation for rate limit and threshold
>      pgdat->nbp_rl_nr_cand += nr;
>      pgdat->nbp_th_nr_cand += nr;
>      
>      return true;
> }

I don't think that it's necessary to make the algorithm harder to be
understood.

If you think that the original stat really makes people confusing, I
guess that we can add a new stat (say PGPROMOTE_CANDIDATE_OTHER).

---
Best Regards,
Huang, Ying


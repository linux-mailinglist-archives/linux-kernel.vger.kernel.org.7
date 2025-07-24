Return-Path: <linux-kernel+bounces-743694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D57B5B101F9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1637B581C8B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 07:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A0F227E82;
	Thu, 24 Jul 2025 07:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="STkArK/0"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D4320C488
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 07:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753342546; cv=none; b=TFpfRFIe8RtwAjk7zm5D7kj+lIOrkDcQGxHrE9Rk0ON214hWWiIhKBrIIG3vFuesf1Kg34xABuDo1/kod1rbmfpyuSLQL/8eBjanMsZz1RbC57M+8pCX399acOW3aPMr5ZUVPkR6Db6sfT4jpTEpnvJxglAPQVMqigjwsxT592E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753342546; c=relaxed/simple;
	bh=8WnfY/8Kj6OaBiY/I/Ju13+/z7nGLLu7WyJT/2789vo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ax4uFvDJwmkxgK6YEb1+101Hq/0/6RVUQdixE6BdGTVXxCintQI9qP6FBmdSTkouwYCqZ/PrGn0Yz4jLuREbwSftnZoA0WYGw4czvHdvf5UijLlCw6UMVIPXWlyloYnSqe13pmZEespOqmoRHSPanfvT6X9Yhb7bv2IxTNnJo04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=STkArK/0; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753342535; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=hjBHJMe/Q18LuysRuiW8kz7jNE0xs2d+Q0WubtH/tqk=;
	b=STkArK/0lLNfpC9crYM40MtDSw0iFqn5oMAJOcj/IyKyuZTfBqfxqhRtlFv2T3qYdk/7KQ0qy9iPswkP3cFF485nPL6+MKhWdO4GZSEFFQONO6P1uJy5aky9Z9IKnXJxqXFprRMwGUKipRFN2s/TIsPlqUBP25sGITMd/SbssiU=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WjlauW4_1753342521 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 24 Jul 2025 15:35:33 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: "Shiyang Ruan (Fujitsu)" <ruansy.fnst@fujitsu.com>,
  "linux-mm@kvack.org" <linux-mm@kvack.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  "lkp@intel.com" <lkp@intel.com>,  "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>,  "Yasunori Gotou (Fujitsu)"
 <y-goto@fujitsu.com>,  "mingo@redhat.com" <mingo@redhat.com>,
  "peterz@infradead.org" <peterz@infradead.org>,  "juri.lelli@redhat.com"
 <juri.lelli@redhat.com>,  "vincent.guittot@linaro.org"
 <vincent.guittot@linaro.org>,  "dietmar.eggemann@arm.com"
 <dietmar.eggemann@arm.com>,  "rostedt@goodmis.org" <rostedt@goodmis.org>,
  "mgorman@suse.de" <mgorman@suse.de>,  "vschneid@redhat.com"
 <vschneid@redhat.com>,  Ben Segall <bsegall@google.com>
Subject: Re: [PATCH RFC v3] mm: memory-tiering: Fix PGPROMOTE_CANDIDATE
 counting
In-Reply-To: <ecc1622e-1076-4c03-9e1b-44aa701e6a5c@fujitsu.com> (Zhijian Li's
	message of "Thu, 24 Jul 2025 03:35:39 +0000")
References: <20250722141650.1821721-1-ruansy.fnst@fujitsu.com>
	<ecc1622e-1076-4c03-9e1b-44aa701e6a5c@fujitsu.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Thu, 24 Jul 2025 15:35:20 +0800
Message-ID: <871pq659dz.fsf@DESKTOP-5N7EMDA>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com> writes:

> On 22/07/2025 22:16, Ruan Shiyang wrote:
>> From: Li Zhijian<lizhijian@fujitsu.com>
>> 
>
> I believe you are the actual author of this patch, so please change to yourself :)
>
>
>> Cc: Juri Lelli<juri.lelli@redhat.com>
>> Cc: Vincent Guittot<vincent.guittot@linaro.org>
>> Cc: Dietmar Eggemann<dietmar.eggemann@arm.com>
>> Cc: Steven Rostedt<rostedt@goodmis.org>
>> Cc: Ben Segall<bsegall@google.com>
>> Cc: Mel Gorman<mgorman@suse.de>
>> Cc: Valentin Schneider<vschneid@redhat.com>
>> Reported-by: Yasunori Gotou (Fujitsu)<y-goto@fujitsu.com>
>> Signed-off-by: Li Zhijian<lizhijian@fujitsu.com>
>> Signed-off-by: Ruan Shiyang<ruansy.fnst@fujitsu.com>
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
>
> Additionally, I think the current comment for PGPROMOTE_CANDIDATE is inaccurate. If possible, I'd like to refine it along with this patch.
> For example:
> 	/*
> 	 * Candidate pages for promotion based on hint fault latency. This counter
> 	 * is used to control the promotion rate and adjust the hotness threshold.
> 	 */
> What are your thoughts, @Ying?

This looks good to me, Thanks!

---
Best Regards,
Huang, Ying

>
>
>> +	PGPROMOTE_CANDIDATE_NOLIMIT,	/* candidate pages without considering
>> +					 * hot threshold */
>
> Similarly, the comment for PGPROMOTE_CANDIDATE_NOLIMIT can also be made more precise.
>
>
> Thanks
> Zhijian
>
>>   #endif


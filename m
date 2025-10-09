Return-Path: <linux-kernel+bounces-846195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B13BC7413
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 04:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A950C3AF346
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 02:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B551E51EE;
	Thu,  9 Oct 2025 02:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fYe/2lgh"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D811CA84
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 02:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759978633; cv=none; b=cxs+3ZTNoBAEQcauXSxdlANArgJw1kr36CNQjH9xl2x3ho6+NtcxJAp8l+AUA7y/6AOZjHp7drabqXieOV/2LA3PZ4RmImdRCnes29S9ctEy8Lbskdev4PP7q5vl6F+8FTRmWbBKDX+5DKBgLIHFp17rjAckSizzW0gHMpCKQHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759978633; c=relaxed/simple;
	bh=i7wkiQjL9ohQ8Ue5iq3GfkPFKSdUQHloHW77Ji9ec/o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PC0/4rSsbl40y8rWpucOjQna+vpNc45LPYZbMjP+nl4sCm1Shp7JUjXwUEHhwp8btMp+vWJJtQpVDyKl1fxQZiYxv6U57OVz6IjBpWnf8I1/NHXlvBCAA6gvlcFUx/ykI2HNoVpAFQ1Eztqno1i24KtNG/NmDgET7rHH+Lfz8lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fYe/2lgh; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1759978628; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=GnDaONb6FN618EW5I46/MhGF+FSL1m5oZv89+qdE5Bc=;
	b=fYe/2lghOMYeMGUij1Ve+oIx1BvwsJp8UNUxlljmBuQjLdE5auRmbDvIrFGeb90NVLizskzgyu31PIgtZheIej6lvgiVxWE+gwSJM51iw7OoxDbRFalNqm0A9+KGpLT7c7D2K1Qa21y1PTdxSnK393watYQ3laOeYiZj+dSBB9s=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WphApVS_1759978626 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 09 Oct 2025 10:57:06 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Dave Hansen <dave.hansen@intel.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Brendan Jackman <jackmanb@google.com>,
  Johannes Weiner <hannes@cmpxchg.org>,  Michal Hocko <mhocko@suse.com>,
  Suren Baghdasaryan <surenb@google.com>,  Vlastimil Babka
 <vbabka@suse.cz>,  Zi Yan <ziy@nvidia.com>,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org
Subject: Re: [RFC] [PATCH] mm/page_alloc: pcp->batch tuning
In-Reply-To: <20251008193642.953032-1-joshua.hahnjy@gmail.com> (Joshua Hahn's
	message of "Wed, 8 Oct 2025 12:36:41 -0700")
References: <20251008193642.953032-1-joshua.hahnjy@gmail.com>
Date: Thu, 09 Oct 2025 10:57:05 +0800
Message-ID: <87ms60wzni.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Joshua,

Joshua Hahn <joshua.hahnjy@gmail.com> writes:

> On Wed, 8 Oct 2025 08:34:21 -0700 Dave Hansen <dave.hansen@intel.com> wrote:
>
> Hello Dave, thank you for your feedback!
>
>> First of all, I do agree that the comment should go away or get fixed up.
>> 
>> But...
>> 
>> On 10/6/25 07:54, Joshua Hahn wrote:
>> > This leaves us with a /= 4 with no corresponding *= 4 anywhere, which
>> > leaves pcp->batch mistuned from the original intent when it was
>> > introduced. This is made worse by the fact that pcp lists are generally
>> > larger today than they were in 2013, meaning batch sizes should have
>> > increased, not decreased.
>> 
>> pcp->batch and pcp->high do very different things. pcp->high is a limit
>> on the amount of memory that can be tied up. pcp->batch balances
>> throughput with latency. I'm not sure I buy the idea that a higher
>> pcp->high means we should necessarily do larger batches.
>
> I agree with your observation that a higher pcp->high doesn't mean we should
> do larger batches. I think what I was trying to get at here was that if
> pcp lists are bigger, some other values might want to scale.
>
> For instance, in nr_pcp_free, pcp->batch is used to determine how many
> pages should be left in the pcplist (and the rest be freed). Should this
> value scale with a bigger pcp? (This is not a rhetorical question, I really
> do want to understand what the implications are here).
>
> Another thing that I would like to note is that pcp->high is actually at
> least in part a function of pcp->batch. In decay_pcp_high, we set
>
> pcp->high = max3(pcp->count - (batch << CONFIG_PCP_BATCH_SCALE_MAX), ...)
>
> So here, it seems like a higher batch value would actually lead to a much
> lower pcp->high instead. This actually seems actively harmful to the system.

Batch here is used to control the latency to free the pages from PCP to
buddy.  Larger batch will lead to larger latency, however it helps to
reduce the size of PCP more quickly when it becomes idle.  So, we need
to balance here.

> So I'll do a take two of this patch and take your advice below and instead
> of getting rid of the /= 4, just fold it in (or add a better explanation)
> as to why we do this. Another candidate place to do this seems to be
> where we do the rounddown_pow_of_two.
>
>> So I dunno... f someone wanted to alter the initial batch size, they'd
>> ideally repeat some of Ying's experiments from: 52166607ecc9 ("mm:
>> restrict the pcp batch scale factor to avoid too long latency").
>
> I ran a few very naive and quick tests on kernel builds, and it seems like
> for larger machines (1TB memory, 316 processors), this leads to a very
> significant speedup in system time during a kernel compilation (~10%).
>
> But for smaller machines (250G memory, 176 processors) and (62G memory and 36
> processors), this leads to quite a regression (~5%).
>
> So maybe the answer is that this should actually be defined by the machine's
> size. In zone_batchsize, we set the value of the batch to: 
>
> min(zone_managed_pages(zone) >> 10, SZ_1M / PAGE_SIZE)
>
> But maybe it makes sense to let this value grow bigger for larger machines? If
> anything, I think that the experiment results above do show that batch size does
> have an impact on the performance, and the effect can either be positive or
> negative based on the machine's size. I can run some more experiments to 
> see if there's an opportunity to better tune pcp->batch.

In fact, we do have some mechanism to scale batch size dynamically
already, via pcp->alloc_factor and pcp->free_count.

You could further tune them.  Per my understanding, it should be a
balance between throughput and latency.

>> Better yet, just absorb the /=4 into the two existing batch assignments.
>> It will probably compile to exactly the same code and have no functional
>> changes and get rid of the comment.
>> 
>> Wouldn't this compile to the same thing?
>> 
>>         batch = zone->managed_pages / 4096;
>>         if (batch * PAGE_SIZE > 128 * 1024)
>>                 batch = (128 * 1024) / PAGE_SIZE;
>
> But for now, this seems good to me. I'll get rid of the confusing comment,
> and try to fold in the batch value and leave a new comment leaving this
> as an explanation. 
>
> Thank you for your thoughtful review, Dave. I hope you have a great day!
> Joshua

---
Best Regards,
Huang, Ying


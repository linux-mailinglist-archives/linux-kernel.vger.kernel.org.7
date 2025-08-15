Return-Path: <linux-kernel+bounces-770050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07738B2763C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D36F175187
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C52F25B66A;
	Fri, 15 Aug 2025 02:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mOpxZTSb"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031C626B0BE
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 02:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755225687; cv=none; b=JR1D3+Ynnz7b25vnsxDUY5ww6rW9R2q30qDvRvUWk9WFVAZXNPcQpiMHFlX+DCG2DigdyVCJBPam1OQyMsFPIO8VXRJCWF1F+O5w1iGINpQ5IpfP9fwu0UgNcygtlputk2BWaQdFI6PmuzJ5XRIMtn0M7zhwRohpopks46THBU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755225687; c=relaxed/simple;
	bh=zQRre9DT9JNXqEojg7ut6X62UsRlcQSj4aRSK05gUkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZSpb1CT+itZIcXUKWywepiuvFxZLTRY5Cl4X83vQGWowcoOtqfOEveVauucGb3EnAaQb5Wi3Fh9w7vKHzbMlEwfkCkk8sOG/f499mu07WBmp3q8dv2d/gtxgrjlJa4EE2gFEmfUuJQdmvyZ+tbuZOC/262GB9LONhRRmxcVOwjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mOpxZTSb; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <be1a8882-fb43-4038-a500-01c3e1a6d577@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755225682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=waVzgAtOi12GgE5yS/99lkSoGQsnDE3UwmJZtXxGlEI=;
	b=mOpxZTSbLfxNoXp5e2h13cpSn1859H5ulR05HsjEyQA5K+tfvtP5JtlCf5X2GxoErJr5sE
	OUTgM7JscK5L2uLEBj+jv2FfpktYyHI0SihUTRvqrkjh/S25sfz8qOj+AXqJiqAgD/FM21
	bn0apTMTP65b6yIoSuCGHjV6S3jkVI8=
Date: Fri, 15 Aug 2025 10:41:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] mm/page_alloc: simplify lowmem_reserve max calculation
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>, Ye Liu <liuye@kylinos.cn>,
 Johannes Weiner <hannes@cmpxchg.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250815023500.36893-1-ye.liu@linux.dev>
 <E5434A0E-3125-48C7-BD25-185CDA4D9FAC@nvidia.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ye Liu <ye.liu@linux.dev>
In-Reply-To: <E5434A0E-3125-48C7-BD25-185CDA4D9FAC@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2025/8/15 10:36, Zi Yan 写道:
> On 14 Aug 2025, at 22:34, Ye Liu wrote:
> 
>> From: Ye Liu <liuye@kylinos.cn>
>>
>> Use max() to find the maximum lowmem_reserve value and min_t() to
>> cap it to managed_pages in calculate_totalreserve_pages(), instead
>> of open-coding the comparisons. No functional change.
>>
>> Signed-off-by: Ye Liu <liuye@kylinos.cn>
>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>> Acked-by: Zi Yan <ziy@nvidia.com>
>>
>> Changes in v2:
>> - Drop unnecessary braces
>> - Replace "if (max > managed_pages)" with min_t()
>> - Link to v1:https://lore.kernel.org/all/20250814090053.22241-1-ye.liu@linux.dev/
>> ---
>>  mm/page_alloc.c | 9 +++------
>>  1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 64872214bc7d..2617fd2f4b73 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -6235,16 +6235,13 @@ static void calculate_totalreserve_pages(void)
>>  			unsigned long managed_pages = zone_managed_pages(zone);
>>
>>  			/* Find valid and maximum lowmem_reserve in the zone */
>> -			for (j = i; j < MAX_NR_ZONES; j++) {
>> -				if (zone->lowmem_reserve[j] > max)
>> -					max = zone->lowmem_reserve[j];
>> -			}
>> +			for (j = i; j < MAX_NR_ZONES; j++)
>> +				max = max(max, zone->lowmem_reserve[j]);
>>
>>  			/* we treat the high watermark as reserved pages. */
>>  			max += high_wmark_pages(zone);
>>
>> -			if (max > managed_pages)
>> -				max = managed_pages;
>> +			min_t(unsigned long, max, managed_pages);
> 
> Should be
> 
> max = min_t(unsigned long, max, managed_pages);
> 
> ;)

Haha I forgot to git add after I modified it ;)

> 
>>
>>  			pgdat->totalreserve_pages += max;
>>
>> -- 
>> 2.43.0
> 
> 
> Best Regards,
> Yan, Zi

-- 
Thanks,
Ye Liu



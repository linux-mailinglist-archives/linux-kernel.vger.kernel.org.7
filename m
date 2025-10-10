Return-Path: <linux-kernel+bounces-848177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 451DDBCCD00
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 13:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C7031A658BF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 11:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA0E2874E9;
	Fri, 10 Oct 2025 11:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEDSlkI1"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB75F286435
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 11:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760097233; cv=none; b=vF2Qqe20cVo5jLZSNZumcw7rPlNgt2mLg2aVc2fblBuWs9oSy5ltzzhOsojafclGmJgK5NQD5LOzalT0VFDZq/d0fKTI5vVNcczdermXhJERMtUD8mNQj0GIeP//7vUCI/ZITuGmYGAlPoqDIhJw7yxoMX02GnBr1OU0ls5kYWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760097233; c=relaxed/simple;
	bh=bcqcC0Uxb3XL55L/gjVHFMkA81wv8+scytsM+4emlys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ajR5xi5s9HOf6B597+/2aLMzyezTuONsQOw5v2I1iingsAgBljr4hDBDeqPWFQp8jHKygXBr7hK+TMhcvOON9yBoR2zlScPbmr6QorU3b3lpcK0oqq67CEUUD04Fg6bAWTtq0cF/QC1PX8/lalQPR2QqEeQJtMujYOmXJsJJ0Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEDSlkI1; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e4ad36541so22133565e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 04:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760097228; x=1760702028; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ve5GXmWmpHi33tEgDSRm/w0MXIwLW/4OvMnLFhI0YcI=;
        b=hEDSlkI1WlLxhN7O5brW4tMWh4grvPhrrvLOq97/Xt1NV/KBByXURF4/FHTk7nMHKj
         yQbmSWC31qrqycm6ayrOUwjro9kTSjj4I9NBxObjg16psE/KAnLC2Z6xQ0CSNR9GeN+i
         HjMttPMFPkKt30ZOAmlzI/tVAuBPSG8s4caLMu8VEMsuhLhsio6ldO1T7/WW5wQXaLhX
         m6iRd7SaME8dmJxIneLrS15B5iWJ2ZyvKNUygocx1SVJS5uiIpm4CYHDOgqB+N3due9a
         ri11B0iWmP6jT2vUY+m7ofxarrfmr6GhRzDU53XFT5Sx8Fm/9lf6TS1F+K6+zcazKwlI
         Wq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760097228; x=1760702028;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ve5GXmWmpHi33tEgDSRm/w0MXIwLW/4OvMnLFhI0YcI=;
        b=aLXADUChARrXfiOEkzFz2McFUyq2jc5loW6Uw8hMkWI0ZDQu1zJyqzwEym0HB42P0Y
         Jwe16oqbXQTKqKpxGup8QB485bY9U6xOf27hSj1cRygtaQjg19crfCMrnsvPM/N9gy2C
         TZmT1+K9mGe3g9XTmTKjqSSEQZiB4Wq+gHkheiOfPF7XJg3UGfh+Fy107tE6SswWQSre
         39Z3fa8SjWxokWoMbd6LzHD7l+q1+OqzY6e6qygi6oeXAlHw5DJfj439xqjyKGgdT4L0
         Qrgh8qI8sZiWXx1c8HNll/H6PxwNB6/mAmXih7nTxV0y7A0MPU8wADtVH6+rFx0hkQu9
         AGhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOlQVGR//7pBkgAhADvR7LO36JC2rT0XCG1fJR/vjnFUA5L4hKTS6sAtUHOc60hMud/9QRCZ51ntquAms=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXubsoXJJppe8bXpAMc+aIQolvOaqtHb7BO+SJEh5r7FQ7BJJl
	GkCU+7cq7k2Pg/3zPfGon1O/0ZCIajw9E/IxCnOmksseVzXCgk9bg/uh
X-Gm-Gg: ASbGncv8TGdhJ78pCko5yKpj0yFILHNYsn9yTIlnq6GK6s1gfPKOwDv18wqNjWrAeGq
	dXAECGA+9GDrEx+xM556AV4KEtSWjjSEb0t4lJv0X0TU9U2BgUHOcwDkQ7icdQlk+xY+ZprMBvv
	dD/DT/T3iAkG5n3fh8SZyqnWx00Uhz8ggSfkwRwlyfvZ0SxxdDoQvd/j7JiaZetPzFeFDf3IYWz
	9U3Kcykol/2vZs0L0dV1MmAKllANrGCN/co331yYMfSqNSwjwyVitSv3NUEhnqp20T2LVlOTGzi
	hg4ggRDlUBx0l8jOSHXncWjjMDVS5CwJAgZDiL1q7el9FBvCbipuqNu4oxYZtY8P7Sbp8myGbZM
	HABpKdBDHnXLQg/ZzA09KAm4ah17tGMGAVAy/YEzNQI07OIKkJGXJcOcuWw3n/PIIWPtzEoA3+S
	F7KhTL2UjW5VexIlF2SumQ5jjINhMZUWrPW4ePYsb2vBdLDCc=
X-Google-Smtp-Source: AGHT+IHsXGyGUJgVXz0ORzGntp6Fic3WHYvB2TK+Q4dKvGuhyzAZu9fH59b5KbN+KiLfkQOaaFGi+w==
X-Received: by 2002:a5d:64c5:0:b0:3d2:9cbf:5b73 with SMTP id ffacd0b85a97d-42666ab9929mr5654537f8f.6.1760097227913;
        Fri, 10 Oct 2025 04:53:47 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e750:1b00:1cfc:9209:4810:3ae5? ([2a02:6b6f:e750:1b00:1cfc:9209:4810:3ae5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5dfc43sm3722424f8f.36.2025.10.10.04.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 04:53:47 -0700 (PDT)
Message-ID: <fb33f2e1-b0fb-49b5-a804-2239ae517aaa@gmail.com>
Date: Fri, 10 Oct 2025 12:53:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm/hugetlb: create hstate_is_gigantic_no_runtime
 helper
Content-Language: en-GB
To: SeongJae Park <sj@kernel.org>
Cc: muchun.song@linux.dev, osalvador@suse.de, david@redhat.com,
 Andrew Morton <akpm@linux-foundation.org>, shakeel.butt@linux.dev,
 linux-mm@kvack.org, hannes@cmpxchg.org, riel@surriel.com, kas@kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20251009191149.57652-1-sj@kernel.org>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20251009191149.57652-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 09/10/2025 20:11, SeongJae Park wrote:
> Hi Usama,
> 
> On Thu,  9 Oct 2025 18:24:30 +0100 Usama Arif <usamaarif642@gmail.com> wrote:
> 
>> This is a common condition used to skip operations that cannot
>> be performed on gigantic pages when runtime support is disabled.
>> This helper is introduced as the condition will exist even more
>> when allowing "overcommit" of gigantic hugepages.
>> No functional change intended with this patch.
> 
> The change looks good to me.  I have a couple of trivial comments below.
> 
>>
>> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>> ---
> 
> I think adding a change log since v1 here, or adding a cover letter with it
> would be nice.
> 

I thought everything needed for the change is there in the commit message for patch 2,
and the first patch was trivial, so didnt add a cover letter. The change from v1 was
trivial as well.

>>  mm/hugetlb.c | 21 ++++++++++++++++-----
>>  1 file changed, 16 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index c07b7192aff26..e74e41386b100 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -134,6 +134,17 @@ static void hugetlb_free_folio(struct folio *folio)
>>  	folio_put(folio);
>>  }
>>  
>> +/*
>> + * Check if the hstate represents gigantic pages but gigantic page
>> + * runtime support is not available. This is a common condition used to
>> + * skip operations that cannot be performed on gigantic pages when runtime
>> + * support is disabled.
>> + */
>> +static inline bool hstate_is_gigantic_no_runtime(struct hstate *h)
>> +{
>> +	return hstate_is_gigantic(h) && !gigantic_page_runtime_supported();
>> +}
>> +
>>  static inline bool subpool_is_free(struct hugepage_subpool *spool)
>>  {
>>  	if (spool->count)
>> @@ -1555,7 +1566,7 @@ static void remove_hugetlb_folio(struct hstate *h, struct folio *folio,
>>  	VM_BUG_ON_FOLIO(hugetlb_cgroup_from_folio_rsvd(folio), folio);
>>  
>>  	lockdep_assert_held(&hugetlb_lock);
>> -	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>> +	if (hstate_is_gigantic_no_runtime(h))
>>  		return;
>>  
>>  	list_del(&folio->lru);
>> @@ -1617,7 +1628,7 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
>>  {
>>  	bool clear_flag = folio_test_hugetlb_vmemmap_optimized(folio);
>>  
>> -	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>> +	if (hstate_is_gigantic_no_runtime(h))
>>  		return;
>>  
>>  	/*
>> @@ -2511,7 +2522,7 @@ static void return_unused_surplus_pages(struct hstate *h,
>>  	/* Uncommit the reservation */
>>  	h->resv_huge_pages -= unused_resv_pages;
>>  
>> -	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>> +	if (hstate_is_gigantic_no_runtime(h))
>>  		goto out;
>>  
>>  	/*
>> @@ -3725,7 +3736,7 @@ static void __init hugetlb_init_hstates(void)
>>  		 * - If CMA allocation is possible, we can not demote
>>  		 *   HUGETLB_PAGE_ORDER or smaller size pages.
>>  		 */
>> -		if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>> +		if (hstate_is_gigantic_no_runtime(h))
>>  			continue;
>>  		if (hugetlb_cma_total_size() && h->order <= HUGETLB_PAGE_ORDER)
>>  			continue;
>> @@ -4202,7 +4213,7 @@ static ssize_t __nr_hugepages_store_common(bool obey_mempolicy,
>>  	int err;
>>  	nodemask_t nodes_allowed, *n_mask;
>>  
>> -	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>> +	if (hstate_is_gigantic_no_runtime(h))
>>  		return -EINVAL;
>>  
>>  	if (nid == NUMA_NO_NODE) {
>> -- 
>> 2.47.3
> 
> It seems the new helper could be used for three more cases.
> 
> On mm-new:
> 
>     $ git grep gigantic_page_runtime_supported mm/hugetlb.c
>     mm/hugetlb.c:   if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>     mm/hugetlb.c:   if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>     mm/hugetlb.c:   if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>     mm/hugetlb.c:   if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>     mm/hugetlb.c:           if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>     mm/hugetlb.c:   if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>     mm/hugetlb.c:   if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>     mm/hugetlb.c:   if (write && hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
> 
> After applying this patch on top of mm-new:
> 
>     $ git grep gigantic_page_runtime_supported mm/hugetlb.c
>     mm/hugetlb.c:   return hstate_is_gigantic(h) && !gigantic_page_runtime_supported();
>     mm/hugetlb.c:   if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>     mm/hugetlb.c:   if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>     mm/hugetlb.c:   if (write && hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
> 
> I'm curious if you are planning to do the conversion later, or there is a
> reason why this patch is keeping those as is but I'm missing.
> 

Yeah what you said in the followup email. I think should be ok now as Andrew has added v2
to mm-new.

Thanks!
Usama
> 
> Thanks,
> SJ



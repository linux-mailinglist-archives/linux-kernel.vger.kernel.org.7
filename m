Return-Path: <linux-kernel+bounces-803308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 781D8B45D4D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D8311BC3817
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F4D31D749;
	Fri,  5 Sep 2025 15:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LHp0aIcY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7292831D74F
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 15:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757087928; cv=none; b=WgO3KdhszKiVQy7MLnvsfdzPEOi7SYo4Yyk7fbvpUcRsxfMyWRxi2oPUqV1tXL5CuDIC++pJJfo6JtHw4BGEZj8ifE76S9xFJxXRkETlvRbPtAHuEWK/zo8El01F7BLpkjLXCiVj39uMBDFPMlpCmKVRrc03ECcf0NEldaS95mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757087928; c=relaxed/simple;
	bh=ClfNbAEP8qya/8XtNqBjOzu/DIwdb5dxS3n+EJhESkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=auoNzCOrK+4c7zvDnNM2JbMsmp5ZDjuVESLg2xy/bpwLkK9s8OnZFYWaDsMe+1qPrOuWZHNLIrAvlKDYEStWVvK1qjEHZIjJrNx4jRS26ZE4UvofHW0qULHLbB5n7gnpXpVGSGIywmWbklLABZSsO3IzBhktPNcI/4vDSfS1E/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LHp0aIcY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757087925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=evLRFYt3UNymMNEcAX6nqhM5iAqoK2ROkZRbyKGwjHg=;
	b=LHp0aIcYy10IlAUusxPh0mqCHQgRWroaivU9AyZQAIRd4JFIiWhBUryVvOYziLfddMDlBb
	pNVldnshWMRGetNwOHQZOKQMS9BevIw8d+N0eCo7Ku54GpTjPAslfZeWCnA86ggQSRN/5C
	bnVIxkpBSeleLzxAW9M6Dd1LMMwTDJw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-sVw57eqQNVe8gajZMqutfg-1; Fri, 05 Sep 2025 11:58:44 -0400
X-MC-Unique: sVw57eqQNVe8gajZMqutfg-1
X-Mimecast-MFC-AGG-ID: sVw57eqQNVe8gajZMqutfg_1757087923
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45b96c2f4ccso14855065e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 08:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757087923; x=1757692723;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=evLRFYt3UNymMNEcAX6nqhM5iAqoK2ROkZRbyKGwjHg=;
        b=KX8PYSX3iDRYA6pwfYY/ZL3o5LFNw4Buqc2sR6iRsoFaVQb5C3N0tF1ZIVqmrj37Qt
         HhEGvCqZb1a4AkKG6qMq1y2m7T6mYjBmNPgaCQLfGGmqhqQPFmVFmadVw07mEDKNwyF8
         Mru8AcHUdkqJllC52KGBsKlgjdhAzYzfJDPhrsZrPEpWlINhLuj5b4nibdy2lF3jlHrg
         ZJMM4ULLH3PpcmkzAa9yLd7txj7453IG1inmqdt7ToEVbBx+aRMZwp55FHIxxkbpdL0X
         5yg0qVc8jijUUYUV3g7p3qhTo3m9WT0r6FZtfUdhL/u9D8i0zsr0ZsKiDZe/LcYL70h8
         K+4g==
X-Forwarded-Encrypted: i=1; AJvYcCVWnx0Ga70A1O82K6mZ1LEGcrgJTMl9pOGX9SIc3tPUqaOTUr9UgToZuVirhNOw8fwWzSXr4Y/Hum0CDmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO7pwKjyttmjkP+PbBXptGD6Zq88Hxhj9VHvGnkAHgjmJ3JhXA
	9vtTST44JgfA6h/K5++hIcZFL26cLWmYIi6WD6czSRPMuA7Y+jFJ/+DXCoeSn4JKj2QaDf11B5n
	xtqHXFk8Z4ZbJIg1rG6YbxzJl4JgqRRkmkwCyp/O5eEv/HXHwxfGThUASyc2IFZvjEg==
X-Gm-Gg: ASbGncv2YqQshpmFYmcDRdzU3EzMCOky7EI4nZOTqVkAstGdzKFBgUcDw37ASRtgtcY
	7NNzvznw5wD/C9JN14xw1vZ2GdhtICBYqum0u3RziL7KgMYzt5Eims5QzQyS+R3gM73jAbtlxIf
	EwuFQxlYtAF9rFKbpB4MyyIGmVEBILMKVszbTP1/JTimwzZhY6xp3kNjBXN1g8z62GXV32FNO+x
	9d6786dOC7uaERVIp2im83l++qhPla50yCzsqX5ieBAYN9lT0H27qs48oTLcwftSK5f0xRw0Qqx
	eNQ/cxXapSettd+0Bv+SIOKIjIEB8iIusJzAyX9cORUJk1rXcXrdlbWWqH5Lh25E4jav3jO2hQK
	CxnR3UcygfkUYMGKmT1mo0jSwJqb5EcXj58PxV2E4jC4Ay2XPXSKgYfHE
X-Received: by 2002:a05:600c:1387:b0:45b:615c:cd2 with SMTP id 5b1f17b1804b1-45b85525da3mr231052785e9.8.1757087922793;
        Fri, 05 Sep 2025 08:58:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlYTbzshuwgip8AqARcntuswSYuXuNnM+V4fp0Ahk+2j2BHbQnTrjYIr7ArN49BJka1MwcfQ==
X-Received: by 2002:a05:600c:1387:b0:45b:615c:cd2 with SMTP id 5b1f17b1804b1-45b85525da3mr231052395e9.8.1757087922244;
        Fri, 05 Sep 2025 08:58:42 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4d:e00:298:59cc:2514:52? (p200300d82f4d0e00029859cc25140052.dip0.t-ipconnect.de. [2003:d8:2f4d:e00:298:59cc:2514:52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f306c93sm420569445e9.14.2025.09.05.08.58.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 08:58:41 -0700 (PDT)
Message-ID: <701d2994-5b9a-4657-a616-586652f42df5@redhat.com>
Date: Fri, 5 Sep 2025 17:58:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/huge_memory: fix shrinking of all-zero THPs with
 max_ptes_none default
To: Usama Arif <usamaarif642@gmail.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>
References: <20250905141137.3529867-1-david@redhat.com>
 <06874db5-80f2-41a0-98f1-35177f758670@gmail.com>
 <1aa5818f-eb75-4aee-a866-9d2f81111056@redhat.com>
 <8b9ee2fe-91ef-4475-905c-cf0943ada720@gmail.com>
 <b56b43c1-d49d-4302-a171-9b00bf9cfa54@redhat.com>
 <8461f6df-a958-4c34-9429-d6696848a145@gmail.com>
 <3737e6e5-9569-464c-8cd0-1ec9888be04b@redhat.com>
 <3c857cdb-01d0-4884-85c1-dfae46d8e4a0@gmail.com>
 <aadf50b1-151b-41c6-b60c-5f1f2a4f2d8e@redhat.com>
 <d48af6f4-2ded-40f5-849d-7aa991727a59@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <d48af6f4-2ded-40f5-849d-7aa991727a59@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05.09.25 17:53, Usama Arif wrote:
> 
> 
> On 05/09/2025 16:28, David Hildenbrand wrote:
>> On 05.09.25 17:16, Usama Arif wrote:
>>>
>>>
>>> On 05/09/2025 16:04, David Hildenbrand wrote:
>>>> On 05.09.25 17:01, Usama Arif wrote:
>>>>>
>>>>>
>>>>> On 05/09/2025 15:58, David Hildenbrand wrote:
>>>>>> On 05.09.25 16:53, Usama Arif wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 05/09/2025 15:46, David Hildenbrand wrote:
>>>>>>>> [...]
>>>>>>>>
>>>>>>>>>
>>>>>>>>> The reason I did this is for the case if you change max_ptes_none after the THP is added
>>>>>>>>> to deferred split list but *before* memory pressure, i.e. before the shrinker runs,
>>>>>>>>> so that its considered for splitting.
>>>>>>>>
>>>>>>>> Yeah, I was assuming that was the reason why the shrinker is enabled as default.
>>>>>>>>
>>>>>>>> But in any sane system, the admin would enable the shrinker early. If not, we can look into handling it differently.
>>>>>>>
>>>>>>> Yes, I do this as well, i.e. have a low value from the start.
>>>>>>>
>>>>>>> Does it make sense to disable shrinker if max_ptes_none is 511? It wont shrink
>>>>>>> the usecase you are describing below, but we wont encounter the increased CPU usage.>
>>>>>>
>>>>>> I don't really see why we should do that.
>>>>>>
>>>>>> If the shrinker is a problem than the shrinker should be disabled. But if it is enabled, we should be shrinking as documented.
>>>>>>
>>>>>> Without more magic around our THP toggles (we want less) :)
>>>>>>
>>>>>> Shrinking happens when we are under memory pressure, so I am not really sure how relevant the scanning bit is, and if it is relevant enought to change the shrinker default.
>>>>>>
>>>>>
>>>>> yes agreed, I also dont have numbers to back up my worry, its all theoretical :)
>>>>
>>>> BTW, I was also wondering if we should just always add all THP to the deferred split list, and make the split toggle just affect whether we process them or not (scan or not).
>>>>
>>>> I mean, as a default we add all of them to the list already right now, even though nothing would ever get reclaimed as default.
>>>>
>>>> What's your take?
>>>>
>>>
>>> hmm I probably didnt understand what you meant to say here:
>>> we already add all of them to the list in __do_huge_pmd_anonymous_page and collapse_huge_page and
>>> shrink_underused sets/clears split_underused_thp in deferred_split_folio decides whether we process or not.
>>
>> This is what I mean:
>>
>> commit 3952b6f6b671ca7d69fd1783b1abf4806f90d436 (HEAD -> max_ptes_none)
>> Author: David Hildenbrand <david@redhat.com>
>> Date:   Fri Sep 5 17:22:01 2025 +0200
>>
>>      mm/huge_memory: always add THPs to the deferred split list
>>          When disabling the shrinker and then re-enabling it, any anon THPs
>>      allocated in the meantime.
>>          That also means that we cannot disable the shrinker as default during
>>      boot, because we would miss some THPs later when enabling it.
>>          So always add them to the deferred split list, and only skip the
>>      scanning if the shrinker is disabled.
>>          This is effectively what we do on all systems out there already, unless
>>      they disable the shrinker.
>>          Signed-off-by: David Hildenbrand <david@redhat.com>
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index aa3ed7a86435b..3ee857c1d3754 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -4052,9 +4052,6 @@ void deferred_split_folio(struct folio *folio, bool partially_mapped)
>>          if (folio_order(folio) <= 1)
>>                  return;
>>   
>> -       if (!partially_mapped && !split_underused_thp)
>> -               return;
>> -
>>          /*
>>           * Exclude swapcache: originally to avoid a corrupt deferred split
>>           * queue. Nowadays that is fully prevented by memcg1_swapout();
>> @@ -4175,6 +4172,8 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>>                  bool underused = false;
>>   
>>                  if (!folio_test_partially_mapped(folio)) {
>> +                       if (!split_underused_thp)
>> +                               goto next;
>>                          underused = thp_underused(folio);
>>                          if (!underused)
>>                                  goto next;
>>
>>
> 
> 
> Thanks for sending the diff! Now I know what you meant lol.
> 
> In the case of when shrinker is disabled, this could make the deferred split scan for partially mapped folios
> very ineffective?

I hope you realize that that's the default on each and every system out 
there that ships this feature :)

And don't ask me how many people even know about disabling the shrinker 
or would do it, when the default setting is mostly not splitting many 
THPs ever.

> 
> I am making up numbers, but lets there are 128 THPs in the system, only 2 of them are partially mapped
> and sc->nr_to_scan is 32.
> 
> In the current code, with shrinker disabled, only the 2 partially mapped THPs will be on the deferred list, so
> we will reclaim them in the first go.
> 
> With your patch, the worst case scenario is that the partially mapped THPs are at the end of the deferred_list
> and we would need 4 calls for the shrinker to split them.

Probably at some point we would want split lists as well, not sure how 
feasible that is.

-- 
Cheers

David / dhildenb



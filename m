Return-Path: <linux-kernel+bounces-803467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE71B46015
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 993C31C26AE9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D202E3191B1;
	Fri,  5 Sep 2025 17:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXc8nUHv"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BA53191A3
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 17:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757093177; cv=none; b=r8dO/DdHAcEBQXZEGRPLn7XHITJGIUEAuMi39jDED/5gEkVFBZqX43j0EPJ33Oft9KbVD2THP0CSCMfdVMtyZeg4yU1L5XxU+bhQkuAR39tY1Ay6ZWQRhVuDCEejaOOOji2Wf1e7TjUQGt+KliCf7IixWEJh/FYaAX7bAUlveXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757093177; c=relaxed/simple;
	bh=nwipSYFch7mJOSHwcIjg+J78Ta+mHcloN6HzZw9dECs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gxVP2qTMTNEiDHpnEHj2NncUNK7uJ/CxOxti085aGPMQKfJofk3UIxqViSa0BXVlt3nH+bLjxVyTNEla5NwInSbDX2SWtlJ2ZMalL1v1YIwRvwhBDToYwq4rnRjcGnPsR+PXOBwmo8xuoz7/gPpy8K5DzozS+38VXEJExWV6YLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXc8nUHv; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45b83ae1734so14377225e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 10:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757093174; x=1757697974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ooESiIT2PTrPysB+HjiZ1lBM810ZvxTg7+P+/fx8htE=;
        b=WXc8nUHvQH/WEllXgeyB2F2DYbY9x74miXHIZnUxE53WAoBNRUsZ2izvGrUL552PZP
         nAmtllBLmCudZV724M2gJg00fOm/NfjDbkXxwpkbVinrN7+OjPUsHaFi1P3b8HJn7fSG
         w5fUcKf9PWa5ypbirCpOix5LEmgzdbu6/q9m34vTusyXeAvj7rC11Q316ljl10mek3bk
         k+gchFOkEri7uh+YlBHlR5b1SrQIk7GpCNmVOI57uqgUF8yoR4utzVcZ73sS4bmA1kiu
         GxxaZLRnQSBr/HOTC1gCCiuO2SiKRCuLYMUzErpjhKSwzIKafOtlwYhZOMN+yjuJZseE
         kLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757093174; x=1757697974;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ooESiIT2PTrPysB+HjiZ1lBM810ZvxTg7+P+/fx8htE=;
        b=SwlrsE7oyoPRVsIWmORbR9yb1ir0AbnsBZl0zJh2W1BfLwlTgkM3VNKawM9+8WqjOe
         zcCQqYg6InJRkjxrdFAOwwtbiPbFrc3QPiZ9LtVDci7MR9/Ta+P6NyMLg6eraKJ6oXc3
         NINNspr5UdSBHEXAdkZMi+/CJegv1sKdQHd4fon296Y71oQgLsb3GtglNik8tyPmK4BD
         m7FWw395WG2ARdTElm2XOGAGGQyp8EUHehcXpUIOhqfd+vdEUaGNBM5+8+ez0ecd2lry
         aniiTIREFOIxykH0d4jaBZYXqj4muW3oW3R7rfwsZwQdX1b8k75V885C7mv/RE8HQjtY
         briw==
X-Forwarded-Encrypted: i=1; AJvYcCXaos/9w3vqB9XF/CvzbKcmjZjFvdX4+KJtFpQfrdoxWEVMdP6CsLYIxW1S+TDNV2yDNH9vu3gTfrPqXsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEmksjrW3V61++E+ubo/IwY2j+8SHIy8vUWjy9rH5jQpFIlpzW
	ldTQxQvqcxhttdRhkzh4wNg2i8cmtJIYEb6bLCOxaiN9YjWaQzdmLUhvsdityYAemg8=
X-Gm-Gg: ASbGncv2NGHZM/5YnO62xWbiLVr2DwST3jIJduOW/YFCpWmzWfLkHckllJvNeuYLlS6
	pNyQPeS1iJVwrJl8Qjv6R0dR61R4vrc9W7QFzlajMthZVxm0bry3WafUBQt0+A5fvzh3XKCZ2Rw
	hlE5XRCRJTTedZadZoQdbNG4gIJVnWvEp7SmSY94Lrch6sCHDIQaWOK8esWFImOK3j0guLHDx5B
	8hNhbagm9JikaYN7mMOQNdSVLLzqJfxWFo/qu1EyUclCSGE/c8FjEgYqkMUBBOez/gOtGgwFTyL
	M3hvQ2nEtTkOR0Fn/HoZ+IwWC2u1k+DJ5EMfGX8uPcueooflKBKUMGKUuYExgDw7qdw+DaWiK5K
	zvEzoKdoZhRYwXPN79ePcXjECbeRADms6embML1SiydYZi8Z4hVb6MvbCDR+DJ3hdyaVla6ITXr
	l6e7hwUAFJyBPnFev8
X-Google-Smtp-Source: AGHT+IGuXOAtZGlrnCDZRD4Elkxv1y7QaZdSaYKheUgsosykLW5TYqK3L/+DcanNmkvR/66rN5X24Q==
X-Received: by 2002:a05:600c:4e8e:b0:45c:b601:660a with SMTP id 5b1f17b1804b1-45cb6016789mr85243605e9.23.1757093174153;
        Fri, 05 Sep 2025 10:26:14 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:1449:d619:96c0:8e08? ([2620:10d:c092:500::4:4f66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fbb3cdsm15949824f8f.51.2025.09.05.10.26.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 10:26:13 -0700 (PDT)
Message-ID: <27460707-3d93-4ff2-bc99-da96d26758e9@gmail.com>
Date: Fri, 5 Sep 2025 18:26:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/huge_memory: fix shrinking of all-zero THPs with
 max_ptes_none default
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
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
 <701d2994-5b9a-4657-a616-586652f42df5@redhat.com>
 <686943a6-7043-41b0-bd4c-2bfc4463d49b@gmail.com>
 <e41c8d5d-5685-49f4-a5f5-87513674a03b@redhat.com>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <e41c8d5d-5685-49f4-a5f5-87513674a03b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 05/09/2025 17:55, David Hildenbrand wrote:
> On 05.09.25 18:47, Usama Arif wrote:
>>
>>
>> On 05/09/2025 16:58, David Hildenbrand wrote:
>>> On 05.09.25 17:53, Usama Arif wrote:
>>>>
>>>>
>>>> On 05/09/2025 16:28, David Hildenbrand wrote:
>>>>> On 05.09.25 17:16, Usama Arif wrote:
>>>>>>
>>>>>>
>>>>>> On 05/09/2025 16:04, David Hildenbrand wrote:
>>>>>>> On 05.09.25 17:01, Usama Arif wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 05/09/2025 15:58, David Hildenbrand wrote:
>>>>>>>>> On 05.09.25 16:53, Usama Arif wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 05/09/2025 15:46, David Hildenbrand wrote:
>>>>>>>>>>> [...]
>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> The reason I did this is for the case if you change max_ptes_none after the THP is added
>>>>>>>>>>>> to deferred split list but *before* memory pressure, i.e. before the shrinker runs,
>>>>>>>>>>>> so that its considered for splitting.
>>>>>>>>>>>
>>>>>>>>>>> Yeah, I was assuming that was the reason why the shrinker is enabled as default.
>>>>>>>>>>>
>>>>>>>>>>> But in any sane system, the admin would enable the shrinker early. If not, we can look into handling it differently.
>>>>>>>>>>
>>>>>>>>>> Yes, I do this as well, i.e. have a low value from the start.
>>>>>>>>>>
>>>>>>>>>> Does it make sense to disable shrinker if max_ptes_none is 511? It wont shrink
>>>>>>>>>> the usecase you are describing below, but we wont encounter the increased CPU usage.>
>>>>>>>>>
>>>>>>>>> I don't really see why we should do that.
>>>>>>>>>
>>>>>>>>> If the shrinker is a problem than the shrinker should be disabled. But if it is enabled, we should be shrinking as documented.
>>>>>>>>>
>>>>>>>>> Without more magic around our THP toggles (we want less) :)
>>>>>>>>>
>>>>>>>>> Shrinking happens when we are under memory pressure, so I am not really sure how relevant the scanning bit is, and if it is relevant enought to change the shrinker default.
>>>>>>>>>
>>>>>>>>
>>>>>>>> yes agreed, I also dont have numbers to back up my worry, its all theoretical :)
>>>>>>>
>>>>>>> BTW, I was also wondering if we should just always add all THP to the deferred split list, and make the split toggle just affect whether we process them or not (scan or not).
>>>>>>>
>>>>>>> I mean, as a default we add all of them to the list already right now, even though nothing would ever get reclaimed as default.
>>>>>>>
>>>>>>> What's your take?
>>>>>>>
>>>>>>
>>>>>> hmm I probably didnt understand what you meant to say here:
>>>>>> we already add all of them to the list in __do_huge_pmd_anonymous_page and collapse_huge_page and
>>>>>> shrink_underused sets/clears split_underused_thp in deferred_split_folio decides whether we process or not.
>>>>>
>>>>> This is what I mean:
>>>>>
>>>>> commit 3952b6f6b671ca7d69fd1783b1abf4806f90d436 (HEAD -> max_ptes_none)
>>>>> Author: David Hildenbrand <david@redhat.com>
>>>>> Date:   Fri Sep 5 17:22:01 2025 +0200
>>>>>
>>>>>       mm/huge_memory: always add THPs to the deferred split list
>>>>>           When disabling the shrinker and then re-enabling it, any anon THPs
>>>>>       allocated in the meantime.
>>>>>           That also means that we cannot disable the shrinker as default during
>>>>>       boot, because we would miss some THPs later when enabling it.
>>>>>           So always add them to the deferred split list, and only skip the
>>>>>       scanning if the shrinker is disabled.
>>>>>           This is effectively what we do on all systems out there already, unless
>>>>>       they disable the shrinker.
>>>>>           Signed-off-by: David Hildenbrand <david@redhat.com>
>>>>>
>>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>>> index aa3ed7a86435b..3ee857c1d3754 100644
>>>>> --- a/mm/huge_memory.c
>>>>> +++ b/mm/huge_memory.c
>>>>> @@ -4052,9 +4052,6 @@ void deferred_split_folio(struct folio *folio, bool partially_mapped)
>>>>>           if (folio_order(folio) <= 1)
>>>>>                   return;
>>>>>    -       if (!partially_mapped && !split_underused_thp)
>>>>> -               return;
>>>>> -
>>>>>           /*
>>>>>            * Exclude swapcache: originally to avoid a corrupt deferred split
>>>>>            * queue. Nowadays that is fully prevented by memcg1_swapout();
>>>>> @@ -4175,6 +4172,8 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>>>>>                   bool underused = false;
>>>>>                     if (!folio_test_partially_mapped(folio)) {
>>>>> +                       if (!split_underused_thp)
>>>>> +                               goto next;
>>>>>                           underused = thp_underused(folio);
>>>>>                           if (!underused)
>>>>>                                   goto next;
>>>>>
>>>>>
>>>>
>>>>
>>>> Thanks for sending the diff! Now I know what you meant lol.
>>>>
>>>> In the case of when shrinker is disabled, this could make the deferred split scan for partially mapped folios
>>>> very ineffective?
>>>
>>> I hope you realize that that's the default on each and every system out there that ships this feature :)
>>>
>>
>> Yes, I made it default :)
>>
>> I am assuming people either keep shrinker enabled (which is an extremely large majority as its default), or disable shrinker
>> and they dont flip flop between the 2 settings.
>> There are 2 scenarios for the above patch:
>>
>> - shrinker is enabled (default): the above patch wont make a difference.
>> - shrinker is disabled: the above patch makes splitting partially mapped folios inefficient.
>>
>> I didnt talk about the shrinker enabled case as it was a no-op and just talked about the shrinker disabled
>> case.
> 
> 
> Yeah, and I am saying that all you raised as a concern would be a problem already today in all default setups (-> 99.999999%). :)
> 
> Probably we should not just disable the shrinker during boot, and once enabled, it would only split THPs created afterwards.
> 

I probably didnt understand this again lol. Sorry its friday evening :)

split_underused_thp is true at boot time [1]. You are saying we should not disable shrinker during boot, but it is already not
disabled during boot, right?


If someone goes with system default, which is THP shrinker enabled (from boot and runtime), the above patch is a no-op, right?


> With this patch it would also split ones created previously.
> 

yes, if someone changes from shrinker being disabled to shrinker being enabled before memory pressure.

[1] https://elixir.bootlin.com/linux/v6.16.4/source/mm/huge_memory.c#L76


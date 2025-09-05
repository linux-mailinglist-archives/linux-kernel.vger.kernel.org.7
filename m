Return-Path: <linux-kernel+bounces-803395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A8FB45E97
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AEC53BD4EA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889882FB0A2;
	Fri,  5 Sep 2025 16:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JokyxNZW"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EAB13D521
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 16:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757090840; cv=none; b=MTF1K3i++Il1N5CTwAdkzJqdvxldNViDzLTJDoNQlRCi/PnMZ3W9a6LULgt3ZzUretmK/vZAtP9g4u7YNVcX7H9MU0ToLQ8ttbKtCm1kdMY+g1DrgDWdtZ7Uw5kpgxvI9ySznwipGAowxx5DfxvRBwGzW57KKOp8/3PZ2I+/HNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757090840; c=relaxed/simple;
	bh=dpfcJu4YfZ7vz0IvQLn+gQ32YF4EXdycGGRFUqELWtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pw1hERfE52G/Zr1Z02Z24uYg4daMvC4b/6HXiKSg10ifqJIQwSBoCIigUsuS1eewoXv1Rnb8+ml8AE/oQh6vV8lSoKr/8Ju6IyIchW9MyNpV+hhAcvx2dWT42K2lEdY8TVzdUR6ZUneUrqrG829kCH/vCuRqaJZ8mvJhUEB/C0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JokyxNZW; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45cb5492350so15723365e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 09:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757090837; x=1757695637; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gRrdweLgJOS6vEQgU0/6/0qTHPBWxDHqLnPQbnJbTIU=;
        b=JokyxNZWYi6w1e6+xRZ2HHA5004fneYXRhK0pFUE5xucjVzZIKcwWrg84RBpUqLxVP
         lwjTJDQ5FxuDyENz4bwVeg2Y+cit4dQI1xENs+HpzjPeyePLAysXENY08M/U8AnHx98b
         8svz6UeWhFskHNc7sewoN2+q+pN2bxEOJoH5TRbmPoaPdfYznHQ7A8Vd+lXz/wUebTDk
         zeH9xx0ddIUW8b2hamCHQ1F+WdY4j1QjlHP8NXD1qN7i8gaVQHvsbT0Gt9r1nPpewzdo
         qmGyG+SyegJQoMKRVWSViE3IYlT+Yaxuv6zeMhHGsqdOmfO0lNqf+qdm5Dbc0I62S3AN
         7aJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757090837; x=1757695637;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gRrdweLgJOS6vEQgU0/6/0qTHPBWxDHqLnPQbnJbTIU=;
        b=EJhzWifHQTTVtHv0R4F6jqxcGGaI5/tWCk218W4DuBb7qjk6AOTwiZjb/wjqFtCOzJ
         Fg6VJw4JxMYP7H+sCrUBlx8iuJdGYeViUDX9oZDJSiPzrmj816Z9bSiAf0A8nkPQcQPV
         ncC0dBt37x569imt48rGM+hC8rbjx55E+YVMG3sGqqLCXZQtrq7h/1Woie/2tVL9n7sD
         YA//jO9h7+4HJotGThYCzm/mMMeIqP3Ixj3LmwSxIJMi3w0l1cVITlSJUyFiZhdkE6sm
         EV1xvMWYVoBZrcaDjoua1LbFwt0MGGgw6PuUm6yAFQKFZSoYertPm3K4UBHCJKSIo8Ae
         YiRw==
X-Forwarded-Encrypted: i=1; AJvYcCUEAk3kh+nehrDD8nxnO3Eb93fc0rvPyTZQ6msneKUeTcEEYgyqugB1KvPMrQgez5vvZJCa+F3JCPf+qbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbSeYhTvtT9SFwWNa3A4vn5u/myIfK0jzGRBHzMjpv3tDfcMV5
	hlbSUJ2OF5437WEKRXYhbIoD21lWHkfsQ7fD1nYLdCSwq7W8wtcjfnl8
X-Gm-Gg: ASbGnctJMz00kV1Q8UCbRmhoKKpa8aauEkqqk8tNk0wcpO6r8gVplLM/ZMHbnxl+BfA
	pbtHrslq7RhcgoaihG9pBYN+DAbe90fV+ybZ7wYh6jYeg91hA5uCpftXm11JDdnHhtDS4y312yk
	KzSokKqV9rMZ3oGWgd3OLfZXuMB+mcsxfffutR1iNf0eYoDfu5aZ2BIwnBFUhczdIh+WWXYhI7C
	0T16EuurEkr1ZfVt8z9mJbNyE0umPNxfFlP51Ewnbm0m/LmgNpZaw05dMffWPPugLnPUIxjB5he
	3X7C8Yn+Kwo42xdukFL3o38wqRVwqHZz2BTYr7D66gr9PndAjLBcSY7nijoheHe2e1UA5N7hkGp
	Tnpc6dkwiaKY3v5T6EyIBnMXvl1QtWv4CFTP11vgY8Kv9+ZZVbnrcmM3TdUwDBCO2X/kkW47hz9
	BEjP9vfw==
X-Google-Smtp-Source: AGHT+IEx8F86Izc5zxqbrnq8C/dmorHzseUBfJEoURTnPa//1n1TwYj5OtK6ZAouLmKwItByNHp0BQ==
X-Received: by 2002:a05:600c:1d18:b0:45d:d522:5b2c with SMTP id 5b1f17b1804b1-45dd5432112mr35730335e9.34.1757090837003;
        Fri, 05 Sep 2025 09:47:17 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:1449:d619:96c0:8e08? ([2620:10d:c092:500::4:4f66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d7ac825b88sm19067298f8f.7.2025.09.05.09.47.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 09:47:16 -0700 (PDT)
Message-ID: <686943a6-7043-41b0-bd4c-2bfc4463d49b@gmail.com>
Date: Fri, 5 Sep 2025 17:47:13 +0100
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
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <701d2994-5b9a-4657-a616-586652f42df5@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 05/09/2025 16:58, David Hildenbrand wrote:
> On 05.09.25 17:53, Usama Arif wrote:
>>
>>
>> On 05/09/2025 16:28, David Hildenbrand wrote:
>>> On 05.09.25 17:16, Usama Arif wrote:
>>>>
>>>>
>>>> On 05/09/2025 16:04, David Hildenbrand wrote:
>>>>> On 05.09.25 17:01, Usama Arif wrote:
>>>>>>
>>>>>>
>>>>>> On 05/09/2025 15:58, David Hildenbrand wrote:
>>>>>>> On 05.09.25 16:53, Usama Arif wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 05/09/2025 15:46, David Hildenbrand wrote:
>>>>>>>>> [...]
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> The reason I did this is for the case if you change max_ptes_none after the THP is added
>>>>>>>>>> to deferred split list but *before* memory pressure, i.e. before the shrinker runs,
>>>>>>>>>> so that its considered for splitting.
>>>>>>>>>
>>>>>>>>> Yeah, I was assuming that was the reason why the shrinker is enabled as default.
>>>>>>>>>
>>>>>>>>> But in any sane system, the admin would enable the shrinker early. If not, we can look into handling it differently.
>>>>>>>>
>>>>>>>> Yes, I do this as well, i.e. have a low value from the start.
>>>>>>>>
>>>>>>>> Does it make sense to disable shrinker if max_ptes_none is 511? It wont shrink
>>>>>>>> the usecase you are describing below, but we wont encounter the increased CPU usage.>
>>>>>>>
>>>>>>> I don't really see why we should do that.
>>>>>>>
>>>>>>> If the shrinker is a problem than the shrinker should be disabled. But if it is enabled, we should be shrinking as documented.
>>>>>>>
>>>>>>> Without more magic around our THP toggles (we want less) :)
>>>>>>>
>>>>>>> Shrinking happens when we are under memory pressure, so I am not really sure how relevant the scanning bit is, and if it is relevant enought to change the shrinker default.
>>>>>>>
>>>>>>
>>>>>> yes agreed, I also dont have numbers to back up my worry, its all theoretical :)
>>>>>
>>>>> BTW, I was also wondering if we should just always add all THP to the deferred split list, and make the split toggle just affect whether we process them or not (scan or not).
>>>>>
>>>>> I mean, as a default we add all of them to the list already right now, even though nothing would ever get reclaimed as default.
>>>>>
>>>>> What's your take?
>>>>>
>>>>
>>>> hmm I probably didnt understand what you meant to say here:
>>>> we already add all of them to the list in __do_huge_pmd_anonymous_page and collapse_huge_page and
>>>> shrink_underused sets/clears split_underused_thp in deferred_split_folio decides whether we process or not.
>>>
>>> This is what I mean:
>>>
>>> commit 3952b6f6b671ca7d69fd1783b1abf4806f90d436 (HEAD -> max_ptes_none)
>>> Author: David Hildenbrand <david@redhat.com>
>>> Date:   Fri Sep 5 17:22:01 2025 +0200
>>>
>>>      mm/huge_memory: always add THPs to the deferred split list
>>>          When disabling the shrinker and then re-enabling it, any anon THPs
>>>      allocated in the meantime.
>>>          That also means that we cannot disable the shrinker as default during
>>>      boot, because we would miss some THPs later when enabling it.
>>>          So always add them to the deferred split list, and only skip the
>>>      scanning if the shrinker is disabled.
>>>          This is effectively what we do on all systems out there already, unless
>>>      they disable the shrinker.
>>>          Signed-off-by: David Hildenbrand <david@redhat.com>
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index aa3ed7a86435b..3ee857c1d3754 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -4052,9 +4052,6 @@ void deferred_split_folio(struct folio *folio, bool partially_mapped)
>>>          if (folio_order(folio) <= 1)
>>>                  return;
>>>   -       if (!partially_mapped && !split_underused_thp)
>>> -               return;
>>> -
>>>          /*
>>>           * Exclude swapcache: originally to avoid a corrupt deferred split
>>>           * queue. Nowadays that is fully prevented by memcg1_swapout();
>>> @@ -4175,6 +4172,8 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>>>                  bool underused = false;
>>>                    if (!folio_test_partially_mapped(folio)) {
>>> +                       if (!split_underused_thp)
>>> +                               goto next;
>>>                          underused = thp_underused(folio);
>>>                          if (!underused)
>>>                                  goto next;
>>>
>>>
>>
>>
>> Thanks for sending the diff! Now I know what you meant lol.
>>
>> In the case of when shrinker is disabled, this could make the deferred split scan for partially mapped folios
>> very ineffective?
> 
> I hope you realize that that's the default on each and every system out there that ships this feature :)
> 

Yes, I made it default :)

I am assuming people either keep shrinker enabled (which is an extremely large majority as its default), or disable shrinker
and they dont flip flop between the 2 settings.
There are 2 scenarios for the above patch:

- shrinker is enabled (default): the above patch wont make a difference.
- shrinker is disabled: the above patch makes splitting partially mapped folios inefficient.

I didnt talk about the shrinker enabled case as it was a no-op and just talked about the shrinker disabled
case.

> And don't ask me how many people even know about disabling the shrinker or would do it, when the default setting is mostly not splitting many THPs ever.
> 
>>
>> I am making up numbers, but lets there are 128 THPs in the system, only 2 of them are partially mapped
>> and sc->nr_to_scan is 32.
>>
>> In the current code, with shrinker disabled, only the 2 partially mapped THPs will be on the deferred list, so
>> we will reclaim them in the first go.
>>
>> With your patch, the worst case scenario is that the partially mapped THPs are at the end of the deferred_list
>> and we would need 4 calls for the shrinker to split them.
> 
> Probably at some point we would want split lists as well, not sure how feasible that is.
> 



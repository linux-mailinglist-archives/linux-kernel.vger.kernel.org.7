Return-Path: <linux-kernel+bounces-805399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DCCB4880E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CD08169B45
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1721B2E9EA1;
	Mon,  8 Sep 2025 09:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C9WM93mn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35311DA23
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 09:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757322895; cv=none; b=p9C1VSHnV/gCQz4DSqasyi2AMijqviUyn7LNSKNcVdjJrPbwuDheuTjyY9uldC0N1SBb6glAfzMifmPU2SCUtVucKrsYPiwlI+QmUQTIMlAv+3MQkBrI2LiL61RWLK6BN4UHHvKdT0RZW+BGYe6KlVIysTqKrD1+PqGt5V6Cq9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757322895; c=relaxed/simple;
	bh=lJZ/yCvkMzmioXpRL2X+tfpI/HV3j+Qqm8DpY7BML00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eme2WNAvnnnPq3eYJuBdZw18GPM6GLQf9JFPE8lPGugIMKNyObTMOhS2cSm7ZqpEJg2YvUa2lIH6SmoP424pelW+n0uuqQNnNACph6UKc5pddev+AktLDTBKBukzgahBoAVMCZJYX2C1sNd64h++9TtfDsEhPMqos1YA5M9m/y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C9WM93mn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757322891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mzcPvwRTvfDw+yZlp7hvvbxIV0w0du39GWUeSOlm0y8=;
	b=C9WM93mnxb4u982W4rB7Clp2quFpVRjw9bq49XX7BZS7aTvEdheddr4JKKzDZgKQ7PfuJ0
	qGPWvTMAJ35S1o4jjjEnR5ZgATs9EkQH9INVZa6nqyK+aevL9fHrYCsUGN6WWISLfKslJL
	bdZZ9eKwJ1CrohoIk76sjiGFh1GUedA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-GJutnec9MSS_QrlU4Tvzig-1; Mon, 08 Sep 2025 05:14:50 -0400
X-MC-Unique: GJutnec9MSS_QrlU4Tvzig-1
X-Mimecast-MFC-AGG-ID: GJutnec9MSS_QrlU4Tvzig_1757322890
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3d3d2472b92so2290437f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 02:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757322889; x=1757927689;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mzcPvwRTvfDw+yZlp7hvvbxIV0w0du39GWUeSOlm0y8=;
        b=B6HDwuEOvUK1B2ignFOMW+6+8XIwm1n08D2KjTwK86qfaiB1B5vR41XYF4lurzqcHr
         CzSB5aNWfE+nkfNNKSd7bNIuhFYsWa39b6ovpJlQtIa0mBorVoO/s3ErOab7eYs9+8Cg
         663NqqB2czRXGUQzV3C6s8KOt2kjo0qhNMkmjaDoahZ31wAm97nWzhaS/fRTzhWRWKGv
         dhiQ/Wst1p4x7AeIgms3j5yp/Ko1Hu+eyb6qHxVi6ZH0+mznSDjmKWtCi0rZR7B+cuLa
         3DeJiWvMMCsGPi7OcodkSm9dQU44C5xFY98cjAp61sUJkp2n40TBobrTfl/Iui/bHhQ1
         47ug==
X-Forwarded-Encrypted: i=1; AJvYcCUoiFBmJjYPDX1rwC7C/3bdUAbIdZH3t8LdLUpnNExqRbohmEWhDOhgsnOtds2fGq7BtZKxnsUBM0Bv54o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz076bRkVbJio21xko63XyaCBSaFj2c8GfwmkAAjs7rDzHClrqk
	en7V9L5tN7dRx4EiXDv2PrSJgCu3BI30j8EosCSp9rryGW7WjoldwFXZDBYWC9JQZyMaUl2Xyfp
	dfmGtQWRmTiwNgyJIGtycyw/5azcOwo9BDjcutEYsW1tubC55NOVCTS43UqShws+t3e2KJUlU5g
	==
X-Gm-Gg: ASbGncvziCGNYCIX4+xv5ozw/xyumhyXPf8O873b8KNYft8DQvQqnWKBvTyBRfgpzXs
	prwD+j7mm+VPMZiegTnBB8wEleC9eVf6SALepxAY8LHeVQ0p85mNhflQ7BxzTntFW+T0TSRbec7
	PVII3GkHOSz8o7uFfVO5A29ROYkiY1zbKKepYoDBhqn61r7nwzrwuTYIQ18kge8JFlTAsrf1XHq
	3TxEa6MbpInHXldc7lrAgEj4TDOXxrKdJBEe13SvguYbbB/wWFKfRrVW6zZ4veZ8hgLsHDd5zFF
	Jip6wuzyv530HesfaiBt521N3R9IKi5mCMNAOkLPcpg3eexNJK6Mdqxwz2zHjiFJ+qmkMnl8dNS
	db4R2qHnAFz7fLfg5YnD8GXQtjlcM0tGhl+rYZ/eKkQcooyxsFA7vnsfANVp+6GRe
X-Received: by 2002:a5d:588c:0:b0:3e0:a5a2:ec9b with SMTP id ffacd0b85a97d-3e64ca76350mr4700086f8f.52.1757322889380;
        Mon, 08 Sep 2025 02:14:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESch+TvPw/XuuDoI/s8ofhAgmUojqK0jp/GaJooIEd0GJefywm4JIByf3OsYAT9LaECB1NBw==
X-Received: by 2002:a5d:588c:0:b0:3e0:a5a2:ec9b with SMTP id ffacd0b85a97d-3e64ca76350mr4700054f8f.52.1757322888839;
        Mon, 08 Sep 2025 02:14:48 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:700:d846:15f3:6ca0:8029? (p200300d82f250700d84615f36ca08029.dip0.t-ipconnect.de. [2003:d8:2f25:700:d846:15f3:6ca0:8029])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf275d2717sm40764051f8f.15.2025.09.08.02.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 02:14:48 -0700 (PDT)
Message-ID: <1b95ca2a-bc1f-4e11-be4e-8341c3cc278e@redhat.com>
Date: Mon, 8 Sep 2025 11:14:45 +0200
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
 <701d2994-5b9a-4657-a616-586652f42df5@redhat.com>
 <686943a6-7043-41b0-bd4c-2bfc4463d49b@gmail.com>
 <e41c8d5d-5685-49f4-a5f5-87513674a03b@redhat.com>
 <27460707-3d93-4ff2-bc99-da96d26758e9@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <27460707-3d93-4ff2-bc99-da96d26758e9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05.09.25 19:26, Usama Arif wrote:
> 
> 
> On 05/09/2025 17:55, David Hildenbrand wrote:
>> On 05.09.25 18:47, Usama Arif wrote:
>>>
>>>
>>> On 05/09/2025 16:58, David Hildenbrand wrote:
>>>> On 05.09.25 17:53, Usama Arif wrote:
>>>>>
>>>>>
>>>>> On 05/09/2025 16:28, David Hildenbrand wrote:
>>>>>> On 05.09.25 17:16, Usama Arif wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 05/09/2025 16:04, David Hildenbrand wrote:
>>>>>>>> On 05.09.25 17:01, Usama Arif wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 05/09/2025 15:58, David Hildenbrand wrote:
>>>>>>>>>> On 05.09.25 16:53, Usama Arif wrote:
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> On 05/09/2025 15:46, David Hildenbrand wrote:
>>>>>>>>>>>> [...]
>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> The reason I did this is for the case if you change max_ptes_none after the THP is added
>>>>>>>>>>>>> to deferred split list but *before* memory pressure, i.e. before the shrinker runs,
>>>>>>>>>>>>> so that its considered for splitting.
>>>>>>>>>>>>
>>>>>>>>>>>> Yeah, I was assuming that was the reason why the shrinker is enabled as default.
>>>>>>>>>>>>
>>>>>>>>>>>> But in any sane system, the admin would enable the shrinker early. If not, we can look into handling it differently.
>>>>>>>>>>>
>>>>>>>>>>> Yes, I do this as well, i.e. have a low value from the start.
>>>>>>>>>>>
>>>>>>>>>>> Does it make sense to disable shrinker if max_ptes_none is 511? It wont shrink
>>>>>>>>>>> the usecase you are describing below, but we wont encounter the increased CPU usage.>
>>>>>>>>>>
>>>>>>>>>> I don't really see why we should do that.
>>>>>>>>>>
>>>>>>>>>> If the shrinker is a problem than the shrinker should be disabled. But if it is enabled, we should be shrinking as documented.
>>>>>>>>>>
>>>>>>>>>> Without more magic around our THP toggles (we want less) :)
>>>>>>>>>>
>>>>>>>>>> Shrinking happens when we are under memory pressure, so I am not really sure how relevant the scanning bit is, and if it is relevant enought to change the shrinker default.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> yes agreed, I also dont have numbers to back up my worry, its all theoretical :)
>>>>>>>>
>>>>>>>> BTW, I was also wondering if we should just always add all THP to the deferred split list, and make the split toggle just affect whether we process them or not (scan or not).
>>>>>>>>
>>>>>>>> I mean, as a default we add all of them to the list already right now, even though nothing would ever get reclaimed as default.
>>>>>>>>
>>>>>>>> What's your take?
>>>>>>>>
>>>>>>>
>>>>>>> hmm I probably didnt understand what you meant to say here:
>>>>>>> we already add all of them to the list in __do_huge_pmd_anonymous_page and collapse_huge_page and
>>>>>>> shrink_underused sets/clears split_underused_thp in deferred_split_folio decides whether we process or not.
>>>>>>
>>>>>> This is what I mean:
>>>>>>
>>>>>> commit 3952b6f6b671ca7d69fd1783b1abf4806f90d436 (HEAD -> max_ptes_none)
>>>>>> Author: David Hildenbrand <david@redhat.com>
>>>>>> Date:   Fri Sep 5 17:22:01 2025 +0200
>>>>>>
>>>>>>        mm/huge_memory: always add THPs to the deferred split list
>>>>>>            When disabling the shrinker and then re-enabling it, any anon THPs
>>>>>>        allocated in the meantime.
>>>>>>            That also means that we cannot disable the shrinker as default during
>>>>>>        boot, because we would miss some THPs later when enabling it.
>>>>>>            So always add them to the deferred split list, and only skip the
>>>>>>        scanning if the shrinker is disabled.
>>>>>>            This is effectively what we do on all systems out there already, unless
>>>>>>        they disable the shrinker.
>>>>>>            Signed-off-by: David Hildenbrand <david@redhat.com>
>>>>>>
>>>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>>>> index aa3ed7a86435b..3ee857c1d3754 100644
>>>>>> --- a/mm/huge_memory.c
>>>>>> +++ b/mm/huge_memory.c
>>>>>> @@ -4052,9 +4052,6 @@ void deferred_split_folio(struct folio *folio, bool partially_mapped)
>>>>>>            if (folio_order(folio) <= 1)
>>>>>>                    return;
>>>>>>     -       if (!partially_mapped && !split_underused_thp)
>>>>>> -               return;
>>>>>> -
>>>>>>            /*
>>>>>>             * Exclude swapcache: originally to avoid a corrupt deferred split
>>>>>>             * queue. Nowadays that is fully prevented by memcg1_swapout();
>>>>>> @@ -4175,6 +4172,8 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>>>>>>                    bool underused = false;
>>>>>>                      if (!folio_test_partially_mapped(folio)) {
>>>>>> +                       if (!split_underused_thp)
>>>>>> +                               goto next;
>>>>>>                            underused = thp_underused(folio);
>>>>>>                            if (!underused)
>>>>>>                                    goto next;
>>>>>>
>>>>>>
>>>>>
>>>>>
>>>>> Thanks for sending the diff! Now I know what you meant lol.
>>>>>
>>>>> In the case of when shrinker is disabled, this could make the deferred split scan for partially mapped folios
>>>>> very ineffective?
>>>>
>>>> I hope you realize that that's the default on each and every system out there that ships this feature :)
>>>>
>>>
>>> Yes, I made it default :)
>>>
>>> I am assuming people either keep shrinker enabled (which is an extremely large majority as its default), or disable shrinker
>>> and they dont flip flop between the 2 settings.
>>> There are 2 scenarios for the above patch:
>>>
>>> - shrinker is enabled (default): the above patch wont make a difference.
>>> - shrinker is disabled: the above patch makes splitting partially mapped folios inefficient.
>>>
>>> I didnt talk about the shrinker enabled case as it was a no-op and just talked about the shrinker disabled
>>> case.
>>
>>
>> Yeah, and I am saying that all you raised as a concern would be a problem already today in all default setups (-> 99.999999%). :)
>>
>> Probably we should not just disable the shrinker during boot, and once enabled, it would only split THPs created afterwards.
>>
> 
> I probably didnt understand this again lol. Sorry its friday evening :)
> 
> split_underused_thp is true at boot time [1]. You are saying we should not disable shrinker during boot, but it is already not
> disabled during boot, right?

It's all a mess, sorry, currently it's "enabled" as default but actually 
"disabled". Let me see if I can clean all that up.

-- 
Cheers

David / dhildenb



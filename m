Return-Path: <linux-kernel+bounces-803306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC8BB45D37
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21FB61892A0B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1817631D746;
	Fri,  5 Sep 2025 15:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Few1Tv3M"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D241C1F12
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 15:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757087834; cv=none; b=I2SiKTOQ2mAPNKomiIoBbh05mu92lcD1g3573voS6kglg5b115r0tsZfkqLiHWqxnIlZQZlUTkOTcZ6DInOD5+wZ2TIV0iOS/l57Za2WT8+fKKXQkqfT9gbCaiB/q/W/UdWC/0p1AfVEoxXodIMtPCdH/H0yocch+WUHzJR1uuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757087834; c=relaxed/simple;
	bh=Y+sTrjI5OW0EiK5VIS+FTi/d+A+TIoWwB2d5cbJVxkg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jOFGBqYDJqoA/wKt0+f8d11NEuwYenhWKTa6/XaBRaY+9Ay78hHO0MB2e/JIdJEyxsE1SvNqjbnDx5NkOEI1xIDcP1FlNwiDQB3dQOjLQOpxqBGTzldmSvZBSGzrgYvbagnZ97AZLZDwfxNaqbCD8G+wo8F+h+ulQxU3MSGYDG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Few1Tv3M; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45ddc7d5731so2344175e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 08:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757087831; x=1757692631; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T307WFdeH75VLzRB5+iWmitggBHVAbxN1ojM9RIT92Y=;
        b=Few1Tv3M4enx16l5zYpBmH+HQ6RQWCYB4Qd3/nxKPkStFRF4flzV+MDWF1i9IgHxPK
         o7G6vPzSeKMnXpDlXqYpim0k77+j/rY9p97Nidbe0IQmiD0QKWxHppgg3zZIzosnmVz+
         FjbcSS+WSi2I8umyZWqmxZRGg7Pquv2TMUPtzD51MX4Ojc9DEnBUjadjtPjuyCfk+lfY
         kJJzJ1kSijavtrCJuhPf8mysOtHJrT0qf8kf3taWZLPkcrAW5aqFFyyZP/8NDj6CKVNn
         OLNu5kMHzEQzPOwGAh48u8zmrzYavwv7DT0Tfvw+zFSFS7TScytWwb658fI2A0RcQ24q
         5N8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757087831; x=1757692631;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T307WFdeH75VLzRB5+iWmitggBHVAbxN1ojM9RIT92Y=;
        b=GV3Ts6l97ERv8n9hECkzOA0xMPNcZwT3wR8BjUtVo3gztoJMsG8znwg86ARadEnDJ7
         UFHUk9Yb6VpqQUX41OM+EioriOWjzKzf0kk2mYxlMMvRchg9SNR3CFGz3AmTRLaMq9IM
         2ULQYUrL3T32+PrtBuuDVsPH9cxnMbyF3x/TKdhITgOS/7mdk3TPPziek9/z6U3miekO
         nKGfXStWMlHGfL3v9MnS8S9knCp8HYevqUZgxf64P62ZEO+XMvBCJxILo0b4XBD37vS5
         cmvxMycfyk1d0Itx5UOewAdUxq9M2KhIBKKi+0SVyVkM335G0GfUhj82Vl6UTJcI7aSM
         nNig==
X-Forwarded-Encrypted: i=1; AJvYcCVKGjke7XFsH4oFnuiNTQ9nFxoPQTN7XIm/9eZMcI0H/qWoaK+uUf6nD61r8ByHCP1serzGDCwDmP+jt/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbIyLcjE/E4ucOaaZML2DcYQ5W3Fy8YXAXTrkXXPpAxECVnBTd
	K6rn8lWLaOuBzKRHqDPX0myrZAJkWGAHlEq/sSZulTGPBC8xga1iv8AN
X-Gm-Gg: ASbGncurubsStvu486pm/LzKuMVNpQPDAsw2LaWLQFSIRnl77JSlPJ6sRtyiTSEOIwF
	cDVbx0jI5nr64JptwQ4XSTh9KKtqL2qWIfuyUjgBrA48IyeLslBBlR+O/SETJAMs9WF+HLswKLC
	cUvE2Dsp1SMsjwaXHUnwQXXa4IarQoTwLthehUGlklp4NuG1OhJBbotUqGqBEvnMeAP6dHbDxab
	aSDH40yLp4wgBJRLHNYnPG9JXnf77fg6W2jf1crJ+0vp80HGsh+nK/3Yx5Ljz4i5YRwiDPkt0IW
	H69/i66xPmQnwAhZeDxOZFBUOqLMVZDBlbFRgyX1aT7zdoT61eouAchmTG8xlVsZhAX+7vCb2b1
	/CirGcIQH7IBh7pmvIrlEQmUErqTa/cv3JcH+Ax5J27U6egAPVHAkYiK/bgVjuUg8IegnxbM=
X-Google-Smtp-Source: AGHT+IFLhKjW4Fe8S8wpI/2bRVPjo1z45/c0rrhsn3wSoJ918bHUq1R21JnyukRzj20J+gUQTw8xlQ==
X-Received: by 2002:a05:600c:4fcd:b0:456:19eb:2e09 with SMTP id 5b1f17b1804b1-45b85528589mr219556995e9.8.1757087830802;
        Fri, 05 Sep 2025 08:57:10 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:1449:d619:96c0:8e08? ([2620:10d:c092:500::4:4f66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45cb5693921sm136327205e9.0.2025.09.05.08.57.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 08:57:10 -0700 (PDT)
Message-ID: <3a8a3ede-b14d-4b42-a2a1-5d62ef132f2a@gmail.com>
Date: Fri, 5 Sep 2025 16:57:07 +0100
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
From: Usama Arif <usamaarif642@gmail.com>
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
In-Reply-To: <d48af6f4-2ded-40f5-849d-7aa991727a59@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 05/09/2025 16:53, Usama Arif wrote:
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
>>     mm/huge_memory: always add THPs to the deferred split list
>>         When disabling the shrinker and then re-enabling it, any anon THPs
>>     allocated in the meantime.
>>         That also means that we cannot disable the shrinker as default during
>>     boot, because we would miss some THPs later when enabling it.
>>         So always add them to the deferred split list, and only skip the
>>     scanning if the shrinker is disabled.
>>         This is effectively what we do on all systems out there already, unless
>>     they disable the shrinker.
>>         Signed-off-by: David Hildenbrand <david@redhat.com>
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index aa3ed7a86435b..3ee857c1d3754 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -4052,9 +4052,6 @@ void deferred_split_folio(struct folio *folio, bool partially_mapped)
>>         if (folio_order(folio) <= 1)
>>                 return;
>>  
>> -       if (!partially_mapped && !split_underused_thp)
>> -               return;
>> -
>>         /*
>>          * Exclude swapcache: originally to avoid a corrupt deferred split
>>          * queue. Nowadays that is fully prevented by memcg1_swapout();
>> @@ -4175,6 +4172,8 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>>                 bool underused = false;
>>  
>>                 if (!folio_test_partially_mapped(folio)) {
>> +                       if (!split_underused_thp)
>> +                               goto next;
>>                         underused = thp_underused(folio);
>>                         if (!underused)
>>                                 goto next;
>>
>>
> 
> 
> Thanks for sending the diff! Now I know what you meant lol.
> 
> In the case of when shrinker is disabled, this could make the deferred split scan for partially mapped folios
> very ineffective?
> 
> I am making up numbers, but lets there are 128 THPs in the system, only 2 of them are partially mapped
> and sc->nr_to_scan is 32.
> 
> In the current code, with shrinker disabled, only the 2 partially mapped THPs will be on the deferred list, so
> we will reclaim them in the first go.
> 
> With your patch, the worst case scenario is that the partially mapped THPs are at the end of the deferred_list
> and we would need 4 calls for the shrinker to split them.


And I am hoping people are not dynamically enabling/disabling THP shrinker :)


I have ideas about dynamically changing max_ptes_none, maybe based on system metrics like memory pressure,
but not enabling/disabling shrinker.



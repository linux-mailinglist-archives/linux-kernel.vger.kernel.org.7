Return-Path: <linux-kernel+bounces-803301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8253AB45D3A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97F4B7B7DD0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11072306B1D;
	Fri,  5 Sep 2025 15:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJ2X5ZJT"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570442F2E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 15:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757087636; cv=none; b=aSD2saWh1AH0q2baaUJA5dlrPxQ8moUO9u6nnU001mFUE1pk7A5+XTFu1rgadDdnxWeAIELeoNVU2bP3e/JMoqhnDJvyVxKGK48pebM00jj2ej5qC/SeFqHK5uaJGIdjNyHve3pzcpTrUnnOK7rrvEqKChOEUEQc3tvY8AHuoNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757087636; c=relaxed/simple;
	bh=dX5buREuoRD0OPssgzhsr77IFmBFnyTA6VMBg75PUcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GGQn6VOx/OXkwtc6iEipQO41tX+/J4Xc1ugvgSxAXrD42g3yw102N5QOs/BiuseCwmXsGXFM0A08VNBBk+LMlnN6lR8Y8kE68UnHV+V8nI2h93CIOFVxg1CRKbcCP8vKbQwPMxq21Bg+8vCH//+hmE1DB6bAPSXc6Uc28HXRlh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJ2X5ZJT; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45b83ae1734so13850835e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 08:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757087633; x=1757692433; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bBjnb9eHsc4AMjz+79Da56WGX1xcPGKADQKecHbj1Dg=;
        b=iJ2X5ZJT8dK9dDILtiEh0eprkC0Gic50OQhSO+kxgwIULr7mfhvw+wA7zx+uqbO5RS
         uXhyPZbeGCES19C+BiuKNBmRoaKouRn5Pb66pNC1TAGzdAO+KNaGeDysnI2cYttMUHE9
         Mu3hLCxVt6SROg66t9xbHlDt40dk7FXNXl3p2a26ebRtj/8yCrztB91SbYb3FrT4FmLK
         lDxmiN/fRgtX/9xFmsxqIy6D08PPWa9vHKAj5lcLk+2KPMPGFu3gq/xn/T/6GSGqn4Gh
         MF9Ibmlw41ski3N7gpDnaWf+FA5uQjm8AuffQRZCM0v9LTAtMGLXXmK4eRwWA1kTv2LX
         bSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757087633; x=1757692433;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bBjnb9eHsc4AMjz+79Da56WGX1xcPGKADQKecHbj1Dg=;
        b=NPWUzS5noBHTdj0wPabxmbotGgsghXnWfOvMoplsxAm9HrxJaTBDD/NSAXO/W4+yGn
         euseMXrWGlMtgVuq3anJpGnxZN5QOe727O14KiR7K/Hv/ruljuxrrEfeDKTqOlexcft4
         gltCDniiZl15fBxeQwNZIgOKGWsQxp+S7VUpilGEWhN1lBQsS+CgM+wjm5MeKflIWWv1
         hdrPSnh6jNPdf86NSSogGt8iuMUp0GwCeyyIBxexB3uXDC/wHB760clPYEOY962xOUMN
         JejF15V7mP4d/+ZfvJyphLYqRVGjDkhzT6hXpGvP6WGqwJSDtXtqfYR3TF5Sz7GA5vMe
         +G9g==
X-Forwarded-Encrypted: i=1; AJvYcCVsrZhvjYjH8ykDS8WakV9LKK78auh+Ny78Uro1uNvGQQVjoA5BtiLpcvoReqb7rbt1S5uZ3g7xwE/Cth0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmR0IzplrFHUK1Oi1Isj+HWlBVm91jGlzONs3XMXGf6GDIH40c
	mvcZYE8ytjCQqBHpSGdjtn4zvIv6Mt2hOmhQDqW/aQIDr78My19Q8jpz0yMnUGe/IsM=
X-Gm-Gg: ASbGncvQm3WgA+fSHqXlq5KxWacb2HxV7ae/lJiDpluDad+4e1Unu+LJdFAvKlrxkGU
	kC5P+uVmFLL8dViMNnLmrVSKCRzVq4CPDQRmWGrYkk0OFXEUye6LsCgdFSZufceGhLBjxm2vONm
	e5+YDZ/UKcEAaXck5dGFuFxOAzGHe/f9PHPQAviKW8ShOq05qvrzSZCZASNaevYtGrlRMRClAlv
	wT1uHAyrfKCLL+8XDM5Kb1nFwn9gVpqiiP06nk/cfwHNY+Wh9CQA0WYJ3LOCybso8jezyZ8wYIK
	sPE5UdEzvLP9+s1Ed9tiETfiYBPVwy0CNDn4cxGPXOt/gDVo1+6FuFQcl3ZldTO53NX8W6lnzWp
	N9mdYqUXQmsou0ZraQVtEzqXQz9lVh76UaIV/8VsL8PZiJDuEECj2W3KaADngvnuR7rApQ28=
X-Google-Smtp-Source: AGHT+IGU5mrUM+Z3bC8QJbKvkz8k5wsN0F9e+YsY1remvxpV8XQ0cvib1U6/IUD6PIX8cC7tM8wEKQ==
X-Received: by 2002:a05:600c:4e87:b0:45c:b5eb:b0c6 with SMTP id 5b1f17b1804b1-45dd5a2b4abmr42580715e9.5.1757087632220;
        Fri, 05 Sep 2025 08:53:52 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:1449:d619:96c0:8e08? ([2620:10d:c092:500::4:4f66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dcfa3ec60sm86415385e9.15.2025.09.05.08.53.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 08:53:51 -0700 (PDT)
Message-ID: <d48af6f4-2ded-40f5-849d-7aa991727a59@gmail.com>
Date: Fri, 5 Sep 2025 16:53:48 +0100
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
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <aadf50b1-151b-41c6-b60c-5f1f2a4f2d8e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 05/09/2025 16:28, David Hildenbrand wrote:
> On 05.09.25 17:16, Usama Arif wrote:
>>
>>
>> On 05/09/2025 16:04, David Hildenbrand wrote:
>>> On 05.09.25 17:01, Usama Arif wrote:
>>>>
>>>>
>>>> On 05/09/2025 15:58, David Hildenbrand wrote:
>>>>> On 05.09.25 16:53, Usama Arif wrote:
>>>>>>
>>>>>>
>>>>>> On 05/09/2025 15:46, David Hildenbrand wrote:
>>>>>>> [...]
>>>>>>>
>>>>>>>>
>>>>>>>> The reason I did this is for the case if you change max_ptes_none after the THP is added
>>>>>>>> to deferred split list but *before* memory pressure, i.e. before the shrinker runs,
>>>>>>>> so that its considered for splitting.
>>>>>>>
>>>>>>> Yeah, I was assuming that was the reason why the shrinker is enabled as default.
>>>>>>>
>>>>>>> But in any sane system, the admin would enable the shrinker early. If not, we can look into handling it differently.
>>>>>>
>>>>>> Yes, I do this as well, i.e. have a low value from the start.
>>>>>>
>>>>>> Does it make sense to disable shrinker if max_ptes_none is 511? It wont shrink
>>>>>> the usecase you are describing below, but we wont encounter the increased CPU usage.>
>>>>>
>>>>> I don't really see why we should do that.
>>>>>
>>>>> If the shrinker is a problem than the shrinker should be disabled. But if it is enabled, we should be shrinking as documented.
>>>>>
>>>>> Without more magic around our THP toggles (we want less) :)
>>>>>
>>>>> Shrinking happens when we are under memory pressure, so I am not really sure how relevant the scanning bit is, and if it is relevant enought to change the shrinker default.
>>>>>
>>>>
>>>> yes agreed, I also dont have numbers to back up my worry, its all theoretical :)
>>>
>>> BTW, I was also wondering if we should just always add all THP to the deferred split list, and make the split toggle just affect whether we process them or not (scan or not).
>>>
>>> I mean, as a default we add all of them to the list already right now, even though nothing would ever get reclaimed as default.
>>>
>>> What's your take?
>>>
>>
>> hmm I probably didnt understand what you meant to say here:
>> we already add all of them to the list in __do_huge_pmd_anonymous_page and collapse_huge_page and
>> shrink_underused sets/clears split_underused_thp in deferred_split_folio decides whether we process or not.
> 
> This is what I mean:
> 
> commit 3952b6f6b671ca7d69fd1783b1abf4806f90d436 (HEAD -> max_ptes_none)
> Author: David Hildenbrand <david@redhat.com>
> Date:   Fri Sep 5 17:22:01 2025 +0200
> 
>     mm/huge_memory: always add THPs to the deferred split list
>         When disabling the shrinker and then re-enabling it, any anon THPs
>     allocated in the meantime.
>         That also means that we cannot disable the shrinker as default during
>     boot, because we would miss some THPs later when enabling it.
>         So always add them to the deferred split list, and only skip the
>     scanning if the shrinker is disabled.
>         This is effectively what we do on all systems out there already, unless
>     they disable the shrinker.
>         Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index aa3ed7a86435b..3ee857c1d3754 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -4052,9 +4052,6 @@ void deferred_split_folio(struct folio *folio, bool partially_mapped)
>         if (folio_order(folio) <= 1)
>                 return;
>  
> -       if (!partially_mapped && !split_underused_thp)
> -               return;
> -
>         /*
>          * Exclude swapcache: originally to avoid a corrupt deferred split
>          * queue. Nowadays that is fully prevented by memcg1_swapout();
> @@ -4175,6 +4172,8 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>                 bool underused = false;
>  
>                 if (!folio_test_partially_mapped(folio)) {
> +                       if (!split_underused_thp)
> +                               goto next;
>                         underused = thp_underused(folio);
>                         if (!underused)
>                                 goto next;
> 
> 


Thanks for sending the diff! Now I know what you meant lol.

In the case of when shrinker is disabled, this could make the deferred split scan for partially mapped folios
very ineffective?

I am making up numbers, but lets there are 128 THPs in the system, only 2 of them are partially mapped
and sc->nr_to_scan is 32.

In the current code, with shrinker disabled, only the 2 partially mapped THPs will be on the deferred list, so
we will reclaim them in the first go.

With your patch, the worst case scenario is that the partially mapped THPs are at the end of the deferred_list
and we would need 4 calls for the shrinker to split them.


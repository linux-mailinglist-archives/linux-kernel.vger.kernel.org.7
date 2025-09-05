Return-Path: <linux-kernel+bounces-803221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C174B45C4A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCA9E3A8226
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B180D1C6B4;
	Fri,  5 Sep 2025 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5TgdnmZ"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2513B1AB
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 15:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757085408; cv=none; b=Fos3sQvUVcTxOa5a9+q5zQQaEKKrQCS6omQmWEpZM6pdNlOpFYrjprh//YAsSAtj6oGQQh4HUYCUf9bNJ5CgqUNHWu91yxLt9crg+i7IFu6ka1SlKcZakQQkN/JzFuhknOQ94oZmZ4jbJKxuNAIuqr0mckh7Jyo5jdYC1H6+050=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757085408; c=relaxed/simple;
	bh=xSTfN8HX2yEYyHvJzW0WEWgg2nlkHhXjrwHDbsp8J18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OG3+80zMRg57mcA/JUzceS0o089p2vPoKOek4DTL8wveRLiMgVVhC57vK5VeRbYwByJCoLWShWaR+vNjUefRjdUAcmwhpQTlOD9UWa+FvBLoUL6yDNDLuszfn9rRDtXQR1mvvKImCpVkQzH9CbUuuKldBWf0ojMcV9JAFPw57pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5TgdnmZ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3e34dbc38easo571512f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 08:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757085405; x=1757690205; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gvCw8PnRQjfPw9zGQmXROzWFubi2ex8kOW8DpaiaGw8=;
        b=m5TgdnmZt52IPn74CJOvWEMcxADNgRFH7LqmtGUvyC5B2BjfKy0R3LS2fOzkBuIxRm
         dBIaQi5h7/4QCrP4VumI3BxhfW+55lyrZnXHrTq/w/R2FtUaWat3xh/twHNZ5PouOutL
         tpcj16xkbp6cgZixVdnauT5VXKVr46B0tVefb4O9x1GqQ40ZUoiayb+bqgP99y7lYvG4
         MkamSbLJ2FqkW3eCwrFO5oVMQpD5AD51BgZ+BKAgdVBuwGJEi9uyD0+h0pyN4dJ+UM8F
         AZPd6nMbQ/rCfy1DnZYVXa3tbb39S6fpykiv4XZ5c5r7NZCOPcDmP4tjQNP9FuDIYWVy
         CFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757085405; x=1757690205;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gvCw8PnRQjfPw9zGQmXROzWFubi2ex8kOW8DpaiaGw8=;
        b=CPUEu7R37x23SpA0ag+aafkGYjDoPrIRPv/TPY6TwOetnZ77bBqkK58SW37Oe5vifM
         tObMOIWo+fHfL5rtZ7Rph3Nzq9ZnwVtIHJ/UMx/tCvlQgSyvGIvV5pKZ/2gC9ZhhN+NC
         8sngd/ckuhOZE2VnhT0/PMAcdjptjLLcGf8rjGKYHSh4526JowoCdf4Av5A3tqW8pdZ/
         6EJuNvuW4V5hy9KgdnLXrV0RWWo8756miaeH9NIJFXezF5wkYsTg9Rrc+q7e50mg2xr1
         srnzjFHjXSiMVkdXfKFJr2Ov6AN2hDLKtyWaqMNrLrcGFOWMBHCt/RZ773Ck4pjpw6cE
         vPoQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3wPgRP/LCGRaGeGjp/wYV2HJ/m/aCOROhy5yDuK4w+xOS8rmcdgx7+lfLgGAkZTEWp3b1lA5lvzlgqb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV+uLgLeU2ofwcJRMsdms4talVN6FTo5yvALJmok1rRGiKuLA2
	N10juwbbJWIKfmAczHeCo4zvC2W3e7jszst3MNZmOwMqbktdt8ZjYQQ1
X-Gm-Gg: ASbGncsHvwRpSG3KVHT29sZGflknk8q1RYH1Ow4exwenqMw3597LN+k5hn8cvVNM2tS
	INYxCSe32OT9c5zVayXoysEJiAaJhrzlpGHHqDr5O6JEc+sXqpDLX9+UzHK2NwOQXiRLcD2ngIi
	4YrNTEmjUa+8g1fPBeM/PkxWRLUrshJlRbHtms8E0uscaUJIdPTXP8GwTVLekLD6v00342mBZp8
	06Vm21MTfhaRG7ryHJjWCpr+Aa1YjrJ1U1siiNzBjBDWtDdkpNxaOT4iBs0w3QYFP0wVta5L601
	xKN9B2jBlp7FI2++TZTL3NfCVOzMMJAhynZ4zAHU/0uKDRU3ibINmEfZnuw7+oq0IeXQGcArM9a
	CkcVmuHxc3SZS/f/wYwzehvnTHqYYelHaFjocYpjxjyb6X+WKxMqnq1msm5uAOIR4bfLdufc=
X-Google-Smtp-Source: AGHT+IEmTCo8jb52P6pCTfWLGNS8fx95yjvAkgZdmH56UsyDr4ZNMlk9nJW2Jy0VkRXvCY7nIV2nsw==
X-Received: by 2002:a05:6000:1449:b0:3da:37de:a3c6 with SMTP id ffacd0b85a97d-3da37dea762mr10479951f8f.59.1757085404642;
        Fri, 05 Sep 2025 08:16:44 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:1449:d619:96c0:8e08? ([2620:10d:c092:500::4:4f66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d9f3c36a78sm16205165f8f.48.2025.09.05.08.16.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 08:16:44 -0700 (PDT)
Message-ID: <3c857cdb-01d0-4884-85c1-dfae46d8e4a0@gmail.com>
Date: Fri, 5 Sep 2025 16:16:41 +0100
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
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <3737e6e5-9569-464c-8cd0-1ec9888be04b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 05/09/2025 16:04, David Hildenbrand wrote:
> On 05.09.25 17:01, Usama Arif wrote:
>>
>>
>> On 05/09/2025 15:58, David Hildenbrand wrote:
>>> On 05.09.25 16:53, Usama Arif wrote:
>>>>
>>>>
>>>> On 05/09/2025 15:46, David Hildenbrand wrote:
>>>>> [...]
>>>>>
>>>>>>
>>>>>> The reason I did this is for the case if you change max_ptes_none after the THP is added
>>>>>> to deferred split list but *before* memory pressure, i.e. before the shrinker runs,
>>>>>> so that its considered for splitting.
>>>>>
>>>>> Yeah, I was assuming that was the reason why the shrinker is enabled as default.
>>>>>
>>>>> But in any sane system, the admin would enable the shrinker early. If not, we can look into handling it differently.
>>>>
>>>> Yes, I do this as well, i.e. have a low value from the start.
>>>>
>>>> Does it make sense to disable shrinker if max_ptes_none is 511? It wont shrink
>>>> the usecase you are describing below, but we wont encounter the increased CPU usage.>
>>>
>>> I don't really see why we should do that.
>>>
>>> If the shrinker is a problem than the shrinker should be disabled. But if it is enabled, we should be shrinking as documented.
>>>
>>> Without more magic around our THP toggles (we want less) :)
>>>
>>> Shrinking happens when we are under memory pressure, so I am not really sure how relevant the scanning bit is, and if it is relevant enought to change the shrinker default.
>>>
>>
>> yes agreed, I also dont have numbers to back up my worry, its all theoretical :)
> 
> BTW, I was also wondering if we should just always add all THP to the deferred split list, and make the split toggle just affect whether we process them or not (scan or not).
> 
> I mean, as a default we add all of them to the list already right now, even though nothing would ever get reclaimed as default.
> 
> What's your take?
> 

hmm I probably didnt understand what you meant to say here:
we already add all of them to the list in __do_huge_pmd_anonymous_page and collapse_huge_page and
shrink_underused sets/clears split_underused_thp in deferred_split_folio decides whether we process or not.

In deferred_split_folio, if split_underused_thp is false, we dont add them to the list (unless partially_mapped).

Unless you are referring to non pmd mapped THPs?




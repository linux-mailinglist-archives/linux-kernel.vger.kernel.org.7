Return-Path: <linux-kernel+bounces-803132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 243CFB45ADE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 041D5177077
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6513680BC;
	Fri,  5 Sep 2025 14:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XN0qGcVI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8342172633
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 14:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757083592; cv=none; b=rngI+ojuq7dl3+tOaJlArXMdEGp5d3zXwAPUbkpMKQPYOSlrR41A5lcA3A/QAsBO/GIcYbUtZBbBBJt86V0M5dFIqSxNzI0sK163YoImVkGIkLxxxGKy9zAkfpHEFeTR2o2HUlokUrFF0Rp9l2BTjTDsnWzasPkeTuxPdE0qlBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757083592; c=relaxed/simple;
	bh=Aa0dAQIu//w03vNSw4C8UW9XoK6F9/BBtbqow4P84z8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B0p2Q1O5EzWx8WnEhtsSSRQ7cPnd6WvQ3Atk7/W88o9HuCQp5glXGxAI/OOqoJV7o5Es7TT2A4q3UbzEuo8JJqnUafdIkyEOnQrlpQPu9OM0dY2cfJYxoZQUyN9tu9D8AZWUPbzbTlq2rpNADsXip1V3GqTVtRF6RetLC6oRgtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XN0qGcVI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757083589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=StuuOmRSI+HpFIlfBf87jbL35E0EZeBKXFAaU3wBprM=;
	b=XN0qGcVIEFS7BtFBNbHbTNE2MbrfP9QbNLHNnzRTcH+ZpfA0cxD8oEUKuAAB5PWfkuMghc
	sT5CU8fNlg2kJVJzTTXhz6NDhtv3+nVWBYCCLtOs0tSY2KGxY1/L6XmvyZ3Vt4zFT1TzgK
	Z90IPovxwY+HPSKwb4b/PsJFlzkKJcI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-oOO-sfBCMguXj_oNyvTMTg-1; Fri, 05 Sep 2025 10:46:25 -0400
X-MC-Unique: oOO-sfBCMguXj_oNyvTMTg-1
X-Mimecast-MFC-AGG-ID: oOO-sfBCMguXj_oNyvTMTg_1757083584
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45b80aecb97so18798315e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 07:46:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757083584; x=1757688384;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=StuuOmRSI+HpFIlfBf87jbL35E0EZeBKXFAaU3wBprM=;
        b=Xpgwk0ap+R7SsCPJb5LnRoGF2ijHGSU2KwUjNY/j2+UfVKzlooJTHJRZ8oi21xLmNY
         BfzhKnp98dmK0+cuvOHWQ8eAbCjCnHlM4QiujMyNyO7MdNWwwNF7x+JuIQMsXjYir8vY
         Bt3W1dmst63GGapogP1C3NYzV+BJj9IhQbmu9UXoaKaup9StM4UNionF8miwXT9BVIfV
         8AxfkIm/Hcr9vhYgYHNTB5gw85wZnmxb88A0n/+WX+htkTLHbNrbw7604X52OrJv4a/9
         z0W8m1K1jDwlTvmJFULRtoqnEp3fkt3ok8EMeP8TlvOVgF2u2TqcTrWB4gudPWEa+7qh
         QU/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXd49/SebYX9z+SnBHFgQ/92ai5X9FQMfWquGF9f+21eBZI1cb9UyEQctftvLhJLVjt42BJUKdWdFwhUho=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWvbOX+ygRu8PsNmnX+0zqgiYCIn+naoe1rfMqsEuiLNPOC/pR
	wAnGbaAOMDOYyE4eVjzR1Fgc62MKAoH8id/XWNhYTAtPN1rmFdM5nOHYlF3JT+Th9fzgoG4g5V6
	rh/CHnyqWK1rPV6xAWKTuH945bAQneO4wrGI9dZLFmiKH2Ge/EPwSIX8nCAmiIP7JHA==
X-Gm-Gg: ASbGncsxOlF7XyhY19pEi58gFixOCcpz1IEFf1K31wqbHnFjaXWNsqnWOAasV4SoYUX
	wQc+SWz30VjxTzvG+HAG187l8fFz1xwMpQWxsxWCGGugfoeh9RMMWNyiMi+UQqMk/1iN9urk/5c
	9mpjZ0jRjmxqGbjCkldsVegxGVk4HMQqXt4qGjzb9Sj48qq1txYynp2WG42HjK36H2DtMiO6gS6
	UedAH5uEuL0c4yb+A9hx+hthEp8Ad5ZbVQoAfhFaHzKq9xd/pR69cnkiFW3mGaRaQM/KI0ubdN6
	aKAU+CeO/qtS3Eyqfrrp06a8sWDrKjOTL0uQDP0FZXaZ6sPIz0c42R4l1wcBPB0IGXfVVwPjJfh
	YhMOnCiwEOHk+TmGt7D59p2fhkowYfFDLHkYrZo0e9WsZq7gVGUBVH6HD
X-Received: by 2002:a05:600c:1c91:b0:45b:8795:4caa with SMTP id 5b1f17b1804b1-45dcfa6b946mr55933515e9.36.1757083583814;
        Fri, 05 Sep 2025 07:46:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtXL4u6qBiUj5sGS3/tCmNMUG503qqTPgghxO03yjWUc3pS9QYk0Gb9OCJXy3McmpNlPvBbQ==
X-Received: by 2002:a05:600c:1c91:b0:45b:8795:4caa with SMTP id 5b1f17b1804b1-45dcfa6b946mr55933115e9.36.1757083583290;
        Fri, 05 Sep 2025 07:46:23 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4d:e00:298:59cc:2514:52? (p200300d82f4d0e00029859cc25140052.dip0.t-ipconnect.de. [2003:d8:2f4d:e00:298:59cc:2514:52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45ddc315d78sm5319915e9.4.2025.09.05.07.46.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 07:46:22 -0700 (PDT)
Message-ID: <1aa5818f-eb75-4aee-a866-9d2f81111056@redhat.com>
Date: Fri, 5 Sep 2025 16:46:21 +0200
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <06874db5-80f2-41a0-98f1-35177f758670@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[...]

> 
> The reason I did this is for the case if you change max_ptes_none after the THP is added
> to deferred split list but *before* memory pressure, i.e. before the shrinker runs,
> so that its considered for splitting.

Yeah, I was assuming that was the reason why the shrinker is enabled as 
default.

But in any sane system, the admin would enable the shrinker early. If 
not, we can look into handling it differently.

> 
>> Easy to reproduce:
>>
>> 1) Allocate some THPs filled with 0s
>>
>> <prog.c>
>>   #include <string.h>
>>   #include <stdio.h>
>>   #include <stdlib.h>
>>   #include <unistd.h>
>>   #include <sys/mman.h>
>>
>>   const size_t size = 1024*1024*1024;
>>
>>   int main(void)
>>   {
>>           size_t offs;
>>           char *area;
>>
>>           area = mmap(0, size, PROT_READ | PROT_WRITE,
>>                       MAP_ANON | MAP_PRIVATE, -1, 0);
>>           if (area == MAP_FAILED) {
>>                   printf("mmap failed\n");
>>                   exit(-1);
>>           }
>>           madvise(area, size, MADV_HUGEPAGE);
>>
>>           for (offs = 0; offs < size; offs += getpagesize())
>>                   area[offs] = 0;
>>           pause();
>>   }
>> <\prog.c>
>>
>> 2) Trigger the shrinker
>>
>> E.g., memory pressure through memhog
>>
>> 3) Observe that THPs are not getting reclaimed
>>
>> $ cat /proc/`pgrep prog`/smaps_rollup
>>
>> Would list ~1GiB of AnonHugePages. With this fix, they would get
>> reclaimed as expected.
>>
>> Fixes: dafff3f4c850 ("mm: split underused THPs")
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
>> Cc: Nico Pache <npache@redhat.com>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Cc: Dev Jain <dev.jain@arm.com>
>> Cc: Barry Song <baohua@kernel.org>
>> Cc: Usama Arif <usamaarif642@gmail.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   mm/huge_memory.c | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 26cedfcd74189..aa3ed7a86435b 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -4110,9 +4110,6 @@ static bool thp_underused(struct folio *folio)
>>   	void *kaddr;
>>   	int i;
>>   
>> -	if (khugepaged_max_ptes_none == HPAGE_PMD_NR - 1)
>> -		return false;
>> -
> 
> I do agree with your usecase, but I am really worried about the amount of
> work and cpu time the THP shrinker will consume when max_ptes_none is 511
> (I dont have any numbers to back up my worry :)), and its less likely that
> we will have these completely zeroed out THPs (again no numbers to back up
> this statement).

Then then shrinker shall be deactivated as default if that becomes a 
problem.

Fortunately you documented the desired semantics:

"All THPs at fault and collapse time will be added to _deferred_list,
and will therefore be split under memory pressure if they are considered
"underused". A THP is underused if the number of zero-filled pages in
the THP is above max_ptes_none (see below)."

> We have the huge_zero_folio as well which is installed on read.

Yes, only if the huge zero folio is not available. Which will then also 
get properly reclaimed.

-- 
Cheers

David / dhildenb



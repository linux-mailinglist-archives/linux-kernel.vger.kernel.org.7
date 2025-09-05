Return-Path: <linux-kernel+bounces-803244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 435AAB45C92
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95E7D1C21587
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716C92F1FD1;
	Fri,  5 Sep 2025 15:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XY/7ZY7O"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B994B23D7F8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 15:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757086115; cv=none; b=To5bTt156L9LlR3SHc9yzyjhwtbHJfWX1T0WNsIRom0TiKFA8+mOi9FK53wwQ/wCKMTa4l43JwMq30YlPBjI75Vev2l9jFvOmg9Jwc6GT4AXvgIecvdtfqgWPw1nnhOj1t54n7PjWoIoov8GAQ3z6QEy2/YQSq1bKb0BI7lgPvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757086115; c=relaxed/simple;
	bh=6bsfxR9o6CnzxczjQQnPIeaD3HDfIcuE0mZwOGo8B08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KGg3G4WbHWSGNPWE1uDKSU+rNYCFOLwnVaxWlCeK59PPaJw3uV/LVLS6mjYpbHLmudSNLfSGeHtBroaGyjlb7u0eKKU8Mv52RAc1zF7ugT9PYq7SPNCb+WCZhQ+7eOK5dOD7b/Y2utGLbOT7kemefRggtpWoOtky7LkTzOKw9yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XY/7ZY7O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757086112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zHR+Mzoo8yNulXQmjP5YSZ3TGPx9n4WCY8ZjjWjytVE=;
	b=XY/7ZY7OpJ8AeaVUAdDcu1s/zcANA6GJknV4Y9kuEtv4PjhjAfx8BMthR6vbVCX0LEOE04
	zoIY0AyCDoaKq6mIeu5fFTfgNLYSWxZC5BbxXyBxVGj94sksO011ysFp1mKr65+7bgQOw9
	5SwLKn0gPCQPNnMEJfDlry4rDSm1uMk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-7z4neAFzMfO2WbGp5yXRVg-1; Fri, 05 Sep 2025 11:28:31 -0400
X-MC-Unique: 7z4neAFzMfO2WbGp5yXRVg-1
X-Mimecast-MFC-AGG-ID: 7z4neAFzMfO2WbGp5yXRVg_1757086110
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b87609663so15015725e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 08:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757086110; x=1757690910;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zHR+Mzoo8yNulXQmjP5YSZ3TGPx9n4WCY8ZjjWjytVE=;
        b=jBimhTnPgFrOx5TRV1AmpEiKQDFyUrf9ekmTC56T/5BJ1Xi/79khcb+Vjj/ADfu2oU
         kghRitA1m+yGJXw/BsWdbz2WdyEvAu95J23FJKCsGKdEYMqu81FEaIopq5IDBYxQRESW
         xkUUO9tVwQQneSZO6hEn0qgK3ynDcnhAJ7HwERfqva5MqY3urziv0OR25XDFs6TkFiQE
         j7dbOoXsND/BkQg4ABC0apo7tcdbFrITsJbX0Xy6k+KrZbbaN5f5TmNCAWmDO0qFmvY0
         JvMZVlvCOMzLJq0ax/W19UBydE68eX+FMaVyCeB3wYLL33wBWFxMRDATdREU4BhuRnfx
         7ugQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGB2cluURAvfb3AE+2bgyJpVM8ieuPABIZCQ8EpYQfEFFEusUIXFeru53wA2xgvPWepY6Hp5cF9JKrpBM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp5acqsTxgP4y8u86XRR//kIQ9PDSJC7H8tLOpCOP0+DZ0DEhr
	tcwRCoCGB1OQTBH6yu+HyRGHxHbVVZsOfGzWGgwfDuvz8a5cmdTmGnmE8uhz1R5zEgI/Hu/ECaH
	7lVRk7f/klZtu/iLyhmbBSDU1TwwWtLGzHQrNRfMw7WEpGxo5e7Adutd6b87ftCFi6g==
X-Gm-Gg: ASbGnct/juuhVsVIT/7SZXw6QWVvxMDKMlE6bqeUBoGCffTluongueA1GT6K9JnLYQD
	OzwJ/whT24+/70HHWCEU3fNm0QMyIsuCFB0ImrE/AE1m7x6+fGOu11D/NDcVMwkrGWiLfRe9g+e
	qHWLQYW1TVZKcwpKVhb8dJ+020CSnLdDEmhn7qkdD29+Ny8UPNKcRVOmdrM8n/QJBv73S1n1pYK
	cYkygtPF0ip5+w030G0yCdWL2Tv88ERpoJVxaOn8bVWHYpj4xP03Vfj1lavdhlbsLLIrJE2+INR
	f3k3g3EFnv1h7yIBni0G0pG3uMRN/pY0sO4cTeY8B0FZ3ZMdxRozmbrUXfipYvHWP1eAA8Amrfh
	FLCcz91NszTwbOYpKN8TZVqutXBt1UQv9e9RP3Nn9FO0hHenyHMs/M4+r
X-Received: by 2002:a05:600c:4e8c:b0:45d:d2a6:ad8d with SMTP id 5b1f17b1804b1-45dd2a6afafmr54359915e9.29.1757086110219;
        Fri, 05 Sep 2025 08:28:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtLMs8butaEKsXzoDM4juQ8K5fxnCDzwwTeOVOy3INb+Tp9TofrU5ky0hka2Ygb32Q0f7LIA==
X-Received: by 2002:a05:600c:4e8c:b0:45d:d2a6:ad8d with SMTP id 5b1f17b1804b1-45dd2a6afafmr54359565e9.29.1757086109739;
        Fri, 05 Sep 2025 08:28:29 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4d:e00:298:59cc:2514:52? (p200300d82f4d0e00029859cc25140052.dip0.t-ipconnect.de. [2003:d8:2f4d:e00:298:59cc:2514:52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd3aadbcesm60638375e9.17.2025.09.05.08.28.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 08:28:29 -0700 (PDT)
Message-ID: <aadf50b1-151b-41c6-b60c-5f1f2a4f2d8e@redhat.com>
Date: Fri, 5 Sep 2025 17:28:28 +0200
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <3c857cdb-01d0-4884-85c1-dfae46d8e4a0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.09.25 17:16, Usama Arif wrote:
> 
> 
> On 05/09/2025 16:04, David Hildenbrand wrote:
>> On 05.09.25 17:01, Usama Arif wrote:
>>>
>>>
>>> On 05/09/2025 15:58, David Hildenbrand wrote:
>>>> On 05.09.25 16:53, Usama Arif wrote:
>>>>>
>>>>>
>>>>> On 05/09/2025 15:46, David Hildenbrand wrote:
>>>>>> [...]
>>>>>>
>>>>>>>
>>>>>>> The reason I did this is for the case if you change max_ptes_none after the THP is added
>>>>>>> to deferred split list but *before* memory pressure, i.e. before the shrinker runs,
>>>>>>> so that its considered for splitting.
>>>>>>
>>>>>> Yeah, I was assuming that was the reason why the shrinker is enabled as default.
>>>>>>
>>>>>> But in any sane system, the admin would enable the shrinker early. If not, we can look into handling it differently.
>>>>>
>>>>> Yes, I do this as well, i.e. have a low value from the start.
>>>>>
>>>>> Does it make sense to disable shrinker if max_ptes_none is 511? It wont shrink
>>>>> the usecase you are describing below, but we wont encounter the increased CPU usage.>
>>>>
>>>> I don't really see why we should do that.
>>>>
>>>> If the shrinker is a problem than the shrinker should be disabled. But if it is enabled, we should be shrinking as documented.
>>>>
>>>> Without more magic around our THP toggles (we want less) :)
>>>>
>>>> Shrinking happens when we are under memory pressure, so I am not really sure how relevant the scanning bit is, and if it is relevant enought to change the shrinker default.
>>>>
>>>
>>> yes agreed, I also dont have numbers to back up my worry, its all theoretical :)
>>
>> BTW, I was also wondering if we should just always add all THP to the deferred split list, and make the split toggle just affect whether we process them or not (scan or not).
>>
>> I mean, as a default we add all of them to the list already right now, even though nothing would ever get reclaimed as default.
>>
>> What's your take?
>>
> 
> hmm I probably didnt understand what you meant to say here:
> we already add all of them to the list in __do_huge_pmd_anonymous_page and collapse_huge_page and
> shrink_underused sets/clears split_underused_thp in deferred_split_folio decides whether we process or not.

This is what I mean:

commit 3952b6f6b671ca7d69fd1783b1abf4806f90d436 (HEAD -> max_ptes_none)
Author: David Hildenbrand <david@redhat.com>
Date:   Fri Sep 5 17:22:01 2025 +0200

     mm/huge_memory: always add THPs to the deferred split list
     
     When disabling the shrinker and then re-enabling it, any anon THPs
     allocated in the meantime.
     
     That also means that we cannot disable the shrinker as default during
     boot, because we would miss some THPs later when enabling it.
     
     So always add them to the deferred split list, and only skip the
     scanning if the shrinker is disabled.
     
     This is effectively what we do on all systems out there already, unless
     they disable the shrinker.
     
     Signed-off-by: David Hildenbrand <david@redhat.com>

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index aa3ed7a86435b..3ee857c1d3754 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4052,9 +4052,6 @@ void deferred_split_folio(struct folio *folio, bool partially_mapped)
         if (folio_order(folio) <= 1)
                 return;
  
-       if (!partially_mapped && !split_underused_thp)
-               return;
-
         /*
          * Exclude swapcache: originally to avoid a corrupt deferred split
          * queue. Nowadays that is fully prevented by memcg1_swapout();
@@ -4175,6 +4172,8 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
                 bool underused = false;
  
                 if (!folio_test_partially_mapped(folio)) {
+                       if (!split_underused_thp)
+                               goto next;
                         underused = thp_underused(folio);
                         if (!underused)
                                 goto next;


-- 
Cheers

David / dhildenb



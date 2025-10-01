Return-Path: <linux-kernel+bounces-838991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FE2BB095A
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 15:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 288932A2BE9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 13:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB5E2FD7D2;
	Wed,  1 Oct 2025 13:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CopufbLl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5AC2FCBF5
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 13:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759327103; cv=none; b=X0nmnJGSulRqWwXNPxwPQ/Ipnx9VJ3KXN5srTnSssew1guxpcgyqV41uXIRN8Sw+iUDo7xkShaX9+sHH4DrPI62hRuQ8rBZqJKOWgUGd10zjmGTUe6yFnq6BA/B6iedcBp2hbhgc6Y2jmlmDTDhZqoQOBUz/B93q71TAj6aD7gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759327103; c=relaxed/simple;
	bh=GuwkYch3rT/c6VYaWFGNV64dyHepYE4WDA8+9On7HEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iUUzjacDN7AL3ZStkTQy4Vf1+1zfPObQHSthz+9nWkjFEUVd6pttDCAp1/oj+fmWwYc5/m9dwQ556W84xK34v1jAkV2+EK0GebdA/HBKyIYQM199/MIi28XS9E3EfxuGdZkuix6ROI7WvDZkSfJKmHeEvDezubV3F6WDQwY3+i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CopufbLl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759327100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EzrKUl+2NkMxRoxmdVM9hHYfWN12ztBQRe+rscPZIc8=;
	b=CopufbLlmjr1lmxm1Wjh1nLd1meUQAnEJ4kqAXwjSz4tnVUFQJ03a9rLgmePd1/I+Yo8Cq
	WFt1Oki3lTUTtMvv1izHJhiKzbnxrbaIVt3h84DtRmE4hbgHZi4O0BD3y4g6st19OVUIik
	K8TiQ1Xq8ffEalJAHRVvxovLeWTvSPg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-yoPUcr3DOKazdrdAQfiwKg-1; Wed, 01 Oct 2025 09:58:19 -0400
X-MC-Unique: yoPUcr3DOKazdrdAQfiwKg-1
X-Mimecast-MFC-AGG-ID: yoPUcr3DOKazdrdAQfiwKg_1759327098
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e4d34ff05so20572705e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 06:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759327098; x=1759931898;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EzrKUl+2NkMxRoxmdVM9hHYfWN12ztBQRe+rscPZIc8=;
        b=JWp9jIRB1GEh2dkQYJLOSb9bjRvCRrqvpsOhAMM2bqfv9LuU2P4z9xd7HHgqhePu2k
         N1C7naUGG4aZJ4sbOm/argAjLeJzOMKjGnu4q6lM4BDpZ3SQUw5TrLUgMWG+neqHVZWA
         m83i0vZvZmlYRpXUonCVA30jjZPUo5uDkMZiepitTwV9BHBBKR8lK9+vSW4yby/JPpLq
         q0HfhDORvzV0BPH8C8ewPlzSUMFoqRwNH/eFKj9/WcVYKPdQQZiyP2dy1Va3JU6HCqol
         Ac3eBwr3X1MzC8T76PqwlpUe4MBttcg34GA9YtP8h31Rc1GmilL9nWUHYahg000lZFcO
         pb9w==
X-Forwarded-Encrypted: i=1; AJvYcCUBcy6FnehHSLXqKAqUPbNPg2wFi2+bzv1TiFWLS5FKvziN4uz6QL/Z9wAEGVUO8JoUEnK/7etoVglik0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdIRZ8MpDmbOHJYIpp6kFfALTOYhDdr9HlZpfE4oAHgHuL9L6w
	ejEFAmy8a56N3Y+lQLCC2GwznRKDQk0WoUTut/pAAbP9qbGvEFzofOM8C/jwBOXgxvuP0WA4HRp
	wQKCKC7axuhfOYjYR5a/X6QvQGUBiznM47OQ/f4iSuz9cNGlH+m6tqwgGfX0ZobC2Dw==
X-Gm-Gg: ASbGnct22eamlTGlMSHxJBPQ0ehQS5pT7yZoHa+mZNVl3ahghlgqLQX8r0VM+DRo2Ab
	IIrX7Lvpt5O49Sg8SUC5g7kVycvZwmCi0Rq769bCL0sjaRzsiC4Kj0mpUTBXbNi4GxI/IQus65T
	rgWamGqlLsAiDdw/ZnF/XyOIoz4tNx/Boxuj4cBXOOtzt5etTRuhwTQ7ParMsLRGp3wvSTRLnLs
	Q1bBGkDKdt/EWgaDIK0pDpIOY5eAiWOqCCgUD2Zz1b5GOkEw4vbFshnfASRFZsRay6MPm91sYC3
	T1v/hlrSugWBfeN6+kZ9L0cF1wMopfIHfVVwWvlHxaMcX3YS5L3SLfAPHAKkdI+3wKT98YoDgHj
	yJp++cygc
X-Received: by 2002:a05:600c:1f8d:b0:46e:3d17:b614 with SMTP id 5b1f17b1804b1-46e676c7450mr10824505e9.6.1759327097801;
        Wed, 01 Oct 2025 06:58:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbmlLetAaGNeCKOH3qjvN1GbXYlFkysa1ZIB56tW7zS7mcnqFyRmh57QFuiH942kvyNYzrGA==
X-Received: by 2002:a05:600c:1f8d:b0:46e:3d17:b614 with SMTP id 5b1f17b1804b1-46e676c7450mr10824145e9.6.1759327097338;
        Wed, 01 Oct 2025 06:58:17 -0700 (PDT)
Received: from [192.168.3.141] (tmo-080-144.customers.d1-online.com. [80.187.80.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e619b8507sm41126065e9.3.2025.10.01.06.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 06:58:16 -0700 (PDT)
Message-ID: <43d78ba7-8829-4a19-bdf3-d192a62cdac4@redhat.com>
Date: Wed, 1 Oct 2025 15:58:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] mm: Introduce vm_uffd_ops API
To: Peter Xu <peterx@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Axel Rasmussen <axelrasmussen@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 James Houghton <jthoughton@google.com>, Nikita Kalyazin
 <kalyazin@amazon.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Ujwal Kundur <ujwal.kundur@gmail.com>, Mike Rapoport <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andrea Arcangeli <aarcange@redhat.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Michal Hocko
 <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, Hugh Dickins <hughd@google.com>,
 Suren Baghdasaryan <surenb@google.com>
References: <20250926211650.525109-1-peterx@redhat.com>
 <20250926211650.525109-2-peterx@redhat.com>
 <f1da3505-f17f-4829-80c1-696b1d99057d@redhat.com> <aNwmE11LirPtEuGW@x1.local>
 <f409cbe7-7865-45ab-af9a-6d5108bc5ad4@redhat.com> <aNw_GrZsql_M04T0@x1.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aNw_GrZsql_M04T0@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>>> I briefly wondered whether we could use actual UFFD_FEATURE_* here, but they
>>>> are rather unsuited for this case here (e.g., different feature flags for
>>>> hugetlb support/shmem support etc).
>>>>
>>>> But reading "uffd_ioctls" below, can't we derive the suitable vma flags from
>>>> the supported ioctls?
>>>>
>>>> _UFFDIO_COPY | _UFDIO_ZEROPAGE -> VM_UFFD_MISSING
>>>> _UFFDIO_WRITEPROTECT -> VM_UFFD_WP
>>>> _UFFDIO_CONTINUE -> VM_UFFD_MINOR
>>>
>>> Yes we can deduce that, but it'll be unclear then when one stares at a
>>> bunch of ioctls and cannot easily digest the modes the memory type
>>> supports.  Here, the modes should be the most straightforward way to
>>> describe the capability of a memory type.
>>
>> I rather dislike the current split approach between vm-flags and ioctls.
>>
>> I briefly thought about abstracting it for internal purposes further and
>> just have some internal backend ("memory type") flags.
>>
>> UFFD_BACKEND_FEAT_MISSING -> _UFFDIO_COPY and VM_UFFD_MISSING
>> UFFD_BACKEND_FEAT_ZEROPAGE -> _UFDIO_ZEROPAGE
>> UFFD_BACKEND_FEAT_WP -> _UFFDIO_WRITEPROTECT and VM_UFFD_WP
>> UFFD_BACKEND_FEAT_MINOR -> _UFFDIO_CONTINUE and VM_UFFD_MINOR
>> UFFD_BACKEND_FEAT_POISON -> _UFFDIO_POISON
> 
> This layer of mapping can be helpful to some, but maybe confusing to
> others.. who is familiar with existing userfaultfd definitions.
> 

Just wondering, is this confusing to you, and if so, which part?

To me it makes perfect sense and cleans up this API and not have to sets 
of flags that are somehow interlinked.

>>>
>>> If hugetlbfs supported ZEROPAGE, then we can deduce the ioctls the other
>>> way round, and we can drop the uffd_ioctls.  However we need the ioctls now
>>> for hugetlbfs to make everything generic.
>>
>> POISON is not a VM_ flag, so that wouldn't work completely, right?
> 
> Logically speaking, POISON should be meaningful if MISSING|MINOR is
> supported.  However, in reality, POISON should always be supported across
> all types..

Do you know what the plans are with guest_memfd?

> 
>>
>> As a side note, hugetlbfs support for ZEROPAGE should be fairly easy:
>> similar to shmem support, simply allocate a zeroed hugetlb folio.
> 
> IMHO it'll be good if we do not introduce ZEROPAGE only because we want to
> remove some flags.. We could be introducing dead codes that nobody uses.
> 
> I think it'll be good if we put that as a separate discussion, and define
> the vm_uffd_ops based on the current situation.

Right. I'd vote for an abstraction in the lines of what I proposed 
above. Doesn't have to be the terminology I used above, but some simple 
single set of flag that we can map to the underlying details.

But again, hoping to hear other opinions on this topic.

-- 
Cheers

David / dhildenb



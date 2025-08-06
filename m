Return-Path: <linux-kernel+bounces-757429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4D6B1C202
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEF113AB99D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 08:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33FA221557;
	Wed,  6 Aug 2025 08:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JcuDpOYE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E326220F57
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 08:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754468350; cv=none; b=HESBpnJpNnqC0LS0GYUUIRunLyKet2gavnyRlDAfPn/Na6F6ATVA1YudDP4btVvemg9zPjwRsc7YFN5eCdCSjJ2uwUzz4dhXVh//OT8quMlHqJmDh84rMAN/Y2HxE5qCfJeUMl5Bmq53yzKKnwsWY1Pv0E9kuX6YNFdyDjH8QNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754468350; c=relaxed/simple;
	bh=BUPDHg0Q2DqRhuygJa8K5RU2RgmqaOSZzMGgiDc9YyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j8nCkSjqdpZRxEfFYggXncnHzlwzkOIMsc4uYcNTaGsIqErnWQvVhNe8M8PyZoC1ScZ+4E9SPQjq72KcFtaIo6K3evJOnC29CQldTrThH8a6AtjxXyGe9/O6Ul6WLqiV/CoM1p4fsgCvPHx2yhkZrJ2WdcPpR8gXwolkP48HfxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JcuDpOYE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754468347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=znF6IF91Kjh9fOW1blnmEZLQNQBHGQn5QAy7B3RNZ1o=;
	b=JcuDpOYEUWIMFVgAbvrh2pgLDPsUhxiwBIxY9TeB7mwyJYSNhaePe0r4a3G8dDzsPsMh2h
	m4zzNoCi21kDzwlzHM9SOp9vkBg74GVRUnCeA+ByrW5FomHmU/A03OHKFXKyVIYDDRBNf7
	FYI55VtaCkzNE4KCAEj0LSPHlBk7Zuk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-ck9DJILWOuK2qh6_XZeEYw-1; Wed, 06 Aug 2025 04:19:06 -0400
X-MC-Unique: ck9DJILWOuK2qh6_XZeEYw-1
X-Mimecast-MFC-AGG-ID: ck9DJILWOuK2qh6_XZeEYw_1754468345
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4595cfed9f4so12744845e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 01:19:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754468345; x=1755073145;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=znF6IF91Kjh9fOW1blnmEZLQNQBHGQn5QAy7B3RNZ1o=;
        b=XrpOfuFEVHPzgC7BoyMwSldN1L3KLYsDgZ5p/LM74THWe/qjjjBoWtBaVw04yByre5
         REmzKWXwO+igLsBffrWwRGZ6rVNfsCoLUYAtk4sNJWm7uaPLxnyW3co7K/bD5RQ0hHx+
         BjXpKuqzrqmtY9Hekl58A+w2gfiaDi2IY26BMspSGJ861Zrkhj+HAgYSyKshQ1OUOUUK
         Ts2zWFMJS2LKbSvc+sIy/1gQj4//x2XzB4eVgYA0emBBq1ya72AP+SpnJoT4AJEW2B5P
         26TXJAz0LLgv7S2r88iDmq7kjmd0QgofUbIzso8fmsfoPAK2wytpp7U9xx6oRRmh0l6u
         0Vfg==
X-Forwarded-Encrypted: i=1; AJvYcCUAjO+Lvk3ie5VxWWq9GB4vOBebgsc77pwMJ7/2maT5Hl03cNFfU+/E3ACfcatdEkGBNoKV1FIUruxfV8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmWYFaMigpxGcdXgXCRz+EFGIMRFoOS1bEjikrc9Jp6CQGchh0
	2AOzOWFQ3O2uNlcauUsz+BuFPF/b9a8JMNApBIZO34aZVAlThwJw9/fabEGkG4S2czA53beahi8
	6Pf1C4hAHEVyooUx8iBJNaLEZTNvTOx3I7dmrwrCkPJhS5LV3U9mnc/Uj38ivUM5ozA==
X-Gm-Gg: ASbGncun3ZR5h/R+qLWikmA5pD8CFWztUCk4pUKAHNH5LSVEAxwG5hejHwu9zQbSmop
	Ps7ZxZRQnedEXgW/1XR3KV9iJEtZuoHj1f4MixBciKQFtmftzgJOoSyOHYZWdkX+RfjdWGTdd+b
	TXjtDQLgVbA1vYkqnnHoEyxsgv3MSXVDb3T97R1DNvBKpejAYvJGuuRTzvKU3TYyuZVGi24y26o
	4ajnSk5jfT+W0dBnm3nyFx8zEUODNxYnUCkFMBGcGbYocXx5dYsCIAVDBxbT0lH/2UvsMf6ay/w
	TQ7tjRyGM3q045Qf/XaE1/eALmaUS9MkxL37WIWmvW0zK6HdPAp8kOoZBAxZhkoRjJhzWX5l4vp
	wZhuW2bgSV6ZHFo+GRhFfCv0i+eIC82mgpYhKsX4Q7UUYYCTyzRvEzIkoL2XbMg==
X-Received: by 2002:a05:600c:35c6:b0:453:5c30:a1fd with SMTP id 5b1f17b1804b1-459e7087704mr18139005e9.8.1754468345086;
        Wed, 06 Aug 2025 01:19:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgROVHMEZgh0TP3BOKWjmCZln6savk2PzpCHP5awcCjYqYMP2QVJ3P1DIDcRnVzvlbVHqAlA==
X-Received: by 2002:a05:600c:35c6:b0:453:5c30:a1fd with SMTP id 5b1f17b1804b1-459e7087704mr18138545e9.8.1754468344556;
        Wed, 06 Aug 2025 01:19:04 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1e:2200:30f4:30:4011:370e? (p200300d82f1e220030f400304011370e.dip0.t-ipconnect.de. [2003:d8:2f1e:2200:30f4:30:4011:370e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953cfd10sm300498035e9.21.2025.08.06.01.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 01:19:04 -0700 (PDT)
Message-ID: <2d213b5c-555e-4a4c-92bc-58ca8480ca64@redhat.com>
Date: Wed, 6 Aug 2025 10:19:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] mm: Optimize mprotect() by PTE batching
To: Will Deacon <will@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org,
 ryan.roberts@arm.com, willy@infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
 Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz,
 jannh@google.com, anshuman.khandual@arm.com, peterx@redhat.com,
 joey.gouly@arm.com, ioworker0@gmail.com, baohua@kernel.org,
 kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com,
 christophe.leroy@csgroup.eu, yangyicong@hisilicon.com,
 linux-arm-kernel@lists.infradead.org, hughd@google.com,
 yang@os.amperecomputing.com, ziy@nvidia.com
References: <20250718090244.21092-1-dev.jain@arm.com>
 <20250718090244.21092-7-dev.jain@arm.com>
 <7567c594-7588-49e0-8b09-2a591181b24d@redhat.com>
 <aJMPOTripINrafxh@willie-the-truck>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <aJMPOTripINrafxh@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.08.25 10:15, Will Deacon wrote:
> On Wed, Aug 06, 2025 at 10:08:33AM +0200, David Hildenbrand wrote:
>> On 18.07.25 11:02, Dev Jain wrote:
>>> Use folio_pte_batch to batch process a large folio. Note that, PTE
>>> batching here will save a few function calls, and this strategy in certain
>>> cases (not this one) batches atomic operations in general, so we have
>>> a performance win for all arches. This patch paves the way for patch 7
>>> which will help us elide the TLBI per contig block on arm64.
>>>
>>> The correctness of this patch lies on the correctness of setting the
>>> new ptes based upon information only from the first pte of the batch
>>> (which may also have accumulated a/d bits via modify_prot_start_ptes()).
>>>
>>> Observe that the flag combination we pass to mprotect_folio_pte_batch()
>>> guarantees that the batch is uniform w.r.t the soft-dirty bit and the
>>> writable bit. Therefore, the only bits which may differ are the a/d bits.
>>> So we only need to worry about code which is concerned about the a/d bits
>>> of the PTEs.
>>>
>>> Setting extra a/d bits on the new ptes where previously they were not set,
>>> is fine - setting access bit when it was not set is not an incorrectness
>>> problem but will only possibly delay the reclaim of the page mapped by
>>> the pte (which is in fact intended because the kernel just operated on this
>>> region via mprotect()!). Setting dirty bit when it was not set is again
>>> not an incorrectness problem but will only possibly force an unnecessary
>>> writeback.
>>>
>>> So now we need to reason whether something can go wrong via
>>> can_change_pte_writable(). The pte_protnone, pte_needs_soft_dirty_wp,
>>> and userfaultfd_pte_wp cases are solved due to uniformity in the
>>> corresponding bits guaranteed by the flag combination. The ptes all
>>> belong to the same VMA (since callers guarantee that [start, end) will
>>> lie within the VMA) therefore the conditional based on the VMA is also
>>> safe to batch around.
>>>
>>> Since the dirty bit on the PTE really is just an indication that the folio
>>> got written to - even if the PTE is not actually dirty but one of the PTEs
>>> in the batch is, the wp-fault optimization can be made. Therefore, it is
>>> safe to batch around pte_dirty() in can_change_shared_pte_writable()
>>> (in fact this is better since without batching, it may happen that
>>> some ptes aren't changed to writable just because they are not dirty,
>>> even though the other ptes mapping the same large folio are dirty).
>>>
>>> To batch around the PageAnonExclusive case, we must check the corresponding
>>> condition for every single page. Therefore, from the large folio batch,
>>> we process sub batches of ptes mapping pages with the same
>>> PageAnonExclusive condition, and process that sub batch, then determine
>>> and process the next sub batch, and so on. Note that this does not cause
>>> any extra overhead; if suppose the size of the folio batch is 512, then
>>> the sub batch processing in total will take 512 iterations, which is the
>>> same as what we would have done before.
>>>
>>> For pte_needs_flush():
>>>
>>> ppc does not care about the a/d bits.
>>>
>>> For x86, PAGE_SAVED_DIRTY is ignored. We will flush only when a/d bits
>>> get cleared; since we can only have extra a/d bits due to batching,
>>> we will only have an extra flush, not a case where we elide a flush due
>>> to batching when we shouldn't have.
>>>
>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>
>>
>> I wanted to review this, but looks like it's already upstream and I suspect
>> it's buggy (see the upstream report I cc'ed you on)
> 
> Please excuse my laziness, but do you have a link to the report?

I was lazy :)

https://lkml.kernel.org/r/68930511.050a0220.7f033.003a.GAE@google.com

> I've
> been looking at some oddities on arm64 coming back from some of the CI
> systems and was heading in the direction of a recent mm regression
> judging by the first-known-bad-build in linux-next.
> 
> https://lore.kernel.org/r/CA+G9fYumD2MGjECCv0wx2V_96_FKNtFQpT63qVNrrCmomoPYVQ@mail.gmail.com

Hm, mprotect seems to be involved. So it might or might not correlate.

-- 
Cheers,

David / dhildenb



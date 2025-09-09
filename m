Return-Path: <linux-kernel+bounces-808523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FEAB500D6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8A4A17A8EF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3C6341652;
	Tue,  9 Sep 2025 15:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UYMIy5ZC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFBA2BB17
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 15:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757431099; cv=none; b=FJ+sCQAcc4NZbnt3njeK0wt4d7HmyaqPbXEVNvKhcKt2gmBfAyH/0WW2l7KUsw67xe22HtN3+5gJqxp/2KCCAmO4ap898YDHvCKEd/8RPRo08KD3EEvkFPkGYB2aIw5yHLhAi1I7RJTvJqy0vqns1Xw/zHq5SH24To3wyT8WvfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757431099; c=relaxed/simple;
	bh=WeRhoPwVOuPnfCidMxYPIA9M+FcAa7+ga7egTf1L99o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mDhyQFrZ0hjPzhIdLMU2l6sELvUbMKxUaTdC3+7vJwPJenknV/1RuNaehAZ4qPp/sDqUmSy5VBlWnLyx84i5YmYkCfInzfdBzJlsGzFJPD20CdrF4N1ueOP/vRWZx1weSSCpMSLXDJEuIA+hYS0PMQNMsCNLSwi0yewVWu9IIJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UYMIy5ZC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757431096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CftawZr7rfdLaKHBorroP5fxQHxVIg34Hy0mtfMoP4Y=;
	b=UYMIy5ZCZ8BeOMyKLsHT4SwZMwIKXVUgxi7a0OhYBx1Hok1J+Y9PJB357jkFoVy6CY2NK2
	fg2N4hUMN5hKmnD856rwLOSUY37wyzjVLYyMfZCGfUbpvPZxeu1EpOa/gBpjNdpXxaxrna
	xd9nS3iisU4cDqSo/kBShodwDI7mKNY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-2n7mo9IFNdW8g7-RFOyV9Q-1; Tue, 09 Sep 2025 11:18:15 -0400
X-MC-Unique: 2n7mo9IFNdW8g7-RFOyV9Q-1
X-Mimecast-MFC-AGG-ID: 2n7mo9IFNdW8g7-RFOyV9Q_1757431094
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45dd66e1971so40945565e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 08:18:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757431094; x=1758035894;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CftawZr7rfdLaKHBorroP5fxQHxVIg34Hy0mtfMoP4Y=;
        b=VRW3YmbnoNPZs+74NH4yxp0VSk9XnmUILaPNqPPSysdDNY0CwPTE1qUHTGuQp+t6WR
         ZVMbIUvI793t/qmG61Nt1+2bWut/li1Xqdf+oHWSug7eo69nmHG8dbWfjIh8X3MAHa2d
         QS/KKneC+wAV/pN6OygTKMs06j5kUunNFMGdpPaHQTgvKS6awhf/SK7HjGYnUeuSdA7h
         z0MxmdIrlJ7LC6eX+0reZI8P7t8rqQCtn50ytGwJAgTWhH9vaO6Eawm8XpNnw79cAcBd
         baCXUeUihH+NysBNnAsgTPwWZu2q60XUfMVpF3H7oWbChvvHJvnDetkAEWX4LgOOjH+r
         lubA==
X-Forwarded-Encrypted: i=1; AJvYcCVpTc8DwLP8bzYvTQSgPlp8/qy79B7gjEI5KFcT4ZIUsYqOcq5USIjYPFb03xuaUjM0U+KIzYMPTlIZnXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjgMJwmOw3QOfE6AL1z8A5nRlfZNVazDjFGnvTYY4DxtcId3BS
	PaRDAXTBry968oVD1P/zSSkHwg1PSBRddq6fiEFc/NW2eq2kH/IKZT6VtPaJOyagKPiiL+QD2F8
	FVhtWWR2QvhlFPbwKHnoE9k9B7+Oph1RHn9yAii7g3tjW5arnoPZg/koHn+kFqxdQ+A==
X-Gm-Gg: ASbGnctXZhrFO085bmVYzBdjebzy5Ph/nib3PNoEXZkLG8HTy17igJVdAsF+TYjwN4e
	Dp8aKFDVAbELmZDbQEafvGDMXJexVAzGYJEKK2z91snhhO6tK5fXjwOYdVk3d3EaduysUeQ/T5k
	lRKz8el89zDdTkxBaQuw462KEufqqOAJAcj8vPz0GZhcHFl1JIefT27Ic8yLu9L8fuZR3l+uBFP
	VJLSSOaORycJvrmg8Ql+d4hnQoBeZk2NZqRd7s2krYDk2NXLKbi5Ei69FPjghhdEVHU2Y52gt4Y
	L5glLSJQTyovUQcOCkyK4IuXSsQf08SEhozAb257dGty8oHp85oF5AaqbEXOiSKYpuCJvB7rvEZ
	6FecAVIvSwEsXtiSkzMg4KvYCW9H1TLDECaOHblG3XD6FX0Yzon537H3UJEMbPmqH1yE=
X-Received: by 2002:a05:600c:3b9f:b0:45d:edf6:367c with SMTP id 5b1f17b1804b1-45df1228190mr25913645e9.30.1757431093862;
        Tue, 09 Sep 2025 08:18:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHw6Lb67cLGpYBVgnVwWX1UQSM6fovL58P0tQZLYw/wsEhx0Z87VnEgBCuQy4LuoXQD/jMb7g==
X-Received: by 2002:a05:600c:3b9f:b0:45d:edf6:367c with SMTP id 5b1f17b1804b1-45df1228190mr25913185e9.30.1757431093360;
        Tue, 09 Sep 2025 08:18:13 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f23:9c00:d1f6:f7fe:8f14:7e34? (p200300d82f239c00d1f6f7fe8f147e34.dip0.t-ipconnect.de. [2003:d8:2f23:9c00:d1f6:f7fe:8f14:7e34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dda4f2a0dsm189504735e9.2.2025.09.09.08.18.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 08:18:12 -0700 (PDT)
Message-ID: <fba37e0d-b809-48b5-9637-7cfffa469801@redhat.com>
Date: Tue, 9 Sep 2025 17:18:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/15] mm, swap: check page poison flag after locking
 it
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
 Chris Li <chrisl@kernel.org>, Barry Song <baohua@kernel.org>,
 Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 linux-kernel@vger.kernel.org
References: <20250905191357.78298-1-ryncsn@gmail.com>
 <20250905191357.78298-5-ryncsn@gmail.com>
 <bd8338cf-6723-46ef-9043-3ced8be56e62@redhat.com>
 <CAMgjq7BPk1PJn0JGo+ERnisSimG0FSuiQZHDY3bf2gBgE5rU1g@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CAMgjq7BPk1PJn0JGo+ERnisSimG0FSuiQZHDY3bf2gBgE5rU1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09.09.25 16:54, Kairui Song wrote:
> On Mon, Sep 8, 2025 at 8:40 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 05.09.25 21:13, Kairui Song wrote:
>>> From: Kairui Song <kasong@tencent.com>
>>>
>>> Instead of checking the poison flag only in the fast swap cache lookup
>>> path, always check the poison flags after locking a swap cache folio.
>>>
>>> There are two reasons to do so.
>>>
>>> The folio is unstable and could be removed from the swap cache anytime,
>>> so it's totally possible that the folio is no longer the backing folio
>>> of a swap entry, and could be an irrelevant poisoned folio. We might
>>> mistakenly kill a faulting process.
>>>
>>> And it's totally possible or even common for the slow swap in path
>>> (swapin_readahead) to bring in a cached folio. The cache folio could be
>>> poisoned, too. Only checking the poison flag in the fast path will miss
>>> such folios.
>>>
>>> The race window is tiny, so it's very unlikely to happen, though.
>>> While at it, also add a unlikely prefix.
>>>
>>> Signed-off-by: Kairui Song <kasong@tencent.com>
>>> ---
>>>    mm/memory.c | 22 +++++++++++-----------
>>>    1 file changed, 11 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 10ef528a5f44..94a5928e8ace 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -4661,10 +4661,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>                goto out;
>>>
>>>        folio = swap_cache_get_folio(entry);
>>> -     if (folio) {
>>> +     if (folio)
>>>                swap_update_readahead(folio, vma, vmf->address);
>>> -             page = folio_file_page(folio, swp_offset(entry));
>>> -     }
>>>        swapcache = folio;
>>>
>>>        if (!folio) {
>>> @@ -4735,20 +4733,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>                ret = VM_FAULT_MAJOR;
>>>                count_vm_event(PGMAJFAULT);
>>>                count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
>>> -             page = folio_file_page(folio, swp_offset(entry));
>>> -     } else if (PageHWPoison(page)) {
>>> -             /*
>>> -              * hwpoisoned dirty swapcache pages are kept for killing
>>> -              * owner processes (which may be unknown at hwpoison time)
>>> -              */
>>> -             ret = VM_FAULT_HWPOISON;
>>> -             goto out_release;
>>>        }
>>>
>>>        ret |= folio_lock_or_retry(folio, vmf);
>>>        if (ret & VM_FAULT_RETRY)
>>>                goto out_release;
>>>
>>> +     page = folio_file_page(folio, swp_offset(entry));
>>>        if (swapcache) {
>>>                /*
>>>                 * Make sure folio_free_swap() or swapoff did not release the
>>> @@ -4761,6 +4752,15 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>                             page_swap_entry(page).val != entry.val))
>>>                        goto out_page;
>>>
>>> +             if (unlikely(PageHWPoison(page))) {
>>> +                     /*
>>> +                      * hwpoisoned dirty swapcache pages are kept for killing
>>> +                      * owner processes (which may be unknown at hwpoison time)
>>> +                      */
>>> +                     ret = VM_FAULT_HWPOISON;
>>> +                     goto out_page;
>>> +             }
>>> +
>>>                /*
>>>                 * KSM sometimes has to copy on read faults, for example, if
>>>                 * folio->index of non-ksm folios would be nonlinear inside the
>>
>> LGTM, but I was wondering whether we just want to check that even when
> 
> Thanks for checking the patch.
> 
>> we just allocated a fresh folio for simplicity. The check is cheap ...
>>
> 
> Maybe not for now? This patch expects folio_test_swapcache to filter
> out potentially irrelevant folios, so moving the check before that is
> in theory not correct.. And folio_test_swapcache check won't work for
> the fresh allocated folio here...
> 
> I'm planning to remove the whole `if (swapcache)` check in phase 2, as
> all swapin will go through swap cache. By that time all checks will
> always be applied. The simplification will be done in a cleaner way.
> 

Fair enough :)

-- 
Cheers

David / dhildenb



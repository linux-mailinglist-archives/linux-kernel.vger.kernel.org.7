Return-Path: <linux-kernel+bounces-824181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E553B884B4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F027A1C8295E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6507D2FDC4F;
	Fri, 19 Sep 2025 07:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="akpU8FtL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4472E972A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758268656; cv=none; b=bGhITdvc7073vVTZdscUTd4I+uambXZCH6VViINChBKRdrbe6RCcYQubGOUpuRn3kJ8XILD4+JhndneSLSbE1seVQmtNhBsytCU7lnB0Iw6pD1p/T9nChi3211RPldOvudbWeRPSLOFTeE95lJme8LKuGPPAjOGiButRvi/jYrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758268656; c=relaxed/simple;
	bh=iQu0e6452YP4MU8FtwWHTPx8IrSn3CKiOMHFMFgagsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LsVuAonbljFY7oDY9wnLh9Zv/7uw5BsLgfP81RiI5t75dFZ4tE0q0zYuEqLz9TY2E0cswWXVnWbRAvM/HDzCxoHY5fR+IJ0dRLz07x1OPq3d5RcK+R2LXjzKmEvF/2Z49qhhIi62SZxmiiEvcOj7Bkk+L/Bt1SXmEDvjD1Jf3Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=akpU8FtL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758268652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=J1s8mwSO2g5lRMeqraDC/TqSw7CSZKUekvBH0GY1gmk=;
	b=akpU8FtLSG1Uw6EYGap6EqRGd2CXMzB0QT4EoWIBCjBCbAJnmYyVZemYL3hBHQSs94Gbtg
	yDAY7nhOPisOh3MXVwq446MhajKmEAoPGBhl6tMNocOrNhrsYvVVIVCYLhDhG9SX44Rl2s
	XMDiMdv4K9TUpMexERu4kDNFZ34S6Z0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-oydiF5kyMUq_l2bK-HZunw-1; Fri, 19 Sep 2025 03:57:30 -0400
X-MC-Unique: oydiF5kyMUq_l2bK-HZunw-1
X-Mimecast-MFC-AGG-ID: oydiF5kyMUq_l2bK-HZunw_1758268650
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ef21d77d2eso587530f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 00:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758268649; x=1758873449;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J1s8mwSO2g5lRMeqraDC/TqSw7CSZKUekvBH0GY1gmk=;
        b=inREP6fry2tx9GpLYMpzDH0XARv44ExV49kXOCHqzCjDUjqUkhLTgyyfAuEUaslrWO
         yQdb6D/ToY741IAz5tGxqhd2Q6kAwLxuJ7q4WvC5vTOdBuIqBLQ+Bj7ScFecrOPp7zgx
         XB+O34NuRcPaYoSkNaxw5nh8qOBsA5p3tYp2ThVMqu49zdzGJ7SQkGUCMV1LyarEM9TO
         RhFf6B6IjPA2USR9ZC+o6f/PUrZet2IVMbunxssOge4Z7aVvab3AcWkTqHxJqLPSwvmC
         gBuORnwm24wlkJwJOPySqyby5sugUuj3UCqW0WM6yFOcGPyC0i3utEP+wM/qzMVwQoN0
         wxiA==
X-Forwarded-Encrypted: i=1; AJvYcCXuseNitmTO7HONj9gsOd0hZuXzYwJLOLcgOjIlSRXHuDKIOWpfxnWtkoYKxPUJNiYS26/8SBZzdXJ8WD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsjYNPWtjM/JwTfCKFF06S17pLGZ1nD2EBinoZgUgY5MIqsnWj
	BrQaXIedtZY0/1+6uQcUn4eUbo7Nqc4aAvjlFmbiOSFzerJEa31d00uzEJi6yrD8Fsq6LxMGi1F
	mUVDKMKjBxeV+k1q3Tf1JDYm2heJojTRUy5aau5XxCN+c026iHqMVfrC8Nsiy36+96g==
X-Gm-Gg: ASbGncscgEeT33VjgWgKEmlGOF55zWiHqv3jPHDuDj1HyIbe2nz44VZtd/9Jp+993Qw
	M6wwN+jL1P0HYF1CoXZbWzCvNuxzgseR0eIUAnAioJyPsUNskwOjyEjF3J0RKjKKHQZcDYA9zj9
	3PK0VlIS4VIPU4Xc0zIlR/WIL3W7xpyoZKQkaCukxz1kHlpSBYNiALzq6aIxwkerOE6HtE3wbuY
	676vKRaP86R8EvGSSISMLn+BED1RBgk9QcVBo90daqTU6t/sfC1sp9VaeWP2G8k4QoU85HA5bDv
	nacw1LA1iUAj3fR97YUQzkfyCVoojNGqC/8LHGeOJiR2OYcqXnT6i79j88JWzosdUJMhdbzdeBG
	bVvTfumr9/hLg4ltDlTX0tatW1MZkjvhx4h3NV8gX7ZszC+DSStqKtDyQY4y05dlXaVlc
X-Received: by 2002:a05:6000:184b:b0:3b7:8da6:1bb4 with SMTP id ffacd0b85a97d-3ee86b847d0mr1591299f8f.58.1758268649451;
        Fri, 19 Sep 2025 00:57:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkZRQx29miXlmD6Dl9ZIU3cZmCOgkk9Qp+5+CBhTu1QALMkgNhzbJGdlj25U9DPoCGB0X1NA==
X-Received: by 2002:a05:6000:184b:b0:3b7:8da6:1bb4 with SMTP id ffacd0b85a97d-3ee86b847d0mr1591281f8f.58.1758268648999;
        Fri, 19 Sep 2025 00:57:28 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f23:5600:727b:b2f6:94a1:a51b? (p200300d82f235600727bb2f694a1a51b.dip0.t-ipconnect.de. [2003:d8:2f23:5600:727b:b2f6:94a1:a51b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7410sm6681789f8f.35.2025.09.19.00.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 00:57:27 -0700 (PDT)
Message-ID: <7840f68e-7580-42cb-a7c8-1ba64fd6df69@redhat.com>
Date: Fri, 19 Sep 2025 09:57:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new v2 2/2] mm/khugepaged: abort collapse scan on guard
 PTEs
To: Lance Yang <lance.yang@linux.dev>
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, ioworker0@gmail.com, kirill@shutemov.name,
 hughd@google.com, mpenttil@redhat.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, akpm@linux-foundation.org, lorenzo.stoakes@oracle.com
References: <20250918050431.36855-1-lance.yang@linux.dev>
 <20250918050431.36855-3-lance.yang@linux.dev>
 <a696c734-9f88-4d6f-a852-013071a2dd2a@redhat.com>
 <eabd866a-aed3-4e28-a139-13b7c1d4e715@linux.dev>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <eabd866a-aed3-4e28-a139-13b7c1d4e715@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19.09.25 04:41, Lance Yang wrote:
> 
> 
> On 2025/9/19 02:47, David Hildenbrand wrote:
>> On 18.09.25 07:04, Lance Yang wrote:
>>> From: Lance Yang <lance.yang@linux.dev>
>>>
>>> Guard PTE markers are installed via MADV_GUARD_INSTALL to create
>>> lightweight guard regions.
>>>
>>> Currently, any collapse path (khugepaged or MADV_COLLAPSE) will fail when
>>> encountering such a range.
>>>
>>> MADV_COLLAPSE fails deep inside the collapse logic when trying to swap-in
>>> the special marker in __collapse_huge_page_swapin().
>>>
>>> hpage_collapse_scan_pmd()
>>>    `- collapse_huge_page()
>>>        `- __collapse_huge_page_swapin() -> fails!
>>>
>>> khugepaged's behavior is slightly different due to its max_ptes_swap
>>> limit
>>> (default 64). It won't fail as deep, but it will still needlessly scan up
>>> to 64 swap entries before bailing out.
>>>
>>> IMHO, we can and should detect this much earlier.
>>>
>>> This patch adds a check directly inside the PTE scan loop. If a guard
>>> marker is found, the scan is aborted immediately with
>>> SCAN_PTE_NON_PRESENT,
>>> avoiding wasted work.
>>>
>>> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>>> ---
>>>    mm/khugepaged.c | 10 ++++++++++
>>>    1 file changed, 10 insertions(+)
>>>
>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>> index 9ed1af2b5c38..70ebfc7c1f3e 100644
>>> --- a/mm/khugepaged.c
>>> +++ b/mm/khugepaged.c
>>> @@ -1306,6 +1306,16 @@ static int hpage_collapse_scan_pmd(struct
>>> mm_struct *mm,
>>>                        result = SCAN_PTE_UFFD_WP;
>>>                        goto out_unmap;
>>>                    }
>>> +                /*
>>> +                 * Guard PTE markers are installed by
>>> +                 * MADV_GUARD_INSTALL. Any collapse path must
>>> +                 * not touch them, so abort the scan immediately
>>> +                 * if one is found.
>>> +                 */
>>> +                if (is_guard_pte_marker(pteval)) {
>>> +                    result = SCAN_PTE_NON_PRESENT;
>>> +                    goto out_unmap;
>>> +                }
>>
>> Thinking about it, this is interesting.
>>
>> Essentially we track any non-swap swap entries towards
>> khugepaged_max_ptes_swap, which is rather weird.
>>
>> I think we might also run into migration entries here and hwpoison entries?
>>
>> So what about just generalizing this:
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index af5f5c80fe4ed..28f1f4bf0e0a8 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -1293,7 +1293,24 @@ static int hpage_collapse_scan_pmd(struct
>> mm_struct *mm,
>>           for (_address = address, _pte = pte; _pte < pte + HPAGE_PMD_NR;
>>                _pte++, _address += PAGE_SIZE) {
>>                   pte_t pteval = ptep_get(_pte);
>> -               if (is_swap_pte(pteval)) {
>> +
>> +               if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
>> +                       ++none_or_zero;
>> +                       if (!userfaultfd_armed(vma) &&
>> +                           (!cc->is_khugepaged ||
>> +                            none_or_zero <= khugepaged_max_ptes_none)) {
>> +                               continue;
>> +                       } else {
>> +                               result = SCAN_EXCEED_NONE_PTE;
>> +                               count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
>> +                               goto out_unmap;
>> +                       }
>> +               } else if (!pte_present(pteval)) {
>> +                       if (non_swap_entry(pte_to_swp_entry(pteval))) {
>> +                               result = SCAN_PTE_NON_PRESENT;
>> +                               goto out_unmap;
>> +                       }
>> +
>>                           ++unmapped;
>>                           if (!cc->is_khugepaged ||
>>                               unmapped <= khugepaged_max_ptes_swap) {
>> @@ -1313,18 +1330,7 @@ static int hpage_collapse_scan_pmd(struct
>> mm_struct *mm,
>>                                   goto out_unmap;
>>                           }
>>                   }
>> -               if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
>> -                       ++none_or_zero;
>> -                       if (!userfaultfd_armed(vma) &&
>> -                           (!cc->is_khugepaged ||
>> -                            none_or_zero <= khugepaged_max_ptes_none)) {
>> -                               continue;
>> -                       } else {
>> -                               result = SCAN_EXCEED_NONE_PTE;
>> -                               count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
>> -                               goto out_unmap;
>> -                       }
>> -               }
>> +
>>                   if (pte_uffd_wp(pteval)) {
>>                           /*
>>                            * Don't collapse the page if any of the small
>>
>>
>> With that, the function flow looks more similar to
>> __collapse_huge_page_isolate(),
>> except that we handle swap entries in there now.
> 
> Ah, indeed. I like this crazy idea ;p
> 
>>
>>
>> And with that in place, couldn't we factor out a huge chunk of both
>> scanning
>> functions into some helper (passing whether swap entries are allowed or
>> not?).
> 
> Yes. Factoring out the common scanning logic into a new helper is a
> good suggestion. It would clean things up ;)
> 
>>
>> Yes, I know, refactoring khugepaged, crazy idea.
> 
> I'll look into that. But let's do this separately :)

Right, but let's just skip any non-swap entries early in this patch 
instead of special-casing only guard ptes.

-- 
Cheers

David / dhildenb



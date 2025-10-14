Return-Path: <linux-kernel+bounces-853003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B09BDA69A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16BD31884607
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0AC3002BD;
	Tue, 14 Oct 2025 15:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aKhNXcAo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB232F0C49
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760456010; cv=none; b=Bhr+KVSd6EKsgw6v3+MSFRnf3VRBKmKQxGOfrfp+SoFch9HOTfC4u8Vk9/zY403XsGtz7IHMXVcQUbvFAXig+FQXyQ3Fg1LuNAdHzOdEiWUVk7S2JA/GQAWiSGL/oRSptMB8qL3IY8qWK5/hTVFE5f4YLPoegq9t7jLsOnsVHAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760456010; c=relaxed/simple;
	bh=A5tDhDfx2NrPSdbsqzXdlZzxceL/afhanUpACY9p8F4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=M+FBVlrpoJEcvQIuFBg0GJwkgjZlyspOqLmHwUEXAEccmeBDkOxn8JJzgAGHmw0DGkVbHxOPTzhhzvL1dKM8VAMWIko/MBVYWPChLheDE0NSjs1WxEmRU57crQpncxWTgwEyurIt/nlBVd2fHmROyD/SwRBbtNAD4vvzO/eBwZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aKhNXcAo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760456007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+1UVYE8sOFf7urKOQ7gZ7h3LRzinBvs61P0Q6ItQr+k=;
	b=aKhNXcAo/UM2bvc9V0lageY8H4TGmjNrV+zCpxJamtY2IFHfDpK6zD9dmsA0Dg3KW2ekbl
	tVgq3m2K5jQ06VKx8s/J4NzFj9FiMcn+n/G30SPEEnpQAJuhPc+xY0GtkLqgOTmWNxFprn
	7ibLNaluQMvkbGjD5X6gCmlhrdGbuR8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-YZ3YMIuUN_6SOjkn7Xi2mQ-1; Tue, 14 Oct 2025 11:33:21 -0400
X-MC-Unique: YZ3YMIuUN_6SOjkn7Xi2mQ-1
X-Mimecast-MFC-AGG-ID: YZ3YMIuUN_6SOjkn7Xi2mQ_1760456000
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e32eb4798so28425185e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:33:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760456000; x=1761060800;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+1UVYE8sOFf7urKOQ7gZ7h3LRzinBvs61P0Q6ItQr+k=;
        b=QVI0B1a1dvmz52Mcf9KgwyNNyxhnagZWqft1O3YRK5zorPSQGyvS6nD5jKHd4bnSxW
         GsnFKD7hqmbK7MjO2vMpeOHv/y7u8VHyAN42XH5BER6y9upOMTX4OXCK2EtAXhnIlzWu
         mfOQofFsvJKowgT5xA9EzkvtdileAiwox9oxajr4sixZq7fqDNS9Ph+K+TAbhrhgDtvi
         ZEPpg5Hg3eTPXRCd/Xh3z1VKuYh6W8vQ0gbdp0lYQjbE+Ik1YZI/lcBX4+KH0O+8SB4N
         H0gCAaOxn9QUcXc/BeojYWS+NzsLM7PSzjIvp/pLQrsiAzHaY6eM8VdfqldV1uPpI3ZR
         4NQw==
X-Forwarded-Encrypted: i=1; AJvYcCVoTVkJCFXf7GosRWx2t/6S1enppNU34nyR6DMmUkQeceeX+XFrAtRzcGKKlZxbT0sF+BpmdmE92hJ/nHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzzsbSWwrhP1EGfYMDTDgAeV3A1awjenhMO7pKNksYfu8HvGaS
	EEaM6QTAACLHKc4eH1lt+DCtVeegYzqt8Y3XWfanmEl7/OqOx/jlrjxEEwTzMX2PTCLwLM73bZu
	gOD/LQNUUgXZ0PyuuocTrlCo2O2S6yy5p6gl0LVWYBvR6kfHonU2U14QExUahEFfeRg==
X-Gm-Gg: ASbGnctlTCUNkcsAIQ5u98p7AUhUZC5is0kHpimHwY2E/jCzCO2RvJ/4j6XunTfR96O
	8qiew5jevbf9q6Pq1ai4Zq2Ft/5+nNufSWvvbNl9Y4vhfPM5cUJI5bclI5ATNQCi68ThPUt6/w5
	PgQwArD2dc93zETQnsk/xtLgRwmt6j70JfzrYDNJcIAwwUgEje3GKPoUnznbrHd4CGaOS72xPH8
	MGA33JzIfkLnwXWrDdK+6+d8fY0Am85ISiVVwxg85Jr0Hx0buAuZqbVnIBwXyCIktMrBhjgPNWM
	SVXnSCJQU9SIwB+HxE7xDtQ4hk8rJXQBaBpz6be/KIW68OikBh0ejhVmrvpDhrcOLpmkiGOrkw=
	=
X-Received: by 2002:a05:600c:4506:b0:45b:8a0e:cda9 with SMTP id 5b1f17b1804b1-46fa9a8638dmr184763975e9.2.1760456000236;
        Tue, 14 Oct 2025 08:33:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhJpIXD7XQ5pJSvl2kMtYK5HLrtya1KimSbQX7gY+SFRx0KBjyrmvvoAE0I1/rLJ3ZdqjMkg==
X-Received: by 2002:a05:600c:4506:b0:45b:8a0e:cda9 with SMTP id 5b1f17b1804b1-46fa9a8638dmr184763725e9.2.1760455999749;
        Tue, 14 Oct 2025 08:33:19 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb32a84edsm132343605e9.4.2025.10.14.08.33.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 08:33:19 -0700 (PDT)
Message-ID: <e2c77ce4-c260-4d10-b9b6-93a507080e61@redhat.com>
Date: Tue, 14 Oct 2025 17:33:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new v3 1/1] mm/khugepaged: abort collapse scan on
 non-swap entries
From: David Hildenbrand <david@redhat.com>
To: Lance Yang <lance.yang@linux.dev>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, dev.jain@arm.com, hughd@google.com,
 ioworker0@gmail.com, kirill@shutemov.name, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, mpenttil@redhat.com, npache@redhat.com,
 ryan.roberts@arm.com, ziy@nvidia.com, richard.weiyang@gmail.com
References: <20251008032657.72406-1-lance.yang@linux.dev>
 <f33735d3-b38d-4b6a-aeba-b415e6b24ea2@lucifer.local>
 <0bfdbccd-9d4a-409f-ae43-b44bb7347d70@linux.dev>
 <f7392f43-b8f1-4e6a-b9c8-25ad8a47f82c@lucifer.local>
 <d2e5b099-94bd-444d-9946-182807443539@linux.dev>
 <c44e198d-7d46-491e-adc1-86cc306c27db@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <c44e198d-7d46-491e-adc1-86cc306c27db@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.10.25 17:12, David Hildenbrand wrote:
> On 14.10.25 17:01, Lance Yang wrote:
>>
>>
>> On 2025/10/14 22:39, Lorenzo Stoakes wrote:
>>> On Tue, Oct 14, 2025 at 10:26:20PM +0800, Lance Yang wrote:
>>>>
>>>>
>>>> On 2025/10/14 19:08, Lorenzo Stoakes wrote:
>>>>> On Wed, Oct 08, 2025 at 11:26:57AM +0800, Lance Yang wrote:
>>>>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>>>>> index abe54f0043c7..bec3e268dc76 100644
>>>>>> --- a/mm/khugepaged.c
>>>>>> +++ b/mm/khugepaged.c
>>>>>> @@ -1020,6 +1020,11 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
>>>>>>      		if (!is_swap_pte(vmf.orig_pte))
>>>>>>      			continue;
>>>>>>
>>>>>> +		if (non_swap_entry(pte_to_swp_entry(vmf.orig_pte))) {
>>>>>> +			result = SCAN_PTE_NON_PRESENT;
>>>>>> +			goto out;
>>>>>> +		}
>>>>>
>>>>> OK seems in line with what we were discussing before...
>>>>
>>>> Yep. That's the idea :)
>>>>
>>>>>
>>>>>> +
>>>>>>      		vmf.pte = pte;
>>>>>>      		vmf.ptl = ptl;
>>>>>>      		ret = do_swap_page(&vmf);
>>>>>> @@ -1281,7 +1286,23 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>>>>>>      	for (addr = start_addr, _pte = pte; _pte < pte + HPAGE_PMD_NR;
>>>>>>      	     _pte++, addr += PAGE_SIZE) {
>>>>>>      		pte_t pteval = ptep_get(_pte);
>>>>>> -		if (is_swap_pte(pteval)) {
>>>>>> +		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
>>>>>> +			++none_or_zero;
>>>>>> +			if (!userfaultfd_armed(vma) &&
>>>>>> +			    (!cc->is_khugepaged ||
>>>>>> +			     none_or_zero <= khugepaged_max_ptes_none)) {
>>>>>> +				continue;
>>>>>> +			} else {
>>>>>> +				result = SCAN_EXCEED_NONE_PTE;
>>>>>> +				count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
>>>>>> +				goto out_unmap;
>>>>>> +			}
>>>>>> +		} else if (!pte_present(pteval)) {
>>>>>> +			if (non_swap_entry(pte_to_swp_entry(pteval))) {
>>>>>
>>>>
>>>> Thanks for pointing that out!
>>>
>>> You've deleted what I've said here and also not indicated whether you'll do what
>>> I asked :)
>>>
>>> Please be clearer...
>>
>> Oh, I didn't delete your comment at all ... It's just below ...
>>
>>>
>>>>>>> Hm but can't this be pte_protnone() at this stage (or something
>> else)? And then <-- Here!
>>>>
>>>> Yeah. The funny thing is, a protnone pte cannot actually get here, IIUC.
>>>>
>>>> ```
>>>> static inline int pte_protnone(pte_t pte)
>>>> {
>>>> 	return (pte_flags(pte) & (_PAGE_PROTNONE | _PAGE_PRESENT))
>>>> 		== _PAGE_PROTNONE;
>>>> }
>>>>
>>>> static inline int pte_present(pte_t a)
>>>> {
>>>> 	return pte_flags(a) & (_PAGE_PRESENT | _PAGE_PROTNONE);
>>>> }
>>>> ```
>>>>
>>>> On x86, pte_present() returns true for a protnone pte. And I'd assume
>>>> other archs behave similarly ...
>>>
>>> This was one example, we may make changes in the future that result in entries
>>> that are non-present but also non-swap.
>>>
>>> I don't see the point in eliminating this check based on an implicit, open-coded
>>> assumption that this can never be the case, this is just asking for trouble.
>>>
>>>>
>>>>> we're just assuming pte_to_swp_entry() is operating on a swap entry when it in
>>>>> fact might not be?
>>>>>
>>>>> Couldn't we end up with false positives here?
>>>>
>>>> Emm, I think we're good here and the code is doing the right thing.
>>>
>>> I mean sorry but just - NO - to doing swap operations based on open-coded checks
>>> that you implicitly feel must imply a swap entry.
>>>
>>> This makes the code a lot more confusing, it opens us up to accidentally
>>> breaking things in future and has little to no benefit, I don't see why we're
>>> doing it.
>>>
>>> I don't think every little 'aha X must imply Y so just eliminate Z' idea need be
>>> implemented, this feels like a sort of 'mathematical reduction of code ignoring
>>> all other factors'.
>>
>> Understood. Changing !pte_present() to is_swap_pte() will resolve all your
>> concerns, right?
>>
>> ```
>> if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
>> [...]
>> } else if (is_swap_pte(pteval)) { <-- Here
>> 	if (non_swap_entry(pte_to_swp_entry(pteval))) {
>> 		[...]
>> 	}
>> [...]}
> 
> Can we please take a step back and make sure we are not starting to do
> stuff differently than elswehere in the kernel, please?
> 

For the sake of progress, I assume the compiler will optimize out the 
additional pte_none() stuff.

I absolutely, absolutely hate is_swap_pte(). To me, it makes the code 
more confusing that talking about something that is !present but also 
!none: there is something that is not an ordinary page table mapping.

The underlying problem is how we hacked in non-swap into swap (and 
that's exactly where it gets confusing). Well, which this series is all 
about.

So, I don't care in the end here.

-- 
Cheers

David / dhildenb



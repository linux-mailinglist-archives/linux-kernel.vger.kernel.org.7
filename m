Return-Path: <linux-kernel+bounces-852936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 333C6BDA3FF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3E201882066
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FC32C159C;
	Tue, 14 Oct 2025 15:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WPbkKyuJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FE91E520E
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454680; cv=none; b=AsDk1dC4Iidvm3c/Y13CYv6tJ+UqiTnenfHpHf0pPqDlg28ofkJBDxvmY8Xp6khA5yGU6ctEhmMCdxYq3YNeqQuTmbP4ZVT3sUoNdQjQ466c0wS2tCa2zZG0UP6coIccsVsDIVARB2K113z+ndQcwuZWd55u4qPzbcFl/1i5Tzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454680; c=relaxed/simple;
	bh=+QFCKm745Z/00h5zCuILSocXxNG1+eYeEsVr0w3cEKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FNoEHH5xWtt/RiCj06QA6/eZHX+2wPfx0FRHz2CjBVzpuBkfLH+TGcy2zcqXy2zbwRcUsyrdPH+YKp36sCGglxS+fq9v6ke+Ir0bqbFae7sfohRbDEhwzqEZzSxh0DH5Ayh7Nw8JyIAMX3/kUnvAi0PHaeF/5ZlxeLak13BF1ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WPbkKyuJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760454677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CFM7dXtICj/fa8yA6o+n0YfJf/ny9ONIQh0B3zZDb+k=;
	b=WPbkKyuJm2RrsoWr0pUS4nR4bU9L0V/XDt36iRGHgEdDMi3Yzr7DWLyMk79pZoDENtGrhf
	7Tf1qyeFo+xzv2NCHstqvc6Z7XxoxTERZbH8zJKRkxcka0l8TMp142i/09kxbmzb4hdov+
	42p+jrqNYO6SwYKHEVuRdVA34mSCkvA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-xw9k4j8vN9i0ZbSYWNhGsA-1; Tue, 14 Oct 2025 11:11:16 -0400
X-MC-Unique: xw9k4j8vN9i0ZbSYWNhGsA-1
X-Mimecast-MFC-AGG-ID: xw9k4j8vN9i0ZbSYWNhGsA_1760454675
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e407c600eso41152765e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:11:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760454675; x=1761059475;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CFM7dXtICj/fa8yA6o+n0YfJf/ny9ONIQh0B3zZDb+k=;
        b=V8G3gpOdfRoEgTE/tsFs0Pd7wGHZ4aKr1TDTsY8ruPD2AfE3vhhJMywkcpwDH7/Orx
         vXhaIDczfya9vzFX6XxRx3XVDRzCINDtZrYUg4T3QLx21w0EY57XPOTDQzCSG9nxirKt
         G9I44YRvSxP0dEgkvd6kdOGAOJ4cnqfRCwx/tuHsCXm0bpw7JW8arJMLrf7SeVVf89yt
         l/M4Y32rqHr9VrsVeupQpm8TFcI77B5OQ+R5zw0Iq+YHq2Zvcpg4cxc8jJ1iddS32KpW
         tZlFH1mU7cZLHuPqXtZY+nf7lsinSfFo7YBJvfcviP8ZeDJYLHMnjMvKAUEDl2K41F4l
         uJ9g==
X-Forwarded-Encrypted: i=1; AJvYcCVlAnHd9d5w0zhvvsyMGH41vs1//Wk3UkjONU27V/atLG4Pu5EGbeWfTTcdsLh/QtlCvlCpkU6xwqxe7b8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbujGnI4wdNTWsHzLpxw3iH3MphYM9djnQ+kzt0e4U3YK9nVJU
	yOhVD+YQ6L8mIjAvVgfsDKmnxmmEGC40iPWiemh9xzmEA6RD2EPRjpRH3xFyhqfZX0+bibdn20B
	tXU4ddvCRacJhlrMA3BKbsnuzzfjLOgdDXmERZDrAnjSYvJDvRSnRPZXZQYx1mP++jg==
X-Gm-Gg: ASbGncu9IslJpzvnHl28035BexiQLx0XwTtY9R1FkVD+51Fk0fO6LCrcTyD2ls50kEW
	+YxSX22ZXlAMruUj9UkluFoer1CTsTzUI9uHYOftek3udN8KBzYd3RzcztzZ5cKkUA0Z/k+akbi
	acDKf361pbpabVnUU82QiSqGPUJ747llMuK2ZjjX9jdzTGC45yVGoD0HUaNUh+39+ddF59SisQw
	B1s/lLUzcABU3XxtGsp10DCRfrTovZC4hdzlhYSCnS+PpyyVJ/1lSx9dymlyYTPYJ2qOCreUr1L
	qtLAbBZ1Yq24kVE7iCYjMdOa63X7NHFgLmiQSNk8GFlvGl57miA6MLqyW/yOXuHCiaa3z5FRHQ=
	=
X-Received: by 2002:a05:600c:608d:b0:46e:6d5f:f59 with SMTP id 5b1f17b1804b1-46fa9a8b2aemr174419405e9.4.1760454674832;
        Tue, 14 Oct 2025 08:11:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAGYdJNsQt56FoIi3mVgcJVNPd2gqaodPPXK/4B0rTbZ0qKVvefWZK8UoRY5YIzCmIEwIKPw==
X-Received: by 2002:a05:600c:608d:b0:46e:6d5f:f59 with SMTP id 5b1f17b1804b1-46fa9a8b2aemr174418995e9.4.1760454674352;
        Tue, 14 Oct 2025 08:11:14 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb49d03e2sm246982765e9.19.2025.10.14.08.11.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 08:11:13 -0700 (PDT)
Message-ID: <95a223b1-8d57-40c3-8226-678b1db233aa@redhat.com>
Date: Tue, 14 Oct 2025 17:11:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new v3 1/1] mm/khugepaged: abort collapse scan on
 non-swap entries
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, dev.jain@arm.com, hughd@google.com,
 ioworker0@gmail.com, kirill@shutemov.name, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, mpenttil@redhat.com, npache@redhat.com,
 ryan.roberts@arm.com, ziy@nvidia.com, richard.weiyang@gmail.com
References: <20251008032657.72406-1-lance.yang@linux.dev>
 <f33735d3-b38d-4b6a-aeba-b415e6b24ea2@lucifer.local>
 <0bfdbccd-9d4a-409f-ae43-b44bb7347d70@linux.dev>
 <f7392f43-b8f1-4e6a-b9c8-25ad8a47f82c@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <f7392f43-b8f1-4e6a-b9c8-25ad8a47f82c@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.10.25 16:39, Lorenzo Stoakes wrote:
> On Tue, Oct 14, 2025 at 10:26:20PM +0800, Lance Yang wrote:
>>
>>
>> On 2025/10/14 19:08, Lorenzo Stoakes wrote:
>>> On Wed, Oct 08, 2025 at 11:26:57AM +0800, Lance Yang wrote:
>>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>>> index abe54f0043c7..bec3e268dc76 100644
>>>> --- a/mm/khugepaged.c
>>>> +++ b/mm/khugepaged.c
>>>> @@ -1020,6 +1020,11 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
>>>>    		if (!is_swap_pte(vmf.orig_pte))
>>>>    			continue;
>>>>
>>>> +		if (non_swap_entry(pte_to_swp_entry(vmf.orig_pte))) {
>>>> +			result = SCAN_PTE_NON_PRESENT;
>>>> +			goto out;
>>>> +		}
>>>
>>> OK seems in line with what we were discussing before...
>>
>> Yep. That's the idea :)
>>
>>>
>>>> +
>>>>    		vmf.pte = pte;
>>>>    		vmf.ptl = ptl;
>>>>    		ret = do_swap_page(&vmf);
>>>> @@ -1281,7 +1286,23 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>>>>    	for (addr = start_addr, _pte = pte; _pte < pte + HPAGE_PMD_NR;
>>>>    	     _pte++, addr += PAGE_SIZE) {
>>>>    		pte_t pteval = ptep_get(_pte);
>>>> -		if (is_swap_pte(pteval)) {
>>>> +		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
>>>> +			++none_or_zero;
>>>> +			if (!userfaultfd_armed(vma) &&
>>>> +			    (!cc->is_khugepaged ||
>>>> +			     none_or_zero <= khugepaged_max_ptes_none)) {
>>>> +				continue;
>>>> +			} else {
>>>> +				result = SCAN_EXCEED_NONE_PTE;
>>>> +				count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
>>>> +				goto out_unmap;
>>>> +			}
>>>> +		} else if (!pte_present(pteval)) {
>>>> +			if (non_swap_entry(pte_to_swp_entry(pteval))) {
>>>
>>
>> Thanks for pointing that out!
> 
> You've deleted what I've said here and also not indicated whether you'll do what
> I asked :)
> 
> Please be clearer...
> 
>>
>>> Hm but can't this be pte_protnone() at this stage (or something else)? And then
>>
>> Yeah. The funny thing is, a protnone pte cannot actually get here, IIUC.
>>
>> ```
>> static inline int pte_protnone(pte_t pte)
>> {
>> 	return (pte_flags(pte) & (_PAGE_PROTNONE | _PAGE_PRESENT))
>> 		== _PAGE_PROTNONE;
>> }
>>
>> static inline int pte_present(pte_t a)
>> {
>> 	return pte_flags(a) & (_PAGE_PRESENT | _PAGE_PROTNONE);
>> }
>> ```
>>
>> On x86, pte_present() returns true for a protnone pte. And I'd assume
>> other archs behave similarly ...
> 
> This was one example, we may make changes in the future that result in entries
> that are non-present but also non-swap.
> 
> I don't see the point in eliminating this check based on an implicit, open-coded
> assumption that this can never be the case, this is just asking for trouble.
> 
>>
>>> we're just assuming pte_to_swp_entry() is operating on a swap entry when it in
>>> fact might not be?
>>>
>>> Couldn't we end up with false positives here?
>>
>> Emm, I think we're good here and the code is doing the right thing.
> 
> I mean sorry but just - NO - to doing swap operations based on open-coded checks
> that you implicitly feel must imply a swap entry.
> 
> This makes the code a lot more confusing, it opens us up to accidentally
> breaking things in future and has little to no benefit, I don't see why we're
> doing it.
> 
> I don't think every little 'aha X must imply Y so just eliminate Z' idea need be
> implemented, this feels like a sort of 'mathematical reduction of code ignoring
> all other factors'.

Not sure I follow. If something is !none && !present it's what we call a 
swap PTE (that includes actual swap and non-swap PTEs).

We have the exact same code flow for example in 
copy_pte_range()->copy_nonpresent_pte() and I don't see a problem with it.

If we were to ever change what we call a "swap PTE" (I don't think so?) 
we'd have to fix stuff all over the place.

Maybe I get the concern here wrong?

-- 
Cheers

David / dhildenb



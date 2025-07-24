Return-Path: <linux-kernel+bounces-744747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A798B11072
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 19:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 747BE5A422F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D45C2EB5B4;
	Thu, 24 Jul 2025 17:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e5dAMy/I"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137E92D8367
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 17:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753378846; cv=none; b=KA4MC+qdi8VwWYmlv7+gRh4Fj7jmKKiKURYcGY1xgKtSLOtWPUvxab2Qiz/xRjD8aO9AGh0Y/s4l/NIbLF/hPdzq20H2JOCiH7mAud6epTb6ODtiHFosNkz65ycPKhpfB5o/WZp1c4tWfUYrMofHGaFo8G/jGo735dnaeLxIGvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753378846; c=relaxed/simple;
	bh=q6t1mahNuzZ74igVi3p+PExlGB055u8Epvd+HbGG8cI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U93zMa2AWphm/66XZZixHzXGtSre8TuVly7DbgyoaSLBiXXgTqxorjX7oV6ZzFWGHOMrXHFJ+j2NxY7IJ9DqHpyjyIJFW8NQUzmszD1CrLO1pcN/QpJKS/Dt1XF2gaTnqtbhnF26k0r1UeHxJ/Jd1+WVA69taMLOktO3HMdKL0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e5dAMy/I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753378843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PnBhIOhkNgjsPUOGU68ShalsAx1zsEf3moa4hYO0HfY=;
	b=e5dAMy/IjUmJKppznuecgVPb2RcwDr3F07pQ04Aysny/Kzjfd26M9d3O4E/UlKtAWPyBAZ
	X6hlz+YhSyfYwOw8oTW26g2WYfAhkoLSIk4KG/qqtTMvppoXXdYcnUj8gSzjR1LuefcpLX
	TZHmAGyC7ob2v9eMsj0/kHekvWRhYzs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-JKLSQh7mPjWPMbcXIewY2g-1; Thu, 24 Jul 2025 13:40:42 -0400
X-MC-Unique: JKLSQh7mPjWPMbcXIewY2g-1
X-Mimecast-MFC-AGG-ID: JKLSQh7mPjWPMbcXIewY2g_1753378841
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4560a30a793so4917045e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 10:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753378841; x=1753983641;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PnBhIOhkNgjsPUOGU68ShalsAx1zsEf3moa4hYO0HfY=;
        b=cDccpOy0tAzWobEKiH05BrWXqoj2uzgzdTNF8fiD3GpSNjV6uKwbVcjgz69SLr/tdV
         xDS3woV51c1Ep1RxbH1OgCLdStDjFGlcHNjOZcHDcdVsVycU1oAFuAhkLOx9KHn/xUo7
         zCUttssXMhEOxePnJi6X2R3/ZktQ9t92E02bkr+2rD0jT8uEPd7FWg0Lo59bSWralrJa
         Ui/C9ccWeIdBTPdZpAuoeDy2KYNT8UIbZkScE/OeUy7qbvm83cIGQB6sMcAlGeoZVox+
         baA7xPgYP1MJwmriEodZlMUBkstBj7nuO6+B8rApS8pwExQDIgNSePWXxQsS1kD8h6ak
         aSFw==
X-Forwarded-Encrypted: i=1; AJvYcCV+Idsg+y/iQHbQD7p1IwVyv0SNuQ7aGwken9d1uTptccXRXArCiEr0VyO01ccqWR8Mf7HUyBA0EY/f160=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5KC9D4IjYw6A3A50GyL6MMGrnJsjb5r9/bI8Z5gp4TE2bpfEj
	CE3Czam8O6Yj0oU5pVEK+jRgagGGhIdvSElg2p0J50iNglN3vrUqh4SeAPBkVTE8gaXDh0YmJ66
	iF3UOiMikemmN3H+dj8xRCS/atFhgeTOwldLlHTLowZbFXUdSdcdRBg0RsOwTPHJ66g==
X-Gm-Gg: ASbGncsIUUTf6fvH981NGW/LR0a+sUQS/DOXvFUzmUYIa/KElClihp+XJ9lmURfmOMO
	llTf8fRD3a4jxG2y5v2xAaVxGqxof7ZIfkA97BgsO+9chw9RHu4rII4rr+ZuFP6WjMU722qLU5D
	GZriJ8fBw+DZuYw6lqASBG5aqdcGoh1NpppGGHW3EUQLAq9CqBfxIA6e7kD6Kk+HSE/HE4UMYxr
	chgJGYoSZZjp5Y2CXoVuPUm62o9F4wovYl7j58uI8EcP8TaM860QPeDfxDEX03pin+1MWDU0Xd0
	JyKRNdd7MErgJ6tkJc9jgo7IfMPHzlkVduzJt5+4LdZGZTWGw57kYWshD0c9kLxr6CN4SFE=
X-Received: by 2002:a05:600c:3b1a:b0:43c:f8fc:f697 with SMTP id 5b1f17b1804b1-45868c8d67amr74577785e9.9.1753378840650;
        Thu, 24 Jul 2025 10:40:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHvjs0X1fA0kzcXhZ9W/oub8Movy4UXE750gEZ0unOi/Yu3rUYgc9Lka+eqlq8FUYlwpkRqA==
X-Received: by 2002:a05:600c:3b1a:b0:43c:f8fc:f697 with SMTP id 5b1f17b1804b1-45868c8d67amr74577455e9.9.1753378840060;
        Thu, 24 Jul 2025 10:40:40 -0700 (PDT)
Received: from [192.168.3.141] (p57a1acc3.dip0.t-ipconnect.de. [87.161.172.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705c4cacsm26765925e9.24.2025.07.24.10.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 10:40:39 -0700 (PDT)
Message-ID: <c69f0b21-1e67-4e1d-b56b-a5c1294e8b45@redhat.com>
Date: Thu, 24 Jul 2025 19:40:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] khugepaged: Optimize
 __collapse_huge_page_copy_succeeded() by PTE batching
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 baohua@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <kjveoiyczkjlm65d3agasjbtplezshwwjyudq4jbxhygcc7plm@dre33kse3y6g>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <kjveoiyczkjlm65d3agasjbtplezshwwjyudq4jbxhygcc7plm@dre33kse3y6g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.07.25 19:32, Lorenzo Stoakes wrote:
> Message-ID: <32843cfb-a70b-4dfb-965c-4e1b0623a1b4@lucifer.local>
> Reply-To:
> In-Reply-To: <20250724052301.23844-3-dev.jain@arm.com>
> 
> NIT: Please don't capitalise 'Optimize' here.
> 
> I think Andrew fixed this for you actually in the repo though :P
> 
> On Thu, Jul 24, 2025 at 10:53:00AM +0530, Dev Jain wrote:
>> Use PTE batching to batch process PTEs mapping the same large folio. An
>> improvement is expected due to batching refcount-mapcount manipulation on
>> the folios, and for arm64 which supports contig mappings, the number of
>> TLB flushes is also reduced.
>>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> ---
>>   mm/khugepaged.c | 25 ++++++++++++++++++-------
>>   1 file changed, 18 insertions(+), 7 deletions(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index a55fb1dcd224..f23e943506bc 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -700,12 +700,15 @@ static void __collapse_huge_page_copy_succeeded(pte_t *pte,
>>   						spinlock_t *ptl,
>>   						struct list_head *compound_pagelist)
>>   {
>> +	unsigned long end = address + HPAGE_PMD_SIZE;
>>   	struct folio *src, *tmp;
>> -	pte_t *_pte;
>>   	pte_t pteval;
>> +	pte_t *_pte;
>> +	unsigned int nr_ptes;
>>
>> -	for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
>> -	     _pte++, address += PAGE_SIZE) {
>> +	for (_pte = pte; _pte < pte + HPAGE_PMD_NR; _pte += nr_ptes,
>> +	     address += nr_ptes * PAGE_SIZE) {
>> +		nr_ptes = 1;
>>   		pteval = ptep_get(_pte);
>>   		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
>>   			add_mm_counter(vma->vm_mm, MM_ANONPAGES, 1);
>> @@ -722,18 +725,26 @@ static void __collapse_huge_page_copy_succeeded(pte_t *pte,
>>   			struct page *src_page = pte_page(pteval);
>>
>>   			src = page_folio(src_page);
>> -			if (!folio_test_large(src))
>> +
>> +			if (folio_test_large(src)) {
>> +				unsigned int max_nr_ptes = (end - address) >> PAGE_SHIFT;
>> +
>> +				nr_ptes = folio_pte_batch(src, _pte, pteval, max_nr_ptes);
>> +			} else {
>>   				release_pte_folio(src);
>> +			}
>> +
>>   			/*
>>   			 * ptl mostly unnecessary, but preempt has to
>>   			 * be disabled to update the per-cpu stats
>>   			 * inside folio_remove_rmap_pte().
>>   			 */
>>   			spin_lock(ptl);
>> -			ptep_clear(vma->vm_mm, address, _pte);
>> -			folio_remove_rmap_pte(src, src_page, vma);
>> +			clear_ptes(vma->vm_mm, address, _pte, nr_ptes);
>> +			folio_remove_rmap_ptes(src, src_page, nr_ptes, vma);
>>   			spin_unlock(ptl);
>> -			free_folio_and_swap_cache(src);
>> +			free_swap_cache(src);
>> +			folio_put_refs(src, nr_ptes);
> 
> Hm one thing here though is the free_folio_and_swap_cache() does:
> 
> 	free_swap_cache(folio);
> 	if (!is_huge_zero_folio(folio))
> 		folio_put(folio);
> 
> Whereas here you unconditionally reduce the reference count. Might this
> cause issues with the shrinker version of the huge zero folio?
> 
> Should this be:
> 
> 			if (!is_huge_zero_folio(src))
> 				folio_put_refs(src, nr_ptes);
> 
> Or do we otherwise avoid issues with this?

The huge zero folio is never PTE-mapped.

-- 
Cheers,

David / dhildenb



Return-Path: <linux-kernel+bounces-702290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F98AE807C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 12:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A82C2188EE7A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 11:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9AC29B771;
	Wed, 25 Jun 2025 10:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gi1CxZlM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF72D214209
	for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 10:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750849168; cv=none; b=R0aq5KGwjoN14BG2PDKtDUBUnma5TAzmn0pbLrldGo5Vxr2b67oEH2dc4x6QhK84JeoPPjXvsgBKrwPmWJDXX81RwhGUVeCZ3204fNmmjycDNiUWxCq8GX5NAaj89mGBh1pc7erG3Tu3G2zb3WocWMU8BrRP6hrw3SPraq5ICL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750849168; c=relaxed/simple;
	bh=fEEMLPwkXv1zTpZ3n59Xi1a3rBtX0QuWr7/xncdWUls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lA+JHyWcr3E0azfXfGRIH/3G4/0VbFXbSXWyYlL+JE61JD1LTv6QO6Wi9VDUG9861qVmzpM3cy9VvENFbOhj6hS1By4VkHlbuspGGSh/LcQN/tPBSV16gosL3rYJeO+EOyPqBCEh3u2n4I57gv1h8uuoegUX6EW3IF46qoF+jx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gi1CxZlM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750849165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GQ708vu4avBCMPhkM+hqdqAXtmzk7kBGgUnbB1W0/yM=;
	b=gi1CxZlMf+H2JYkAEiZDL1rKw3wdK7NlhYobf9Wz//sOFgQicHy9zpk7fLkbfgeheDJDQ0
	4PXos7jMxdyB45os5bTjdbcojiqvyWKezNQfW/oXLeZnpJO/gCEVrm111/JQC7a1HXjZdH
	5E6V/hv5HhLGIuTztJMlSAP0yKfn4GE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-sJ4ftmSCPfCF1tDn09o1ag-1; Wed, 25 Jun 2025 06:59:24 -0400
X-MC-Unique: sJ4ftmSCPfCF1tDn09o1ag-1
X-Mimecast-MFC-AGG-ID: sJ4ftmSCPfCF1tDn09o1ag_1750849163
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-451d3f03b74so8988495e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 03:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750849163; x=1751453963;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GQ708vu4avBCMPhkM+hqdqAXtmzk7kBGgUnbB1W0/yM=;
        b=VvC3mMJ5mvq+4EQibwNo3xj/TfUQL9H1kdu8s+JThnBD2YZk/w7ydklMno591i3W+z
         cny3dCW+FamSbM5tpUrafHYsd/O9RYYVNNbmrqVW1XVCeQQnFTxE6PS7JvjPV6QZQ072
         wiUcFh3e4g7McHPBODTNuBjvZvCHJMUT5iUvuCkitQY8QAa+o10VW7sLGIFJjAQVWYZC
         XoGd8tAzbANAsg7kHKVz86dciyz//DOSLMRdDju7DXwi8r03zNrNn3jYZkacsBq4yROg
         jpLYBd6zlE3VHv2dTNpnX3QqRILQOZi3wMsZPIU1sl53EyuImFcjYBNMpZpxIYQv7QSJ
         ZovA==
X-Forwarded-Encrypted: i=1; AJvYcCUdEx1j9M5WU1YGmUHDzojxkeUCUSbscnwVXa2Ot4zoy+boXJRXZiuDEqC/wpcr3ASFjZHqCuolwkdEAdA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2m+BO7M69zqp0oPxhAhkmic7GBMvvRGMdtAQuoZ9gyL4yBh67
	qLHmJahCxHA485VAHDpD8CyeHCSlC58OyuDipb782yluBw8U0yvVv+1YX6yzN3KFbmABGZIXTFB
	Rvdu9h/sMHLF01WNW28GBEK0HdpAa8Id3CR3sSemddQGI8zItBtbqzQpvm8wHFUBmsQ==
X-Gm-Gg: ASbGnctKRWQ1B09T2G+CzdvYbqHyi7HU3kjX5D/DddIr0xiZ2MC9OlDyqI9OgSmNyqk
	iT86pCg8w8IHJ0NgtE+sYG3TLHd+MCl0+gGiTMacscaNVEcoPNKaUUWb6hnuLhMkE5sr8NVOKSU
	GBLaeEVy0XPKbOmZqI9oAUxwKpAVte9aQzSd6tVMfbvmI/o5Pk2ymK/O7QCTYSXnxRy+d8OOQlT
	/FLX1riD3MYBKW4mEovsqlwyiIUHE4fMKEuiFdIYPmL4NHuCWgdBGmITtScXsslCdIdpbbnkBne
	iHPiH9mgmqNFt02+HszwzTB6hBFEE4F32KTmxeZsjZSadtReELCQwtOLxSO6g5/+jDIHCmpW0XN
	Sn1MpQtgAjmmRnhBl82egekDGDSSAKSQUA5seVmsEZeec
X-Received: by 2002:a05:600c:64cf:b0:43d:fa58:700e with SMTP id 5b1f17b1804b1-45381af6af8mr20391405e9.33.1750849163269;
        Wed, 25 Jun 2025 03:59:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDpfug9PmYOC/S+NqZ57NJ8Jm3l0ZdGNpTYbf8qxhN/FecM/8gb7Bcic4PKJ268lMQ/vZeMA==
X-Received: by 2002:a05:600c:64cf:b0:43d:fa58:700e with SMTP id 5b1f17b1804b1-45381af6af8mr20391015e9.33.1750849162720;
        Wed, 25 Jun 2025 03:59:22 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f12:1b00:5d6b:db26:e2b7:12? (p200300d82f121b005d6bdb26e2b70012.dip0.t-ipconnect.de. [2003:d8:2f12:1b00:5d6b:db26:e2b7:12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e80ff461sm4398628f8f.67.2025.06.25.03.59.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 03:59:22 -0700 (PDT)
Message-ID: <146b4cb1-aa1e-4519-9e03-f98cfb1135d2@redhat.com>
Date: Wed, 25 Jun 2025 12:59:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] mm: Support batched unmap for lazyfree large
 folios during reclamation
To: Barry Song <21cnbao@gmail.com>
Cc: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org,
 baolin.wang@linux.alibaba.com, chrisl@kernel.org, kasong@tencent.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-riscv@lists.infradead.org,
 lorenzo.stoakes@oracle.com, ryan.roberts@arm.com, v-songbaohua@oppo.com,
 x86@kernel.org, ying.huang@intel.com, zhengtangquan@oppo.com
References: <2c19a6cf-0b42-477b-a672-ed8c1edd4267@redhat.com>
 <20250624162503.78957-1-ioworker0@gmail.com>
 <27d174e0-c209-4851-825a-0baeb56df86f@redhat.com>
 <CAGsJ_4wyByWJqzsDGhx=4=Xs+3uUZt6PZdyVoUCUMAo350cm-g@mail.gmail.com>
 <8a157228-0b7e-479d-a224-ec85b458ea75@redhat.com>
 <CAGsJ_4xPEqXozZCy623LzD6Y01cM9XrbrrYAbddXnUj2eZ8O2Q@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGsJ_4xPEqXozZCy623LzD6Y01cM9XrbrrYAbddXnUj2eZ8O2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25.06.25 12:49, Barry Song wrote:
> On Wed, Jun 25, 2025 at 10:43 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 25.06.25 12:38, Barry Song wrote:
>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>>> index fb63d9256f09..241d55a92a47 100644
>>>>> --- a/mm/rmap.c
>>>>> +++ b/mm/rmap.c
>>>>> @@ -1847,12 +1847,25 @@ void folio_remove_rmap_pud(struct folio *folio, struct page *page,
>>>>>
>>>>>     /* We support batch unmapping of PTEs for lazyfree large folios */
>>>>>     static inline bool can_batch_unmap_folio_ptes(unsigned long addr,
>>>>> -                     struct folio *folio, pte_t *ptep)
>>>>> +                                           struct folio *folio, pte_t *ptep,
>>>>> +                                           struct vm_area_struct *vma)
>>>>>     {
>>>>>         const fpb_t fpb_flags = FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
>>>>> +     unsigned long next_pmd, vma_end, end_addr;
>>>>>         int max_nr = folio_nr_pages(folio);
>>>>>         pte_t pte = ptep_get(ptep);
>>>>>
>>>>> +     /*
>>>>> +      * Limit the batch scan within a single VMA and within a single
>>>>> +      * page table.
>>>>> +      */
>>>>> +     vma_end = vma->vm_end;
>>>>> +     next_pmd = ALIGN(addr + 1, PMD_SIZE);
>>>>> +     end_addr = addr + (unsigned long)max_nr * PAGE_SIZE;
>>>>> +
>>>>> +     if (end_addr > min(next_pmd, vma_end))
>>>>> +             return false;
>>>>
>>>> May I suggest that we clean all that up as we fix it?
>>>>
>>>> Maybe something like this:
>>>>
>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>> index 3b74bb19c11dd..11fbddc6ad8d6 100644
>>>> --- a/mm/rmap.c
>>>> +++ b/mm/rmap.c
>>>> @@ -1845,23 +1845,38 @@ void folio_remove_rmap_pud(struct folio *folio, struct page *page,
>>>>     #endif
>>>>     }
>>>>
>>>> -/* We support batch unmapping of PTEs for lazyfree large folios */
>>>> -static inline bool can_batch_unmap_folio_ptes(unsigned long addr,
>>>> -                       struct folio *folio, pte_t *ptep)
>>>> +static inline unsigned int folio_unmap_pte_batch(struct folio *folio,
>>>> +               struct page_vma_mapped_walk *pvmw, enum ttu_flags flags,
>>>> +               pte_t pte)
>>>>     {
>>>>            const fpb_t fpb_flags = FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
>>>> -       int max_nr = folio_nr_pages(folio);
>>>> -       pte_t pte = ptep_get(ptep);
>>>> +       struct vm_area_struct *vma = pvmw->vma;
>>>> +       unsigned long end_addr, addr = pvmw->address;
>>>> +       unsigned int max_nr;
>>>> +
>>>> +       if (flags & TTU_HWPOISON)
>>>> +               return 1;
>>>> +       if (!folio_test_large(folio))
>>>> +               return 1;
>>>> +
>>>> +       /* We may only batch within a single VMA and a single page table. */
>>>> +       end_addr = min_t(unsigned long, ALIGN(addr + 1, PMD_SIZE), vma->vm_end);
>>>
>>> Is this pmd_addr_end()?
>>>
>>
>> Yes, that could be reused as well here.
>>
>>>> +       max_nr = (end_addr - addr) >> PAGE_SHIFT;
>>>>
>>>> +       /* We only support lazyfree batching for now ... */
>>>>            if (!folio_test_anon(folio) || folio_test_swapbacked(folio))
>>>> -               return false;
>>>> +               return 1;
>>>>            if (pte_unused(pte))
>>>> -               return false;
>>>> -       if (pte_pfn(pte) != folio_pfn(folio))
>>>> -               return false;
>>>> +               return 1;
>>>> +       /* ... where we must be able to batch the whole folio. */
>>>> +       if (pte_pfn(pte) != folio_pfn(folio) || max_nr != folio_nr_pages(folio))
>>>> +               return 1;
>>>> +       max_nr = folio_pte_batch(folio, addr, pvmw->pte, pte, max_nr, fpb_flags,
>>>> +                                NULL, NULL, NULL);
>>>>
>>>> -       return folio_pte_batch(folio, addr, ptep, pte, max_nr, fpb_flags, NULL,
>>>> -                              NULL, NULL) == max_nr;
>>>> +       if (max_nr != folio_nr_pages(folio))
>>>> +               return 1;
>>>> +       return max_nr;
>>>>     }
>>>>
>>>>     /*
>>>> @@ -2024,9 +2039,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>>>>                            if (pte_dirty(pteval))
>>>>                                    folio_mark_dirty(folio);
>>>>                    } else if (likely(pte_present(pteval))) {
>>>> -                       if (folio_test_large(folio) && !(flags & TTU_HWPOISON) &&
>>>> -                           can_batch_unmap_folio_ptes(address, folio, pvmw.pte))
>>>> -                               nr_pages = folio_nr_pages(folio);
>>>> +                       nr_pages = folio_unmap_pte_batch(folio, &pvmw, flags, pteval);
>>>>                            end_addr = address + nr_pages * PAGE_SIZE;
>>>>                            flush_cache_range(vma, address, end_addr);
>>>>
>>>>
>>>> Note that I don't quite understand why we have to batch the whole thing or fallback to
>>>> individual pages. Why can't we perform other batches that span only some PTEs? What's special
>>>> about 1 PTE vs. 2 PTEs vs. all PTEs?
>>>>
>>>>
>>>> Can someone enlighten me why that is required?
>>>
>>> It's probably not a strict requirement — I thought cases where the
>>> count is greater than 1 but less than nr_pages might not provide much
>>> practical benefit, except perhaps in very rare edge cases, since
>>> madv_free() already calls split_folio().
>>
>> Okay, but it makes the code more complicated. If there is no reason to
>> prevent the batching, we should drop it.
> 
> It's not necessarily more complex, since page_vma_mapped_walk() still
> has to check each PTE individually and can't skip ahead based on nr.
> With nr_pages batched, we can exit the loop early in one go.

I said "complicated", not "complex". The code is more complicated than 
necessary.

-- 
Cheers,

David / dhildenb



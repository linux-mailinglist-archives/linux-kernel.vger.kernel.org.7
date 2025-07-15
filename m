Return-Path: <linux-kernel+bounces-731619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED74B0573E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3DCB17030E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820792D375A;
	Tue, 15 Jul 2025 09:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dwEL1RTn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEB42561AE
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752573393; cv=none; b=guOND7O6WEdBmC/rU74eCiWmX9TatYYf3SArZ0nGlFRG8v+PwheUnXIFg+7YqFfs7qUPZxPZtSu63Ac0+6AzG9NmgzXtpzxXt0JCA/EkSjjLsIRQpIzCCB3I6+S652EQNUFK3tBEXwimZsATRzH0k1ai7UvL6FxRkA0AxuME4d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752573393; c=relaxed/simple;
	bh=cRqgNoUUSyQ8PcQsZacCveVeWYUnIK5jm0zf/Lrhc4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GXzAtBnGFNaIVGAvMhSh+P15hl6FJZBHEhgGUXXN8IO/V0IKqemiW5+YEfiJxxn2nBjLauGiSskztTJnq1XthjHkgrKqp3T8hVh+t+LgpY73eiQ6lI3lERYQElviaQ9jnKhMSdpbc1N9eiUpDhOj0XMDHKvj0Bzff1e466Wed98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dwEL1RTn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752573391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pnA4IPD44g6/jzC6xd2sZTmwSU0IvchPHU5KZSlw0ao=;
	b=dwEL1RTnN7YRyMlxFY62+IPCYkCOJvrN8JeGOL4pWLgsfrj3q2ztbzrVH70c/8qTYy/ujQ
	hE3WuqdEyHJ12n3To4rxuwqNYBfGp88iV7m4vW8On0zRi/tSQW/+OD35exnLriPxVXZ7W/
	4cIT/yFrdWp9T7EfxsXyCeS+kwWVPf0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-c4EMga8eN2yH8wBEqw_2ww-1; Tue, 15 Jul 2025 05:56:29 -0400
X-MC-Unique: c4EMga8eN2yH8wBEqw_2ww-1
X-Mimecast-MFC-AGG-ID: c4EMga8eN2yH8wBEqw_2ww_1752573388
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4560f28b2b1so8784945e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 02:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752573388; x=1753178188;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pnA4IPD44g6/jzC6xd2sZTmwSU0IvchPHU5KZSlw0ao=;
        b=KvZSiuT6in1YxeZ4uDn8iZMf28BdPFvx/89D3wwfvDhQdLYIFi0fI+DJibnktNkAxs
         HUfxAfBEJ3BVUDo+DbJTJGqs5Y/2fVKd1el3jZ6tQGcEbCJ7rLiCuH6ez++Fmx3bt4Q1
         KdfIL5e/58yy3M7nVXTSL1uXq0ulqgkW2ghlDC8jU7qkIaLK7eqAi12PPsVPh6FrcZSz
         r98Bs4hwoQems/OpcgzJe0n/IHyXSW0puWGjRE8CWkp/BOjWFSB0ZN9cSuOaD0VwTaaf
         pKwbKfhGM40kgpUdKB85IHlTdXbN1fsbBwrbAA7icBeG/fGISfqToemxJeRq8j2kuoTO
         c9/w==
X-Forwarded-Encrypted: i=1; AJvYcCU2CJKL1see/hlxU1zeVAVzEuFl8awhIm3zM17c2PnyJN3rOAjNbxXkO1/kt28ZBjsOtDJoVcX3fzOi5hM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjQ8kK/UXn63C67j1lQGvRJxadVBsuQ8BejoNUGZFevU7e8ni0
	tYlqZBtvW0hXevCgeblYTTfQ9KwVai4cwsJfJpew6PJxh5eiLDVyYl5AHtaItIByBxKGJnOLDYM
	rDgPPuQLpTrD3PTL0yhOBOGmIOg768H00meDxQxkbnPGDo/c6IjpKmP/Vyi53IPCdSA==
X-Gm-Gg: ASbGnctmUI2xLYWRjpjOYum/5fv4m2O6wkvjqnLhTjvKDz++XqfW/oWbgy1aDptibXp
	MF9+KVTtyPlX+kDcFY+FSvsgWYkecBHvOkiQOinf7jHQzwdVsLeOEkmSJfk3KgA4/bkS9Z0hXA0
	O+qRGga2oHvIG24H8V3iwsRSUylApo7k2+mEpT8hqn4ekwFZMUdccADE3tFlHhRmqgI96O4F3wu
	w9ch6EpROGHqqk7s+fgxIdKJZQxKhAHrhLlg++IfT9dz9aWYyuDjO0D2U8FEDBeOlHniyo+KAL8
	SSQ8Gm858ZpDC2t4BCFwlEc/JGxR6ngOocDJojoGHNqb4QylehNRIozdPJJocRd6FsRxent0a/u
	dBwZvG0E17rtqhXbcdmCVCSipuaWr3CKO263hTWMOXrimjLcI3MqA/9sv/RZjJjipbgc=
X-Received: by 2002:a05:600c:3f18:b0:456:c50:1b3 with SMTP id 5b1f17b1804b1-4560c50065emr98445165e9.29.1752573388313;
        Tue, 15 Jul 2025 02:56:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmicJJzD1wNt94gADTgMM4AQf4F351QVMOQmuSesstilvzLQXa7U5J7AiW3EOW3ayr91rNng==
X-Received: by 2002:a05:600c:3f18:b0:456:c50:1b3 with SMTP id 5b1f17b1804b1-4560c50065emr98444765e9.29.1752573387783;
        Tue, 15 Jul 2025 02:56:27 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4900:2c24:4e20:1f21:9fbd? (p200300d82f2849002c244e201f219fbd.dip0.t-ipconnect.de. [2003:d8:2f28:4900:2c24:4e20:1f21:9fbd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4561b176f87sm55096675e9.35.2025.07.15.02.56.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 02:56:27 -0700 (PDT)
Message-ID: <adf4fba6-f246-4bf5-ba90-ac1357024dac@redhat.com>
Date: Tue, 15 Jul 2025 11:56:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] khugepaged: Optimize collapse_pte_mapped_thp() for
 large folios by PTE batching
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 baohua@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250625055806.82645-1-dev.jain@arm.com>
 <20250625055806.82645-3-dev.jain@arm.com>
 <71350398-b5d8-45b9-b05c-d2b63030f766@lucifer.local>
 <8109236a-9288-4935-8321-dbff361dc529@arm.com>
 <e9b027c8-9db9-4950-8d25-9984ae0a4de1@lucifer.local>
 <d58dc96a-4082-4a24-84cf-fed27b85763a@arm.com>
 <b82b860c-8ad9-409a-8668-e3db11b9f7a5@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <b82b860c-8ad9-409a-8668-e3db11b9f7a5@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.07.25 11:43, Lorenzo Stoakes wrote:
> On Tue, Jul 15, 2025 at 12:04:56PM +0530, Dev Jain wrote:
>>
>> On 26/06/25 10:17 am, Lorenzo Stoakes wrote:
>>> On Thu, Jun 26, 2025 at 09:18:47AM +0530, Dev Jain wrote:
>>>> On 25/06/25 6:41 pm, Lorenzo Stoakes wrote:
>>>>> On Wed, Jun 25, 2025 at 11:28:05AM +0530, Dev Jain wrote:
>>>>>> Use PTE batching to optimize collapse_pte_mapped_thp().
>>>>>>
>>>>>> On arm64, suppose khugepaged is scanning a pte-mapped 2MB THP for collapse.
>>>>>> Then, calling ptep_clear() for every pte will cause a TLB flush for every
>>>>>> contpte block. Instead, clear_full_ptes() does a
>>>>>> contpte_try_unfold_partial() which will flush the TLB only for the (if any)
>>>>>> starting and ending contpte block, if they partially overlap with the range
>>>>>> khugepaged is looking at.
>>>>>>
>>>>>> For all arches, there should be a benefit due to batching atomic operations
>>>>>> on mapcounts due to folio_remove_rmap_ptes().
>>>>>>
>>>>>> Note that we do not need to make a change to the check
>>>>>> "if (folio_page(folio, i) != page)"; if i'th page of the folio is equal
>>>>>> to the first page of our batch, then i + 1, .... i + nr_batch_ptes - 1
>>>>>> pages of the folio will be equal to the corresponding pages of our
>>>>>> batch mapping consecutive pages.
>>>>>>
>>>>>> No issues were observed with mm-selftests.
>>>>>>
>>>>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>>>>> ---
>>>>>>     mm/khugepaged.c | 38 ++++++++++++++++++++++++++------------
>>>>>>     1 file changed, 26 insertions(+), 12 deletions(-)
>>>>>>
>>>>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>>>>> index 3944b112d452..4c8d33abfbd8 100644
>>>>>> --- a/mm/khugepaged.c
>>>>>> +++ b/mm/khugepaged.c
>>>>>> @@ -1499,15 +1499,16 @@ static int set_huge_pmd(struct vm_area_struct *vma, unsigned long addr,
>>>>>>     int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>>>>>>     			    bool install_pmd)
>>>>>>     {
>>>>>> +	int nr_mapped_ptes = 0, nr_batch_ptes, result = SCAN_FAIL;
>>>>>>     	struct mmu_notifier_range range;
>>>>>>     	bool notified = false;
>>>>>>     	unsigned long haddr = addr & HPAGE_PMD_MASK;
>>>>>> +	unsigned long end = haddr + HPAGE_PMD_SIZE;
>>>>>>     	struct vm_area_struct *vma = vma_lookup(mm, haddr);
>>>>>>     	struct folio *folio;
>>>>>>     	pte_t *start_pte, *pte;
>>>>>>     	pmd_t *pmd, pgt_pmd;
>>>>>>     	spinlock_t *pml = NULL, *ptl;
>>>>>> -	int nr_ptes = 0, result = SCAN_FAIL;
>>>>>>     	int i;
>>>>>>
>>>>>>     	mmap_assert_locked(mm);
>>>>>> @@ -1621,11 +1622,17 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>>>>>>     		goto abort;
>>>>>>
>>>>>>     	/* step 2: clear page table and adjust rmap */
>>>>>> -	for (i = 0, addr = haddr, pte = start_pte;
>>>>>> -	     i < HPAGE_PMD_NR; i++, addr += PAGE_SIZE, pte++) {
>>>>>> +	for (i = 0, addr = haddr, pte = start_pte; i < HPAGE_PMD_NR;
>>>>>> +	     i += nr_batch_ptes, addr += nr_batch_ptes * PAGE_SIZE,
>>>>>> +	     pte += nr_batch_ptes) {
>>>>>> +		const fpb_t flags = FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
>>>>>> +		int max_nr_batch_ptes = (end - addr) >> PAGE_SHIFT;
>>>>>> +		struct folio *mapped_folio;
>>>>>>     		struct page *page;
>>>>>>     		pte_t ptent = ptep_get(pte);
>>>>>>
>>>>>> +		nr_batch_ptes = 1;
>>>>>> +
>>>>>>     		if (pte_none(ptent))
>>>>>>     			continue;
>>>>>>     		/*
>>>>>> @@ -1639,26 +1646,33 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>>>>>>     			goto abort;
>>>>>>     		}
>>>>>>     		page = vm_normal_page(vma, addr, ptent);
>>>>>> +		mapped_folio = page_folio(page);
>>>>>> +
>>>>>>     		if (folio_page(folio, i) != page)
>>>>>>     			goto abort;
>>>>> Isn't this asserting that folio == mapped_folio here? We're saying page is the
>>>>> ith page of folio, so why do we need to look up mapped_folio?
>>>> We need to check for all PTEs whether they map the right page or not. This may
>>>> get disturbed due to mremap and stuff.
>>> Right but I'm saying mapped_folio == folio right? You're literally asserting it
>>> here? So there's no need to assign mapped_folio at all, just reference folio no?
>>>
>>>>>> +		mapped_folio = page_folio(page);
>>>>> You're assigning this twice.
>>>> Forgot to remove, thanks.
>>>>
>>>>>> +		nr_batch_ptes = folio_pte_batch(mapped_folio, addr, pte, ptent,
>>>>>> +						max_nr_batch_ptes, flags,
>>>>>> +						NULL, NULL, NULL);
>>>>>> +
>>>>>>     		/*
>>>>>>     		 * Must clear entry, or a racing truncate may re-remove it.
>>>>>>     		 * TLB flush can be left until pmdp_collapse_flush() does it.
>>>>>>     		 * PTE dirty? Shmem page is already dirty; file is read-only.
>>>>>>     		 */
>>>>>> -		ptep_clear(mm, addr, pte);
>>>>>> -		folio_remove_rmap_pte(folio, page, vma);
>>>>>> -		nr_ptes++;
>>>>>> +		clear_full_ptes(mm, addr, pte, nr_batch_ptes, /* full = */ false);
>>>>>> +		folio_remove_rmap_ptes(folio, page, nr_batch_ptes, vma);
>>>>>> +		nr_mapped_ptes += nr_batch_ptes;
>>>>>>     	}
>>>>>>
>>>>>>     	if (!pml)
>>>>>>     		spin_unlock(ptl);
>>>>>>
>>>>>>     	/* step 3: set proper refcount and mm_counters. */
>>>>>> -	if (nr_ptes) {
>>>>>> -		folio_ref_sub(folio, nr_ptes);
>>>>>> -		add_mm_counter(mm, mm_counter_file(folio), -nr_ptes);
>>>>>> +	if (nr_mapped_ptes) {
>>>>>> +		folio_ref_sub(folio, nr_mapped_ptes);
>>>>>> +		add_mm_counter(mm, mm_counter_file(folio), -nr_mapped_ptes);
>>>>>>     	}
>>>>>>
>>>>>>     	/* step 4: remove empty page table */
>>>>>> @@ -1691,10 +1705,10 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>>>>>>     			: SCAN_SUCCEED;
>>>>>>     	goto drop_folio;
>>>>>>     abort:
>>>>>> -	if (nr_ptes) {
>>>>>> +	if (nr_mapped_ptes) {
>>>>> I know it's ironic coming from me :P but I'm not sure why we need to churn this
>>>>> up by renaming?
>>>> Because nr_ptes is an existing variable and I need a new variable to make
>>>> the jump at the end of the PTE batch.
>>> I thought you eliminated nr_ptes as a variable here? Where else is it used?
>>>
>>> Oh how this code needs refactoring...
>>
>> If we retain nr_ptes, then the two variables will be nr_ptes and nr_mapped_ptes,
>> which is confusing since the former is plain and the latter has a _mapped_ thingy
>> in it, so instead now we call them nr_batch_ptes and nr_mapped_ptes.
>>
> 
> Sigh, this is still awful. But probably just existing awfulness. This whole
> thing needs a tent thrown over it and fumigation... but again not your fault :)
> 
> I mean fine, this is fine then.

Probably best to be pragmatic here: as long as the educated reader 
understands the code, all good. I hope I'll never have to explain it to 
my daughters.

I know, I'm a perfectionist myself ;)

-- 
Cheers,

David / dhildenb



Return-Path: <linux-kernel+bounces-894491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDBCC4B1D8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 03:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA137189873A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 01:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6780930F7F1;
	Tue, 11 Nov 2025 01:52:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D040C4C97
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762825919; cv=none; b=bnFyx1QSCWGwoCm5sVVlYyV0e5zgfJL8rJfCrlnrSDIdQifDW0I3a2C7Hg2CtCv+EL6R0RAVWVj+fpA7LfrVPaCOPfbGeRx5QTA3XuEVV5qqB35qlEd1s4lRTsx2ts3VfTDX2vk86Mk/zzGyhUUXoeIoB5d2eF2bh+bmBhptrhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762825919; c=relaxed/simple;
	bh=X7E2kdzhRVt6Ugun7VkqmJCMLDheAhQq82PvzRwRQPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DAIB+YR6zUatDh+SsE6BeX9aYw+1mLfq3R0oQj+dUAjUAj6ZLalpzxgXcyHxfNHN7VTPq3dkocSKqB773jef0TxpjzU4E74ccbvk0En2hVis8cCHWCnVWK43MM3H/3eXBJnPcnlaUhzfP89J/CsbSgr15dZXES2i9P9aSVv0xAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1952E2F;
	Mon, 10 Nov 2025 17:51:48 -0800 (PST)
Received: from [10.163.74.35] (unknown [10.163.74.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0AB23F66E;
	Mon, 10 Nov 2025 17:51:51 -0800 (PST)
Message-ID: <73cd2390-f4c9-4b65-95da-a3b20994f958@arm.com>
Date: Tue, 11 Nov 2025 07:21:48 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/ptdesc: Derive from the compound head in page_ptdesc()
To: "David Hildenbrand (Red Hat)" <davidhildenbrandkernel@gmail.com>,
 linux-mm@kvack.org
Cc: vishal.moola@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org
References: <20251110063725.3118037-1-anshuman.khandual@arm.com>
 <048f6173-f538-46eb-b0dd-70f1aaa79562@gmail.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <048f6173-f538-46eb-b0dd-70f1aaa79562@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/11/25 2:23 PM, David Hildenbrand (Red Hat) wrote:
> On 10.11.25 07:37, Anshuman Khandual wrote:
>> struct ptdesc (including all relevant helpers) support multi order compound
>> pages. But page_ptdesc() coverts given page into its own ptdesc rather than
>> deriving from its compound head as would have been expected otherwise. Just
>> change the macro to fetch the struct ptdesc from the compound head instead,
>> so that the same struct ptdesc is reached from all tail pages.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Mike Rapoport <rppt@kernel.org>
>> Cc: Suren Baghdasaryan <surenb@google.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> This applies on v6.18-rc5
>>
>> Found via code inspection. Apparently struct ptdesc could represent a page
>> table page which is multi order looking into helpers as ptdesc_nr_pages(),
>> __pagetable_ctor/dtor() and pagetable_free() etc. Am I missing something ?
>>
>>   include/linux/mm_types.h | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>> index 90e5790c318f..f7107bc55d1e 100644
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -604,9 +604,9 @@ static_assert(sizeof(struct ptdesc) <= sizeof(struct page));
>>       const struct ptdesc *:        (const struct folio *)(pt),    \
>>       struct ptdesc *:        (struct folio *)(pt)))
>>   -#define page_ptdesc(p)            (_Generic((p),            \
>> -    const struct page *:        (const struct ptdesc *)(p),    \
>> -    struct page *:            (struct ptdesc *)(p)))
>> +#define page_ptdesc(p)            (_Generic((p),                    \
>> +    const struct page *:        (const struct ptdesc *)_compound_head(p),    \
>> +    struct page *:            (struct ptdesc *)_compound_head(p)))
> 
> Well, this adds overhead :)
> 
> The real question is when we would be converting from a tail page to a ptdesc.
> 
> Take a look at pmd_ptdesc()->pmd_pgtable_page() where we avoid looking up a tail page in the first place.
> 

Agreed - it does avoid looking into the tail pages. Currently there
are no instances where tail pages are converted into struct ptdesc.
But on its own page_ptdesc() does not look right and would not work
when applied on a tail page.

static inline struct page *pmd_pgtable_page(pmd_t *pmd)
{
        unsigned long mask = ~(PTRS_PER_PMD * sizeof(pmd_t) - 1);
        return virt_to_page((void *)((unsigned long) pmd & mask));
}

static inline struct ptdesc *pmd_ptdesc(pmd_t *pmd)
{
        return page_ptdesc(pmd_pgtable_page(pmd));
}


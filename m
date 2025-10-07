Return-Path: <linux-kernel+bounces-843874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA43BC0769
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 09:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E7D8934CC0D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 07:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F24E22D4DC;
	Tue,  7 Oct 2025 07:11:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2E22253EE
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 07:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759821091; cv=none; b=QPyGQzrgeac1gotPDfXWVrEW2CIjATirFdnNJ5LQuR/shkD3SbmlqOmAhMBLm92A74LVYrlgnf5h3/piXonaVukB74MGagbvKscEKJHi8Wm1OcgHVW0MDkBg5/rTiiauMtjVOcQo6gzCedhzGVJ0KxifjAUAZgoyClFtnpynbh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759821091; c=relaxed/simple;
	bh=LadauiYqFa0FVLNi6UteWLgji4+EmhJAL0p4QNPxgCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KtSSyy96ImAPf7uvWDbQiIlGxpusNdBPKRvOlFYBhxOnyMnDJmYRRXDAptLbaT6tpCy6HpkxO6xIOahDMCMvruDbk3vFRsN8wCquxIvxdWP8+ElTwrlcJY8fWlhl6hE2UxFsdEtiHk0isszcraagA760JvyhVPnXclmxHop4rYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A79914BF;
	Tue,  7 Oct 2025 00:11:20 -0700 (PDT)
Received: from [10.163.65.24] (unknown [10.163.65.24])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76B623F66E;
	Tue,  7 Oct 2025 00:11:26 -0700 (PDT)
Message-ID: <584fea72-e564-4cf6-9435-ce4b03f2fd65@arm.com>
Date: Tue, 7 Oct 2025 12:41:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Replace READ_ONCE() with standard page table
 accessors
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
References: <20251007063100.2396936-1-anshuman.khandual@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20251007063100.2396936-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 07/10/25 12:01 pm, Anshuman Khandual wrote:
> Replace all READ_ONCE() with a standard page table accessors i.e pxdp_get()
> that defaults into READ_ONCE() in cases where platform does not override.

Does any platform override into something else currently? The way you write
the description implies that.

>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>   mm/gup.c            | 10 +++++-----
>   mm/hmm.c            |  2 +-
>   mm/memory.c         |  4 ++--
>   mm/mprotect.c       |  2 +-
>   mm/sparse-vmemmap.c |  2 +-
>   mm/vmscan.c         |  2 +-
>   6 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/mm/gup.c b/mm/gup.c
> index 0bc4d140fc07..37e2af5ed96d 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -964,7 +964,7 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
>   	struct mm_struct *mm = vma->vm_mm;
>   
>   	pudp = pud_offset(p4dp, address);
> -	pud = READ_ONCE(*pudp);
> +	pud = pudp_get(pudp);
>   	if (!pud_present(pud))
>   		return no_page_table(vma, flags, address);
>   	if (pud_leaf(pud)) {
> @@ -989,7 +989,7 @@ static struct page *follow_p4d_mask(struct vm_area_struct *vma,
>   	p4d_t *p4dp, p4d;
>   
>   	p4dp = p4d_offset(pgdp, address);
> -	p4d = READ_ONCE(*p4dp);
> +	p4d = p4dp_get(p4dp);
>   	BUILD_BUG_ON(p4d_leaf(p4d));
>   
>   	if (!p4d_present(p4d) || p4d_bad(p4d))
> @@ -3080,7 +3080,7 @@ static int gup_fast_pud_range(p4d_t *p4dp, p4d_t p4d, unsigned long addr,
>   
>   	pudp = pud_offset_lockless(p4dp, p4d, addr);
>   	do {
> -		pud_t pud = READ_ONCE(*pudp);
> +		pud_t pud = pudp_get(pudp);
>   
>   		next = pud_addr_end(addr, end);
>   		if (unlikely(!pud_present(pud)))
> @@ -3106,7 +3106,7 @@ static int gup_fast_p4d_range(pgd_t *pgdp, pgd_t pgd, unsigned long addr,
>   
>   	p4dp = p4d_offset_lockless(pgdp, pgd, addr);
>   	do {
> -		p4d_t p4d = READ_ONCE(*p4dp);
> +		p4d_t p4d = p4dp_get(p4dp);
>   
>   		next = p4d_addr_end(addr, end);
>   		if (!p4d_present(p4d))
> @@ -3128,7 +3128,7 @@ static void gup_fast_pgd_range(unsigned long addr, unsigned long end,
>   
>   	pgdp = pgd_offset(current->mm, addr);
>   	do {
> -		pgd_t pgd = READ_ONCE(*pgdp);
> +		pgd_t pgd = pgdp_get(pgdp);
>   
>   		next = pgd_addr_end(addr, end);
>   		if (pgd_none(pgd))
> diff --git a/mm/hmm.c b/mm/hmm.c
> index d545e2494994..126c3f42e525 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -431,7 +431,7 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
>   	/* Normally we don't want to split the huge page */
>   	walk->action = ACTION_CONTINUE;
>   
> -	pud = READ_ONCE(*pudp);
> +	pud = pudp_get(pudp);
>   	if (!pud_present(pud)) {
>   		spin_unlock(ptl);
>   		return hmm_vma_walk_hole(start, end, -1, walk);
> diff --git a/mm/memory.c b/mm/memory.c
> index 0ba4f6b71847..50f841ee6e84 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -6549,12 +6549,12 @@ int follow_pfnmap_start(struct follow_pfnmap_args *args)
>   		goto out;
>   
>   	p4dp = p4d_offset(pgdp, address);
> -	p4d = READ_ONCE(*p4dp);
> +	p4d = p4dp_get(p4dp);
>   	if (p4d_none(p4d) || unlikely(p4d_bad(p4d)))
>   		goto out;
>   
>   	pudp = pud_offset(p4dp, address);
> -	pud = READ_ONCE(*pudp);
> +	pud = pudp_get(pudp);
>   	if (pud_none(pud))
>   		goto out;
>   	if (pud_leaf(pud)) {
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 113b48985834..988c366137d5 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -599,7 +599,7 @@ static inline long change_pud_range(struct mmu_gather *tlb,
>   			break;
>   		}
>   
> -		pud = READ_ONCE(*pudp);
> +		pud = pudp_get(pudp);
>   		if (pud_none(pud))
>   			continue;
>   
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index dbd8daccade2..37522d6cb398 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -439,7 +439,7 @@ int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned long end,
>   			return -ENOMEM;
>   
>   		pmd = pmd_offset(pud, addr);
> -		if (pmd_none(READ_ONCE(*pmd))) {
> +		if (pmd_none(pmdp_get(pmd))) {

I believe sparse-vmemmap is only for 64 bit arches so we are safe.

>   			void *p;
>   
>   			p = vmemmap_alloc_block_buf(PMD_SIZE, node, altmap);
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 674999999cd0..14c2722b955b 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3772,7 +3772,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned long start, unsigned long end,
>   	pud = pud_offset(p4d, start & P4D_MASK);
>   restart:
>   	for (i = pud_index(start), addr = start; addr != end; i++, addr = next) {
> -		pud_t val = READ_ONCE(pud[i]);
> +		pud_t val = pudp_get(pud + i);
>   
>   		next = pud_addr_end(addr, end);
>   


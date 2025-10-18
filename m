Return-Path: <linux-kernel+bounces-859061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EC9BEC966
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 09:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B4783AB5DE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 07:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E072566F7;
	Sat, 18 Oct 2025 07:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=airmail.cc header.i=@airmail.cc header.b="Qc2EbJV9"
Received: from mail.cock.li (mail.cock.li [37.120.193.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BA9354AEB
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 07:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.193.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760772645; cv=none; b=JBycvRao5AVq14x5iqJgsmrXrAG+xPWg7QM3YRJSUJOV9iIYd1wdE7ryPMCZeAL3vTQlxlJKfk/wCxA/F+GcNbZ6NNUAoMKyaAvvJ2XYV4mD16yYbkoZl0Rtzymb87D+A5vDjJlZl5b/iGFQRu1HSSNQKm5EjnQorRwVVAF0jic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760772645; c=relaxed/simple;
	bh=Si77P5mHpiO9js4b1P3EZOVmgTuGtQ+9mtNz0P4X8RU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GOOsssCgNs4GiQBi9LEOjTFeP5dM9aFO06D41Hbza7d4SBoT4KaeUUOKXHskaBSozGlpb4xUiik8zgNYvrlbweDjx8JAA30KkpUNNp5RPyB2L7RszvRu/DB+VCHmNdqe3fsHtCK7+9f+niaQDqMXIBjYue1s7Lv8AagnNxGhpbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airmail.cc; spf=pass smtp.mailfrom=airmail.cc; dkim=pass (2048-bit key) header.d=airmail.cc header.i=@airmail.cc header.b=Qc2EbJV9; arc=none smtp.client-ip=37.120.193.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airmail.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airmail.cc
Message-ID: <6e9ca60a-648c-45e9-9580-27f45a4f2a4d@airmail.cc>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=airmail.cc; s=mail;
	t=1760772629; bh=Si77P5mHpiO9js4b1P3EZOVmgTuGtQ+9mtNz0P4X8RU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Qc2EbJV9NKGPkRaJ/XnMJ2xwN79WVgkoXdME6rWFb4aCRLtAUGT65Mo4RmZQiBouP
	 UhsOWvI7hFSp4SknVD336lo7E8sTBDwsK8i7vPTisndLM/PX2kQfs3uTsq6J3LtfEG
	 Sofg5lUwZaIT1LbHUKXhuWy6jYJZUAsuNUWZ6AwFZqKwNqRrMGDBgt8hB+Zcc5PP3U
	 7B1R33hxXn5Lr8V8oPXo+6+MI+7J8rMwfXbrxgc12QlzTmGC+iJ6rHffdFj8MC20i5
	 4sQ70buzieeAo1/cF6c1jHjnO136O+1gFCRzcMNsIr6X8yRWKuloOWI/d5rm6ci/I1
	 09qJnw1vv0L6A==
Date: Sat, 18 Oct 2025 07:30:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] ksm: use range-walk function to jump over holes in
 scan_get_next_rmap_item
To: David Hildenbrand <david@redhat.com>,
 Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20251016012236.4189-1-pedrodemargomes@gmail.com>
 <844af749-374e-49b3-91f0-a72e951981c8@redhat.com>
From: craftfever <craftfever@airmail.cc>
In-Reply-To: <844af749-374e-49b3-91f0-a72e951981c8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



David Hildenbrand wrote:
> On 16.10.25 03:22, Pedro Demarchi Gomes wrote:
>> Currently, scan_get_next_rmap_item() walks every page address in a VMA
>> to locate mergeable pages. This becomes highly inefficient when scanning
>> large virtual memory areas that contain mostly unmapped regions.
>>
>> This patch replaces the per-address lookup with a range walk using
>> walk_page_range(). The range walker allows KSM to skip over entire
>> unmapped holes in a VMA, avoiding unnecessary lookups.
>> This problem was previously discussed in [1].
>>
>> [1] https://lore.kernel.org/linux- 
>> mm/423de7a3-1c62-4e72-8e79-19a6413e420c@redhat.com/
>>
>> ---
> 
> This patch does to much in a single patch which makes it
> rather hard to review.
> 
> As a first step, we should focus on leaving most of
> scan_get_next_rmap_item() alone and only focus on replacing
> folio_walk by walk_page_range_vma().
> 
> Follow-up cleanups could try cleaning up scan_get_next_rmap_item()
> -- and boy oh boy, does that function scream for quite some cleanups.
> 
> This is something minimal based on your v3. I applied plenty of more
> cleanups and I wish we could further shrink the pmd_entry function,
> but I have to give up for today (well, it's already tomorrow :) ).
> 
> 
> Briefly tested with ksm selftests and my machine did not burn down my 
> building.
> 
> 
>  From d971b88056fe3fefe50e5d4fa5b359e8c8331b2c Mon Sep 17 00:00:00 2001
> From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
> Date: Wed, 15 Oct 2025 22:22:36 -0300
> Subject: [PATCH] ksm: use range-walk function to jump over holes in
>   scan_get_next_rmap_item
> 
> Currently, scan_get_next_rmap_item() walks every page address in a VMA
> to locate mergeable pages. This becomes highly inefficient when scanning
> large virtual memory areas that contain mostly unmapped regions.
> 
> This patch replaces the per-address lookup with a range walk using
> walk_page_range_vma(). The range walker allows KSM to skip over entire
> unmapped holes in a VMA, avoiding unnecessary lookups.
> This problem was previously discussed in [1].
> 
> [1] https://lore.kernel.org/linux- 
> mm/423de7a3-1c62-4e72-8e79-19a6413e420c@redhat.com/
> 
> Reported-by: craftfever <craftfever@airmail.cc>
> Closes: https://lkml.kernel.org/ 
> r/020cf8de6e773bb78ba7614ef250129f11a63781@murena.io
> Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
> Co-developed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   mm/ksm.c | 116 ++++++++++++++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 103 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 3aed0478fdcef..8bd2b78c4f869 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -2455,6 +2455,94 @@ static bool should_skip_rmap_item(struct folio 
> *folio,
>       return true;
>   }
> 
> +struct ksm_next_page_arg {
> +    struct folio *folio;
> +    struct page *page;
> +    unsigned long addr;
> +};
> +
> +static int ksm_next_page_pmd_entry(pmd_t *pmdp, unsigned long addr, 
> unsigned long end,
> +        struct mm_walk *walk)
> +{
> +    struct ksm_next_page_arg *private = walk->private;
> +    struct vm_area_struct *vma = walk->vma;
> +    pte_t *start_ptep = NULL, *ptep, pte;
> +    struct mm_struct *mm = walk->mm;
> +    struct folio *folio;
> +    struct page *page;
> +    spinlock_t *ptl;
> +    pmd_t pmd;
> +
> +    if (ksm_test_exit(mm))
> +        return 0;
> +    cond_resched();
> +
> +    pmd = pmdp_get_lockless(pmdp);
> +    if (!pmd_present(pmd))
> +        return 0;
> +
> +    if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && pmd_leaf(pmd)) {
> +        ptl = pmd_lock(mm, pmdp);
> +        pmd = pmdp_get(pmdp);
> +
> +        if (!pmd_present(pmd)) {
> +            goto not_found_unlock;
> +        } else if (pmd_leaf(pmd)) {
> +            page = vm_normal_page_pmd(vma, addr, pmd);
> +            if (!page)
> +                goto not_found_unlock;
> +            folio = page_folio(page);
> +
> +            if (folio_is_zone_device(folio) || !folio_test_anon(folio))
> +                goto not_found_unlock;
> +
> +            page += ((addr & (PMD_SIZE - 1)) >> PAGE_SHIFT);
> +            goto found_unlock;
> +        }
> +        spin_unlock(ptl);
> +    }
> +
> +    start_ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
> +    if (!start_ptep)
> +        return 0;
> +
> +    for (ptep = start_ptep; addr < end; ptep++, addr += PAGE_SIZE) {
> +        pte = ptep_get(ptep);
> +
> +        if (!pte_present(pte))
> +            continue;
> +
> +        page = vm_normal_page(vma, addr, pte);
> +        if (!page)
> +            continue;
> +        folio = page_folio(page);
> +
> +        if (folio_is_zone_device(folio) || !folio_test_anon(folio))
> +            continue;
> +        goto found_unlock;
> +    }
> +
> +not_found_unlock:
> +    spin_unlock(ptl);
> +    if (start_ptep)
> +        pte_unmap(start_ptep);
> +    return 0;
> +found_unlock:
> +    folio_get(folio);
> +    spin_unlock(ptl);
> +    if (start_ptep)
> +        pte_unmap(start_ptep);
> +    private->page = page;
> +    private->folio = folio;
> +    private->addr = addr;
> +    return 1;
> +}
> +
> +static struct mm_walk_ops ksm_next_page_ops = {
> +    .pmd_entry = ksm_next_page_pmd_entry,
> +    .walk_lock = PGWALK_RDLOCK,
> +};
> +
>   static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>   {
>       struct mm_struct *mm;
> @@ -2542,21 +2630,23 @@ static struct ksm_rmap_item 
> *scan_get_next_rmap_item(struct page **page)
>               ksm_scan.address = vma->vm_end;
> 
>           while (ksm_scan.address < vma->vm_end) {
> +            struct ksm_next_page_arg ksm_next_page_arg;
>               struct page *tmp_page = NULL;
> -            struct folio_walk fw;
>               struct folio *folio;
> -
> -            if (ksm_test_exit(mm))
> -                break;
> -
> -            folio = folio_walk_start(&fw, vma, ksm_scan.address, 0);
> -            if (folio) {
> -                if (!folio_is_zone_device(folio) &&
> -                     folio_test_anon(folio)) {
> -                    folio_get(folio);
> -                    tmp_page = fw.page;
> -                }
> -                folio_walk_end(&fw, vma);
> +            int found;
> +
> +            found = walk_page_range_vma(vma, ksm_scan.address,
> +                            vma->vm_end,
> +                            &ksm_next_page_ops,
> +                            &ksm_next_page_arg);
> +
> +            if (found > 0) {
> +                folio = ksm_next_page_arg.folio;
> +                tmp_page = ksm_next_page_arg.page;
> +                ksm_scan.address = ksm_next_page_arg.addr;
> +            } else {
> +                VM_WARN_ON_ONCE(found < 0);
> +                ksm_scan.address = vma->vm_end - PAGE_SIZE;
>               }
> 
>               if (tmp_page) {


%)
Guys, I'm so sorry, I"m little confused, can you lease tell further by 
e-mail, when patch or couple of patches will be done, so it could 
properly tested, 'cause I'm little lost in this progress, is it ready or 
not, thank you)


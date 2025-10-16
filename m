Return-Path: <linux-kernel+bounces-856854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 822C5BE5403
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 21:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7A0E188A746
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727392DA775;
	Thu, 16 Oct 2025 19:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=airmail.cc header.i=@airmail.cc header.b="RBrTMHrn"
Received: from mail.cock.li (mail.cock.li [37.120.193.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4CB1917CD
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 19:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.193.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760643371; cv=none; b=ZfPzXntgBvpaffYc5Ig7SF8vbLQ9sjIDv6Z/6DRPdP45HuEFdizg5aJMMQTd9gImKJ3ZBC7TyJvc2nP/c5l0XhW2Yn2QxtZwgkt/KoISU68z1foZ26Tep3BhuDDPkuMiqVmspEVcKbTcWFlG5zZmi3b49sGoCHWekqDQtQIyK7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760643371; c=relaxed/simple;
	bh=ZQCKlrlqu3Uz3yk3lAwJeWok/9yVjsKtrSFW6jl8trI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W+nfCVwczc45jDXKTVXeq2bv24z/g+OHsZrIYPFcjhLxJJtnZxfeQjd6hAQqQTVR+m2ujZMHuFA3BaTCH1e69bbcI/q6oT0o/MbsE5w7CIv6IL+qvCVpOZixgv0hud9VmFAG+zRmvCtPijBu0/JKw1tuFDaAx4JmDFDiGNiEJIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airmail.cc; spf=pass smtp.mailfrom=airmail.cc; dkim=pass (2048-bit key) header.d=airmail.cc header.i=@airmail.cc header.b=RBrTMHrn; arc=none smtp.client-ip=37.120.193.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airmail.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airmail.cc
Message-ID: <41daec8b-9be0-4f71-83a5-2fe5c5c4bff7@airmail.cc>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=airmail.cc; s=mail;
	t=1760643352; bh=ZQCKlrlqu3Uz3yk3lAwJeWok/9yVjsKtrSFW6jl8trI=;
	h=Date:Subject:To:Cc:References:From:Reply-To:In-Reply-To:From;
	b=RBrTMHrnW0PFGlgMBKzFSHjxZKbX2cPUytY5vRSr5ugfyNA2sjCR6QuBeVFPaz/CK
	 v+4ZWOxYRWmghLqN/5w3RumZ2ZO7zE9xSPWkCfhgNmoFLi4+yWmli+E5WqKbzmMlMA
	 VdCIV7wrM/XT/SMWNrRaHuA4b5b9O2+pVzi3kEuMp1EVzzpVWeaIAWORCzfwZmdDou
	 rxxaQ+DG++Xu8zNwmQgIpOQrA+SwlTXRIYxe5jFvgX73v4U7NH3sHa711fSSzXQWnk
	 4tWJ15dGDqgU/AR87bfjqJ+x0stQbLu/XH6V8BIfkKgTUsT61j6nYmDQl+MnQbIUA/
	 Lq/nkn5sEK8NQ==
Date: Thu, 16 Oct 2025 19:35:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] ksm: use range-walk function to jump over holes in
 scan_get_next_rmap_item
To: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20251016012236.4189-1-pedrodemargomes@gmail.com>
From: craftfever <craftfever@airmail.cc>
Reply-To: 20251016012236.4189-1-pedrodemargomes@gmail.com
In-Reply-To: <20251016012236.4189-1-pedrodemargomes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



Pedro Demarchi Gomes wrote:
> Currently, scan_get_next_rmap_item() walks every page address in a VMA
> to locate mergeable pages. This becomes highly inefficient when scanning
> large virtual memory areas that contain mostly unmapped regions.
> 
> This patch replaces the per-address lookup with a range walk using
> walk_page_range(). The range walker allows KSM to skip over entire
> unmapped holes in a VMA, avoiding unnecessary lookups.
> This problem was previously discussed in [1].
> 
> [1] https://lore.kernel.org/linux-mm/423de7a3-1c62-4e72-8e79-19a6413e420c@redhat.com/
> 
> ---
> 
> v3:
>    - Treat THPs in ksm_pmd_entry
>    - Update ksm_scan.address outside walk_page_range
>    - Change goto to while loop
> 
> v2: https://lore.kernel.org/all/20251014151126.87589-1-pedrodemargomes@gmail.com/
>    - Use pmd_entry to walk page range
>    - Use cond_resched inside pmd_entry()
>    - walk_page_range returns page+folio
> 
> v1: https://lore.kernel.org/all/20251014055828.124522-1-pedrodemargomes@gmail.com/
> 
> Reported-by: craftfever <craftfever@airmail.cc>
> Closes: https://lkml.kernel.org/r/020cf8de6e773bb78ba7614ef250129f11a63781@murena.io
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
> ---
>   mm/ksm.c | 185 ++++++++++++++++++++++++++++++++++++++++---------------
>   1 file changed, 135 insertions(+), 50 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 3aed0478fdce..403e4f102f07 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -2455,14 +2455,119 @@ static bool should_skip_rmap_item(struct folio *folio,
>   	return true;
>   }
>   
> +struct ksm_walk_private {
> +	struct page *page;
> +	struct folio *folio;
> +	struct vm_area_struct *vma;
> +	unsigned long address;
> +};
> +
> +static int ksm_walk_test(unsigned long addr, unsigned long next, struct mm_walk *walk)
> +{
> +	struct vm_area_struct *vma = walk->vma;
> +	struct ksm_walk_private *private;
> +
> +	if (!(vma->vm_flags & VM_MERGEABLE))
> +		return 1;
> +
> +	private = (struct ksm_walk_private *) walk->private;
> +	private->address = vma->vm_end;
> +
> +	if (!vma->anon_vma)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static int ksm_pmd_entry(pmd_t *pmd, unsigned long addr,
> +			    unsigned long end, struct mm_walk *walk)
> +{
> +	struct mm_struct *mm = walk->mm;
> +	struct vm_area_struct *vma = walk->vma;
> +	struct ksm_walk_private *private = (struct ksm_walk_private *) walk->private;
> +	struct folio *folio;
> +	pte_t *start_pte, *pte, ptent;
> +	pmd_t pmde;
> +	struct page *page;
> +	spinlock_t *ptl;
> +	int ret = 0;
> +
> +	if (ksm_test_exit(mm))
> +		return 1;
> +
> +	ptl = pmd_lock(mm, pmd);
> +	pmde = pmdp_get(pmd);
> +
> +	if (!pmd_present(pmde))
> +		goto pmd_out;
> +
> +	if (!pmd_trans_huge(pmde))
> +		goto pte_table;
> +
> +	page = vm_normal_page_pmd(vma, addr, pmde);
> +
> +	if (!page)
> +		goto pmd_out;
> +
> +	folio = page_folio(page);
> +	if (folio_is_zone_device(folio) || !folio_test_anon(folio))
> +		goto pmd_out;
> +
> +	ret = 1;
> +	folio_get(folio);
> +	private->page = page + ((addr & (PMD_SIZE - 1)) >> PAGE_SHIFT);
> +	private->folio = folio;
> +	private->vma = vma;
> +	private->address = addr;
> +pmd_out:
> +	spin_unlock(ptl);
> +	return ret;
> +
> +pte_table:
> +	spin_unlock(ptl);
> +
> +	start_pte = pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
> +	if (!start_pte)
> +		return 0;
> +
> +	for (; addr < end; pte++, addr += PAGE_SIZE) {
> +		ptent = ptep_get(pte);
> +		page = vm_normal_page(vma, addr, ptent);
> +
> +		if (!page)
> +			continue;
> +
> +		folio = page_folio(page);
> +		if (folio_is_zone_device(folio) || !folio_test_anon(folio))
> +			continue;
> +
> +		ret = 1;
> +		folio_get(folio);
> +		private->page = page;
> +		private->folio = folio;
> +		private->vma = vma;
> +		private->address = addr;
> +		break;
> +	}
> +	pte_unmap_unlock(start_pte, ptl);
> +
> +	cond_resched();
> +	return ret;
> +}
> +
> +struct mm_walk_ops walk_ops = {
> +	.pmd_entry = ksm_pmd_entry,
> +	.test_walk = ksm_walk_test,
> +	.walk_lock = PGWALK_RDLOCK,
> +};
> +
>   static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>   {
>   	struct mm_struct *mm;
>   	struct ksm_mm_slot *mm_slot;
>   	struct mm_slot *slot;
> -	struct vm_area_struct *vma;
>   	struct ksm_rmap_item *rmap_item;
> -	struct vma_iterator vmi;
> +	struct ksm_walk_private walk_private;
>   	int nid;
>   
>   	if (list_empty(&ksm_mm_head.slot.mm_node))
> @@ -2527,64 +2632,44 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>   
>   	slot = &mm_slot->slot;
>   	mm = slot->mm;
> -	vma_iter_init(&vmi, mm, ksm_scan.address);
>   
>   	mmap_read_lock(mm);
>   	if (ksm_test_exit(mm))
>   		goto no_vmas;
>   
> -	for_each_vma(vmi, vma) {
> -		if (!(vma->vm_flags & VM_MERGEABLE))
> -			continue;
> -		if (ksm_scan.address < vma->vm_start)
> -			ksm_scan.address = vma->vm_start;
> -		if (!vma->anon_vma)
> -			ksm_scan.address = vma->vm_end;
> -
> -		while (ksm_scan.address < vma->vm_end) {
> -			struct page *tmp_page = NULL;
> -			struct folio_walk fw;
> -			struct folio *folio;
> +	while (true) {
> +		struct folio *folio;
>   
> -			if (ksm_test_exit(mm))
> -				break;
> +		walk_private.page = NULL;
> +		walk_private.folio = NULL;
> +		walk_private.address = ksm_scan.address;
>   
> -			folio = folio_walk_start(&fw, vma, ksm_scan.address, 0);
> -			if (folio) {
> -				if (!folio_is_zone_device(folio) &&
> -				     folio_test_anon(folio)) {
> -					folio_get(folio);
> -					tmp_page = fw.page;
> -				}
> -				folio_walk_end(&fw, vma);
> -			}
> +		walk_page_range(mm, ksm_scan.address, -1, &walk_ops, (void *) &walk_private);
> +		ksm_scan.address = walk_private.address;
> +		if (!walk_private.page)
> +			break;
> +
> +		folio = walk_private.folio;
> +		flush_anon_page(walk_private.vma, walk_private.page, ksm_scan.address);
> +		flush_dcache_page(walk_private.page);
> +		rmap_item = get_next_rmap_item(mm_slot,
> +			ksm_scan.rmap_list, ksm_scan.address);
> +		if (rmap_item) {
> +			ksm_scan.rmap_list =
> +					&rmap_item->rmap_list;
>   
> -			if (tmp_page) {
> -				flush_anon_page(vma, tmp_page, ksm_scan.address);
> -				flush_dcache_page(tmp_page);
> -				rmap_item = get_next_rmap_item(mm_slot,
> -					ksm_scan.rmap_list, ksm_scan.address);
> -				if (rmap_item) {
> -					ksm_scan.rmap_list =
> -							&rmap_item->rmap_list;
> -
> -					if (should_skip_rmap_item(folio, rmap_item)) {
> -						folio_put(folio);
> -						goto next_page;
> -					}
> -
> -					ksm_scan.address += PAGE_SIZE;
> -					*page = tmp_page;
> -				} else {
> -					folio_put(folio);
> -				}
> -				mmap_read_unlock(mm);
> -				return rmap_item;
> -			}
> -next_page:
>   			ksm_scan.address += PAGE_SIZE;
> -			cond_resched();
> +			if (should_skip_rmap_item(folio, rmap_item)) {
> +				folio_put(folio);
> +				continue;
> +			}
> +
> +			*page = walk_private.page;
> +		} else {
> +			folio_put(folio);
>   		}
> +		mmap_read_unlock(mm);
> +		return rmap_item;
>   	}
>   
>   	if (ksm_test_exit(mm)) {

I've finally compiled linux-git 6.18rc1 with topic v3 version of patch 
and I'm highly impressed. The footprint of KSM even lighter that it was 
in prior to 6.15 version and system overall seems much more performant 
even without relation to KSM performance. It would be exciting release, 
6.18 definitely deserves be the next LTS version, big thank to you. The 
new algorithm with page-walk and revising VMA working absolutely best.


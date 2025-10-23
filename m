Return-Path: <linux-kernel+bounces-866648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 534E6C00580
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 745871A61998
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E31030AACD;
	Thu, 23 Oct 2025 09:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=airmail.cc header.i=@airmail.cc header.b="GF1TizAJ"
Received: from mail.cock.li (mail.cock.li [37.120.193.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1821F3074A1
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.193.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761212965; cv=none; b=geGOSIfcrDzO6x2uPEjLWBvkPWodfjVHNx0cOuR7yktczwp4pdb5hdJ540rTeSQOk8cCOJG85yV4JuXdvAUTyZDlzTw0PI05om0EqWkZ4lVVl6lRVWNtp4CUEjJCmwTiyPxNmtBgsITU8k6uCHauPAAX9CesyA7OF4l5kW6GACw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761212965; c=relaxed/simple;
	bh=hMyRSn8c2GFUbvLc0Ipm9WT+ur0EAu8JQ6Lx+iRj8eM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XgxdgAoK+ujIhTy3gMLJjCHso5y5lo82YnMSdQVaQ/3WpTRnvXRXRiKB4SYmNa/IqNKTA7F+//ImnjtcZS/bCLSMRER2+hgUBf+6LJEthnItKm7+eZqm8pPsPhJYIzvbx4p0hgt/znuEuc/AK0kyUg4xGtcN2Ipp4O/U6DTeLqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airmail.cc; spf=pass smtp.mailfrom=airmail.cc; dkim=pass (2048-bit key) header.d=airmail.cc header.i=@airmail.cc header.b=GF1TizAJ; arc=none smtp.client-ip=37.120.193.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airmail.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airmail.cc
Message-ID: <d06f4c9d-cf63-4bc4-859d-8256e16dd68d@airmail.cc>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=airmail.cc; s=mail;
	t=1761212958; bh=hMyRSn8c2GFUbvLc0Ipm9WT+ur0EAu8JQ6Lx+iRj8eM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GF1TizAJE4PQCrSQ6fuSut5AN1mHGSNhtD/Rkm0Gj4QelDweEWLbsz+9HMFokopoe
	 Btwmy/djgoR8+WHtE4sKPml9l9ViGMameGouSmcvYDo/b8MREZDl4vuNBNAS547wcI
	 y14IGyxVOrkoLxyg2iqLoQVp0kO6g4TgAKnrtIv3d2di0I/dkgvvDYYM/QhH+HK0SV
	 qyaZFPdAKDx6kwJjYt6zyqS0CcP9sVYF7Nef78ABxkBEpeOvdYh/Y/tlAlimfszioD
	 0qC/Tti5ZI9mrYWrHfjUuN+39LzOHKnMua4izB9nLrPFrb06rX/fto3/uL14UF9J+t
	 2vvqQYjMrSCww==
Date: Thu, 23 Oct 2025 09:49:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5] ksm: use range-walk function to jump over holes in
 scan_get_next_rmap_item
To: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20251023035841.41406-1-pedrodemargomes@gmail.com>
From: craftfever <craftfever@airmail.cc>
In-Reply-To: <20251023035841.41406-1-pedrodemargomes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



Pedro Demarchi Gomes wrote:
> Currently, scan_get_next_rmap_item() walks every page address in a VMA
> to locate mergeable pages. This becomes highly inefficient when scanning
> large virtual memory areas that contain mostly unmapped regions, causing
> ksmd to use large amount of cpu without deduplicating much pages.
> 
> This patch replaces the per-address lookup with a range walk using
> walk_page_range(). The range walker allows KSM to skip over entire
> unmapped holes in a VMA, avoiding unnecessary lookups.
> This problem was previously discussed in [1].
> 
> Consider the following test program which creates a 32 TiB mapping in
> the virtual address space but only populates a single page:
> 
> #include <unistd.h>
> #include <stdio.h>
> #include <sys/mman.h>
> 
> /* 32 TiB */
> const size_t size = 32ul * 1024 * 1024 * 1024 * 1024;
> 
> int main() {
>          char *area = mmap(NULL, size, PROT_READ | PROT_WRITE,
>                            MAP_NORESERVE | MAP_PRIVATE | MAP_ANON, -1, 0);
> 
>          if (area == MAP_FAILED) {
>                  perror("mmap() failed\n");
>                  return -1;
>          }
> 
>          /* Populate a single page such that we get an anon_vma. */
>          *area = 0;
> 
>          /* Enable KSM. */
>          madvise(area, size, MADV_MERGEABLE);
>          pause();
>          return 0;
> }
> 
> $ ./ksm-sparse  &
> $ echo 1 > /sys/kernel/mm/ksm/run
> 
> Without this patch ksmd uses 100% of the cpu for a long time (more then
> 1 hour in my test machine) scanning all the 32 TiB virtual address space
> that contain only one mapped page. This makes ksmd essentially deadlocked
> not able to deduplicate anything of value.
> With this patch ksmd walks only the one mapped page and skips the rest of
> the 32 TiB virtual address space, making the scan fast using little cpu.
> 
> [1] https://lore.kernel.org/linux-mm/423de7a3-1c62-4e72-8e79-19a6413e420c@redhat.com/
> 
> ---
> v5:
>    - Improve patch description
> 
> v4: https://lore.kernel.org/linux-mm/20251022153059.22763-1-pedrodemargomes@gmail.com/
>    - Make minimal changes to replace folio_walk by walk_page_range_vma
> 
> v3: https://lore.kernel.org/all/20251016012236.4189-1-pedrodemargomes@gmail.com/
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
> Co-developed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Fixes: 31dbd01f3143 ("ksm: Kernel SamePage Merging")
> Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
> ---
>   mm/ksm.c | 113 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 104 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 3aed0478fdce..4f672f4f2140 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -2455,6 +2455,95 @@ static bool should_skip_rmap_item(struct folio *folio,
>   	return true;
>   }
>   
> +struct ksm_next_page_arg {
> +	struct folio *folio;
> +	struct page *page;
> +	unsigned long addr;
> +};
> +
> +static int ksm_next_page_pmd_entry(pmd_t *pmdp, unsigned long addr, unsigned long end,
> +		struct mm_walk *walk)
> +{
> +	struct ksm_next_page_arg *private = walk->private;
> +	struct vm_area_struct *vma = walk->vma;
> +	pte_t *start_ptep = NULL, *ptep, pte;
> +	struct mm_struct *mm = walk->mm;
> +	struct folio *folio;
> +	struct page *page;
> +	spinlock_t *ptl;
> +	pmd_t pmd;
> +
> +	if (ksm_test_exit(mm))
> +		return 0;
> +
> +	cond_resched();
> +
> +	pmd = pmdp_get_lockless(pmdp);
> +	if (!pmd_present(pmd))
> +		return 0;
> +
> +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && pmd_leaf(pmd)) {
> +		ptl = pmd_lock(mm, pmdp);
> +		pmd = pmdp_get(pmdp);
> +
> +		if (!pmd_present(pmd)) {
> +			goto not_found_unlock;
> +		} else if (pmd_leaf(pmd)) {
> +			page = vm_normal_page_pmd(vma, addr, pmd);
> +			if (!page)
> +				goto not_found_unlock;
> +			folio = page_folio(page);
> +
> +			if (folio_is_zone_device(folio) || !folio_test_anon(folio))
> +				goto not_found_unlock;
> +
> +			page += ((addr & (PMD_SIZE - 1)) >> PAGE_SHIFT);
> +			goto found_unlock;
> +		}
> +		spin_unlock(ptl);
> +	}
> +
> +	start_ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
> +	if (!start_ptep)
> +		return 0;
> +
> +	for (ptep = start_ptep; addr < end; ptep++, addr += PAGE_SIZE) {
> +		pte = ptep_get(ptep);
> +
> +		if (!pte_present(pte))
> +			continue;
> +
> +		page = vm_normal_page(vma, addr, pte);
> +		if (!page)
> +			continue;
> +		folio = page_folio(page);
> +
> +		if (folio_is_zone_device(folio) || !folio_test_anon(folio))
> +			continue;
> +		goto found_unlock;
> +	}
> +
> +not_found_unlock:
> +	spin_unlock(ptl);
> +	if (start_ptep)
> +		pte_unmap(start_ptep);
> +	return 0;
> +found_unlock:
> +	folio_get(folio);
> +	spin_unlock(ptl);
> +	if (start_ptep)
> +		pte_unmap(start_ptep);
> +	private->page = page;
> +	private->folio = folio;
> +	private->addr = addr;
> +	return 1;
> +}
> +
> +static struct mm_walk_ops ksm_next_page_ops = {
> +	.pmd_entry = ksm_next_page_pmd_entry,
> +	.walk_lock = PGWALK_RDLOCK,
> +};
> +
>   static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>   {
>   	struct mm_struct *mm;
> @@ -2542,21 +2631,27 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>   			ksm_scan.address = vma->vm_end;
>   
>   		while (ksm_scan.address < vma->vm_end) {
> +			struct ksm_next_page_arg ksm_next_page_arg;
>   			struct page *tmp_page = NULL;
> -			struct folio_walk fw;
>   			struct folio *folio;
>   
>   			if (ksm_test_exit(mm))
>   				break;
>   
> -			folio = folio_walk_start(&fw, vma, ksm_scan.address, 0);
> -			if (folio) {
> -				if (!folio_is_zone_device(folio) &&
> -				     folio_test_anon(folio)) {
> -					folio_get(folio);
> -					tmp_page = fw.page;
> -				}
> -				folio_walk_end(&fw, vma);
> +			int found;
> +
> +			found = walk_page_range_vma(vma, ksm_scan.address,
> +						    vma->vm_end,
> +						    &ksm_next_page_ops,
> +						    &ksm_next_page_arg);
> +
> +			if (found > 0) {
> +				folio = ksm_next_page_arg.folio;
> +				tmp_page = ksm_next_page_arg.page;
> +				ksm_scan.address = ksm_next_page_arg.addr;
> +			} else {
> +				VM_WARN_ON_ONCE(found < 0);
> +				ksm_scan.address = vma->vm_end - PAGE_SIZE;
>   			}
>   
>   			if (tmp_page) {

Thank you, it works magnificently, very pleasent. Very low CPU-consuming 
and effective, no crashes. Is this a final version?


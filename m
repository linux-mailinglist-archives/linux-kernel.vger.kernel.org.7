Return-Path: <linux-kernel+bounces-771108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78420B282F5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C4E9AC8B72
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3B1223DDF;
	Fri, 15 Aug 2025 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHVG2dnN"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6F12AD13
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 15:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755271875; cv=none; b=FKW+NWpXbJHhmq/zCJAP7XMHVVeER4E4qXIBwprmoRrTuooVR24TDHZj8Msft50NJF3+2xDxACpKTNFKYYdbRatDDQMgDrjnQs8KF9D4/6vokeDWP2F+6fxtsj/CSCpGwub8+CmVoa1f8Ed9/84ntr8j36QkixH7F7hz7Nfudu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755271875; c=relaxed/simple;
	bh=cE81UEsx/yLispyGgOg0ScWpFSOsuPXaukKYvQRN3W4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRoH/Q9stCPJQIWgmhjh5vn4woVWT2We7VX9+AUX7sqvCbb7JNHmyvrYFHBdEQmq12yR2XUUxq5++C8UfwdaBoQIDuHHk+RDRiguDZbYZhAym8Mb7VgCh6jIhW9cDonk5nA2pWksFBOjUkhAiXbwJV4tMyvE5BsZDwznBHoPqV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHVG2dnN; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e2ea94c7cso1934185b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 08:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755271873; x=1755876673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vG6nSpBW8GrI6flwCx2lvOGPZBtdjytP1/oIYvTBz5w=;
        b=DHVG2dnN/hwSLdgsEUrVVXGgKWH9g2Ot5fHR3e4V00tBvabHotae/iWkR4yElz/6dL
         pdkv9PZYgbdOcYQp48eVUf3gL2OAQEoxJKVT7ZMy6lXOP986DrbysM/PJu7G9SX9BUo7
         23oBK2hROPQ8h7NR2x1W5WoMFlmfXoEc8hO+evQSYBCAwg6QZyhWXAKlUuUkHRdh2BXS
         +xQgl/b0YkpFDPPX2iOe4f3XBTyKkxESPafTi3iI3FiBsgeKHPVf//rPcOjDHgs8D75a
         6CkjPl/ZiQVBP9riJK3LTYE4PT693OkVVBlc+NFTtNo6rNRlVXbKL0kOyRTjlMuG2kgU
         HsSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755271873; x=1755876673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vG6nSpBW8GrI6flwCx2lvOGPZBtdjytP1/oIYvTBz5w=;
        b=fmbEPOiH1mvLZTbc4ffz9j74HHDSpps+vHS7pqgq11T/Fxsu1tVW0/sNdlkN0U8LjS
         s9S7+pLtYtM3uFP0JFnnYjLGPIfkqGTJb4AOErgcSq/I2ji4P01Kme2srX/nMzPBGpHw
         KVqG9raGKlNEaeQTux5LFS+0rRazRCsYfha06Kq9LRHaE2vQnmYYmzNeH2qsBgjiR3Fm
         Hgrver8yLTdFnYcoOUVapz75y4nv/EUjv/RaP+cPqaHzCnetyA/MCxHaHi/FnEMR3uEE
         1443zneqEAgjWgKzQeYnwxG1S8y7HVX5NDCZohx77/rr0IPvDkrplVFGpjMjXS7OKI4t
         wi1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXBPL9AGB9NmTOwiVzhpC0meP3B7SVhZrGJsCzCE4HXWptyKhrLKCxhUGa5VF+ebeapGaf+gaQ2bvPDToA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW0pvPVdrl1IeZBKYdpD3zPdDH4z6/1tFw178lGqus/D6aWGXP
	xXexxWYoDZjPM4TEhMUGiH8SdIKR8IXXny/41MpgiewCTzqC0vZN4BkC
X-Gm-Gg: ASbGncvAd/iESi0P8bHLZWMW6rNdBEeLawGWhvRMZC7yhj2QBnbubIn8bd/YWfjVIZr
	6HLsO6CNs8Gj7p9vI6KeSuhFZLGoDUdvvUCiD+7f9nt3pHzd3P+aNSAhOmmOeLDplTGZl0JiVzO
	sWIsHneHxFxOCw9oQ33LbHMOYBIKrUGHjpQ2I4u6DRamUEO2CX8oidI8Qc1PUXF2ZdXldw8V0iJ
	N7crWnQ68jPe6XachBe2epIhJ50LX+Bh6QPgtvHhqrya6qHQpDZblUqncPK/bjILdS2GWO9zDUv
	hTxDNYKtE1s/TsPOBOqPt/XeO6JVcOz03eD6oNuRdNFeJ+rC9hefR3+ZOkp/c4siicIJxvcT0MO
	J7Fdy7eF04up1QZSGiBso
X-Google-Smtp-Source: AGHT+IG2024fvzeP+d/GT5SQI1pFoeOHDyqnbCwH7pKgNThMneJbBJSXCa0lYaEaeXB1gM3IUDO/Mg==
X-Received: by 2002:a17:902:e5cd:b0:243:43a:fa20 with SMTP id d9443c01a7336-2446d73b896mr47021765ad.24.1755271872816;
        Fri, 15 Aug 2025 08:31:12 -0700 (PDT)
Received: from vernon-pc ([114.232.195.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d59a188sm16363645ad.162.2025.08.15.08.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 08:31:12 -0700 (PDT)
Date: Fri, 15 Aug 2025 23:30:55 +0800
From: Vernon Yang <vernon2gm@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
	baohua@kernel.org, glider@google.com, elver@google.com,
	dvyukov@google.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, muchun.song@linux.dev,
	osalvador@suse.de, shuah@kernel.org, richardcochran@gmail.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 6/7] mm: memory: add mTHP support for wp
Message-ID: <aJ9RLmuEj4U7JN_7@vernon-pc>
References: <20250814113813.4533-1-vernon2gm@gmail.com>
 <20250814113813.4533-7-vernon2gm@gmail.com>
 <b607985d-d319-4b47-9365-0595f7d87f28@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b607985d-d319-4b47-9365-0595f7d87f28@redhat.com>

On Thu, Aug 14, 2025 at 02:57:34PM +0200, David Hildenbrand wrote:
> On 14.08.25 13:38, Vernon Yang wrote:
> > Currently pagefaults on anonymous pages support mthp, and hardware
> > features (such as arm64 contpte) can be used to store multiple ptes in
> > one TLB entry, reducing the probability of TLB misses. However, when the
> > process is forked and the cow is triggered again, the above optimization
> > effect is lost, and only 4KB is requested once at a time.
> >
> > Therefore, make pagefault write-protect copy support mthp to maintain the
> > optimization effect of TLB and improve the efficiency of cow pagefault.
> >
> > vm-scalability usemem shows a great improvement,
> > test using: usemem -n 32 --prealloc --prefault 249062617
> > (result unit is KB/s, bigger is better)
> >
> > |    size     | w/o patch | w/ patch  |  delta  |
> > |-------------|-----------|-----------|---------|
> > | baseline 4K | 723041.63 | 717643.21 | -0.75%  |
> > | mthp 16K    | 732871.14 | 799513.18 | +9.09%  |
> > | mthp 32K    | 746060.91 | 836261.83 | +12.09% |
> > | mthp 64K    | 747333.18 | 855570.43 | +14.48% |
> >
> > Signed-off-by: Vernon Yang <vernon2gm@gmail.com>
> > ---
> >   include/linux/huge_mm.h |   3 +
> >   mm/memory.c             | 174 ++++++++++++++++++++++++++++++++++++----
> >   2 files changed, 163 insertions(+), 14 deletions(-)
> >
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 2f190c90192d..d1ebbe0636fb 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -132,6 +132,9 @@ enum mthp_stat_item {
> >   	MTHP_STAT_SHMEM_ALLOC,
> >   	MTHP_STAT_SHMEM_FALLBACK,
> >   	MTHP_STAT_SHMEM_FALLBACK_CHARGE,
> > +	MTHP_STAT_WP_FAULT_ALLOC,
> > +	MTHP_STAT_WP_FAULT_FALLBACK,
> > +	MTHP_STAT_WP_FAULT_FALLBACK_CHARGE,
> >   	MTHP_STAT_SPLIT,
> >   	MTHP_STAT_SPLIT_FAILED,
> >   	MTHP_STAT_SPLIT_DEFERRED,
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 8dd869b0cfc1..ea84c49cc975 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3344,6 +3344,21 @@ static inline int __wp_page_copy_user(struct page *dst, struct page *src,
> >   	return ret;
> >   }
> > +static inline int __wp_folio_copy_user(struct folio *dst, struct folio *src,
> > +				       unsigned int offset,
> > +				       struct vm_fault *vmf)
> > +{
> > +	struct vm_area_struct *vma = vmf->vma;
> > +	void __user *uaddr;
> > +
> > +	if (likely(src))
> > +		return copy_user_large_folio(dst, src, offset, vmf->address, vma);
> > +
> > +	uaddr = (void __user *)ALIGN_DOWN(vmf->address, folio_size(dst));
> > +
> > +	return copy_folio_from_user(dst, uaddr, 0);
> > +}
> > +
> >   static gfp_t __get_fault_gfp_mask(struct vm_area_struct *vma)
> >   {
> >   	struct file *vm_file = vma->vm_file;
> > @@ -3527,6 +3542,119 @@ vm_fault_t __vmf_anon_prepare(struct vm_fault *vmf)
> >   	return ret;
> >   }
> > +static inline unsigned long thp_wp_suitable_orders(struct folio *old_folio,
> > +						   unsigned long orders)
> > +{
> > +	int order, max_order;
> > +
> > +	max_order = folio_order(old_folio);
> > +	order = highest_order(orders);
> > +
> > +	/*
> > +	 * Since need to copy content from the old folio to the new folio, the
> > +	 * maximum size of the new folio will not exceed the old folio size,
> > +	 * so filter the inappropriate order.
> > +	 */
> > +	while (orders) {
> > +		if (order <= max_order)
> > +			break;
> > +		order = next_order(&orders, order);
> > +	}
> > +
> > +	return orders;
> > +}
> > +
> > +static bool pte_range_readonly(pte_t *pte, int nr_pages)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < nr_pages; i++) {
> > +		if (pte_write(ptep_get_lockless(pte + i)))
> > +			return false;
> > +	}
> > +
> > +	return true;
> > +}
> > +
> > +static struct folio *alloc_wp_folio(struct vm_fault *vmf, bool pfn_is_zero)
> > +{
> > +	struct vm_area_struct *vma = vmf->vma;
> > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > +	unsigned long orders;
> > +	struct folio *folio;
> > +	unsigned long addr;
> > +	pte_t *pte;
> > +	gfp_t gfp;
> > +	int order;
> > +
> > +	/*
> > +	 * If uffd is active for the vma we need per-page fault fidelity to
> > +	 * maintain the uffd semantics.
> > +	 */
> > +	if (unlikely(userfaultfd_armed(vma)))
> > +		goto fallback;
> > +
> > +	if (pfn_is_zero || !vmf->page)
> > +		goto fallback;
> > +
> > +	/*
> > +	 * Get a list of all the (large) orders below folio_order() that are enabled
> > +	 * for this vma. Then filter out the orders that can't be allocated over
> > +	 * the faulting address and still be fully contained in the vma.
> > +	 */
> > +	orders = thp_vma_allowable_orders(vma, vma->vm_flags,
> > +			TVA_IN_PF | TVA_ENFORCE_SYSFS, BIT(PMD_ORDER) - 1);
> > +	orders = thp_vma_suitable_orders(vma, vmf->address, orders);
> > +	orders = thp_wp_suitable_orders(page_folio(vmf->page), orders);
> > +
> > +	if (!orders)
> > +		goto fallback;
> > +
> > +	pte = pte_offset_map(vmf->pmd, vmf->address & PMD_MASK);
> > +	if (!pte)
> > +		return ERR_PTR(-EAGAIN);
> > +
> > +	/*
> > +	 * Find the highest order where the aligned range is completely readonly.
> > +	 * Note that all remaining orders will be completely readonly.
> > +	 */
> > +	order = highest_order(orders);
> > +	while (orders) {
> > +		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
> > +		if (pte_range_readonly(pte + pte_index(addr), 1 << order))
> > +			break;
> > +		order = next_order(&orders, order);
> > +	}
> > +
> > +	pte_unmap(pte);
> > +
> > +	if (!orders)
> > +		goto fallback;
> > +
> > +	/* Try allocating the highest of the remaining orders. */
> > +	gfp = vma_thp_gfp_mask(vma);
> > +	while (orders) {
> > +		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
> > +		folio = vma_alloc_folio(gfp, order, vma, addr);
> > +		if (folio) {
> > +			if (mem_cgroup_charge(folio, vma->vm_mm, gfp)) {
> > +				count_mthp_stat(order, MTHP_STAT_WP_FAULT_FALLBACK_CHARGE);
> > +				folio_put(folio);
> > +				goto next;
> > +			}
> > +			folio_throttle_swaprate(folio, gfp);
> > +			return folio;
> > +		}
>
> I might be missing something, but besides the PAE issue I think there are
> more issues lurking here:
>
> * Are you scanning outside of the current VMA, and some PTEs might
>   actually belong to a !writable VMA?

In thp_vma_suitable_order(), it not exceed the size of the current VMA,
and all PTEs belong to current writable VMA.

> * Are you assuming that the R/O PTE range is actually mapping all-pages
>   from the same large folio?

Yes, is there a potential problem with this assumption? maybe I'm missing
something.

>
> I am not sure if you are assuming some natural alignment of the old folio.
> Due to mremap() that must not be the case.

Here it is assumed that the virtual address aligns the old folio size,
the mremap would break that assumption, right?

>
> Which stresses my point: khugepaged might be the better place to re-collapse
> where reasonable, avoiding further complexity in our CoW handling.
>
> --
> Cheers
>
> David / dhildenb
>


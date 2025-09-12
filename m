Return-Path: <linux-kernel+bounces-813044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA66B5400C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 03:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D11D21C8601B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 01:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFF3191493;
	Fri, 12 Sep 2025 01:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="difnhe8r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DB83D544
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757642353; cv=none; b=ihL0jhBBdbXsAqaQl6ONhWl4mEkJzuSdfXNTjdOHUNw2atZVMW3Qt9Pv6sIN6loi/EwLQG+vKA2s045PyCxFGm32GIM5wfwoHAtfocVbh3RYWkxesGS1/7bstqB0dteq5ZHI9vntxaOUWWl0qvmgFhSI7teaxofFpKO0O19jaak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757642353; c=relaxed/simple;
	bh=meu8m65eD3yfEwGMUX3MAwvZUXiaWLYcK+z9uaK0MG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sXAPCW0RfAO4wnzt2xaXry9TdviNmiNd0m99AMQQXMUcGL024XRGU3jyuOvf8kjWdcyPlSC/XYSCm5kKmHpeIH9Qz1cApa88NlEyv8DsROrjT5fvfaxZlXpA67IL24kWBVRop9+3FOEn5gWUBkLimB0EpCXxOCt8OWKWSnt3Tu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=difnhe8r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 571FBC4CEF0;
	Fri, 12 Sep 2025 01:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757642353;
	bh=meu8m65eD3yfEwGMUX3MAwvZUXiaWLYcK+z9uaK0MG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=difnhe8rYJ5KYdrAC/LLuy/z68nGffP5eq6tURh51P5H9B0rWNM+2S29plk+JSMnb
	 R5ryLu093928ic6MByU1XZT5WhVqZ96NtoAIFYDgqsbXPmuUs/IbqDnDiDQTKltm4R
	 5alZpJVf4mXmpap37JqkD8Fm7i/zS6ow+yTWYafuFgu+mzq1MU6hAIn2GN9vxp+M9W
	 FS2zjM6LmhgsCUik5aa6LImOnIYw8J4QuxDH0LR93nSqPxZuk+aga2TECNsmGP/h5b
	 4lI9QMMGs0efuyZDuCNo5GXs26UfMwDI3qKKqAaL+9IH9+a4gRgLBj5lIkdZUiLijS
	 /eRxPF4CW5q3Q==
From: SeongJae Park <sj@kernel.org>
To: Balbir Singh <balbirs@nvidia.com>
Cc: SeongJae Park <sj@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	dri-devel@lists.freedesktop.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Ralph Campbell <rcampbell@nvidia.com>,
	=?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Francois Dugast <francois.dugast@intel.com>
Subject: Re: [v5 03/15] mm/rmap: extend rmap and migration support device-private entries
Date: Thu, 11 Sep 2025 18:59:09 -0700
Message-Id: <20250912015910.59404-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250908000448.180088-4-balbirs@nvidia.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon,  8 Sep 2025 10:04:36 +1000 Balbir Singh <balbirs@nvidia.com> wrote:

> Add device-private THP support to reverse mapping infrastructure,
> enabling proper handling during migration and walk operations.
> 
> The key changes are:
> - add_migration_pmd()/remove_migration_pmd(): Handle device-private
>   entries during folio migration and splitting
> - page_vma_mapped_walk(): Recognize device-private THP entries during
>   VMA traversal operations
> 
> This change supports folio splitting and migration operations on
> device-private entries.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
> Cc: Rakie Kim <rakie.kim@sk.com>
> Cc: Byungchul Park <byungchul@sk.com>
> Cc: Gregory Price <gourry@gourry.net>
> Cc: Ying Huang <ying.huang@linux.alibaba.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Nico Pache <npache@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Mika Penttilä <mpenttil@redhat.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Francois Dugast <francois.dugast@intel.com>
> 
> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
> ---
>  mm/damon/ops-common.c | 20 +++++++++++++++++---
>  mm/huge_memory.c      | 16 +++++++++++++++-
>  mm/page_idle.c        |  5 +++--
>  mm/page_vma_mapped.c  | 12 ++++++++++--
>  mm/rmap.c             | 19 ++++++++++++++++---
>  5 files changed, 61 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index 998c5180a603..eda4de553611 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -75,12 +75,24 @@ void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr
>  void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr)
>  {
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -	struct folio *folio = damon_get_folio(pmd_pfn(pmdp_get(pmd)));
> +	pmd_t pmdval = pmdp_get(pmd);
> +	struct folio *folio;
> +	bool young = false;
> +	unsigned long pfn;
> +
> +	if (likely(pmd_present(pmdval)))
> +		pfn = pmd_pfn(pmdval);
> +	else
> +		pfn = swp_offset_pfn(pmd_to_swp_entry(pmdval));
>  
> +	folio = damon_get_folio(pfn);
>  	if (!folio)
>  		return;
>  
> -	if (pmdp_clear_young_notify(vma, addr, pmd))
> +	if (likely(pmd_present(pmdval)))
> +		young |= pmdp_clear_young_notify(vma, addr, pmd);
> +	young |= mmu_notifier_clear_young(vma->vm_mm, addr, addr + PAGE_SIZE);
> +	if (young)
>  		folio_set_young(folio);
>  
>  	folio_set_idle(folio);
> @@ -203,7 +215,9 @@ static bool damon_folio_young_one(struct folio *folio,
>  				mmu_notifier_test_young(vma->vm_mm, addr);
>  		} else {
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -			*accessed = pmd_young(pmdp_get(pvmw.pmd)) ||
> +			pmd_t pmd = pmdp_get(pvmw.pmd);
> +
> +			*accessed = (pmd_present(pmd) && pmd_young(pmd)) ||
>  				!folio_test_idle(folio) ||
>  				mmu_notifier_test_young(vma->vm_mm, addr);

Could you please elaborate more about why the above change is needed on the
commit message?

For example, I found below from v3 of this patch series:

    pmd_pfn() does not work well with zone device entries, use
    pfn_pmd_entry_to_swap() for checking and comparison as for zone device
    entries.

Adding that kind of elaboration on the commit message would be helpful.

Also, seems the DAMON part change is not really required to be made together
with other changes.  If I'm not wrong, could you make DAMON part change as a
separate commit?

The code looks good to me.

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]


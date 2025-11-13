Return-Path: <linux-kernel+bounces-898793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD53C5608C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59E664E2DC2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 07:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABB7320CBA;
	Thu, 13 Nov 2025 07:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XoHXrO4m"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53B929CEB;
	Thu, 13 Nov 2025 07:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763018443; cv=none; b=MptV/xyOeZfppE0hhcj/hYlYDHuoMQNaMovqmT/wMzBGxE6k2E0r3CJWk+8Mt9gqB5E5lqzXWt0SPZMxE940Fy7Qmi5XvcPkBTNAwNj+egErcNvX3Qz/++DKzDrqXY3kwOc7LdnNkMICUj8ZJcFRbBuOA/KA/zWHkCqP8g5xZRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763018443; c=relaxed/simple;
	bh=6Me6GWqOMV1Te3Vqndd4JPy4GgWbf+TWVFwtSqdGhwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pVWyJBPAu/RX5kQDx8v3jzI2NJQB0sovY/ps2znTT/S5szidlCeox+FghpoW8VS2wV8o2aA4Du9KdprG54HaaOx2HzM+g175Q3O7U7WEgnnPszAvrcdvcxpty2U8jayg5SbLOIrZNF7PP1TXx/kcsOyUqOqO4vqRpgkJ5BgDhfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XoHXrO4m; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763018441; x=1794554441;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6Me6GWqOMV1Te3Vqndd4JPy4GgWbf+TWVFwtSqdGhwE=;
  b=XoHXrO4m2Yhq1LoEz3M3uBAQFx47UO6m0xcfZrHt75ivhZNBDrUXFv7L
   US2f+hoaefflnDOeIDFPuzr0o1wmqVZm11TBHECuRBWIceapPMtu35EPA
   KxlERTK9U4zniMRG2UXLL+DuOCX4S0bmIbKNbCH0eGbxi/edECrAH03Ip
   pqQyN2C67EGyDbFCSQ5XznN7PHFMyNUGs2Z4GHn5q1udD4f4+8TYRXnyu
   AYiNyr5Y7TfvrFYG1xDDsYxKd1QMdDuBNcGFVkU6AjJRWNtZOMPLUM3e2
   ytEft3SMJlGDrZSjMNSCgAR4UJQvgr9GZG3TYYn3Mvz0nXe9+YCf9uaMj
   g==;
X-CSE-ConnectionGUID: G+urj6xYRjm3sNkRx+8NHQ==
X-CSE-MsgGUID: bd6YLeY8Qm633qVyroyOwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65018343"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="65018343"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 23:20:40 -0800
X-CSE-ConnectionGUID: Gj2hNzySSG+P7YfpZN0+0w==
X-CSE-MsgGUID: Rg/fE/d9SqiQUCtfAuTUPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="189614267"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 12 Nov 2025 23:20:36 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vJRdB-00051L-19;
	Thu, 13 Nov 2025 07:20:33 +0000
Date: Thu, 13 Nov 2025 15:19:38 +0800
From: kernel test robot <lkp@intel.com>
To: Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
	linux-riscv@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	devicetree@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
	Michal Hocko <mhocko@suse.com>, Conor Dooley <conor@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh+dt@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v3 08/22] mm: Allow page table accessors to be
 non-idempotent
Message-ID: <202511131448.ZCsuBlBE-lkp@intel.com>
References: <20251113014656.2605447-9-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113014656.2605447-9-samuel.holland@sifive.com>

Hi Samuel,

kernel test robot noticed the following build errors:

[auto build test ERROR on 24172e0d79900908cf5ebf366600616d29c9b417]

url:    https://github.com/intel-lab-lkp/linux/commits/Samuel-Holland/mm-ptdump-replace-READ_ONCE-with-standard-page-table-accessors/20251113-095117
base:   24172e0d79900908cf5ebf366600616d29c9b417
patch link:    https://lore.kernel.org/r/20251113014656.2605447-9-samuel.holland%40sifive.com
patch subject: [PATCH v3 08/22] mm: Allow page table accessors to be non-idempotent
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20251113/202511131448.ZCsuBlBE-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251113/202511131448.ZCsuBlBE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511131448.ZCsuBlBE-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/gup.c: In function 'gup_fast_pte_range':
>> mm/gup.c:2848:9: error: implicit declaration of function 'set_pmd'; did you mean 'set_p4d'? [-Wimplicit-function-declaration]
    2848 |         set_pmd(&pmd, pmd);
         |         ^~~~~~~
         |         set_p4d
--
   mm/pgtable-generic.c: In function '___pte_offset_map':
>> mm/pgtable-generic.c:303:9: error: implicit declaration of function 'set_pmd'; did you mean 'set_p4d'? [-Wimplicit-function-declaration]
     303 |         set_pmd(&pmdval, pmdval);
         |         ^~~~~~~
         |         set_p4d


vim +2848 mm/gup.c

  2819	
  2820	#ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
  2821	/*
  2822	 * GUP-fast relies on pte change detection to avoid concurrent pgtable
  2823	 * operations.
  2824	 *
  2825	 * To pin the page, GUP-fast needs to do below in order:
  2826	 * (1) pin the page (by prefetching pte), then (2) check pte not changed.
  2827	 *
  2828	 * For the rest of pgtable operations where pgtable updates can be racy
  2829	 * with GUP-fast, we need to do (1) clear pte, then (2) check whether page
  2830	 * is pinned.
  2831	 *
  2832	 * Above will work for all pte-level operations, including THP split.
  2833	 *
  2834	 * For THP collapse, it's a bit more complicated because GUP-fast may be
  2835	 * walking a pgtable page that is being freed (pte is still valid but pmd
  2836	 * can be cleared already).  To avoid race in such condition, we need to
  2837	 * also check pmd here to make sure pmd doesn't change (corresponds to
  2838	 * pmdp_collapse_flush() in the THP collapse code path).
  2839	 */
  2840	static int gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
  2841			unsigned long end, unsigned int flags, struct page **pages,
  2842			int *nr)
  2843	{
  2844		int ret = 0;
  2845		pte_t *ptep, *ptem;
  2846	
  2847		/* transform pmd as if &pmd pointed to a hardware page table */
> 2848		set_pmd(&pmd, pmd);
  2849		ptem = ptep = pte_offset_map(&pmd, addr);
  2850		pmd = pmdp_get(&pmd);
  2851		if (!ptep)
  2852			return 0;
  2853		do {
  2854			pte_t pte = ptep_get_lockless(ptep);
  2855			struct page *page;
  2856			struct folio *folio;
  2857	
  2858			/*
  2859			 * Always fallback to ordinary GUP on PROT_NONE-mapped pages:
  2860			 * pte_access_permitted() better should reject these pages
  2861			 * either way: otherwise, GUP-fast might succeed in
  2862			 * cases where ordinary GUP would fail due to VMA access
  2863			 * permissions.
  2864			 */
  2865			if (pte_protnone(pte))
  2866				goto pte_unmap;
  2867	
  2868			if (!pte_access_permitted(pte, flags & FOLL_WRITE))
  2869				goto pte_unmap;
  2870	
  2871			if (pte_special(pte))
  2872				goto pte_unmap;
  2873	
  2874			/* If it's not marked as special it must have a valid memmap. */
  2875			VM_WARN_ON_ONCE(!pfn_valid(pte_pfn(pte)));
  2876			page = pte_page(pte);
  2877	
  2878			folio = try_grab_folio_fast(page, 1, flags);
  2879			if (!folio)
  2880				goto pte_unmap;
  2881	
  2882			if (unlikely(pmd_val(pmd) != pmd_val(pmdp_get(pmdp))) ||
  2883			    unlikely(pte_val(pte) != pte_val(ptep_get(ptep)))) {
  2884				gup_put_folio(folio, 1, flags);
  2885				goto pte_unmap;
  2886			}
  2887	
  2888			if (!gup_fast_folio_allowed(folio, flags)) {
  2889				gup_put_folio(folio, 1, flags);
  2890				goto pte_unmap;
  2891			}
  2892	
  2893			if (!pte_write(pte) && gup_must_unshare(NULL, flags, page)) {
  2894				gup_put_folio(folio, 1, flags);
  2895				goto pte_unmap;
  2896			}
  2897	
  2898			/*
  2899			 * We need to make the page accessible if and only if we are
  2900			 * going to access its content (the FOLL_PIN case).  Please
  2901			 * see Documentation/core-api/pin_user_pages.rst for
  2902			 * details.
  2903			 */
  2904			if ((flags & FOLL_PIN) && arch_make_folio_accessible(folio)) {
  2905				gup_put_folio(folio, 1, flags);
  2906				goto pte_unmap;
  2907			}
  2908			folio_set_referenced(folio);
  2909			pages[*nr] = page;
  2910			(*nr)++;
  2911		} while (ptep++, addr += PAGE_SIZE, addr != end);
  2912	
  2913		ret = 1;
  2914	
  2915	pte_unmap:
  2916		pte_unmap(ptem);
  2917		return ret;
  2918	}
  2919	#else
  2920	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


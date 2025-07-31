Return-Path: <linux-kernel+bounces-752383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA29B174D9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 18:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62BBE1C21F76
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681E823E334;
	Thu, 31 Jul 2025 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vzaqlv72"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071B923C8B3
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753978813; cv=none; b=ALaEzCNefrvtUUtfDDCk8cyHraW7YUQTpbvCyechbib9a1A63GMjYile1Xc2lpsrui4N7M7zxbpkGWgMLU7d3fQD4k5cB4yL/u12gwGtANW2+XqmiZAgqllliQAiVfY4IF+cwUXc9u0fy7hJWFZVn40RXplUIsOvqYXVQAn9e2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753978813; c=relaxed/simple;
	bh=3Uzw4l/DadJpUNAI5j/MXwiKLFsLDzgdQXCiuDsi3QE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkfiqL0hGrv03o13ktZ2Yj5UlHiSDXO6sCjaJlDiaJks4cFwh49VkSVgz91Qv3VBGyVfZYDt3k9Yv5AiD8Z+/Le1AGagdABufJ0TpSpCxYhhVTA9X6oETuP+bZL/WhgdbXNOGbuJsLiy4aKzyhQNN2gbw1TgBemOmSD993e4d/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vzaqlv72; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753978812; x=1785514812;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3Uzw4l/DadJpUNAI5j/MXwiKLFsLDzgdQXCiuDsi3QE=;
  b=Vzaqlv728BPD0wU4mJvKG1NIdY8bDqeMKZp3XrmjL4he6Spgee7C/fmX
   leqaO+b5bxzG8h8XBqZqpXLdqE4laTaqeoOnhdc8tgJArgLDzl6p/kojA
   sriahE8iCn/K9fwFNmGhyKRJd6qnSJuooZeBOTUzPj1gaW39FY8hjA+jj
   EmfAzLicwlBW1iyI6xCHlO726HygnW7d1+6ibXlefKaVnLzJYQOGP0dQM
   XSJQ3+tefMuKF/NdNpowrtliOhS2WjFPOXgo+aETINEyU+SvVJzOntkti
   fT7nVYcEfk2p2Z+JM/98ScoiCdJgvZnGujA/cIEyuJ1puKFOH2SMqS640
   g==;
X-CSE-ConnectionGUID: UggJJJtDQ9S6jnpxn33ehA==
X-CSE-MsgGUID: vWudmf8qQbOYSd7rlml/xA==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="56455667"
X-IronPort-AV: E=Sophos;i="6.17,254,1747724400"; 
   d="scan'208";a="56455667"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 09:20:12 -0700
X-CSE-ConnectionGUID: 1TSHb2rpQySMYDBl24Qimg==
X-CSE-MsgGUID: gK+enTLiSlGTTNmrphHccQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,254,1747724400"; 
   d="scan'208";a="167791054"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 31 Jul 2025 09:20:06 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uhW0h-0003um-2m;
	Thu, 31 Jul 2025 16:20:03 +0000
Date: Fri, 1 Aug 2025 00:19:52 +0800
From: kernel test robot <lkp@intel.com>
To: Balbir Singh <balbirs@nvidia.com>, linux-mm@kvack.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Balbir Singh <balbirs@nvidia.com>,
	Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	David Hildenbrand <david@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Matthew Wilcox <willy@infradead.org>, Peter Xu <peterx@redhat.com>,
	Zi Yan <ziy@nvidia.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
	Jane Chu <jane.chu@oracle.com>,
	Alistair Popple <apopple@nvidia.com>,
	Donet Tom <donettom@linux.ibm.com>,
	Mika =?iso-8859-1?Q?Penttil=E4?= <mpenttil@redhat.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Francois Dugast <francois.dugast@intel.com>,
	Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [v2 03/11] mm/migrate_device: THP migration of zone device pages
Message-ID: <202507312342.dmLxVgli-lkp@intel.com>
References: <20250730092139.3890844-4-balbirs@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730092139.3890844-4-balbirs@nvidia.com>

Hi Balbir,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on next-20250731]
[cannot apply to akpm-mm/mm-nonmm-unstable shuah-kselftest/next shuah-kselftest/fixes linus/master v6.16]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Balbir-Singh/mm-zone_device-support-large-zone-device-private-folios/20250730-172600
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250730092139.3890844-4-balbirs%40nvidia.com
patch subject: [v2 03/11] mm/migrate_device: THP migration of zone device pages
config: x86_64-randconfig-122-20250731 (https://download.01.org/0day-ci/archive/20250731/202507312342.dmLxVgli-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250731/202507312342.dmLxVgli-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507312342.dmLxVgli-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> mm/migrate_device.c:769:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected int [assigned] ret @@     got restricted vm_fault_t @@
   mm/migrate_device.c:769:13: sparse:     expected int [assigned] ret
   mm/migrate_device.c:769:13: sparse:     got restricted vm_fault_t
   mm/migrate_device.c:130:25: sparse: sparse: context imbalance in 'migrate_vma_collect_huge_pmd' - unexpected unlock
   mm/migrate_device.c:815:16: sparse: sparse: context imbalance in 'migrate_vma_insert_huge_pmd_page' - different lock contexts for basic block

vim +769 mm/migrate_device.c

   689	
   690	#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
   691	/**
   692	 * migrate_vma_insert_huge_pmd_page: Insert a huge folio into @migrate->vma->vm_mm
   693	 * at @addr. folio is already allocated as a part of the migration process with
   694	 * large page.
   695	 *
   696	 * @folio needs to be initialized and setup after it's allocated. The code bits
   697	 * here follow closely the code in __do_huge_pmd_anonymous_page(). This API does
   698	 * not support THP zero pages.
   699	 *
   700	 * @migrate: migrate_vma arguments
   701	 * @addr: address where the folio will be inserted
   702	 * @folio: folio to be inserted at @addr
   703	 * @src: src pfn which is being migrated
   704	 * @pmdp: pointer to the pmd
   705	 */
   706	static int migrate_vma_insert_huge_pmd_page(struct migrate_vma *migrate,
   707						 unsigned long addr,
   708						 struct page *page,
   709						 unsigned long *src,
   710						 pmd_t *pmdp)
   711	{
   712		struct vm_area_struct *vma = migrate->vma;
   713		gfp_t gfp = vma_thp_gfp_mask(vma);
   714		struct folio *folio = page_folio(page);
   715		int ret;
   716		spinlock_t *ptl;
   717		pgtable_t pgtable;
   718		pmd_t entry;
   719		bool flush = false;
   720		unsigned long i;
   721	
   722		VM_WARN_ON_FOLIO(!folio, folio);
   723		VM_WARN_ON_ONCE(!pmd_none(*pmdp) && !is_huge_zero_pmd(*pmdp));
   724	
   725		if (!thp_vma_suitable_order(vma, addr, HPAGE_PMD_ORDER))
   726			return -EINVAL;
   727	
   728		ret = anon_vma_prepare(vma);
   729		if (ret)
   730			return ret;
   731	
   732		folio_set_order(folio, HPAGE_PMD_ORDER);
   733		folio_set_large_rmappable(folio);
   734	
   735		if (mem_cgroup_charge(folio, migrate->vma->vm_mm, gfp)) {
   736			count_vm_event(THP_FAULT_FALLBACK);
   737			count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
   738			ret = -ENOMEM;
   739			goto abort;
   740		}
   741	
   742		__folio_mark_uptodate(folio);
   743	
   744		pgtable = pte_alloc_one(vma->vm_mm);
   745		if (unlikely(!pgtable))
   746			goto abort;
   747	
   748		if (folio_is_device_private(folio)) {
   749			swp_entry_t swp_entry;
   750	
   751			if (vma->vm_flags & VM_WRITE)
   752				swp_entry = make_writable_device_private_entry(
   753							page_to_pfn(page));
   754			else
   755				swp_entry = make_readable_device_private_entry(
   756							page_to_pfn(page));
   757			entry = swp_entry_to_pmd(swp_entry);
   758		} else {
   759			if (folio_is_zone_device(folio) &&
   760			    !folio_is_device_coherent(folio)) {
   761				goto abort;
   762			}
   763			entry = folio_mk_pmd(folio, vma->vm_page_prot);
   764			if (vma->vm_flags & VM_WRITE)
   765				entry = pmd_mkwrite(pmd_mkdirty(entry), vma);
   766		}
   767	
   768		ptl = pmd_lock(vma->vm_mm, pmdp);
 > 769		ret = check_stable_address_space(vma->vm_mm);
   770		if (ret)
   771			goto abort;
   772	
   773		/*
   774		 * Check for userfaultfd but do not deliver the fault. Instead,
   775		 * just back off.
   776		 */
   777		if (userfaultfd_missing(vma))
   778			goto unlock_abort;
   779	
   780		if (!pmd_none(*pmdp)) {
   781			if (!is_huge_zero_pmd(*pmdp))
   782				goto unlock_abort;
   783			flush = true;
   784		} else if (!pmd_none(*pmdp))
   785			goto unlock_abort;
   786	
   787		add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
   788		folio_add_new_anon_rmap(folio, vma, addr, RMAP_EXCLUSIVE);
   789		if (!folio_is_zone_device(folio))
   790			folio_add_lru_vma(folio, vma);
   791		folio_get(folio);
   792	
   793		if (flush) {
   794			pte_free(vma->vm_mm, pgtable);
   795			flush_cache_page(vma, addr, addr + HPAGE_PMD_SIZE);
   796			pmdp_invalidate(vma, addr, pmdp);
   797		} else {
   798			pgtable_trans_huge_deposit(vma->vm_mm, pmdp, pgtable);
   799			mm_inc_nr_ptes(vma->vm_mm);
   800		}
   801		set_pmd_at(vma->vm_mm, addr, pmdp, entry);
   802		update_mmu_cache_pmd(vma, addr, pmdp);
   803	
   804		spin_unlock(ptl);
   805	
   806		count_vm_event(THP_FAULT_ALLOC);
   807		count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_ALLOC);
   808		count_memcg_event_mm(vma->vm_mm, THP_FAULT_ALLOC);
   809	
   810		return 0;
   811	
   812	unlock_abort:
   813		spin_unlock(ptl);
   814	abort:
   815		for (i = 0; i < HPAGE_PMD_NR; i++)
   816			src[i] &= ~MIGRATE_PFN_MIGRATE;
   817		return 0;
   818	}
   819	#else /* !CONFIG_ARCH_ENABLE_THP_MIGRATION */
   820	static int migrate_vma_insert_huge_pmd_page(struct migrate_vma *migrate,
   821						 unsigned long addr,
   822						 struct page *page,
   823						 unsigned long *src,
   824						 pmd_t *pmdp)
   825	{
   826		return 0;
   827	}
   828	#endif
   829	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


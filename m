Return-Path: <linux-kernel+bounces-751294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C48CB16756
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 22:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A584C18C6B93
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51F81FFC55;
	Wed, 30 Jul 2025 20:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mvrhFafk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200DC1F1537
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 20:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753905975; cv=none; b=LJQUCGH56HvzN3NhFk3dLK74BJlvmPKd7XuL9rllJi3wnBxtftAdHWkRNcwADwStyUoGb7KUrAClOACItNGtL9jkKud8QdDlARdiNyXyMCOl3sB6DxJsm5Z0/6Njq/RscPe7FWmtZXLJwPwzX3A7VhswPw+09I3upn+mrXxNFnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753905975; c=relaxed/simple;
	bh=cMBTMM1CUjcsMZHR6XO1Wm8zLHZFE8PNesd4NP4AGX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYuGlHyF7JY/6w668FEodY6ezAatuR+yk0jAH++bN3Ny5OS787nO+s+ypeKpet3MHn87eMMS8iv9ztnjkiloeOF7DN+qpxKimEB+MMdiLL7TVIdHuUdYnMwgsjvJWwhw06VKkuRrDMwopvrtg7Siwn2xJnCaMO+1dhORal/2nmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mvrhFafk; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753905974; x=1785441974;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cMBTMM1CUjcsMZHR6XO1Wm8zLHZFE8PNesd4NP4AGX4=;
  b=mvrhFafkSb/egRs3Oxhrc66iUbzyUdqhX35yHUlQkDSoYTS7/svTTYkz
   zNz8MlwpensEhKFlAVw0v2SUr5OCW9bCNI65jcgk2yFAaSl32JXKxNuub
   yM0fGGXz4+hH4nRyQkgWELI8XP0C2qohLZ9bcfbsztX5GT4hep+DCRifh
   Iboe6jfzO2Bz/jEF3/ERp3uCmWXnLHPMNLGqwOyFTAbWduHhw+ifteUaL
   CVXfLhKtutDLix20bbk89tI7wndo1k2uyZV7m07SGAn2GTon5jFgNflFO
   A1rjsCF/3zjpn/0wER8Kd3Z+tYarILC9KGJ+f+U7ftHlFDPct+barceoD
   A==;
X-CSE-ConnectionGUID: b/0prSTEQFCY6zhv9MSIag==
X-CSE-MsgGUID: GkQdTvi3S3KigQGrHYItuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="60035985"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="60035985"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 13:06:14 -0700
X-CSE-ConnectionGUID: nBTCfiBzQN+XZZJN4M9xpQ==
X-CSE-MsgGUID: aNjGAYLlTZKF5EABprN4CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="163414761"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 30 Jul 2025 13:06:08 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uhD3t-00036w-1c;
	Wed, 30 Jul 2025 20:06:05 +0000
Date: Thu, 31 Jul 2025 04:05:24 +0800
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
Subject: Re: [v2 02/11] mm/thp: zone_device awareness in THP handling code
Message-ID: <202507310343.ZipoyitU-lkp@intel.com>
References: <20250730092139.3890844-3-balbirs@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730092139.3890844-3-balbirs@nvidia.com>

Hi Balbir,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on next-20250730]
[cannot apply to akpm-mm/mm-nonmm-unstable shuah-kselftest/next shuah-kselftest/fixes linus/master v6.16]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Balbir-Singh/mm-zone_device-support-large-zone-device-private-folios/20250730-172600
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250730092139.3890844-3-balbirs%40nvidia.com
patch subject: [v2 02/11] mm/thp: zone_device awareness in THP handling code
config: i386-buildonly-randconfig-001-20250731 (https://download.01.org/0day-ci/archive/20250731/202507310343.ZipoyitU-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250731/202507310343.ZipoyitU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507310343.ZipoyitU-lkp@intel.com/

All warnings (new ones prefixed by >>):

   mm/rmap.c: In function 'try_to_migrate_one':
>> mm/rmap.c:2330:39: warning: unused variable 'pfn' [-Wunused-variable]
    2330 |                         unsigned long pfn;
         |                                       ^~~


vim +/pfn +2330 mm/rmap.c

  2273	
  2274	/*
  2275	 * @arg: enum ttu_flags will be passed to this argument.
  2276	 *
  2277	 * If TTU_SPLIT_HUGE_PMD is specified any PMD mappings will be split into PTEs
  2278	 * containing migration entries.
  2279	 */
  2280	static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
  2281			     unsigned long address, void *arg)
  2282	{
  2283		struct mm_struct *mm = vma->vm_mm;
  2284		DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address,
  2285					PVMW_THP_DEVICE_PRIVATE);
  2286		bool anon_exclusive, writable, ret = true;
  2287		pte_t pteval;
  2288		struct page *subpage;
  2289		struct mmu_notifier_range range;
  2290		enum ttu_flags flags = (enum ttu_flags)(long)arg;
  2291		unsigned long pfn;
  2292		unsigned long hsz = 0;
  2293	
  2294		/*
  2295		 * When racing against e.g. zap_pte_range() on another cpu,
  2296		 * in between its ptep_get_and_clear_full() and folio_remove_rmap_*(),
  2297		 * try_to_migrate() may return before page_mapped() has become false,
  2298		 * if page table locking is skipped: use TTU_SYNC to wait for that.
  2299		 */
  2300		if (flags & TTU_SYNC)
  2301			pvmw.flags = PVMW_SYNC;
  2302	
  2303		/*
  2304		 * For THP, we have to assume the worse case ie pmd for invalidation.
  2305		 * For hugetlb, it could be much worse if we need to do pud
  2306		 * invalidation in the case of pmd sharing.
  2307		 *
  2308		 * Note that the page can not be free in this function as call of
  2309		 * try_to_unmap() must hold a reference on the page.
  2310		 */
  2311		range.end = vma_address_end(&pvmw);
  2312		mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma->vm_mm,
  2313					address, range.end);
  2314		if (folio_test_hugetlb(folio)) {
  2315			/*
  2316			 * If sharing is possible, start and end will be adjusted
  2317			 * accordingly.
  2318			 */
  2319			adjust_range_if_pmd_sharing_possible(vma, &range.start,
  2320							     &range.end);
  2321	
  2322			/* We need the huge page size for set_huge_pte_at() */
  2323			hsz = huge_page_size(hstate_vma(vma));
  2324		}
  2325		mmu_notifier_invalidate_range_start(&range);
  2326	
  2327		while (page_vma_mapped_walk(&pvmw)) {
  2328			/* PMD-mapped THP migration entry */
  2329			if (!pvmw.pte) {
> 2330				unsigned long pfn;
  2331	
  2332				if (flags & TTU_SPLIT_HUGE_PMD) {
  2333					split_huge_pmd_locked(vma, pvmw.address,
  2334							      pvmw.pmd, true);
  2335					ret = false;
  2336					page_vma_mapped_walk_done(&pvmw);
  2337					break;
  2338				}
  2339	#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
  2340				/*
  2341				 * Zone device private folios do not work well with
  2342				 * pmd_pfn() on some architectures due to pte
  2343				 * inversion.
  2344				 */
  2345				if (is_pmd_device_private_entry(*pvmw.pmd)) {
  2346					swp_entry_t entry = pmd_to_swp_entry(*pvmw.pmd);
  2347	
  2348					pfn = swp_offset_pfn(entry);
  2349				} else {
  2350					pfn = pmd_pfn(*pvmw.pmd);
  2351				}
  2352	
  2353				subpage = folio_page(folio, pfn - folio_pfn(folio));
  2354	
  2355				VM_BUG_ON_FOLIO(folio_test_hugetlb(folio) ||
  2356						!folio_test_pmd_mappable(folio), folio);
  2357	
  2358				if (set_pmd_migration_entry(&pvmw, subpage)) {
  2359					ret = false;
  2360					page_vma_mapped_walk_done(&pvmw);
  2361					break;
  2362				}
  2363				continue;
  2364	#endif
  2365			}
  2366	
  2367			/* Unexpected PMD-mapped THP? */
  2368			VM_BUG_ON_FOLIO(!pvmw.pte, folio);
  2369	
  2370			/*
  2371			 * Handle PFN swap PTEs, such as device-exclusive ones, that
  2372			 * actually map pages.
  2373			 */
  2374			pteval = ptep_get(pvmw.pte);
  2375			if (likely(pte_present(pteval))) {
  2376				pfn = pte_pfn(pteval);
  2377			} else {
  2378				pfn = swp_offset_pfn(pte_to_swp_entry(pteval));
  2379				VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
  2380			}
  2381	
  2382			subpage = folio_page(folio, pfn - folio_pfn(folio));
  2383			address = pvmw.address;
  2384			anon_exclusive = folio_test_anon(folio) &&
  2385					 PageAnonExclusive(subpage);
  2386	
  2387			if (folio_test_hugetlb(folio)) {
  2388				bool anon = folio_test_anon(folio);
  2389	
  2390				/*
  2391				 * huge_pmd_unshare may unmap an entire PMD page.
  2392				 * There is no way of knowing exactly which PMDs may
  2393				 * be cached for this mm, so we must flush them all.
  2394				 * start/end were already adjusted above to cover this
  2395				 * range.
  2396				 */
  2397				flush_cache_range(vma, range.start, range.end);
  2398	
  2399				/*
  2400				 * To call huge_pmd_unshare, i_mmap_rwsem must be
  2401				 * held in write mode.  Caller needs to explicitly
  2402				 * do this outside rmap routines.
  2403				 *
  2404				 * We also must hold hugetlb vma_lock in write mode.
  2405				 * Lock order dictates acquiring vma_lock BEFORE
  2406				 * i_mmap_rwsem.  We can only try lock here and
  2407				 * fail if unsuccessful.
  2408				 */
  2409				if (!anon) {
  2410					VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
  2411					if (!hugetlb_vma_trylock_write(vma)) {
  2412						page_vma_mapped_walk_done(&pvmw);
  2413						ret = false;
  2414						break;
  2415					}
  2416					if (huge_pmd_unshare(mm, vma, address, pvmw.pte)) {
  2417						hugetlb_vma_unlock_write(vma);
  2418						flush_tlb_range(vma,
  2419							range.start, range.end);
  2420	
  2421						/*
  2422						 * The ref count of the PMD page was
  2423						 * dropped which is part of the way map
  2424						 * counting is done for shared PMDs.
  2425						 * Return 'true' here.  When there is
  2426						 * no other sharing, huge_pmd_unshare
  2427						 * returns false and we will unmap the
  2428						 * actual page and drop map count
  2429						 * to zero.
  2430						 */
  2431						page_vma_mapped_walk_done(&pvmw);
  2432						break;
  2433					}
  2434					hugetlb_vma_unlock_write(vma);
  2435				}
  2436				/* Nuke the hugetlb page table entry */
  2437				pteval = huge_ptep_clear_flush(vma, address, pvmw.pte);
  2438				if (pte_dirty(pteval))
  2439					folio_mark_dirty(folio);
  2440				writable = pte_write(pteval);
  2441			} else if (likely(pte_present(pteval))) {
  2442				flush_cache_page(vma, address, pfn);
  2443				/* Nuke the page table entry. */
  2444				if (should_defer_flush(mm, flags)) {
  2445					/*
  2446					 * We clear the PTE but do not flush so potentially
  2447					 * a remote CPU could still be writing to the folio.
  2448					 * If the entry was previously clean then the
  2449					 * architecture must guarantee that a clear->dirty
  2450					 * transition on a cached TLB entry is written through
  2451					 * and traps if the PTE is unmapped.
  2452					 */
  2453					pteval = ptep_get_and_clear(mm, address, pvmw.pte);
  2454	
  2455					set_tlb_ubc_flush_pending(mm, pteval, address, address + PAGE_SIZE);
  2456				} else {
  2457					pteval = ptep_clear_flush(vma, address, pvmw.pte);
  2458				}
  2459				if (pte_dirty(pteval))
  2460					folio_mark_dirty(folio);
  2461				writable = pte_write(pteval);
  2462			} else {
  2463				pte_clear(mm, address, pvmw.pte);
  2464				writable = is_writable_device_private_entry(pte_to_swp_entry(pteval));
  2465			}
  2466	
  2467			VM_WARN_ON_FOLIO(writable && folio_test_anon(folio) &&
  2468					!anon_exclusive, folio);
  2469	
  2470			/* Update high watermark before we lower rss */
  2471			update_hiwater_rss(mm);
  2472	
  2473			if (PageHWPoison(subpage)) {
  2474				VM_WARN_ON_FOLIO(folio_is_device_private(folio), folio);
  2475	
  2476				pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
  2477				if (folio_test_hugetlb(folio)) {
  2478					hugetlb_count_sub(folio_nr_pages(folio), mm);
  2479					set_huge_pte_at(mm, address, pvmw.pte, pteval,
  2480							hsz);
  2481				} else {
  2482					dec_mm_counter(mm, mm_counter(folio));
  2483					set_pte_at(mm, address, pvmw.pte, pteval);
  2484				}
  2485			} else if (likely(pte_present(pteval)) && pte_unused(pteval) &&
  2486				   !userfaultfd_armed(vma)) {
  2487				/*
  2488				 * The guest indicated that the page content is of no
  2489				 * interest anymore. Simply discard the pte, vmscan
  2490				 * will take care of the rest.
  2491				 * A future reference will then fault in a new zero
  2492				 * page. When userfaultfd is active, we must not drop
  2493				 * this page though, as its main user (postcopy
  2494				 * migration) will not expect userfaults on already
  2495				 * copied pages.
  2496				 */
  2497				dec_mm_counter(mm, mm_counter(folio));
  2498			} else {
  2499				swp_entry_t entry;
  2500				pte_t swp_pte;
  2501	
  2502				/*
  2503				 * arch_unmap_one() is expected to be a NOP on
  2504				 * architectures where we could have PFN swap PTEs,
  2505				 * so we'll not check/care.
  2506				 */
  2507				if (arch_unmap_one(mm, vma, address, pteval) < 0) {
  2508					if (folio_test_hugetlb(folio))
  2509						set_huge_pte_at(mm, address, pvmw.pte,
  2510								pteval, hsz);
  2511					else
  2512						set_pte_at(mm, address, pvmw.pte, pteval);
  2513					ret = false;
  2514					page_vma_mapped_walk_done(&pvmw);
  2515					break;
  2516				}
  2517	
  2518				/* See folio_try_share_anon_rmap_pte(): clear PTE first. */
  2519				if (folio_test_hugetlb(folio)) {
  2520					if (anon_exclusive &&
  2521					    hugetlb_try_share_anon_rmap(folio)) {
  2522						set_huge_pte_at(mm, address, pvmw.pte,
  2523								pteval, hsz);
  2524						ret = false;
  2525						page_vma_mapped_walk_done(&pvmw);
  2526						break;
  2527					}
  2528				} else if (anon_exclusive &&
  2529					   folio_try_share_anon_rmap_pte(folio, subpage)) {
  2530					set_pte_at(mm, address, pvmw.pte, pteval);
  2531					ret = false;
  2532					page_vma_mapped_walk_done(&pvmw);
  2533					break;
  2534				}
  2535	
  2536				/*
  2537				 * Store the pfn of the page in a special migration
  2538				 * pte. do_swap_page() will wait until the migration
  2539				 * pte is removed and then restart fault handling.
  2540				 */
  2541				if (writable)
  2542					entry = make_writable_migration_entry(
  2543								page_to_pfn(subpage));
  2544				else if (anon_exclusive)
  2545					entry = make_readable_exclusive_migration_entry(
  2546								page_to_pfn(subpage));
  2547				else
  2548					entry = make_readable_migration_entry(
  2549								page_to_pfn(subpage));
  2550				if (likely(pte_present(pteval))) {
  2551					if (pte_young(pteval))
  2552						entry = make_migration_entry_young(entry);
  2553					if (pte_dirty(pteval))
  2554						entry = make_migration_entry_dirty(entry);
  2555					swp_pte = swp_entry_to_pte(entry);
  2556					if (pte_soft_dirty(pteval))
  2557						swp_pte = pte_swp_mksoft_dirty(swp_pte);
  2558					if (pte_uffd_wp(pteval))
  2559						swp_pte = pte_swp_mkuffd_wp(swp_pte);
  2560				} else {
  2561					swp_pte = swp_entry_to_pte(entry);
  2562					if (pte_swp_soft_dirty(pteval))
  2563						swp_pte = pte_swp_mksoft_dirty(swp_pte);
  2564					if (pte_swp_uffd_wp(pteval))
  2565						swp_pte = pte_swp_mkuffd_wp(swp_pte);
  2566				}
  2567				if (folio_test_hugetlb(folio))
  2568					set_huge_pte_at(mm, address, pvmw.pte, swp_pte,
  2569							hsz);
  2570				else
  2571					set_pte_at(mm, address, pvmw.pte, swp_pte);
  2572				trace_set_migration_pte(address, pte_val(swp_pte),
  2573							folio_order(folio));
  2574				/*
  2575				 * No need to invalidate here it will synchronize on
  2576				 * against the special swap migration pte.
  2577				 */
  2578			}
  2579	
  2580			if (unlikely(folio_test_hugetlb(folio)))
  2581				hugetlb_remove_rmap(folio);
  2582			else
  2583				folio_remove_rmap_pte(folio, subpage, vma);
  2584			if (vma->vm_flags & VM_LOCKED)
  2585				mlock_drain_local();
  2586			folio_put(folio);
  2587		}
  2588	
  2589		mmu_notifier_invalidate_range_end(&range);
  2590	
  2591		return ret;
  2592	}
  2593	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


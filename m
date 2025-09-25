Return-Path: <linux-kernel+bounces-832494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0ACB9F7AD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65E4D560184
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29DC2264AA;
	Thu, 25 Sep 2025 13:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HfRh23RW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0704C13B58C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758806152; cv=none; b=F2Yquza6T8lNu4+iz/Uy1Iw4iF+Wf4Xain4/ObxzJVoNcXEUxxzFubb8pZmsPmUNtV9i/eFpIbDSquiwTDz19LT6qQQbL/x6AWKmSqPGvkz/gaiPE0jBvhswP6RIE7omr2eAtKXZGTUk3YLfW8M/4ezqHHuiWaQ1h3nrBFYgMW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758806152; c=relaxed/simple;
	bh=kMx3O1w40yOeQReQlt831IU30eN0/QVbXAiRTp2LOKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPlhb3YDTsicKwf7nOe34j/mcVQ4upZlixuERFkS9ko6e4vmqUMRTi4DpgLUHCcw6Z/rL0dMn+8TJ8dCQ3urZtDlQGv219PVbuS9ZW+j8736PO2BrNg0PS3FIMPMkHNDXaWmMXJ4nFYPS9+m3Y5hetQxPuB/0ViGs9GnFExuVFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HfRh23RW; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758806151; x=1790342151;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kMx3O1w40yOeQReQlt831IU30eN0/QVbXAiRTp2LOKk=;
  b=HfRh23RW+RFBf5sCUiRSwvBenvYkGSWDU8CXTKQzkNhKHoKKK0T/HZUl
   n5gNrz1YHMXWlixG4oRwQRa8W+9WbmLD6sey9NOpvKXNvgV/I+oTx/+mK
   OlYgvtgw/MoAj70JlqwTj6kBLBXPfr8mma5cOIn1kHvzAO0VN6jvXmfiH
   hqfj9xUY1wFJotb3bDuMRZOMNJ7N7MFwvTHHONzT6UVzlo2XKnUYDyDNO
   1E76WrzEOSkgb16CrvCMS6uGewaDHoaMi7oCppNERGVz/nmpkfO1AHYcI
   MYEZ/oS6UjHktdJgJMr/UkRwcmhadYVS1CZPgZJXblt090iJtoH8wSww9
   g==;
X-CSE-ConnectionGUID: 6uVIG+yIREawgqPZk4zCOQ==
X-CSE-MsgGUID: VFDsTIL3QHil4dCr9N9UdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="86568018"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="86568018"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 06:15:50 -0700
X-CSE-ConnectionGUID: qTgriWMkTjOhbLMgBGam6Q==
X-CSE-MsgGUID: ffU6NF5xSM2kcjLDra7sWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="181614505"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 25 Sep 2025 06:15:43 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v1lov-0005FF-0n;
	Thu, 25 Sep 2025 13:15:40 +0000
Date: Thu, 25 Sep 2025 21:15:18 +0800
From: kernel test robot <lkp@intel.com>
To: Brendan Jackman <jackmanb@google.com>,
	Andy Lutomirski <luto@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	peterz@infradead.org, bp@alien8.de, dave.hansen@linux.intel.com,
	mingo@redhat.com, tglx@linutronix.de, akpm@linux-foundation.org,
	david@redhat.com, derkling@google.com, junaids@google.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, reijiw@google.com,
	rientjes@google.com, rppt@kernel.org, vbabka@suse.cz,
	x86@kernel.org, yosry.ahmed@linux.dev
Subject: Re: [PATCH 11/21] mm: introduce freetype_t
Message-ID: <202509252109.X3oqS16b-lkp@intel.com>
References: <20250924-b4-asi-page-alloc-v1-11-2d861768041f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-b4-asi-page-alloc-v1-11-2d861768041f@google.com>

Hi Brendan,

kernel test robot noticed the following build errors:

[auto build test ERROR on bf2602a3cb2381fb1a04bf1c39a290518d2538d1]

url:    https://github.com/intel-lab-lkp/linux/commits/Brendan-Jackman/x86-mm-asi-Add-CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION/20250924-230633
base:   bf2602a3cb2381fb1a04bf1c39a290518d2538d1
patch link:    https://lore.kernel.org/r/20250924-b4-asi-page-alloc-v1-11-2d861768041f%40google.com
patch subject: [PATCH 11/21] mm: introduce freetype_t
config: i386-buildonly-randconfig-001-20250925 (https://download.01.org/0day-ci/archive/20250925/202509252109.X3oqS16b-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250925/202509252109.X3oqS16b-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509252109.X3oqS16b-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/compaction.c:2319:7: error: use of undeclared identifier 'migratetype'; did you mean 'migrate_pfn'?
    2319 |                 if (migratetype == MIGRATE_MOVABLE &&
         |                     ^~~~~~~~~~~
         |                     migrate_pfn
   include/linux/migrate.h:137:29: note: 'migrate_pfn' declared here
     137 | static inline unsigned long migrate_pfn(unsigned long pfn)
         |                             ^
   1 error generated.


vim +2319 mm/compaction.c

facdaa917c4d5a3 Nitin Gupta        2020-08-11  2234  
40cacbcb3240362 Mel Gorman         2019-03-05  2235  static enum compact_result __compact_finished(struct compact_control *cc)
748446bb6b5a939 Mel Gorman         2010-05-24  2236  {
8fb74b9fb2b182d Mel Gorman         2013-01-11  2237  	unsigned int order;
fb432f7fe43d9fb Brendan Jackman    2025-09-24  2238  	const freetype_t freetype = cc->freetype;
cb2dcaf023c2cf1 Mel Gorman         2019-03-05  2239  	int ret;
748446bb6b5a939 Mel Gorman         2010-05-24  2240  
753341a4b85ff33 Mel Gorman         2012-10-08  2241  	/* Compaction run completes if the migrate and free scanner meet */
f2849aa09d4fbc4 Vlastimil Babka    2015-09-08  2242  	if (compact_scanners_met(cc)) {
55b7c4c99f6a448 Vlastimil Babka    2014-01-21  2243  		/* Let the next compaction start anew. */
40cacbcb3240362 Mel Gorman         2019-03-05  2244  		reset_cached_positions(cc->zone);
55b7c4c99f6a448 Vlastimil Babka    2014-01-21  2245  
62997027ca5b3d4 Mel Gorman         2012-10-08  2246  		/*
62997027ca5b3d4 Mel Gorman         2012-10-08  2247  		 * Mark that the PG_migrate_skip information should be cleared
accf62422b3a67f Vlastimil Babka    2016-03-17  2248  		 * by kswapd when it goes to sleep. kcompactd does not set the
62997027ca5b3d4 Mel Gorman         2012-10-08  2249  		 * flag itself as the decision to be clear should be directly
62997027ca5b3d4 Mel Gorman         2012-10-08  2250  		 * based on an allocation request.
62997027ca5b3d4 Mel Gorman         2012-10-08  2251  		 */
accf62422b3a67f Vlastimil Babka    2016-03-17  2252  		if (cc->direct_compaction)
40cacbcb3240362 Mel Gorman         2019-03-05  2253  			cc->zone->compact_blockskip_flush = true;
62997027ca5b3d4 Mel Gorman         2012-10-08  2254  
c8f7de0bfae36e8 Michal Hocko       2016-05-20  2255  		if (cc->whole_zone)
748446bb6b5a939 Mel Gorman         2010-05-24  2256  			return COMPACT_COMPLETE;
c8f7de0bfae36e8 Michal Hocko       2016-05-20  2257  		else
c8f7de0bfae36e8 Michal Hocko       2016-05-20  2258  			return COMPACT_PARTIAL_SKIPPED;
bb13ffeb9f6bfeb Mel Gorman         2012-10-08  2259  	}
748446bb6b5a939 Mel Gorman         2010-05-24  2260  
facdaa917c4d5a3 Nitin Gupta        2020-08-11  2261  	if (cc->proactive_compaction) {
facdaa917c4d5a3 Nitin Gupta        2020-08-11  2262  		int score, wmark_low;
facdaa917c4d5a3 Nitin Gupta        2020-08-11  2263  		pg_data_t *pgdat;
facdaa917c4d5a3 Nitin Gupta        2020-08-11  2264  
facdaa917c4d5a3 Nitin Gupta        2020-08-11  2265  		pgdat = cc->zone->zone_pgdat;
facdaa917c4d5a3 Nitin Gupta        2020-08-11  2266  		if (kswapd_is_running(pgdat))
facdaa917c4d5a3 Nitin Gupta        2020-08-11  2267  			return COMPACT_PARTIAL_SKIPPED;
facdaa917c4d5a3 Nitin Gupta        2020-08-11  2268  
facdaa917c4d5a3 Nitin Gupta        2020-08-11  2269  		score = fragmentation_score_zone(cc->zone);
8fbb92bd10be26d Kemeng Shi         2023-08-09  2270  		wmark_low = fragmentation_score_wmark(true);
facdaa917c4d5a3 Nitin Gupta        2020-08-11  2271  
facdaa917c4d5a3 Nitin Gupta        2020-08-11  2272  		if (score > wmark_low)
facdaa917c4d5a3 Nitin Gupta        2020-08-11  2273  			ret = COMPACT_CONTINUE;
facdaa917c4d5a3 Nitin Gupta        2020-08-11  2274  		else
facdaa917c4d5a3 Nitin Gupta        2020-08-11  2275  			ret = COMPACT_SUCCESS;
facdaa917c4d5a3 Nitin Gupta        2020-08-11  2276  
facdaa917c4d5a3 Nitin Gupta        2020-08-11  2277  		goto out;
facdaa917c4d5a3 Nitin Gupta        2020-08-11  2278  	}
facdaa917c4d5a3 Nitin Gupta        2020-08-11  2279  
21c527a3cba07f9 Yaowei Bai         2015-11-05  2280  	if (is_via_compact_memory(cc->order))
56de7263fcf3eb1 Mel Gorman         2010-05-24  2281  		return COMPACT_CONTINUE;
56de7263fcf3eb1 Mel Gorman         2010-05-24  2282  
baf6a9a1db5a40e Vlastimil Babka    2017-05-08  2283  	/*
efe771c7603bc52 Mel Gorman         2019-03-05  2284  	 * Always finish scanning a pageblock to reduce the possibility of
efe771c7603bc52 Mel Gorman         2019-03-05  2285  	 * fallbacks in the future. This is particularly important when
efe771c7603bc52 Mel Gorman         2019-03-05  2286  	 * migration source is unmovable/reclaimable but it's not worth
efe771c7603bc52 Mel Gorman         2019-03-05  2287  	 * special casing.
baf6a9a1db5a40e Vlastimil Babka    2017-05-08  2288  	 */
ee0913c47196102 Kefeng Wang        2022-09-07  2289  	if (!pageblock_aligned(cc->migrate_pfn))
baf6a9a1db5a40e Vlastimil Babka    2017-05-08  2290  		return COMPACT_CONTINUE;
baf6a9a1db5a40e Vlastimil Babka    2017-05-08  2291  
a211c6550efcc87 Johannes Weiner    2025-03-13  2292  	/*
a211c6550efcc87 Johannes Weiner    2025-03-13  2293  	 * When defrag_mode is enabled, make kcompactd target
a211c6550efcc87 Johannes Weiner    2025-03-13  2294  	 * watermarks in whole pageblocks. Because they can be stolen
a211c6550efcc87 Johannes Weiner    2025-03-13  2295  	 * without polluting, no further fallback checks are needed.
a211c6550efcc87 Johannes Weiner    2025-03-13  2296  	 */
a211c6550efcc87 Johannes Weiner    2025-03-13  2297  	if (defrag_mode && !cc->direct_compaction) {
a211c6550efcc87 Johannes Weiner    2025-03-13  2298  		if (__zone_watermark_ok(cc->zone, cc->order,
a211c6550efcc87 Johannes Weiner    2025-03-13  2299  					high_wmark_pages(cc->zone),
a211c6550efcc87 Johannes Weiner    2025-03-13  2300  					cc->highest_zoneidx, cc->alloc_flags,
a211c6550efcc87 Johannes Weiner    2025-03-13  2301  					zone_page_state(cc->zone,
a211c6550efcc87 Johannes Weiner    2025-03-13  2302  							NR_FREE_PAGES_BLOCKS)))
a211c6550efcc87 Johannes Weiner    2025-03-13  2303  			return COMPACT_SUCCESS;
a211c6550efcc87 Johannes Weiner    2025-03-13  2304  
a211c6550efcc87 Johannes Weiner    2025-03-13  2305  		return COMPACT_CONTINUE;
a211c6550efcc87 Johannes Weiner    2025-03-13  2306  	}
a211c6550efcc87 Johannes Weiner    2025-03-13  2307  
56de7263fcf3eb1 Mel Gorman         2010-05-24  2308  	/* Direct compactor: Is a suitable page free? */
cb2dcaf023c2cf1 Mel Gorman         2019-03-05  2309  	ret = COMPACT_NO_SUITABLE_PAGE;
fd37721803c6e73 Kirill A. Shutemov 2023-12-28  2310  	for (order = cc->order; order < NR_PAGE_ORDERS; order++) {
40cacbcb3240362 Mel Gorman         2019-03-05  2311  		struct free_area *area = &cc->zone->free_area[order];
8fb74b9fb2b182d Mel Gorman         2013-01-11  2312  
fb432f7fe43d9fb Brendan Jackman    2025-09-24  2313  		/* Job done if page is free of the right freetype */
fb432f7fe43d9fb Brendan Jackman    2025-09-24  2314  		if (!free_area_empty(area, freetype))
cf378319d335663 Vlastimil Babka    2016-10-07  2315  			return COMPACT_SUCCESS;
56de7263fcf3eb1 Mel Gorman         2010-05-24  2316  
2149cdaef6c0eb5 Joonsoo Kim        2015-04-14  2317  #ifdef CONFIG_CMA
2149cdaef6c0eb5 Joonsoo Kim        2015-04-14  2318  		/* MIGRATE_MOVABLE can fallback on MIGRATE_CMA */
2149cdaef6c0eb5 Joonsoo Kim        2015-04-14 @2319  		if (migratetype == MIGRATE_MOVABLE &&
fb432f7fe43d9fb Brendan Jackman    2025-09-24  2320  		    !free_areas_empty(area, MIGRATE_CMA))
cf378319d335663 Vlastimil Babka    2016-10-07  2321  			return COMPACT_SUCCESS;
2149cdaef6c0eb5 Joonsoo Kim        2015-04-14  2322  #endif
2149cdaef6c0eb5 Joonsoo Kim        2015-04-14  2323  		/*
2149cdaef6c0eb5 Joonsoo Kim        2015-04-14  2324  		 * Job done if allocation would steal freepages from
fb432f7fe43d9fb Brendan Jackman    2025-09-24  2325  		 * other freetype buddy lists.
2149cdaef6c0eb5 Joonsoo Kim        2015-04-14  2326  		 */
fb432f7fe43d9fb Brendan Jackman    2025-09-24  2327  		if (find_suitable_fallback(area, order, freetype, true) >= 0)
baf6a9a1db5a40e Vlastimil Babka    2017-05-08  2328  			/*
fb432f7fe43d9fb Brendan Jackman    2025-09-24  2329  			 * Movable pages are OK in any pageblock of the right
fb432f7fe43d9fb Brendan Jackman    2025-09-24  2330  			 * sensitivity. If we are * stealing for a
fb432f7fe43d9fb Brendan Jackman    2025-09-24  2331  			 * non-movable allocation, make sure
fa599c44987df43 Miaohe Lin         2022-04-28  2332  			 * we finish compacting the current pageblock first
fa599c44987df43 Miaohe Lin         2022-04-28  2333  			 * (which is assured by the above migrate_pfn align
fa599c44987df43 Miaohe Lin         2022-04-28  2334  			 * check) so it is as free as possible and we won't
fa599c44987df43 Miaohe Lin         2022-04-28  2335  			 * have to steal another one soon.
baf6a9a1db5a40e Vlastimil Babka    2017-05-08  2336  			 */
baf6a9a1db5a40e Vlastimil Babka    2017-05-08  2337  			return COMPACT_SUCCESS;
baf6a9a1db5a40e Vlastimil Babka    2017-05-08  2338  	}
baf6a9a1db5a40e Vlastimil Babka    2017-05-08  2339  
facdaa917c4d5a3 Nitin Gupta        2020-08-11  2340  out:
cb2dcaf023c2cf1 Mel Gorman         2019-03-05  2341  	if (cc->contended || fatal_signal_pending(current))
cb2dcaf023c2cf1 Mel Gorman         2019-03-05  2342  		ret = COMPACT_CONTENDED;
cb2dcaf023c2cf1 Mel Gorman         2019-03-05  2343  
cb2dcaf023c2cf1 Mel Gorman         2019-03-05  2344  	return ret;
837d026d560c5ef Joonsoo Kim        2015-02-11  2345  }
837d026d560c5ef Joonsoo Kim        2015-02-11  2346  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


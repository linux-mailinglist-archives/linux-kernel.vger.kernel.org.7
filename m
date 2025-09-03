Return-Path: <linux-kernel+bounces-798192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BB2B41A82
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9265D5641D7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F81D2701D9;
	Wed,  3 Sep 2025 09:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jHw1hgDZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B0E26B95B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 09:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756892985; cv=none; b=d8fKdtvd8mrrclmD3c1ibP9RADtf0ueV61E2h7/pbqNbvSoLu7o6xusjs36b41Ow+OiFtAJkQ9GJrh/4egUl9U64g1GbVv/7rENrrVJF+LVAJhbGP8xj6vD/Yq0wFDAnYCwsaA/Ik3VzjIMY7T37NF4qwj0ZS3sPqbI221SO8SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756892985; c=relaxed/simple;
	bh=/GXQxrq4olsaQZF0tYUyMIdCmN1wPnFvKRAgcOdpAvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZfvkHy5Q6DoxQj75uPKR0301fsoS08Lq3z0grgcYMo3IjGQLTz8pLqdilY1BvbifoYZEUYLcm4LvbEtZTocK/iaql+lLAkTDaDJYiIzn0BYYKdHwLlPWD5fCvQs2O86O4FrrV9CosQ12zhCTLuyR5oRbOheO++vtHiAx/TQT+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jHw1hgDZ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756892983; x=1788428983;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/GXQxrq4olsaQZF0tYUyMIdCmN1wPnFvKRAgcOdpAvM=;
  b=jHw1hgDZZw2ED9GeNEFJA/gfxnOy2uGfgqz4aGNhrdA2/4/IjYNVmLA5
   d9mv7w0lweZT8/ldbTU+DqL+xnAHZJY+n8xKClpRH0d5tP0IpX8bz5dlj
   yZzFvKRsKn8xLwJMc0NwP6KtoVygeaosWhHxWYidnIdJi4TsvaR+kxGcW
   k25mV3Ys42wx2dS3ZCXGX7vpKGeyoDQ7LDdubEBhkYLIA3174Mp8e/j1j
   Dgm1wXLkYeo7RO3mlk0zjYz1HK4CiX3ChRuDKb0j9h+fi6fiFYRAzGSBa
   cwVhhdLDo0qdp9ggHov46PR7omEfOnZyEIhJy76UPOWERqHvJrRhb4Vmm
   Q==;
X-CSE-ConnectionGUID: 5VHN1XxRSk6MFRBo9ZPBWA==
X-CSE-MsgGUID: q89vjHnxQVqPMyv7xfkabg==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="46774649"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="46774649"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 02:49:42 -0700
X-CSE-ConnectionGUID: pySSvOT5SSeshVvcZ+dbcw==
X-CSE-MsgGUID: ecH8QOpuQ46rlnkuzuD9Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="172006550"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 03 Sep 2025 02:49:35 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1utk6m-0003il-0P;
	Wed, 03 Sep 2025 09:49:09 +0000
Date: Wed, 3 Sep 2025 17:47:35 +0800
From: kernel test robot <lkp@intel.com>
To: Yueyang Pan <pyyjason@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Vishal Moola <vishal.moola@gmail.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Usama Arif <usamaarif642@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	kernel-team@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm/show_mem: Add trylock while printing alloc info
Message-ID: <202509031744.HcibSETe-lkp@intel.com>
References: <1491df0ac12a7626b7c9b00e26a6e10adb8c9045.1756827906.git.pyyjason@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1491df0ac12a7626b7c9b00e26a6e10adb8c9045.1756827906.git.pyyjason@gmail.com>

Hi Yueyang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Yueyang-Pan/mm-show_mem-Dump-the-status-of-the-mem-alloc-profiling-before-printing/20250903-000616
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/1491df0ac12a7626b7c9b00e26a6e10adb8c9045.1756827906.git.pyyjason%40gmail.com
patch subject: [PATCH v2 2/2] mm/show_mem: Add trylock while printing alloc info
config: i386-buildonly-randconfig-001-20250903 (https://download.01.org/0day-ci/archive/20250903/202509031744.HcibSETe-lkp@intel.com/config)
compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250903/202509031744.HcibSETe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509031744.HcibSETe-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from mm/show_mem.c:18:
   mm/show_mem.c: In function 'show_free_areas':
   mm/show_mem.c:336:49: error: 'NR_ZSPAGES' undeclared (first use in this function); did you mean 'NR_STATS'?
     336 |                         K(zone_page_state(zone, NR_ZSPAGES)),
         |                                                 ^~~~~~~~~~
   mm/internal.h:560:16: note: in definition of macro 'K'
     560 | #define K(x) ((x) << (PAGE_SHIFT-10))
         |                ^
   include/linux/printk.h:512:26: note: in expansion of macro 'printk_index_wrap'
     512 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                          ^~~~~~~~~~~~~~~~~
   mm/show_mem.c:298:17: note: in expansion of macro 'printk'
     298 |                 printk(KERN_CONT
         |                 ^~~~~~
   mm/show_mem.c:336:49: note: each undeclared identifier is reported only once for each function it appears in
     336 |                         K(zone_page_state(zone, NR_ZSPAGES)),
         |                                                 ^~~~~~~~~~
   mm/internal.h:560:16: note: in definition of macro 'K'
     560 | #define K(x) ((x) << (PAGE_SHIFT-10))
         |                ^
   include/linux/printk.h:512:26: note: in expansion of macro 'printk_index_wrap'
     512 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                          ^~~~~~~~~~~~~~~~~
   mm/show_mem.c:298:17: note: in expansion of macro 'printk'
     298 |                 printk(KERN_CONT
         |                 ^~~~~~
   In file included from include/linux/spinlock.h:89,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:7,
                    from include/linux/highmem.h:5,
                    from include/linux/bvec.h:10,
                    from include/linux/blk_types.h:10,
                    from include/linux/blkdev.h:9,
                    from mm/show_mem.c:8:
   mm/show_mem.c: In function '__show_mem':
>> mm/show_mem.c:399:32: warning: unused variable 'mem_alloc_profiling_spinlock' [-Wunused-variable]
     399 |         static DEFINE_SPINLOCK(mem_alloc_profiling_spinlock);
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_types.h:43:44: note: in definition of macro 'DEFINE_SPINLOCK'
      43 | #define DEFINE_SPINLOCK(x)      spinlock_t x = __SPIN_LOCK_UNLOCKED(x)
         |                                            ^


vim +/mem_alloc_profiling_spinlock +399 mm/show_mem.c

   396	
   397	void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
   398	{
 > 399		static DEFINE_SPINLOCK(mem_alloc_profiling_spinlock);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


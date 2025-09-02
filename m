Return-Path: <linux-kernel+bounces-797257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9FEB40E0B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 21:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0CDC563749
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE86434F491;
	Tue,  2 Sep 2025 19:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XHKQi/Ip"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AD32E7161
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 19:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756842405; cv=none; b=AXdBwBZE0I8Jk50jgxa58r4cHsp6Wqkn36FsE9Vu7l+2AFGNLV0QE7hF6bafgBkInp73TXflurhOseixICtH54aiuoTL/Op0ol1a/BbN5R/futjHUUO8Sj9bbvgUJdLDQP2ymyx/oUH8o0OoOGd0dGb8KCH91v08MGfRDMCsgF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756842405; c=relaxed/simple;
	bh=zRy0DAZFgMiP7GYmxbyjuD/eGzMInt5FBbU+Nye7QrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7VwR8HDqpJ+jpsCMDsOv40H7w3hXdWhjdO0dY3TlSLjuy5zsKnqD8CyHuhJ/zLeyGha8vM2mgN+AYnFcnPl6HHNw7ckCqX0ysEhopg9825381O6wOUshXbgrIK0FS6JAxLAkRpaZ90ZLkD2IBNS3QqAYqzwDu3ugtwcDpJvAPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XHKQi/Ip; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756842403; x=1788378403;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zRy0DAZFgMiP7GYmxbyjuD/eGzMInt5FBbU+Nye7QrI=;
  b=XHKQi/Ippr4ARTprSxtnnDrl5hh8znze5MdMVyk+MewP2+HFdtHyOu9x
   rDIAz6HhfB90yihwBMX+S35ygPtj+IGMyvZdRtnGcpxQKg3Ei31mU5OrT
   eOQLpQQ29jgUzmNnvfMyAa9Jwu8m0+aeD/icu5z0azloRthBAp5SRw9vg
   ZWT7bMmTJJIY8mg/RjCxr4WUjK8tk+BxHcuWiQGVK3gbYXh0fzyhrj1aK
   TtLmcr2XF2aEYTa+vIWHfltS1WjOqdA1V2LJEsUlih1QqVtVJMGOv7VHj
   arZh1CbkqXjBiEeEFz4DCAuLkJE21o53fH1BmNVL7ol7A4f0/533pV6IZ
   Q==;
X-CSE-ConnectionGUID: pp0MgJAARbeppL5f9+fCvw==
X-CSE-MsgGUID: f60m7bCiShWwqEkWQgWWgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62966107"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62966107"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 12:46:43 -0700
X-CSE-ConnectionGUID: x2st/9FlRMSZvdRndu6cOw==
X-CSE-MsgGUID: uZoPtHYqQOGE70FRtVBomA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="170645854"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 02 Sep 2025 12:46:39 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1utWxf-0002yb-2t;
	Tue, 02 Sep 2025 19:46:35 +0000
Date: Wed, 3 Sep 2025 03:46:23 +0800
From: kernel test robot <lkp@intel.com>
To: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, x86@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, akpm@linux-foundation.org,
	david@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org,
	peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
	tglx@linutronix.de, willy@infradead.org, raghavendra.kt@amd.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
	ankur.a.arora@oracle.com
Subject: Re: [PATCH v6 13/15] mm: memory: support clearing page ranges
Message-ID: <202509030344.SZCI0AIf-lkp@intel.com>
References: <20250902080816.3715913-14-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902080816.3715913-14-ankur.a.arora@oracle.com>

Hi Ankur,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Ankur-Arora/perf-bench-mem-Remove-repetition-around-time-measurement/20250902-161417
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250902080816.3715913-14-ankur.a.arora%40oracle.com
patch subject: [PATCH v6 13/15] mm: memory: support clearing page ranges
config: i386-randconfig-014-20250903 (https://download.01.org/0day-ci/archive/20250903/202509030344.SZCI0AIf-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250903/202509030344.SZCI0AIf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509030344.SZCI0AIf-lkp@intel.com/

All warnings (new ones prefixed by >>):

   mm/memory.c: In function 'clear_contig_highpages':
   mm/memory.c:7165:38: error: implicit declaration of function 'nth_page'; did you mean 'pte_page'? [-Werror=implicit-function-declaration]
    7165 |                 clear_user_highpages(nth_page(page, i),
         |                                      ^~~~~~~~
         |                                      pte_page
>> mm/memory.c:7165:38: warning: passing argument 1 of 'clear_user_highpages' makes pointer from integer without a cast [-Wint-conversion]
    7165 |                 clear_user_highpages(nth_page(page, i),
         |                                      ^~~~~~~~~~~~~~~~~
         |                                      |
         |                                      int
   In file included from include/linux/bvec.h:10,
                    from include/linux/blk_types.h:10,
                    from include/linux/writeback.h:13,
                    from include/linux/memcontrol.h:23,
                    from include/linux/swap.h:9,
                    from include/linux/mm_inline.h:8,
                    from mm/memory.c:44:
   include/linux/highmem.h:211:54: note: expected 'struct page *' but argument is of type 'int'
     211 | static inline void clear_user_highpages(struct page *page, unsigned long vaddr,
         |                                         ~~~~~~~~~~~~~^~~~
   cc1: some warnings being treated as errors


vim +/clear_user_highpages +7165 mm/memory.c

  7151	
  7152	/*
  7153	 * Clear contiguous pages chunking them up when running under
  7154	 * non-preemptible models.
  7155	 */
  7156	static void clear_contig_highpages(struct page *page, unsigned long addr,
  7157					   unsigned int npages)
  7158	{
  7159		unsigned int i, count, unit;
  7160	
  7161		unit = preempt_model_preemptible() ? npages : PAGE_CONTIG_NR;
  7162	
  7163		for (i = 0; i < npages; ) {
  7164			count = min(unit, npages - i);
> 7165			clear_user_highpages(nth_page(page, i),
  7166					     addr + i * PAGE_SIZE, count);
  7167			i += count;
  7168			cond_resched();
  7169		}
  7170	}
  7171	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


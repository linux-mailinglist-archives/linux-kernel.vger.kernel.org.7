Return-Path: <linux-kernel+bounces-797270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6A1B40E36
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 21:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 912DF5E2550
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E6F35207A;
	Tue,  2 Sep 2025 19:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DC7XUSI7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E92350D4A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 19:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756843071; cv=none; b=uIZdQTCJ+pdE38qZSqe3Vo97/apMkeQK16yAJG21S2yiG+r0RGkUbycA2aXPFlMlH3px1Xrn4dqRaMfBTJCCusIc7t8dQwHRYtp1j/sj6R1p026yg5acf++jg8ojJL88Isaq+tTMwAxpIp/by1w/t9d44aQEGNW7nRYX+MLjymk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756843071; c=relaxed/simple;
	bh=WG20E1PYl6zQTGosd4M112pEByXyuxZIRP6y1iHCS5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZRl/onYdH8tB955R2E0WDPULYCfRLG5Lghl+A/Z+7CfEcDjXAi+BMO/ZE67TsZxCir2Bu2ZfpSbl4T2MSKee4qaMgMlVa9kDXVUlR/Vo3XFLgX10x0jZecg42OdukdMUu0dMiqgpRNs8qgxEL3UqkkGfcyLZX6Lew/fN331074=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DC7XUSI7; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756843070; x=1788379070;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WG20E1PYl6zQTGosd4M112pEByXyuxZIRP6y1iHCS5I=;
  b=DC7XUSI7BWgxM+rvYREzOollahiqwxKD8+xRVbPbGnZGMJ30PCVMuMnh
   cauwACMfFRcMdyHPB86GP7tkfrq2255eo4xp+Ylt9xNFrkHP9cs05GdPI
   fflTTQ+oSJfanSoaEKEjzlODQLqi0ojU7fIfxp7QRWZn50rNsCi4FKlpm
   g4OqoaZpKu7Ot9B5Fv2nU8jW4GTsJlkiGnb91PNx3omLuBesYwH6QqBpm
   4bXP+AfpnNUnCY3fDgCPdXKoXD9EPfc8ESieEL4jMc27j01DuPUvVOuPv
   wk+tzLi2yO3tqv+2KU7Gi/ttv6q77R5FGxVd/n3fbGA/ugvJrj7dTTvzU
   Q==;
X-CSE-ConnectionGUID: vT0F9J+pQECYYQAbGQazUw==
X-CSE-MsgGUID: psyRDfpvRrK6Kt23caaGtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62967187"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62967187"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 12:57:50 -0700
X-CSE-ConnectionGUID: k62XfXQIQmuVDv1f8T8fmA==
X-CSE-MsgGUID: 4ImPeJBGRRiVYLHkJVP4Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="170647122"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 02 Sep 2025 12:57:45 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1utX8Q-0002z7-08;
	Tue, 02 Sep 2025 19:57:42 +0000
Date: Wed, 3 Sep 2025 03:56:55 +0800
From: kernel test robot <lkp@intel.com>
To: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, x86@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	akpm@linux-foundation.org, david@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
	mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
	acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
	willy@infradead.org, raghavendra.kt@amd.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
	ankur.a.arora@oracle.com
Subject: Re: [PATCH v6 11/15] mm: define clear_pages(), clear_user_pages()
Message-ID: <202509030341.jBuh7Fma-lkp@intel.com>
References: <20250902080816.3715913-12-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902080816.3715913-12-ankur.a.arora@oracle.com>

Hi Ankur,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Ankur-Arora/perf-bench-mem-Remove-repetition-around-time-measurement/20250902-161417
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250902080816.3715913-12-ankur.a.arora%40oracle.com
patch subject: [PATCH v6 11/15] mm: define clear_pages(), clear_user_pages()
config: arm-randconfig-002-20250903 (https://download.01.org/0day-ci/archive/20250903/202509030341.jBuh7Fma-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250903/202509030341.jBuh7Fma-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509030341.jBuh7Fma-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/arm/kernel/asm-offsets.c:12:
>> include/linux/mm.h:3886:3: error: call to undeclared function 'clear_user_page'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   clear_user_page(addr + i * PAGE_SIZE,
                   ^
   include/linux/mm.h:3886:3: note: did you mean 'clear_user_pages'?
   include/linux/mm.h:3882:20: note: 'clear_user_pages' declared here
   static inline void clear_user_pages(void *addr, unsigned long vaddr,
                      ^
   1 error generated.
   make[3]: *** [scripts/Makefile.build:182: arch/arm/kernel/asm-offsets.s] Error 1 shuffle=1003087465
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1282: prepare0] Error 2 shuffle=1003087465
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2 shuffle=1003087465
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2 shuffle=1003087465
   make: Target 'prepare' not remade because of errors.


vim +/clear_user_page +3886 include/linux/mm.h

  3880	
  3881	#ifndef clear_user_pages
  3882	static inline void clear_user_pages(void *addr, unsigned long vaddr,
  3883					    struct page *pg, unsigned int npages)
  3884	{
  3885		for (int i = 0; i < npages; i++)
> 3886			clear_user_page(addr + i * PAGE_SIZE,
  3887					vaddr + i * PAGE_SIZE, pg + i);
  3888	}
  3889	#endif
  3890	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


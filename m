Return-Path: <linux-kernel+bounces-824457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C53B8948E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DD897C4EE0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B904E30CB5D;
	Fri, 19 Sep 2025 11:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="idIRiYEs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B7F30BB92
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 11:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758281613; cv=none; b=Wv9/kEMVQfUZuzp7Q8z9fTb7lnJJRDS3WJtjOgNsKuOA/eZ5huVs/q3NuLyMrcPCoJ5CVntkEXIZ5AWlm1nC/xdz8olhlJ5pjNQcQwx6WhKcjhH2p1m/aYFUQdLSY7x2kew1jatywCY4uhHEwuSo9D2ne/YkT6Av14NO+tlJHN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758281613; c=relaxed/simple;
	bh=QKhnnAL6BDX+xxQOeAiqNh0DHBoO9yCBDNo5Ke7f/P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnC6L9gwkQ4Ls4HLCHjiuS9Evu84t4V7tPP7tV0NdSRsDEtauyNUg5dXpyqesqYPe88H/D9vlOvaz0HOb9MhzaOqgJV89+ce751dkfs/HZSwqDSluXS2/tsChCE5OLNkDKAAk+cKDYGSPRdaBh7rKc8VKRNQkRcjhl0lO0sFLXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=idIRiYEs; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758281612; x=1789817612;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QKhnnAL6BDX+xxQOeAiqNh0DHBoO9yCBDNo5Ke7f/P4=;
  b=idIRiYEspCgf21XsCrgckl8YfyrRfnpIsavt9obZQu8r2jxcHYAD3QkC
   LffPZl8c4Ax3R4l+deAUxZLGG3dwdoQFVPkbkyibJTJuFb5tHyrIA10lt
   1ZuZjWR8CFwuhvMPKqci3AL5anYCOaKR38r4C97X2PWrDHZSUrtJLGZ9i
   FdP7Dm84vb40EgcFKETwc3OpmjLxTSDcXfm42Fqg+9XAxFkN8BkcpJQlJ
   NuZnZgKFxolta6EjcmQhzY9vc83ewNs7p/uNxD86UQoGeG9YALz0PVhjs
   YFLRsXgnUlHUGK0gr1MkyTLxgE9iYXwC0cVla4XUgZ/nJhpSwlQNSjzJH
   A==;
X-CSE-ConnectionGUID: 5fVXdkCnTGG+1Kpf7a7JHQ==
X-CSE-MsgGUID: X7BV4IsoQfOTvAjrftITJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="83229919"
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="83229919"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 04:33:31 -0700
X-CSE-ConnectionGUID: dXqTEXXpQJiNyfzl15ufyQ==
X-CSE-MsgGUID: 2qrvnKEFQ2SVC6rfZhfn4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="175372303"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 19 Sep 2025 04:33:26 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uzZMh-0004Fv-1w;
	Fri, 19 Sep 2025 11:33:23 +0000
Date: Fri, 19 Sep 2025 19:33:12 +0800
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
Subject: Re: [PATCH v7 13/16] mm: memory: support clearing page ranges
Message-ID: <202509191916.a0oRRfua-lkp@intel.com>
References: <20250917152418.4077386-14-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917152418.4077386-14-ankur.a.arora@oracle.com>

Hi Ankur,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Ankur-Arora/perf-bench-mem-Remove-repetition-around-time-measurement/20250917-233045
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250917152418.4077386-14-ankur.a.arora%40oracle.com
patch subject: [PATCH v7 13/16] mm: memory: support clearing page ranges
config: arm-randconfig-001-20250919 (https://download.01.org/0day-ci/archive/20250919/202509191916.a0oRRfua-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250919/202509191916.a0oRRfua-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509191916.a0oRRfua-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from arch/arm/include/asm/thread_info.h:14,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arm/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/smp.h:116,
                    from include/linux/kernel_stat.h:5,
                    from mm/memory.c:42:
   mm/memory.c: In function 'clear_contig_highpages':
   mm/memory.c:7199:38: error: implicit declaration of function 'nth_page'; did you mean 'pte_page'? [-Werror=implicit-function-declaration]
    7199 |                 clear_user_highpages(nth_page(page, i),
         |                                      ^~~~~~~~
   arch/arm/include/asm/page.h:152:36: note: in definition of macro 'clear_user_highpage'
     152 |          __cpu_clear_user_highpage(page, vaddr)
         |                                    ^~~~
   mm/memory.c:7199:17: note: in expansion of macro 'clear_user_highpages'
    7199 |                 clear_user_highpages(nth_page(page, i),
         |                 ^~~~~~~~~~~~~~~~~~~~
>> mm/memory.c:7199:38: warning: passing argument 1 of 'cpu_user.cpu_clear_user_highpage' makes pointer from integer without a cast [-Wint-conversion]
    7199 |                 clear_user_highpages(nth_page(page, i),
         |                                      ^~~~~~~~~~~~~~~~~
         |                                      |
         |                                      int
   arch/arm/include/asm/page.h:152:36: note: in definition of macro 'clear_user_highpage'
     152 |          __cpu_clear_user_highpage(page, vaddr)
         |                                    ^~~~
   mm/memory.c:7199:17: note: in expansion of macro 'clear_user_highpages'
    7199 |                 clear_user_highpages(nth_page(page, i),
         |                 ^~~~~~~~~~~~~~~~~~~~
   mm/memory.c:7199:38: note: expected 'struct page *' but argument is of type 'int'
    7199 |                 clear_user_highpages(nth_page(page, i),
         |                                      ^~~~~~~~~~~~~~~~~
   arch/arm/include/asm/page.h:152:36: note: in definition of macro 'clear_user_highpage'
     152 |          __cpu_clear_user_highpage(page, vaddr)
         |                                    ^~~~
   mm/memory.c:7199:17: note: in expansion of macro 'clear_user_highpages'
    7199 |                 clear_user_highpages(nth_page(page, i),
         |                 ^~~~~~~~~~~~~~~~~~~~
>> arch/arm/include/asm/page.h:157:15: error: lvalue required as left operand of assignment
     157 |         vaddr += PAGE_SIZE;                             \
         |               ^~
   mm/memory.c:7199:17: note: in expansion of macro 'clear_user_highpages'
    7199 |                 clear_user_highpages(nth_page(page, i),
         |                 ^~~~~~~~~~~~~~~~~~~~
>> arch/arm/include/asm/page.h:158:13: error: lvalue required as increment operand
     158 |         page++;                                         \
         |             ^~
   mm/memory.c:7199:17: note: in expansion of macro 'clear_user_highpages'
    7199 |                 clear_user_highpages(nth_page(page, i),
         |                 ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +7199 mm/memory.c

  7185	
  7186	/*
  7187	 * Clear contiguous pages chunking them up when running under
  7188	 * non-preemptible models.
  7189	 */
  7190	static void clear_contig_highpages(struct page *page, unsigned long addr,
  7191					   unsigned int npages)
  7192	{
  7193		unsigned int i, count, unit;
  7194	
  7195		unit = preempt_model_preemptible() ? npages : PAGE_CONTIG_NR;
  7196	
  7197		for (i = 0; i < npages; ) {
  7198			count = min(unit, npages - i);
> 7199			clear_user_highpages(nth_page(page, i),
  7200					     addr + i * PAGE_SIZE, count);
  7201			i += count;
  7202			cond_resched();
  7203		}
  7204	}
  7205	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


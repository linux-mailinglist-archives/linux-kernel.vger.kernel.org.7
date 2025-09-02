Return-Path: <linux-kernel+bounces-797283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EB8B40E61
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 22:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 173AA3B2BE5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 20:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8F52EB873;
	Tue,  2 Sep 2025 20:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Asqa15kJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6122E322775
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 20:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756843844; cv=none; b=Tsk4ZXphzv4TwhV7v7j3WFnnb7zkhuzFdj0YOF91ROUb7H8e8Ih0qV+Gj8bRJw3vmeKNyfKswG2Zw8HlP8mc1WRpCHJhMzJTGAxQtBQta/rKmn6hlOt/FF815gGF6uQJe6/WWgAAR8cHrqSObjqzu0RUiniV0B1w9xC+GCEIrp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756843844; c=relaxed/simple;
	bh=YSX3ayXvCq2CuS4CQ/bYGZn6jqqI1INvzwUeD7fjKTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxMGf8AwGb+2XZx53l5QnnWr7rX+Os7tAmUnQAEjq74vEeRNTffw9h9IJaT9i20AL7og2lktVSj5oA8s4hDIzHavYThe5+wiA/5uHzNuESACfx7E5fhFwPnuI9dqkRt1YL7bcJ6AdSfrYkH5K07UH3JV67LcBtXqd+SO2mpHxXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Asqa15kJ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756843843; x=1788379843;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YSX3ayXvCq2CuS4CQ/bYGZn6jqqI1INvzwUeD7fjKTo=;
  b=Asqa15kJD/Bgyl0YwQv9+99FFAGFpMa69ZuJdT077nHncP9481DMzg+I
   I8AITMi1eNqg7TcUh9QxvnJjJkFsubpq8Nrw5DZNscQfqHuwFRjZh9C6k
   mieZwzN2lZMDKCXGqlmVVqbvoFRGMWCBoZ24c0MrvqedftTW1LlAdSPxf
   Jh24ZRCUsR0+wXMIoFddm+O1sLLcWSImMn05WU03/KjmkehZrmJWVAAXA
   5kLHA0nG9NZ4h2tQ6TPr603wIYLBRobRx35uLLjBBoqL4Qqz+SIp1Ic0V
   WSLuDuqsPAuEfXjPYbNJ2CgkkIHioX6ZiJPuVAWha87e6fV4Uz/OW5edl
   Q==;
X-CSE-ConnectionGUID: I4za+Vl8SlC5iaYFOr4hsg==
X-CSE-MsgGUID: CVrBOkPJTDW6vhTi78tkxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62968930"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62968930"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 13:10:42 -0700
X-CSE-ConnectionGUID: JqVyyvvhQ7m/l28TUMxOow==
X-CSE-MsgGUID: BlvYY114S769WpPW3JXOug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="202281602"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 02 Sep 2025 13:10:36 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1utXJx-0002zX-0W;
	Tue, 02 Sep 2025 20:09:52 +0000
Date: Wed, 3 Sep 2025 04:09:08 +0800
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
Subject: Re: [PATCH v6 11/15] mm: define clear_pages(), clear_user_pages()
Message-ID: <202509030338.DlQJTxIk-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Ankur-Arora/perf-bench-mem-Remove-repetition-around-time-measurement/20250902-161417
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250902080816.3715913-12-ankur.a.arora%40oracle.com
patch subject: [PATCH v6 11/15] mm: define clear_pages(), clear_user_pages()
config: sparc-defconfig (https://download.01.org/0day-ci/archive/20250903/202509030338.DlQJTxIk-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250903/202509030338.DlQJTxIk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509030338.DlQJTxIk-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/sparc/include/asm/page.h:8,
                    from arch/sparc/include/asm/string_32.h:13,
                    from arch/sparc/include/asm/string.h:7,
                    from include/linux/string.h:65,
                    from include/linux/bitmap.h:13,
                    from include/linux/cpumask.h:12,
                    from arch/sparc/include/asm/smp_32.h:15,
                    from arch/sparc/include/asm/smp.h:7,
                    from arch/sparc/include/asm/switch_to_32.h:5,
                    from arch/sparc/include/asm/switch_to.h:7,
                    from arch/sparc/include/asm/ptrace.h:120,
                    from arch/sparc/include/asm/thread_info_32.h:19,
                    from arch/sparc/include/asm/thread_info.h:7,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/sparc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:18,
                    from init/main.c:18:
   include/linux/mm.h: In function 'clear_user_pages':
   arch/sparc/include/asm/page_32.h:22:17: error: implicit declaration of function 'sparc_flush_page_to_ram' [-Wimplicit-function-declaration]
      22 |                 sparc_flush_page_to_ram(page);  \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mm.h:3886:17: note: in expansion of macro 'clear_user_page'
    3886 |                 clear_user_page(addr + i * PAGE_SIZE,
         |                 ^~~~~~~~~~~~~~~
   In file included from arch/sparc/include/asm/cacheflush.h:11,
                    from include/linux/cacheflush.h:5,
                    from include/linux/highmem.h:8,
                    from include/linux/bvec.h:10,
                    from include/linux/blk_types.h:10,
                    from include/linux/writeback.h:13,
                    from include/linux/memcontrol.h:23,
                    from include/linux/bpf.h:31,
                    from include/linux/security.h:35,
                    from include/linux/perf_event.h:53,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:95,
                    from init/main.c:22:
   arch/sparc/include/asm/cacheflush_32.h: At top level:
>> arch/sparc/include/asm/cacheflush_32.h:38:6: warning: conflicting types for 'sparc_flush_page_to_ram'; have 'void(struct page *)'
      38 | void sparc_flush_page_to_ram(struct page *page);
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   arch/sparc/include/asm/page_32.h:22:17: note: previous implicit declaration of 'sparc_flush_page_to_ram' with type 'void(struct page *)'
      22 |                 sparc_flush_page_to_ram(page);  \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mm.h:3886:17: note: in expansion of macro 'clear_user_page'
    3886 |                 clear_user_page(addr + i * PAGE_SIZE,
         |                 ^~~~~~~~~~~~~~~


vim +38 arch/sparc/include/asm/cacheflush_32.h

f5e706ad886b6a include/asm-sparc/cacheflush_32.h      Sam Ravnborg            2008-07-17  19  
f5e706ad886b6a include/asm-sparc/cacheflush_32.h      Sam Ravnborg            2008-07-17  20  #define copy_to_user_page(vma, page, vaddr, dst, src, len) \
f5e706ad886b6a include/asm-sparc/cacheflush_32.h      Sam Ravnborg            2008-07-17  21  	do {							\
f5e706ad886b6a include/asm-sparc/cacheflush_32.h      Sam Ravnborg            2008-07-17  22  		flush_cache_page(vma, vaddr, page_to_pfn(page));\
f5e706ad886b6a include/asm-sparc/cacheflush_32.h      Sam Ravnborg            2008-07-17  23  		memcpy(dst, src, len);				\
f5e706ad886b6a include/asm-sparc/cacheflush_32.h      Sam Ravnborg            2008-07-17  24  	} while (0)
f5e706ad886b6a include/asm-sparc/cacheflush_32.h      Sam Ravnborg            2008-07-17  25  #define copy_from_user_page(vma, page, vaddr, dst, src, len) \
f5e706ad886b6a include/asm-sparc/cacheflush_32.h      Sam Ravnborg            2008-07-17  26  	do {							\
f5e706ad886b6a include/asm-sparc/cacheflush_32.h      Sam Ravnborg            2008-07-17  27  		flush_cache_page(vma, vaddr, page_to_pfn(page));\
f5e706ad886b6a include/asm-sparc/cacheflush_32.h      Sam Ravnborg            2008-07-17  28  		memcpy(dst, src, len);				\
f5e706ad886b6a include/asm-sparc/cacheflush_32.h      Sam Ravnborg            2008-07-17  29  	} while (0)
f5e706ad886b6a include/asm-sparc/cacheflush_32.h      Sam Ravnborg            2008-07-17  30  
5d83d66635bb16 arch/sparc/include/asm/cacheflush_32.h David S. Miller         2012-05-13  31  #define __flush_page_to_ram(addr) \
5d83d66635bb16 arch/sparc/include/asm/cacheflush_32.h David S. Miller         2012-05-13  32  	sparc32_cachetlb_ops->page_to_ram(addr)
5d83d66635bb16 arch/sparc/include/asm/cacheflush_32.h David S. Miller         2012-05-13  33  #define flush_sig_insns(mm,insn_addr) \
5d83d66635bb16 arch/sparc/include/asm/cacheflush_32.h David S. Miller         2012-05-13  34  	sparc32_cachetlb_ops->sig_insns(mm, insn_addr)
5d83d66635bb16 arch/sparc/include/asm/cacheflush_32.h David S. Miller         2012-05-13  35  #define flush_page_for_dma(addr) \
5d83d66635bb16 arch/sparc/include/asm/cacheflush_32.h David S. Miller         2012-05-13  36  	sparc32_cachetlb_ops->page_for_dma(addr)
f5e706ad886b6a include/asm-sparc/cacheflush_32.h      Sam Ravnborg            2008-07-17  37  
f05a68653e56ca arch/sparc/include/asm/cacheflush_32.h Sam Ravnborg            2014-05-16 @38  void sparc_flush_page_to_ram(struct page *page);
665f640294540a arch/sparc/include/asm/cacheflush_32.h Matthew Wilcox (Oracle  2023-08-02  39) void sparc_flush_folio_to_ram(struct folio *folio);
f5e706ad886b6a include/asm-sparc/cacheflush_32.h      Sam Ravnborg            2008-07-17  40  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


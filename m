Return-Path: <linux-kernel+bounces-777025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C1EB2D434
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8DE14E34F6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 06:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E054E2222A0;
	Wed, 20 Aug 2025 06:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BQXJa2Dk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419D42EB10
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 06:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755672339; cv=none; b=kNmQmKdX8Z/dtVx3S5qV9iEI/TZTkHu8S7F+mDQK2REnrLney83vqrXdL6OHCdbfm95ocXUq0CeClpT759H6j2wT7GW0oTm11DYfBlkMe1DCcmIq6ONOlbUaxYG/a9LszCdo/rHf5YDasMrWnUmGkWtaw49kXfK2tp/kBJWt/+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755672339; c=relaxed/simple;
	bh=Aks18XLnFJDywmToiC/hQRBj84tcW/vcMhMm0McgHP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ns3xO28jhPWWWdx399d0IyDPvuZ22QDJZHSGEW99SuLcL2fg8zmmtySbqDLl8J7zQ4NV1J/uRzqoNdBuCJQazt6/4iKx9watDd+MGKa/4ToNCJgecFF7gX/izRLiPp56NwSydOD0wgVTkpRMS6zxEsOSqrUTsVb7ZYp+/HQ0B48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BQXJa2Dk; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755672337; x=1787208337;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Aks18XLnFJDywmToiC/hQRBj84tcW/vcMhMm0McgHP4=;
  b=BQXJa2DklheG1XobGiKPr7yfHJ1llIMtWEnmthEuG2o5XuQJhnZd4722
   +r4ginOFQaGSEUGnmO/3zhl+ytz6YfJNcrajthLUsCrcqJyHsMf2/LpAV
   AY3egFRSJco4Dh4wUl+GSItpo1Wcq7yRfeZICZT95j5RScDfm2Pv26g8J
   wGhpaYcSwhYgj4WUe5SxR+V93cgCBi3CsHjQpLZIG072iwUGi+hQrrmiG
   j2EfKJZV870QQCCUxmxMz5CHCiKoRlFTzHNT4iNEyO9IBiMJffcigLMXk
   eZ0wdtzvwUQ9FXwwpTLG3b716xUuWMi4WvKmGukpY/i5jjsGwaUlbnav0
   Q==;
X-CSE-ConnectionGUID: SWn3ATIRQFK8n+iioay2LA==
X-CSE-MsgGUID: Oe8TXaosTuC5XDZSAeO4xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="61745333"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="61745333"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 23:45:36 -0700
X-CSE-ConnectionGUID: oZu6t+lTTiuD65z9o2thYw==
X-CSE-MsgGUID: BZwrqRZbQTWCzxT/CDtEsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="168851444"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 19 Aug 2025 23:45:32 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uocZd-000IJH-2r;
	Wed, 20 Aug 2025 06:45:29 +0000
Date: Wed, 20 Aug 2025 14:44:54 +0800
From: kernel test robot <lkp@intel.com>
To: Yunhui Cui <cuiyunhui@bytedance.com>, yury.norov@gmail.com,
	linux@rasmusvillemoes.dk, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	dennis@kernel.org, tj@kernel.org, cl@gentwo.org, linux-mm@kvack.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Yunhui Cui <cuiyunhui@bytedance.com>
Subject: Re: [PATCH 2/2] riscv: introduce percpu.h into include/asm
Message-ID: <202508201452.ciEgfhNO-lkp@intel.com>
References: <20250819135007.85646-3-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819135007.85646-3-cuiyunhui@bytedance.com>

Hi Yunhui,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on dennis-percpu/for-next v6.17-rc2 next-20250819]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yunhui-Cui/riscv-remove-irqflags-h-inclusion-in-asm-bitops-h/20250819-215256
base:   linus/master
patch link:    https://lore.kernel.org/r/20250819135007.85646-3-cuiyunhui%40bytedance.com
patch subject: [PATCH 2/2] riscv: introduce percpu.h into include/asm
config: riscv-randconfig-002-20250820 (https://download.01.org/0day-ci/archive/20250820/202508201452.ciEgfhNO-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 93d24b6b7b148c47a2fa228a4ef31524fa1d9f3f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250820/202508201452.ciEgfhNO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508201452.ciEgfhNO-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/riscv/kernel/asm-offsets.c:8:
   In file included from include/linux/mm.h:7:
   In file included from include/linux/gfp.h:7:
   In file included from include/linux/mmzone.h:22:
   In file included from include/linux/mm_types.h:19:
   In file included from include/linux/workqueue.h:9:
>> include/linux/alloc_tag.h:219:2: warning: implicit conversion from 'typeof (tag->counters->calls)' (aka 'unsigned long long') to 'unsigned long' changes value from 18446744073709551615 to 4294967295 [-Wconstant-conversion]
     219 |         this_cpu_dec(tag->counters->calls);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:512:28: note: expanded from macro 'this_cpu_dec'
     512 | #define this_cpu_dec(pcp)               this_cpu_sub(pcp, 1)
         |                                         ^~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:510:51: note: expanded from macro 'this_cpu_sub'
     510 | #define this_cpu_sub(pcp, val)          this_cpu_add(pcp, -(typeof(pcp))(val))
         |                                         ~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:501:70: note: expanded from macro 'this_cpu_add'
     501 | #define this_cpu_add(pcp, val)          __pcpu_size_call(this_cpu_add_, pcp, val)
         |                                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
   include/linux/percpu-defs.h:372:29: note: expanded from macro '__pcpu_size_call'
     372 |                 case 8: stem##8(variable, __VA_ARGS__);break;           \
         |                         ~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
   arch/riscv/include/asm/percpu.h:96:78: note: expanded from macro 'this_cpu_add_8'
      96 | #define this_cpu_add_8(pcp, val)        _pcp_protect(__percpu_add_amo_case_64, pcp, val)
         |                                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
   arch/riscv/include/asm/percpu.h:72:26: note: expanded from macro '_pcp_protect'
      72 |         op(raw_cpu_ptr(&(pcp)), __VA_ARGS__);                           \
         |         ~~                      ^~~~~~~~~~~
   1 warning generated.
--
   In file included from arch/riscv/errata/sifive/errata.c:7:
   In file included from include/linux/memory.h:19:
   In file included from include/linux/node.h:18:
   In file included from include/linux/device.h:16:
   In file included from include/linux/energy_model.h:7:
   In file included from include/linux/kobject.h:20:
   In file included from include/linux/sysfs.h:16:
   In file included from include/linux/kernfs.h:12:
   In file included from include/linux/idr.h:15:
   In file included from include/linux/radix-tree.h:16:
   In file included from include/linux/percpu.h:5:
>> include/linux/alloc_tag.h:219:2: warning: implicit conversion from 'typeof (tag->counters->calls)' (aka 'unsigned long long') to 'unsigned long' changes value from 18446744073709551615 to 4294967295 [-Wconstant-conversion]
     219 |         this_cpu_dec(tag->counters->calls);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:512:28: note: expanded from macro 'this_cpu_dec'
     512 | #define this_cpu_dec(pcp)               this_cpu_sub(pcp, 1)
         |                                         ^~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:510:51: note: expanded from macro 'this_cpu_sub'
     510 | #define this_cpu_sub(pcp, val)          this_cpu_add(pcp, -(typeof(pcp))(val))
         |                                         ~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:501:70: note: expanded from macro 'this_cpu_add'
     501 | #define this_cpu_add(pcp, val)          __pcpu_size_call(this_cpu_add_, pcp, val)
         |                                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
   include/linux/percpu-defs.h:372:29: note: expanded from macro '__pcpu_size_call'
     372 |                 case 8: stem##8(variable, __VA_ARGS__);break;           \
         |                         ~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
   arch/riscv/include/asm/percpu.h:96:78: note: expanded from macro 'this_cpu_add_8'
      96 | #define this_cpu_add_8(pcp, val)        _pcp_protect(__percpu_add_amo_case_64, pcp, val)
         |                                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
   arch/riscv/include/asm/percpu.h:72:26: note: expanded from macro '_pcp_protect'
      72 |         op(raw_cpu_ptr(&(pcp)), __VA_ARGS__);                           \
         |         ~~                      ^~~~~~~~~~~
   arch/riscv/errata/sifive/errata.c:29:14: warning: result of comparison of constant 9223372036854775815 with expression of type 'unsigned long' is always true [-Wtautological-constant-out-of-range-compare]
      29 |         if (arch_id != 0x8000000000000007 ||
         |             ~~~~~~~ ^  ~~~~~~~~~~~~~~~~~~
   arch/riscv/errata/sifive/errata.c:42:14: warning: result of comparison of constant 9223372036854775815 with expression of type 'unsigned long' is always true [-Wtautological-constant-out-of-range-compare]
      42 |         if (arch_id != 0x8000000000000007 && arch_id != 0x1)
         |             ~~~~~~~ ^  ~~~~~~~~~~~~~~~~~~
   3 warnings generated.
--
   In file included from arch/riscv/kernel/asm-offsets.c:8:
   In file included from include/linux/mm.h:7:
   In file included from include/linux/gfp.h:7:
   In file included from include/linux/mmzone.h:22:
   In file included from include/linux/mm_types.h:19:
   In file included from include/linux/workqueue.h:9:
>> include/linux/alloc_tag.h:219:2: warning: implicit conversion from 'typeof (tag->counters->calls)' (aka 'unsigned long long') to 'unsigned long' changes value from 18446744073709551615 to 4294967295 [-Wconstant-conversion]
     219 |         this_cpu_dec(tag->counters->calls);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:512:28: note: expanded from macro 'this_cpu_dec'
     512 | #define this_cpu_dec(pcp)               this_cpu_sub(pcp, 1)
         |                                         ^~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:510:51: note: expanded from macro 'this_cpu_sub'
     510 | #define this_cpu_sub(pcp, val)          this_cpu_add(pcp, -(typeof(pcp))(val))
         |                                         ~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:501:70: note: expanded from macro 'this_cpu_add'
     501 | #define this_cpu_add(pcp, val)          __pcpu_size_call(this_cpu_add_, pcp, val)
         |                                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
   include/linux/percpu-defs.h:372:29: note: expanded from macro '__pcpu_size_call'
     372 |                 case 8: stem##8(variable, __VA_ARGS__);break;           \
         |                         ~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
   arch/riscv/include/asm/percpu.h:96:78: note: expanded from macro 'this_cpu_add_8'
      96 | #define this_cpu_add_8(pcp, val)        _pcp_protect(__percpu_add_amo_case_64, pcp, val)
         |                                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
   arch/riscv/include/asm/percpu.h:72:26: note: expanded from macro '_pcp_protect'
      72 |         op(raw_cpu_ptr(&(pcp)), __VA_ARGS__);                           \
         |         ~~                      ^~~~~~~~~~~
   1 warning generated.


vim +219 include/linux/alloc_tag.h

22d407b164ff79 Suren Baghdasaryan 2024-03-21  202  
22d407b164ff79 Suren Baghdasaryan 2024-03-21  203  static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes)
22d407b164ff79 Suren Baghdasaryan 2024-03-21  204  {
22d407b164ff79 Suren Baghdasaryan 2024-03-21  205  	struct alloc_tag *tag;
22d407b164ff79 Suren Baghdasaryan 2024-03-21  206  
22d407b164ff79 Suren Baghdasaryan 2024-03-21  207  	alloc_tag_sub_check(ref);
22d407b164ff79 Suren Baghdasaryan 2024-03-21  208  	if (!ref || !ref->ct)
22d407b164ff79 Suren Baghdasaryan 2024-03-21  209  		return;
22d407b164ff79 Suren Baghdasaryan 2024-03-21  210  
239d6c96d86f8a Suren Baghdasaryan 2024-03-21  211  	if (is_codetag_empty(ref)) {
239d6c96d86f8a Suren Baghdasaryan 2024-03-21  212  		ref->ct = NULL;
239d6c96d86f8a Suren Baghdasaryan 2024-03-21  213  		return;
239d6c96d86f8a Suren Baghdasaryan 2024-03-21  214  	}
239d6c96d86f8a Suren Baghdasaryan 2024-03-21  215  
22d407b164ff79 Suren Baghdasaryan 2024-03-21  216  	tag = ct_to_alloc_tag(ref->ct);
22d407b164ff79 Suren Baghdasaryan 2024-03-21  217  
22d407b164ff79 Suren Baghdasaryan 2024-03-21  218  	this_cpu_sub(tag->counters->bytes, bytes);
22d407b164ff79 Suren Baghdasaryan 2024-03-21 @219  	this_cpu_dec(tag->counters->calls);
22d407b164ff79 Suren Baghdasaryan 2024-03-21  220  
22d407b164ff79 Suren Baghdasaryan 2024-03-21  221  	ref->ct = NULL;
22d407b164ff79 Suren Baghdasaryan 2024-03-21  222  }
22d407b164ff79 Suren Baghdasaryan 2024-03-21  223  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


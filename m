Return-Path: <linux-kernel+bounces-778291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 527DBB2E3E2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 19:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D82231662C2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E238933A010;
	Wed, 20 Aug 2025 17:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fDpsQa9e"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995BF225413
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 17:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755710386; cv=none; b=W9Az/e7LsNqs7I2hUC7hfoJ9BfvQVKZtCir4Nd3MSa6JLHnRIAyqOXd2QY15OKw9HsGuKhkr9DLHcktXxGeZbl5la+tt5xL1hpgeIWVitawPInk38+4QHKTloiVgwvjv2Xthkd4R3troy5A1Kef3sXpNJxxBiuZ+lsl7LQ500Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755710386; c=relaxed/simple;
	bh=GxHr6/54rgcy6sAclCD5AO7ktqqANCdjdS8twJwHCMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LtgHCDw1YPhZ6igYpqwuBAMtqay6aqBk4i6PSBfPzp/NjiZVfsneZnTj9YX2qkqeYHWpJu7uSJGSZWYE5EC83gvZuT474CT1b7+B6upPv7ggTPmSFKv05jepr4utIKBgU0x2rEo2PWWgNQDdZpiDGD1Rt4LkY98QaXuYZmAXBjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fDpsQa9e; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755710385; x=1787246385;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GxHr6/54rgcy6sAclCD5AO7ktqqANCdjdS8twJwHCMA=;
  b=fDpsQa9eXVW3VUKag2sEKTeHkQJUYbP+sJO26cTNdygg9yv2PSm668ZS
   pEGSj0wFF13DBljeGm0IZbdiIj6A4jXr685Cgf69OJitnwKhVycI3sz/X
   lzzRitpiNyi29foD5g6Uk4OERwXVAMs5BcMxg99RPdgMBR2T0/7qdRSHI
   2apcDGhrma00TnfuFZyg40kzxGrT5ARuGMTTAtG8TTvcR6gtVw8rn/jkf
   7n9nMq4EdJ+q9WgGgxakeeI5nQraY1pgxtTeSFcEbykSwWyTZ7xK5EEbv
   LwU0/T/WQVhjT+PH+BE+PXG0fM51QyhfAq0cOq1vWPJTbYMx/ruy6U1lw
   A==;
X-CSE-ConnectionGUID: nxPccekISSSCHe7PGCTWJA==
X-CSE-MsgGUID: TVAnzsmzSxaYQuYsqQ4X3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="83406122"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="83406122"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 10:19:44 -0700
X-CSE-ConnectionGUID: id3NsaM5RTK6EUgGk1bUSw==
X-CSE-MsgGUID: F/GOHyWPSxGZCqOCHmhCXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="167798899"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 20 Aug 2025 10:19:40 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uomTK-000JXL-03;
	Wed, 20 Aug 2025 17:19:38 +0000
Date: Thu, 21 Aug 2025 01:18:54 +0800
From: kernel test robot <lkp@intel.com>
To: Yunhui Cui <cuiyunhui@bytedance.com>, yury.norov@gmail.com,
	linux@rasmusvillemoes.dk, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	dennis@kernel.org, tj@kernel.org, cl@gentwo.org, linux-mm@kvack.org
Cc: oe-kbuild-all@lists.linux.dev, Yunhui Cui <cuiyunhui@bytedance.com>
Subject: Re: [PATCH 2/2] riscv: introduce percpu.h into include/asm
Message-ID: <202508210101.WySkXlSZ-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on dennis-percpu/for-next v6.17-rc2 next-20250820]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yunhui-Cui/riscv-remove-irqflags-h-inclusion-in-asm-bitops-h/20250819-215256
base:   linus/master
patch link:    https://lore.kernel.org/r/20250819135007.85646-3-cuiyunhui%40bytedance.com
patch subject: [PATCH 2/2] riscv: introduce percpu.h into include/asm
config: riscv-allnoconfig (https://download.01.org/0day-ci/archive/20250821/202508210101.WySkXlSZ-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250821/202508210101.WySkXlSZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508210101.WySkXlSZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/atomic.h:80,
                    from include/linux/cpumask.h:14,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:63,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/mm.h:7,
                    from mm/slub.c:13:
   mm/slub.c: In function '__update_cpu_freelist_fast':
>> include/linux/atomic/atomic-arch-fallback.h:414:30: error: implicit declaration of function 'arch_cmpxchg128_local'; did you mean 'arch_cmpxchg64_local'? [-Wimplicit-function-declaration]
     414 | #define raw_cmpxchg128_local arch_cmpxchg128_local
         |                              ^~~~~~~~~~~~~~~~~~~~~
   include/linux/atomic/atomic-instrumented.h:5005:9: note: in expansion of macro 'raw_cmpxchg128_local'
    5005 |         raw_cmpxchg128_local(__ai_ptr, __VA_ARGS__); \
         |         ^~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/percpu.h:131:17: note: in expansion of macro 'cmpxchg128_local'
     131 |         ret__ = cmpxchg128_local(ptr__, old__, new__);                  \
         |                 ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:108:17: note: in expansion of macro 'this_cpu_cmpxchg128'
     108 |         __val = _cmpxchg(pcp, __old, nval);                             \
         |                 ^~~~~~~~
   include/asm-generic/percpu.h:527:9: note: in expansion of macro '__cpu_fallback_try_cmpxchg'
     527 |         __cpu_fallback_try_cmpxchg(pcp, ovalp, nval, this_cpu_cmpxchg128)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   mm/slab.h:24:41: note: in expansion of macro 'this_cpu_try_cmpxchg128'
      24 | #define this_cpu_try_cmpxchg_freelist   this_cpu_try_cmpxchg128
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   mm/slub.c:3638:16: note: in expansion of macro 'this_cpu_try_cmpxchg_freelist'
    3638 |         return this_cpu_try_cmpxchg_freelist(s->cpu_slab->freelist_tid.full,
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +414 include/linux/atomic/atomic-arch-fallback.h

9257959a6e5b4f Mark Rutland 2023-06-05  413  
9257959a6e5b4f Mark Rutland 2023-06-05 @414  #define raw_cmpxchg128_local arch_cmpxchg128_local
e6ce9d741163af Uros Bizjak  2023-04-05  415  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


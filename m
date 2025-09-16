Return-Path: <linux-kernel+bounces-818444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D87B591D0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 522DC1B22A11
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BDF29A310;
	Tue, 16 Sep 2025 09:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mQ6C4vPi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EE829898B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758013909; cv=none; b=EZn1Z4E+rbaCGgADLFicux1mF8L9PQDLOCNtorxCUcsyNGU5XljHNcuMGfM8xnRR32VBGrIA8pHBt67mXFoCTsb/Nyq4M8/+509EIS5HrMO40wjGhfYZOyG0vU9dZ74Rd+ZHyKkS2tdLRuUl/AaG94KALJmGR4uUVq6G6rcK1x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758013909; c=relaxed/simple;
	bh=zMt+lj07w4o0jqg5XJ/ynsRarpPmoVl62tOzbhSFTo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6sxhTOGMgCajON0PXzETWsUPqF/z60ONiateD130PyDQ7F3JpuFLb3E6WOVV0/NDS2vG9zoNwxEw/aCjmrRkLhJ6kTMCt8kEEjo1j3MYaais6yU2xcNJyVClDr2A22NDuBVqgv8xsv7yRKm37orvPLM6A6xPVuq5pq3hQXuD1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mQ6C4vPi; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758013908; x=1789549908;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zMt+lj07w4o0jqg5XJ/ynsRarpPmoVl62tOzbhSFTo4=;
  b=mQ6C4vPi6xTlDTcKuPQfIf6NvmgiV5F08dExvsSP4iUu4ooHyzqYjgxJ
   CErfwJM3tmZgIlb7S3mQKPV2838CTIEq4n4X2LYsM9f6cjMVaijVR6KRW
   XMO9Y6A+eGPLXRpc/iG+ezFdUCaGf5zSBZyQGH05dQSrb3HgA9xvbl0sx
   fMekRHN23vIW8HdyZ999BpOCdDlKf1X+rlir1pEuhAwINnc78TtKeqBfS
   3yrDez06Vj5ad8FH/e98D5pkh1Bc9TuefBbvy4Cu+VEaBhOwY3x/kPtr2
   WXDX/9dX1NDGm04XgOufn0eMqfYWUMOMkpMwYyimqWCoIex+hUg2HoNtr
   Q==;
X-CSE-ConnectionGUID: MNnty9PoRNq2CtXZcBrRnw==
X-CSE-MsgGUID: mEFCnxATQ7qBa9O/ywQANw==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="60156178"
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; 
   d="scan'208";a="60156178"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 02:11:42 -0700
X-CSE-ConnectionGUID: uZhwW8IrSsG2Bt+G9sPI2Q==
X-CSE-MsgGUID: vXVH7QybRG+5S4cYC1RT9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; 
   d="scan'208";a="205672250"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 16 Sep 2025 02:11:40 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uyRir-00008V-1z;
	Tue, 16 Sep 2025 09:11:37 +0000
Date: Tue, 16 Sep 2025 17:10:50 +0800
From: kernel test robot <lkp@intel.com>
To: Miquel =?iso-8859-1?Q?Sabat=E9_Sol=E0?= <mikisabate@gmail.com>,
	linux-riscv@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	pjw@kernel.org, palmer@dabbelt.com, alex@ghiti.fr,
	wangyuli@uniontech.com, chenhuacai@kernel.org, mikisabate@gmail.com
Subject: Re: [PATCH] riscv: kgdb: Prefer strscpy instead of strcpy
Message-ID: <202509161619.eJeLbfU0-lkp@intel.com>
References: <20250915200644.200498-1-mikisabate@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915200644.200498-1-mikisabate@gmail.com>

Hi Miquel,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.17-rc6 next-20250915]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Miquel-Sabat-Sol/riscv-kgdb-Prefer-strscpy-instead-of-strcpy/20250916-040750
base:   linus/master
patch link:    https://lore.kernel.org/r/20250915200644.200498-1-mikisabate%40gmail.com
patch subject: [PATCH] riscv: kgdb: Prefer strscpy instead of strcpy
config: riscv-randconfig-002-20250916 (https://download.01.org/0day-ci/archive/20250916/202509161619.eJeLbfU0-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250916/202509161619.eJeLbfU0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509161619.eJeLbfU0-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/ptrace.h:5,
                    from arch/riscv/kernel/kgdb.c:6:
   arch/riscv/kernel/kgdb.c: In function 'kgdb_arch_handle_qxfer_pkt':
>> include/linux/compiler.h:197:67: error: static assertion failed: "must be array"
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                   ^~~~~~~~~~~~~~
   include/linux/compiler.h:202:28: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     202 | #define __must_be_array(a) __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                            ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/string.h:80:40: note: in expansion of macro '__must_be_array'
      80 |  sized_strscpy(dst, src, sizeof(dst) + __must_be_array(dst) + \
         |                                        ^~~~~~~~~~~~~~~
   include/linux/args.h:25:24: note: in expansion of macro '__strscpy0'
      25 | #define __CONCAT(a, b) a ## b
         |                        ^
   include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
      26 | #define CONCATENATE(a, b) __CONCAT(a, b)
         |                           ^~~~~~~~
   include/linux/string.h:114:2: note: in expansion of macro 'CONCATENATE'
     114 |  CONCATENATE(__strscpy, COUNT_ARGS(__VA_ARGS__))(dst, src, __VA_ARGS__)
         |  ^~~~~~~~~~~
   arch/riscv/kernel/kgdb.c:268:3: note: in expansion of macro 'strscpy'
     268 |   strscpy(remcom_out_buffer, riscv_gdb_stub_target_desc);
         |   ^~~~~~~
>> include/linux/compiler.h:197:67: error: static assertion failed: "must be array"
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                   ^~~~~~~~~~~~~~
   include/linux/compiler.h:202:28: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     202 | #define __must_be_array(a) __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                            ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/string.h:80:40: note: in expansion of macro '__must_be_array'
      80 |  sized_strscpy(dst, src, sizeof(dst) + __must_be_array(dst) + \
         |                                        ^~~~~~~~~~~~~~~
   include/linux/args.h:25:24: note: in expansion of macro '__strscpy0'
      25 | #define __CONCAT(a, b) a ## b
         |                        ^
   include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
      26 | #define CONCATENATE(a, b) __CONCAT(a, b)
         |                           ^~~~~~~~
   include/linux/string.h:114:2: note: in expansion of macro 'CONCATENATE'
     114 |  CONCATENATE(__strscpy, COUNT_ARGS(__VA_ARGS__))(dst, src, __VA_ARGS__)
         |  ^~~~~~~~~~~
   arch/riscv/kernel/kgdb.c:271:3: note: in expansion of macro 'strscpy'
     271 |   strscpy(remcom_out_buffer, riscv_gdb_stub_cpuxml);
         |   ^~~~~~~


vim +197 include/linux/compiler.h

230fa253df6352 Christian Borntraeger 2014-11-25  193  
cb7380de9e4cbc Kees Cook             2025-02-05  194  #ifdef __CHECKER__
243c90e917f5cf Vincent Mailhol       2025-03-29  195  #define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...) (0)
cb7380de9e4cbc Kees Cook             2025-02-05  196  #else /* __CHECKER__ */
243c90e917f5cf Vincent Mailhol       2025-03-29 @197  #define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
cb7380de9e4cbc Kees Cook             2025-02-05  198  #endif /* __CHECKER__ */
cb7380de9e4cbc Kees Cook             2025-02-05  199  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


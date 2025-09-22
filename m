Return-Path: <linux-kernel+bounces-827316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C99B916A4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A57F17A1C79
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2A830CB2F;
	Mon, 22 Sep 2025 13:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SDy8VOE2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98122309EF6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758548020; cv=none; b=Y+0GSwskZbbhj+XtQYXeqOYep+pH3bZz91bPN9TTKOSoncZOTQJDcVnSBh7R95nfPZ4UGH0XN6K6sYtq8qKGYLu1xRPnJxmNsLgdPvILiBtbEvYbUoeN5vD9MJxnNtIdmjogkGDkpqlibE/5hxD+wm0uk/Q/MCorGq9i85jqUYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758548020; c=relaxed/simple;
	bh=elO3NLv4vt1JKnON/yJ0aCls7P7sTB7/lhLmqgp9rgg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pGGQns83buTWakqHroy1G69BNQB1aUFJlQqqXe/xcUWxOPaZzt0mNxR+VncTxIqkquFPdOMIC8IwP7xWIE+AqBSN6HqcPM7RyGTfb+NfpQTa3I0gUm5wGe0HPIzn1KMoYyaWFokxaiTrammJXxD0KAjYoWjCgc3HZ3V9+0e4p8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SDy8VOE2; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758548019; x=1790084019;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=elO3NLv4vt1JKnON/yJ0aCls7P7sTB7/lhLmqgp9rgg=;
  b=SDy8VOE268vPkXtUUIeDzrsM5+jV1MATvXcWQs/wv5O1tLgewTI4L85n
   ZH/pYB3z9hq0St7yQiOgomD0Sm91XS2ZEhMhm1NCwjpyzr3BmYNU1UXI2
   UzNpD3pIcHTc4mBAVy1NBrGN9tsRnZHEjp4UKvCPjzEletWTSaOVc2Sa3
   IqcfLViNAeyCGhsxt1AKq5q/xJ5xam68n69YxnTTUpLWMP0eF56gaigRp
   24SZx9cSwsOqYt7vntRPmNvH+Ht8rMVQ7yUhgdpSnqvKXJsaGJvSKQRl1
   3r4PJMYDOarPf8FSjUFHS3hJVbhv2Mt2ylI/OD3LwLMw40bYI56EpuIQ5
   A==;
X-CSE-ConnectionGUID: D+goINgcQmW3zA24K4sIAA==
X-CSE-MsgGUID: pLA0eckkTh6IpzdoHXeOAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="63437687"
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; 
   d="scan'208";a="63437687"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 06:33:38 -0700
X-CSE-ConnectionGUID: BC/kmH+NTrGQk6dneCix1w==
X-CSE-MsgGUID: 3o4exqteQd+w9anjPZHnaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; 
   d="scan'208";a="180491381"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 22 Sep 2025 06:33:36 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v0gfd-0001iT-0c;
	Mon, 22 Sep 2025 13:33:33 +0000
Date: Mon, 22 Sep 2025 21:32:48 +0800
From: kernel test robot <lkp@intel.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>,
	Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Subject: include/asm-generic/percpu.h:21:44: warning: array subscript 32 is
 above array bounds of 'long unsigned int[32]'
Message-ID: <202509222148.aujDHbuM-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Yury,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   07e27ad16399afcd693be20211b0dfae63e0615f
commit: fda1dd3c54ef3c4200c2e77634a91610da973950 find: Switch from inline to __always_inline
date:   1 year, 1 month ago
config: riscv-randconfig-r111-20250922 (https://download.01.org/0day-ci/archive/20250922/202509222148.aujDHbuM-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250922/202509222148.aujDHbuM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509222148.aujDHbuM-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/compiler_types.h:174,
                    from <command-line>:
   drivers/base/test/test_async_driver_probe.c: In function 'test_async_probe_init':
>> include/asm-generic/percpu.h:21:44: warning: array subscript 32 is above array bounds of 'long unsigned int[32]' [-Warray-bounds]
    #define per_cpu_offset(x) (__per_cpu_offset[x])
   include/linux/compiler-gcc.h:35:26: note: in definition of macro 'RELOC_HIDE'
     (typeof(ptr)) (__ptr + (off));     \
                             ^~~
   include/linux/percpu-defs.h:236:2: note: in expansion of macro 'SHIFT_PERCPU_PTR'
     SHIFT_PERCPU_PTR((ptr), per_cpu_offset((cpu)));   \
     ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:236:26: note: in expansion of macro 'per_cpu_offset'
     SHIFT_PERCPU_PTR((ptr), per_cpu_offset((cpu)));   \
                             ^~~~~~~~~~~~~~
   include/linux/percpu-defs.h:269:29: note: in expansion of macro 'per_cpu_ptr'
    #define per_cpu(var, cpu) (*per_cpu_ptr(&(var), cpu))
                                ^~~~~~~~~~~
   include/linux/topology.h:96:9: note: in expansion of macro 'per_cpu'
     return per_cpu(numa_node, cpu);
            ^~~~~~~


vim +21 include/asm-generic/percpu.h

^1da177e4c3f41 Linus Torvalds 2005-04-16  20  
a875a69f8b00a3 Ingo Molnar    2006-07-03 @21  #define per_cpu_offset(x) (__per_cpu_offset[x])
acdac87202a408 travis@sgi.com 2008-01-30  22  #endif
acdac87202a408 travis@sgi.com 2008-01-30  23  

:::::: The code at line 21 was first introduced by commit
:::::: a875a69f8b00a38b4f40d9632a4fc71a159f0e0d [PATCH] lockdep: add per_cpu_offset()

:::::: TO: Ingo Molnar <mingo@elte.hu>
:::::: CC: Linus Torvalds <torvalds@g5.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


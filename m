Return-Path: <linux-kernel+bounces-825374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEBBB8BB3A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 02:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71AD77E3B03
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 00:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3339EA92E;
	Sat, 20 Sep 2025 00:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bUvf98IH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A888B191
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 00:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758329213; cv=none; b=EY2UsR3vIOFXoLqwvgGnfb3vgTEu6zie4HtP0Lh+FXpMzGpvKNPcFOd4m/Owm0O/CiEmY6hJ7BFaeJe/r78sovB8thkxinUs00aFWK05eo3ehbhNO7WBbx+FU1TtMiY32KV16T84G8OAdu7m7RaMqFsdUI3vPR0+CmF5g95I4zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758329213; c=relaxed/simple;
	bh=IZK4QCUIsmSsq8uucHTLaXbe91586eFSYBj7chNzAMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQEXPZoJcEhPvAY2IseCS8dNGp5nF3t6cK9sqLKhDLIjoXM6QMaSaTqTysviQrCzD/w9XjEeI0hBUJPe6g+EeBvC1Kln57bgpPhbZ0htHr1vQMnmgbanVm2p8kD/DIjQJXcb5qVV1KVc4bULZ5zHAdr6mfWAmmPO+bSCORzKQyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bUvf98IH; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758329212; x=1789865212;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IZK4QCUIsmSsq8uucHTLaXbe91586eFSYBj7chNzAMA=;
  b=bUvf98IHZ1WyGSygboeY8b2y0p1trooOvSXR02PpdQRWjdezNRMCnehH
   deVUEP60NAScAezSZjMgOGXg3SAW5ErsYLSjMwkvYSF+o++mO8ehibxG2
   OgewJ4osFn2tMIQLYQ18i5j0pMLXVG3Og6OwhqAwvCoMWmRK8ot/7I6oE
   8m2Vt6b2P6MA10G0uqErN3KGJGctofTJBsn3bg3jhfID2/Dy8lUU8TaiP
   aWU1lVumTmwnGDP+8EKJELbrTThy3XaPIoXXKMU5gAumXnjFmOxhgBzWY
   IwQdpcUvLY1pVNEI3hDDJ7M0N5OEmtROo4kWFjzoXebiixHrzxdBH21/H
   A==;
X-CSE-ConnectionGUID: raGi1TtLQ3iNLoT+8zBUSw==
X-CSE-MsgGUID: ukwQy8AST7q97KxHvpjtjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="71784982"
X-IronPort-AV: E=Sophos;i="6.18,279,1751266800"; 
   d="scan'208";a="71784982"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 17:46:52 -0700
X-CSE-ConnectionGUID: WoInC2IWSW6olGkG7QTKqg==
X-CSE-MsgGUID: A9mArTNKQlujZhm4auirVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,279,1751266800"; 
   d="scan'208";a="181223585"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 19 Sep 2025 17:46:48 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uzlkT-0004vr-3D;
	Sat, 20 Sep 2025 00:46:46 +0000
Date: Sat, 20 Sep 2025 08:46:11 +0800
From: kernel test robot <lkp@intel.com>
To: Adrian =?utf-8?Q?Barna=C5=9B?= <abarnas@google.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Adrian =?utf-8?Q?Barna=C5=9B?= <abarnas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Dylan Hatch <dylanbhatch@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Fanqin Cui <cuifq1@chinatelecom.cn>
Subject: Re: [PATCH 2/2] arch: arm64: Reject modules with internal
 alternative callbacks
Message-ID: <202509200821.Qy7LYrJP-lkp@intel.com>
References: <20250919122321.946462-3-abarnas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919122321.946462-3-abarnas@google.com>

Hi Adrian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on arm/for-next]
[also build test WARNING on arm/fixes kvmarm/next soc/for-next linus/master v6.17-rc6 next-20250919]
[cannot apply to arm64/for-next/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Adrian-Barna/arch-arm64-Fail-module-loading-if-dynamic-SCS-patching-fails/20250919-202643
base:   git://git.armlinux.org.uk/~rmk/linux-arm.git for-next
patch link:    https://lore.kernel.org/r/20250919122321.946462-3-abarnas%40google.com
patch subject: [PATCH 2/2] arch: arm64: Reject modules with internal alternative callbacks
config: arm64-allnoconfig (https://download.01.org/0day-ci/archive/20250920/202509200821.Qy7LYrJP-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250920/202509200821.Qy7LYrJP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509200821.Qy7LYrJP-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/arm64/include/asm/sysreg.h:1111,
                    from arch/arm64/include/asm/cputype.h:250,
                    from arch/arm64/include/asm/cache.h:43,
                    from include/vdso/cache.h:5,
                    from include/linux/cache.h:6,
                    from include/linux/slab.h:15,
                    from include/linux/resource_ext.h:11,
                    from include/linux/acpi.h:13,
                    from include/acpi/apei.h:9,
                    from include/acpi/ghes.h:5,
                    from include/linux/arm_sdei.h:8,
                    from arch/arm64/kernel/asm-offsets.c:10:
   arch/arm64/include/asm/alternative.h: In function 'apply_alternatives_module':
>> arch/arm64/include/asm/alternative.h:31:1: warning: no return statement in function returning non-void [-Wreturn-type]
      31 | static inline int apply_alternatives_module(void *start, size_t length) { }
         | ^~~~~~
--
   In file included from arch/arm64/include/asm/sysreg.h:1111,
                    from arch/arm64/include/asm/memory.h:223,
                    from arch/arm64/include/asm/thread_info.h:17,
                    from include/linux/thread_info.h:60,
                    from arch/arm64/include/asm/preempt.h:6,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:7,
                    from arch/arm64/kernel/sys.c:11:
   arch/arm64/include/asm/alternative.h: In function 'apply_alternatives_module':
>> arch/arm64/include/asm/alternative.h:31:1: warning: no return statement in function returning non-void [-Wreturn-type]
      31 | static inline int apply_alternatives_module(void *start, size_t length) { }
         | ^~~~~~
   ./arch/arm64/include/generated/asm/syscall_table_64.h: At top level:
   arch/arm64/kernel/sys.c:58:40: warning: initialized field overwritten [-Woverride-init]
      58 | #define __SYSCALL(nr, sym)      [nr] = __arm64_##sym,
         |                                        ^~~~~~~~
   arch/arm64/kernel/sys.c:51:52: note: in expansion of macro '__SYSCALL'
      51 | #define __SYSCALL_WITH_COMPAT(nr, native, compat)  __SYSCALL(nr, native)
         |                                                    ^~~~~~~~~
   ./arch/arm64/include/generated/asm/syscall_table_64.h:1:1: note: in expansion of macro '__SYSCALL_WITH_COMPAT'
       1 | __SYSCALL_WITH_COMPAT(0, sys_io_setup, compat_sys_io_setup)
         | ^~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/sys.c:58:40: note: (near initialization for 'sys_call_table[0]')
      58 | #define __SYSCALL(nr, sym)      [nr] = __arm64_##sym,
         |                                        ^~~~~~~~
   arch/arm64/kernel/sys.c:51:52: note: in expansion of macro '__SYSCALL'
      51 | #define __SYSCALL_WITH_COMPAT(nr, native, compat)  __SYSCALL(nr, native)
         |                                                    ^~~~~~~~~
   ./arch/arm64/include/generated/asm/syscall_table_64.h:1:1: note: in expansion of macro '__SYSCALL_WITH_COMPAT'
       1 | __SYSCALL_WITH_COMPAT(0, sys_io_setup, compat_sys_io_setup)
         | ^~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/sys.c:58:40: warning: initialized field overwritten [-Woverride-init]
      58 | #define __SYSCALL(nr, sym)      [nr] = __arm64_##sym,
         |                                        ^~~~~~~~
   ./arch/arm64/include/generated/asm/syscall_table_64.h:2:1: note: in expansion of macro '__SYSCALL'
       2 | __SYSCALL(1, sys_io_destroy)
         | ^~~~~~~~~
   arch/arm64/kernel/sys.c:58:40: note: (near initialization for 'sys_call_table[1]')
      58 | #define __SYSCALL(nr, sym)      [nr] = __arm64_##sym,
         |                                        ^~~~~~~~
   ./arch/arm64/include/generated/asm/syscall_table_64.h:2:1: note: in expansion of macro '__SYSCALL'
       2 | __SYSCALL(1, sys_io_destroy)
         | ^~~~~~~~~
   arch/arm64/kernel/sys.c:58:40: warning: initialized field overwritten [-Woverride-init]
      58 | #define __SYSCALL(nr, sym)      [nr] = __arm64_##sym,
         |                                        ^~~~~~~~
   arch/arm64/kernel/sys.c:51:52: note: in expansion of macro '__SYSCALL'
      51 | #define __SYSCALL_WITH_COMPAT(nr, native, compat)  __SYSCALL(nr, native)
         |                                                    ^~~~~~~~~
   ./arch/arm64/include/generated/asm/syscall_table_64.h:3:1: note: in expansion of macro '__SYSCALL_WITH_COMPAT'
       3 | __SYSCALL_WITH_COMPAT(2, sys_io_submit, compat_sys_io_submit)
         | ^~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/sys.c:58:40: note: (near initialization for 'sys_call_table[2]')
      58 | #define __SYSCALL(nr, sym)      [nr] = __arm64_##sym,
         |                                        ^~~~~~~~
   arch/arm64/kernel/sys.c:51:52: note: in expansion of macro '__SYSCALL'
      51 | #define __SYSCALL_WITH_COMPAT(nr, native, compat)  __SYSCALL(nr, native)
         |                                                    ^~~~~~~~~
   ./arch/arm64/include/generated/asm/syscall_table_64.h:3:1: note: in expansion of macro '__SYSCALL_WITH_COMPAT'
       3 | __SYSCALL_WITH_COMPAT(2, sys_io_submit, compat_sys_io_submit)
         | ^~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/sys.c:58:40: warning: initialized field overwritten [-Woverride-init]
      58 | #define __SYSCALL(nr, sym)      [nr] = __arm64_##sym,
         |                                        ^~~~~~~~
   ./arch/arm64/include/generated/asm/syscall_table_64.h:4:1: note: in expansion of macro '__SYSCALL'
       4 | __SYSCALL(3, sys_io_cancel)
         | ^~~~~~~~~
   arch/arm64/kernel/sys.c:58:40: note: (near initialization for 'sys_call_table[3]')
      58 | #define __SYSCALL(nr, sym)      [nr] = __arm64_##sym,
         |                                        ^~~~~~~~
   ./arch/arm64/include/generated/asm/syscall_table_64.h:4:1: note: in expansion of macro '__SYSCALL'
       4 | __SYSCALL(3, sys_io_cancel)
         | ^~~~~~~~~
   arch/arm64/kernel/sys.c:58:40: warning: initialized field overwritten [-Woverride-init]
      58 | #define __SYSCALL(nr, sym)      [nr] = __arm64_##sym,
         |                                        ^~~~~~~~
   ./arch/arm64/include/generated/asm/syscall_table_64.h:5:1: note: in expansion of macro '__SYSCALL'
       5 | __SYSCALL(4, sys_io_getevents)
         | ^~~~~~~~~
   arch/arm64/kernel/sys.c:58:40: note: (near initialization for 'sys_call_table[4]')
      58 | #define __SYSCALL(nr, sym)      [nr] = __arm64_##sym,
         |                                        ^~~~~~~~
   ./arch/arm64/include/generated/asm/syscall_table_64.h:5:1: note: in expansion of macro '__SYSCALL'
       5 | __SYSCALL(4, sys_io_getevents)
         | ^~~~~~~~~
   arch/arm64/kernel/sys.c:58:40: warning: initialized field overwritten [-Woverride-init]
      58 | #define __SYSCALL(nr, sym)      [nr] = __arm64_##sym,
         |                                        ^~~~~~~~
   ./arch/arm64/include/generated/asm/syscall_table_64.h:6:1: note: in expansion of macro '__SYSCALL'
       6 | __SYSCALL(5, sys_setxattr)
         | ^~~~~~~~~
   arch/arm64/kernel/sys.c:58:40: note: (near initialization for 'sys_call_table[5]')
      58 | #define __SYSCALL(nr, sym)      [nr] = __arm64_##sym,
         |                                        ^~~~~~~~
   ./arch/arm64/include/generated/asm/syscall_table_64.h:6:1: note: in expansion of macro '__SYSCALL'
       6 | __SYSCALL(5, sys_setxattr)
         | ^~~~~~~~~
   arch/arm64/kernel/sys.c:58:40: warning: initialized field overwritten [-Woverride-init]
      58 | #define __SYSCALL(nr, sym)      [nr] = __arm64_##sym,
         |                                        ^~~~~~~~
   ./arch/arm64/include/generated/asm/syscall_table_64.h:7:1: note: in expansion of macro '__SYSCALL'
       7 | __SYSCALL(6, sys_lsetxattr)
         | ^~~~~~~~~
   arch/arm64/kernel/sys.c:58:40: note: (near initialization for 'sys_call_table[6]')
      58 | #define __SYSCALL(nr, sym)      [nr] = __arm64_##sym,
         |                                        ^~~~~~~~
   ./arch/arm64/include/generated/asm/syscall_table_64.h:7:1: note: in expansion of macro '__SYSCALL'
       7 | __SYSCALL(6, sys_lsetxattr)
         | ^~~~~~~~~
   arch/arm64/kernel/sys.c:58:40: warning: initialized field overwritten [-Woverride-init]
--
   In file included from arch/arm64/include/asm/sysreg.h:1111,
                    from arch/arm64/include/asm/cputype.h:250,
                    from arch/arm64/include/asm/cache.h:43,
                    from include/vdso/cache.h:5,
                    from include/linux/cache.h:6,
                    from arch/arm64/include/asm/processor.h:29,
                    from include/linux/sched.h:13,
                    from include/linux/context_tracking.h:5,
                    from arch/arm64/kernel/traps.c:10:
   arch/arm64/include/asm/alternative.h: In function 'apply_alternatives_module':
>> arch/arm64/include/asm/alternative.h:31:1: warning: no return statement in function returning non-void [-Wreturn-type]
      31 | static inline int apply_alternatives_module(void *start, size_t length) { }
         | ^~~~~~
   arch/arm64/kernel/traps.c: At top level:
   arch/arm64/kernel/traps.c:831:43: warning: initialized field overwritten [-Woverride-init]
     831 |         [ESR_ELx_EC_UNKNOWN]            = "Unknown/Uncategorized",
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:831:43: note: (near initialization for 'esr_class_str[0]')
   arch/arm64/kernel/traps.c:832:43: warning: initialized field overwritten [-Woverride-init]
     832 |         [ESR_ELx_EC_WFx]                = "WFI/WFE",
         |                                           ^~~~~~~~~
   arch/arm64/kernel/traps.c:832:43: note: (near initialization for 'esr_class_str[1]')
   arch/arm64/kernel/traps.c:833:43: warning: initialized field overwritten [-Woverride-init]
     833 |         [ESR_ELx_EC_CP15_32]            = "CP15 MCR/MRC",
         |                                           ^~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:833:43: note: (near initialization for 'esr_class_str[3]')
   arch/arm64/kernel/traps.c:834:43: warning: initialized field overwritten [-Woverride-init]
     834 |         [ESR_ELx_EC_CP15_64]            = "CP15 MCRR/MRRC",
         |                                           ^~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:834:43: note: (near initialization for 'esr_class_str[4]')
   arch/arm64/kernel/traps.c:835:43: warning: initialized field overwritten [-Woverride-init]
     835 |         [ESR_ELx_EC_CP14_MR]            = "CP14 MCR/MRC",
         |                                           ^~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:835:43: note: (near initialization for 'esr_class_str[5]')
   arch/arm64/kernel/traps.c:836:43: warning: initialized field overwritten [-Woverride-init]
     836 |         [ESR_ELx_EC_CP14_LS]            = "CP14 LDC/STC",
         |                                           ^~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:836:43: note: (near initialization for 'esr_class_str[6]')
   arch/arm64/kernel/traps.c:837:43: warning: initialized field overwritten [-Woverride-init]
     837 |         [ESR_ELx_EC_FP_ASIMD]           = "ASIMD",
         |                                           ^~~~~~~
   arch/arm64/kernel/traps.c:837:43: note: (near initialization for 'esr_class_str[7]')
   arch/arm64/kernel/traps.c:838:43: warning: initialized field overwritten [-Woverride-init]
     838 |         [ESR_ELx_EC_CP10_ID]            = "CP10 MRC/VMRS",
         |                                           ^~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:838:43: note: (near initialization for 'esr_class_str[8]')
   arch/arm64/kernel/traps.c:839:43: warning: initialized field overwritten [-Woverride-init]
     839 |         [ESR_ELx_EC_PAC]                = "PAC",
         |                                           ^~~~~
   arch/arm64/kernel/traps.c:839:43: note: (near initialization for 'esr_class_str[9]')
   arch/arm64/kernel/traps.c:840:43: warning: initialized field overwritten [-Woverride-init]
     840 |         [ESR_ELx_EC_CP14_64]            = "CP14 MCRR/MRRC",
         |                                           ^~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:840:43: note: (near initialization for 'esr_class_str[12]')
   arch/arm64/kernel/traps.c:841:43: warning: initialized field overwritten [-Woverride-init]
     841 |         [ESR_ELx_EC_BTI]                = "BTI",
         |                                           ^~~~~
   arch/arm64/kernel/traps.c:841:43: note: (near initialization for 'esr_class_str[13]')
   arch/arm64/kernel/traps.c:842:43: warning: initialized field overwritten [-Woverride-init]
     842 |         [ESR_ELx_EC_ILL]                = "PSTATE.IL",
         |                                           ^~~~~~~~~~~
   arch/arm64/kernel/traps.c:842:43: note: (near initialization for 'esr_class_str[14]')
   arch/arm64/kernel/traps.c:843:43: warning: initialized field overwritten [-Woverride-init]
     843 |         [ESR_ELx_EC_SVC32]              = "SVC (AArch32)",
         |                                           ^~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:843:43: note: (near initialization for 'esr_class_str[17]')
   arch/arm64/kernel/traps.c:844:43: warning: initialized field overwritten [-Woverride-init]
     844 |         [ESR_ELx_EC_HVC32]              = "HVC (AArch32)",
         |                                           ^~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:844:43: note: (near initialization for 'esr_class_str[18]')
   arch/arm64/kernel/traps.c:845:43: warning: initialized field overwritten [-Woverride-init]
     845 |         [ESR_ELx_EC_SMC32]              = "SMC (AArch32)",
         |                                           ^~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:845:43: note: (near initialization for 'esr_class_str[19]')
   arch/arm64/kernel/traps.c:846:43: warning: initialized field overwritten [-Woverride-init]
     846 |         [ESR_ELx_EC_SVC64]              = "SVC (AArch64)",
         |                                           ^~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:846:43: note: (near initialization for 'esr_class_str[21]')
   arch/arm64/kernel/traps.c:847:43: warning: initialized field overwritten [-Woverride-init]
     847 |         [ESR_ELx_EC_HVC64]              = "HVC (AArch64)",
         |                                           ^~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:847:43: note: (near initialization for 'esr_class_str[22]')
   arch/arm64/kernel/traps.c:848:43: warning: initialized field overwritten [-Woverride-init]
     848 |         [ESR_ELx_EC_SMC64]              = "SMC (AArch64)",
         |                                           ^~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:848:43: note: (near initialization for 'esr_class_str[23]')
   arch/arm64/kernel/traps.c:849:43: warning: initialized field overwritten [-Woverride-init]
     849 |         [ESR_ELx_EC_SYS64]              = "MSR/MRS (AArch64)",
         |                                           ^~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:849:43: note: (near initialization for 'esr_class_str[24]')
   arch/arm64/kernel/traps.c:850:43: warning: initialized field overwritten [-Woverride-init]
     850 |         [ESR_ELx_EC_SVE]                = "SVE",
         |                                           ^~~~~
   arch/arm64/kernel/traps.c:850:43: note: (near initialization for 'esr_class_str[25]')
   arch/arm64/kernel/traps.c:851:43: warning: initialized field overwritten [-Woverride-init]
     851 |         [ESR_ELx_EC_ERET]               = "ERET/ERETAA/ERETAB",
         |                                           ^~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:851:43: note: (near initialization for 'esr_class_str[26]')
   arch/arm64/kernel/traps.c:852:43: warning: initialized field overwritten [-Woverride-init]
     852 |         [ESR_ELx_EC_FPAC]               = "FPAC",
         |                                           ^~~~~~
   arch/arm64/kernel/traps.c:852:43: note: (near initialization for 'esr_class_str[28]')
   arch/arm64/kernel/traps.c:853:43: warning: initialized field overwritten [-Woverride-init]
     853 |         [ESR_ELx_EC_SME]                = "SME",
         |                                           ^~~~~
   arch/arm64/kernel/traps.c:853:43: note: (near initialization for 'esr_class_str[29]')
   arch/arm64/kernel/traps.c:854:43: warning: initialized field overwritten [-Woverride-init]
     854 |         [ESR_ELx_EC_IMP_DEF]            = "EL3 IMP DEF",
         |                                           ^~~~~~~~~~~~~
   arch/arm64/kernel/traps.c:854:43: note: (near initialization for 'esr_class_str[31]')
   arch/arm64/kernel/traps.c:855:43: warning: initialized field overwritten [-Woverride-init]
--
   In file included from arch/arm64/include/asm/sysreg.h:1111,
                    from arch/arm64/include/asm/cputype.h:250,
                    from arch/arm64/include/asm/cache.h:43,
                    from include/vdso/cache.h:5,
                    from include/linux/cache.h:6,
                    from include/linux/slab.h:15,
                    from include/linux/resource_ext.h:11,
                    from include/linux/acpi.h:13,
                    from include/acpi/apei.h:9,
                    from include/acpi/ghes.h:5,
                    from include/linux/arm_sdei.h:8,
                    from arch/arm64/kernel/asm-offsets.c:10:
   arch/arm64/include/asm/alternative.h: In function 'apply_alternatives_module':
>> arch/arm64/include/asm/alternative.h:31:1: warning: no return statement in function returning non-void [-Wreturn-type]
      31 | static inline int apply_alternatives_module(void *start, size_t length) { }
         | ^~~~~~
   In file included from arch/arm64/include/asm/vdso/gettimeofday.h:10,
                    from include/vdso/datapage.h:197,
                    from lib/vdso/gettimeofday.c:5,
                    from <command-line>:
   arch/arm64/include/asm/alternative.h: In function 'apply_alternatives_module':
>> arch/arm64/include/asm/alternative.h:31:1: warning: no return statement in function returning non-void [-Wreturn-type]
      31 | static inline int apply_alternatives_module(void *start, size_t length) { }
         | ^~~~~~
   In file included from arch/arm64/include/asm/vdso/gettimeofday.h:10,
                    from include/vdso/datapage.h:197,
                    from lib/vdso/getrandom.c:8,
                    from <command-line>:
   arch/arm64/include/asm/alternative.h: In function 'apply_alternatives_module':
>> arch/arm64/include/asm/alternative.h:31:1: warning: no return statement in function returning non-void [-Wreturn-type]
      31 | static inline int apply_alternatives_module(void *start, size_t length) { }
         | ^~~~~~


vim +31 arch/arm64/include/asm/alternative.h

    27	
    28	#ifdef CONFIG_MODULES
    29	int apply_alternatives_module(void *start, size_t length);
    30	#else
  > 31	static inline int apply_alternatives_module(void *start, size_t length) { }
    32	#endif
    33	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


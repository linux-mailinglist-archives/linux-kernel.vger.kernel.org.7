Return-Path: <linux-kernel+bounces-793622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81881B3D631
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 03:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA0EC3BAE9A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 01:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80F313A244;
	Mon,  1 Sep 2025 01:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nzc8yb7E"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60229F9EC
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 01:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756688522; cv=none; b=h8fSOnEbPtu5TdPlvc1F3Hk7IdXi9NS18fIGIUPsiqXYeKZYA2s9DbSG/wvzfYzHX1YQ/vYjF3TxMpc41GFQu6FuuZZXBu2Sa8SWDAZ7KT4c4Xf4ELWNCHQAzz+zNO5B66a+to+2IJrmzwbKF1GiRymBIq352iL/48ofN8UUGlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756688522; c=relaxed/simple;
	bh=g4/tUGE+bPBFZqyr43BhsY0IspuBvt4O6j4K3lSP2Rs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i35c1sNVHVHIc0TLS4V6JmvcyiOv3fbaRZKPvC/76CA2LdZymhaH1AtOTeAHPCMPR0Ssx5eGGRzfWcbHQci4w7uaAlApKbq1COD6Yhv5vnc70/Y4TBLio3qKeiNI0CM81qu8yWpIiYbYs3jsH9s+70ht0Rb3BQQPTRFwbjJsEzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nzc8yb7E; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756688521; x=1788224521;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=g4/tUGE+bPBFZqyr43BhsY0IspuBvt4O6j4K3lSP2Rs=;
  b=nzc8yb7Ea7AF4BzY/uM0BIYhjvJYJ47O6+iLEoCpEGJ025IdDmHYfCvJ
   7FOaEF2zEefkT2xeOLejXwanJVPLw43LzPNY2BCUM+h5Tsrb0ubBQN42J
   VCWuqjENPqv/2EaNUqnZJ1l7h1Mbm10YMGsc1GeiyyYwuXafYEww4UPZj
   i2v/lJtNvt/3NcxlCnRo/8EV1dJtfA0PVg64qqKP9tQAKNzxiSaGTGMgg
   40dGgXqbZG/tXIghtjjXGMQMhfGAZEyP+zO+dx3YGKs3EJbuDsjqDbou6
   B8i4CkuDiFBD6HWSxMN06ztFm/eiDvPSo976BQRtvLJf3MsWBOTXnpiaM
   Q==;
X-CSE-ConnectionGUID: YdVspFSSQv6EWOq4ydfIdQ==
X-CSE-MsgGUID: F8U7HcM9Tp+GyMySi0WVTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11539"; a="70317143"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="70317143"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2025 18:02:00 -0700
X-CSE-ConnectionGUID: YBAYBBgIRjWiXE8g0nf3+g==
X-CSE-MsgGUID: mcUgq/DZQ+2cl1WEB+7uVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="171005205"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 31 Aug 2025 18:01:59 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ussvP-000WSF-2k;
	Mon, 01 Sep 2025 01:01:41 +0000
Date: Mon, 1 Sep 2025 09:00:45 +0800
From: kernel test robot <lkp@intel.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: arch/riscv/mm/init.c:354 relocate_kernel() warn: always true
 condition '(relocated_addr >= (((0)))) => (0-u32max >= 0)'
Message-ID: <202509010849.b4WcaJtA-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b320789d6883cc00ac78ce83bccbfe7ed58afcf0
commit: ea2bde36a46d5724c1b44d80cc9fafbd73c2ecf9 riscv: Support CONFIG_RELOCATABLE on riscv32
date:   5 months ago
config: riscv-randconfig-r073-20250901 (https://download.01.org/0day-ci/archive/20250901/202509010849.b4WcaJtA-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 9.5.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509010849.b4WcaJtA-lkp@intel.com/

smatch warnings:
arch/riscv/mm/init.c:354 relocate_kernel() warn: always true condition '(relocated_addr >= (((0)))) => (0-u32max >= 0)'

vim +354 arch/riscv/mm/init.c

51b766c79a3d74 Samuel Holland 2024-10-26  326  
51b766c79a3d74 Samuel Holland 2024-10-26  327  static void __init relocate_kernel(void)
51b766c79a3d74 Samuel Holland 2024-10-26  328  {
ea2bde36a46d57 Samuel Holland 2024-10-26  329  	Elf_Rela *rela = (Elf_Rela *)&__rela_dyn_start;
51b766c79a3d74 Samuel Holland 2024-10-26  330  	/*
51b766c79a3d74 Samuel Holland 2024-10-26  331  	 * This holds the offset between the linked virtual address and the
51b766c79a3d74 Samuel Holland 2024-10-26  332  	 * relocated virtual address.
51b766c79a3d74 Samuel Holland 2024-10-26  333  	 */
51b766c79a3d74 Samuel Holland 2024-10-26  334  	uintptr_t reloc_offset = kernel_map.virt_addr - KERNEL_LINK_ADDR;
51b766c79a3d74 Samuel Holland 2024-10-26  335  	/*
51b766c79a3d74 Samuel Holland 2024-10-26  336  	 * This holds the offset between kernel linked virtual address and
51b766c79a3d74 Samuel Holland 2024-10-26  337  	 * physical address.
51b766c79a3d74 Samuel Holland 2024-10-26  338  	 */
51b766c79a3d74 Samuel Holland 2024-10-26  339  	uintptr_t va_kernel_link_pa_offset = KERNEL_LINK_ADDR - kernel_map.phys_addr;
51b766c79a3d74 Samuel Holland 2024-10-26  340  
ea2bde36a46d57 Samuel Holland 2024-10-26  341  	for ( ; rela < (Elf_Rela *)&__rela_dyn_end; rela++) {
ea2bde36a46d57 Samuel Holland 2024-10-26  342  		Elf_Addr addr = (rela->r_offset - va_kernel_link_pa_offset);
ea2bde36a46d57 Samuel Holland 2024-10-26  343  		Elf_Addr relocated_addr = rela->r_addend;
51b766c79a3d74 Samuel Holland 2024-10-26  344  
51b766c79a3d74 Samuel Holland 2024-10-26  345  		if (rela->r_info != R_RISCV_RELATIVE)
51b766c79a3d74 Samuel Holland 2024-10-26  346  			continue;
51b766c79a3d74 Samuel Holland 2024-10-26  347  
51b766c79a3d74 Samuel Holland 2024-10-26  348  		/*
51b766c79a3d74 Samuel Holland 2024-10-26  349  		 * Make sure to not relocate vdso symbols like rt_sigreturn
51b766c79a3d74 Samuel Holland 2024-10-26  350  		 * which are linked from the address 0 in vmlinux since
51b766c79a3d74 Samuel Holland 2024-10-26  351  		 * vdso symbol addresses are actually used as an offset from
51b766c79a3d74 Samuel Holland 2024-10-26  352  		 * mm->context.vdso in VDSO_OFFSET macro.
51b766c79a3d74 Samuel Holland 2024-10-26  353  		 */
51b766c79a3d74 Samuel Holland 2024-10-26 @354  		if (relocated_addr >= KERNEL_LINK_ADDR)
51b766c79a3d74 Samuel Holland 2024-10-26  355  			relocated_addr += reloc_offset;
51b766c79a3d74 Samuel Holland 2024-10-26  356  
ea2bde36a46d57 Samuel Holland 2024-10-26  357  		*(Elf_Addr *)addr = relocated_addr;
51b766c79a3d74 Samuel Holland 2024-10-26  358  	}
51b766c79a3d74 Samuel Holland 2024-10-26  359  }
51b766c79a3d74 Samuel Holland 2024-10-26  360  #endif /* CONFIG_RELOCATABLE */
51b766c79a3d74 Samuel Holland 2024-10-26  361  

:::::: The code at line 354 was first introduced by commit
:::::: 51b766c79a3d741fb97419c3da1c58fce5e66f0e riscv: Support CONFIG_RELOCATABLE on NOMMU

:::::: TO: Samuel Holland <samuel.holland@sifive.com>
:::::: CC: Palmer Dabbelt <palmer@rivosinc.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


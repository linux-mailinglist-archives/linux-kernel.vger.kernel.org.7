Return-Path: <linux-kernel+bounces-662363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653CBAC39A2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 May 2025 08:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F29207A7B12
	for <lists+linux-kernel@lfdr.de>; Mon, 26 May 2025 06:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256711D5143;
	Mon, 26 May 2025 06:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nhkUieLH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33270149C64
	for <linux-kernel@vger.kernel.org>; Mon, 26 May 2025 06:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748239691; cv=none; b=KmSSlfwzDdNQ3xnYjV8IrPYoH9EnAbHT2p/qsdH86QQ+dJ8i6aUlo0OXYs7VboIdfFNvE2P8eCTUdRyEjGVvEegFtHE/9sQkLqG35vA7l07K2jPEOlWocJoBcEWPPpR9b5Ne/Sx14zwHk9p5r7t/hIZ700moPEutkl4vysNSXpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748239691; c=relaxed/simple;
	bh=CitTfLgHCLjcwiQ20kGZu8ka59r7M8eV51K4PgMBhPw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=QIW8ympwldzH1FpuNKcyxfz6o17aAm2uIudXWG4JUefUH3/mLF6QW6pw3gwusCUAUW81oJ/2IEFM0EvBiTKcTvDpqgewqidYgyDzAOLSemeQa0Nn6m/iOc8Hq0YAEDaQoiSvIZJiII1tE065T7DCFEebHRTAVUX8TFr/iLh7pt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nhkUieLH; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748239689; x=1779775689;
  h=date:from:to:cc:subject:message-id;
  bh=CitTfLgHCLjcwiQ20kGZu8ka59r7M8eV51K4PgMBhPw=;
  b=nhkUieLH9XIybCpVqNajkPT09Lam8/H2lNGRxJIiqV4q4Id/y5EghjbL
   gcYFewLjajpcptGyfd+WWUQmYmIr7d/MvzOQDUm8UDMw8th1VFjElzJgB
   m5Vj4UUlDJjIHDx7Sw/3twQSO65PoXefJq9O48uoZSaL8tPEF5kt0EfpJ
   0045DibudTrGmcvVvKlE4FfcrLenPsM6+h5PjkIfN0FmHs8ial3V5hAXz
   sauPpYSxjrHzLrFPFe5iLmFuac3qViuwandrhThOiXciN6CiuMfDSqEV6
   NbQElGEkfsd76cvO+UCRzNWkIxEEPNVp3CX5oMLQw+fNF1Kx8cuEQlDbJ
   Q==;
X-CSE-ConnectionGUID: mDFyDHWET5eLz8VumQP4lA==
X-CSE-MsgGUID: DMRErzWXSCOgyQWShNCL4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11444"; a="50200789"
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; 
   d="scan'208";a="50200789"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2025 23:08:09 -0700
X-CSE-ConnectionGUID: 2Ls2tqliRt2KsPVwdyBRKQ==
X-CSE-MsgGUID: IrTBnZVETgaJzDZnuTphoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; 
   d="scan'208";a="143176951"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 25 May 2025 23:08:08 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uJR0H-000SBO-1G;
	Mon, 26 May 2025 06:08:05 +0000
Date: Mon, 26 May 2025 14:08:01 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 dccc757f4204250d0e3579bfb60bac4b7910e6fe
Message-ID: <202505261451.FZvkVWDk-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: dccc757f4204250d0e3579bfb60bac4b7910e6fe  Merge branch into tip/master: 'x86/sgx'

elapsed time: 1108m

configs tested: 141
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250525    gcc-12.4.0
arc                   randconfig-002-20250525    gcc-8.5.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                         axm55xx_defconfig    clang-21
arm                                 defconfig    clang-21
arm                             mxs_defconfig    clang-21
arm                   randconfig-001-20250525    clang-21
arm                   randconfig-002-20250525    clang-21
arm                   randconfig-003-20250525    gcc-8.5.0
arm                   randconfig-004-20250525    gcc-7.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250525    clang-21
arm64                 randconfig-002-20250525    gcc-8.5.0
arm64                 randconfig-003-20250525    gcc-6.5.0
arm64                 randconfig-004-20250525    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250525    gcc-14.2.0
csky                  randconfig-002-20250525    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250525    clang-19
hexagon               randconfig-002-20250525    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250525    gcc-11
i386        buildonly-randconfig-002-20250525    clang-20
i386        buildonly-randconfig-003-20250525    gcc-12
i386        buildonly-randconfig-004-20250525    gcc-12
i386        buildonly-randconfig-005-20250525    gcc-12
i386        buildonly-randconfig-006-20250525    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250525    gcc-15.1.0
loongarch             randconfig-002-20250525    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          atari_defconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                        m5407c3_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                       bmips_be_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250525    gcc-6.5.0
nios2                 randconfig-002-20250525    gcc-10.5.0
openrisc                         alldefconfig    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250525    gcc-7.5.0
parisc                randconfig-002-20250525    gcc-11.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                      arches_defconfig    gcc-14.2.0
powerpc                 canyonlands_defconfig    clang-21
powerpc                     rainier_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250525    clang-16
powerpc               randconfig-002-20250525    clang-21
powerpc               randconfig-003-20250525    clang-21
powerpc                    sam440ep_defconfig    gcc-14.2.0
powerpc                     stx_gp3_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250525    clang-21
powerpc64             randconfig-002-20250525    clang-18
powerpc64             randconfig-003-20250525    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250525    clang-21
riscv                 randconfig-002-20250525    clang-21
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250525    clang-19
s390                  randconfig-002-20250525    gcc-7.5.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                          kfr2r09_defconfig    gcc-14.2.0
sh                    randconfig-001-20250525    gcc-6.5.0
sh                    randconfig-002-20250525    gcc-14.2.0
sh                   rts7751r2dplus_defconfig    gcc-14.2.0
sh                          sdk7780_defconfig    gcc-14.2.0
sh                           se7722_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250525    gcc-6.5.0
sparc                 randconfig-002-20250525    gcc-10.3.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250525    gcc-7.5.0
sparc64               randconfig-002-20250525    gcc-13.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250525    clang-18
um                    randconfig-002-20250525    gcc-12
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250525    clang-20
x86_64      buildonly-randconfig-002-20250525    clang-20
x86_64      buildonly-randconfig-003-20250525    clang-20
x86_64      buildonly-randconfig-004-20250525    gcc-12
x86_64      buildonly-randconfig-005-20250525    clang-20
x86_64      buildonly-randconfig-006-20250525    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250525    gcc-9.3.0
xtensa                randconfig-002-20250525    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


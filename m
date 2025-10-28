Return-Path: <linux-kernel+bounces-873696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8CAC14777
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6E111B20379
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D306A30F541;
	Tue, 28 Oct 2025 11:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DbHJzLAo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D2730F94C
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761652075; cv=none; b=G8BlZkE3SFpDchibcUJl/EDHkJQmyMipHY6gJ29q16uOrd8VQCdzPCOHR0QwxkOrq6tPFmpAofx5PibHwQbtMVNfPLJ7QgfQ0659spFNaGbPEY0KRaoGHY6WViQ1sqJafMnLp07cYf2LUmuPIBTxCuooVY7byDy+dfrnlDwWH5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761652075; c=relaxed/simple;
	bh=ZGTX4ynYVxRctizbiuoFYaPQDo6s7B4y++zor9+BM+o=;
	h=Date:From:To:Cc:Subject:Message-ID; b=cvdmXwAutmDa8UWtt/kN0AVC4rt/hPgXOWqU9di2StKLEdufIkf4wM4eViLkvnLQwxLt9enoNT+iXrggAY0DX1yONMrsdsYnYaQx+v5GbAYmNCZ8b/HZSaNO2XQSxEymJhtgs8jyG2YxMM+an8bopZKRpnn3gMbkXLe7cqwCe+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DbHJzLAo; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761652074; x=1793188074;
  h=date:from:to:cc:subject:message-id;
  bh=ZGTX4ynYVxRctizbiuoFYaPQDo6s7B4y++zor9+BM+o=;
  b=DbHJzLAo249GeENGAA9p/w6i72lSTG5pyWWTh/psvpuqutr8sBxoGLaa
   3KwmPtWV1rngRyNupwAjrJkBk8sGY5+M+stbi8yH/hw5/ibjxW1BBxNsz
   PSZAJSlI/L+yNBMjQxiVx4k6CPdA33H+7OzUf3WWw/5pry91Nd7IISLc6
   v9Int8PGE87sQ2zZVxndH3ogliS1RTkDl+B1rHo0auL/YWJU3miDfjGOp
   /AGm0KwmRFV6TajL54jy9dA8IMpOTWvJAoYchR34hIDvwZY+uldry+XXm
   BvSADyT83TDu+oBBonfxYO+1Gc8KAffenQV+6EtEsUQzVymJX84aX4XPZ
   Q==;
X-CSE-ConnectionGUID: 7NXyfjlhTy+TenCR3U2Mqg==
X-CSE-MsgGUID: rNAYGfT7QKGwkaHrJvJJew==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74349850"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="74349850"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 04:47:53 -0700
X-CSE-ConnectionGUID: MoACR3jVRiy1sk26fobdEg==
X-CSE-MsgGUID: P3/y5a4FQfOgaNKPTv1peA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="185242190"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 28 Oct 2025 04:47:52 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vDiAx-000J5c-21;
	Tue, 28 Oct 2025 11:47:45 +0000
Date: Tue, 28 Oct 2025 19:46:35 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/drivers] BUILD SUCCESS
 539d147ef69c3e2f9817de0fcf1dc8ba12938909
Message-ID: <202510281929.Pj9boIeu-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/drivers
branch HEAD: 539d147ef69c3e2f9817de0fcf1dc8ba12938909  irqchip/sifive-plic: Add support for UltraRISC DP1000 PLIC

elapsed time: 1452m

configs tested: 248
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20251027    gcc-8.5.0
arc                   randconfig-001-20251028    gcc-8.5.0
arc                   randconfig-002-20251027    gcc-8.5.0
arc                   randconfig-002-20251028    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                          exynos_defconfig    gcc-15.1.0
arm                   randconfig-001-20251027    clang-22
arm                   randconfig-001-20251028    gcc-8.5.0
arm                   randconfig-002-20251027    clang-22
arm                   randconfig-002-20251028    gcc-8.5.0
arm                   randconfig-003-20251027    gcc-8.5.0
arm                   randconfig-003-20251028    gcc-8.5.0
arm                   randconfig-004-20251027    clang-22
arm                   randconfig-004-20251028    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20251027    clang-22
arm64                 randconfig-001-20251028    gcc-8.5.0
arm64                 randconfig-002-20251027    gcc-12.5.0
arm64                 randconfig-002-20251028    gcc-8.5.0
arm64                 randconfig-003-20251027    gcc-9.5.0
arm64                 randconfig-003-20251028    gcc-8.5.0
arm64                 randconfig-004-20251027    clang-22
arm64                 randconfig-004-20251028    gcc-8.5.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20251027    gcc-14.3.0
csky                  randconfig-001-20251028    gcc-13.4.0
csky                  randconfig-002-20251027    gcc-13.4.0
csky                  randconfig-002-20251028    gcc-13.4.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20251027    clang-22
hexagon               randconfig-001-20251028    gcc-13.4.0
hexagon               randconfig-002-20251027    clang-17
hexagon               randconfig-002-20251028    gcc-13.4.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251027    gcc-13
i386        buildonly-randconfig-001-20251028    gcc-14
i386        buildonly-randconfig-002-20251027    clang-20
i386        buildonly-randconfig-002-20251028    gcc-14
i386        buildonly-randconfig-003-20251027    clang-20
i386        buildonly-randconfig-003-20251028    gcc-14
i386        buildonly-randconfig-004-20251027    gcc-14
i386        buildonly-randconfig-004-20251028    gcc-14
i386        buildonly-randconfig-005-20251027    clang-20
i386        buildonly-randconfig-005-20251028    gcc-14
i386        buildonly-randconfig-006-20251027    clang-20
i386        buildonly-randconfig-006-20251028    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251028    clang-20
i386                  randconfig-002-20251028    clang-20
i386                  randconfig-003-20251028    clang-20
i386                  randconfig-004-20251028    clang-20
i386                  randconfig-005-20251028    clang-20
i386                  randconfig-006-20251028    clang-20
i386                  randconfig-007-20251028    clang-20
i386                  randconfig-011-20251028    gcc-14
i386                  randconfig-012-20251028    gcc-14
i386                  randconfig-013-20251028    gcc-14
i386                  randconfig-014-20251028    gcc-14
i386                  randconfig-015-20251028    gcc-14
i386                  randconfig-016-20251028    gcc-14
i386                  randconfig-017-20251028    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251027    gcc-15.1.0
loongarch             randconfig-001-20251028    gcc-13.4.0
loongarch             randconfig-002-20251027    gcc-13.4.0
loongarch             randconfig-002-20251028    gcc-13.4.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                           virt_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                            allyesconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20251027    gcc-8.5.0
nios2                 randconfig-001-20251028    gcc-13.4.0
nios2                 randconfig-002-20251027    gcc-8.5.0
nios2                 randconfig-002-20251028    gcc-13.4.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251027    gcc-8.5.0
parisc                randconfig-001-20251028    gcc-13.4.0
parisc                randconfig-002-20251027    gcc-12.5.0
parisc                randconfig-002-20251028    gcc-13.4.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                      chrp32_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251027    clang-22
powerpc               randconfig-001-20251028    gcc-13.4.0
powerpc               randconfig-002-20251027    clang-22
powerpc               randconfig-002-20251028    gcc-13.4.0
powerpc               randconfig-003-20251027    gcc-8.5.0
powerpc               randconfig-003-20251028    gcc-13.4.0
powerpc64             randconfig-001-20251027    gcc-8.5.0
powerpc64             randconfig-001-20251028    gcc-13.4.0
powerpc64             randconfig-002-20251027    gcc-10.5.0
powerpc64             randconfig-002-20251028    gcc-13.4.0
powerpc64             randconfig-003-20251027    gcc-10.5.0
powerpc64             randconfig-003-20251028    gcc-13.4.0
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20251027    gcc-13.4.0
riscv                 randconfig-002-20251027    clang-22
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20251027    clang-22
s390                  randconfig-002-20251027    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                            hp6xx_defconfig    gcc-15.1.0
sh                    randconfig-001-20251027    gcc-12.5.0
sh                    randconfig-002-20251027    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                            allyesconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251027    gcc-12.5.0
sparc                 randconfig-002-20251027    gcc-8.5.0
sparc                       sparc32_defconfig    gcc-15.1.0
sparc64                          allmodconfig    clang-22
sparc64                          allyesconfig    gcc-15.1.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251027    gcc-14.3.0
sparc64               randconfig-002-20251027    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251027    clang-22
um                    randconfig-002-20251027    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251027    gcc-14
x86_64      buildonly-randconfig-001-20251028    clang-20
x86_64      buildonly-randconfig-002-20251027    gcc-14
x86_64      buildonly-randconfig-002-20251028    clang-20
x86_64      buildonly-randconfig-003-20251027    gcc-14
x86_64      buildonly-randconfig-003-20251028    clang-20
x86_64      buildonly-randconfig-004-20251027    gcc-14
x86_64      buildonly-randconfig-004-20251028    clang-20
x86_64      buildonly-randconfig-005-20251027    gcc-14
x86_64      buildonly-randconfig-005-20251028    clang-20
x86_64      buildonly-randconfig-006-20251027    gcc-14
x86_64      buildonly-randconfig-006-20251028    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251028    clang-20
x86_64                randconfig-002-20251028    clang-20
x86_64                randconfig-003-20251028    clang-20
x86_64                randconfig-004-20251028    clang-20
x86_64                randconfig-005-20251028    clang-20
x86_64                randconfig-006-20251028    clang-20
x86_64                randconfig-007-20251028    clang-20
x86_64                randconfig-008-20251028    clang-20
x86_64                randconfig-071-20251028    clang-20
x86_64                randconfig-072-20251028    clang-20
x86_64                randconfig-073-20251028    clang-20
x86_64                randconfig-074-20251028    clang-20
x86_64                randconfig-075-20251028    clang-20
x86_64                randconfig-076-20251028    clang-20
x86_64                randconfig-077-20251028    clang-20
x86_64                randconfig-078-20251028    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    gcc-15.1.0
xtensa                       common_defconfig    gcc-15.1.0
xtensa                randconfig-001-20251027    gcc-12.5.0
xtensa                randconfig-002-20251027    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


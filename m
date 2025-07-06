Return-Path: <linux-kernel+bounces-713489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8BDAF5A74
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 16:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 093A97AC52E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 14:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3429285CAE;
	Wed,  2 Jul 2025 14:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eqFXNJvP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1826527EFEC
	for <linux-kernel@vger.kernel.org>; Wed,  2 Jul 2025 14:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751465065; cv=none; b=dmIF1cuPQB1n8oj3lLR0yu28hhvRHApKGx92ybs43dHVaHX6fLr5DUrhAiUhAERJ5n0ae2NK/QFqZ6ajVwJFjb3yvkUfaHQmAPJyUxydZoyy8+gdF+eVyClceAfsaHVD11Ze3Gjxm9QDVoxYSkC2wEf2EOcJiJwo1BmW3souPxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751465065; c=relaxed/simple;
	bh=WcGg9VpJ3HleDybYZbmHSQEFKctc0K650AxIqcgDexQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=u/xJ8p7LnepUtf+GTkkhHmJKeNhgCrepgRBx+m4ghV9YzliAg7t0MVdwTnWCXtM8ZDdTf0Pm9Jsi+tPe++JWfw+dURGJNurC8RLHEl1l0mbGrxV5zM0bgoP4bxnVBCC0idL7ua7c7f8jielPy/kqmZFahg+SjnaIpZPbECOU7ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eqFXNJvP; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751465064; x=1783001064;
  h=date:from:to:cc:subject:message-id;
  bh=WcGg9VpJ3HleDybYZbmHSQEFKctc0K650AxIqcgDexQ=;
  b=eqFXNJvP+i8QK1p+kUK/c3FMnR0WB/sL1P+VmlXDBvAI4WnrtezW2+mB
   hiLgFiqIquOzQxS6vqAFWbZboZ5KVd2zjoyDYMuDe0QdbFap1xig9Dp0n
   kx/Jrzqm69JlC9oGWVTPtzSFtDf18hTyY3gjnwryUD5MvsyYuGqZl1BG/
   HupnkOou/7UVHv7jSz2RkStOlMgneYMS0LSGRCTEkefsT0mxE2K1vfyf6
   pSR/ewNSHk6rSVTNx3cSBwJ3q2+PKxb8454GkEs7uPN13DkUS7g1ld+gc
   kSEsyNGg9wr9Fh2TVvfbfE5hyozMJEHFd77X1wV65qveBQOg0+rWeuA7a
   g==;
X-CSE-ConnectionGUID: KMmeI1NkQU27JYzNZVL0wQ==
X-CSE-MsgGUID: kUhtufslR2u5nxnsLTxTsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="53691189"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="53691189"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 07:04:21 -0700
X-CSE-ConnectionGUID: nXbs90VmQPGsrOUmc6oosA==
X-CSE-MsgGUID: x8tOmuPmRIuLgfI0Uxl8rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="154641440"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 02 Jul 2025 07:04:20 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uWy4Q-0000iL-17;
	Wed, 02 Jul 2025 14:04:18 +0000
Date: Wed, 02 Jul 2025 22:03:49 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/vdso] BUILD SUCCESS
 437079605c26dc7c98586580a8c01b5f7f746a79
Message-ID: <202507022237.qzV4UYUk-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/vdso
branch HEAD: 437079605c26dc7c98586580a8c01b5f7f746a79  selftests: vDSO: vdso_standalone_test_x86: Replace source file with symlink

elapsed time: 1447m

configs tested: 252
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250701    gcc-13.3.0
arc                   randconfig-001-20250702    clang-19
arc                   randconfig-002-20250701    gcc-15.1.0
arc                   randconfig-002-20250702    clang-19
arc                        vdk_hs38_defconfig    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-19
arm                                 defconfig    gcc-15.1.0
arm                          gemini_defconfig    gcc-15.1.0
arm                      integrator_defconfig    gcc-15.1.0
arm                        multi_v7_defconfig    gcc-15.1.0
arm                        mvebu_v7_defconfig    gcc-15.1.0
arm                          pxa3xx_defconfig    clang-18
arm                   randconfig-001-20250701    clang-17
arm                   randconfig-001-20250702    clang-19
arm                   randconfig-002-20250701    gcc-8.5.0
arm                   randconfig-002-20250702    clang-19
arm                   randconfig-003-20250701    clang-21
arm                   randconfig-003-20250702    clang-19
arm                   randconfig-004-20250701    clang-21
arm                   randconfig-004-20250702    clang-19
arm                           tegra_defconfig    clang-18
arm                           u8500_defconfig    gcc-15.1.0
arm                         vf610m4_defconfig    clang-18
arm                         wpcm450_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250701    clang-21
arm64                 randconfig-001-20250702    clang-19
arm64                 randconfig-002-20250701    gcc-15.1.0
arm64                 randconfig-002-20250702    clang-19
arm64                 randconfig-003-20250701    clang-18
arm64                 randconfig-003-20250702    clang-19
arm64                 randconfig-004-20250701    gcc-8.5.0
arm64                 randconfig-004-20250702    clang-19
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250701    gcc-11.5.0
csky                  randconfig-001-20250702    gcc-14.2.0
csky                  randconfig-002-20250701    gcc-10.5.0
csky                  randconfig-002-20250702    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-15.1.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20250701    clang-21
hexagon               randconfig-001-20250702    gcc-14.2.0
hexagon               randconfig-002-20250701    clang-21
hexagon               randconfig-002-20250702    gcc-14.2.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250701    gcc-12
i386        buildonly-randconfig-001-20250702    clang-20
i386        buildonly-randconfig-002-20250701    gcc-12
i386        buildonly-randconfig-002-20250702    clang-20
i386        buildonly-randconfig-003-20250701    gcc-12
i386        buildonly-randconfig-003-20250702    clang-20
i386        buildonly-randconfig-004-20250701    gcc-12
i386        buildonly-randconfig-004-20250702    clang-20
i386        buildonly-randconfig-005-20250701    gcc-12
i386        buildonly-randconfig-005-20250702    clang-20
i386        buildonly-randconfig-006-20250701    clang-20
i386        buildonly-randconfig-006-20250702    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250702    clang-20
i386                  randconfig-002-20250702    clang-20
i386                  randconfig-003-20250702    clang-20
i386                  randconfig-004-20250702    clang-20
i386                  randconfig-005-20250702    clang-20
i386                  randconfig-006-20250702    clang-20
i386                  randconfig-007-20250702    clang-20
i386                  randconfig-011-20250702    gcc-12
i386                  randconfig-012-20250702    gcc-12
i386                  randconfig-013-20250702    gcc-12
i386                  randconfig-014-20250702    gcc-12
i386                  randconfig-015-20250702    gcc-12
i386                  randconfig-016-20250702    gcc-12
i386                  randconfig-017-20250702    gcc-12
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    gcc-15.1.0
loongarch             randconfig-001-20250701    gcc-13.3.0
loongarch             randconfig-001-20250702    gcc-14.2.0
loongarch             randconfig-002-20250701    gcc-15.1.0
loongarch             randconfig-002-20250702    gcc-14.2.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                        m5307c3_defconfig    gcc-15.1.0
m68k                           virt_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           gcw0_defconfig    clang-18
mips                            gpr_defconfig    clang-18
mips                           ip32_defconfig    gcc-15.1.0
mips                         rt305x_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250701    gcc-14.2.0
nios2                 randconfig-001-20250702    gcc-14.2.0
nios2                 randconfig-002-20250701    gcc-13.3.0
nios2                 randconfig-002-20250702    gcc-14.2.0
openrisc                          allnoconfig    clang-21
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
openrisc                 simple_smp_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250701    gcc-14.3.0
parisc                randconfig-001-20250702    gcc-14.2.0
parisc                randconfig-002-20250701    gcc-10.5.0
parisc                randconfig-002-20250702    gcc-14.2.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                          allyesconfig    gcc-15.1.0
powerpc                      chrp32_defconfig    gcc-15.1.0
powerpc                       ebony_defconfig    gcc-15.1.0
powerpc                     mpc512x_defconfig    gcc-15.1.0
powerpc                    mvme5100_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250701    gcc-13.3.0
powerpc               randconfig-001-20250702    gcc-14.2.0
powerpc               randconfig-002-20250701    clang-21
powerpc               randconfig-002-20250702    gcc-14.2.0
powerpc               randconfig-003-20250701    clang-21
powerpc               randconfig-003-20250702    gcc-14.2.0
powerpc                     sequoia_defconfig    clang-18
powerpc                     sequoia_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250701    clang-21
powerpc64             randconfig-001-20250702    gcc-14.2.0
powerpc64             randconfig-002-20250701    clang-21
powerpc64             randconfig-002-20250702    gcc-14.2.0
powerpc64             randconfig-003-20250701    gcc-10.5.0
powerpc64             randconfig-003-20250702    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250701    gcc-14.3.0
riscv                 randconfig-001-20250702    clang-21
riscv                 randconfig-002-20250701    gcc-10.5.0
riscv                 randconfig-002-20250702    clang-21
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250701    gcc-9.3.0
s390                  randconfig-001-20250702    clang-21
s390                  randconfig-002-20250701    clang-17
s390                  randconfig-002-20250702    clang-21
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                        edosk7705_defconfig    gcc-15.1.0
sh                             espt_defconfig    clang-18
sh                             espt_defconfig    gcc-15.1.0
sh                    randconfig-001-20250701    gcc-15.1.0
sh                    randconfig-001-20250702    clang-21
sh                    randconfig-002-20250701    gcc-13.3.0
sh                    randconfig-002-20250702    clang-21
sh                           se7722_defconfig    gcc-15.1.0
sh                     sh7710voipgw_defconfig    gcc-15.1.0
sh                        sh7763rdp_defconfig    gcc-15.1.0
sh                  sh7785lcr_32bit_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250701    gcc-10.3.0
sparc                 randconfig-001-20250702    clang-21
sparc                 randconfig-002-20250701    gcc-15.1.0
sparc                 randconfig-002-20250702    clang-21
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250701    gcc-8.5.0
sparc64               randconfig-001-20250702    clang-21
sparc64               randconfig-002-20250701    gcc-12.4.0
sparc64               randconfig-002-20250702    clang-21
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250701    gcc-12
um                    randconfig-001-20250702    clang-21
um                    randconfig-002-20250701    gcc-12
um                    randconfig-002-20250702    clang-21
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250701    gcc-12
x86_64      buildonly-randconfig-001-20250702    gcc-11
x86_64      buildonly-randconfig-002-20250701    gcc-12
x86_64      buildonly-randconfig-002-20250702    gcc-11
x86_64      buildonly-randconfig-003-20250701    gcc-12
x86_64      buildonly-randconfig-003-20250702    gcc-11
x86_64      buildonly-randconfig-004-20250701    gcc-12
x86_64      buildonly-randconfig-004-20250702    gcc-11
x86_64      buildonly-randconfig-005-20250701    clang-20
x86_64      buildonly-randconfig-005-20250702    gcc-11
x86_64      buildonly-randconfig-006-20250701    clang-20
x86_64      buildonly-randconfig-006-20250702    gcc-11
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-004-20250702    gcc-12
x86_64                randconfig-005-20250702    gcc-12
x86_64                randconfig-006-20250702    gcc-12
x86_64                randconfig-007-20250702    gcc-12
x86_64                randconfig-008-20250702    gcc-12
x86_64                randconfig-071-20250702    clang-20
x86_64                randconfig-072-20250702    clang-20
x86_64                randconfig-073-20250702    clang-20
x86_64                randconfig-074-20250702    clang-20
x86_64                randconfig-075-20250702    clang-20
x86_64                randconfig-076-20250702    clang-20
x86_64                randconfig-077-20250702    clang-20
x86_64                randconfig-078-20250702    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                  cadence_csp_defconfig    gcc-15.1.0
xtensa                randconfig-001-20250701    gcc-15.1.0
xtensa                randconfig-001-20250702    clang-21
xtensa                randconfig-002-20250701    gcc-13.3.0
xtensa                randconfig-002-20250702    clang-21

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


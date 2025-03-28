Return-Path: <linux-kernel+bounces-579807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B04A749BE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 13:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C11A9189A85F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 12:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5590921B19E;
	Fri, 28 Mar 2025 12:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NUZR4aWt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5FE213E7D
	for <linux-kernel@vger.kernel.org>; Fri, 28 Mar 2025 12:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743164647; cv=none; b=log2ZiPjERZgYb9jNRs1a1FkkLRofUFSHlIxjquvSuV2Der37ljfqV3YQ+Svhwz7uskgyVsFKbeOvMlBuJvw9DRFid94kUkrpER3/4QHmLnLGkL+ZgyTtP3YthQucHoiLvuRuPpxPUIBYuytvDj5ySYKpnI0YkTJQT7HfH74Dj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743164647; c=relaxed/simple;
	bh=7WYACMDRMgydEIk+mDBPNxXfyNJZpYVFpKjEGsRAh30=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LIEa1LzsyefYloLbeO73qSj3InOTNJoJi52/ThUU0fJ9AKPA56uOFQ7hKNcoWhh9dP8nDgtoDj1kJaXsRmB2xfOZLMU4DIZyQFev19xcBgl66sgNUyS4TtFBXzxSIfH4uunXMUbDk0vC2PL5/HBAzDpnHt2zy2HEJQvdNkwEsBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NUZR4aWt; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743164645; x=1774700645;
  h=date:from:to:cc:subject:message-id;
  bh=7WYACMDRMgydEIk+mDBPNxXfyNJZpYVFpKjEGsRAh30=;
  b=NUZR4aWthm7/HvQORZYTqMeGe/XKqiKHAVjS2iAK/pZVbcw857T/2biP
   qdshRVb5P31aF0PQdrnx5rt91yL6ElV6EwnPQBIj1yuoTs9HdtXUq6qk5
   cMeh+81Cz45bIP8Xqx9lTEkTKl4Xd0J3igSnCahL+Zt8hqVdzaOSrbu1I
   iL4nbz+Ada91dB7lS2Fszgt5EDEP/9zXvCPpAJMxg5tkK4ulJD9BowmPF
   aED+YF5tZJ+iNIRfn93l2XIBbvN6yFRqbmmHIRDmMXHi4Cm7+pTh9tWtg
   vd0E2db8ZNYDycfu83uuWDL5d3r0gIH1Rn3tLvlg1sCfs9frBKa8BXU/X
   A==;
X-CSE-ConnectionGUID: XK50NqapR2mZznfcHDUUdw==
X-CSE-MsgGUID: kzkgdQNxQcCC2JxWAlFHEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="66996302"
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; 
   d="scan'208";a="66996302"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2025 05:24:05 -0700
X-CSE-ConnectionGUID: 8nS16vI+Q4aRseLSg5uFmA==
X-CSE-MsgGUID: FGJUPuthSn+VQrOVTqsbIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; 
   d="scan'208";a="125198369"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 28 Mar 2025 05:24:04 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ty8kj-0007RI-2d;
	Fri, 28 Mar 2025 12:24:01 +0000
Date: Fri, 28 Mar 2025 20:23:36 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:objtool/urgent] BUILD REGRESSION
 1c9d28fdf70d4ae3e8dfeadee982461403c6bb50
Message-ID: <202503282023.jTYBgviL-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool/urgent
branch HEAD: 1c9d28fdf70d4ae3e8dfeadee982461403c6bb50  objtool: Fix NULL printf() '%s' argument in builtin-check.c:save_argv()

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202503280703.OARM8SrY-lkp@intel.com

    arch/loongarch/kernel/traps.o: warning: objtool: show_stack+0xe0: skipping duplicate warning(s)

Error/Warning ids grouped by kconfigs:

recent_errors
`-- loongarch-randconfig-001-20250328
    `-- arch-loongarch-kernel-traps.o:warning:objtool:show_stack:skipping-duplicate-warning(s)

elapsed time: 1452m

configs tested: 218
configs skipped: 6

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                            hsdk_defconfig    gcc-14.2.0
arc                     nsimosci_hs_defconfig    gcc-14.2.0
arc                   randconfig-001-20250327    gcc-14.2.0
arc                   randconfig-002-20250327    gcc-14.2.0
arc                           tb10x_defconfig    gcc-14.2.0
arm                              alldefconfig    gcc-14.2.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                           h3600_defconfig    clang-21
arm                      integrator_defconfig    clang-21
arm                            mps2_defconfig    clang-21
arm                       multi_v4t_defconfig    clang-16
arm                   randconfig-001-20250327    clang-21
arm                   randconfig-002-20250327    gcc-5.5.0
arm                   randconfig-003-20250327    clang-21
arm                   randconfig-004-20250327    clang-16
arm                       spear13xx_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250327    gcc-5.5.0
arm64                 randconfig-002-20250327    clang-21
arm64                 randconfig-003-20250327    clang-21
arm64                 randconfig-004-20250327    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250327    gcc-9.3.0
csky                  randconfig-002-20250327    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250327    clang-21
hexagon               randconfig-002-20250327    clang-21
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250327    clang-20
i386        buildonly-randconfig-002-20250327    gcc-12
i386        buildonly-randconfig-003-20250327    clang-20
i386        buildonly-randconfig-004-20250327    clang-20
i386        buildonly-randconfig-005-20250327    clang-20
i386        buildonly-randconfig-006-20250327    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250328    gcc-12
i386                  randconfig-002-20250328    gcc-12
i386                  randconfig-003-20250328    gcc-12
i386                  randconfig-004-20250328    gcc-12
i386                  randconfig-005-20250328    gcc-12
i386                  randconfig-006-20250328    gcc-12
i386                  randconfig-007-20250328    gcc-12
i386                  randconfig-011-20250328    clang-20
i386                  randconfig-012-20250328    clang-20
i386                  randconfig-013-20250328    clang-20
i386                  randconfig-014-20250328    clang-20
i386                  randconfig-015-20250328    clang-20
i386                  randconfig-016-20250328    clang-20
i386                  randconfig-017-20250328    clang-20
loongarch                        alldefconfig    gcc-14.2.0
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250327    gcc-14.2.0
loongarch             randconfig-002-20250327    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                       m5208evb_defconfig    clang-21
m68k                            q40_defconfig    gcc-14.2.0
m68k                        stmark2_defconfig    gcc-14.2.0
m68k                          sun3x_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                         bigsur_defconfig    gcc-14.2.0
mips                           ip22_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250327    gcc-11.5.0
nios2                 randconfig-002-20250327    gcc-13.3.0
openrisc                          allnoconfig    clang-15
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-15
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250327    gcc-14.2.0
parisc                randconfig-002-20250327    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-15
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                       holly_defconfig    clang-21
powerpc                      mgcoge_defconfig    gcc-14.2.0
powerpc                 mpc8315_rdb_defconfig    clang-21
powerpc               randconfig-001-20250327    gcc-7.5.0
powerpc               randconfig-002-20250327    gcc-9.3.0
powerpc               randconfig-003-20250327    gcc-5.5.0
powerpc                     redwood_defconfig    clang-21
powerpc                     taishan_defconfig    clang-21
powerpc                     tqm8560_defconfig    clang-21
powerpc                      tqm8xx_defconfig    clang-21
powerpc                         wii_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250327    gcc-9.3.0
powerpc64             randconfig-002-20250327    clang-21
powerpc64             randconfig-003-20250327    clang-16
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    clang-15
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250327    clang-21
riscv                 randconfig-002-20250327    clang-21
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                                defconfig    gcc-12
s390                  randconfig-001-20250327    gcc-6.5.0
s390                  randconfig-002-20250327    clang-16
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-14.2.0
sh                          lboxre2_defconfig    gcc-14.2.0
sh                          polaris_defconfig    clang-21
sh                          r7780mp_defconfig    gcc-14.2.0
sh                          r7785rp_defconfig    gcc-14.2.0
sh                    randconfig-001-20250327    gcc-5.5.0
sh                    randconfig-002-20250327    gcc-9.3.0
sh                          rsk7203_defconfig    gcc-14.2.0
sh                   rts7751r2dplus_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250327    gcc-12.4.0
sparc                 randconfig-002-20250327    gcc-10.3.0
sparc                       sparc64_defconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250327    gcc-6.5.0
sparc64               randconfig-002-20250327    gcc-6.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-15
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250327    clang-19
um                    randconfig-002-20250327    gcc-12
um                           x86_64_defconfig    clang-15
um                           x86_64_defconfig    clang-21
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250327    gcc-12
x86_64      buildonly-randconfig-002-20250327    gcc-12
x86_64      buildonly-randconfig-003-20250327    clang-20
x86_64      buildonly-randconfig-004-20250327    clang-20
x86_64      buildonly-randconfig-005-20250327    gcc-12
x86_64      buildonly-randconfig-006-20250327    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250328    gcc-12
x86_64                randconfig-002-20250328    gcc-12
x86_64                randconfig-003-20250328    gcc-12
x86_64                randconfig-004-20250328    gcc-12
x86_64                randconfig-005-20250328    gcc-12
x86_64                randconfig-006-20250328    gcc-12
x86_64                randconfig-007-20250328    gcc-12
x86_64                randconfig-008-20250328    gcc-12
x86_64                randconfig-071-20250328    clang-20
x86_64                randconfig-072-20250328    clang-20
x86_64                randconfig-073-20250328    clang-20
x86_64                randconfig-074-20250328    clang-20
x86_64                randconfig-075-20250328    clang-20
x86_64                randconfig-076-20250328    clang-20
x86_64                randconfig-077-20250328    clang-20
x86_64                randconfig-078-20250328    clang-20
x86_64                               rhel-9.4    clang-20
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250327    gcc-14.2.0
xtensa                randconfig-002-20250327    gcc-6.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


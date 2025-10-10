Return-Path: <linux-kernel+bounces-847851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B943BCBE32
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D8C3C353396
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 07:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAB925A642;
	Fri, 10 Oct 2025 07:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VtcPEfKy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5BC1991D2
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760080446; cv=none; b=ZHdA+e+c21bkrcnqKIprM42l7Blf9ms7CEuQwypWHxP2tNew5gDuerOmV6O46Df2rWkP8Ijq686PQuAJ7y1K+3QV+H8aI/earX91mPHpn4CK/umCoOx2PWG5LMByLOYbHHdVLQuhjjx0WXsF30oTP12zmdVGP8e2fTvQ9agI0Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760080446; c=relaxed/simple;
	bh=TS2CMYTMs0wuY1tlF9l8hax/RYdwjgZ6VagXnPWmpsY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Aw6bivAyG0O35bHFhhv2GMesWe8cTwKv8InrjXRAJnfFr4vO4qSOgIOKGMaN/+mGeFLiWF8rlFZN2k9upRlh4AXa0C5U9oHTBe/GBpoS3H6Ua7721BeZeV5iXarKrx379BcuJ12oAaF6K4ALG3r2vUHloEJxGIyIhdeMfZR8S/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VtcPEfKy; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760080445; x=1791616445;
  h=date:from:to:cc:subject:message-id;
  bh=TS2CMYTMs0wuY1tlF9l8hax/RYdwjgZ6VagXnPWmpsY=;
  b=VtcPEfKyeZkujUzRMas5oS81qiUVMJZsVPkxqqtq56ppLTH3seJF5AdS
   X3sG+7MKAI+nq68PyswLzxoChEeGfj6N0X8+79LPcooV22/sekR06X5By
   vW1MjJvHdSZc+e5a08RxZuTHscW9ETxKiVf1J24RSArTxjjfD0rU6PD+b
   5c/7Xx9ueNwu5k5JyvDoQInAXrfRHlUbdhjZLoTlbpyrmfwztWH+sU7Op
   ma3DN5C4XO+c9FUTWGzabPFdPFq8YzIyawa44SRFVYn7/5K1V2kPcBEeF
   2gT+1d14q6lQspeAZ3WRe3roJ1hIZf4VAq8IdtTRnIVL+jiAyxXut7DOl
   Q==;
X-CSE-ConnectionGUID: yM+B599SRiuj1SFm9mkA/w==
X-CSE-MsgGUID: KE/G84IHRj+nYG7teRswAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="73732447"
X-IronPort-AV: E=Sophos;i="6.19,218,1754982000"; 
   d="scan'208";a="73732447"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 00:14:03 -0700
X-CSE-ConnectionGUID: 6blLlS2DQPCG/uj74ehyCw==
X-CSE-MsgGUID: q4KiHBg9Q06V72nuB89LfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,218,1754982000"; 
   d="scan'208";a="180019898"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 10 Oct 2025 00:14:01 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v77KA-0002OF-22;
	Fri, 10 Oct 2025 07:13:58 +0000
Date: Fri, 10 Oct 2025 15:13:19 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/core] BUILD REGRESSION
 6c6e6a5416471498d8aafc050110bec9467e4da7
Message-ID: <202510101512.ahEFplWJ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
branch HEAD: 6c6e6a5416471498d8aafc050110bec9467e4da7  Merge branch 'linus' into x86/core, to resolve conflicts

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202510092124.O2IX0Jek-lkp@intel.com

    vmlinux.o: warning: objtool: rcar_pcie_probe+0x13e: no-cfi indirect call!

Error/Warning ids grouped by kconfigs:

recent_errors
`-- x86_64-buildonly-randconfig-001-20251009
    `-- vmlinux.o:warning:objtool:rcar_pcie_probe:no-cfi-indirect-call

elapsed time: 1462m

configs tested: 237
configs skipped: 5

tested configs:
alpha                             allnoconfig    clang-22
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20251009    gcc-11.5.0
arc                   randconfig-001-20251010    gcc-8.5.0
arc                   randconfig-002-20251009    gcc-14.3.0
arc                   randconfig-002-20251010    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                         bcm2835_defconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                      integrator_defconfig    gcc-15.1.0
arm                   randconfig-001-20251009    gcc-10.5.0
arm                   randconfig-001-20251010    gcc-8.5.0
arm                   randconfig-002-20251009    gcc-11.5.0
arm                   randconfig-002-20251010    gcc-8.5.0
arm                   randconfig-003-20251009    gcc-11.5.0
arm                   randconfig-003-20251010    gcc-8.5.0
arm                   randconfig-004-20251009    gcc-12.5.0
arm                   randconfig-004-20251010    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                               defconfig    clang-19
arm64                 randconfig-001-20251009    gcc-8.5.0
arm64                 randconfig-001-20251010    gcc-8.5.0
arm64                 randconfig-002-20251009    gcc-14.3.0
arm64                 randconfig-002-20251010    gcc-8.5.0
arm64                 randconfig-003-20251009    gcc-9.5.0
arm64                 randconfig-003-20251010    gcc-8.5.0
arm64                 randconfig-004-20251009    gcc-8.5.0
arm64                 randconfig-004-20251010    gcc-8.5.0
csky                              allnoconfig    clang-22
csky                                defconfig    clang-19
csky                  randconfig-001-20251009    gcc-13.4.0
csky                  randconfig-001-20251010    gcc-14.3.0
csky                  randconfig-002-20251009    gcc-15.1.0
csky                  randconfig-002-20251010    gcc-14.3.0
hexagon                          alldefconfig    clang-22
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20251009    clang-16
hexagon               randconfig-001-20251010    gcc-14.3.0
hexagon               randconfig-002-20251009    clang-19
hexagon               randconfig-002-20251010    gcc-14.3.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20251010    gcc-14
i386        buildonly-randconfig-002-20251010    clang-20
i386        buildonly-randconfig-002-20251010    gcc-14
i386        buildonly-randconfig-003-20251010    clang-20
i386        buildonly-randconfig-003-20251010    gcc-14
i386        buildonly-randconfig-004-20251010    gcc-14
i386        buildonly-randconfig-005-20251010    gcc-14
i386        buildonly-randconfig-006-20251010    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251010    clang-20
i386                  randconfig-002-20251010    clang-20
i386                  randconfig-003-20251010    clang-20
i386                  randconfig-004-20251010    clang-20
i386                  randconfig-005-20251010    clang-20
i386                  randconfig-006-20251010    clang-20
i386                  randconfig-007-20251010    clang-20
i386                  randconfig-011-20251010    gcc-14
i386                  randconfig-012-20251010    gcc-14
i386                  randconfig-013-20251010    gcc-14
i386                  randconfig-014-20251010    gcc-14
i386                  randconfig-015-20251010    gcc-14
i386                  randconfig-016-20251010    gcc-14
i386                  randconfig-017-20251010    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251009    gcc-15.1.0
loongarch             randconfig-001-20251010    gcc-14.3.0
loongarch             randconfig-002-20251009    gcc-15.1.0
loongarch             randconfig-002-20251010    gcc-14.3.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                          sun3x_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          eyeq5_defconfig    clang-22
mips                           gcw0_defconfig    gcc-15.1.0
mips                           ip22_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20251009    gcc-8.5.0
nios2                 randconfig-001-20251010    gcc-14.3.0
nios2                 randconfig-002-20251009    gcc-11.5.0
nios2                 randconfig-002-20251010    gcc-14.3.0
openrisc                          allnoconfig    clang-22
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
openrisc                  or1klitex_defconfig    clang-22
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251009    gcc-8.5.0
parisc                randconfig-001-20251010    gcc-14.3.0
parisc                randconfig-002-20251009    gcc-9.5.0
parisc                randconfig-002-20251010    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                          allyesconfig    clang-22
powerpc                      mgcoge_defconfig    clang-22
powerpc                      pasemi_defconfig    clang-22
powerpc               randconfig-001-20251009    gcc-8.5.0
powerpc               randconfig-001-20251010    gcc-14.3.0
powerpc               randconfig-002-20251009    gcc-11.5.0
powerpc               randconfig-002-20251010    gcc-14.3.0
powerpc               randconfig-003-20251009    gcc-8.5.0
powerpc               randconfig-003-20251010    gcc-14.3.0
powerpc64             randconfig-001-20251010    gcc-14.3.0
powerpc64             randconfig-002-20251009    clang-22
powerpc64             randconfig-002-20251010    gcc-14.3.0
powerpc64             randconfig-003-20251009    clang-22
powerpc64             randconfig-003-20251010    gcc-14.3.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-14
riscv                    nommu_k210_defconfig    gcc-15.1.0
riscv                 randconfig-001-20251009    gcc-8.5.0
riscv                 randconfig-001-20251010    gcc-9.5.0
riscv                 randconfig-002-20251009    clang-19
riscv                 randconfig-002-20251010    gcc-9.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20251009    clang-22
s390                  randconfig-001-20251010    gcc-9.5.0
s390                  randconfig-002-20251009    clang-22
s390                  randconfig-002-20251010    gcc-9.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20251009    gcc-15.1.0
sh                    randconfig-001-20251010    gcc-9.5.0
sh                    randconfig-002-20251009    gcc-12.5.0
sh                    randconfig-002-20251010    gcc-9.5.0
sh                           se7721_defconfig    clang-22
sh                            shmin_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251009    gcc-8.5.0
sparc                 randconfig-001-20251010    gcc-9.5.0
sparc                 randconfig-002-20251009    gcc-8.5.0
sparc                 randconfig-002-20251010    gcc-9.5.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251009    clang-22
sparc64               randconfig-001-20251010    gcc-9.5.0
sparc64               randconfig-002-20251009    clang-22
sparc64               randconfig-002-20251010    gcc-9.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251009    clang-17
um                    randconfig-001-20251010    gcc-9.5.0
um                    randconfig-002-20251009    gcc-14
um                    randconfig-002-20251010    gcc-9.5.0
um                           x86_64_defconfig    gcc-14
um                           x86_64_defconfig    gcc-15.1.0
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251010    clang-20
x86_64      buildonly-randconfig-001-20251010    gcc-14
x86_64      buildonly-randconfig-002-20251010    clang-20
x86_64      buildonly-randconfig-002-20251010    gcc-14
x86_64      buildonly-randconfig-003-20251010    clang-20
x86_64      buildonly-randconfig-003-20251010    gcc-14
x86_64      buildonly-randconfig-004-20251010    clang-20
x86_64      buildonly-randconfig-004-20251010    gcc-14
x86_64      buildonly-randconfig-005-20251010    gcc-14
x86_64      buildonly-randconfig-006-20251010    gcc-14
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251010    clang-20
x86_64                randconfig-002-20251010    clang-20
x86_64                randconfig-003-20251010    clang-20
x86_64                randconfig-004-20251010    clang-20
x86_64                randconfig-005-20251010    clang-20
x86_64                randconfig-006-20251010    clang-20
x86_64                randconfig-007-20251010    clang-20
x86_64                randconfig-008-20251010    clang-20
x86_64                randconfig-071-20251010    clang-20
x86_64                randconfig-072-20251010    clang-20
x86_64                randconfig-073-20251010    clang-20
x86_64                randconfig-074-20251010    clang-20
x86_64                randconfig-075-20251010    clang-20
x86_64                randconfig-076-20251010    clang-20
x86_64                randconfig-077-20251010    clang-20
x86_64                randconfig-078-20251010    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                generic_kc705_defconfig    gcc-15.1.0
xtensa                randconfig-001-20251009    gcc-11.5.0
xtensa                randconfig-001-20251010    gcc-9.5.0
xtensa                randconfig-002-20251009    gcc-8.5.0
xtensa                randconfig-002-20251010    gcc-9.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


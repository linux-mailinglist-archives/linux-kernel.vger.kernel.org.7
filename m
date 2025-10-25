Return-Path: <linux-kernel+bounces-869760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20129C08ACC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 06:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE2B21AA77FE
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 04:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AE128C5D9;
	Sat, 25 Oct 2025 04:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D5N+9nJH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AA51E991B
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 04:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761366544; cv=none; b=MW+h6HdlM1/K0/amh8VACzx1G/FpF7po5hf6Zl7SRedh6ekj5yd5Kpe9vxJh7Yz615QQ4E0+K9oKQ8uNw0CtEPKQCLRdG9BHJ0gcOSJ12aKx8IYQpJcLwtc76myvoPB2yfQJ+GuFftgUsIfKnvysZ89SYVr6YUbbI4Ot4+Ury9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761366544; c=relaxed/simple;
	bh=kIXkZz0Y8Rea2WHblDG/I1dwo/golO+KFLQBc5Xnyjc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hnYLR9Uu2oBmngPRrEC8PpmjG/ADHg2NgwTvGH/zdDUrjuR/qNo9eVX5eGhPtKiJT7WDgBLQeYiHx60jNjQ/6Yt5GnOgN+lTkzDY7bSyuB0HgoI4gnFVETpxcnxZCU+8jPb/Jo0yVoBengxtews5kvxsnDuEXGQ0AD92V4UgPjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D5N+9nJH; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761366542; x=1792902542;
  h=date:from:to:cc:subject:message-id;
  bh=kIXkZz0Y8Rea2WHblDG/I1dwo/golO+KFLQBc5Xnyjc=;
  b=D5N+9nJHe8SIfTONqc8XIcsqor++4KKm+tgxCHu9iNpmcmyy1O21puEl
   WihyCCyMciJKyROwln/momuiS1cbKGgJGYX+yGY8tH3ZK2Q84Lbaky2At
   JMJFD3MvZ5hOLp5uV2tbYRSW2aCugzkMd3TdGlZzm8CkLecK6gpIkxGyE
   eB3RcJyKXl4Z5p5sw0eylV0Mz7H9/oXDV+jw9oY2gEHsWlVdeVih4HVa6
   FB2WzbhByLPZku5mxltj9bv5D5efMXP/o0JPfoGRqsyjI/nPf6Fp12jBc
   0kd8iluUQ+VEQ6KJw1QO2pZuQwboj3FjFg/OXGPeAWuGOmEaED+XIAla0
   w==;
X-CSE-ConnectionGUID: radA3B8iSUG8LCjsWkQbIw==
X-CSE-MsgGUID: FBZmUq1zRjuIdWKK4ByTMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="89012175"
X-IronPort-AV: E=Sophos;i="6.19,254,1754982000"; 
   d="scan'208";a="89012175"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 21:29:00 -0700
X-CSE-ConnectionGUID: zPXGoajpRMyyzA7N3e7OIw==
X-CSE-MsgGUID: jkqwwOQVRo+9veSH5OP8fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,254,1754982000"; 
   d="scan'208";a="185347070"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 24 Oct 2025 21:28:59 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vCVth-000F77-1G;
	Sat, 25 Oct 2025 04:28:57 +0000
Date: Sat, 25 Oct 2025 12:28:56 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 ef3330b99c01bda53f2a189b58bed8f6b7397f28
Message-ID: <202510251251.cQjKEYDY-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
branch HEAD: ef3330b99c01bda53f2a189b58bed8f6b7397f28  genirq/manage: Add buslock back in to enable_irq()

elapsed time: 1059m

configs tested: 248
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-22
arc                              allyesconfig    clang-19
arc                                 defconfig    clang-19
arc                   randconfig-001-20251024    gcc-8.5.0
arc                   randconfig-001-20251025    clang-22
arc                   randconfig-002-20251024    gcc-14.3.0
arc                   randconfig-002-20251025    clang-22
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                            hisi_defconfig    clang-22
arm                   randconfig-001-20251024    clang-20
arm                   randconfig-001-20251025    clang-22
arm                   randconfig-002-20251024    gcc-15.1.0
arm                   randconfig-002-20251025    clang-22
arm                   randconfig-003-20251024    clang-22
arm                   randconfig-003-20251025    clang-22
arm                   randconfig-004-20251024    clang-22
arm                   randconfig-004-20251025    clang-22
arm                           sama7_defconfig    clang-22
arm                        spear6xx_defconfig    clang-22
arm                           sunxi_defconfig    clang-22
arm                           u8500_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                            allyesconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20251024    gcc-8.5.0
arm64                 randconfig-001-20251025    clang-22
arm64                 randconfig-002-20251024    clang-16
arm64                 randconfig-002-20251025    clang-22
arm64                 randconfig-003-20251024    gcc-13.4.0
arm64                 randconfig-003-20251025    clang-22
arm64                 randconfig-004-20251024    clang-17
arm64                 randconfig-004-20251025    clang-22
csky                             alldefconfig    clang-22
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    clang-22
csky                             allyesconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20251024    gcc-14.3.0
csky                  randconfig-001-20251025    gcc-10.5.0
csky                  randconfig-002-20251024    gcc-11.5.0
csky                  randconfig-002-20251025    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20251024    clang-22
hexagon               randconfig-001-20251025    gcc-10.5.0
hexagon               randconfig-002-20251024    clang-22
hexagon               randconfig-002-20251025    gcc-10.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20251024    clang-20
i386        buildonly-randconfig-001-20251025    clang-20
i386        buildonly-randconfig-002-20251024    gcc-14
i386        buildonly-randconfig-002-20251025    clang-20
i386        buildonly-randconfig-003-20251024    clang-20
i386        buildonly-randconfig-003-20251025    clang-20
i386        buildonly-randconfig-004-20251024    gcc-14
i386        buildonly-randconfig-004-20251025    clang-20
i386        buildonly-randconfig-005-20251024    gcc-14
i386        buildonly-randconfig-005-20251025    clang-20
i386        buildonly-randconfig-006-20251024    gcc-14
i386        buildonly-randconfig-006-20251025    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20251025    clang-20
i386                  randconfig-002-20251025    clang-20
i386                  randconfig-003-20251025    clang-20
i386                  randconfig-004-20251025    clang-20
i386                  randconfig-005-20251025    clang-20
i386                  randconfig-006-20251025    clang-20
i386                  randconfig-007-20251025    clang-20
i386                  randconfig-011-20251025    gcc-14
i386                  randconfig-012-20251025    gcc-14
i386                  randconfig-013-20251025    gcc-14
i386                  randconfig-014-20251025    gcc-14
i386                  randconfig-015-20251025    gcc-14
i386                  randconfig-016-20251025    gcc-14
i386                  randconfig-017-20251025    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                        allyesconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251024    gcc-15.1.0
loongarch             randconfig-001-20251025    gcc-10.5.0
loongarch             randconfig-002-20251024    gcc-15.1.0
loongarch             randconfig-002-20251025    gcc-10.5.0
m68k                             allmodconfig    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                          ath25_defconfig    clang-22
mips                        vocore2_defconfig    clang-22
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                            allyesconfig    clang-22
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20251024    gcc-11.5.0
nios2                 randconfig-001-20251025    gcc-10.5.0
nios2                 randconfig-002-20251024    gcc-11.5.0
nios2                 randconfig-002-20251025    gcc-10.5.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251024    gcc-9.5.0
parisc                randconfig-001-20251025    gcc-10.5.0
parisc                randconfig-002-20251024    gcc-13.4.0
parisc                randconfig-002-20251025    gcc-10.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                    amigaone_defconfig    clang-22
powerpc                       ebony_defconfig    clang-22
powerpc                     mpc5200_defconfig    clang-22
powerpc                 mpc836x_rdk_defconfig    clang-22
powerpc               randconfig-001-20251024    gcc-8.5.0
powerpc               randconfig-001-20251025    gcc-10.5.0
powerpc               randconfig-002-20251024    clang-17
powerpc               randconfig-002-20251025    gcc-10.5.0
powerpc               randconfig-003-20251024    clang-16
powerpc               randconfig-003-20251025    gcc-10.5.0
powerpc64             randconfig-001-20251024    gcc-12.5.0
powerpc64             randconfig-001-20251025    gcc-10.5.0
powerpc64             randconfig-002-20251024    gcc-14.3.0
powerpc64             randconfig-002-20251025    gcc-10.5.0
powerpc64             randconfig-003-20251024    gcc-8.5.0
powerpc64             randconfig-003-20251025    gcc-10.5.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20251024    clang-22
riscv                 randconfig-001-20251025    clang-22
riscv                 randconfig-002-20251024    clang-22
riscv                 randconfig-002-20251025    clang-22
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20251024    gcc-13.4.0
s390                  randconfig-001-20251025    clang-22
s390                  randconfig-002-20251024    clang-22
s390                  randconfig-002-20251025    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20251024    gcc-12.5.0
sh                    randconfig-001-20251025    clang-22
sh                    randconfig-002-20251024    gcc-14.3.0
sh                    randconfig-002-20251025    clang-22
sh                      rts7751r2d1_defconfig    clang-22
sh                   sh7724_generic_defconfig    clang-22
sh                            titan_defconfig    clang-22
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                            allyesconfig    clang-22
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251024    gcc-12.5.0
sparc                 randconfig-001-20251025    clang-22
sparc                 randconfig-002-20251024    gcc-8.5.0
sparc                 randconfig-002-20251025    clang-22
sparc64                          allmodconfig    clang-22
sparc64                          allyesconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251024    clang-20
sparc64               randconfig-001-20251025    clang-22
sparc64               randconfig-002-20251024    clang-22
sparc64               randconfig-002-20251025    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251024    gcc-14
um                    randconfig-001-20251025    clang-22
um                    randconfig-002-20251024    clang-22
um                    randconfig-002-20251025    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251024    clang-20
x86_64      buildonly-randconfig-001-20251025    clang-20
x86_64      buildonly-randconfig-002-20251024    clang-20
x86_64      buildonly-randconfig-002-20251025    clang-20
x86_64      buildonly-randconfig-003-20251024    clang-20
x86_64      buildonly-randconfig-003-20251025    clang-20
x86_64      buildonly-randconfig-004-20251024    gcc-14
x86_64      buildonly-randconfig-004-20251025    clang-20
x86_64      buildonly-randconfig-005-20251024    gcc-14
x86_64      buildonly-randconfig-005-20251025    clang-20
x86_64      buildonly-randconfig-006-20251024    clang-20
x86_64      buildonly-randconfig-006-20251025    clang-20
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251025    clang-20
x86_64                randconfig-002-20251025    clang-20
x86_64                randconfig-003-20251025    clang-20
x86_64                randconfig-004-20251025    clang-20
x86_64                randconfig-005-20251025    clang-20
x86_64                randconfig-006-20251025    clang-20
x86_64                randconfig-007-20251025    clang-20
x86_64                randconfig-008-20251025    clang-20
x86_64                randconfig-071-20251025    clang-20
x86_64                randconfig-072-20251025    clang-20
x86_64                randconfig-073-20251025    clang-20
x86_64                randconfig-074-20251025    clang-20
x86_64                randconfig-075-20251025    clang-20
x86_64                randconfig-076-20251025    clang-20
x86_64                randconfig-077-20251025    clang-20
x86_64                randconfig-078-20251025    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20251024    gcc-11.5.0
xtensa                randconfig-001-20251025    clang-22
xtensa                randconfig-002-20251024    gcc-13.4.0
xtensa                randconfig-002-20251025    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-kernel+bounces-826241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 109F1B8DF71
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 18:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C110817C042
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 16:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8752215F6B;
	Sun, 21 Sep 2025 16:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X4JTUQms"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FB417AE11
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 16:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758471919; cv=none; b=jLduVCIfY1fMbjUsNpZz0Apus+m6lzR3nXGgLoLSlBn65+xktdFRfO/WGfytzKOI0ppwh1AN0TnRppaNZDOJLD7+glix9LxKdKKNHVE13MiOxmbHOsrp2rGZcbjYdsqQG2BeDsgk1E+OaI3puMd+lHDz6rVea0/mOCzq+bmE9IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758471919; c=relaxed/simple;
	bh=mSicT7Tl6JzC3dXbYYPIrCOFu71CL4Zym6nwdDZ63s4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=atvowZrxko4ai6BrJk8wPYS8yMB+Tb2AzcGD+AoE6Eyu/vv7cKrwsipBrcQ1dz8EElhBRYDUw143/g6w/4rQ/IzB7HAEwFKZitbMY6B4HLIuQISOC7xS2+jD70SdZK7XuItbZ8Fa8Zvjyxmqm1P5EeXdRIgXOQMW47TQpm5pnBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X4JTUQms; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758471918; x=1790007918;
  h=date:from:to:cc:subject:message-id;
  bh=mSicT7Tl6JzC3dXbYYPIrCOFu71CL4Zym6nwdDZ63s4=;
  b=X4JTUQmszSfAmqjTkmPQ98t6pXSa549MFzTtqJ9eey6o3RlD3OMn23Xl
   YsvJhBBroFZ+ugr4G1tnXbRgqW5ri8Ejs/+W6ckphbOyGFCS/nLQsG31T
   P7w1UKgbROSguAaQx8oZlKZUG4204x036HzcFSz+XFb1fsl6VS67Df5TR
   lm4HWVZbDGad+4MSVaGad4kLQJmXEoHG/nUD1PcOcpvEa2pRoON7E7MbO
   mm+92Gy7Ez0PGdm/U2d7RfftE5NgxiXMj1Zchel16U5qsKcLfwzveCKXV
   3BEoXffBuNUER5mK8zvxN2a1sUj4n2sF5S0yHRJiqS2Z9Tixj+iwWRsmu
   w==;
X-CSE-ConnectionGUID: oURXIn30RnqJ2zzmwWgNkQ==
X-CSE-MsgGUID: rDDj20sEQQ2ezh6N9LEBhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11560"; a="71852282"
X-IronPort-AV: E=Sophos;i="6.18,283,1751266800"; 
   d="scan'208";a="71852282"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2025 09:25:17 -0700
X-CSE-ConnectionGUID: 1xFqN9ePT7+mzb41g1zt1g==
X-CSE-MsgGUID: NNa7EiaGSr+jfcWgG/ZI0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,283,1751266800"; 
   d="scan'208";a="176191884"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 21 Sep 2025 09:25:15 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v0MsD-0000t9-0d;
	Sun, 21 Sep 2025 16:25:13 +0000
Date: Mon, 22 Sep 2025 00:25:09 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:locking/urgent] BUILD SUCCESS
 b549113738e8c751b613118032a724b772aa83f2
Message-ID: <202509220055.XD82m5ks-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/urgent
branch HEAD: b549113738e8c751b613118032a724b772aa83f2  futex: Prevent use-after-free during requeue-PI

elapsed time: 1452m

configs tested: 247
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                     haps_hs_smp_defconfig    clang-22
arc                            hsdk_defconfig    clang-22
arc                   randconfig-001-20250921    gcc-14.3.0
arc                   randconfig-002-20250921    gcc-12.5.0
arc                   randconfig-002-20250921    gcc-14.3.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                          gemini_defconfig    clang-22
arm                           h3600_defconfig    gcc-15.1.0
arm                      integrator_defconfig    clang-18
arm                        multi_v5_defconfig    clang-18
arm                   randconfig-001-20250921    gcc-11.5.0
arm                   randconfig-001-20250921    gcc-14.3.0
arm                   randconfig-002-20250921    clang-16
arm                   randconfig-002-20250921    gcc-14.3.0
arm                   randconfig-003-20250921    gcc-14.3.0
arm                   randconfig-003-20250921    gcc-8.5.0
arm                   randconfig-004-20250921    clang-22
arm                   randconfig-004-20250921    gcc-14.3.0
arm                         s3c6400_defconfig    clang-22
arm                          sp7021_defconfig    clang-18
arm                        vexpress_defconfig    clang-18
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250921    clang-22
arm64                 randconfig-001-20250921    gcc-14.3.0
arm64                 randconfig-002-20250921    gcc-14.3.0
arm64                 randconfig-002-20250921    gcc-8.5.0
arm64                 randconfig-003-20250921    clang-22
arm64                 randconfig-003-20250921    gcc-14.3.0
arm64                 randconfig-004-20250921    gcc-14.3.0
arm64                 randconfig-004-20250921    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250921    clang-22
csky                  randconfig-001-20250921    gcc-9.5.0
csky                  randconfig-002-20250921    clang-22
csky                  randconfig-002-20250921    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250921    clang-20
hexagon               randconfig-001-20250921    clang-22
hexagon               randconfig-002-20250921    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20250921    gcc-14
i386        buildonly-randconfig-002-20250921    clang-20
i386        buildonly-randconfig-003-20250921    gcc-12
i386        buildonly-randconfig-004-20250921    gcc-14
i386        buildonly-randconfig-005-20250921    gcc-14
i386        buildonly-randconfig-006-20250921    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20250921    gcc-14
i386                  randconfig-002-20250921    gcc-14
i386                  randconfig-003-20250921    gcc-14
i386                  randconfig-004-20250921    gcc-14
i386                  randconfig-005-20250921    gcc-14
i386                  randconfig-006-20250921    gcc-14
i386                  randconfig-007-20250921    gcc-14
i386                  randconfig-011-20250921    clang-20
i386                  randconfig-012-20250921    clang-20
i386                  randconfig-013-20250921    clang-20
i386                  randconfig-014-20250921    clang-20
i386                  randconfig-015-20250921    clang-20
i386                  randconfig-016-20250921    clang-20
i386                  randconfig-017-20250921    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250921    clang-18
loongarch             randconfig-001-20250921    clang-22
loongarch             randconfig-002-20250921    clang-18
loongarch             randconfig-002-20250921    clang-22
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                       m5475evb_defconfig    gcc-15.1.0
m68k                            mac_defconfig    gcc-15.1.0
m68k                        mvme16x_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          rb532_defconfig    clang-18
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250921    clang-22
nios2                 randconfig-001-20250921    gcc-8.5.0
nios2                 randconfig-002-20250921    clang-22
nios2                 randconfig-002-20250921    gcc-8.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250921    clang-22
parisc                randconfig-001-20250921    gcc-8.5.0
parisc                randconfig-002-20250921    clang-22
parisc                randconfig-002-20250921    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                      cm5200_defconfig    clang-22
powerpc                    ge_imp3a_defconfig    clang-22
powerpc                 mpc8315_rdb_defconfig    clang-18
powerpc               randconfig-001-20250921    clang-22
powerpc               randconfig-001-20250921    gcc-12.5.0
powerpc               randconfig-002-20250921    clang-22
powerpc               randconfig-002-20250921    gcc-8.5.0
powerpc               randconfig-003-20250921    clang-22
powerpc64             randconfig-002-20250921    clang-22
powerpc64             randconfig-002-20250921    gcc-15.1.0
powerpc64             randconfig-003-20250921    clang-22
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv             nommu_k210_sdcard_defconfig    gcc-15.1.0
riscv                 randconfig-001-20250921    clang-22
riscv                 randconfig-001-20250921    gcc-8.5.0
riscv                 randconfig-002-20250921    gcc-12.5.0
riscv                 randconfig-002-20250921    gcc-8.5.0
s390                             alldefconfig    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20250921    clang-20
s390                  randconfig-001-20250921    gcc-8.5.0
s390                  randconfig-002-20250921    clang-22
s390                  randconfig-002-20250921    gcc-8.5.0
sh                               alldefconfig    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         ap325rxa_defconfig    clang-18
sh                                  defconfig    gcc-14
sh                    randconfig-001-20250921    gcc-15.1.0
sh                    randconfig-001-20250921    gcc-8.5.0
sh                    randconfig-002-20250921    gcc-15.1.0
sh                    randconfig-002-20250921    gcc-8.5.0
sh                              ul2_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250921    gcc-13.4.0
sparc                 randconfig-001-20250921    gcc-8.5.0
sparc                 randconfig-002-20250921    gcc-8.5.0
sparc                       sparc32_defconfig    clang-18
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20250921    clang-22
sparc64               randconfig-001-20250921    gcc-8.5.0
sparc64               randconfig-002-20250921    clang-22
sparc64               randconfig-002-20250921    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250921    gcc-14
um                    randconfig-001-20250921    gcc-8.5.0
um                    randconfig-002-20250921    gcc-14
um                    randconfig-002-20250921    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250921    clang-20
x86_64      buildonly-randconfig-002-20250921    clang-20
x86_64      buildonly-randconfig-003-20250921    clang-20
x86_64      buildonly-randconfig-004-20250921    clang-20
x86_64      buildonly-randconfig-004-20250921    gcc-14
x86_64      buildonly-randconfig-005-20250921    clang-20
x86_64      buildonly-randconfig-006-20250921    clang-20
x86_64      buildonly-randconfig-006-20250921    gcc-14
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250921    gcc-14
x86_64                randconfig-002-20250921    gcc-14
x86_64                randconfig-003-20250921    gcc-14
x86_64                randconfig-004-20250921    gcc-14
x86_64                randconfig-005-20250921    gcc-14
x86_64                randconfig-006-20250921    gcc-14
x86_64                randconfig-007-20250921    gcc-14
x86_64                randconfig-008-20250921    gcc-14
x86_64                randconfig-071-20250921    gcc-14
x86_64                randconfig-072-20250921    gcc-14
x86_64                randconfig-073-20250921    gcc-14
x86_64                randconfig-074-20250921    gcc-14
x86_64                randconfig-075-20250921    gcc-14
x86_64                randconfig-076-20250921    gcc-14
x86_64                randconfig-077-20250921    gcc-14
x86_64                randconfig-078-20250921    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250921    gcc-12.5.0
xtensa                randconfig-001-20250921    gcc-8.5.0
xtensa                randconfig-002-20250921    gcc-8.5.0
xtensa                         virt_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


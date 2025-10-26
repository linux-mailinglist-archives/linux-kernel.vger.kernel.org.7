Return-Path: <linux-kernel+bounces-870646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BB475C0B589
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 23:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7810C4EAD73
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 22:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D757C283159;
	Sun, 26 Oct 2025 22:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FyTARXgU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419FA239E7D
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 22:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761517334; cv=none; b=XxiXs9htfQAORSUaoGOIV7AseaKhtoTBajXlR1mKHhOCDNjZdfNapw8juXbscsYqrbQSjmkKWueYl5Lq4zNEznUsL9+KJ98Kwep2a8jpF9syh3l25eqptT7tyGbMBoIRtuXvi0QKWROjMHZQD/pbJWHhPM7g1YVFaDhorlcZ6Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761517334; c=relaxed/simple;
	bh=Kr7BD5VrclcRNyWxf71F9gvaJ345tDI67382dVEmDDY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=FW7zejGSziy3+TpDapRTJZuXWPO5mPGd8yCg5QA1mreoQGmnZIGDBWxA9bw2Wmcdlcu8fSrpodDhsli32K9q/gBKD4m7HT9cDHq/SCEVCBrSrTHwmKmlTkH7FOhk8jTIyou5k33F0yfAop8cRHOI1XKw5ouZjtRr8Wkry1jsv3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FyTARXgU; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761517332; x=1793053332;
  h=date:from:to:cc:subject:message-id;
  bh=Kr7BD5VrclcRNyWxf71F9gvaJ345tDI67382dVEmDDY=;
  b=FyTARXgUeX8G4W/k+/bSVkFBdx1sM+/z4XczITp09Vn/kbMnk3rGi4QE
   q9DpVfy6NmoO/ScwDa5VwCcwCkAn0LzXDIGSdk0WjrjVB+CSp6qlf90e+
   qEm3zyceD/NXSGN4wuZIbZIzss2OLmuiop3jwKIH0TgNKo977IJCh8NgD
   OjmcuaXxiPmAKTItEm7c1FmnUPhzr7U9K7Ol9+Nx4iaHZ3O4pl+GzL5m+
   d3sUR8BE2lQnMHrv81Np47V9kQltqAxxwxL+oVEBsrG2obFV0D/pcispd
   eRP4LUMSJw0esjxvV7dvt4NxrLzdMV2VXOajJvuiy8yhPayAMMR6pKn9p
   Q==;
X-CSE-ConnectionGUID: IDyaECwPSHWoH+NV1XMgVw==
X-CSE-MsgGUID: OLDxd/0DSZ2AaxZ6PDoOOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="51177452"
X-IronPort-AV: E=Sophos;i="6.19,257,1754982000"; 
   d="scan'208";a="51177452"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2025 15:22:12 -0700
X-CSE-ConnectionGUID: 0J3ZY2f1RBSbjFWqMEAK+A==
X-CSE-MsgGUID: SnXygO9TQ++6/POpWJaWsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,257,1754982000"; 
   d="scan'208";a="185360469"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 26 Oct 2025 15:22:10 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vD97o-000GMv-1F;
	Sun, 26 Oct 2025 22:22:08 +0000
Date: Mon, 27 Oct 2025 06:21:30 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/drivers] BUILD SUCCESS
 14ff9e54dd14339776afff78e2d29e0edb3a4402
Message-ID: <202510270623.WrhBS0bb-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/drivers
branch HEAD: 14ff9e54dd14339776afff78e2d29e0edb3a4402  irqchip/sifive-plic: Cache the interrupt enable state

elapsed time: 901m

configs tested: 175
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              alldefconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251026    gcc-13.4.0
arc                   randconfig-002-20251026    gcc-9.5.0
arc                        vdk_hs38_defconfig    clang-22
arm                               allnoconfig    clang-22
arm                                 defconfig    clang-22
arm                          ep93xx_defconfig    clang-22
arm                   randconfig-001-20251026    clang-22
arm                   randconfig-002-20251026    clang-20
arm                   randconfig-003-20251026    clang-17
arm                   randconfig-004-20251026    clang-20
arm                    vt8500_v6_v7_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251026    gcc-15.1.0
arm64                 randconfig-002-20251026    clang-22
arm64                 randconfig-003-20251026    gcc-8.5.0
arm64                 randconfig-004-20251026    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251026    gcc-15.1.0
csky                  randconfig-002-20251026    gcc-9.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251026    clang-18
hexagon               randconfig-002-20251026    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251026    gcc-14
i386        buildonly-randconfig-002-20251026    clang-20
i386        buildonly-randconfig-003-20251026    gcc-14
i386        buildonly-randconfig-004-20251026    clang-20
i386        buildonly-randconfig-005-20251026    clang-20
i386        buildonly-randconfig-006-20251026    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251027    gcc-14
i386                  randconfig-002-20251027    gcc-14
i386                  randconfig-003-20251027    gcc-14
i386                  randconfig-004-20251027    gcc-14
i386                  randconfig-005-20251027    gcc-14
i386                  randconfig-006-20251027    gcc-14
i386                  randconfig-007-20251027    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251026    clang-22
loongarch             randconfig-002-20251026    gcc-15.1.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                       m5275evb_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20251026    gcc-8.5.0
nios2                 randconfig-002-20251026    gcc-11.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
openrisc                       virt_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                generic-32bit_defconfig    gcc-15.1.0
parisc                randconfig-001-20251026    gcc-12.5.0
parisc                randconfig-002-20251026    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                  mpc866_ads_defconfig    clang-22
powerpc                      pasemi_defconfig    clang-22
powerpc               randconfig-001-20251026    gcc-13.4.0
powerpc               randconfig-002-20251026    gcc-8.5.0
powerpc               randconfig-003-20251026    gcc-10.5.0
powerpc                         wii_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251026    gcc-10.5.0
powerpc64             randconfig-002-20251026    gcc-12.5.0
powerpc64             randconfig-003-20251026    clang-22
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251027    gcc-13.4.0
riscv                 randconfig-002-20251027    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251027    clang-22
s390                  randconfig-002-20251027    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                             espt_defconfig    clang-22
sh                 kfr2r09-romimage_defconfig    clang-22
sh                    randconfig-001-20251027    gcc-12.5.0
sh                    randconfig-002-20251027    gcc-15.1.0
sh                           sh2007_defconfig    clang-22
sh                   sh7724_generic_defconfig    clang-22
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251027    gcc-12.5.0
sparc                 randconfig-002-20251027    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251027    gcc-14.3.0
sparc64               randconfig-002-20251027    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251027    clang-22
um                    randconfig-002-20251027    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251026    clang-20
x86_64      buildonly-randconfig-002-20251026    gcc-12
x86_64      buildonly-randconfig-003-20251026    gcc-14
x86_64      buildonly-randconfig-004-20251026    gcc-14
x86_64      buildonly-randconfig-005-20251026    clang-20
x86_64      buildonly-randconfig-006-20251026    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-071-20251027    clang-20
x86_64                randconfig-072-20251027    clang-20
x86_64                randconfig-073-20251027    clang-20
x86_64                randconfig-074-20251027    clang-20
x86_64                randconfig-075-20251027    clang-20
x86_64                randconfig-076-20251027    clang-20
x86_64                randconfig-077-20251027    clang-20
x86_64                randconfig-078-20251027    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251027    gcc-12.5.0
xtensa                randconfig-002-20251027    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


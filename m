Return-Path: <linux-kernel+bounces-889266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E9EC3D1DD
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 19:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 96C894E2076
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 18:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3992225409;
	Thu,  6 Nov 2025 18:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Un6Udkl9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977232DA753
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 18:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762455157; cv=none; b=tKcvXm+nxgVvbtTvYVruqEp+DIrFDZnXM/tcL/P3Id+GnQmxVd2jaaQGwD0X458gCJ2Q/6w/ELWngRa4qPG1T/pfUlsDQIPkaV/xouwWzGT0nqrj2a7UTt2I/H93ScZuiN1DA51fxH24DATQoanjHV6LXEl/sfN3qCqcFHsQVc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762455157; c=relaxed/simple;
	bh=Vhex5Ut99ffwKZRQwM9+PV8YYESi/K28Zl0R13YgM1M=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tU+iVxkBzoWb592DOD4/dDqe3ZthPfeuIGorCyGAb1bcBGbss1vn8Mv8mdKQW/QCTkPaC9PnfYmUzMRLipzPqyNiHCGCgRKrvdv4FRmDeXo3MI7ik2ShGQkIYk/E7CgTsHjzD+8Pzk7pa3G+TfC1sqgIFIRgYZXxweSV9C3Z26Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Un6Udkl9; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762455156; x=1793991156;
  h=date:from:to:cc:subject:message-id;
  bh=Vhex5Ut99ffwKZRQwM9+PV8YYESi/K28Zl0R13YgM1M=;
  b=Un6Udkl9UWhKmOiJLzICEVH59LWegSdBBb2OaMowVEfLmqf0VWtcq+I6
   Mbr0Kp7cRHb1KC7M8rcgRyUjnmkRGA/Gw1S+5n9jpfSftbMAadERtSvMJ
   EFsjKNgIRaHN9P9+j7KP7CXxI6i7+QmvWvXzT6Usw2xqBKa4lmVEubwN6
   uPC6yi6QfuMyVjSO3SyLWIIrL1KjvOJuEToLlnE4ezcmF6gyqIM/+xmAS
   vJCXy+LW62DRWg9dA80DDud5TvhfbHhK0SGwslRRDdWH1bhs1gbVvhUPL
   QPF4DLNemH/fHxg4KAfVlQVyjcuTREapFEIyGxHPeqVeVgfJihmZaEboB
   Q==;
X-CSE-ConnectionGUID: IAZQQ3AHTNm+gm69VbPbHQ==
X-CSE-MsgGUID: EyP2gP+XTAmOlj6dvpkpzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="75956787"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="75956787"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 10:52:35 -0800
X-CSE-ConnectionGUID: 8vKuAZ73QzysOEy+OiD3Aw==
X-CSE-MsgGUID: ZG90HbQGSLyVEUgnmbBIBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="218494975"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 06 Nov 2025 10:52:33 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vH55z-000UGe-1n;
	Thu, 06 Nov 2025 18:52:31 +0000
Date: Fri, 07 Nov 2025 02:52:31 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:tip/urgent] BUILD SUCCESS
 ee3ad4d055896a19512b654547c8d1e1f3edf088
Message-ID: <202511070225.4veMYi3d-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tip/urgent
branch HEAD: ee3ad4d055896a19512b654547c8d1e1f3edf088  Merge branch into tip/master: 'x86/urgent'

elapsed time: 1850m

configs tested: 106
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20251106    gcc-12.5.0
arc                   randconfig-002-20251106    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                          exynos_defconfig    clang-22
arm                         lpc18xx_defconfig    clang-22
arm                   randconfig-001-20251106    gcc-11.5.0
arm                   randconfig-002-20251106    clang-22
arm                   randconfig-003-20251106    gcc-10.5.0
arm                   randconfig-004-20251106    gcc-8.5.0
arm                        spear3xx_defconfig    clang-17
arm64                             allnoconfig    gcc-15.1.0
arm64                            allyesconfig    clang-22
arm64                 randconfig-001-20251106    gcc-11.5.0
arm64                 randconfig-002-20251106    clang-19
arm64                 randconfig-003-20251106    gcc-14.3.0
arm64                 randconfig-004-20251106    gcc-15.1.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                  randconfig-001-20251106    gcc-12.5.0
csky                  randconfig-002-20251106    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20251105    clang-22
hexagon               randconfig-002-20251105    clang-20
i386                              allnoconfig    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                        allyesconfig    clang-22
loongarch             randconfig-001-20251105    clang-18
loongarch             randconfig-002-20251105    clang-20
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                 randconfig-001-20251105    gcc-9.5.0
nios2                 randconfig-002-20251105    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                randconfig-001-20251106    gcc-10.5.0
parisc                randconfig-002-20251106    gcc-10.5.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                 mpc834x_itx_defconfig    clang-16
powerpc               randconfig-001-20251106    gcc-14.3.0
powerpc               randconfig-002-20251106    clang-22
powerpc64             randconfig-002-20251106    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20251105    gcc-8.5.0
riscv                 randconfig-002-20251105    clang-18
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20251105    gcc-8.5.0
s390                  randconfig-002-20251105    gcc-14.3.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251105    gcc-10.5.0
sh                    randconfig-002-20251105    gcc-11.5.0
sh                          rsk7264_defconfig    gcc-15.1.0
sh                        sh7757lcr_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20251106    gcc-15.1.0
sparc                 randconfig-002-20251106    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251106    gcc-13.4.0
sparc64               randconfig-002-20251106    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251106    gcc-14
um                    randconfig-002-20251106    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251106    gcc-12
x86_64      buildonly-randconfig-002-20251106    gcc-14
x86_64      buildonly-randconfig-003-20251106    gcc-14
x86_64      buildonly-randconfig-004-20251106    gcc-14
x86_64      buildonly-randconfig-005-20251106    clang-20
x86_64      buildonly-randconfig-006-20251106    clang-20
x86_64                              defconfig    gcc-14
xtensa                            allnoconfig    gcc-15.1.0
xtensa                  audio_kc705_defconfig    gcc-15.1.0
xtensa                randconfig-001-20251106    gcc-9.5.0
xtensa                randconfig-002-20251106    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-kernel+bounces-789136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E68B39189
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 04:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8391F364FB3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 02:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2C186334;
	Thu, 28 Aug 2025 02:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fzcPralF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC4127453
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 02:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756347358; cv=none; b=UHjmN2HWI/MgqTBPBzn1GzlEWiGyhTyzJvCsNpZiNEIX8zww41qMziyDpFdXIJU6C5+Hys6cZ37qdRn3E+7Jjj2iUoS1O/cO5CdeF7xE9pM3CulloRHBYLj1lF8Mz9p4YxflJ+QLqPTY/Mwbc7WQlfs+8qfJGGscs9Obya1De0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756347358; c=relaxed/simple;
	bh=DRoDvt62sMwBA55QmsfHx23Kf/o35TeuRmDkQUg/aPM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ke2QXhANACjw4JSb+09xg+raaLEnXer3+olKPTPDApR8uVizXpZC/kwv6JGbjbgwjJ3/5h+fa3Z48mOgoYWJu848TKh4zwsk+BHLYaMq8l6GXcVV0o/E8rpiiBSolxk71pEGkyrM3nlitxECF+UquGvLGOAnByyLQSlh73rSe0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fzcPralF; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756347358; x=1787883358;
  h=date:from:to:cc:subject:message-id;
  bh=DRoDvt62sMwBA55QmsfHx23Kf/o35TeuRmDkQUg/aPM=;
  b=fzcPralFFYAYAwoVLFQxY4aHtTTQcHlHqHl16rm95Rk1DweZKt5pInI6
   hMwNhGbcYItkwK8rHTTd3IU/r1AbdQagBanvXUyywOESO8I/7FKfvTHRQ
   n+omFoFc2PJYTtmIRfydVJs0TTtkqqBVl5bea5FrwtT5ItT0KNyiW1Tcb
   fZFmPnJZWAHk5U06gU/T50AGBLuHZzkdiCF4hob9MQM5b3mo4JcFlIil3
   v/aZcnNG5C1cIPtK7bC5MHuzV1PbmfTPPuq0AObEzC50RK6zVdBbctiTh
   cqS2QTejl2aWLy9hB5IRac2ot/fa5Z0Nn2MD5xgFKxT9OvqArjeHDfMaS
   A==;
X-CSE-ConnectionGUID: n4wWEWaERMC736wsg7dZEg==
X-CSE-MsgGUID: 2ED279gwRCCkE6hRWj1LjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="70048886"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="70048886"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 19:15:57 -0700
X-CSE-ConnectionGUID: R12aNyfaTAyNCVV58wB29g==
X-CSE-MsgGUID: iKHXC9A0Ssih9MLlFUJSwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="170379191"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 27 Aug 2025 19:15:55 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1urSAw-000TNB-1D;
	Thu, 28 Aug 2025 02:15:52 +0000
Date: Thu, 28 Aug 2025 10:15:31 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 cab48e960d35f35ff799f7aafce7a7bf7c56d8e3
Message-ID: <202508281021.zi4Mlez0-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: cab48e960d35f35ff799f7aafce7a7bf7c56d8e3  Merge branch into tip/master: 'x86/tdx'

elapsed time: 1205m

configs tested: 128
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-15.1.0
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                      axs103_smp_defconfig    gcc-15.1.0
arc                   randconfig-001-20250827    gcc-12.5.0
arc                   randconfig-002-20250827    gcc-8.5.0
arc                        vdk_hs38_defconfig    gcc-15.1.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                         axm55xx_defconfig    clang-22
arm                          pxa168_defconfig    clang-19
arm                   randconfig-001-20250827    clang-22
arm                   randconfig-002-20250827    clang-22
arm                   randconfig-003-20250827    clang-22
arm                   randconfig-004-20250827    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250827    gcc-11.5.0
arm64                 randconfig-002-20250827    gcc-8.5.0
arm64                 randconfig-003-20250827    clang-22
arm64                 randconfig-004-20250827    gcc-9.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250827    gcc-10.5.0
csky                  randconfig-002-20250827    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250827    clang-22
hexagon               randconfig-002-20250827    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250827    clang-20
i386        buildonly-randconfig-002-20250827    clang-20
i386        buildonly-randconfig-003-20250827    clang-20
i386        buildonly-randconfig-004-20250827    clang-20
i386        buildonly-randconfig-005-20250827    clang-20
i386        buildonly-randconfig-006-20250827    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250827    gcc-15.1.0
loongarch             randconfig-002-20250827    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           ci20_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250827    gcc-8.5.0
nios2                 randconfig-002-20250827    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250827    gcc-12.5.0
parisc                randconfig-002-20250827    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                     mpc83xx_defconfig    clang-22
powerpc               randconfig-001-20250827    clang-22
powerpc               randconfig-002-20250827    clang-22
powerpc               randconfig-003-20250827    clang-22
powerpc64             randconfig-001-20250827    gcc-11.5.0
powerpc64             randconfig-002-20250827    gcc-11.5.0
powerpc64             randconfig-003-20250827    gcc-13.4.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250827    clang-19
riscv                 randconfig-002-20250827    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250827    gcc-13.4.0
s390                  randconfig-002-20250827    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250827    gcc-15.1.0
sh                    randconfig-002-20250827    gcc-9.5.0
sh                             shx3_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250827    gcc-15.1.0
sparc                 randconfig-002-20250827    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250827    gcc-11.5.0
sparc64               randconfig-002-20250827    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250827    gcc-12
um                    randconfig-002-20250827    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250827    clang-20
x86_64      buildonly-randconfig-002-20250827    clang-20
x86_64      buildonly-randconfig-003-20250827    gcc-12
x86_64      buildonly-randconfig-004-20250827    gcc-12
x86_64      buildonly-randconfig-005-20250827    clang-20
x86_64      buildonly-randconfig-006-20250827    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250827    gcc-10.5.0
xtensa                randconfig-002-20250827    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


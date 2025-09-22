Return-Path: <linux-kernel+bounces-826484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8250B8EA4B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 02:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88A721899B7D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 00:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74F47D098;
	Mon, 22 Sep 2025 00:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GaTY1N6U"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD7080C02
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 00:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758502718; cv=none; b=Bnxe5Roq9WdZ3u+MgR+xxGQheOpdUubxwQa0H6BiTpRFff3zs1TVSOtvHwjcs1nXxKdctcq4oV5bRKJ6eBRyPUygR0itB2eGfOKwZSR35DVf/32ifduEhS0ImnJ4SEIa01l8sCKH04zKF/5ApL/eqswzL8bb6z1l0tH/EFRE3pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758502718; c=relaxed/simple;
	bh=RF+80J1cUr/Kv0hHJ+A6/MmnoRg8vZazKKlQL1hzwbo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HW9mCRmXYhxShyVcACwbTJD0NBRtZOSabVX5zzlUN3UQpOB8bbOuFy0GRhRwRp8rNZudmHz/1cPj9QhcK1mIvAASJAbIhASq0M66+/+hE8+92NmNf3aal994qTcNOZQP9RClYp7S4QQ1AVZ+bhzqBjX7p7ITkHlM3AdBzKmKcqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GaTY1N6U; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758502716; x=1790038716;
  h=date:from:to:cc:subject:message-id;
  bh=RF+80J1cUr/Kv0hHJ+A6/MmnoRg8vZazKKlQL1hzwbo=;
  b=GaTY1N6UXEI1s9tfNoI9kMoRJ7T9vVq3je2jkRhZ4tITOtA6bx71f5Sx
   1GhLJU6hleRDsSmPNquuPtoQt9BAwIWdEWxJWrsWkWCa65FXPD9fkg89A
   /Mgvegaa5IczXPf/MpT3sfBKDCPQBfTTjpfMwLtmWZZ2qJrpaPYN4USNd
   DeItG0MWDPJsAfPsISPtWiwjAI75YpvNfGWMvkfjPVLtnsueLqy+B6Wvn
   RKwszlzbjyLHoi0aHIG3bMEMytI5lHmmtYR58biWs16HvSBQkYoV/r9nf
   uSpo5H6MVvGRU/YM21hxLJUfU2z/nR+VRHvKZJQsCqnED2cUUyeIKRhKx
   w==;
X-CSE-ConnectionGUID: 0ky1vOzDRl2BaVRfsvVwHg==
X-CSE-MsgGUID: sWgfVjvOSB2nBLKhTcIgNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11560"; a="71865882"
X-IronPort-AV: E=Sophos;i="6.18,283,1751266800"; 
   d="scan'208";a="71865882"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2025 17:58:36 -0700
X-CSE-ConnectionGUID: lyiEk16xSNSNpaf9p/eA+A==
X-CSE-MsgGUID: gYTbeRzCQn2KkoKK5XgqBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,283,1751266800"; 
   d="scan'208";a="175623711"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 21 Sep 2025 17:58:36 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v0Usy-0001B7-1T;
	Mon, 22 Sep 2025 00:58:32 +0000
Date: Mon, 22 Sep 2025 08:58:14 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 391253b25f078d2fe5657a1dedd360396d186407
Message-ID: <202509220800.p2HhBPkd-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: 391253b25f078d2fe5657a1dedd360396d186407  time: Fix spelling mistakes in comments

elapsed time: 986m

configs tested: 127
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250921    gcc-14.3.0
arc                   randconfig-002-20250921    gcc-12.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                       omap2plus_defconfig    gcc-15.1.0
arm                   randconfig-001-20250921    gcc-11.5.0
arm                   randconfig-002-20250921    clang-16
arm                   randconfig-003-20250921    gcc-8.5.0
arm                   randconfig-004-20250921    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250921    clang-22
arm64                 randconfig-002-20250921    gcc-8.5.0
arm64                 randconfig-003-20250921    clang-22
arm64                 randconfig-004-20250921    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250921    gcc-9.5.0
csky                  randconfig-002-20250921    gcc-15.1.0
hexagon                          alldefconfig    clang-22
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250921    clang-20
hexagon               randconfig-002-20250921    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20250921    gcc-14
i386        buildonly-randconfig-002-20250921    clang-20
i386        buildonly-randconfig-003-20250921    gcc-12
i386        buildonly-randconfig-004-20250921    gcc-14
i386        buildonly-randconfig-005-20250921    gcc-14
i386        buildonly-randconfig-006-20250921    gcc-14
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250921    clang-18
loongarch             randconfig-002-20250921    clang-18
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          ath25_defconfig    clang-22
mips                  cavium_octeon_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250921    gcc-8.5.0
nios2                 randconfig-002-20250921    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250921    gcc-8.5.0
parisc                randconfig-002-20250921    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                      bamboo_defconfig    clang-22
powerpc                  iss476-smp_defconfig    gcc-15.1.0
powerpc                   lite5200b_defconfig    clang-22
powerpc               randconfig-001-20250921    gcc-12.5.0
powerpc               randconfig-002-20250921    gcc-8.5.0
powerpc               randconfig-003-20250921    clang-22
powerpc64             randconfig-002-20250921    gcc-15.1.0
powerpc64             randconfig-003-20250921    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250921    clang-22
riscv                 randconfig-002-20250921    gcc-12.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250921    clang-20
s390                  randconfig-002-20250921    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                        edosk7705_defconfig    gcc-15.1.0
sh                    randconfig-001-20250921    gcc-15.1.0
sh                    randconfig-002-20250921    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250921    gcc-13.4.0
sparc                 randconfig-002-20250921    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250921    clang-22
sparc64               randconfig-002-20250921    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250921    gcc-14
um                    randconfig-002-20250921    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250921    clang-20
x86_64      buildonly-randconfig-002-20250921    clang-20
x86_64      buildonly-randconfig-003-20250921    clang-20
x86_64      buildonly-randconfig-004-20250921    gcc-14
x86_64      buildonly-randconfig-005-20250921    clang-20
x86_64      buildonly-randconfig-006-20250921    gcc-14
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250921    gcc-12.5.0
xtensa                randconfig-002-20250921    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


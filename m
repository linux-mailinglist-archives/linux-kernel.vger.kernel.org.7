Return-Path: <linux-kernel+bounces-754387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 982A8B193C5
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 13:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B253B1753F3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 11:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58915464E;
	Sun,  3 Aug 2025 11:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gVJhpF9M"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDEC74420
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 11:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754219377; cv=none; b=T2CS852uOCtPynP0vAPdm61GDHrwSeO84m0tK56qvDMXrMavc+YWma94epVkbBMTaxFSMWLjC+AW86QM82a1v5XxxKi7iC5DJh1VsI+EGQMcSa5Q98pfkdIpaRyWWEeF/INCoZnVBH4s0mWsbgVAjaBl/yw2Y78sdKTPcHwNXx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754219377; c=relaxed/simple;
	bh=FlKWNDvWd369m0Ktzj+YoUteKp5L6uiyT93N7M4WWr8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=thZFDNS4oehlQj1jCXBRVj4VMD2V/U1a7mqB1rotsr5jrU8b5eX2pBJWrZ9RiudL1TPyeEqkZLJRUkUaCPQcNUJmd9Qv+1fFItYVWT64lhG+r9NEmivHk6d3utlffTWtN/9yROeBYomWyDh91cEq3qQBH9WyAJb+tqMRdYoghNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gVJhpF9M; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754219376; x=1785755376;
  h=date:from:to:cc:subject:message-id;
  bh=FlKWNDvWd369m0Ktzj+YoUteKp5L6uiyT93N7M4WWr8=;
  b=gVJhpF9MRD/jVOrhJ/BMY2NzKRA1FriQeD3zWLzxEN+8b9SGjQaERmoB
   HsIcVJ2YQ3aw7MgW+Km1qggkOSQ47BwaNfNz+EdcV7y3a4/wEmJCviaUy
   LD3SphCeaH1xyLXdsldwj2+e9JZAQxn2eb1XOsaOWvQ//4eXXikNwSZGE
   NA6GQxnNb066ldIBAixmfl0d8VAAn0ChWuhXzDmDGwUL88y2ttHEuyKbl
   RcMsZyys7M3QTWttRJYzgMp1HKPei88YP07VBSB29cjze7lIsMhOKbPfG
   lskvzFxYrh8NPOdtwEk7gEzvvmk2BvWhmH3wcbjpvukWG8IgNogt8Hu6w
   A==;
X-CSE-ConnectionGUID: qCapkE+PSmmlN67d6sGNnw==
X-CSE-MsgGUID: LOKY+DRuQeiJvCwDluOxEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11510"; a="55701578"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="55701578"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2025 04:09:35 -0700
X-CSE-ConnectionGUID: N1GdbaPJQCOQPfpZNoFv/Q==
X-CSE-MsgGUID: +JMuMJ3eSsWaY6idHdQGyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="194880455"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 03 Aug 2025 04:09:34 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uiWap-0006RS-31;
	Sun, 03 Aug 2025 11:09:31 +0000
Date: Sun, 03 Aug 2025 19:09:03 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:locking/urgent] BUILD SUCCESS
 e703b7e247503b8bf87b62c02a4392749b09eca8
Message-ID: <202508031953.WAPZX6XW-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/urgent
branch HEAD: e703b7e247503b8bf87b62c02a4392749b09eca8  futex: Move futex cleanup to __mmdrop()

elapsed time: 1248m

configs tested: 183
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250802    gcc-11.5.0
arc                   randconfig-002-20250802    gcc-14.3.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-22
arm                          ixp4xx_defconfig    gcc-15.1.0
arm                        keystone_defconfig    gcc-15.1.0
arm                         nhk8815_defconfig    clang-22
arm                   randconfig-001-20250802    gcc-10.5.0
arm                   randconfig-002-20250802    clang-22
arm                   randconfig-003-20250802    clang-18
arm                   randconfig-004-20250802    gcc-8.5.0
arm                         s3c6400_defconfig    gcc-15.1.0
arm                    vt8500_v6_v7_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250802    gcc-12.5.0
arm64                 randconfig-002-20250802    gcc-8.5.0
arm64                 randconfig-003-20250802    clang-22
arm64                 randconfig-004-20250802    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250802    gcc-15.1.0
csky                  randconfig-002-20250802    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20250802    clang-22
hexagon               randconfig-002-20250802    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250802    gcc-12
i386        buildonly-randconfig-002-20250802    gcc-12
i386        buildonly-randconfig-003-20250802    clang-20
i386        buildonly-randconfig-004-20250802    gcc-12
i386        buildonly-randconfig-005-20250802    clang-20
i386        buildonly-randconfig-006-20250802    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250803    gcc-12
i386                  randconfig-002-20250803    gcc-12
i386                  randconfig-003-20250803    gcc-12
i386                  randconfig-004-20250803    gcc-12
i386                  randconfig-005-20250803    gcc-12
i386                  randconfig-006-20250803    gcc-12
i386                  randconfig-007-20250803    gcc-12
i386                  randconfig-011-20250803    clang-20
i386                  randconfig-012-20250803    clang-20
i386                  randconfig-013-20250803    clang-20
i386                  randconfig-014-20250803    clang-20
i386                  randconfig-015-20250803    clang-20
i386                  randconfig-016-20250803    clang-20
i386                  randconfig-017-20250803    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250802    clang-18
loongarch             randconfig-002-20250802    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                          hp300_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250802    gcc-9.5.0
nios2                 randconfig-002-20250802    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250802    gcc-8.5.0
parisc                randconfig-002-20250802    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                       ebony_defconfig    clang-22
powerpc                       ebony_defconfig    gcc-15.1.0
powerpc                       eiger_defconfig    gcc-15.1.0
powerpc                     mpc5200_defconfig    clang-22
powerpc                      ppc6xx_defconfig    gcc-15.1.0
powerpc                         ps3_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250802    gcc-8.5.0
powerpc               randconfig-002-20250802    clang-20
powerpc               randconfig-003-20250802    gcc-10.5.0
powerpc64             randconfig-001-20250802    clang-16
powerpc64             randconfig-002-20250802    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250802    gcc-10.5.0
riscv                 randconfig-002-20250802    gcc-9.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250802    clang-22
s390                  randconfig-002-20250802    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250802    gcc-15.1.0
sh                    randconfig-002-20250802    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250802    gcc-8.5.0
sparc                 randconfig-002-20250802    gcc-8.5.0
sparc64                          alldefconfig    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250802    gcc-8.5.0
sparc64               randconfig-002-20250802    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250802    clang-22
um                    randconfig-002-20250802    clang-22
um                           x86_64_defconfig    clang-22
x86_64                           alldefconfig    gcc-15.1.0
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250802    gcc-12
x86_64      buildonly-randconfig-002-20250802    clang-20
x86_64      buildonly-randconfig-003-20250802    clang-20
x86_64      buildonly-randconfig-004-20250802    clang-20
x86_64      buildonly-randconfig-005-20250802    clang-20
x86_64      buildonly-randconfig-006-20250802    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250803    clang-20
x86_64                randconfig-002-20250803    clang-20
x86_64                randconfig-003-20250803    clang-20
x86_64                randconfig-004-20250803    clang-20
x86_64                randconfig-005-20250803    clang-20
x86_64                randconfig-006-20250803    clang-20
x86_64                randconfig-007-20250803    clang-20
x86_64                randconfig-008-20250803    clang-20
x86_64                randconfig-071-20250803    clang-20
x86_64                randconfig-072-20250803    clang-20
x86_64                randconfig-073-20250803    clang-20
x86_64                randconfig-074-20250803    clang-20
x86_64                randconfig-075-20250803    clang-20
x86_64                randconfig-076-20250803    clang-20
x86_64                randconfig-077-20250803    clang-20
x86_64                randconfig-078-20250803    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250802    gcc-13.4.0
xtensa                randconfig-002-20250802    gcc-9.5.0
xtensa                         virt_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


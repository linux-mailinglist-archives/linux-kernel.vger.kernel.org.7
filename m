Return-Path: <linux-kernel+bounces-725036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C69AFFA13
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B39274A792A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 06:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB1C231A21;
	Thu, 10 Jul 2025 06:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RyDCG+i9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21914DDC1
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 06:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752130167; cv=none; b=WcvNsWs7J0yU7IgJaH0vc9p0Xlrb4sUq2EOPDfjV68upOhf7Zqd9oEPSqfxkcS4f3BsVVemncwmZK8ycSptJVjfsA0tRZcywd8J39eYM8ZtE5BrMc1D3qrinrzP3i3njg6+cecElbbruizodH+3IpCuSkO0M/saKHusfy+7Wfkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752130167; c=relaxed/simple;
	bh=bWVeZTFqwPALZiYUqjG49GKxna9jbhNUjwWMWjfT3BI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VYgMiu+9bb3hw+gS3Ftl3HdNTFtBRxeOTMMBI51g0d1zfrKAr7Yuivsslq0iKBm5SETi60IutTY3MwmiaJQqfD4MF6VQWy+MaRYoWUJ+kcOk2gaxbFOcuzB1aWeb/iEKmqapgFU57DeRgkNj36ZGpV8mGnpOH4BmkcIZMZbZvSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RyDCG+i9; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752130165; x=1783666165;
  h=date:from:to:cc:subject:message-id;
  bh=bWVeZTFqwPALZiYUqjG49GKxna9jbhNUjwWMWjfT3BI=;
  b=RyDCG+i9DJ+WVAdBGgWkq18BTjRB3/4sdjcFsHbXtikkZ1/uKlRmwiIw
   HL0M7BYP3fX64IFPAlDtENrK8I3reriMtIcEykc6bX491iPkkahNBvkOW
   wwhEx7FDNTZlziVUDgjpFrSx5SLRXxnk6tRSVlTK3DCxYmrL5a/mhAaHm
   csltqIbh3n1T1+NeoEb3rUsqSTY4nqq5dtqQYVXe8cl2z3ZqS1fL3/4Cz
   PAn+yfYxoGEhbGpmp2g3NJPWO5zldPdtpgAcsN6cCx+Pg/rM0hXfTg+J0
   R1Il34F/53/+Qu+vQt9jzeai8SpFsDOc91s0dmFBiBVcnhDWtw+AGhnm1
   Q==;
X-CSE-ConnectionGUID: g7w9y7WbRayehwXg7/OUiw==
X-CSE-MsgGUID: Lr2J/Sh7SVe4eQ50PjuKkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="53512776"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="53512776"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 23:49:25 -0700
X-CSE-ConnectionGUID: Xx1YBH+1TqyjIbCoMug+6w==
X-CSE-MsgGUID: fVTegptMQH+bISakK2gWXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="155632887"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 09 Jul 2025 23:49:23 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uZl5t-0004bW-1Q;
	Thu, 10 Jul 2025 06:49:21 +0000
Date: Thu, 10 Jul 2025 14:49:03 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2025.07.08a] BUILD SUCCESS
 866420b31a0834f45c8f28cc6f7f68a5afaa35d4
Message-ID: <202507101451.6Iouu6tt-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2025.07.08a
branch HEAD: 866420b31a0834f45c8f28cc6f7f68a5afaa35d4  EXP arm64: enable PREEMPT_LAZY

elapsed time: 1659m

configs tested: 213
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-21
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-21
arc                              allyesconfig    clang-19
arc                                 defconfig    clang-19
arc                   randconfig-001-20250710    clang-21
arc                   randconfig-001-20250710    gcc-15.1.0
arc                   randconfig-002-20250710    clang-21
arc                   randconfig-002-20250710    gcc-12.4.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-21
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                   randconfig-001-20250710    clang-21
arm                   randconfig-001-20250710    gcc-8.5.0
arm                   randconfig-002-20250710    clang-21
arm                   randconfig-003-20250710    clang-21
arm                   randconfig-004-20250710    clang-21
arm                   randconfig-004-20250710    gcc-8.5.0
arm                           spitz_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-21
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250710    clang-21
arm64                 randconfig-002-20250710    clang-21
arm64                 randconfig-003-20250710    clang-21
arm64                 randconfig-003-20250710    gcc-8.5.0
arm64                 randconfig-004-20250710    clang-21
csky                              allnoconfig    clang-21
csky                                defconfig    clang-19
csky                  randconfig-001-20250710    gcc-15.1.0
csky                  randconfig-002-20250710    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250710    clang-21
hexagon               randconfig-001-20250710    gcc-15.1.0
hexagon               randconfig-002-20250710    clang-21
hexagon               randconfig-002-20250710    gcc-15.1.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250709    gcc-12
i386        buildonly-randconfig-001-20250710    clang-20
i386        buildonly-randconfig-001-20250710    gcc-12
i386        buildonly-randconfig-002-20250709    clang-20
i386        buildonly-randconfig-002-20250710    clang-20
i386        buildonly-randconfig-002-20250710    gcc-12
i386        buildonly-randconfig-003-20250709    clang-20
i386        buildonly-randconfig-003-20250710    clang-20
i386        buildonly-randconfig-004-20250709    clang-20
i386        buildonly-randconfig-004-20250710    clang-20
i386        buildonly-randconfig-004-20250710    gcc-11
i386        buildonly-randconfig-005-20250709    gcc-12
i386        buildonly-randconfig-005-20250710    clang-20
i386        buildonly-randconfig-006-20250709    clang-20
i386        buildonly-randconfig-006-20250710    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250710    gcc-12
i386                  randconfig-002-20250710    gcc-12
i386                  randconfig-003-20250710    gcc-12
i386                  randconfig-004-20250710    gcc-12
i386                  randconfig-005-20250710    gcc-12
i386                  randconfig-006-20250710    gcc-12
i386                  randconfig-007-20250710    gcc-12
i386                  randconfig-011-20250710    clang-20
i386                  randconfig-012-20250710    clang-20
i386                  randconfig-013-20250710    clang-20
i386                  randconfig-014-20250710    clang-20
i386                  randconfig-015-20250710    clang-20
i386                  randconfig-016-20250710    clang-20
i386                  randconfig-017-20250710    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250710    gcc-14.3.0
loongarch             randconfig-001-20250710    gcc-15.1.0
loongarch             randconfig-002-20250710    gcc-15.1.0
m68k                             allmodconfig    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                         apollo_defconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                       m5249evb_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                      bmips_stb_defconfig    gcc-15.1.0
mips                 decstation_r4k_defconfig    gcc-15.1.0
mips                           rs90_defconfig    gcc-15.1.0
mips                   sb1250_swarm_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250710    gcc-15.1.0
nios2                 randconfig-001-20250710    gcc-9.3.0
nios2                 randconfig-002-20250710    gcc-12.4.0
nios2                 randconfig-002-20250710    gcc-15.1.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250710    gcc-15.1.0
parisc                randconfig-001-20250710    gcc-8.5.0
parisc                randconfig-002-20250710    gcc-15.1.0
parisc                randconfig-002-20250710    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc               randconfig-001-20250710    gcc-12.4.0
powerpc               randconfig-001-20250710    gcc-15.1.0
powerpc               randconfig-002-20250710    gcc-15.1.0
powerpc               randconfig-002-20250710    gcc-9.3.0
powerpc               randconfig-003-20250710    gcc-15.1.0
powerpc               randconfig-003-20250710    gcc-8.5.0
powerpc64             randconfig-001-20250710    gcc-11.5.0
powerpc64             randconfig-001-20250710    gcc-15.1.0
powerpc64             randconfig-002-20250710    clang-17
powerpc64             randconfig-002-20250710    gcc-15.1.0
powerpc64             randconfig-003-20250710    gcc-14.3.0
powerpc64             randconfig-003-20250710    gcc-15.1.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                 randconfig-001-20250710    gcc-12.4.0
riscv                 randconfig-001-20250710    gcc-15.1.0
riscv                 randconfig-002-20250710    gcc-10.5.0
riscv                 randconfig-002-20250710    gcc-12.4.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250710    gcc-12.4.0
s390                  randconfig-001-20250710    gcc-14.3.0
s390                  randconfig-002-20250710    clang-17
s390                  randconfig-002-20250710    gcc-12.4.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250710    gcc-12.4.0
sh                    randconfig-001-20250710    gcc-15.1.0
sh                    randconfig-002-20250710    gcc-12.4.0
sh                    randconfig-002-20250710    gcc-13.4.0
sh                           se7780_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250710    gcc-12.4.0
sparc                 randconfig-001-20250710    gcc-13.4.0
sparc                 randconfig-002-20250710    gcc-12.4.0
sparc                 randconfig-002-20250710    gcc-14.3.0
sparc64               randconfig-001-20250710    gcc-12.4.0
sparc64               randconfig-001-20250710    gcc-8.5.0
sparc64               randconfig-002-20250710    gcc-12.4.0
sparc64               randconfig-002-20250710    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                    randconfig-001-20250710    gcc-11
um                    randconfig-001-20250710    gcc-12.4.0
um                    randconfig-002-20250710    clang-16
um                    randconfig-002-20250710    gcc-12.4.0
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250709    gcc-12
x86_64      buildonly-randconfig-001-20250710    clang-20
x86_64      buildonly-randconfig-001-20250710    gcc-12
x86_64      buildonly-randconfig-002-20250709    clang-20
x86_64      buildonly-randconfig-002-20250710    clang-20
x86_64      buildonly-randconfig-002-20250710    gcc-12
x86_64      buildonly-randconfig-003-20250709    gcc-12
x86_64      buildonly-randconfig-003-20250710    clang-20
x86_64      buildonly-randconfig-003-20250710    gcc-12
x86_64      buildonly-randconfig-004-20250709    gcc-12
x86_64      buildonly-randconfig-004-20250710    clang-20
x86_64      buildonly-randconfig-005-20250709    clang-20
x86_64      buildonly-randconfig-005-20250710    clang-20
x86_64      buildonly-randconfig-006-20250709    gcc-12
x86_64      buildonly-randconfig-006-20250710    clang-20
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250710    gcc-12
x86_64                randconfig-002-20250710    gcc-12
x86_64                randconfig-003-20250710    gcc-12
x86_64                randconfig-004-20250710    gcc-12
x86_64                randconfig-005-20250710    gcc-12
x86_64                randconfig-006-20250710    gcc-12
x86_64                randconfig-007-20250710    gcc-12
x86_64                randconfig-008-20250710    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250710    gcc-12.4.0
xtensa                randconfig-002-20250710    gcc-12.4.0
xtensa                randconfig-002-20250710    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


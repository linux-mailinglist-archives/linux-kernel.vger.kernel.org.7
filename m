Return-Path: <linux-kernel+bounces-815915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB24B56CE1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 00:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79C141897B28
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 22:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00652199FB2;
	Sun, 14 Sep 2025 22:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cPkIV7GQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6620923B0
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 22:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757889150; cv=none; b=So1lUggrx441R1ux1tru94Ka1TP1Md3be8YNlKUaOc9cXZN+AlPeCDt8+FpogdFIjdUnVU2A0P0anY+3H1iBjjQqhMpds4dYVWC8bikVZKb/2zDhim6UhVW38zYxZ5EZXSu64dckwy0vEjSpA9pGxD07DmG+ELhPb/BlVxMeWME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757889150; c=relaxed/simple;
	bh=EpwmXiK3QBuct+P+n29+0gAC5WigGhaaQvhHmr3XD+U=;
	h=Date:From:To:Cc:Subject:Message-ID; b=OGhp6VIhM+MjTGY8UF+ZwbK8D1ociLvvXkDZPRwfwX6AiCgaaQq+5Xp6bN+rJz/tEQxC2x4FTh+LKg3pMh5igOnjvwb5x6SRkYcbFcYS3TXFvgVTBaO8qUF9OWUOKLMfXXJ5YLx8hO6xhXBYe0uSeYz8Oz+z2HmPWNyUBxAp9+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cPkIV7GQ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757889148; x=1789425148;
  h=date:from:to:cc:subject:message-id;
  bh=EpwmXiK3QBuct+P+n29+0gAC5WigGhaaQvhHmr3XD+U=;
  b=cPkIV7GQAkuKZWeGWeosCQUP34RuDax/FMFs/YAr3blTrSX0kOPmXDI7
   /R+bFvCssL+LewMAFQ5nJlJvoCQyXsf1YdjJDaE5FcQpZK+qoRHMRf0D1
   wkpcV+dGkI+yqb2Wfl/Wrp1W/W1n+iG7LWgtrfs6mpqayn+cxsa8OIR06
   nJI1aUtBSJLEB+1xTBpDKuu9WCv3J8mAgEGxqfkZh1lxfwFwhX/hjBXzp
   AHjjzN3YIdwOrtz9ZvcNF8l36RN0CPI5J4qNTNjlKGmItegkWxZFW/25G
   nHUfZGORfruCKM1Y+TPQ2+XLTFN15erFkr3appCz4M5KqFAFMrrKXGVW5
   w==;
X-CSE-ConnectionGUID: cuZkD+wdTwOsx5M6Q+L9dw==
X-CSE-MsgGUID: zAVACJW0Rs6gHnanny8M8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="62774020"
X-IronPort-AV: E=Sophos;i="6.18,264,1751266800"; 
   d="scan'208";a="62774020"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2025 15:32:27 -0700
X-CSE-ConnectionGUID: GRPuL0q3QQyBJypihvoE2g==
X-CSE-MsgGUID: a7I/oyhKTuCASzdoQPfogQ==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO eb5fdfb2a9b7) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 14 Sep 2025 15:32:27 -0700
Received: from kbuild by eb5fdfb2a9b7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uxvG1-0002lk-0h;
	Sun, 14 Sep 2025 22:32:00 +0000
Date: Mon, 15 Sep 2025 06:31:04 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:tip/urgent] BUILD SUCCESS
 660e3808790ed9c8cb3461660449f3f1e417f991
Message-ID: <202509150654.HxH0iHW3-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tip/urgent
branch HEAD: 660e3808790ed9c8cb3461660449f3f1e417f991  Merge branch into tip/master: 'x86/urgent'

elapsed time: 722m

configs tested: 135
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250914    gcc-9.5.0
arc                   randconfig-002-20250914    gcc-10.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                   randconfig-001-20250914    clang-22
arm                   randconfig-002-20250914    clang-19
arm                   randconfig-003-20250914    gcc-14.3.0
arm                   randconfig-004-20250914    gcc-12.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250914    gcc-9.5.0
arm64                 randconfig-002-20250914    clang-22
arm64                 randconfig-003-20250914    clang-17
arm64                 randconfig-004-20250914    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250914    gcc-15.1.0
csky                  randconfig-002-20250914    gcc-13.4.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20250914    clang-22
hexagon               randconfig-002-20250914    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20250914    gcc-13
i386        buildonly-randconfig-002-20250914    gcc-14
i386        buildonly-randconfig-003-20250914    gcc-14
i386        buildonly-randconfig-004-20250914    gcc-14
i386        buildonly-randconfig-005-20250914    clang-20
i386        buildonly-randconfig-006-20250914    gcc-14
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250914    clang-22
loongarch             randconfig-002-20250914    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                         apollo_defconfig    gcc-15.1.0
m68k                          atari_defconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                       rbtx49xx_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250914    gcc-10.5.0
nios2                 randconfig-002-20250914    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250914    gcc-8.5.0
parisc                randconfig-002-20250914    gcc-10.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                      bamboo_defconfig    clang-22
powerpc                        fsp2_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250914    clang-22
powerpc               randconfig-002-20250914    clang-22
powerpc               randconfig-003-20250914    clang-22
powerpc64             randconfig-001-20250914    clang-22
powerpc64             randconfig-002-20250914    clang-22
powerpc64             randconfig-003-20250914    gcc-13.4.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250914    clang-22
riscv                 randconfig-002-20250914    gcc-12.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250914    gcc-10.5.0
s390                  randconfig-002-20250914    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250914    gcc-15.1.0
sh                    randconfig-002-20250914    gcc-10.5.0
sh                   sh7724_generic_defconfig    gcc-15.1.0
sh                              ul2_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250914    gcc-11.5.0
sparc                 randconfig-002-20250914    gcc-14.3.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250914    gcc-8.5.0
sparc64               randconfig-002-20250914    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250914    clang-22
um                    randconfig-002-20250914    clang-18
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250914    clang-20
x86_64      buildonly-randconfig-002-20250914    clang-20
x86_64      buildonly-randconfig-003-20250914    clang-20
x86_64      buildonly-randconfig-004-20250914    clang-20
x86_64      buildonly-randconfig-005-20250914    gcc-14
x86_64      buildonly-randconfig-006-20250914    clang-20
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250914    gcc-14.3.0
xtensa                randconfig-002-20250914    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-kernel+bounces-782943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A540B3276E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 09:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C5361BA4C42
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 07:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCBD220F4F;
	Sat, 23 Aug 2025 07:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gUlrzN0L"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1993126F0A
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 07:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755934772; cv=none; b=g6q5lHQeurKjxx2DuxvT/e5fRdAOignupV7ZLC8zUZ1ToScfDPk9Irft3H0iWvfxpZhZEM4LIhl970iGbWJ+mgJIRQjXpFiboDnO7Ey7Nu28LLBfunf1O0qoYd4Yr3F1hn7aNTM7izkGWGx1gw3vD9B0nrDXXBC4v6n7cSkHSRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755934772; c=relaxed/simple;
	bh=LfrW0wyjOrh5jSfX2Rac4ThYlTDPZeVgsziiVXxemYk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=q7FWg2/8Oa23pcGFvh0Iocja9oOWQI/PW+xhwJpZlAKR/4Sobum/vPOy5NIXMZ/4VdE/2ERoufFDzo4EKDM9HyRkE64eZwN/W5Fzh2jOjhoPUSr3KpdyEKG0iHzOLfLLs8SRxb4AsSYyU8qX2Mkt9MedkuntCaVKSPLnQ66OaUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gUlrzN0L; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755934770; x=1787470770;
  h=date:from:to:cc:subject:message-id;
  bh=LfrW0wyjOrh5jSfX2Rac4ThYlTDPZeVgsziiVXxemYk=;
  b=gUlrzN0LVzx056qXtsiww35Dx01a0ncIJW07UTGK5SwFpje0ixT18IcI
   xxWtAlEHAN9kBNJhMF1tFWtrjFoo+ienrCn3SkIq7fM6kZxZV47h7RBAT
   h5FEpunr6QHTw4IXEKfobO22hfUux7FeqBNPnwmLIliDHKISq3m5O/9a+
   lH36JL57JQ8IYbUYh4Yjm4+6JfuQQjbvh/lYrO5WMhOgTXrwRWfEaJwBk
   IFiDtw9iMZNexmBsJ+L7U7MRR2Vdb7/xUUHgDlfahroBMb9VTPmX31Pux
   dINvyH1mpKkLBffcn1jC1CE0sZjX0iDZCQAxWQ5tTaG2e5BZVsXy1QGzQ
   g==;
X-CSE-ConnectionGUID: wXtHHOhDR9uoIDIGKO/G3A==
X-CSE-MsgGUID: DhrYWzCKTTGOMVAlTtE3jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="58378306"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58378306"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2025 00:39:30 -0700
X-CSE-ConnectionGUID: 7BelRhUTTKCMSq06snNrBA==
X-CSE-MsgGUID: 2BYooy6MTG+SUwAhGAA9tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="168383280"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 23 Aug 2025 00:39:28 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upiqU-000MB9-20;
	Sat, 23 Aug 2025 07:39:26 +0000
Date: Sat, 23 Aug 2025 15:38:40 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/bugs] BUILD SUCCESS
 6bca6b9d414c8127350341f193caa11944ce6fa9
Message-ID: <202508231534.G14NHcDC-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/bugs
branch HEAD: 6bca6b9d414c8127350341f193caa11944ce6fa9  x86/its: Move ITS indirect branch thunks to .text..__x86.indirect_thunk

elapsed time: 1031m

configs tested: 160
configs skipped: 119

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                            allyesconfig    clang-19
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-22
arc                              allyesconfig    clang-19
arc                                 defconfig    clang-19
arc                   randconfig-001-20250823    clang-22
arc                   randconfig-002-20250823    clang-22
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                          exynos_defconfig    clang-22
arm                      jornada720_defconfig    clang-22
arm                   randconfig-001-20250823    clang-22
arm                   randconfig-002-20250823    clang-22
arm                   randconfig-003-20250823    clang-22
arm                   randconfig-004-20250823    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250823    clang-22
arm64                 randconfig-002-20250823    clang-22
arm64                 randconfig-003-20250823    clang-22
arm64                 randconfig-004-20250823    clang-22
csky                              allnoconfig    clang-22
csky                                defconfig    clang-19
csky                  randconfig-001-20250823    clang-22
csky                  randconfig-002-20250823    clang-22
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250823    clang-22
hexagon               randconfig-002-20250823    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250822    gcc-12
i386        buildonly-randconfig-001-20250823    clang-20
i386        buildonly-randconfig-002-20250822    clang-20
i386        buildonly-randconfig-002-20250823    clang-20
i386        buildonly-randconfig-003-20250822    gcc-12
i386        buildonly-randconfig-003-20250823    clang-20
i386        buildonly-randconfig-004-20250822    gcc-12
i386        buildonly-randconfig-004-20250823    clang-20
i386        buildonly-randconfig-005-20250822    gcc-12
i386        buildonly-randconfig-005-20250823    clang-20
i386        buildonly-randconfig-006-20250822    gcc-12
i386        buildonly-randconfig-006-20250823    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250823    clang-20
i386                  randconfig-002-20250823    clang-20
i386                  randconfig-003-20250823    clang-20
i386                  randconfig-004-20250823    clang-20
i386                  randconfig-005-20250823    clang-20
i386                  randconfig-006-20250823    clang-20
i386                  randconfig-007-20250823    clang-20
i386                  randconfig-011-20250823    gcc-12
i386                  randconfig-012-20250823    gcc-12
i386                  randconfig-013-20250823    gcc-12
i386                  randconfig-014-20250823    gcc-12
i386                  randconfig-015-20250823    gcc-12
i386                  randconfig-016-20250823    gcc-12
i386                  randconfig-017-20250823    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250823    clang-22
loongarch             randconfig-002-20250823    clang-22
m68k                             allmodconfig    clang-19
m68k                             allyesconfig    clang-19
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                       allyesconfig    clang-19
mips                        bcm47xx_defconfig    clang-22
nios2                 randconfig-001-20250823    clang-22
nios2                 randconfig-002-20250823    clang-22
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                randconfig-001-20250823    clang-22
parisc                randconfig-002-20250823    clang-22
powerpc                          allmodconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                    ge_imp3a_defconfig    clang-22
powerpc                 mpc832x_rdb_defconfig    clang-22
powerpc               randconfig-001-20250823    clang-22
powerpc               randconfig-002-20250823    clang-22
powerpc               randconfig-003-20250823    clang-22
powerpc64             randconfig-001-20250823    clang-22
powerpc64             randconfig-002-20250823    clang-22
powerpc64             randconfig-003-20250823    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250823    clang-22
riscv                 randconfig-002-20250823    clang-22
s390                             allmodconfig    gcc-15.1.0
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250823    clang-22
s390                  randconfig-002-20250823    clang-22
sh                               alldefconfig    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250823    clang-22
sh                    randconfig-002-20250823    clang-22
sh                        sh7757lcr_defconfig    clang-22
sparc                            allmodconfig    gcc-15.1.0
sparc                 randconfig-001-20250823    clang-22
sparc                 randconfig-002-20250823    clang-22
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250823    clang-22
sparc64               randconfig-002-20250823    clang-22
um                               allmodconfig    clang-19
um                               allyesconfig    clang-19
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250823    clang-22
um                    randconfig-002-20250823    clang-22
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250822    clang-20
x86_64      buildonly-randconfig-001-20250823    gcc-12
x86_64      buildonly-randconfig-002-20250822    gcc-12
x86_64      buildonly-randconfig-002-20250823    gcc-12
x86_64      buildonly-randconfig-003-20250822    clang-20
x86_64      buildonly-randconfig-003-20250823    gcc-12
x86_64      buildonly-randconfig-004-20250822    clang-20
x86_64      buildonly-randconfig-004-20250823    gcc-12
x86_64      buildonly-randconfig-005-20250822    clang-20
x86_64      buildonly-randconfig-005-20250823    gcc-12
x86_64      buildonly-randconfig-006-20250822    gcc-12
x86_64      buildonly-randconfig-006-20250823    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250823    gcc-12
x86_64                randconfig-002-20250823    gcc-12
x86_64                randconfig-003-20250823    gcc-12
x86_64                randconfig-004-20250823    gcc-12
x86_64                randconfig-005-20250823    gcc-12
x86_64                randconfig-006-20250823    gcc-12
x86_64                randconfig-007-20250823    gcc-12
x86_64                randconfig-008-20250823    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                randconfig-001-20250823    clang-22
xtensa                randconfig-002-20250823    clang-22
xtensa                    xip_kc705_defconfig    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


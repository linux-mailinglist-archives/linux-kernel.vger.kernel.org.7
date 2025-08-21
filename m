Return-Path: <linux-kernel+bounces-780089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 929B0B2FD82
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1ABB1BA0521
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F4A2E2DDE;
	Thu, 21 Aug 2025 14:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pv0Yj+yW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D412DF714
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 14:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755787755; cv=none; b=PHDGcxDsqljgEOwHN5nvD+A804cTYd/SFY7Az++1kCkXIvm5R5I7YYD4WrT+dFd3iO6kghCkjvMHMoPNEgGCPWApu3zkMwCYw4rtQYe5YA2RMad0dmOLs5sPSdrr0iYdaYrSRQcYb0PFwobzpdNzJZhc12uGkQjXKSH82b23t9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755787755; c=relaxed/simple;
	bh=16DvelkAtFnwqhYJXv8yjuKzkcAxxRe34gF8gj1uVWw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HWhl9mGGm6e1bkn/aEbTHWPdrNQw8K6EjQrTA4CijNsU68JUd9qQCtqR+u9eBOS2rZRtlXPU7zaTVilPS4spbBfMHEvIsU8HDb3QhT17xbK3hwWdIcSJ96Rj9t4RoZFDKcWV81AJD8kXj4Q4U5PpRdQGBDLIp6q050lgdCjVx4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pv0Yj+yW; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755787755; x=1787323755;
  h=date:from:to:cc:subject:message-id;
  bh=16DvelkAtFnwqhYJXv8yjuKzkcAxxRe34gF8gj1uVWw=;
  b=Pv0Yj+yWzRuIO5Pi4ivWSz56PPGsg8ljcTv7RZDGirsOkARm3vhA2zMg
   oiwiEdvHqG8t216u7b/oSaKjv7C0tB8HhOvLcOulPflS+LZXUoMgpc2T3
   OVwZosczgm3Mbs0zD5vGbSNbMVAxihL2ltUrLSyKpHEelZHd5JCapLhNJ
   SJs7Yih+OSL4Fy43uI7u5wD7WXDEZHXVbUlRv8qR3kSU+paMDjUtxkisi
   i+HkZLAEHnM9bjh1ceIH5C9sNOxPSmf587ksIqgFzQcTLs2AEjTNk+D4g
   TP30YYZlGsmWstlyHA0yXtn7+cRmXIEViFxF8tFjnGQsOpdaWHFAiisw4
   g==;
X-CSE-ConnectionGUID: +7hLwJS7R6KwzIBZe/WC0Q==
X-CSE-MsgGUID: vhN8vuz5REuPgpCVM3n/hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="75663510"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="75663510"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 07:49:14 -0700
X-CSE-ConnectionGUID: Kiz6ExWcRUy67Tfa0YnMkg==
X-CSE-MsgGUID: LIMnNTvkSZSSGA/32dPPRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="205606684"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 21 Aug 2025 07:49:12 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1up6bG-000KNn-0Z;
	Thu, 21 Aug 2025 14:49:10 +0000
Date: Thu, 21 Aug 2025 22:43:28 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/microcode] BUILD SUCCESS
 952df63ef426b21d6da14bb48748f12b0ae2fe36
Message-ID: <202508212222.DxtAdSkW-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/microcode
branch HEAD: 952df63ef426b21d6da14bb48748f12b0ae2fe36  x86/microcode/intel: Refresh the revisions that determine old_microcode

elapsed time: 962m

configs tested: 99
configs skipped: 119

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                               defconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                   randconfig-001-20250821    clang-22
arc                   randconfig-002-20250821    clang-22
arm                               allnoconfig    clang-22
arm                     am200epdkit_defconfig    gcc-15.1.0
arm                   randconfig-001-20250821    clang-22
arm                   randconfig-002-20250821    clang-22
arm                   randconfig-003-20250821    clang-22
arm                   randconfig-004-20250821    clang-22
arm                           sama7_defconfig    gcc-15.1.0
arm                       spear13xx_defconfig    gcc-15.1.0
arm                           spitz_defconfig    gcc-15.1.0
arm64                             allnoconfig    clang-22
arm64                 randconfig-001-20250821    clang-22
arm64                 randconfig-002-20250821    clang-22
arm64                 randconfig-003-20250821    clang-22
arm64                 randconfig-004-20250821    clang-22
csky                              allnoconfig    clang-22
hexagon                           allnoconfig    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250821    gcc-12
i386        buildonly-randconfig-002-20250821    gcc-12
i386        buildonly-randconfig-003-20250821    clang-20
i386        buildonly-randconfig-003-20250821    gcc-12
i386        buildonly-randconfig-004-20250821    gcc-12
i386        buildonly-randconfig-005-20250821    gcc-12
i386        buildonly-randconfig-006-20250821    clang-20
i386        buildonly-randconfig-006-20250821    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-011-20250821    gcc-12
i386                  randconfig-012-20250821    gcc-12
i386                  randconfig-013-20250821    gcc-12
i386                  randconfig-014-20250821    gcc-12
i386                  randconfig-015-20250821    gcc-12
i386                  randconfig-016-20250821    gcc-12
i386                  randconfig-017-20250821    gcc-12
loongarch                         allnoconfig    clang-22
m68k                              allnoconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
openrisc                          allnoconfig    clang-22
parisc                            allnoconfig    clang-22
parisc                              defconfig    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                 mpc8315_rdb_defconfig    gcc-15.1.0
powerpc                      ppc6xx_defconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                 randconfig-001-20250821    clang-18
riscv                 randconfig-002-20250821    clang-18
s390                              allnoconfig    clang-22
s390                  randconfig-001-20250821    clang-18
s390                  randconfig-002-20250821    clang-18
sh                                allnoconfig    gcc-15.1.0
sh                         apsh4a3a_defconfig    gcc-15.1.0
sh                    randconfig-001-20250821    clang-18
sh                    randconfig-002-20250821    clang-18
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250821    clang-18
sparc                 randconfig-002-20250821    clang-18
sparc64               randconfig-001-20250821    clang-18
sparc64               randconfig-002-20250821    clang-18
um                                allnoconfig    clang-22
um                    randconfig-001-20250821    clang-18
um                    randconfig-002-20250821    clang-18
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250821    clang-20
x86_64      buildonly-randconfig-002-20250821    clang-20
x86_64      buildonly-randconfig-003-20250821    clang-20
x86_64      buildonly-randconfig-004-20250821    clang-20
x86_64      buildonly-randconfig-004-20250821    gcc-12
x86_64      buildonly-randconfig-005-20250821    clang-20
x86_64      buildonly-randconfig-006-20250821    clang-20
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250821    clang-20
x86_64                randconfig-002-20250821    clang-20
x86_64                randconfig-003-20250821    clang-20
x86_64                randconfig-004-20250821    clang-20
x86_64                randconfig-005-20250821    clang-20
x86_64                randconfig-006-20250821    clang-20
x86_64                randconfig-007-20250821    clang-20
x86_64                randconfig-008-20250821    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250821    clang-18
xtensa                randconfig-002-20250821    clang-18

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


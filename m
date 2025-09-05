Return-Path: <linux-kernel+bounces-803758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9D0B464B2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 22:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6796B1BC7C64
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 20:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDE82C21FE;
	Fri,  5 Sep 2025 20:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DhnIitY7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50DE2C21FB
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 20:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757104925; cv=none; b=nGJv63KuGGvWv315Wq6T7XlXqUKcOyXHHfOD+cJZl6EfGUJzN+WmmU7LGrkmRtLilEKrYs/Bv/h/SILiX6iz1T9ICTEpJ77bLtlWPPNS1eF4Kg7iQKKHMdnXkrQNkyJ9OUpE/VlWgiyOR/6g3KEBlW7ve+QjcSWLYu6993jvT64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757104925; c=relaxed/simple;
	bh=930W9E6t3iL3bJbvMmEmaQGf0nlQugfLAycM/GNAKGY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Xgn+6yLXY31gq5+zJqt3NBye4P+6rSW21aA+Nu73RsUc3BP6ZYxfKn9c0CQNdh2g9JxE9xqdfeP34RVyfA92bvK935+IA55J23LAWFQv0CZD9uoF21U1eVfhRi4USQjBEaehsxvnvHm6yTF1N9O4PqszlUua/Zjgo7WoxKTLw8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DhnIitY7; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757104924; x=1788640924;
  h=date:from:to:cc:subject:message-id;
  bh=930W9E6t3iL3bJbvMmEmaQGf0nlQugfLAycM/GNAKGY=;
  b=DhnIitY7/Aq5i7ytAYGJODIxF/RkZjhuWPn7W3pDY+uaU28M2y/+ZxQ8
   NOzyCwAI1969o5QIezKp03/Prk0a0FqsfgNRtZhs2rZZb1lG+uMIc/VgE
   LeAU52cl7N63sI0Irrm3RtmEIDs+OV7Vwrl0EhH2rz1gfw/K2ydTp5bs7
   /f9MrtlX4iqUFPzvmelcnqB/13ENir7XQ5hL1gqek+JjC/eJBdihG6SMv
   xEQYZTAYpCHp8eSZcCnOljty6rbRmnFnyMqTeXjVCOLDdATbDvAHQqw0V
   G98mUfQlCmbB6mHhwpBIQhz1GhOmZDrXGiWSMExvHb7MS1NQfbgX1Dt3/
   A==;
X-CSE-ConnectionGUID: rr6hhp51SnePozsMZlxclQ==
X-CSE-MsgGUID: brj5TGpkRJ2or4YuKjMjww==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="69721058"
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
   d="scan'208";a="69721058"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 13:42:02 -0700
X-CSE-ConnectionGUID: qeAoDInsQO+fJsefX8CwhQ==
X-CSE-MsgGUID: 0vJSingGRrGEgf2p1B+7lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
   d="scan'208";a="203180321"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 05 Sep 2025 13:42:01 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uudFv-0000pD-0D;
	Fri, 05 Sep 2025 20:41:59 +0000
Date: Sat, 06 Sep 2025 04:41:47 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/vdso] BUILD SUCCESS WITH WARNING
 e994a4197086cd5df809277b3b96c88f75e1e860
Message-ID: <202509060440.Mnw17m2w-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/vdso
branch HEAD: e994a4197086cd5df809277b3b96c88f75e1e860  vdso: Add struct __kernel_old_timeval forward declaration to gettime.h

Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202509051042.7KOze0fZ-lkp@intel.com

    include/vdso/unaligned.h:23:9: warning: '__builtin_memcpy' reading 4 bytes from a region of size 1 [-Wstringop-overread]

Warning ids grouped by kconfigs:

recent_errors
|-- parisc-allnoconfig
|   `-- include-vdso-unaligned.h:warning:__builtin_memcpy-reading-bytes-from-a-region-of-size
`-- parisc64-alldefconfig
    `-- include-vdso-unaligned.h:warning:__builtin_memcpy-reading-bytes-from-a-region-of-size

elapsed time: 1897m

configs tested: 102
configs skipped: 2

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20250904    gcc-9.5.0
arc                   randconfig-002-20250904    gcc-11.5.0
arm                               allnoconfig    clang-22
arm                         lpc32xx_defconfig    clang-17
arm                   randconfig-001-20250904    gcc-10.5.0
arm                   randconfig-002-20250904    gcc-13.4.0
arm                   randconfig-003-20250904    gcc-8.5.0
arm                   randconfig-004-20250904    gcc-13.4.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250904    gcc-8.5.0
arm64                 randconfig-002-20250904    gcc-8.5.0
arm64                 randconfig-003-20250904    clang-22
arm64                 randconfig-004-20250904    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250905    gcc-15.1.0
csky                  randconfig-002-20250905    gcc-13.4.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250905    clang-22
hexagon               randconfig-002-20250905    clang-22
i386                             allmodconfig    gcc-13
i386                              allnoconfig    gcc-13
i386                             allyesconfig    gcc-13
i386        buildonly-randconfig-001-20250904    clang-20
i386        buildonly-randconfig-002-20250904    gcc-12
i386        buildonly-randconfig-003-20250904    gcc-13
i386        buildonly-randconfig-004-20250904    gcc-13
i386        buildonly-randconfig-005-20250904    clang-20
i386        buildonly-randconfig-006-20250904    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250905    clang-18
loongarch             randconfig-002-20250905    clang-18
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                         apollo_defconfig    gcc-15.1.0
m68k                        m5407c3_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                 randconfig-001-20250905    gcc-10.5.0
nios2                 randconfig-002-20250905    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                randconfig-001-20250905    gcc-15.1.0
parisc                randconfig-002-20250905    gcc-8.5.0
parisc64                         alldefconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                    amigaone_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250905    gcc-8.5.0
powerpc               randconfig-002-20250905    clang-22
powerpc               randconfig-003-20250905    gcc-8.5.0
powerpc                     stx_gp3_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250905    clang-22
powerpc64             randconfig-002-20250905    clang-22
powerpc64             randconfig-003-20250905    gcc-14.3.0
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250904    gcc-8.5.0
riscv                 randconfig-002-20250904    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250904    gcc-10.5.0
s390                  randconfig-002-20250904    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250904    gcc-12.5.0
sh                    randconfig-002-20250904    gcc-10.5.0
sh                            shmin_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250904    gcc-11.5.0
sparc                 randconfig-002-20250904    gcc-15.1.0
sparc64               randconfig-001-20250904    gcc-12.5.0
sparc64               randconfig-002-20250904    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-13
um                    randconfig-001-20250904    gcc-13
um                    randconfig-002-20250904    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250904    gcc-12
x86_64      buildonly-randconfig-002-20250904    clang-20
x86_64      buildonly-randconfig-003-20250904    gcc-13
x86_64      buildonly-randconfig-004-20250904    gcc-13
x86_64      buildonly-randconfig-005-20250904    gcc-13
x86_64      buildonly-randconfig-006-20250904    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250904    gcc-10.5.0
xtensa                randconfig-002-20250904    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


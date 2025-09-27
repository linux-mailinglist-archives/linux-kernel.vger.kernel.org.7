Return-Path: <linux-kernel+bounces-835044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E2DBA61E7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 19:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D404E17C574
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 17:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3396225403;
	Sat, 27 Sep 2025 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OEd/6CG3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E8618E1F
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 17:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758992953; cv=none; b=tbE79sPoerli7L0kC1QSOYpO6zwF0LFbCOgZUxq2STG+l8jxdlnIZCTT/3BAhNdKlDfu5JZAU5jk1i+Oo4pxei2k6wIjQyAlPC77Ef+x/7vbNyRB/Dn3T3el5GheLZuOCLVhAAlnxv6WM6vJSLleIt8WN/svaWJnI27OQI7wVgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758992953; c=relaxed/simple;
	bh=Y6uUu3Kyxj0D22dej7eXrkROQSgEw4jnZ8hsKVJ7Iy0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=VU3UVrUFZNL/ZGaDFJNgEQwMaN535vgXQxJGfnPf86CUIGT52Z5w7E+xyu3W9NwnP1oI0CNR4ii535P08RaDgEXlr7u6DbyixYVkxBK1HZSj/QGWXYtMI3F4SeA+FPDzwmNSOhEu/tb5T5kMoGN4L9kRj4Dh89IBrGmIvIHrmu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OEd/6CG3; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758992952; x=1790528952;
  h=date:from:to:cc:subject:message-id;
  bh=Y6uUu3Kyxj0D22dej7eXrkROQSgEw4jnZ8hsKVJ7Iy0=;
  b=OEd/6CG3/bicFpNS1XXAQyo9bMfzlo61vYCdWdqs9+3R+0b3zVwCNMNI
   4EqJN3iBTe5ZzxrJZTXy/4RaRPyIAW0tGhpcf1Gnn2fiXsugWIzJQQU55
   3i4tSKl2L5oycrVkoXfXcQ7r2GD/mjdsfTyGhZnusEcKRIncj1vEp9AO+
   6fmNOUaskb4IZSesdtDVTkdC1/+byRHcN7PDuSyCKlh7FRJVSoE9onpj4
   EGL5To9RuFHJUeSO+RzBEqyf11dsqBqjTTJ8ShFGvr0V2GUpMNLFRWtkn
   RFIH833uJX7oVrMyh4mnViP5vYM0DNzAwFPlze2a5l1mSXsNq+B9KIMVG
   A==;
X-CSE-ConnectionGUID: bFm0W3zxQmOFOESAfVAYTg==
X-CSE-MsgGUID: XnD87wlIRgitHJytLKgDSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11566"; a="61002919"
X-IronPort-AV: E=Sophos;i="6.18,298,1751266800"; 
   d="scan'208";a="61002919"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2025 10:09:11 -0700
X-CSE-ConnectionGUID: GZ8WWN1pQxafb/uB0/9bCA==
X-CSE-MsgGUID: buGMqXHaSreXVg/2ByaKaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,298,1751266800"; 
   d="scan'208";a="201539967"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 27 Sep 2025 10:09:09 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v2YPz-0007EB-2J;
	Sat, 27 Sep 2025 17:09:07 +0000
Date: Sun, 28 Sep 2025 01:08:17 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20250926] BUILD SUCCESS
 883782ad7050c1e5a38940a93a84c9b94a893e6d
Message-ID: <202509280101.H6UieGw3-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20250926
branch HEAD: 883782ad7050c1e5a38940a93a84c9b94a893e6d  net: inet_sock.h: Avoid thousands of -Wflex-array-member-not-at-end warnings

elapsed time: 1449m

configs tested: 108
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                         haps_hs_defconfig    gcc-15.1.0
arc                   randconfig-001-20250927    gcc-10.5.0
arc                   randconfig-002-20250927    gcc-13.4.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250927    clang-18
arm                   randconfig-002-20250927    clang-16
arm                   randconfig-003-20250927    gcc-8.5.0
arm                   randconfig-004-20250927    gcc-10.5.0
arm                       spear13xx_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250927    gcc-8.5.0
arm64                 randconfig-002-20250927    gcc-11.5.0
arm64                 randconfig-003-20250927    clang-22
arm64                 randconfig-004-20250927    gcc-9.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250927    gcc-15.1.0
csky                  randconfig-002-20250927    gcc-13.4.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250927    clang-22
hexagon               randconfig-002-20250927    clang-22
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20250927    clang-20
i386        buildonly-randconfig-002-20250927    gcc-14
i386        buildonly-randconfig-003-20250927    clang-20
i386        buildonly-randconfig-004-20250927    clang-20
i386        buildonly-randconfig-005-20250927    gcc-12
i386        buildonly-randconfig-006-20250927    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250927    gcc-15.1.0
loongarch             randconfig-002-20250927    clang-18
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                         apollo_defconfig    gcc-15.1.0
m68k                       bvme6000_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          rb532_defconfig    clang-18
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250927    gcc-9.5.0
nios2                 randconfig-002-20250927    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250927    gcc-9.5.0
parisc                randconfig-002-20250927    gcc-11.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                 mpc832x_rdb_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250927    gcc-13.4.0
powerpc               randconfig-002-20250927    clang-22
powerpc               randconfig-003-20250927    gcc-8.5.0
powerpc64             randconfig-001-20250927    clang-22
powerpc64             randconfig-002-20250927    gcc-15.1.0
powerpc64             randconfig-003-20250927    gcc-12.5.0
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250927    clang-22
riscv                 randconfig-002-20250927    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250927    clang-22
s390                  randconfig-002-20250927    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         apsh4a3a_defconfig    gcc-15.1.0
sh                    randconfig-001-20250927    gcc-15.1.0
sh                    randconfig-002-20250927    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250927    gcc-11.5.0
sparc                 randconfig-002-20250927    gcc-11.5.0
sparc64               randconfig-001-20250927    gcc-15.1.0
sparc64               randconfig-002-20250927    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                    randconfig-001-20250927    gcc-14
um                    randconfig-002-20250927    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20250927    gcc-14
x86_64      buildonly-randconfig-002-20250927    clang-20
x86_64      buildonly-randconfig-003-20250927    clang-20
x86_64      buildonly-randconfig-004-20250927    gcc-14
x86_64      buildonly-randconfig-005-20250927    gcc-14
x86_64      buildonly-randconfig-006-20250927    clang-20
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250927    gcc-8.5.0
xtensa                randconfig-002-20250927    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


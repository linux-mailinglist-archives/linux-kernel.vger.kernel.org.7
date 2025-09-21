Return-Path: <linux-kernel+bounces-826247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF3CB8DFB2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 18:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1DE7189CDFE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 16:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A34C24169D;
	Sun, 21 Sep 2025 16:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F/yw3qhU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2AD23D7CD
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 16:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758472159; cv=none; b=jCGqXJUh71ty1NDzWccEkQ1So8eQI7mUAHHmapYM2ynLSIZGekfBOBfnKjK3NTVmr1cwVu8JlHYY+SF7yBO0mDzjTK1neBvj0gGdw33l6z/GFm7o0o8QZGeNM76Bxwd5WYK1kgfsSuB0cv10+00YiFgmWZ+zDKDHjd43f8fbyhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758472159; c=relaxed/simple;
	bh=hxwSB+j9GbwxZLtiZ7sxpmBVpgYF+LYHTyLjujxGR8o=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ScU9V8WyBvAF9Vz2QFT0CO+OUF7LI8kDro8zoLZF7xKmDNVTVl3PtVNchJGpisQAX83Wzq8R51pxqotCxHenZft4l0bEs08gYYOFLXlOHeMACe2m+KUqlmrB4D1mVMGmR1ApRKKu0ZkRJ+tb6Df6y1Sng39+7CXL6KIhoL46V5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F/yw3qhU; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758472158; x=1790008158;
  h=date:from:to:cc:subject:message-id;
  bh=hxwSB+j9GbwxZLtiZ7sxpmBVpgYF+LYHTyLjujxGR8o=;
  b=F/yw3qhUsHNwJgn4mmiR5gubjyajqH6mhtco/K2aRoKleyxob4U35/15
   FUXPMrS7V4M5QXhdjhBlkq2c7jBA5+/Wj8wmlmMPC67n1cDx3eP9y7wwT
   q6JKrhOuJxdpP+9kH8a0bxy44IyKscB3PQDs2DKtbudSeKK1iHJEDVZdE
   7Ba1Js7J0lMpFT4lsxxvOQUEQiWFqOd97ZFbT1Rlyp8HtUeNuXF8ny7qG
   BrOQzmJ3C0NhH7MEMxxTOF+PZp4fsSABU2mxpOKAXc9wDnp12jH1YlAGb
   hm/xRd3Q+JLYTMWV18z/X1T8536qmj34p4INlJwgXw7YQCGAbdWmOfvbV
   w==;
X-CSE-ConnectionGUID: inyRAgD/Tqixz16L0KaCjg==
X-CSE-MsgGUID: xSA1PvgnSJ6u/lQsVlnQnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60803858"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60803858"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2025 09:29:17 -0700
X-CSE-ConnectionGUID: uYHd+g12Q5mlPRXkqvdshA==
X-CSE-MsgGUID: fiiAxiVbQAqeIZ75ht1Wfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,283,1751266800"; 
   d="scan'208";a="175882762"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 21 Sep 2025 09:29:16 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v0Mw5-0000tV-2U;
	Sun, 21 Sep 2025 16:29:13 +0000
Date: Mon, 22 Sep 2025 00:29:05 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:locking/futex] BUILD SUCCESS
 4386f71623b77215c9502e60fc399e76ec337fec
Message-ID: <202509220045.bdU6qmsi-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/futex
branch HEAD: 4386f71623b77215c9502e60fc399e76ec337fec  selftest/futex: Fix spelling mistake "boundarie" -> "boundary"

elapsed time: 1384m

configs tested: 132
configs skipped: 4

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
arc                     haps_hs_smp_defconfig    gcc-15.1.0
arc                            hsdk_defconfig    gcc-15.1.0
arc                   randconfig-001-20250921    gcc-14.3.0
arc                   randconfig-002-20250921    gcc-12.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                          gemini_defconfig    clang-20
arm                   randconfig-001-20250921    gcc-11.5.0
arm                   randconfig-002-20250921    clang-16
arm                   randconfig-003-20250921    gcc-8.5.0
arm                   randconfig-004-20250921    clang-22
arm                         s3c6400_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250921    clang-22
arm64                 randconfig-002-20250921    gcc-8.5.0
arm64                 randconfig-003-20250921    clang-22
arm64                 randconfig-004-20250921    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250921    gcc-9.5.0
csky                  randconfig-002-20250921    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
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
powerpc                      cm5200_defconfig    clang-22
powerpc                    ge_imp3a_defconfig    gcc-15.1.0
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
sh                               alldefconfig    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
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


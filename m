Return-Path: <linux-kernel+bounces-687179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03055ADA13B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jun 2025 09:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09A1C18934BF
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jun 2025 07:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F947261595;
	Sun, 15 Jun 2025 07:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JBrSMfnv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18E116FF44
	for <linux-kernel@vger.kernel.org>; Sun, 15 Jun 2025 07:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749973350; cv=none; b=dPFnuYcUOdJqZOLhBydbd7NStwShrW/z3ugnf6FPziTjgT0jG0MZAzojcI3wPz+Yb1zPaTpwEVP5F/KevqimjufZ5i4iMNfZSpyTyAwu3GfJVRa4DRXwXvfeT6uJE/9sA5qSGlDBBAmRVtdKL8SvOrC6dzJyK8N7FpvCMQ8FUMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749973350; c=relaxed/simple;
	bh=FjoJdv/HmcGffkIhypAWLnxuGOFWipnxHnIc6Wyfbu8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Lp980Ldb9IBZkrP/bak7ASY63PUNjBAKANAJ0sEFIWBIK3XRlDl9eRjQB1IcJ0pBZQaWNxbSrzSYTU0smHAuVuas4BFYLDe7sA2JvgW4i/29gvjiKEgSFcqgIYlTIfraxk9Rs4iT/sMEAXLC1//0FANGizqCaLpBDZqAiULd1cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JBrSMfnv; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749973349; x=1781509349;
  h=date:from:to:cc:subject:message-id;
  bh=FjoJdv/HmcGffkIhypAWLnxuGOFWipnxHnIc6Wyfbu8=;
  b=JBrSMfnvLn1A0SveLIWDhT73+I4GxLBQdrl1wn+2WaKyhija7WVaE05X
   72DMjlLEz4fRjH4AgUP6dcsRJ5AHe2yiD8wvZwg2XGKiJ/8h8jTgpPbsw
   RXlxYWMqWpJyz7MtmzcOQltiGaStWRyF+XB2FKiW/Recl2IGZMK/U3QWJ
   KaqaEba+xPl0J7NX9B95HnZgDdT+hHt0h1s1Ib/TKnkUim5NHt+z6Qis5
   Ak/jErKM4dNpDPSPirNb5AIoDXCaEO3oaUGsyu4AfuDURYwMReiJwt2iB
   MF1fThqW0bRN7TYtxUHH64LgoMtYwjGjWpjbuu/RG+MrRnLMCf0+L/qri
   w==;
X-CSE-ConnectionGUID: DdbWiCf0TzS3ZCuF5qSEmg==
X-CSE-MsgGUID: SceuGwB9THGsZdPLPuyEcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11464"; a="69582984"
X-IronPort-AV: E=Sophos;i="6.16,238,1744095600"; 
   d="scan'208";a="69582984"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 00:42:28 -0700
X-CSE-ConnectionGUID: hTREqG3wQkiFe6Zghqa+ew==
X-CSE-MsgGUID: GEVECfDSRAGlAWUOTyMY5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,238,1744095600"; 
   d="scan'208";a="152012103"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 15 Jun 2025 00:42:27 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uQi0W-000EBw-36;
	Sun, 15 Jun 2025 07:42:24 +0000
Date: Sun, 15 Jun 2025 15:41:51 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:tip/urgent] BUILD SUCCESS
 5fd82acbf78d6525e8589203b03211c4aa3b511d
Message-ID: <202506151541.Ma4BZMKQ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tip/urgent
branch HEAD: 5fd82acbf78d6525e8589203b03211c4aa3b511d  Merge branch into tip/master: 'x86/urgent'

elapsed time: 1441m

configs tested: 124
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250614    gcc-8.5.0
arc                   randconfig-002-20250614    gcc-12.4.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                         at91_dt_defconfig    clang-21
arm                            mmp2_defconfig    gcc-15.1.0
arm                   randconfig-001-20250614    gcc-8.5.0
arm                   randconfig-002-20250614    clang-21
arm                   randconfig-003-20250614    clang-16
arm                   randconfig-004-20250614    clang-17
arm                         socfpga_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250614    clang-21
arm64                 randconfig-002-20250614    gcc-15.1.0
arm64                 randconfig-003-20250614    clang-21
arm64                 randconfig-004-20250614    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250614    gcc-13.3.0
csky                  randconfig-002-20250614    gcc-12.4.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250614    clang-21
hexagon               randconfig-002-20250614    clang-16
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250614    clang-20
i386        buildonly-randconfig-002-20250614    clang-20
i386        buildonly-randconfig-003-20250614    clang-20
i386        buildonly-randconfig-004-20250614    gcc-12
i386        buildonly-randconfig-005-20250614    clang-20
i386        buildonly-randconfig-006-20250614    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch             randconfig-001-20250614    gcc-15.1.0
loongarch             randconfig-002-20250614    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           ip22_defconfig    gcc-15.1.0
mips                           ip30_defconfig    gcc-15.1.0
mips                          rb532_defconfig    clang-18
mips                         rt305x_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250614    gcc-13.3.0
nios2                 randconfig-002-20250614    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250614    gcc-8.5.0
parisc                randconfig-002-20250614    gcc-11.5.0
powerpc                     akebono_defconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                    ge_imp3a_defconfig    gcc-15.1.0
powerpc                 mpc8315_rdb_defconfig    clang-21
powerpc                     mpc83xx_defconfig    clang-21
powerpc                     rainier_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250614    gcc-13.3.0
powerpc               randconfig-002-20250614    clang-21
powerpc               randconfig-003-20250614    gcc-12.4.0
powerpc64             randconfig-001-20250614    gcc-11.5.0
powerpc64             randconfig-002-20250614    clang-21
powerpc64             randconfig-003-20250614    gcc-12.4.0
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-21
riscv                    nommu_virt_defconfig    clang-21
riscv                 randconfig-001-20250614    clang-21
riscv                 randconfig-002-20250614    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250614    clang-21
s390                  randconfig-002-20250614    gcc-10.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250614    gcc-14.3.0
sh                    randconfig-002-20250614    gcc-12.4.0
sh                           se7751_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250614    gcc-15.1.0
sparc                 randconfig-002-20250614    gcc-10.3.0
sparc64                             defconfig    gcc-15.1.0
sparc64               randconfig-001-20250614    gcc-8.5.0
sparc64               randconfig-002-20250614    gcc-9.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250614    clang-21
um                    randconfig-002-20250614    gcc-12
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250614    clang-20
x86_64      buildonly-randconfig-002-20250614    clang-20
x86_64      buildonly-randconfig-003-20250614    gcc-12
x86_64      buildonly-randconfig-004-20250614    clang-20
x86_64      buildonly-randconfig-005-20250614    clang-20
x86_64      buildonly-randconfig-006-20250614    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-15.1.0
xtensa                  audio_kc705_defconfig    gcc-15.1.0
xtensa                randconfig-001-20250614    gcc-9.3.0
xtensa                randconfig-002-20250614    gcc-13.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


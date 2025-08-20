Return-Path: <linux-kernel+bounces-777783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B59CFB2DDBB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EC661C47BAA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BFC31DDB5;
	Wed, 20 Aug 2025 13:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XpB1Oug/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34273304BAB
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 13:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755696521; cv=none; b=G8s8LaROGpjLVaB3RvExFT+JC09sWpGk99swHwMzpvgKMlJtLuYn5SqDbLCIwCm76hx2IuBWwShw4PWh0fCrBYcu86BYcuODVEvQf7Ac+aIxgO2IfonPVc6sluqBpi2d7EZFidqE2fs+egx1kDafc4sRJluu51FV64VyjYydAZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755696521; c=relaxed/simple;
	bh=f1Yk0bWadNSQKXbLj/JbHwJjFFVafr6EH34kcj2yVfM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=CxueAEJDjSVpkNttlxTr5S218iVfDYCegF8WIr0xMSbaBLKvciBNTAIMP1FYg0Zd5Jt66p9Tox6OKLmos3w4KyiucHel/J/vICPbi9+AQI2U8PTRHT09NDsGukRNc5gjD9pdWu/+vQRGcb02yyRK5Vk7OPBIn/omB5PcbxkawrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XpB1Oug/; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755696520; x=1787232520;
  h=date:from:to:cc:subject:message-id;
  bh=f1Yk0bWadNSQKXbLj/JbHwJjFFVafr6EH34kcj2yVfM=;
  b=XpB1Oug/qN144J9qnrTFI826F5BfHXIQfG3JCBog3kVZx5YYfiJBer0O
   UBQHkhYNOOZWH7oSklgKquRzIInjnP26VE+2rqp/669spTwZ659qz4LSe
   kOBvwQZrJNS7Fa2K+6x3DspNDjhrtMl4jc+CgTfwWI0UyP2t+ZIDmci2V
   wBzBt7MEZ9s6BLheZxrdSFzLTCuss0t8uO2qrbCn68+TwHkDXXLTMTLAY
   5xJxORWKgs66TY41sFEygF08fQZtmvW+6UXvZqOQsJjJpeGjtIUc8qFJi
   +tiw3n7yfvo/Pg23e4tfEcE8bTciVEvMCR3HExHy3Oz9K70IZ17sUgv6u
   w==;
X-CSE-ConnectionGUID: Ej1+uXODR06PVBABJ0kUTw==
X-CSE-MsgGUID: qrYCtqXMSEm/WiGixAMJsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="75409803"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="75409803"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 06:28:38 -0700
X-CSE-ConnectionGUID: fSRckwPERHejlb0+gGzWJA==
X-CSE-MsgGUID: 2mk6qAWzTseHMGDQlpguyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="168476587"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 20 Aug 2025 06:28:37 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uoirS-000JAP-0q;
	Wed, 20 Aug 2025 13:28:26 +0000
Date: Wed, 20 Aug 2025 21:25:20 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:tip/urgent] BUILD SUCCESS
 704e427ebc4dc71597e337d5c646c080800ee9cf
Message-ID: <202508202114.MlDnMgDx-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tip/urgent
branch HEAD: 704e427ebc4dc71597e337d5c646c080800ee9cf  Merge branch into tip/master: 'x86/urgent'

elapsed time: 1451m

configs tested: 252
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20250820    gcc-14.3.0
arc                   randconfig-001-20250820    gcc-8.5.0
arc                   randconfig-002-20250820    gcc-11.5.0
arc                   randconfig-002-20250820    gcc-14.3.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                            mmp2_defconfig    clang-22
arm                   randconfig-001-20250820    gcc-14.3.0
arm                   randconfig-001-20250820    gcc-8.5.0
arm                   randconfig-002-20250820    gcc-14.3.0
arm                   randconfig-002-20250820    gcc-15.1.0
arm                   randconfig-003-20250820    gcc-13.4.0
arm                   randconfig-003-20250820    gcc-14.3.0
arm                   randconfig-004-20250820    clang-22
arm                   randconfig-004-20250820    gcc-14.3.0
arm                        realview_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                            allyesconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250820    gcc-14.3.0
arm64                 randconfig-002-20250820    gcc-14.3.0
arm64                 randconfig-003-20250820    gcc-14.3.0
arm64                 randconfig-003-20250820    gcc-8.5.0
arm64                 randconfig-004-20250820    gcc-14.3.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250819    gcc-15.1.0
csky                  randconfig-001-20250820    clang-22
csky                  randconfig-002-20250819    gcc-15.1.0
csky                  randconfig-002-20250820    clang-22
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250819    clang-22
hexagon               randconfig-001-20250820    clang-22
hexagon               randconfig-002-20250819    clang-18
hexagon               randconfig-002-20250820    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250819    gcc-12
i386        buildonly-randconfig-001-20250820    gcc-12
i386        buildonly-randconfig-002-20250819    clang-20
i386        buildonly-randconfig-002-20250820    gcc-12
i386        buildonly-randconfig-003-20250819    clang-20
i386        buildonly-randconfig-003-20250820    gcc-12
i386        buildonly-randconfig-004-20250819    clang-20
i386        buildonly-randconfig-004-20250820    gcc-12
i386        buildonly-randconfig-005-20250819    clang-20
i386        buildonly-randconfig-005-20250820    gcc-12
i386        buildonly-randconfig-006-20250819    clang-20
i386        buildonly-randconfig-006-20250820    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250820    gcc-12
i386                  randconfig-002-20250820    gcc-12
i386                  randconfig-003-20250820    gcc-12
i386                  randconfig-004-20250820    gcc-12
i386                  randconfig-005-20250820    gcc-12
i386                  randconfig-006-20250820    gcc-12
i386                  randconfig-007-20250820    gcc-12
i386                  randconfig-011-20250820    clang-20
i386                  randconfig-012-20250820    clang-20
i386                  randconfig-013-20250820    clang-20
i386                  randconfig-014-20250820    clang-20
i386                  randconfig-015-20250820    clang-20
i386                  randconfig-016-20250820    clang-20
i386                  randconfig-017-20250820    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                        allyesconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250819    gcc-15.1.0
loongarch             randconfig-001-20250820    clang-22
loongarch             randconfig-002-20250819    clang-18
loongarch             randconfig-002-20250820    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                           gcw0_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250819    gcc-8.5.0
nios2                 randconfig-001-20250820    clang-22
nios2                 randconfig-002-20250819    gcc-8.5.0
nios2                 randconfig-002-20250820    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250819    gcc-10.5.0
parisc                randconfig-001-20250820    clang-22
parisc                randconfig-002-20250819    gcc-8.5.0
parisc                randconfig-002-20250820    clang-22
parisc64                            defconfig    gcc-15.1.0
powerpc                    adder875_defconfig    clang-22
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                          g5_defconfig    clang-22
powerpc               randconfig-001-20250819    clang-22
powerpc               randconfig-001-20250820    clang-22
powerpc               randconfig-002-20250819    gcc-10.5.0
powerpc               randconfig-002-20250820    clang-22
powerpc               randconfig-003-20250819    clang-22
powerpc               randconfig-003-20250820    clang-22
powerpc                     tqm8548_defconfig    clang-22
powerpc64                        alldefconfig    clang-22
powerpc64             randconfig-001-20250819    clang-22
powerpc64             randconfig-001-20250820    clang-22
powerpc64             randconfig-002-20250819    clang-22
powerpc64             randconfig-002-20250820    clang-22
powerpc64             randconfig-003-20250819    gcc-10.5.0
powerpc64             randconfig-003-20250820    clang-22
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250819    clang-22
riscv                 randconfig-001-20250820    clang-22
riscv                 randconfig-002-20250819    clang-22
riscv                 randconfig-002-20250820    clang-22
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250819    gcc-8.5.0
s390                  randconfig-001-20250820    clang-22
s390                  randconfig-002-20250819    gcc-12.5.0
s390                  randconfig-002-20250820    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250819    gcc-15.1.0
sh                    randconfig-001-20250820    clang-22
sh                    randconfig-002-20250819    gcc-15.1.0
sh                    randconfig-002-20250820    clang-22
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250819    gcc-8.5.0
sparc                 randconfig-001-20250820    clang-22
sparc                 randconfig-002-20250819    gcc-11.5.0
sparc                 randconfig-002-20250820    clang-22
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250819    clang-22
sparc64               randconfig-001-20250820    clang-22
sparc64               randconfig-002-20250819    gcc-8.5.0
sparc64               randconfig-002-20250820    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250819    clang-18
um                    randconfig-001-20250820    clang-22
um                    randconfig-002-20250819    gcc-12
um                    randconfig-002-20250820    clang-22
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250819    clang-20
x86_64      buildonly-randconfig-001-20250820    clang-20
x86_64      buildonly-randconfig-002-20250819    clang-20
x86_64      buildonly-randconfig-002-20250820    clang-20
x86_64      buildonly-randconfig-003-20250819    clang-20
x86_64      buildonly-randconfig-003-20250820    clang-20
x86_64      buildonly-randconfig-004-20250819    clang-20
x86_64      buildonly-randconfig-004-20250820    clang-20
x86_64      buildonly-randconfig-005-20250819    clang-20
x86_64      buildonly-randconfig-005-20250820    clang-20
x86_64      buildonly-randconfig-006-20250819    clang-20
x86_64      buildonly-randconfig-006-20250820    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250820    gcc-12
x86_64                randconfig-002-20250820    gcc-12
x86_64                randconfig-003-20250820    gcc-12
x86_64                randconfig-004-20250820    gcc-12
x86_64                randconfig-005-20250820    gcc-12
x86_64                randconfig-006-20250820    gcc-12
x86_64                randconfig-007-20250820    gcc-12
x86_64                randconfig-008-20250820    gcc-12
x86_64                randconfig-071-20250820    gcc-12
x86_64                randconfig-072-20250820    gcc-12
x86_64                randconfig-073-20250820    gcc-12
x86_64                randconfig-074-20250820    gcc-12
x86_64                randconfig-075-20250820    gcc-12
x86_64                randconfig-076-20250820    gcc-12
x86_64                randconfig-077-20250820    gcc-12
x86_64                randconfig-078-20250820    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250819    gcc-8.5.0
xtensa                randconfig-001-20250820    clang-22
xtensa                randconfig-002-20250819    gcc-15.1.0
xtensa                randconfig-002-20250820    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


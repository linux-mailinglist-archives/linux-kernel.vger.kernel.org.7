Return-Path: <linux-kernel+bounces-793620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F1FB3D62C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 02:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 334493BA579
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 00:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365801A9B24;
	Mon,  1 Sep 2025 00:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EyfgZwUP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80D117C77
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 00:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756687555; cv=none; b=hp9yTNuWC/hsRHrFJsfOlp4lGljgC9j5L6fqc/oHiJKPMTyXIFG/Vnwt8G4gjLO1xCX0+mVafP8CVgVRimt9O5tcfv+0kaHjezqn4U2rkxV0isg2AT+j4ahl/4jKlQ5M7dUtAs8ZY3XlQulFmSFn5raFigLvGR2765HeclnJAQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756687555; c=relaxed/simple;
	bh=yUprqaggvuQLfERV3yD4sPfjl7E9OclyGXNGQxqtFAo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=sfcrH4K32iyg8gFlmGszCeHFU557aTRDgnqIeWlC5js/HMwM7ncnddEMVI/Q2wxJmxdtXZ1aNj1uRy0fjeJJ6ijFDFlgBpwm6yUC8FNX9/pnbuN60HVpfoFVZZyYahE4gbqeqrP9jjpZ43/b9poVMVAu9pyzSDrhc04C2qzRfsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EyfgZwUP; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756687554; x=1788223554;
  h=date:from:to:cc:subject:message-id;
  bh=yUprqaggvuQLfERV3yD4sPfjl7E9OclyGXNGQxqtFAo=;
  b=EyfgZwUP9B853HPYRloEICBMqYd+CWPOTE+Bxzm4Eq882qTr9byAFUuE
   gEYKBvHsS3+iw/vMgSslVME7cI2gsZ53PgHS7VL64WWrG6I+WbdiIkozH
   mSpvJLNCofJt8mO6GXTrINpS4jLGBWD3CzqCMjpBiFKxG9MLljjiT/wg+
   2TsUDVatnELQctCunFgHfvcbfxmEmspSLNm8VgkghrtBoVX2jlPSCiXYS
   cv5aWnrDN7Nnn053Ss4qBIkjJaXN7C4zPptY/nnvT4PWnVos4IEUmHHmq
   LRX10pH4yjPTGqHstb00VTRkhOqad2naocdHMT4kIzsv4c87P+e4R7Jog
   g==;
X-CSE-ConnectionGUID: f1kWZRKeSdSDIwzPJizdxA==
X-CSE-MsgGUID: Czpc6VRGSyKnNtzkWE8OHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11539"; a="58816022"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="58816022"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2025 17:45:53 -0700
X-CSE-ConnectionGUID: Y22RDcvUTbey798Gq82Fsw==
X-CSE-MsgGUID: Ut2nAQb2RBeUAfX+Z52p/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="176140219"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 31 Aug 2025 17:45:51 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ussfW-000WRe-18;
	Mon, 01 Sep 2025 00:45:25 +0000
Date: Mon, 01 Sep 2025 08:43:42 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:locking/urgent] BUILD SUCCESS
 d9b05321e21e4b218de4ce8a590bf375f58b6346
Message-ID: <202509010831.il0aYDxw-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/urgent
branch HEAD: d9b05321e21e4b218de4ce8a590bf375f58b6346  futex: Move futex_hash_free() back to __mmput()

elapsed time: 727m

configs tested: 161
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250831    gcc-8.5.0
arc                   randconfig-002-20250831    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                      footbridge_defconfig    gcc-15.1.0
arm                           imxrt_defconfig    gcc-15.1.0
arm                        mvebu_v5_defconfig    gcc-15.1.0
arm                            qcom_defconfig    clang-22
arm                   randconfig-001-20250831    clang-22
arm                   randconfig-002-20250831    gcc-8.5.0
arm                   randconfig-003-20250831    clang-22
arm                   randconfig-004-20250831    gcc-14.3.0
arm                         vf610m4_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250831    gcc-13.4.0
arm64                 randconfig-002-20250831    gcc-9.5.0
arm64                 randconfig-003-20250831    gcc-8.5.0
arm64                 randconfig-004-20250831    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250831    gcc-11.5.0
csky                  randconfig-002-20250831    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250831    clang-22
hexagon               randconfig-002-20250831    clang-17
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250831    gcc-12
i386        buildonly-randconfig-002-20250831    clang-20
i386        buildonly-randconfig-003-20250831    gcc-12
i386        buildonly-randconfig-004-20250831    gcc-12
i386        buildonly-randconfig-005-20250831    gcc-12
i386        buildonly-randconfig-006-20250831    clang-20
i386                                defconfig    clang-20
i386                  randconfig-011-20250901    gcc-12
i386                  randconfig-012-20250901    gcc-12
i386                  randconfig-013-20250901    gcc-12
i386                  randconfig-014-20250901    gcc-12
i386                  randconfig-015-20250901    gcc-12
i386                  randconfig-016-20250901    gcc-12
i386                  randconfig-017-20250901    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250831    gcc-15.1.0
loongarch             randconfig-002-20250831    clang-22
m68k                             alldefconfig    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                        m5407c3_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250831    gcc-11.5.0
nios2                 randconfig-002-20250831    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250831    gcc-15.1.0
parisc                randconfig-002-20250831    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                     ppa8548_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250831    gcc-14.3.0
powerpc               randconfig-002-20250831    gcc-12.5.0
powerpc               randconfig-003-20250831    gcc-14.3.0
powerpc                    sam440ep_defconfig    gcc-15.1.0
powerpc                      tqm8xx_defconfig    clang-19
powerpc64             randconfig-001-20250831    gcc-8.5.0
powerpc64             randconfig-003-20250831    gcc-12.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250831    gcc-12.5.0
riscv                 randconfig-001-20250901    gcc-15.1.0
riscv                 randconfig-002-20250831    gcc-8.5.0
riscv                 randconfig-002-20250901    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250831    gcc-13.4.0
s390                  randconfig-001-20250901    gcc-15.1.0
s390                  randconfig-002-20250831    clang-22
s390                  randconfig-002-20250901    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250831    gcc-11.5.0
sh                    randconfig-001-20250901    gcc-15.1.0
sh                    randconfig-002-20250831    gcc-15.1.0
sh                    randconfig-002-20250901    gcc-15.1.0
sh                     sh7710voipgw_defconfig    gcc-15.1.0
sh                   sh7724_generic_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250831    gcc-15.1.0
sparc                 randconfig-001-20250901    gcc-15.1.0
sparc                 randconfig-002-20250831    gcc-8.5.0
sparc                 randconfig-002-20250901    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250831    clang-22
sparc64               randconfig-001-20250901    gcc-15.1.0
sparc64               randconfig-002-20250831    clang-22
sparc64               randconfig-002-20250901    gcc-15.1.0
um                               alldefconfig    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250831    clang-17
um                    randconfig-001-20250901    gcc-15.1.0
um                    randconfig-002-20250831    clang-18
um                    randconfig-002-20250901    gcc-15.1.0
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250831    gcc-12
x86_64      buildonly-randconfig-002-20250831    clang-20
x86_64      buildonly-randconfig-003-20250831    gcc-12
x86_64      buildonly-randconfig-004-20250831    gcc-12
x86_64      buildonly-randconfig-005-20250831    gcc-12
x86_64      buildonly-randconfig-006-20250831    clang-20
x86_64                              defconfig    gcc-11
x86_64                randconfig-001-20250901    clang-20
x86_64                randconfig-002-20250901    clang-20
x86_64                randconfig-003-20250901    clang-20
x86_64                randconfig-004-20250901    clang-20
x86_64                randconfig-005-20250901    clang-20
x86_64                randconfig-006-20250901    clang-20
x86_64                randconfig-007-20250901    clang-20
x86_64                randconfig-008-20250901    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250831    gcc-10.5.0
xtensa                randconfig-001-20250901    gcc-15.1.0
xtensa                randconfig-002-20250901    gcc-15.1.0
xtensa                         virt_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


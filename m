Return-Path: <linux-kernel+bounces-831860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65899B9DB85
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E74F1B22E29
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B542D6623;
	Thu, 25 Sep 2025 06:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QI+BsNb5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1148914AD20
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758782679; cv=none; b=NqG0uDnGfGj5L8UCXodtp42fXE+6iYHyFeTPUUySULf4y3dCZx9+89Q4udHC6yxJyKaQa2Tqw6Ea98Zpe7ulgkxmjwd+Uaz5bhj7NSvb4P7P2r9agQbL8WBcX0uuslwGXA6GBhkSENQvO4+KaC5MZB2AXB1231zS3ZrxcKTgnKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758782679; c=relaxed/simple;
	bh=Dq7MTTKuojRJDM3iT59YGYSNv8IhIe3ImGx2gD/A6oU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=JUa17hZg2wxy/5lXmOahmiOLZXV71wjpT2/Xv6IwzmxSzGDfPnMZpifZdo4p0hExuN7QL7M3nnfYaUY7rv44Fp6TNHiMBuBjSXYndLAyMY6Y3Ianf3E7NALTWRjsitjNhqnnKtttoCU1Xeb+55/exXkhHDyKMS2SXXIRmLS6IHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QI+BsNb5; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758782678; x=1790318678;
  h=date:from:to:cc:subject:message-id;
  bh=Dq7MTTKuojRJDM3iT59YGYSNv8IhIe3ImGx2gD/A6oU=;
  b=QI+BsNb5uEcIKYJznzLOGdVnvqwUk0LDUiQXUduqU3a6ewBGoo1E+kTo
   uuLxNVY21G0F9JpaO6Z0BXOxzdU76vWOS2lAkXDf/q3kUa7d6J4+SjV15
   JrJqY59Mx5UAgprjry1aldibTbJVFwta4upSHjBSVoJssY7vnOH61qpmu
   NSbbb6j4cUgC9NdBIHqk+itzPq0sxVq7E2nl5GbVeycABPGH84mweaahH
   Sy42pgZShwVOFQxG63lu6n9mVd+veivLWaFO35I4fmeuWRWJQhqt0UiBC
   gfUeMbIfY1FmyHt8yV7MEDpqAC5aGWoVOBFdz3rkNkktBIVpJ7X1B5mX8
   Q==;
X-CSE-ConnectionGUID: 3YnlkNJ1SzadD3OmmO4BeA==
X-CSE-MsgGUID: R0xb2BmzTuy40SHjef3W0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="61141421"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="61141421"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 23:44:37 -0700
X-CSE-ConnectionGUID: u0JlC03MTbmpzZRQ3b5BpQ==
X-CSE-MsgGUID: 4tAtB58EQaq7p/+17rpDiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="177646579"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 24 Sep 2025 23:44:36 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v1fiH-0004zP-0b;
	Thu, 25 Sep 2025 06:44:28 +0000
Date: Thu, 25 Sep 2025 14:43:01 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:core/urgent] BUILD SUCCESS
 e2ffa15b9baa447e444d654ffd47123ba6443ae4
Message-ID: <202509251454.2hUY3KZl-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/urgent
branch HEAD: e2ffa15b9baa447e444d654ffd47123ba6443ae4  kbuild: Disable CC_HAS_ASM_GOTO_OUTPUT on clang < 17

elapsed time: 1375m

configs tested: 254
configs skipped: 4

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
arc                   randconfig-001-20250924    gcc-11.5.0
arc                   randconfig-001-20250925    gcc-13.4.0
arc                   randconfig-002-20250924    gcc-14.3.0
arc                   randconfig-002-20250925    gcc-13.4.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                   randconfig-001-20250924    clang-22
arm                   randconfig-001-20250925    gcc-13.4.0
arm                   randconfig-002-20250924    clang-22
arm                   randconfig-002-20250925    gcc-13.4.0
arm                   randconfig-003-20250924    clang-22
arm                   randconfig-003-20250925    gcc-13.4.0
arm                   randconfig-004-20250924    gcc-13.4.0
arm                   randconfig-004-20250925    gcc-13.4.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250924    gcc-14.3.0
arm64                 randconfig-001-20250925    gcc-13.4.0
arm64                 randconfig-002-20250924    clang-18
arm64                 randconfig-002-20250925    gcc-13.4.0
arm64                 randconfig-003-20250924    gcc-12.5.0
arm64                 randconfig-003-20250925    gcc-13.4.0
arm64                 randconfig-004-20250924    clang-22
arm64                 randconfig-004-20250925    gcc-13.4.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250924    gcc-14.3.0
csky                  randconfig-001-20250925    clang-22
csky                  randconfig-002-20250924    gcc-15.1.0
csky                  randconfig-002-20250925    clang-22
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250924    clang-22
hexagon               randconfig-001-20250925    clang-22
hexagon               randconfig-002-20250924    clang-22
hexagon               randconfig-002-20250925    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20250924    gcc-14
i386        buildonly-randconfig-001-20250925    gcc-14
i386        buildonly-randconfig-002-20250924    clang-20
i386        buildonly-randconfig-002-20250925    gcc-14
i386        buildonly-randconfig-003-20250924    gcc-13
i386        buildonly-randconfig-003-20250925    gcc-14
i386        buildonly-randconfig-004-20250924    gcc-14
i386        buildonly-randconfig-004-20250925    gcc-14
i386        buildonly-randconfig-005-20250924    clang-20
i386        buildonly-randconfig-005-20250925    gcc-14
i386        buildonly-randconfig-006-20250924    clang-20
i386        buildonly-randconfig-006-20250925    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20250925    gcc-14
i386                  randconfig-002-20250925    gcc-14
i386                  randconfig-003-20250925    gcc-14
i386                  randconfig-004-20250925    gcc-14
i386                  randconfig-005-20250925    gcc-14
i386                  randconfig-006-20250925    gcc-14
i386                  randconfig-007-20250925    gcc-14
i386                  randconfig-011-20250925    clang-20
i386                  randconfig-012-20250925    clang-20
i386                  randconfig-013-20250925    clang-20
i386                  randconfig-014-20250925    clang-20
i386                  randconfig-015-20250925    clang-20
i386                  randconfig-016-20250925    clang-20
i386                  randconfig-017-20250925    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250924    gcc-15.1.0
loongarch             randconfig-001-20250925    clang-22
loongarch             randconfig-002-20250924    gcc-14.3.0
loongarch             randconfig-002-20250925    clang-22
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           ip30_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250924    gcc-11.5.0
nios2                 randconfig-001-20250925    clang-22
nios2                 randconfig-002-20250924    gcc-8.5.0
nios2                 randconfig-002-20250925    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250924    gcc-12.5.0
parisc                randconfig-001-20250925    clang-22
parisc                randconfig-002-20250924    gcc-13.4.0
parisc                randconfig-002-20250925    clang-22
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                  mpc866_ads_defconfig    clang-22
powerpc                      pmac32_defconfig    clang-22
powerpc               randconfig-001-20250924    clang-18
powerpc               randconfig-001-20250925    clang-22
powerpc               randconfig-002-20250924    clang-18
powerpc               randconfig-002-20250925    clang-22
powerpc               randconfig-003-20250924    clang-22
powerpc               randconfig-003-20250925    clang-22
powerpc64             randconfig-001-20250924    clang-22
powerpc64             randconfig-001-20250925    clang-22
powerpc64             randconfig-002-20250924    gcc-15.1.0
powerpc64             randconfig-002-20250925    clang-22
powerpc64             randconfig-003-20250924    gcc-8.5.0
powerpc64             randconfig-003-20250925    clang-22
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20250924    gcc-8.5.0
riscv                 randconfig-001-20250925    gcc-12.5.0
riscv                 randconfig-002-20250924    clang-22
riscv                 randconfig-002-20250925    gcc-12.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20250924    gcc-8.5.0
s390                  randconfig-001-20250925    gcc-12.5.0
s390                  randconfig-002-20250924    clang-22
s390                  randconfig-002-20250925    gcc-12.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                        dreamcast_defconfig    gcc-15.1.0
sh                    randconfig-001-20250924    gcc-15.1.0
sh                    randconfig-001-20250925    gcc-12.5.0
sh                    randconfig-002-20250924    gcc-15.1.0
sh                    randconfig-002-20250925    gcc-12.5.0
sh                      rts7751r2d1_defconfig    gcc-15.1.0
sh                           se7206_defconfig    gcc-15.1.0
sparc                            alldefconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250924    gcc-15.1.0
sparc                 randconfig-001-20250925    gcc-12.5.0
sparc                 randconfig-002-20250924    gcc-8.5.0
sparc                 randconfig-002-20250925    gcc-12.5.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20250924    gcc-8.5.0
sparc64               randconfig-001-20250925    gcc-12.5.0
sparc64               randconfig-002-20250924    gcc-8.5.0
sparc64               randconfig-002-20250925    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250924    clang-16
um                    randconfig-001-20250925    gcc-12.5.0
um                    randconfig-002-20250924    clang-19
um                    randconfig-002-20250925    gcc-12.5.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250924    clang-20
x86_64      buildonly-randconfig-001-20250925    clang-20
x86_64      buildonly-randconfig-002-20250924    clang-20
x86_64      buildonly-randconfig-002-20250925    clang-20
x86_64      buildonly-randconfig-003-20250924    clang-20
x86_64      buildonly-randconfig-003-20250925    clang-20
x86_64      buildonly-randconfig-004-20250924    gcc-14
x86_64      buildonly-randconfig-004-20250925    clang-20
x86_64      buildonly-randconfig-005-20250924    clang-20
x86_64      buildonly-randconfig-005-20250925    clang-20
x86_64      buildonly-randconfig-006-20250924    clang-20
x86_64      buildonly-randconfig-006-20250925    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250925    gcc-14
x86_64                randconfig-002-20250925    gcc-14
x86_64                randconfig-003-20250925    gcc-14
x86_64                randconfig-004-20250925    gcc-14
x86_64                randconfig-005-20250925    gcc-14
x86_64                randconfig-006-20250925    gcc-14
x86_64                randconfig-007-20250925    gcc-14
x86_64                randconfig-008-20250925    gcc-14
x86_64                randconfig-071-20250925    gcc-14
x86_64                randconfig-072-20250925    gcc-14
x86_64                randconfig-073-20250925    gcc-14
x86_64                randconfig-074-20250925    gcc-14
x86_64                randconfig-075-20250925    gcc-14
x86_64                randconfig-076-20250925    gcc-14
x86_64                randconfig-077-20250925    gcc-14
x86_64                randconfig-078-20250925    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250924    gcc-13.4.0
xtensa                randconfig-001-20250925    gcc-12.5.0
xtensa                randconfig-002-20250924    gcc-8.5.0
xtensa                randconfig-002-20250925    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


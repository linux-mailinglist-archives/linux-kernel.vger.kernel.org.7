Return-Path: <linux-kernel+bounces-743517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3F9B0FF8B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 06:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78BC81C2754B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 04:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9E21DF98D;
	Thu, 24 Jul 2025 04:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nMkQKd4V"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39241804A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 04:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753331491; cv=none; b=FCuSWVJ6vh1sqaAVfSWi8vjmlX5jGLC3URss9mO5Dq8IxAyWdaU4BlX10qAvpFXqUlo6iR9AjUGAzBnF6ms5uZGxbnqvInaQgz83fgU0m0bNcLwqaf8XXOilqmllOky1Z8vTKh7EUW4y1/4Ik31Hhsmn+Zqyt3upDZgPcvS9cI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753331491; c=relaxed/simple;
	bh=FiEFmc+/gt2x75xh+J2U67eF8TMFmJh+PHRhu5ARQFg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=eHp/Qk/BubCi92ERR7csyuAPryADAbHkc7/UvyjRDPEJqRYrbuxq9BD8Yu3E1qLeW/O0T+84xWvJ52T4jCxH99he9b9oF1pXPQOWU2ZPFiWNp89jGNrl/02GLyJOWO0aUi/u7wxAp9/7vGrhFjYrsIf08U/SzV6AmlynuKh3Hdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nMkQKd4V; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753331490; x=1784867490;
  h=date:from:to:cc:subject:message-id;
  bh=FiEFmc+/gt2x75xh+J2U67eF8TMFmJh+PHRhu5ARQFg=;
  b=nMkQKd4VDxDLsy9DSAI/EYTI+EosZKKasEDYpmyYsfWUQ954Qe1O46XP
   xa8UjWammn4RaWJYLNCvUAjjdxazYAfP2hdoNbVxIJlZhCCBrSv/3axL4
   ddsgizCnIVZoggzknyXek39g9EYON3HNpmgnPt/3+tejasUg+YCtORe3i
   anIrbdLOIbFNF3Neon1rBYcl8lV+Z+mE6brN9rzPKg9XV5QHro3ZM8xxU
   pbtYKT5x/FjzkDLzfvlZxLJfvtsMaTGWAfB7kCEUrAjDxYceDIIsHSMSU
   FBsO6MSg0QkqF+Dq+FoBcXafJMTn989expPtWLFpgrpkR3Enq0Ta2W2WK
   w==;
X-CSE-ConnectionGUID: gMYDvSqnSdi2m/iqU6D+eA==
X-CSE-MsgGUID: bRZ6aDX9S7mWUmkErTGq3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="81075838"
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="81075838"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 21:31:29 -0700
X-CSE-ConnectionGUID: 4qBoSKqIR0+2/Jl9JRWr/w==
X-CSE-MsgGUID: lSAAy2s2Q0CR2NMirPZnRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="159234395"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 23 Jul 2025 21:31:28 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uenc5-000K4p-2g;
	Thu, 24 Jul 2025 04:31:25 +0000
Date: Thu, 24 Jul 2025 12:30:59 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20250723] BUILD SUCCESS
 49c6b94fa76fb9af574157e2c2b25f7894a744f4
Message-ID: <202507241247.NDvBZ8Cl-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20250723
branch HEAD: 49c6b94fa76fb9af574157e2c2b25f7894a744f4  treewide-TRAILING_OVERLAP: Avoid -Wflex-array-member-not-at-end warnings

elapsed time: 1453m

configs tested: 224
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                         haps_hs_defconfig    gcc-15.1.0
arc                   randconfig-001-20250723    gcc-8.5.0
arc                   randconfig-001-20250724    clang-22
arc                   randconfig-002-20250723    gcc-9.5.0
arc                   randconfig-002-20250724    clang-22
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                        multi_v7_defconfig    gcc-15.1.0
arm                           omap1_defconfig    gcc-15.1.0
arm                   randconfig-001-20250723    gcc-13.4.0
arm                   randconfig-001-20250724    clang-22
arm                   randconfig-002-20250723    gcc-13.4.0
arm                   randconfig-002-20250724    clang-22
arm                   randconfig-003-20250723    clang-16
arm                   randconfig-003-20250724    clang-22
arm                   randconfig-004-20250724    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250724    clang-22
arm64                 randconfig-002-20250724    clang-22
arm64                 randconfig-003-20250723    clang-16
arm64                 randconfig-003-20250724    clang-22
arm64                 randconfig-004-20250723    clang-22
arm64                 randconfig-004-20250724    clang-22
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250723    gcc-12.5.0
csky                  randconfig-002-20250723    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250723    clang-22
hexagon               randconfig-002-20250723    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250723    clang-20
i386        buildonly-randconfig-001-20250724    gcc-12
i386        buildonly-randconfig-002-20250723    clang-20
i386        buildonly-randconfig-002-20250724    gcc-12
i386        buildonly-randconfig-003-20250723    clang-20
i386        buildonly-randconfig-003-20250724    gcc-12
i386        buildonly-randconfig-004-20250723    clang-20
i386        buildonly-randconfig-004-20250724    gcc-12
i386        buildonly-randconfig-005-20250723    gcc-11
i386        buildonly-randconfig-005-20250724    gcc-12
i386        buildonly-randconfig-006-20250723    clang-20
i386        buildonly-randconfig-006-20250724    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250724    clang-20
i386                  randconfig-002-20250724    clang-20
i386                  randconfig-003-20250724    clang-20
i386                  randconfig-004-20250724    clang-20
i386                  randconfig-005-20250724    clang-20
i386                  randconfig-006-20250724    clang-20
i386                  randconfig-007-20250724    clang-20
i386                  randconfig-011-20250724    gcc-12
i386                  randconfig-012-20250724    gcc-12
i386                  randconfig-013-20250724    gcc-12
i386                  randconfig-014-20250724    gcc-12
i386                  randconfig-015-20250724    gcc-12
i386                  randconfig-016-20250724    gcc-12
i386                  randconfig-017-20250724    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250723    gcc-15.1.0
loongarch             randconfig-002-20250723    clang-22
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                          hp300_defconfig    gcc-15.1.0
m68k                        stmark2_defconfig    gcc-15.1.0
m68k                          sun3x_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          eyeq6_defconfig    clang-22
nios2                         3c120_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250723    gcc-8.5.0
nios2                 randconfig-002-20250723    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
openrisc                 simple_smp_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                generic-64bit_defconfig    gcc-15.1.0
parisc                randconfig-001-20250723    gcc-8.5.0
parisc                randconfig-002-20250723    gcc-15.1.0
parisc64                         alldefconfig    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                     ksi8560_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250723    gcc-10.5.0
powerpc               randconfig-002-20250723    gcc-8.5.0
powerpc               randconfig-003-20250723    gcc-12.5.0
powerpc                    sam440ep_defconfig    gcc-15.1.0
powerpc                     tqm8541_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250723    clang-22
powerpc64             randconfig-002-20250723    clang-22
powerpc64             randconfig-003-20250723    clang-22
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250723    gcc-9.5.0
riscv                 randconfig-001-20250724    gcc-13.4.0
riscv                 randconfig-002-20250724    gcc-13.4.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250723    clang-22
s390                  randconfig-001-20250724    gcc-13.4.0
s390                  randconfig-002-20250723    clang-20
s390                  randconfig-002-20250724    gcc-13.4.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250723    gcc-12.5.0
sh                    randconfig-001-20250724    gcc-13.4.0
sh                    randconfig-002-20250723    gcc-9.5.0
sh                    randconfig-002-20250724    gcc-13.4.0
sh                           se7722_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250723    gcc-8.5.0
sparc                 randconfig-001-20250724    gcc-13.4.0
sparc                 randconfig-002-20250723    gcc-8.5.0
sparc                 randconfig-002-20250724    gcc-13.4.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250723    gcc-12.5.0
sparc64               randconfig-001-20250724    gcc-13.4.0
sparc64               randconfig-002-20250723    gcc-14.3.0
sparc64               randconfig-002-20250724    gcc-13.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250723    gcc-12
um                    randconfig-001-20250724    gcc-13.4.0
um                    randconfig-002-20250723    clang-22
um                    randconfig-002-20250724    gcc-13.4.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250723    gcc-12
x86_64      buildonly-randconfig-001-20250724    gcc-12
x86_64      buildonly-randconfig-002-20250723    gcc-11
x86_64      buildonly-randconfig-002-20250724    gcc-12
x86_64      buildonly-randconfig-003-20250723    gcc-11
x86_64      buildonly-randconfig-003-20250724    gcc-12
x86_64      buildonly-randconfig-004-20250723    clang-20
x86_64      buildonly-randconfig-004-20250724    gcc-12
x86_64      buildonly-randconfig-005-20250723    gcc-12
x86_64      buildonly-randconfig-005-20250724    gcc-12
x86_64      buildonly-randconfig-006-20250723    gcc-12
x86_64      buildonly-randconfig-006-20250724    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250724    gcc-12
x86_64                randconfig-002-20250724    gcc-12
x86_64                randconfig-003-20250724    gcc-12
x86_64                randconfig-004-20250724    gcc-12
x86_64                randconfig-005-20250724    gcc-12
x86_64                randconfig-006-20250724    gcc-12
x86_64                randconfig-007-20250724    gcc-12
x86_64                randconfig-008-20250724    gcc-12
x86_64                randconfig-071-20250724    clang-20
x86_64                randconfig-072-20250724    clang-20
x86_64                randconfig-073-20250724    clang-20
x86_64                randconfig-074-20250724    clang-20
x86_64                randconfig-075-20250724    clang-20
x86_64                randconfig-076-20250724    clang-20
x86_64                randconfig-077-20250724    clang-20
x86_64                randconfig-078-20250724    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250723    gcc-13.4.0
xtensa                randconfig-001-20250724    gcc-13.4.0
xtensa                randconfig-002-20250723    gcc-10.5.0
xtensa                randconfig-002-20250724    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


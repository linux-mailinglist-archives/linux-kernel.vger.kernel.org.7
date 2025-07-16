Return-Path: <linux-kernel+bounces-733743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7F7B07890
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A214F7BCABD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E3E2750F0;
	Wed, 16 Jul 2025 14:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MK3bPCn4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51744264615
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677202; cv=none; b=Sz1nilj6+Hb5wryqG/rF7HfosZXDk69/jxubyC7Zrf10byB7BuLTtXeeVsJ+L56oKnCr7M+9q16FRMhwCPzrB8QgJ2MiDML7pZyJYyLaShthhsJQ7Jykh3CJImlfmo7xLTUEJf2XNtxm5j+3dGakWlyZ8YG95Qdsnrm+0coFLHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677202; c=relaxed/simple;
	bh=u5UtNQQwH63fgzPLH848df1l35qsV5tA9V2adLKjbw4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=iifENaonjRNxBVM3EPaY11NQEHkQ6dmRlA2Cpzpf/6toaO7LptLpCFAuy0THJtiDK87QrdefdBIZh0FcnS6fNECFBinmiu1BpNyEmrazfnYWI+yMUrylD0y/IMVdCLCtucEokQNTaAlDdyenoCeg/jMTaXoE0gs8711ygrTa57c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MK3bPCn4; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752677200; x=1784213200;
  h=date:from:to:cc:subject:message-id;
  bh=u5UtNQQwH63fgzPLH848df1l35qsV5tA9V2adLKjbw4=;
  b=MK3bPCn4BRWJWXj3NozF9yLT6UVBlFMLxzIVb/J8cJjrgzeW7Mmyrfaj
   G/YUZ1Rok3qgHRitk8DlSxXW/tb0CnY84/2sSxBCE1ysPXitfmXjgbbdD
   jXwCqHlVI2GLu1uAMUUEHBcpqrSWPoYIfyx7HxypWWlvb5pu5YVCA557U
   8gX+zLbGjV3aG09oXyWBRQkGMkJI0R8kXqncDaptwuNzRoc2vAVCqSOJ4
   KCwPa0g2LVrCbtaGEuZQTAplf3FWLp2yTbbSCB4Rw2ta7lkxBtLCdi6xv
   jrJ4gBSqLyegSkPmiAgl1aYdFNKgcZ7Qbhu1FUJ/1M/Khu1cO2XPUR43u
   A==;
X-CSE-ConnectionGUID: tNuHTXVKRwm79uA58XdzMw==
X-CSE-MsgGUID: Jeugx+ziRhCHb0KD9t4GZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="65623327"
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="65623327"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 07:46:40 -0700
X-CSE-ConnectionGUID: z3GZUeQdTj2PlR0b8S3LLw==
X-CSE-MsgGUID: bNIxS+wqSDuLDEgehjHkgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="157190795"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 16 Jul 2025 07:46:38 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uc3P2-000CW7-1R;
	Wed, 16 Jul 2025 14:46:36 +0000
Date: Wed, 16 Jul 2025 22:46:21 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 7f2b41ac3f29f682cde113f1d0b4b43d261902fe
Message-ID: <202507162209.spOGct6n-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: 7f2b41ac3f29f682cde113f1d0b4b43d261902fe  x86/apic: Move apic_update_irq_cfg() call to apic_update_vector()

elapsed time: 1679m

configs tested: 181
configs skipped: 182

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-21
alpha                            allyesconfig    clang-19
alpha                               defconfig    clang-19
arc                               allnoconfig    clang-21
arc                          axs103_defconfig    clang-21
arc                      axs103_smp_defconfig    clang-21
arc                                 defconfig    clang-19
arc                   randconfig-001-20250716    clang-21
arc                   randconfig-002-20250716    clang-21
arm                               allnoconfig    clang-21
arm                         bcm2835_defconfig    clang-21
arm                                 defconfig    clang-19
arm                   randconfig-001-20250716    clang-21
arm                   randconfig-002-20250716    clang-21
arm                   randconfig-003-20250716    clang-21
arm                   randconfig-004-20250716    clang-21
arm                         s3c6400_defconfig    clang-21
arm64                            alldefconfig    clang-21
arm64                             allnoconfig    clang-21
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250716    clang-21
arm64                 randconfig-002-20250716    clang-21
arm64                 randconfig-003-20250716    clang-21
arm64                 randconfig-004-20250716    clang-21
csky                              allnoconfig    clang-21
csky                                defconfig    clang-19
csky                  randconfig-001-20250716    gcc-15.1.0
csky                  randconfig-002-20250716    gcc-15.1.0
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-19
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250716    gcc-15.1.0
hexagon               randconfig-002-20250716    gcc-15.1.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250715    gcc-12
i386        buildonly-randconfig-001-20250716    gcc-12
i386        buildonly-randconfig-002-20250715    gcc-12
i386        buildonly-randconfig-002-20250716    gcc-12
i386        buildonly-randconfig-003-20250715    gcc-12
i386        buildonly-randconfig-003-20250716    gcc-12
i386        buildonly-randconfig-004-20250715    clang-20
i386        buildonly-randconfig-004-20250716    gcc-12
i386        buildonly-randconfig-005-20250715    clang-20
i386        buildonly-randconfig-005-20250716    gcc-12
i386        buildonly-randconfig-006-20250715    clang-20
i386        buildonly-randconfig-006-20250716    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250716    clang-20
i386                  randconfig-002-20250716    clang-20
i386                  randconfig-003-20250716    clang-20
i386                  randconfig-004-20250716    clang-20
i386                  randconfig-005-20250716    clang-20
i386                  randconfig-006-20250716    clang-20
i386                  randconfig-007-20250716    clang-20
i386                  randconfig-011-20250716    gcc-12
i386                  randconfig-012-20250716    gcc-12
i386                  randconfig-013-20250716    gcc-12
i386                  randconfig-014-20250716    gcc-12
i386                  randconfig-015-20250716    gcc-12
i386                  randconfig-016-20250716    gcc-12
i386                  randconfig-017-20250716    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250716    gcc-15.1.0
loongarch             randconfig-002-20250716    gcc-15.1.0
m68k                             allmodconfig    clang-19
m68k                             allyesconfig    clang-19
m68k                         amcore_defconfig    clang-21
m68k                                defconfig    clang-19
m68k                        m5407c3_defconfig    clang-21
microblaze                       allmodconfig    clang-19
microblaze                       allyesconfig    clang-19
microblaze                          defconfig    gcc-15.1.0
mips                        maltaup_defconfig    clang-21
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250716    gcc-15.1.0
nios2                 randconfig-002-20250716    gcc-15.1.0
openrisc                          allnoconfig    clang-21
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250716    gcc-15.1.0
parisc                randconfig-002-20250716    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                          allyesconfig    gcc-15.1.0
powerpc                   bluestone_defconfig    clang-21
powerpc                      cm5200_defconfig    clang-21
powerpc                   currituck_defconfig    clang-21
powerpc               randconfig-001-20250716    gcc-15.1.0
powerpc               randconfig-002-20250716    gcc-15.1.0
powerpc               randconfig-003-20250716    gcc-15.1.0
powerpc                     stx_gp3_defconfig    clang-21
powerpc64             randconfig-001-20250716    gcc-15.1.0
powerpc64             randconfig-003-20250716    gcc-15.1.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250716    gcc-9.3.0
riscv                 randconfig-002-20250716    gcc-9.3.0
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250716    gcc-9.3.0
s390                  randconfig-002-20250716    gcc-9.3.0
sh                               allmodconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                ecovec24-romimage_defconfig    clang-21
sh                          kfr2r09_defconfig    clang-21
sh                    randconfig-001-20250716    gcc-9.3.0
sh                    randconfig-002-20250716    gcc-9.3.0
sh                  sh7785lcr_32bit_defconfig    clang-21
sparc                            allmodconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250716    gcc-9.3.0
sparc                 randconfig-002-20250716    gcc-9.3.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250716    gcc-9.3.0
sparc64               randconfig-002-20250716    gcc-9.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250716    gcc-9.3.0
um                    randconfig-002-20250716    gcc-9.3.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250715    clang-20
x86_64      buildonly-randconfig-001-20250716    clang-20
x86_64      buildonly-randconfig-002-20250715    gcc-12
x86_64      buildonly-randconfig-002-20250716    clang-20
x86_64      buildonly-randconfig-003-20250715    gcc-12
x86_64      buildonly-randconfig-003-20250716    clang-20
x86_64      buildonly-randconfig-004-20250715    gcc-11
x86_64      buildonly-randconfig-004-20250716    clang-20
x86_64      buildonly-randconfig-005-20250715    gcc-12
x86_64      buildonly-randconfig-005-20250716    clang-20
x86_64      buildonly-randconfig-006-20250715    gcc-12
x86_64      buildonly-randconfig-006-20250716    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250716    clang-20
x86_64                randconfig-002-20250716    clang-20
x86_64                randconfig-003-20250716    clang-20
x86_64                randconfig-004-20250716    clang-20
x86_64                randconfig-005-20250716    clang-20
x86_64                randconfig-006-20250716    clang-20
x86_64                randconfig-007-20250716    clang-20
x86_64                randconfig-008-20250716    clang-20
x86_64                randconfig-071-20250716    gcc-12
x86_64                randconfig-072-20250716    gcc-12
x86_64                randconfig-073-20250716    gcc-12
x86_64                randconfig-074-20250716    gcc-12
x86_64                randconfig-075-20250716    gcc-12
x86_64                randconfig-076-20250716    gcc-12
x86_64                randconfig-077-20250716    gcc-12
x86_64                randconfig-078-20250716    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                randconfig-001-20250716    gcc-9.3.0
xtensa                randconfig-002-20250716    gcc-9.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


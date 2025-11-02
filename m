Return-Path: <linux-kernel+bounces-882009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 435EDC29708
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 22:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 490A9188C480
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 21:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F9217C211;
	Sun,  2 Nov 2025 21:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cRVQjGPu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEEEF9EC
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 21:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762118180; cv=none; b=SxOoeQSdppIaMDdqiEHjQk6/FPB3VjxhabX0eG7yHOnqKe7Fnil0VZ/yEX+1o3xBZOsp8SyEKPG8Vlmcp432hcHb7GgYgmB4HdKZJv2eTAs6Lh0q9/VRBzlunGQxKIY8+e5l3N8Ny8qc4/2QnfLwF2jaSS2ONScdbT8VxAum6ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762118180; c=relaxed/simple;
	bh=49fDOQlVVQrH97mZ33vWhz1qt/nmq7lFUqqvkQBJ2V4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=oOBF7a/3MT2m9aj3PsbW4RBBgPBKUTTncxwOW4zuH0tHY3pMeq7Zi06+CiALYcwYZSmumD1yOGFUemEEOW0lK8TCHMe+q1ZRNi8kIyXgwGRZ6YsGlWbgQmXxfXufQHlgdHNakXbaQrqPQVYgypBu752muHN0v/gFgL3tPWfbjGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cRVQjGPu; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762118178; x=1793654178;
  h=date:from:to:cc:subject:message-id;
  bh=49fDOQlVVQrH97mZ33vWhz1qt/nmq7lFUqqvkQBJ2V4=;
  b=cRVQjGPufTE62zAqfxHeLLBIy+rjuJzF+pR4hcILmyzVk+SFlPMmsjcm
   DbwuYIjyfLBWY25XQnIf+i+mGOPNOB+qEXpXb12YBtUvmcH3cBFBZKTGV
   8jXu04tdsjGEgLcSQD69L+yfMp3CG8YZaObFW1B2MULkhNCXZrUWI79zA
   RJfuJJr0am8zVwPmsS43gm0w8OUEpSNx5abD2K1Wy+qt2OJW4xAE8JEXM
   TBAfeI/seMHDQOavhd+W11yS4jw4IqNEMV4+dPeruSbwau5oV+h0BaPQV
   ZJq3AtNxvVjMKEcljtpX8eq+fsSJ/Zx+1809aDPNWBp24NlfZg7exLPNC
   g==;
X-CSE-ConnectionGUID: 5roI4wF2QYOMRra+86WfKw==
X-CSE-MsgGUID: b1SxlF7PTWuC8zMFBP9vXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="51770181"
X-IronPort-AV: E=Sophos;i="6.19,274,1754982000"; 
   d="scan'208";a="51770181"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2025 13:16:17 -0800
X-CSE-ConnectionGUID: ws6guCO0T4in0WnONRcZ7g==
X-CSE-MsgGUID: prQL7DwfQpCaEA8opD22tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,274,1754982000"; 
   d="scan'208";a="186587155"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 02 Nov 2025 13:16:16 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vFfQs-000PZ6-27;
	Sun, 02 Nov 2025 21:16:14 +0000
Date: Mon, 03 Nov 2025 05:15:34 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 51d0656959bcdb743232f9b530b4cca569e74e7f
Message-ID: <202511030526.F5qAzzdO-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: 51d0656959bcdb743232f9b530b4cca569e74e7f  genirq/manage: Reduce priority of forced secondary interrupt handler

elapsed time: 1453m

configs tested: 134
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
arc                   randconfig-001-20251102    gcc-8.5.0
arc                   randconfig-002-20251102    gcc-14.3.0
arm                               allnoconfig    clang-22
arm                        neponset_defconfig    gcc-15.1.0
arm                         orion5x_defconfig    clang-22
arm                   randconfig-001-20251102    gcc-15.1.0
arm                   randconfig-002-20251102    gcc-10.5.0
arm                   randconfig-003-20251102    gcc-8.5.0
arm                   randconfig-004-20251102    gcc-14.3.0
arm                           spitz_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
arm64                            allyesconfig    clang-22
arm64                 randconfig-001-20251103    clang-22
arm64                 randconfig-002-20251103    gcc-13.4.0
arm64                 randconfig-003-20251103    gcc-14.3.0
arm64                 randconfig-004-20251103    gcc-8.5.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251103    gcc-15.1.0
csky                  randconfig-002-20251103    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251102    clang-22
hexagon               randconfig-002-20251102    clang-22
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251102    gcc-14
i386        buildonly-randconfig-003-20251102    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251103    clang-20
i386                  randconfig-002-20251103    gcc-14
i386                  randconfig-003-20251103    gcc-14
i386                  randconfig-004-20251103    clang-20
i386                  randconfig-005-20251103    gcc-14
i386                  randconfig-006-20251103    clang-20
i386                  randconfig-007-20251103    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                        allyesconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251102    gcc-15.1.0
loongarch             randconfig-002-20251102    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                        mvme147_defconfig    gcc-15.1.0
m68k                            q40_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                            allyesconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251102    gcc-11.5.0
nios2                 randconfig-002-20251102    gcc-11.5.0
openrisc                         alldefconfig    gcc-15.1.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251102    gcc-8.5.0
parisc                randconfig-002-20251102    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                        fsp2_defconfig    gcc-15.1.0
powerpc                  mpc866_ads_defconfig    clang-22
powerpc               randconfig-001-20251102    gcc-9.5.0
powerpc               randconfig-002-20251102    clang-18
powerpc64             randconfig-001-20251102    gcc-14.3.0
powerpc64             randconfig-002-20251102    gcc-8.5.0
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251102    gcc-13.4.0
riscv                 randconfig-002-20251102    gcc-14.3.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-002-20251102    gcc-11.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251102    gcc-13.4.0
sh                    randconfig-002-20251102    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                            allyesconfig    gcc-15.1.0
sparc                 randconfig-001-20251103    gcc-15.1.0
sparc                 randconfig-002-20251103    gcc-11.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251103    clang-22
sparc64               randconfig-002-20251103    gcc-8.5.0
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251103    clang-19
um                    randconfig-002-20251103    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251102    gcc-14
x86_64      buildonly-randconfig-002-20251102    clang-20
x86_64      buildonly-randconfig-003-20251102    clang-20
x86_64      buildonly-randconfig-004-20251102    clang-20
x86_64      buildonly-randconfig-005-20251102    gcc-14
x86_64      buildonly-randconfig-006-20251102    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-011-20251102    gcc-14
x86_64                randconfig-012-20251102    gcc-14
x86_64                randconfig-013-20251102    gcc-12
x86_64                randconfig-014-20251102    gcc-14
x86_64                randconfig-015-20251102    gcc-14
x86_64                randconfig-016-20251102    gcc-14
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251103    gcc-13.4.0
xtensa                randconfig-002-20251103    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


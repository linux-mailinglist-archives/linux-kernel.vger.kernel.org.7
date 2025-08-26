Return-Path: <linux-kernel+bounces-786083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C72B354C3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 08:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E24FD1B61F04
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 06:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7782F533E;
	Tue, 26 Aug 2025 06:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZGxS0mfV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524B7224AE6
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 06:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756191056; cv=none; b=jlLBcuAqWjRrvp3PqSZjUILxldsTTfju5LMF3vUCd/5WMPyD5u6bAfuoJ19NK73nTF3d5kaZGg8IxVTaOH17SQ5btkUg4+1mlVUJcb3CjtcUbaI4Vi7lranrR/TuZL75cMSvHzxuOYOFL1RuCcieYJ7Qq630+wadNkzERLRQRmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756191056; c=relaxed/simple;
	bh=ZFS5sBbkoEhMRyBmrVv6Z+efTAPjzH8VPaM7NiPoNiI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=l/fCYluCFKKYgVZx3DXouUiUdJI7q7Ulwh3KFrliA0OCAEeTlp0TMx0pyLcC5+EBdISIsHWhhgsNuIextvk0Ae+ADNpZG4wkJnHMGi12Yhe13H6Wyv4isO8tdKYhMEpOh7PjPA20UgE/A8mYp7o4fkJ4pOHWE+FZ7lgWlpUlhfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZGxS0mfV; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756191052; x=1787727052;
  h=date:from:to:cc:subject:message-id;
  bh=ZFS5sBbkoEhMRyBmrVv6Z+efTAPjzH8VPaM7NiPoNiI=;
  b=ZGxS0mfVZwzeOTl2CxNnhSoH26Dpi2qkrfguAb+kfeY5C45u7vSbiQpi
   tTCuwp8HcBRTI8+C/bHt3qJcsmiaY4GHtq/i3N9FVcgO0Z9l4n2IlSSXd
   u9pZtGvpy3PFvRz7jWOBynmByd9DvWWMUN1hZScNWSu96bPz3qlLX0nfl
   +w8SLD1toaJSk1PejIwiFTP2QX2r0Om72eo0woJMFgd1ZcjkUFVmGCUlk
   HRm6JM8LPaIKsnbuqinMtpoUSmvkbppwfF4k2W641pthDeAeJpnFYtQ2H
   uOVlgy84Wrj9dQ77XkA7VbHvFgjuvB0MMSkhtS0l2Us0/mDqeJ2zlohaq
   Q==;
X-CSE-ConnectionGUID: 6Ecx/NCeR3+j0cJipMzbVg==
X-CSE-MsgGUID: JnAFDOJ1TZeIl5/byYc2OA==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="58274951"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="58274951"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 23:50:51 -0700
X-CSE-ConnectionGUID: RloBcyvkTNGV884Z27vLnA==
X-CSE-MsgGUID: 9ul9UAatQSKU3MfgD1g+8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="200385989"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 25 Aug 2025 23:50:49 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uqnW3-000OHi-0o;
	Tue, 26 Aug 2025 06:50:47 +0000
Date: Tue, 26 Aug 2025 14:50:35 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 13bdfb53aa04eeb8022af87288c5bc0a5d13a834
Message-ID: <202508261425.ToMecrhy-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: 13bdfb53aa04eeb8022af87288c5bc0a5d13a834  x86/sgx: Use ENCLS mnemonic in <kernel/cpu/sgx/encls.h>

elapsed time: 876m

configs tested: 124
configs skipped: 120

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                            allyesconfig    clang-19
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-22
arc                              allyesconfig    clang-19
arc                      axs103_smp_defconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20250826    gcc-8.5.0
arc                   randconfig-002-20250826    gcc-8.5.0
arm                              alldefconfig    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                   milbeaut_m10v_defconfig    gcc-15.1.0
arm                   randconfig-001-20250826    gcc-8.5.0
arm                   randconfig-002-20250826    gcc-8.5.0
arm                   randconfig-003-20250826    gcc-8.5.0
arm                   randconfig-004-20250826    gcc-8.5.0
arm                       versatile_defconfig    gcc-15.1.0
arm                        vexpress_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250826    gcc-8.5.0
arm64                 randconfig-002-20250826    gcc-8.5.0
arm64                 randconfig-003-20250826    gcc-8.5.0
arm64                 randconfig-004-20250826    gcc-8.5.0
csky                              allnoconfig    clang-22
csky                                defconfig    clang-19
csky                  randconfig-001-20250826    gcc-14.3.0
csky                  randconfig-002-20250826    gcc-14.3.0
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250826    gcc-14.3.0
hexagon               randconfig-002-20250826    gcc-14.3.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250826    gcc-12
i386        buildonly-randconfig-002-20250826    gcc-12
i386        buildonly-randconfig-003-20250826    clang-20
i386        buildonly-randconfig-004-20250826    gcc-12
i386        buildonly-randconfig-005-20250826    clang-20
i386        buildonly-randconfig-006-20250826    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250826    gcc-11
i386                  randconfig-002-20250826    gcc-11
i386                  randconfig-003-20250826    gcc-11
i386                  randconfig-004-20250826    gcc-11
i386                  randconfig-005-20250826    gcc-11
i386                  randconfig-006-20250826    gcc-11
i386                  randconfig-007-20250826    gcc-11
i386                  randconfig-011-20250826    gcc-12
i386                  randconfig-012-20250826    gcc-12
i386                  randconfig-013-20250826    gcc-12
i386                  randconfig-014-20250826    gcc-12
i386                  randconfig-015-20250826    gcc-12
i386                  randconfig-016-20250826    gcc-12
i386                  randconfig-017-20250826    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250826    gcc-14.3.0
loongarch             randconfig-002-20250826    gcc-14.3.0
m68k                             allmodconfig    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
mips                              allnoconfig    gcc-15.1.0
mips                           ip30_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-15.1.0
nios2                 randconfig-001-20250826    gcc-14.3.0
nios2                 randconfig-002-20250826    gcc-14.3.0
openrisc                            defconfig    gcc-12
parisc                randconfig-001-20250826    gcc-14.3.0
parisc                randconfig-002-20250826    gcc-14.3.0
powerpc               randconfig-001-20250826    gcc-14.3.0
powerpc               randconfig-002-20250826    gcc-14.3.0
powerpc               randconfig-003-20250826    gcc-14.3.0
powerpc                      tqm8xx_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250826    gcc-14.3.0
powerpc64             randconfig-002-20250826    gcc-14.3.0
powerpc64             randconfig-003-20250826    gcc-14.3.0
riscv                               defconfig    gcc-12
s390                                defconfig    gcc-12
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sparc                             allnoconfig    gcc-15.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-19
um                               allyesconfig    clang-19
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250826    clang-20
x86_64      buildonly-randconfig-002-20250826    clang-20
x86_64      buildonly-randconfig-003-20250826    gcc-12
x86_64      buildonly-randconfig-004-20250826    clang-20
x86_64      buildonly-randconfig-005-20250826    gcc-12
x86_64      buildonly-randconfig-006-20250826    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                randconfig-001-20250826    gcc-12
x86_64                randconfig-002-20250826    gcc-12
x86_64                randconfig-003-20250826    gcc-12
x86_64                randconfig-004-20250826    gcc-12
x86_64                randconfig-005-20250826    gcc-12
x86_64                randconfig-006-20250826    gcc-12
x86_64                randconfig-007-20250826    gcc-12
x86_64                randconfig-008-20250826    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


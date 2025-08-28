Return-Path: <linux-kernel+bounces-789525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81761B396D0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49ED74650AF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 08:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476CC2D73AA;
	Thu, 28 Aug 2025 08:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oGKUasTQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D61849C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 08:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756369495; cv=none; b=S8tNakJOeEMb42dCxka3Xjod1i97ka2jpK+9adhYtDBo4MRSSEDmQ8tShjf6lCRKJ8P0baaTgXwfNlzrIRCrz/eGee0I9zSg6aFpK7l/BUm8d7ARgZ254zLfmVcYqQHnSC0Z0642B5OcUUvYidAMEWUWfx+LjZ7caCrOG8+8pXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756369495; c=relaxed/simple;
	bh=8p85gv+wgLjXc9mSghFmH5iFx33OGKSnHN8xLP7ilt0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=U2yutP8c3MtYtsmf5zwb+sChHgR3dX77UsIBT9oO4hKyNzf2VWnmRUvvjKgO3TcSgAW8x5lkAAEnbv8ODvqvIfNaCL0O733S8ELcraHhb3ISOjgquTo6e0KVJVOueRg/Xnozcvt1xCKLFhcyMLMitcsFJWQeruy2D9FhoNXN7D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oGKUasTQ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756369494; x=1787905494;
  h=date:from:to:cc:subject:message-id;
  bh=8p85gv+wgLjXc9mSghFmH5iFx33OGKSnHN8xLP7ilt0=;
  b=oGKUasTQd4c6RKmd0g8q57itODJlk4wyoXmSJc8HdcapEX5WRcTXM6cs
   kSo4zoMkzVFWbp5A3mQk/Iil2b/9iWzm5myMX6Z4aDdXgFsUifmi2xJ6x
   I3XCzXgBnES58Ncb1I7OtYMy9QaCQngLNIUt79LMWfLzPmort7u+tQAXn
   GuHNEDNRN8mv+s4atO+VDBUDBtnwI/IEjI4Vvvmj8/QzSWA5e++y7sc/a
   dQvpsvQ7hiaZ2QwSJ0rNzIYaMzpIdOrmCfNp32ofLLZcDCEhUzfIxzUkA
   UK3o1wQ08yV7rJn3SneeUVvy9Dydf5mlTSqI2CVakOEYdOSYs5sq5HhC+
   g==;
X-CSE-ConnectionGUID: XqPJpb+lQqi/dU60dQjDcQ==
X-CSE-MsgGUID: PVyMSKINQiS3P08PGhJg0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58698338"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58698338"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 01:24:53 -0700
X-CSE-ConnectionGUID: pxTnigAeT++Exvkyezxo5Q==
X-CSE-MsgGUID: wO+P2L8JTsunurdiM5jCVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="174219702"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 28 Aug 2025 01:24:52 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1urXw9-000TUh-1E;
	Thu, 28 Aug 2025 08:24:49 +0000
Date: Thu, 28 Aug 2025 16:24:37 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:locking/urgent] BUILD SUCCESS
 1b708b38414d32838baa39c9dee59d40731ed202
Message-ID: <202508281627.5hlsWy8a-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/urgent
branch HEAD: 1b708b38414d32838baa39c9dee59d40731ed202  futex: Move futex_hash_free() back to __mmput()

elapsed time: 1210m

configs tested: 248
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-15.1.0
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
arc                      axs103_smp_defconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20250827    gcc-12.5.0
arc                   randconfig-001-20250828    clang-22
arc                   randconfig-002-20250827    gcc-8.5.0
arc                   randconfig-002-20250828    clang-22
arc                        vdk_hs38_defconfig    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                         axm55xx_defconfig    clang-22
arm                                 defconfig    clang-19
arm                          pxa168_defconfig    clang-19
arm                   randconfig-001-20250827    clang-22
arm                   randconfig-001-20250828    clang-22
arm                   randconfig-002-20250827    clang-22
arm                   randconfig-002-20250828    clang-22
arm                   randconfig-003-20250827    clang-22
arm                   randconfig-003-20250828    clang-22
arm                   randconfig-004-20250827    clang-22
arm                   randconfig-004-20250828    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250827    gcc-11.5.0
arm64                 randconfig-001-20250828    clang-22
arm64                 randconfig-002-20250827    gcc-8.5.0
arm64                 randconfig-002-20250828    clang-22
arm64                 randconfig-003-20250827    clang-22
arm64                 randconfig-003-20250828    clang-22
arm64                 randconfig-004-20250827    gcc-9.5.0
arm64                 randconfig-004-20250828    clang-22
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250827    gcc-10.5.0
csky                  randconfig-001-20250828    clang-22
csky                  randconfig-002-20250827    gcc-15.1.0
csky                  randconfig-002-20250828    clang-22
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250827    clang-22
hexagon               randconfig-001-20250828    clang-22
hexagon               randconfig-002-20250827    clang-22
hexagon               randconfig-002-20250828    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250827    clang-20
i386        buildonly-randconfig-002-20250827    clang-20
i386        buildonly-randconfig-003-20250827    clang-20
i386        buildonly-randconfig-004-20250827    clang-20
i386        buildonly-randconfig-005-20250827    clang-20
i386        buildonly-randconfig-006-20250827    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250828    gcc-12
i386                  randconfig-002-20250828    gcc-12
i386                  randconfig-003-20250828    gcc-12
i386                  randconfig-004-20250828    gcc-12
i386                  randconfig-005-20250828    gcc-12
i386                  randconfig-006-20250828    gcc-12
i386                  randconfig-007-20250828    gcc-12
i386                  randconfig-011-20250828    clang-20
i386                  randconfig-012-20250828    clang-20
i386                  randconfig-013-20250828    clang-20
i386                  randconfig-014-20250828    clang-20
i386                  randconfig-015-20250828    clang-20
i386                  randconfig-016-20250828    clang-20
i386                  randconfig-017-20250828    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250827    gcc-15.1.0
loongarch             randconfig-001-20250828    clang-22
loongarch             randconfig-002-20250827    clang-22
loongarch             randconfig-002-20250828    clang-22
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
mips                           ci20_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250827    gcc-8.5.0
nios2                 randconfig-001-20250828    clang-22
nios2                 randconfig-002-20250827    gcc-11.5.0
nios2                 randconfig-002-20250828    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250827    gcc-12.5.0
parisc                randconfig-001-20250828    clang-22
parisc                randconfig-002-20250827    gcc-8.5.0
parisc                randconfig-002-20250828    clang-22
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                     mpc83xx_defconfig    clang-22
powerpc               randconfig-001-20250827    clang-22
powerpc               randconfig-001-20250828    clang-22
powerpc               randconfig-002-20250827    clang-22
powerpc               randconfig-002-20250828    clang-22
powerpc               randconfig-003-20250827    clang-22
powerpc               randconfig-003-20250828    clang-22
powerpc64             randconfig-001-20250827    gcc-11.5.0
powerpc64             randconfig-001-20250828    clang-22
powerpc64             randconfig-002-20250827    gcc-11.5.0
powerpc64             randconfig-003-20250827    gcc-13.4.0
powerpc64             randconfig-003-20250828    clang-22
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250827    clang-19
riscv                 randconfig-001-20250828    clang-19
riscv                 randconfig-002-20250827    clang-22
riscv                 randconfig-002-20250828    clang-19
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250827    gcc-13.4.0
s390                  randconfig-001-20250828    clang-19
s390                  randconfig-002-20250827    gcc-8.5.0
s390                  randconfig-002-20250828    clang-19
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250827    gcc-15.1.0
sh                    randconfig-001-20250828    clang-19
sh                    randconfig-002-20250827    gcc-9.5.0
sh                    randconfig-002-20250828    clang-19
sh                             shx3_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250827    gcc-15.1.0
sparc                 randconfig-001-20250828    clang-19
sparc                 randconfig-002-20250827    gcc-15.1.0
sparc                 randconfig-002-20250828    clang-19
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250827    gcc-11.5.0
sparc64               randconfig-001-20250828    clang-19
sparc64               randconfig-002-20250827    gcc-8.5.0
sparc64               randconfig-002-20250828    clang-19
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250827    gcc-12
um                    randconfig-001-20250828    clang-19
um                    randconfig-002-20250827    clang-22
um                    randconfig-002-20250828    clang-19
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250827    clang-20
x86_64      buildonly-randconfig-001-20250828    gcc-12
x86_64      buildonly-randconfig-002-20250827    clang-20
x86_64      buildonly-randconfig-002-20250828    gcc-12
x86_64      buildonly-randconfig-003-20250827    gcc-12
x86_64      buildonly-randconfig-003-20250828    gcc-12
x86_64      buildonly-randconfig-004-20250827    gcc-12
x86_64      buildonly-randconfig-004-20250828    gcc-12
x86_64      buildonly-randconfig-005-20250827    clang-20
x86_64      buildonly-randconfig-005-20250828    gcc-12
x86_64      buildonly-randconfig-006-20250827    clang-20
x86_64      buildonly-randconfig-006-20250828    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250828    clang-20
x86_64                randconfig-002-20250828    clang-20
x86_64                randconfig-003-20250828    clang-20
x86_64                randconfig-004-20250828    clang-20
x86_64                randconfig-005-20250828    clang-20
x86_64                randconfig-006-20250828    clang-20
x86_64                randconfig-007-20250828    clang-20
x86_64                randconfig-008-20250828    clang-20
x86_64                randconfig-071-20250828    clang-20
x86_64                randconfig-072-20250828    clang-20
x86_64                randconfig-073-20250828    clang-20
x86_64                randconfig-074-20250828    clang-20
x86_64                randconfig-075-20250828    clang-20
x86_64                randconfig-076-20250828    clang-20
x86_64                randconfig-077-20250828    clang-20
x86_64                randconfig-078-20250828    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250827    gcc-10.5.0
xtensa                randconfig-001-20250828    clang-19
xtensa                randconfig-002-20250827    gcc-10.5.0
xtensa                randconfig-002-20250828    clang-19

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


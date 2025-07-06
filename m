Return-Path: <linux-kernel+bounces-711767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B70AEFF2E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 18:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 518F916504C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 16:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B02278E41;
	Tue,  1 Jul 2025 16:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dKN7mVTZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB222798EC
	for <linux-kernel@vger.kernel.org>; Tue,  1 Jul 2025 16:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751386357; cv=none; b=YBVSZ+egbJM2b1gPg4nkIPsGCt5hDHKZJAuwZoK+LrfRDs5QTWGxpRlhFjDdn5SfaCy3sdg0ecB8XblDx1VLu6xUPdEVpNslSpLuFpiSHVvv1sXU6BgMOEZAr5aPkyOGIYfKMj+dTO9kHnv5+KHNr4miYJoD33qNr3ReGWQ6EQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751386357; c=relaxed/simple;
	bh=V9E6SwHt2cb4+m4DGVVhCy9hEzGBLvuiaeS6cKxpZWY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=i6GeMrqHZtEciHRP9DbdXn2pOwLFXxuKmYQ3guYHoB8C7zIg78wxywzd6YGIg42iaZ0gyFlyZr7fmvpMJM85AbZIv7Avjkc6OyqgD1WXfrDwdFnVaJuTYO/uA7Nsu5/3ozgtZAjNcayZqVKKy3jt6KnUdmzg31NJekRvF4oLOrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dKN7mVTZ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751386356; x=1782922356;
  h=date:from:to:cc:subject:message-id;
  bh=V9E6SwHt2cb4+m4DGVVhCy9hEzGBLvuiaeS6cKxpZWY=;
  b=dKN7mVTZSNTe/7rgdJf5821G5p/Q+LsXf9Hd1S2erpF60yGWx8OnjHWG
   ZaYwQ4Ummh2T17Qe44DPtPPiI+/knaZeJjckBQjtYwnRn5zeUsKVwTsnw
   xYTSSP5i3ni6DDVyO/COwucgm6pSnzvi2NZ2ZtJT53YV+EjIlyJv3zI1G
   ikRJkSm1SnP8fCq5jVXtAZnmFMIYbH3Ya3eS9oPX79dnQd6x1q3kQW8f9
   hd4K17OETV/+Uj9+svzSNL8AIhlXNFUsOthAakHDs0CO+D4BDigEKCB45
   aqfz40E+dHzdH5GKnjZ7hTuq8UF8FGAL0UJ7qqlnQUjQf+6pf3cvFUXGX
   Q==;
X-CSE-ConnectionGUID: rAsFIbxaSTiIza3bSjNx/A==
X-CSE-MsgGUID: 5LsWs6/rTkSi2dOnxEixqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="53766538"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="53766538"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 09:12:35 -0700
X-CSE-ConnectionGUID: rjC1R8TeSyiQF0Nlwls+5g==
X-CSE-MsgGUID: II/3gztgQsGg3EYBNR75IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="184752659"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 01 Jul 2025 09:12:33 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uWdax-000aOt-1q;
	Tue, 01 Jul 2025 16:12:31 +0000
Date: Wed, 02 Jul 2025 00:12:16 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/ptp] BUILD SUCCESS
 7b95663a3d96b39b40f169dba5faef3e20163c5c
Message-ID: <202507020006.T5QASiAq-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/ptp
branch HEAD: 7b95663a3d96b39b40f169dba5faef3e20163c5c  timekeeping: Provide interface to control auxiliary clocks

elapsed time: 1450m

configs tested: 243
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-15.1.0
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250701    gcc-13.3.0
arc                   randconfig-001-20250701    gcc-8.5.0
arc                   randconfig-002-20250701    gcc-15.1.0
arc                   randconfig-002-20250701    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-21
arm                              allyesconfig    clang-19
arm                                 defconfig    gcc-15.1.0
arm                      integrator_defconfig    gcc-15.1.0
arm                        mvebu_v7_defconfig    gcc-15.1.0
arm                   randconfig-001-20250701    clang-17
arm                   randconfig-001-20250701    gcc-8.5.0
arm                   randconfig-002-20250701    gcc-8.5.0
arm                   randconfig-003-20250701    clang-21
arm                   randconfig-003-20250701    gcc-8.5.0
arm                   randconfig-004-20250701    clang-21
arm                   randconfig-004-20250701    gcc-8.5.0
arm                           sama5_defconfig    gcc-15.1.0
arm                         vf610m4_defconfig    gcc-15.1.0
arm                         wpcm450_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250701    clang-21
arm64                 randconfig-001-20250701    gcc-8.5.0
arm64                 randconfig-002-20250701    gcc-15.1.0
arm64                 randconfig-002-20250701    gcc-8.5.0
arm64                 randconfig-003-20250701    clang-18
arm64                 randconfig-003-20250701    gcc-8.5.0
arm64                 randconfig-004-20250701    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250701    gcc-11.5.0
csky                  randconfig-001-20250701    gcc-13.3.0
csky                  randconfig-002-20250701    gcc-10.5.0
csky                  randconfig-002-20250701    gcc-13.3.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20250701    clang-21
hexagon               randconfig-001-20250701    gcc-13.3.0
hexagon               randconfig-002-20250701    clang-21
hexagon               randconfig-002-20250701    gcc-13.3.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250701    gcc-12
i386        buildonly-randconfig-002-20250701    gcc-12
i386        buildonly-randconfig-003-20250701    gcc-12
i386        buildonly-randconfig-004-20250701    gcc-12
i386        buildonly-randconfig-005-20250701    gcc-12
i386        buildonly-randconfig-006-20250701    clang-20
i386        buildonly-randconfig-006-20250701    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250701    clang-20
i386                  randconfig-002-20250701    clang-20
i386                  randconfig-003-20250701    clang-20
i386                  randconfig-004-20250701    clang-20
i386                  randconfig-005-20250701    clang-20
i386                  randconfig-006-20250701    clang-20
i386                  randconfig-007-20250701    clang-20
i386                  randconfig-011-20250701    clang-20
i386                  randconfig-012-20250701    clang-20
i386                  randconfig-013-20250701    clang-20
i386                  randconfig-014-20250701    clang-20
i386                  randconfig-015-20250701    clang-20
i386                  randconfig-016-20250701    clang-20
i386                  randconfig-017-20250701    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    gcc-15.1.0
loongarch             randconfig-001-20250701    gcc-13.3.0
loongarch             randconfig-002-20250701    gcc-13.3.0
loongarch             randconfig-002-20250701    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                         amcore_defconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                       m5275evb_defconfig    gcc-15.1.0
m68k                        m5307c3_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250701    gcc-13.3.0
nios2                 randconfig-001-20250701    gcc-14.2.0
nios2                 randconfig-002-20250701    gcc-13.3.0
openrisc                          allnoconfig    clang-21
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
openrisc                 simple_smp_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250701    gcc-13.3.0
parisc                randconfig-001-20250701    gcc-14.3.0
parisc                randconfig-002-20250701    gcc-10.5.0
parisc                randconfig-002-20250701    gcc-13.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-15.1.0
powerpc                   currituck_defconfig    gcc-15.1.0
powerpc                   motionpro_defconfig    gcc-15.1.0
powerpc                 mpc8313_rdb_defconfig    gcc-15.1.0
powerpc                 mpc8315_rdb_defconfig    gcc-15.1.0
powerpc                    mvme5100_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250701    gcc-13.3.0
powerpc               randconfig-002-20250701    clang-21
powerpc               randconfig-002-20250701    gcc-13.3.0
powerpc               randconfig-003-20250701    clang-21
powerpc               randconfig-003-20250701    gcc-13.3.0
powerpc                     sequoia_defconfig    gcc-15.1.0
powerpc                     tqm8540_defconfig    gcc-15.1.0
powerpc64                        alldefconfig    gcc-15.1.0
powerpc64             randconfig-001-20250701    clang-21
powerpc64             randconfig-001-20250701    gcc-13.3.0
powerpc64             randconfig-002-20250701    clang-21
powerpc64             randconfig-002-20250701    gcc-13.3.0
powerpc64             randconfig-003-20250701    gcc-10.5.0
powerpc64             randconfig-003-20250701    gcc-13.3.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                    nommu_virt_defconfig    gcc-15.1.0
riscv                 randconfig-001-20250701    gcc-12
riscv                 randconfig-001-20250701    gcc-14.3.0
riscv                 randconfig-002-20250701    gcc-10.5.0
riscv                 randconfig-002-20250701    gcc-12
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250701    gcc-12
s390                  randconfig-001-20250701    gcc-9.3.0
s390                  randconfig-002-20250701    clang-17
s390                  randconfig-002-20250701    gcc-12
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                        edosk7705_defconfig    gcc-15.1.0
sh                    randconfig-001-20250701    gcc-12
sh                    randconfig-001-20250701    gcc-15.1.0
sh                    randconfig-002-20250701    gcc-12
sh                    randconfig-002-20250701    gcc-13.3.0
sh                          rsk7201_defconfig    gcc-15.1.0
sh                          sdk7786_defconfig    gcc-15.1.0
sh                           se7343_defconfig    gcc-15.1.0
sh                   sh7724_generic_defconfig    gcc-15.1.0
sh                        sh7763rdp_defconfig    gcc-15.1.0
sh                  sh7785lcr_32bit_defconfig    gcc-15.1.0
sh                            titan_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250701    gcc-10.3.0
sparc                 randconfig-001-20250701    gcc-12
sparc                 randconfig-002-20250701    gcc-12
sparc                 randconfig-002-20250701    gcc-15.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250701    gcc-12
sparc64               randconfig-001-20250701    gcc-8.5.0
sparc64               randconfig-002-20250701    gcc-12
sparc64               randconfig-002-20250701    gcc-12.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250701    gcc-12
um                    randconfig-002-20250701    gcc-12
um                           x86_64_defconfig    gcc-12
um                           x86_64_defconfig    gcc-15.1.0
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250701    gcc-12
x86_64      buildonly-randconfig-002-20250701    gcc-12
x86_64      buildonly-randconfig-003-20250701    gcc-12
x86_64      buildonly-randconfig-004-20250701    gcc-12
x86_64      buildonly-randconfig-005-20250701    clang-20
x86_64      buildonly-randconfig-005-20250701    gcc-12
x86_64      buildonly-randconfig-006-20250701    clang-20
x86_64      buildonly-randconfig-006-20250701    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250701    gcc-12
x86_64                randconfig-002-20250701    gcc-12
x86_64                randconfig-003-20250701    gcc-12
x86_64                randconfig-004-20250701    gcc-12
x86_64                randconfig-005-20250701    gcc-12
x86_64                randconfig-006-20250701    gcc-12
x86_64                randconfig-007-20250701    gcc-12
x86_64                randconfig-008-20250701    gcc-12
x86_64                randconfig-071-20250701    gcc-12
x86_64                randconfig-072-20250701    gcc-12
x86_64                randconfig-073-20250701    gcc-12
x86_64                randconfig-074-20250701    gcc-12
x86_64                randconfig-075-20250701    gcc-12
x86_64                randconfig-076-20250701    gcc-12
x86_64                randconfig-077-20250701    gcc-12
x86_64                randconfig-078-20250701    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                  nommu_kc705_defconfig    gcc-15.1.0
xtensa                randconfig-001-20250701    gcc-12
xtensa                randconfig-001-20250701    gcc-15.1.0
xtensa                randconfig-002-20250701    gcc-12
xtensa                randconfig-002-20250701    gcc-13.3.0
xtensa                         virt_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


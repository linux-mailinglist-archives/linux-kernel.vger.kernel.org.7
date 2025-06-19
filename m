Return-Path: <linux-kernel+bounces-694373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B66A1AE0B85
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 18:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F14D47A7E58
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 16:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8F228C026;
	Thu, 19 Jun 2025 16:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hqh2m/Kx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A8F17D2
	for <linux-kernel@vger.kernel.org>; Thu, 19 Jun 2025 16:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750352123; cv=none; b=ughC2kOM6/gzlRY5A9cYauidC7kirogOXQWuZiZ/hy1B3JXm7EH6HUc2RHRxfShfGo7SSIeA1YWVKrdzfMJxKjSN0wp5lVZ5wljcW6TjfFGPu6XhJN2oix1gE669bvHbUOe4sGDtjidjt7M9jbtYj+vl32MgPsQDoBNizzqLius=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750352123; c=relaxed/simple;
	bh=o+Fyvg1Lb5hrrfP3c3Lji0RDDM+4QFDtJpRrO1GoVcg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Lor+MDXPKzzwKNF9MNNkrdP8E96q/BD4MzcH7Pc/3+5AwMNhLef38Yr10WQeMzmX3FU2ZwNvU+NkBgJJD1AcDXTTUM8XW0Qtc8y4Whv+iCku3xdj3zjIHeeYzVZG8hWw+r2QOx4eIy7cIqYaxP1eEGylANeio4yILrhBio+mhS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hqh2m/Kx; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750352121; x=1781888121;
  h=date:from:to:cc:subject:message-id;
  bh=o+Fyvg1Lb5hrrfP3c3Lji0RDDM+4QFDtJpRrO1GoVcg=;
  b=hqh2m/KxgLFg1SJMpD3SLrc/SPlY9hXfuh7LocN9QZC+9I7TBXN7Droo
   RJHOSSiGwfy29Arz7S0JplAbR7qP8pbiiPtdHQ+wj4VdE22apMidMatjv
   5MtEfWny3bASV/T2EqNULB24x7tqSoBA8oUINnRR4zX+3RrRNhCtzT29R
   LVkDax5s5y2BLPMhv0Tqzo2QFz7PAUc48wY8asNlwa12KJY8pBB5s83dv
   Ac5ecrHRktk01J9tSHVrTDbZpv/3AtGdctH0Zv8E4wXPlmo8ve8r4OQ58
   Jqt94iprWbUqL/3KSWaAgMTd7afb1mLjBv8hFj30CFMUxLDCtocJmdCYn
   Q==;
X-CSE-ConnectionGUID: VmDXlupMQkejnSEFw0ThXQ==
X-CSE-MsgGUID: 5bXNHRPfQDijsuTrXFX2NA==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="70047989"
X-IronPort-AV: E=Sophos;i="6.16,249,1744095600"; 
   d="scan'208";a="70047989"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 09:55:20 -0700
X-CSE-ConnectionGUID: sEE4X3xHQrK5bySI+LkPUQ==
X-CSE-MsgGUID: Q0RZjoubQNmYWb6WAxPudQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,249,1744095600"; 
   d="scan'208";a="150911622"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 19 Jun 2025 09:55:19 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uSIXk-000KxE-1U;
	Thu, 19 Jun 2025 16:55:16 +0000
Date: Fri, 20 Jun 2025 00:54:43 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/msi] BUILD SUCCESS
 4a089c0b3f55b400689a5c35f7dfa0a74c363dae
Message-ID: <202506200033.n9nGYyDE-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/msi
branch HEAD: 4a089c0b3f55b400689a5c35f7dfa0a74c363dae  PCI/MSI: Remove duplicated to_pci_dev() conversion

elapsed time: 1280m

configs tested: 235
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250619    gcc-15.1.0
arc                   randconfig-002-20250619    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-19
arm                         bcm2835_defconfig    gcc-15.1.0
arm                                 defconfig    gcc-15.1.0
arm                      jornada720_defconfig    clang-21
arm                        multi_v7_defconfig    gcc-15.1.0
arm                          pxa910_defconfig    clang-21
arm                   randconfig-001-20250619    clang-21
arm                   randconfig-001-20250619    gcc-15.1.0
arm                   randconfig-002-20250619    gcc-15.1.0
arm                   randconfig-002-20250619    gcc-8.5.0
arm                   randconfig-003-20250619    gcc-15.1.0
arm                   randconfig-003-20250619    gcc-8.5.0
arm                   randconfig-004-20250619    gcc-10.5.0
arm                   randconfig-004-20250619    gcc-15.1.0
arm                           stm32_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250619    gcc-15.1.0
arm64                 randconfig-001-20250619    gcc-8.5.0
arm64                 randconfig-002-20250619    gcc-15.1.0
arm64                 randconfig-002-20250619    gcc-9.5.0
arm64                 randconfig-003-20250619    gcc-10.5.0
arm64                 randconfig-003-20250619    gcc-15.1.0
arm64                 randconfig-004-20250619    gcc-10.5.0
arm64                 randconfig-004-20250619    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250619    gcc-11.5.0
csky                  randconfig-001-20250619    gcc-8.5.0
csky                  randconfig-002-20250619    gcc-8.5.0
csky                  randconfig-002-20250619    gcc-9.3.0
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    gcc-15.1.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20250619    clang-21
hexagon               randconfig-001-20250619    gcc-8.5.0
hexagon               randconfig-002-20250619    clang-21
hexagon               randconfig-002-20250619    gcc-8.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250619    clang-20
i386        buildonly-randconfig-001-20250619    gcc-12
i386        buildonly-randconfig-002-20250619    clang-20
i386        buildonly-randconfig-002-20250619    gcc-12
i386        buildonly-randconfig-003-20250619    clang-20
i386        buildonly-randconfig-004-20250619    clang-20
i386        buildonly-randconfig-005-20250619    clang-20
i386        buildonly-randconfig-006-20250619    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250619    gcc-12
i386                  randconfig-002-20250619    gcc-12
i386                  randconfig-003-20250619    gcc-12
i386                  randconfig-004-20250619    gcc-12
i386                  randconfig-005-20250619    gcc-12
i386                  randconfig-006-20250619    gcc-12
i386                  randconfig-007-20250619    gcc-12
i386                  randconfig-011-20250619    clang-20
i386                  randconfig-012-20250619    clang-20
i386                  randconfig-013-20250619    clang-20
i386                  randconfig-014-20250619    clang-20
i386                  randconfig-015-20250619    clang-20
i386                  randconfig-016-20250619    clang-20
i386                  randconfig-017-20250619    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    gcc-15.1.0
loongarch             randconfig-001-20250619    gcc-15.1.0
loongarch             randconfig-001-20250619    gcc-8.5.0
loongarch             randconfig-002-20250619    gcc-15.1.0
loongarch             randconfig-002-20250619    gcc-8.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                         apollo_defconfig    clang-21
m68k                                defconfig    gcc-15.1.0
m68k                       m5249evb_defconfig    clang-21
m68k                            mac_defconfig    clang-21
m68k                        mvme147_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        bcm47xx_defconfig    clang-21
mips                           ip28_defconfig    gcc-15.1.0
mips                           ip30_defconfig    clang-21
mips                           ip32_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250619    gcc-8.5.0
nios2                 randconfig-002-20250619    gcc-8.5.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250619    gcc-11.5.0
parisc                randconfig-001-20250619    gcc-8.5.0
parisc                randconfig-002-20250619    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                   currituck_defconfig    clang-21
powerpc                   currituck_defconfig    gcc-15.1.0
powerpc                       ebony_defconfig    clang-21
powerpc                      katmai_defconfig    clang-21
powerpc                     mpc5200_defconfig    clang-21
powerpc               randconfig-001-20250619    gcc-8.5.0
powerpc               randconfig-001-20250619    gcc-9.3.0
powerpc               randconfig-002-20250619    clang-21
powerpc               randconfig-002-20250619    gcc-8.5.0
powerpc               randconfig-003-20250619    gcc-10.5.0
powerpc               randconfig-003-20250619    gcc-8.5.0
powerpc                     tqm8540_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250619    gcc-11.5.0
powerpc64             randconfig-001-20250619    gcc-8.5.0
powerpc64             randconfig-002-20250619    clang-21
powerpc64             randconfig-002-20250619    gcc-8.5.0
powerpc64             randconfig-003-20250619    gcc-10.5.0
powerpc64             randconfig-003-20250619    gcc-8.5.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250619    gcc-11.5.0
riscv                 randconfig-001-20250619    gcc-9.3.0
riscv                 randconfig-002-20250619    clang-16
riscv                 randconfig-002-20250619    gcc-9.3.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250619    clang-19
s390                  randconfig-001-20250619    gcc-9.3.0
s390                  randconfig-002-20250619    gcc-13.2.0
s390                  randconfig-002-20250619    gcc-9.3.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         apsh4a3a_defconfig    clang-21
sh                                  defconfig    gcc-12
sh                     magicpanelr2_defconfig    gcc-15.1.0
sh                    randconfig-001-20250619    gcc-9.3.0
sh                    randconfig-002-20250619    gcc-9.3.0
sh                           se7206_defconfig    clang-21
sh                           se7206_defconfig    gcc-15.1.0
sh                           se7705_defconfig    clang-21
sh                   sh7724_generic_defconfig    clang-21
sh                            titan_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250619    gcc-14.3.0
sparc                 randconfig-001-20250619    gcc-9.3.0
sparc                 randconfig-002-20250619    gcc-10.3.0
sparc                 randconfig-002-20250619    gcc-9.3.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250619    gcc-13.3.0
sparc64               randconfig-001-20250619    gcc-9.3.0
sparc64               randconfig-002-20250619    gcc-8.5.0
sparc64               randconfig-002-20250619    gcc-9.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250619    clang-19
um                    randconfig-001-20250619    gcc-9.3.0
um                    randconfig-002-20250619    clang-21
um                    randconfig-002-20250619    gcc-9.3.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250619    clang-20
x86_64      buildonly-randconfig-001-20250619    gcc-12
x86_64      buildonly-randconfig-002-20250619    gcc-12
x86_64      buildonly-randconfig-003-20250619    clang-20
x86_64      buildonly-randconfig-003-20250619    gcc-12
x86_64      buildonly-randconfig-004-20250619    gcc-12
x86_64      buildonly-randconfig-005-20250619    clang-20
x86_64      buildonly-randconfig-005-20250619    gcc-12
x86_64      buildonly-randconfig-006-20250619    gcc-12
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250619    gcc-11
x86_64                randconfig-002-20250619    gcc-11
x86_64                randconfig-003-20250619    gcc-11
x86_64                randconfig-004-20250619    gcc-11
x86_64                randconfig-005-20250619    gcc-11
x86_64                randconfig-006-20250619    gcc-11
x86_64                randconfig-007-20250619    gcc-11
x86_64                randconfig-008-20250619    gcc-11
x86_64                randconfig-071-20250619    clang-20
x86_64                randconfig-072-20250619    clang-20
x86_64                randconfig-073-20250619    clang-20
x86_64                randconfig-074-20250619    clang-20
x86_64                randconfig-075-20250619    clang-20
x86_64                randconfig-076-20250619    clang-20
x86_64                randconfig-077-20250619    clang-20
x86_64                randconfig-078-20250619    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                           alldefconfig    gcc-15.1.0
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250619    gcc-9.3.0
xtensa                randconfig-002-20250619    gcc-8.5.0
xtensa                randconfig-002-20250619    gcc-9.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


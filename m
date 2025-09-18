Return-Path: <linux-kernel+bounces-822024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FDFB82E20
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 06:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 525DD620266
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 04:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4276822D9ED;
	Thu, 18 Sep 2025 04:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JvOog7tT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603B4257AC2
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 04:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758169685; cv=none; b=ktTrNvBDNYHOaLLHetqivxhBr/UTgSr50/hoXaCLEfJedHFLBZlApzLETTepBQ34HYE1Zm3qajnEXvAP1uBLqNkh8D1Ot8Rm41MhIqi0qdU4TTHNiEOW4DvhwaaxEdCG6NVAOorTlN8kp843CnnlJR+WPAeRMLMxCJL1SYyMu/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758169685; c=relaxed/simple;
	bh=A+8qLWWelwTBHJS46jkKlHZY3dBtX2j00VOTuukrVTI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Ll1E5ZxB/T6XjUmVXev7r/Mv6em9fA8N/wEZtWakK75Ct8yU24X1Pr3ow3P7QHcbt+q8lOCFmjqBHDEe5tNfrcBIRbbAHoEnnghBl5qBWXra1I4FijF4ej2M23kzZYL9iksRlO1XJAwYl07nVgkDiAXyppDojlG2XnKka4VtYx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JvOog7tT; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758169683; x=1789705683;
  h=date:from:to:cc:subject:message-id;
  bh=A+8qLWWelwTBHJS46jkKlHZY3dBtX2j00VOTuukrVTI=;
  b=JvOog7tTTJIzWWJ6/oYNavS/w3/EmM6yTuEVmAEzLO8G/IGWJX9u/0KP
   PZ84BlK+8IHT5HKZHns1EOEvJ2e9KZljhz3w+fqcEMNgEc7oylbgbjtMB
   KV+0p1NE54hHcYJAwFjZdXDuQsqZclUEHDjyMN5PpPJyxYtAOhIJEgjVZ
   lEF8+6PLGbbng4VbFEdi8m/jJH+GCdh0czSYJIpdcy8y7gpjhbFRs/MZH
   S+NrGyt+v/9o2B0tevP/oQe8b9+XyRaAwj0Jr+/figZVA2IOsjWoAG76Q
   UYaPF0R+z+W/gLOiM2F10DhZAHtdHsqzaMIDxe0IkRR3rGLcQ6uRBnhqR
   w==;
X-CSE-ConnectionGUID: HF0AQSbTQgKkHLKG2O/OXg==
X-CSE-MsgGUID: ZCYXAHS4QtqZOuoJyow4/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="83084614"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="83084614"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 21:28:02 -0700
X-CSE-ConnectionGUID: O7+wuhkMSNuyscYk7j/XTg==
X-CSE-MsgGUID: u0jYE9SpRx6se/xf+Ndntg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="175871012"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 17 Sep 2025 21:28:01 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uz6FT-0002lH-0j;
	Thu, 18 Sep 2025 04:27:59 +0000
Date: Thu, 18 Sep 2025 12:27:48 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:core/core] BUILD SUCCESS
 41e871f2b63edaf8da20907d512cd5d91ba51476
Message-ID: <202509181242.VnySSYqK-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/core
branch HEAD: 41e871f2b63edaf8da20907d512cd5d91ba51476  riscv: Use generic TIF bits

elapsed time: 1331m

configs tested: 250
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                          axs101_defconfig    clang-22
arc                      axs103_smp_defconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20250917    gcc-8.5.0
arc                   randconfig-001-20250918    clang-22
arc                   randconfig-002-20250917    gcc-15.1.0
arc                   randconfig-002-20250918    clang-22
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                        keystone_defconfig    gcc-15.1.0
arm                   milbeaut_m10v_defconfig    clang-22
arm                       netwinder_defconfig    clang-22
arm                   randconfig-001-20250917    clang-22
arm                   randconfig-001-20250918    clang-22
arm                   randconfig-002-20250917    gcc-12.5.0
arm                   randconfig-002-20250918    clang-22
arm                   randconfig-003-20250917    gcc-10.5.0
arm                   randconfig-003-20250918    clang-22
arm                   randconfig-004-20250917    clang-22
arm                   randconfig-004-20250918    clang-22
arm                         s5pv210_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250917    clang-22
arm64                 randconfig-001-20250918    clang-22
arm64                 randconfig-002-20250917    clang-19
arm64                 randconfig-002-20250918    clang-22
arm64                 randconfig-003-20250917    gcc-10.5.0
arm64                 randconfig-003-20250918    clang-22
arm64                 randconfig-004-20250917    clang-22
arm64                 randconfig-004-20250918    clang-22
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250917    gcc-12.5.0
csky                  randconfig-001-20250918    clang-22
csky                  randconfig-002-20250917    gcc-9.5.0
csky                  randconfig-002-20250918    clang-22
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250917    clang-22
hexagon               randconfig-001-20250918    clang-22
hexagon               randconfig-002-20250917    clang-22
hexagon               randconfig-002-20250918    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250917    gcc-14
i386        buildonly-randconfig-001-20250918    gcc-14
i386        buildonly-randconfig-002-20250917    clang-20
i386        buildonly-randconfig-002-20250918    gcc-14
i386        buildonly-randconfig-003-20250917    gcc-14
i386        buildonly-randconfig-003-20250918    gcc-14
i386        buildonly-randconfig-004-20250917    gcc-14
i386        buildonly-randconfig-004-20250918    gcc-14
i386        buildonly-randconfig-005-20250917    gcc-14
i386        buildonly-randconfig-005-20250918    gcc-14
i386        buildonly-randconfig-006-20250917    clang-20
i386        buildonly-randconfig-006-20250918    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20250918    gcc-14
i386                  randconfig-002-20250918    gcc-14
i386                  randconfig-003-20250918    gcc-14
i386                  randconfig-004-20250918    gcc-14
i386                  randconfig-005-20250918    gcc-14
i386                  randconfig-006-20250918    gcc-14
i386                  randconfig-007-20250918    gcc-14
i386                  randconfig-011-20250918    gcc-14
i386                  randconfig-012-20250918    gcc-14
i386                  randconfig-013-20250918    gcc-14
i386                  randconfig-014-20250918    gcc-14
i386                  randconfig-015-20250918    gcc-14
i386                  randconfig-016-20250918    gcc-14
i386                  randconfig-017-20250918    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250917    gcc-15.1.0
loongarch             randconfig-001-20250918    clang-22
loongarch             randconfig-002-20250917    gcc-15.1.0
loongarch             randconfig-002-20250918    clang-22
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                         amcore_defconfig    clang-22
m68k                          amiga_defconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           ip22_defconfig    gcc-15.1.0
mips                           ip27_defconfig    gcc-15.1.0
mips                        maltaup_defconfig    clang-22
mips                           mtx1_defconfig    clang-22
mips                        qi_lb60_defconfig    gcc-15.1.0
mips                         rt305x_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250917    gcc-11.5.0
nios2                 randconfig-001-20250918    clang-22
nios2                 randconfig-002-20250917    gcc-8.5.0
nios2                 randconfig-002-20250918    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250917    gcc-14.3.0
parisc                randconfig-001-20250918    clang-22
parisc                randconfig-002-20250917    gcc-14.3.0
parisc                randconfig-002-20250918    clang-22
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc               randconfig-001-20250917    clang-18
powerpc               randconfig-001-20250918    clang-22
powerpc               randconfig-002-20250917    clang-22
powerpc               randconfig-002-20250918    clang-22
powerpc               randconfig-003-20250917    gcc-9.5.0
powerpc               randconfig-003-20250918    clang-22
powerpc64             randconfig-001-20250917    clang-19
powerpc64             randconfig-001-20250918    clang-22
powerpc64             randconfig-002-20250917    gcc-8.5.0
powerpc64             randconfig-002-20250918    clang-22
powerpc64             randconfig-003-20250918    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20250917    gcc-14.3.0
riscv                 randconfig-001-20250918    gcc-10.5.0
riscv                 randconfig-002-20250917    clang-22
riscv                 randconfig-002-20250918    gcc-10.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20250917    clang-22
s390                  randconfig-001-20250918    gcc-10.5.0
s390                  randconfig-002-20250917    gcc-8.5.0
s390                  randconfig-002-20250918    gcc-10.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                        edosk7705_defconfig    gcc-15.1.0
sh                    randconfig-001-20250917    gcc-14.3.0
sh                    randconfig-001-20250918    gcc-10.5.0
sh                    randconfig-002-20250917    gcc-15.1.0
sh                    randconfig-002-20250918    gcc-10.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250917    gcc-8.5.0
sparc                 randconfig-001-20250918    gcc-10.5.0
sparc                 randconfig-002-20250917    gcc-14.3.0
sparc                 randconfig-002-20250918    gcc-10.5.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20250917    gcc-11.5.0
sparc64               randconfig-001-20250918    gcc-10.5.0
sparc64               randconfig-002-20250917    gcc-8.5.0
sparc64               randconfig-002-20250918    gcc-10.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250917    gcc-14
um                    randconfig-001-20250918    gcc-10.5.0
um                    randconfig-002-20250917    gcc-14
um                    randconfig-002-20250918    gcc-10.5.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250917    gcc-14
x86_64      buildonly-randconfig-001-20250918    clang-20
x86_64      buildonly-randconfig-002-20250917    clang-20
x86_64      buildonly-randconfig-002-20250918    clang-20
x86_64      buildonly-randconfig-003-20250917    clang-20
x86_64      buildonly-randconfig-003-20250918    clang-20
x86_64      buildonly-randconfig-004-20250917    clang-20
x86_64      buildonly-randconfig-004-20250918    clang-20
x86_64      buildonly-randconfig-005-20250917    clang-20
x86_64      buildonly-randconfig-005-20250918    clang-20
x86_64      buildonly-randconfig-006-20250917    gcc-12
x86_64      buildonly-randconfig-006-20250918    clang-20
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250918    gcc-12
x86_64                randconfig-002-20250918    gcc-12
x86_64                randconfig-003-20250918    gcc-12
x86_64                randconfig-004-20250918    gcc-12
x86_64                randconfig-005-20250918    gcc-12
x86_64                randconfig-006-20250918    gcc-12
x86_64                randconfig-007-20250918    gcc-12
x86_64                randconfig-008-20250918    gcc-12
x86_64                randconfig-071-20250918    clang-20
x86_64                randconfig-072-20250918    clang-20
x86_64                randconfig-073-20250918    clang-20
x86_64                randconfig-074-20250918    clang-20
x86_64                randconfig-075-20250918    clang-20
x86_64                randconfig-076-20250918    clang-20
x86_64                randconfig-077-20250918    clang-20
x86_64                randconfig-078-20250918    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250917    gcc-8.5.0
xtensa                randconfig-001-20250918    gcc-10.5.0
xtensa                randconfig-002-20250917    gcc-11.5.0
xtensa                randconfig-002-20250918    gcc-10.5.0
xtensa                    xip_kc705_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


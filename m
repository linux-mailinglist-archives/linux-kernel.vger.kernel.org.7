Return-Path: <linux-kernel+bounces-713493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B13BAF5A80
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 16:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D71F2173B9A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 14:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFB8285079;
	Wed,  2 Jul 2025 14:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XjSgflKh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB5D2857DA
	for <linux-kernel@vger.kernel.org>; Wed,  2 Jul 2025 14:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751465195; cv=none; b=I4MqZb8T57SiqMZncFluWqQX7vQvh0tVISNYo5PKD+OZ+e/yaC/NwoM5wOVrhI3MOcR2C1+XlmFLXGbCzfvY6tjBHSZKwCWXdb7FPo7iLYf9mAC8L+032EHCBcp/eP6KFJJcVjMvzo7ZxTkgHu4O7FZcIWR4mHC6/EYAlxnV1Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751465195; c=relaxed/simple;
	bh=mb63fXyaHPxUt/nbVnR007vHkGzSK3CuZfT1pJ89Pto=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Qq8x0iiQ0LwIiRbbT0vwAw/AkOBW8kz2QEB+AYl5PWWGjYLo7ZnExs9xiKbMKqHHZQq5MYUFzQBi+vwTTtD0R/jNBfdhieKQaLoY7QAMrEkjMuaReeBUL1CJWit/P4nezmq6I8112bZ37F9TwulwadcbBbVWDoQDsP9/lqxSMA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XjSgflKh; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751465194; x=1783001194;
  h=date:from:to:cc:subject:message-id;
  bh=mb63fXyaHPxUt/nbVnR007vHkGzSK3CuZfT1pJ89Pto=;
  b=XjSgflKh5SzU4W6h0TrlPVliCzTUUCgnES/4Xilzwk/cQqUbqgPa4U5c
   zFvVCEGdslOMaaygaCRr6cFvdGpzAhppbcgubUfBo+7o6/YqjaYJgvWw5
   VZDLVrq2MVnw0Hfxj+SvWe55s0cOeVZunuQPHgkTj6PnLMvcYzsB5/n5q
   re5cu8yWhI5cR5n/PEX7VsQXuJbodgebDRdK4wBjJBhCzAyNYjwRfrx1o
   OPADa4YowHt7n6y5bocpfv41/eBTuWOvhLXjrfRFiSIv5jaSzgvVnLuEd
   i8cC8+HQlSKs2WbZxXS0nCYtsYKKPXlYSMUnPCUoZNoiI6p7tdAXc3IaI
   w==;
X-CSE-ConnectionGUID: xj8B+CsMSf+n/n1G5V0IoQ==
X-CSE-MsgGUID: LE3AQterR/qZUIXtqxjF3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="76309042"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="76309042"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 07:06:22 -0700
X-CSE-ConnectionGUID: rvtsxM7LQFm5VhbNSG4F7g==
X-CSE-MsgGUID: cApoc9hTQXaWhieGJwnCoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="153539559"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 02 Jul 2025 07:06:20 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uWy6M-0000iV-1b;
	Wed, 02 Jul 2025 14:06:18 +0000
Date: Wed, 02 Jul 2025 22:05:38 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:objtool/urgent] BUILD SUCCESS
 ccdd09e0fc0d5ce6dfc8360f0c88da9a5045b6ea
Message-ID: <202507022225.IpvyRGoi-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool/urgent
branch HEAD: ccdd09e0fc0d5ce6dfc8360f0c88da9a5045b6ea  objtool: Add missing endian conversion to read_annotate()

elapsed time: 1449m

configs tested: 253
configs skipped: 8

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
arc                   randconfig-001-20250701    gcc-13.3.0
arc                   randconfig-001-20250702    clang-19
arc                   randconfig-002-20250701    gcc-15.1.0
arc                   randconfig-002-20250702    clang-19
arc                        vdk_hs38_defconfig    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-19
arm                                 defconfig    gcc-15.1.0
arm                          gemini_defconfig    gcc-15.1.0
arm                      integrator_defconfig    gcc-15.1.0
arm                        multi_v7_defconfig    gcc-15.1.0
arm                        mvebu_v7_defconfig    gcc-15.1.0
arm                          pxa3xx_defconfig    clang-18
arm                   randconfig-001-20250701    clang-17
arm                   randconfig-001-20250702    clang-19
arm                   randconfig-002-20250701    gcc-8.5.0
arm                   randconfig-002-20250702    clang-19
arm                   randconfig-003-20250701    clang-21
arm                   randconfig-003-20250702    clang-19
arm                   randconfig-004-20250701    clang-21
arm                   randconfig-004-20250702    clang-19
arm                           tegra_defconfig    clang-18
arm                           u8500_defconfig    gcc-15.1.0
arm                         vf610m4_defconfig    clang-18
arm                         wpcm450_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250701    clang-21
arm64                 randconfig-001-20250702    clang-19
arm64                 randconfig-002-20250701    gcc-15.1.0
arm64                 randconfig-002-20250702    clang-19
arm64                 randconfig-003-20250701    clang-18
arm64                 randconfig-003-20250702    clang-19
arm64                 randconfig-004-20250701    gcc-8.5.0
arm64                 randconfig-004-20250702    clang-19
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250701    gcc-11.5.0
csky                  randconfig-001-20250702    gcc-14.2.0
csky                  randconfig-002-20250701    gcc-10.5.0
csky                  randconfig-002-20250702    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-15.1.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20250701    clang-21
hexagon               randconfig-001-20250702    gcc-14.2.0
hexagon               randconfig-002-20250701    clang-21
hexagon               randconfig-002-20250702    gcc-14.2.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250701    gcc-12
i386        buildonly-randconfig-001-20250702    clang-20
i386        buildonly-randconfig-002-20250701    gcc-12
i386        buildonly-randconfig-002-20250702    clang-20
i386        buildonly-randconfig-003-20250701    gcc-12
i386        buildonly-randconfig-003-20250702    clang-20
i386        buildonly-randconfig-004-20250701    gcc-12
i386        buildonly-randconfig-004-20250702    clang-20
i386        buildonly-randconfig-005-20250701    gcc-12
i386        buildonly-randconfig-005-20250702    clang-20
i386        buildonly-randconfig-006-20250701    clang-20
i386        buildonly-randconfig-006-20250702    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250702    clang-20
i386                  randconfig-002-20250702    clang-20
i386                  randconfig-003-20250702    clang-20
i386                  randconfig-004-20250702    clang-20
i386                  randconfig-005-20250702    clang-20
i386                  randconfig-006-20250702    clang-20
i386                  randconfig-007-20250702    clang-20
i386                  randconfig-011-20250702    gcc-12
i386                  randconfig-012-20250702    gcc-12
i386                  randconfig-013-20250702    gcc-12
i386                  randconfig-014-20250702    gcc-12
i386                  randconfig-015-20250702    gcc-12
i386                  randconfig-016-20250702    gcc-12
i386                  randconfig-017-20250702    gcc-12
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    gcc-15.1.0
loongarch             randconfig-001-20250701    gcc-13.3.0
loongarch             randconfig-001-20250702    gcc-14.2.0
loongarch             randconfig-002-20250701    gcc-15.1.0
loongarch             randconfig-002-20250702    gcc-14.2.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                        m5307c3_defconfig    gcc-15.1.0
m68k                           virt_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           gcw0_defconfig    clang-18
mips                            gpr_defconfig    clang-18
mips                           ip32_defconfig    gcc-15.1.0
mips                         rt305x_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250701    gcc-14.2.0
nios2                 randconfig-001-20250702    gcc-14.2.0
nios2                 randconfig-002-20250701    gcc-13.3.0
nios2                 randconfig-002-20250702    gcc-14.2.0
openrisc                          allnoconfig    clang-21
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
openrisc                 simple_smp_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250701    gcc-14.3.0
parisc                randconfig-001-20250702    gcc-14.2.0
parisc                randconfig-002-20250701    gcc-10.5.0
parisc                randconfig-002-20250702    gcc-14.2.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-15.1.0
powerpc                      chrp32_defconfig    gcc-15.1.0
powerpc                       ebony_defconfig    gcc-15.1.0
powerpc                     mpc512x_defconfig    gcc-15.1.0
powerpc                    mvme5100_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250701    gcc-13.3.0
powerpc               randconfig-001-20250702    gcc-14.2.0
powerpc               randconfig-002-20250701    clang-21
powerpc               randconfig-002-20250702    gcc-14.2.0
powerpc               randconfig-003-20250701    clang-21
powerpc               randconfig-003-20250702    gcc-14.2.0
powerpc                     sequoia_defconfig    clang-18
powerpc                     sequoia_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250701    clang-21
powerpc64             randconfig-001-20250702    gcc-14.2.0
powerpc64             randconfig-002-20250701    clang-21
powerpc64             randconfig-002-20250702    gcc-14.2.0
powerpc64             randconfig-003-20250701    gcc-10.5.0
powerpc64             randconfig-003-20250702    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250701    gcc-14.3.0
riscv                 randconfig-001-20250702    clang-21
riscv                 randconfig-002-20250701    gcc-10.5.0
riscv                 randconfig-002-20250702    clang-21
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250701    gcc-9.3.0
s390                  randconfig-001-20250702    clang-21
s390                  randconfig-002-20250701    clang-17
s390                  randconfig-002-20250702    clang-21
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                        edosk7705_defconfig    gcc-15.1.0
sh                             espt_defconfig    clang-18
sh                             espt_defconfig    gcc-15.1.0
sh                    randconfig-001-20250701    gcc-15.1.0
sh                    randconfig-001-20250702    clang-21
sh                    randconfig-002-20250701    gcc-13.3.0
sh                    randconfig-002-20250702    clang-21
sh                           se7722_defconfig    gcc-15.1.0
sh                     sh7710voipgw_defconfig    gcc-15.1.0
sh                        sh7763rdp_defconfig    gcc-15.1.0
sh                  sh7785lcr_32bit_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250701    gcc-10.3.0
sparc                 randconfig-001-20250702    clang-21
sparc                 randconfig-002-20250701    gcc-15.1.0
sparc                 randconfig-002-20250702    clang-21
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250701    gcc-8.5.0
sparc64               randconfig-001-20250702    clang-21
sparc64               randconfig-002-20250701    gcc-12.4.0
sparc64               randconfig-002-20250702    clang-21
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250701    gcc-12
um                    randconfig-001-20250702    clang-21
um                    randconfig-002-20250701    gcc-12
um                    randconfig-002-20250702    clang-21
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250701    gcc-12
x86_64      buildonly-randconfig-001-20250702    gcc-11
x86_64      buildonly-randconfig-002-20250701    gcc-12
x86_64      buildonly-randconfig-002-20250702    gcc-11
x86_64      buildonly-randconfig-003-20250701    gcc-12
x86_64      buildonly-randconfig-003-20250702    gcc-11
x86_64      buildonly-randconfig-004-20250701    gcc-12
x86_64      buildonly-randconfig-004-20250702    gcc-11
x86_64      buildonly-randconfig-005-20250701    clang-20
x86_64      buildonly-randconfig-005-20250702    gcc-11
x86_64      buildonly-randconfig-006-20250701    clang-20
x86_64      buildonly-randconfig-006-20250702    gcc-11
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-004-20250702    gcc-12
x86_64                randconfig-005-20250702    gcc-12
x86_64                randconfig-006-20250702    gcc-12
x86_64                randconfig-007-20250702    gcc-12
x86_64                randconfig-008-20250702    gcc-12
x86_64                randconfig-071-20250702    clang-20
x86_64                randconfig-072-20250702    clang-20
x86_64                randconfig-073-20250702    clang-20
x86_64                randconfig-074-20250702    clang-20
x86_64                randconfig-075-20250702    clang-20
x86_64                randconfig-076-20250702    clang-20
x86_64                randconfig-077-20250702    clang-20
x86_64                randconfig-078-20250702    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                  cadence_csp_defconfig    gcc-15.1.0
xtensa                randconfig-001-20250701    gcc-15.1.0
xtensa                randconfig-001-20250702    clang-21
xtensa                randconfig-002-20250701    gcc-13.3.0
xtensa                randconfig-002-20250702    clang-21

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


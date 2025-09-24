Return-Path: <linux-kernel+bounces-829938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F73B9846A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 07:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7C1D2E634A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 05:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DE821FF25;
	Wed, 24 Sep 2025 05:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VRVUvZhm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C8B1946DF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 05:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758691203; cv=none; b=MEn+URtDqNfHUP+SBdUfIhlXporspigAb6WVC3I7E9FHs9MXSKeqsLpvz/dgaBo8xtoK+W2Y+Dxxm4pXyMdWeR72dRXQBLTGQ/FvvZGVuuQSIMwSkIT4o9t0bGgntADX4O8Pt/c51dwUifjcuCJ7nVssaXjX/RIt7Bm4x7uHuq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758691203; c=relaxed/simple;
	bh=IXnBS+xcWxXuXzmFKC0UlTPiOdGIuW9mGv/t12nQohg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=CELN9ZAI+DeL1ft4KRsseijVioDeKW0agFJo8E0Hv3rB3lFqtsFUA2GfxA7cApWQ0+6r8HZ3DhQMS8bWRlPFal+DkW/6B9hAeOvy/ZMTn1WXptvnfTsi5DYaViKLq2t1Ww/J1uxJ4Lp6yUjfPpT/vuYht53uhb5uf/TPaHEqu64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VRVUvZhm; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758691202; x=1790227202;
  h=date:from:to:cc:subject:message-id;
  bh=IXnBS+xcWxXuXzmFKC0UlTPiOdGIuW9mGv/t12nQohg=;
  b=VRVUvZhmjALllBaV0RHXh+yTxGUyMJnK65cClzar82HqN0mzD1rMvNrT
   /Snegm8QfuzCbavyaXlEnRXmMX6SRVkgrpWBNXhgBpkANrM8YlvfucJHl
   b5q7eVjn4eH+LVCDqJ9ZfiMnnFvkDq9sVyjXgSuOHvnbtOP3K/VTqiw1H
   xPgFQl+PGW5QkT5wVK+TQs7uOOeCvyzQXw88H70jm85n++aozKlK88i2B
   dyegZuGR4ZTW7LGgSkfRArIdVN+OOZnFVPCRki686ShrB7EXCd6lxA17P
   8h1NeJ7nY2CrSa3f3F7sU73pzPlaUGfVCRsLfFNujc/WvQpZV2Nvub4C6
   g==;
X-CSE-ConnectionGUID: NbUcaNkLTIqhlGFss6MDsw==
X-CSE-MsgGUID: z6O39KltSViiEDjvabEYjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="86422250"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="86422250"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 22:20:01 -0700
X-CSE-ConnectionGUID: ozllhFCtRPqAVBHiVVeOaQ==
X-CSE-MsgGUID: fNr/2enFT2OSzk6/5p9vdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="207689731"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 23 Sep 2025 22:20:00 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v1Hv3-0003on-1S;
	Wed, 24 Sep 2025 05:19:57 +0000
Date: Wed, 24 Sep 2025 13:19:15 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2025.09.18a] BUILD SUCCESS
 fb763a0d3223e685ecb2af4f1fa5d10e9a222d09
Message-ID: <202509241302.I3x8TWuA-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2025.09.18a
branch HEAD: fb763a0d3223e685ecb2af4f1fa5d10e9a222d09  refscale: Exercise DEFINE_STATIC_SRCU_FAST() and init_srcu_struct_fast()

elapsed time: 1323m

configs tested: 250
configs skipped: 6

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
arc                   randconfig-001-20250923    gcc-12.5.0
arc                   randconfig-001-20250924    gcc-11.5.0
arc                   randconfig-002-20250923    gcc-12.5.0
arc                   randconfig-002-20250924    gcc-11.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                            mmp2_defconfig    clang-22
arm                            mps2_defconfig    clang-22
arm                   randconfig-001-20250923    gcc-12.5.0
arm                   randconfig-001-20250924    gcc-11.5.0
arm                   randconfig-002-20250923    clang-17
arm                   randconfig-002-20250924    gcc-11.5.0
arm                   randconfig-003-20250923    gcc-8.5.0
arm                   randconfig-003-20250924    gcc-11.5.0
arm                   randconfig-004-20250923    clang-22
arm                   randconfig-004-20250924    gcc-11.5.0
arm                             rpc_defconfig    clang-22
arm                           stm32_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250923    gcc-8.5.0
arm64                 randconfig-001-20250924    gcc-11.5.0
arm64                 randconfig-002-20250923    clang-18
arm64                 randconfig-002-20250924    gcc-11.5.0
arm64                 randconfig-003-20250923    gcc-8.5.0
arm64                 randconfig-003-20250924    gcc-11.5.0
arm64                 randconfig-004-20250923    gcc-11.5.0
arm64                 randconfig-004-20250924    gcc-11.5.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250923    gcc-9.5.0
csky                  randconfig-001-20250924    clang-22
csky                  randconfig-002-20250923    gcc-15.1.0
csky                  randconfig-002-20250924    clang-22
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250923    clang-22
hexagon               randconfig-001-20250924    clang-22
hexagon               randconfig-002-20250923    clang-22
hexagon               randconfig-002-20250924    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20250923    gcc-14
i386        buildonly-randconfig-001-20250924    gcc-14
i386        buildonly-randconfig-002-20250923    clang-20
i386        buildonly-randconfig-002-20250924    gcc-14
i386        buildonly-randconfig-003-20250923    clang-20
i386        buildonly-randconfig-003-20250924    gcc-14
i386        buildonly-randconfig-004-20250923    gcc-14
i386        buildonly-randconfig-004-20250924    gcc-14
i386        buildonly-randconfig-005-20250923    clang-20
i386        buildonly-randconfig-005-20250924    gcc-14
i386        buildonly-randconfig-006-20250923    clang-20
i386        buildonly-randconfig-006-20250924    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20250924    clang-20
i386                  randconfig-002-20250924    clang-20
i386                  randconfig-003-20250924    clang-20
i386                  randconfig-004-20250924    clang-20
i386                  randconfig-005-20250924    clang-20
i386                  randconfig-006-20250924    clang-20
i386                  randconfig-007-20250924    clang-20
i386                  randconfig-011-20250924    gcc-14
i386                  randconfig-012-20250924    gcc-14
i386                  randconfig-013-20250924    gcc-14
i386                  randconfig-014-20250924    gcc-14
i386                  randconfig-015-20250924    gcc-14
i386                  randconfig-016-20250924    gcc-14
i386                  randconfig-017-20250924    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250923    gcc-15.1.0
loongarch             randconfig-001-20250924    clang-22
loongarch             randconfig-002-20250923    gcc-15.1.0
loongarch             randconfig-002-20250924    clang-22
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                        mvme147_defconfig    clang-22
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250923    gcc-11.5.0
nios2                 randconfig-001-20250924    clang-22
nios2                 randconfig-002-20250923    gcc-11.5.0
nios2                 randconfig-002-20250924    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250923    gcc-15.1.0
parisc                randconfig-001-20250924    clang-22
parisc                randconfig-002-20250923    gcc-9.5.0
parisc                randconfig-002-20250924    clang-22
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                     kmeter1_defconfig    clang-22
powerpc               randconfig-001-20250923    gcc-8.5.0
powerpc               randconfig-001-20250924    clang-22
powerpc               randconfig-002-20250923    clang-16
powerpc               randconfig-002-20250924    clang-22
powerpc               randconfig-003-20250923    gcc-12.5.0
powerpc               randconfig-003-20250924    clang-22
powerpc                      tqm8xx_defconfig    clang-22
powerpc64             randconfig-001-20250923    gcc-10.5.0
powerpc64             randconfig-001-20250924    clang-22
powerpc64             randconfig-002-20250923    clang-22
powerpc64             randconfig-002-20250924    clang-22
powerpc64             randconfig-003-20250924    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20250923    gcc-12.5.0
riscv                 randconfig-001-20250924    gcc-8.5.0
riscv                 randconfig-002-20250923    clang-22
riscv                 randconfig-002-20250924    gcc-8.5.0
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20250923    gcc-8.5.0
s390                  randconfig-001-20250924    gcc-8.5.0
s390                  randconfig-002-20250923    clang-22
s390                  randconfig-002-20250924    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20250923    gcc-15.1.0
sh                    randconfig-001-20250924    gcc-8.5.0
sh                    randconfig-002-20250923    gcc-10.5.0
sh                    randconfig-002-20250924    gcc-8.5.0
sh                           se7705_defconfig    clang-22
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250923    gcc-8.5.0
sparc                 randconfig-001-20250924    gcc-8.5.0
sparc                 randconfig-002-20250923    gcc-12.5.0
sparc                 randconfig-002-20250924    gcc-8.5.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20250923    clang-22
sparc64               randconfig-001-20250924    gcc-8.5.0
sparc64               randconfig-002-20250923    gcc-8.5.0
sparc64               randconfig-002-20250924    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250923    clang-22
um                    randconfig-001-20250924    gcc-8.5.0
um                    randconfig-002-20250923    clang-22
um                    randconfig-002-20250924    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250923    gcc-14
x86_64      buildonly-randconfig-001-20250924    clang-20
x86_64      buildonly-randconfig-002-20250923    gcc-14
x86_64      buildonly-randconfig-002-20250924    clang-20
x86_64      buildonly-randconfig-003-20250923    gcc-14
x86_64      buildonly-randconfig-003-20250924    clang-20
x86_64      buildonly-randconfig-004-20250923    clang-20
x86_64      buildonly-randconfig-004-20250924    clang-20
x86_64      buildonly-randconfig-005-20250923    clang-20
x86_64      buildonly-randconfig-005-20250924    clang-20
x86_64      buildonly-randconfig-006-20250923    clang-20
x86_64      buildonly-randconfig-006-20250924    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250924    gcc-14
x86_64                randconfig-002-20250924    gcc-14
x86_64                randconfig-003-20250924    gcc-14
x86_64                randconfig-004-20250924    gcc-14
x86_64                randconfig-005-20250924    gcc-14
x86_64                randconfig-006-20250924    gcc-14
x86_64                randconfig-007-20250924    gcc-14
x86_64                randconfig-008-20250924    gcc-14
x86_64                randconfig-071-20250924    clang-20
x86_64                randconfig-072-20250924    clang-20
x86_64                randconfig-073-20250924    clang-20
x86_64                randconfig-074-20250924    clang-20
x86_64                randconfig-075-20250924    clang-20
x86_64                randconfig-076-20250924    clang-20
x86_64                randconfig-077-20250924    clang-20
x86_64                randconfig-078-20250924    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250923    gcc-8.5.0
xtensa                randconfig-001-20250924    gcc-8.5.0
xtensa                randconfig-002-20250923    gcc-8.5.0
xtensa                randconfig-002-20250924    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-kernel+bounces-778731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0898DB2E97B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 02:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03F281CC03CC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 00:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6671C860F;
	Thu, 21 Aug 2025 00:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jeO6DENy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80E11C3BF7
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 00:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755736558; cv=none; b=mVQWx7UFv51dRhztMLW1VhC7P9TO+tPyumLe3yx8d3u+qQaANOEero/cZOEg3nHTGMErh0HO+QqjcTvgRJAchP/eiXH7LYvsrpzW4+mNF1afeaSDFwIMjIi90DQpe2AkehZZYJCs1cxRxAExq2zAws9wf5X4yYh+Svp+I5Ho1vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755736558; c=relaxed/simple;
	bh=liyjx2o2hWX1dihlQMbzdt9FlHjaSAnw1owulb5kndE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kzEA0xqQ78LeMgFrEbXEPZeRio5bV2eU0ZyXso+kEG1PxuaZTg+yMuOL4/XGSXHp0gmXTF0WBBYJz0npFHSJW5mglhuJsdF0Dg/lXGYyuCkz3J2d/ucZQZg40mnpB95nP2u1eYKh0VDktZbLEmfpMrv//ao/rWJJjzsOCG/9jWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jeO6DENy; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755736556; x=1787272556;
  h=date:from:to:cc:subject:message-id;
  bh=liyjx2o2hWX1dihlQMbzdt9FlHjaSAnw1owulb5kndE=;
  b=jeO6DENyz5l5M+SzY36S0KG9tKHIpOktbah+TILURBfENF4A/jXFcrqY
   sm3paOfXe5NxnxjGGOEuQHVM7BO3/EJNY+JVlnGPZfVuXWZYN2mD1Qas2
   dsVbTjD/aTJUCa06mq4DQff0rB+MfxUugBbUDRD/YnXyr4guH2X/AbfnE
   1zb2bnXEmHw5wY9SesG4fIOn4zbQz9A/ZzZ7UdTN4lQ/SYH9gmjv+VWY2
   MNox4sl1CsuEg3tWrLLDZSD/KTPcrZ0x2QqRxp9X5SqRicMKNC1r4OhaO
   4Qj1yF8X73QEG/eeC+DAVD729PEC3ejKfASHtSGxlSCVSckxupxg9JfqM
   Q==;
X-CSE-ConnectionGUID: MtlvLFRcRC2jsRSFsgxXMg==
X-CSE-MsgGUID: uZT7xptTQ+6Dr72VGC7D8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="83435549"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="83435549"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 17:35:55 -0700
X-CSE-ConnectionGUID: 9oFaJjMZQuqSFm7i1BJJpw==
X-CSE-MsgGUID: H/JHYH4lSzeVf4SLA0KT4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="167488842"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 20 Aug 2025 17:35:54 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uotHT-000Jlr-2Q;
	Thu, 21 Aug 2025 00:35:51 +0000
Date: Thu, 21 Aug 2025 08:35:09 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 6a42c31ef324476fb304e137fe71870fcc538c88
Message-ID: <202508210802.nOn2At62-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
branch HEAD: 6a42c31ef324476fb304e137fe71870fcc538c88  x86/cpu: Rename and move CPU model entry for Diamond Rapids

elapsed time: 1462m

configs tested: 278
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                          axs103_defconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20250820    gcc-14.3.0
arc                   randconfig-001-20250820    gcc-8.5.0
arc                   randconfig-001-20250821    clang-22
arc                   randconfig-002-20250820    gcc-11.5.0
arc                   randconfig-002-20250820    gcc-14.3.0
arc                   randconfig-002-20250821    clang-22
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                   randconfig-001-20250820    gcc-14.3.0
arm                   randconfig-001-20250820    gcc-8.5.0
arm                   randconfig-001-20250821    clang-22
arm                   randconfig-002-20250820    gcc-14.3.0
arm                   randconfig-002-20250820    gcc-15.1.0
arm                   randconfig-002-20250821    clang-22
arm                   randconfig-003-20250820    gcc-13.4.0
arm                   randconfig-003-20250820    gcc-14.3.0
arm                   randconfig-003-20250821    clang-22
arm                   randconfig-004-20250820    clang-22
arm                   randconfig-004-20250820    gcc-14.3.0
arm                   randconfig-004-20250821    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250820    gcc-14.3.0
arm64                 randconfig-001-20250821    clang-22
arm64                 randconfig-002-20250820    gcc-14.3.0
arm64                 randconfig-002-20250821    clang-22
arm64                 randconfig-003-20250820    gcc-14.3.0
arm64                 randconfig-003-20250820    gcc-8.5.0
arm64                 randconfig-003-20250821    clang-22
arm64                 randconfig-004-20250820    gcc-14.3.0
arm64                 randconfig-004-20250821    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250820    gcc-15.1.0
csky                  randconfig-001-20250821    clang-22
csky                  randconfig-002-20250820    gcc-9.5.0
csky                  randconfig-002-20250821    clang-22
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250820    clang-22
hexagon               randconfig-001-20250821    clang-22
hexagon               randconfig-002-20250820    clang-22
hexagon               randconfig-002-20250821    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250820    clang-20
i386        buildonly-randconfig-001-20250820    gcc-12
i386        buildonly-randconfig-001-20250821    gcc-12
i386        buildonly-randconfig-002-20250820    gcc-12
i386        buildonly-randconfig-002-20250821    gcc-12
i386        buildonly-randconfig-003-20250820    gcc-12
i386        buildonly-randconfig-003-20250821    gcc-12
i386        buildonly-randconfig-004-20250820    clang-20
i386        buildonly-randconfig-004-20250820    gcc-12
i386        buildonly-randconfig-004-20250821    gcc-12
i386        buildonly-randconfig-005-20250820    gcc-12
i386        buildonly-randconfig-005-20250821    gcc-12
i386        buildonly-randconfig-006-20250820    gcc-11
i386        buildonly-randconfig-006-20250820    gcc-12
i386        buildonly-randconfig-006-20250821    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250820    gcc-12
i386                  randconfig-001-20250821    gcc-11
i386                  randconfig-002-20250820    gcc-12
i386                  randconfig-002-20250821    gcc-11
i386                  randconfig-003-20250820    gcc-12
i386                  randconfig-003-20250821    gcc-11
i386                  randconfig-004-20250820    gcc-12
i386                  randconfig-004-20250821    gcc-11
i386                  randconfig-005-20250820    gcc-12
i386                  randconfig-005-20250821    gcc-11
i386                  randconfig-006-20250820    gcc-12
i386                  randconfig-006-20250821    gcc-11
i386                  randconfig-007-20250820    gcc-12
i386                  randconfig-007-20250821    gcc-11
i386                  randconfig-011-20250820    clang-20
i386                  randconfig-011-20250821    gcc-12
i386                  randconfig-012-20250820    clang-20
i386                  randconfig-012-20250821    gcc-12
i386                  randconfig-013-20250820    clang-20
i386                  randconfig-013-20250821    gcc-12
i386                  randconfig-014-20250820    clang-20
i386                  randconfig-014-20250821    gcc-12
i386                  randconfig-015-20250820    clang-20
i386                  randconfig-015-20250821    gcc-12
i386                  randconfig-016-20250820    clang-20
i386                  randconfig-016-20250821    gcc-12
i386                  randconfig-017-20250820    clang-20
i386                  randconfig-017-20250821    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250820    clang-18
loongarch             randconfig-001-20250821    clang-22
loongarch             randconfig-002-20250820    clang-22
loongarch             randconfig-002-20250821    clang-22
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                        mvme16x_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          ath25_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250820    gcc-11.5.0
nios2                 randconfig-001-20250821    clang-22
nios2                 randconfig-002-20250820    gcc-10.5.0
nios2                 randconfig-002-20250821    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250820    gcc-8.5.0
parisc                randconfig-001-20250821    clang-22
parisc                randconfig-002-20250820    gcc-13.4.0
parisc                randconfig-002-20250821    clang-22
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                      chrp32_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250820    gcc-12.5.0
powerpc               randconfig-001-20250821    clang-22
powerpc               randconfig-002-20250820    gcc-8.5.0
powerpc               randconfig-002-20250821    clang-22
powerpc               randconfig-003-20250820    gcc-13.4.0
powerpc               randconfig-003-20250821    clang-22
powerpc                  storcenter_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250820    clang-22
powerpc64             randconfig-002-20250820    clang-22
powerpc64             randconfig-002-20250821    clang-22
powerpc64             randconfig-003-20250820    gcc-15.1.0
powerpc64             randconfig-003-20250821    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250820    clang-20
riscv                 randconfig-001-20250820    clang-22
riscv                 randconfig-002-20250820    clang-22
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250820    clang-18
s390                  randconfig-001-20250820    clang-22
s390                  randconfig-002-20250820    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250820    clang-22
sh                    randconfig-001-20250820    gcc-15.1.0
sh                    randconfig-002-20250820    clang-22
sh                    randconfig-002-20250820    gcc-15.1.0
sh                          rsk7201_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250820    clang-22
sparc                 randconfig-001-20250820    gcc-8.5.0
sparc                 randconfig-002-20250820    clang-22
sparc                 randconfig-002-20250820    gcc-12.5.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250820    clang-22
sparc64               randconfig-002-20250820    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250820    clang-22
um                    randconfig-001-20250820    gcc-12
um                    randconfig-002-20250820    clang-22
um                    randconfig-002-20250820    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250820    clang-20
x86_64      buildonly-randconfig-001-20250821    clang-20
x86_64      buildonly-randconfig-002-20250820    clang-20
x86_64      buildonly-randconfig-002-20250820    gcc-11
x86_64      buildonly-randconfig-002-20250821    clang-20
x86_64      buildonly-randconfig-003-20250820    clang-20
x86_64      buildonly-randconfig-003-20250821    clang-20
x86_64      buildonly-randconfig-004-20250820    clang-20
x86_64      buildonly-randconfig-004-20250820    gcc-12
x86_64      buildonly-randconfig-004-20250821    clang-20
x86_64      buildonly-randconfig-005-20250820    clang-20
x86_64      buildonly-randconfig-005-20250821    clang-20
x86_64      buildonly-randconfig-006-20250820    clang-20
x86_64      buildonly-randconfig-006-20250820    gcc-12
x86_64      buildonly-randconfig-006-20250821    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250820    gcc-12
x86_64                randconfig-001-20250821    clang-20
x86_64                randconfig-002-20250820    gcc-12
x86_64                randconfig-002-20250821    clang-20
x86_64                randconfig-003-20250820    gcc-12
x86_64                randconfig-003-20250821    clang-20
x86_64                randconfig-004-20250820    gcc-12
x86_64                randconfig-004-20250821    clang-20
x86_64                randconfig-005-20250820    gcc-12
x86_64                randconfig-005-20250821    clang-20
x86_64                randconfig-006-20250820    gcc-12
x86_64                randconfig-006-20250821    clang-20
x86_64                randconfig-007-20250820    gcc-12
x86_64                randconfig-007-20250821    clang-20
x86_64                randconfig-008-20250820    gcc-12
x86_64                randconfig-008-20250821    clang-20
x86_64                randconfig-071-20250820    gcc-12
x86_64                randconfig-071-20250821    clang-20
x86_64                randconfig-072-20250820    gcc-12
x86_64                randconfig-072-20250821    clang-20
x86_64                randconfig-073-20250820    gcc-12
x86_64                randconfig-073-20250821    clang-20
x86_64                randconfig-074-20250820    gcc-12
x86_64                randconfig-074-20250821    clang-20
x86_64                randconfig-075-20250820    gcc-12
x86_64                randconfig-075-20250821    clang-20
x86_64                randconfig-076-20250820    gcc-12
x86_64                randconfig-076-20250821    clang-20
x86_64                randconfig-077-20250820    gcc-12
x86_64                randconfig-077-20250821    clang-20
x86_64                randconfig-078-20250820    gcc-12
x86_64                randconfig-078-20250821    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250820    clang-22
xtensa                randconfig-001-20250820    gcc-8.5.0
xtensa                randconfig-002-20250820    clang-22
xtensa                randconfig-002-20250820    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


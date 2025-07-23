Return-Path: <linux-kernel+bounces-742131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E63DB0EDA6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30AB53A90E2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E9527F75F;
	Wed, 23 Jul 2025 08:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KMzI3uRq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B3126B09F
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 08:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753260666; cv=none; b=VDOzNJmE8liT7mh8E5XDHyNmWG6hnfb462yL9V7q+h3QCMMBewrbkbLWczDXYAq0YhhWc44DjC8kbgwEmGE+G+883g6bkoTaOyAPr5hjnrdA54UVF7XLLUz1z70RfvgCp4eDOR8eOmrUBi+fE4ZYJdZGfTgrEIoXtEVwRFoR0Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753260666; c=relaxed/simple;
	bh=Wwd7+bIIoiXzswceyb4xYcsDsFbQecUkyepEG8W0ocg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fJJuzxBmPgPTbELIaTSHFfQFvPmI1K4rqq3sqCDQH3JUVUwjixltIkKVaXbS8Sb+ozKC/CdFGpl+bwyALekqwpPifcy6HLJdMVnGfjS8RtytbYDuu9Ew3zXvddonyU0FiNg1IvGF7qoO5dYnukp5YY9AA58ZwMHWEw5LEKEmXKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KMzI3uRq; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753260665; x=1784796665;
  h=date:from:to:cc:subject:message-id;
  bh=Wwd7+bIIoiXzswceyb4xYcsDsFbQecUkyepEG8W0ocg=;
  b=KMzI3uRqMYPEqD1U7Qy2VzjEugUZfySl6WNgvqyztsmxApCYTuk9+TQm
   p/UaMUVB4TrRzpORUfiqm3+7v6JYkiAzIRKU9aBftKd+FjpTjCnsmxq1q
   jLH7trCGJZVmdM1LE5fEF7VkWgpZVtST1wTdHktgZT5sth0Yn1+61UinZ
   q5uIZuoa+weoCWwW4I/k2MqfoJL9Lcdtu8pnOatD3V8qRXkBw9NSpSrYU
   QwAr44lvZwEsX+xV1yzVduVM6xWpxFmHT9vYcdFjRr3x3IRhz3ktHUkx1
   vI0Ke+yCWHSIEIIdfmtoSiEajHCRX0dDYnktwj8acMtext6I+EWbRXVSC
   w==;
X-CSE-ConnectionGUID: rmg7hwA0SHSFYvU1w5KbXA==
X-CSE-MsgGUID: mMU2PY/tS/2zFSg1DkH2AQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="59193167"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="59193167"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 01:51:04 -0700
X-CSE-ConnectionGUID: KcgeMmMZQR242eZDy9O3VQ==
X-CSE-MsgGUID: iqo6WrilRoyYi0kbQ1woUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="159481258"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 23 Jul 2025 01:51:03 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ueVBl-000J91-1E;
	Wed, 23 Jul 2025 08:51:01 +0000
Date: Wed, 23 Jul 2025 16:50:20 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/urgent] BUILD SUCCESS
 67c632b4a7fbd6b76a08b86f4950f0f84de93439
Message-ID: <202507231607.ef1xMPXs-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/urgent
branch HEAD: 67c632b4a7fbd6b76a08b86f4950f0f84de93439  timekeeping: Zero initialize system_counterval when querying time from phc drivers

elapsed time: 1156m

configs tested: 241
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
arc                   randconfig-001-20250722    gcc-10.5.0
arc                   randconfig-001-20250723    clang-16
arc                   randconfig-002-20250722    gcc-11.5.0
arc                   randconfig-002-20250723    clang-16
arm                              alldefconfig    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                   randconfig-001-20250722    gcc-12.5.0
arm                   randconfig-001-20250723    clang-16
arm                   randconfig-002-20250722    clang-22
arm                   randconfig-002-20250723    clang-16
arm                   randconfig-003-20250722    gcc-8.5.0
arm                   randconfig-003-20250723    clang-16
arm                   randconfig-004-20250722    clang-17
arm                   randconfig-004-20250723    clang-16
arm                        spear6xx_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250722    clang-22
arm64                 randconfig-001-20250723    clang-16
arm64                 randconfig-002-20250722    clang-22
arm64                 randconfig-002-20250723    clang-16
arm64                 randconfig-003-20250722    clang-22
arm64                 randconfig-003-20250723    clang-16
arm64                 randconfig-004-20250722    gcc-8.5.0
arm64                 randconfig-004-20250723    clang-16
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250723    gcc-12.5.0
csky                  randconfig-001-20250723    gcc-8.5.0
csky                  randconfig-002-20250723    gcc-14.3.0
csky                  randconfig-002-20250723    gcc-8.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250723    clang-22
hexagon               randconfig-001-20250723    gcc-8.5.0
hexagon               randconfig-002-20250723    clang-22
hexagon               randconfig-002-20250723    gcc-8.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250722    gcc-12
i386        buildonly-randconfig-001-20250723    clang-20
i386        buildonly-randconfig-002-20250722    gcc-12
i386        buildonly-randconfig-002-20250723    clang-20
i386        buildonly-randconfig-003-20250722    clang-20
i386        buildonly-randconfig-003-20250723    clang-20
i386        buildonly-randconfig-004-20250722    gcc-12
i386        buildonly-randconfig-004-20250723    clang-20
i386        buildonly-randconfig-005-20250722    clang-20
i386        buildonly-randconfig-005-20250723    clang-20
i386        buildonly-randconfig-006-20250722    clang-20
i386        buildonly-randconfig-006-20250723    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250723    clang-20
i386                  randconfig-002-20250723    clang-20
i386                  randconfig-003-20250723    clang-20
i386                  randconfig-004-20250723    clang-20
i386                  randconfig-005-20250723    clang-20
i386                  randconfig-006-20250723    clang-20
i386                  randconfig-007-20250723    clang-20
i386                  randconfig-011-20250723    clang-20
i386                  randconfig-012-20250723    clang-20
i386                  randconfig-013-20250723    clang-20
i386                  randconfig-014-20250723    clang-20
i386                  randconfig-015-20250723    clang-20
i386                  randconfig-016-20250723    clang-20
i386                  randconfig-017-20250723    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250723    gcc-15.1.0
loongarch             randconfig-001-20250723    gcc-8.5.0
loongarch             randconfig-002-20250723    clang-22
loongarch             randconfig-002-20250723    gcc-8.5.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                       bmips_be_defconfig    gcc-15.1.0
mips                           jazz_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250723    gcc-8.5.0
nios2                 randconfig-002-20250723    gcc-11.5.0
nios2                 randconfig-002-20250723    gcc-8.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250723    gcc-8.5.0
parisc                randconfig-002-20250723    gcc-15.1.0
parisc                randconfig-002-20250723    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250723    gcc-10.5.0
powerpc               randconfig-001-20250723    gcc-8.5.0
powerpc               randconfig-002-20250723    gcc-8.5.0
powerpc               randconfig-003-20250723    gcc-12.5.0
powerpc               randconfig-003-20250723    gcc-8.5.0
powerpc                     tqm8540_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250723    clang-22
powerpc64             randconfig-001-20250723    gcc-8.5.0
powerpc64             randconfig-002-20250723    clang-22
powerpc64             randconfig-002-20250723    gcc-8.5.0
powerpc64             randconfig-003-20250723    clang-22
powerpc64             randconfig-003-20250723    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250722    clang-16
riscv                 randconfig-001-20250723    gcc-9.5.0
riscv                 randconfig-002-20250722    gcc-12.5.0
riscv                 randconfig-002-20250723    gcc-9.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250722    clang-22
s390                  randconfig-001-20250723    gcc-9.5.0
s390                  randconfig-002-20250722    gcc-12.5.0
s390                  randconfig-002-20250723    gcc-9.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250722    gcc-15.1.0
sh                    randconfig-001-20250723    gcc-9.5.0
sh                    randconfig-002-20250722    gcc-15.1.0
sh                    randconfig-002-20250723    gcc-9.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250722    gcc-13.4.0
sparc                 randconfig-001-20250723    gcc-9.5.0
sparc                 randconfig-002-20250722    gcc-15.1.0
sparc                 randconfig-002-20250723    gcc-9.5.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250722    gcc-8.5.0
sparc64               randconfig-001-20250723    gcc-9.5.0
sparc64               randconfig-002-20250722    gcc-8.5.0
sparc64               randconfig-002-20250723    gcc-9.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250722    gcc-12
um                    randconfig-001-20250723    gcc-9.5.0
um                    randconfig-002-20250722    gcc-12
um                    randconfig-002-20250723    gcc-9.5.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250722    gcc-12
x86_64      buildonly-randconfig-001-20250723    gcc-11
x86_64      buildonly-randconfig-002-20250722    gcc-12
x86_64      buildonly-randconfig-002-20250723    gcc-11
x86_64      buildonly-randconfig-003-20250722    gcc-12
x86_64      buildonly-randconfig-003-20250723    gcc-11
x86_64      buildonly-randconfig-004-20250722    clang-20
x86_64      buildonly-randconfig-004-20250723    gcc-11
x86_64      buildonly-randconfig-005-20250722    gcc-12
x86_64      buildonly-randconfig-005-20250723    gcc-11
x86_64      buildonly-randconfig-006-20250722    gcc-12
x86_64      buildonly-randconfig-006-20250723    gcc-11
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250723    gcc-12
x86_64                randconfig-002-20250723    gcc-12
x86_64                randconfig-003-20250723    gcc-12
x86_64                randconfig-004-20250723    gcc-12
x86_64                randconfig-005-20250723    gcc-12
x86_64                randconfig-006-20250723    gcc-12
x86_64                randconfig-007-20250723    gcc-12
x86_64                randconfig-008-20250723    gcc-12
x86_64                randconfig-071-20250723    clang-20
x86_64                randconfig-072-20250723    clang-20
x86_64                randconfig-073-20250723    clang-20
x86_64                randconfig-074-20250723    clang-20
x86_64                randconfig-075-20250723    clang-20
x86_64                randconfig-076-20250723    clang-20
x86_64                randconfig-077-20250723    clang-20
x86_64                randconfig-078-20250723    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250722    gcc-15.1.0
xtensa                randconfig-001-20250723    gcc-9.5.0
xtensa                randconfig-002-20250722    gcc-10.5.0
xtensa                randconfig-002-20250723    gcc-9.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


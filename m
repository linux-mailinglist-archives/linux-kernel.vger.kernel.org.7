Return-Path: <linux-kernel+bounces-686186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C52AD9422
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 20:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A3CD1BC30F7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 18:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA79B2E11B3;
	Fri, 13 Jun 2025 18:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HJqmtghy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0795C2309B5
	for <linux-kernel@vger.kernel.org>; Fri, 13 Jun 2025 18:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749837854; cv=none; b=gsGHUmnX6Urn7DwmIt1cXFharoBGUXtmK/VWir3ITyO5ZA9Zkt6t9vy7VJ4P9v18dbL7v2mmQEF5gr04zRB5fpsQNXREpm/7ukEWCZK7tm0A8E8K6BQEpWta3C7SluE+Ll1h0RcKoKe5v+XVcD3V8VqslAQjeqUNSErLvn1yUfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749837854; c=relaxed/simple;
	bh=lQDr7n2NPsHYM3WSdgF6MQPGAkwvSEE5ZzFC4GXvw2Y=;
	h=Date:From:To:Cc:Subject:Message-ID; b=lUfRX+9cGGsJuK8twV0e+2n5NY2xe6nEdvDC8Gx9OQDdrqw3Sq+TM3zDDMMvTIHrjHc14ldIvwGKoXgP9rkX96g0UYw0UGyxx+g1kxjQQHaKnu3Tm5XJ+PAbRtISGi5DEdE8Uq5GxoRSQVpIpd5IiDXnZ0YPMMgSPoKCLQYpACU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HJqmtghy; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749837853; x=1781373853;
  h=date:from:to:cc:subject:message-id;
  bh=lQDr7n2NPsHYM3WSdgF6MQPGAkwvSEE5ZzFC4GXvw2Y=;
  b=HJqmtghy3gT3xZBR/FKhXSFhsS8DUo1oruEcbV6+US7KN6BfGE7ZXt5W
   m4wQKb6kxwuy9m/h2djRf0dUR86tvR/TWH6RkFGHt1r1EmCngcVpeCd47
   WmrDqHUGYLDQKeUETj/NLQVBH/yA09yGdoYEGXEzybETVLinSLOF3QfE8
   IrUwugDK+aRgxvQjkn3dfaB8k2JLRhFTXVca9QNyoGcd6NwQ3xsPqH6C+
   heY/WCnbRrIvLjEJ098WPzVWuyNscDDwah/BmtifCBqUtd31CFl98/7wL
   32g2WcG2On4YPqM/FKXnQDZaNBIs7t2kHZfZ6CkhFsxu6BvGOdAHXmPhP
   Q==;
X-CSE-ConnectionGUID: BKc1ObnYRj2dcdcTMwB5AA==
X-CSE-MsgGUID: wBgjYMT/QK+Hov2+7ZNnfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="51779614"
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="51779614"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 11:04:04 -0700
X-CSE-ConnectionGUID: Rnadgvo1TgWfQxTC0s4Vhg==
X-CSE-MsgGUID: GMR0jCk9SeiMGo5l2Zf4Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="148781453"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 13 Jun 2025 11:04:03 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uQ8ky-000Ct8-2O;
	Fri, 13 Jun 2025 18:04:00 +0000
Date: Sat, 14 Jun 2025 02:03:07 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 ff56a3e2a8613e8524f40ef2efa2c0169659e99e
Message-ID: <202506140257.y31H0Lh9-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: ff56a3e2a8613e8524f40ef2efa2c0169659e99e  timers/migration: Clean up the loop in tmigr_quick_check()

elapsed time: 1277m

configs tested: 219
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    clang-21
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250613    gcc-12.4.0
arc                   randconfig-002-20250613    gcc-12.4.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-19
arm                                 defconfig    gcc-15.1.0
arm                            mps2_defconfig    clang-21
arm                   randconfig-001-20250613    clang-21
arm                   randconfig-001-20250613    gcc-12.4.0
arm                   randconfig-002-20250613    clang-20
arm                   randconfig-002-20250613    gcc-12.4.0
arm                   randconfig-003-20250613    gcc-12.4.0
arm                   randconfig-003-20250613    gcc-8.5.0
arm                   randconfig-004-20250613    clang-21
arm                   randconfig-004-20250613    gcc-12.4.0
arm                           sunxi_defconfig    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250613    gcc-12.4.0
arm64                 randconfig-001-20250613    gcc-15.1.0
arm64                 randconfig-002-20250613    clang-21
arm64                 randconfig-002-20250613    gcc-12.4.0
arm64                 randconfig-003-20250613    clang-21
arm64                 randconfig-003-20250613    gcc-12.4.0
arm64                 randconfig-004-20250613    gcc-12.4.0
arm64                 randconfig-004-20250613    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250613    gcc-13.3.0
csky                  randconfig-001-20250613    gcc-15.1.0
csky                  randconfig-002-20250613    gcc-13.3.0
csky                  randconfig-002-20250613    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    gcc-15.1.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20250613    clang-21
hexagon               randconfig-001-20250613    gcc-13.3.0
hexagon               randconfig-002-20250613    clang-21
hexagon               randconfig-002-20250613    gcc-13.3.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250613    gcc-12
i386        buildonly-randconfig-002-20250613    gcc-11
i386        buildonly-randconfig-002-20250613    gcc-12
i386        buildonly-randconfig-003-20250613    gcc-12
i386        buildonly-randconfig-004-20250613    clang-20
i386        buildonly-randconfig-004-20250613    gcc-12
i386        buildonly-randconfig-005-20250613    clang-20
i386        buildonly-randconfig-005-20250613    gcc-12
i386        buildonly-randconfig-006-20250613    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250613    clang-20
i386                  randconfig-002-20250613    clang-20
i386                  randconfig-003-20250613    clang-20
i386                  randconfig-004-20250613    clang-20
i386                  randconfig-005-20250613    clang-20
i386                  randconfig-006-20250613    clang-20
i386                  randconfig-007-20250613    clang-20
i386                  randconfig-011-20250613    clang-20
i386                  randconfig-012-20250613    clang-20
i386                  randconfig-013-20250613    clang-20
i386                  randconfig-014-20250613    clang-20
i386                  randconfig-015-20250613    clang-20
i386                  randconfig-016-20250613    clang-20
i386                  randconfig-017-20250613    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    gcc-15.1.0
loongarch             randconfig-001-20250613    gcc-13.3.0
loongarch             randconfig-001-20250613    gcc-15.1.0
loongarch             randconfig-002-20250613    gcc-13.3.0
loongarch             randconfig-002-20250613    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                          multi_defconfig    gcc-15.1.0
m68k                          sun3x_defconfig    clang-21
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        maltaup_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250613    gcc-11.5.0
nios2                 randconfig-001-20250613    gcc-13.3.0
nios2                 randconfig-002-20250613    gcc-11.5.0
nios2                 randconfig-002-20250613    gcc-13.3.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
openrisc                       virt_defconfig    clang-21
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250613    gcc-13.3.0
parisc                randconfig-001-20250613    gcc-8.5.0
parisc                randconfig-002-20250613    gcc-13.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                      arches_defconfig    gcc-15.1.0
powerpc                        cell_defconfig    clang-21
powerpc                      chrp32_defconfig    gcc-15.1.0
powerpc                      pasemi_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250613    clang-21
powerpc               randconfig-001-20250613    gcc-13.3.0
powerpc               randconfig-002-20250613    gcc-13.3.0
powerpc               randconfig-002-20250613    gcc-8.5.0
powerpc               randconfig-003-20250613    gcc-13.3.0
powerpc               randconfig-003-20250613    gcc-9.3.0
powerpc64             randconfig-001-20250613    gcc-13.3.0
powerpc64             randconfig-001-20250613    gcc-8.5.0
powerpc64             randconfig-002-20250613    gcc-13.3.0
powerpc64             randconfig-002-20250613    gcc-8.5.0
powerpc64             randconfig-003-20250613    gcc-10.5.0
powerpc64             randconfig-003-20250613    gcc-13.3.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250613    gcc-15.1.0
riscv                 randconfig-001-20250613    gcc-8.5.0
riscv                 randconfig-002-20250613    clang-21
riscv                 randconfig-002-20250613    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250613    clang-21
s390                  randconfig-001-20250613    gcc-15.1.0
s390                  randconfig-002-20250613    clang-21
s390                  randconfig-002-20250613    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                        edosk7705_defconfig    gcc-15.1.0
sh                             espt_defconfig    clang-21
sh                    randconfig-001-20250613    gcc-15.1.0
sh                    randconfig-002-20250613    gcc-15.1.0
sh                          sdk7780_defconfig    clang-21
sh                          sdk7780_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250613    gcc-10.3.0
sparc                 randconfig-001-20250613    gcc-15.1.0
sparc                 randconfig-002-20250613    gcc-13.3.0
sparc                 randconfig-002-20250613    gcc-15.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250613    gcc-15.1.0
sparc64               randconfig-002-20250613    gcc-15.1.0
sparc64               randconfig-002-20250613    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250613    gcc-12
um                    randconfig-001-20250613    gcc-15.1.0
um                    randconfig-002-20250613    gcc-12
um                    randconfig-002-20250613    gcc-15.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250613    clang-20
x86_64      buildonly-randconfig-001-20250613    gcc-12
x86_64      buildonly-randconfig-002-20250613    gcc-12
x86_64      buildonly-randconfig-003-20250613    gcc-12
x86_64      buildonly-randconfig-004-20250613    gcc-12
x86_64      buildonly-randconfig-005-20250613    clang-20
x86_64      buildonly-randconfig-005-20250613    gcc-12
x86_64      buildonly-randconfig-006-20250613    gcc-12
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250613    gcc-12
x86_64                randconfig-002-20250613    gcc-12
x86_64                randconfig-003-20250613    gcc-12
x86_64                randconfig-004-20250613    gcc-12
x86_64                randconfig-005-20250613    gcc-12
x86_64                randconfig-006-20250613    gcc-12
x86_64                randconfig-007-20250613    gcc-12
x86_64                randconfig-008-20250613    gcc-12
x86_64                randconfig-071-20250613    gcc-12
x86_64                randconfig-072-20250613    gcc-12
x86_64                randconfig-073-20250613    gcc-12
x86_64                randconfig-074-20250613    gcc-12
x86_64                randconfig-075-20250613    gcc-12
x86_64                randconfig-076-20250613    gcc-12
x86_64                randconfig-077-20250613    gcc-12
x86_64                randconfig-078-20250613    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250613    gcc-15.1.0
xtensa                randconfig-001-20250613    gcc-8.5.0
xtensa                randconfig-002-20250613    gcc-15.1.0
xtensa                    smp_lx200_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


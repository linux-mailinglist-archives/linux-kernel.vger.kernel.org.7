Return-Path: <linux-kernel+bounces-728683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4828FB02BD4
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 18:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E8064A76BB
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 16:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8512853E0;
	Sat, 12 Jul 2025 16:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h5iaqRTc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC59717A2EB
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 16:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752336541; cv=none; b=lyWIgUO/c3jionGW4felBT71Z56Rj8XPHC/7+Lm9nuFg8BCh8PCqsmEpub0U+opHM+7bdOC9lEk8fT491DLypT5i9F98/GVlVY46ubWfID4eVDxVVry78UHhfr9baCwojcg28wNe8P11ZJRRz7eoQkU59yJYZBa6BNs59Z2VADg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752336541; c=relaxed/simple;
	bh=X4r7XqkAQIecRC3a4wERtNm7k1fTrvVJlkmFQPfOEvw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=CYHxIqrOzEZ60A+wW4L03ljKTD5iRsMVw6gQ5bWjKKBSf/OiECZwy7olC/bVv5o/J62RcpFgpM6ltUR0ZuMnRu0D4VhnlRdN3NfvTafe5iBhNy4TvD1KLNbpi7JxJgtiKT5AEvwUgUjqbgyQg/0eySa/sCepVzIEnOiexEgvgi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h5iaqRTc; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752336540; x=1783872540;
  h=date:from:to:cc:subject:message-id;
  bh=X4r7XqkAQIecRC3a4wERtNm7k1fTrvVJlkmFQPfOEvw=;
  b=h5iaqRTcMQuI/Bpbpuk00+k7VY5ckBEiVzBDWrsb0kPnu3Yhqk7doacM
   JxEkumPxiq0gNxktJTiuEmkHIS3RQb6U+xpUQqZ3z1XwJn8mpBDtELYvI
   piZ3Rrv09hex0QD8joOYLQnSP/zhekn7EVdtxyAcEWxMhrPFgn/lS3jHq
   kREytORQy4N6fVUKgEVHHdVLrBUwnfLt2lVJoluovvby4HYtJGjsYutZx
   +UhuMzm8mDaC0Vm4JoZIKNAnFC0ciAl6Kp6/tWsbcyoGTyJwvZzKF8tx8
   +cnKb+qIrAIzHpb7nDQaLq+F4s4mFjOWdYsMEvsGMkq+oG2HS+KRyhVq2
   w==;
X-CSE-ConnectionGUID: nSwqCjL9QkehloW/Zyh+mA==
X-CSE-MsgGUID: jNSv/DTvSzCYnHxSwA2OYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54731246"
X-IronPort-AV: E=Sophos;i="6.16,306,1744095600"; 
   d="scan'208";a="54731246"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2025 09:08:58 -0700
X-CSE-ConnectionGUID: E0zjN8t4RDeOSMKdQBGh5g==
X-CSE-MsgGUID: zSs+FUg3RdyJHOkzgLaxEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,306,1744095600"; 
   d="scan'208";a="160898432"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 12 Jul 2025 09:08:56 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uacmU-0007Sf-09;
	Sat, 12 Jul 2025 16:08:54 +0000
Date: Sun, 13 Jul 2025 00:08:48 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:tip/urgent] BUILD SUCCESS
 858d409dbf619b16091151e13445e1300671675a
Message-ID: <202507130036.gRrrdaeq-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tip/urgent
branch HEAD: 858d409dbf619b16091151e13445e1300671675a  Merge x86/urgent into tip/urgent

elapsed time: 1303m

configs tested: 216
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-21
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-21
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20250712    gcc-10.5.0
arc                   randconfig-001-20250712    gcc-13.4.0
arc                   randconfig-002-20250712    gcc-13.4.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                                 defconfig    clang-19
arm                          ixp4xx_defconfig    gcc-15.1.0
arm                         mv78xx0_defconfig    gcc-15.1.0
arm                   randconfig-001-20250712    gcc-13.4.0
arm                   randconfig-001-20250712    gcc-8.5.0
arm                   randconfig-002-20250712    gcc-10.5.0
arm                   randconfig-002-20250712    gcc-13.4.0
arm                   randconfig-003-20250712    clang-21
arm                   randconfig-003-20250712    gcc-13.4.0
arm                   randconfig-004-20250712    clang-21
arm                   randconfig-004-20250712    gcc-13.4.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-21
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250712    gcc-12.3.0
arm64                 randconfig-001-20250712    gcc-13.4.0
arm64                 randconfig-002-20250712    gcc-12.3.0
arm64                 randconfig-002-20250712    gcc-13.4.0
arm64                 randconfig-003-20250712    gcc-13.4.0
arm64                 randconfig-003-20250712    gcc-8.5.0
arm64                 randconfig-004-20250712    gcc-13.4.0
csky                              allnoconfig    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250712    gcc-11.5.0
csky                  randconfig-001-20250712    gcc-14.3.0
csky                  randconfig-002-20250712    gcc-11.5.0
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250712    clang-21
hexagon               randconfig-001-20250712    gcc-11.5.0
hexagon               randconfig-002-20250712    clang-18
hexagon               randconfig-002-20250712    gcc-11.5.0
i386                             alldefconfig    gcc-15.1.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250712    clang-20
i386        buildonly-randconfig-001-20250712    gcc-12
i386        buildonly-randconfig-002-20250712    gcc-11
i386        buildonly-randconfig-002-20250712    gcc-12
i386        buildonly-randconfig-003-20250712    gcc-12
i386        buildonly-randconfig-004-20250712    gcc-12
i386        buildonly-randconfig-005-20250712    gcc-12
i386        buildonly-randconfig-006-20250712    clang-20
i386        buildonly-randconfig-006-20250712    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250712    gcc-12
i386                  randconfig-002-20250712    gcc-12
i386                  randconfig-003-20250712    gcc-12
i386                  randconfig-004-20250712    gcc-12
i386                  randconfig-005-20250712    gcc-12
i386                  randconfig-006-20250712    gcc-12
i386                  randconfig-007-20250712    gcc-12
i386                  randconfig-011-20250712    gcc-12
i386                  randconfig-012-20250712    gcc-12
i386                  randconfig-013-20250712    gcc-12
i386                  randconfig-014-20250712    gcc-12
i386                  randconfig-015-20250712    gcc-12
i386                  randconfig-016-20250712    gcc-12
i386                  randconfig-017-20250712    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250712    gcc-11.5.0
loongarch             randconfig-001-20250712    gcc-15.1.0
loongarch             randconfig-002-20250712    gcc-11.5.0
loongarch             randconfig-002-20250712    gcc-14.3.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                        stmark2_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250712    gcc-11.5.0
nios2                 randconfig-002-20250712    gcc-11.5.0
nios2                 randconfig-002-20250712    gcc-8.5.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250712    gcc-11.5.0
parisc                randconfig-001-20250712    gcc-8.5.0
parisc                randconfig-002-20250712    gcc-11.5.0
parisc                randconfig-002-20250712    gcc-12.4.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc               randconfig-001-20250712    gcc-11.5.0
powerpc               randconfig-001-20250712    gcc-15.1.0
powerpc               randconfig-002-20250712    gcc-11.5.0
powerpc               randconfig-002-20250712    gcc-8.5.0
powerpc               randconfig-003-20250712    clang-21
powerpc               randconfig-003-20250712    gcc-11.5.0
powerpc64             randconfig-002-20250712    clang-21
powerpc64             randconfig-002-20250712    gcc-11.5.0
powerpc64             randconfig-003-20250712    clang-19
powerpc64             randconfig-003-20250712    gcc-11.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250712    gcc-8.5.0
riscv                 randconfig-002-20250712    clang-21
riscv                 randconfig-002-20250712    gcc-8.5.0
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250712    clang-21
s390                  randconfig-001-20250712    gcc-8.5.0
s390                  randconfig-002-20250712    clang-21
s390                  randconfig-002-20250712    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                        apsh4ad0a_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250712    gcc-15.1.0
sh                    randconfig-001-20250712    gcc-8.5.0
sh                    randconfig-002-20250712    gcc-14.3.0
sh                    randconfig-002-20250712    gcc-8.5.0
sh                   rts7751r2dplus_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250712    gcc-13.4.0
sparc                 randconfig-001-20250712    gcc-8.5.0
sparc                 randconfig-002-20250712    gcc-15.1.0
sparc                 randconfig-002-20250712    gcc-8.5.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250712    clang-20
sparc64               randconfig-001-20250712    gcc-8.5.0
sparc64               randconfig-002-20250712    gcc-14.3.0
sparc64               randconfig-002-20250712    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250712    gcc-12
um                    randconfig-001-20250712    gcc-8.5.0
um                    randconfig-002-20250712    clang-21
um                    randconfig-002-20250712    gcc-8.5.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250712    gcc-12
x86_64      buildonly-randconfig-002-20250712    gcc-12
x86_64      buildonly-randconfig-003-20250712    clang-20
x86_64      buildonly-randconfig-003-20250712    gcc-12
x86_64      buildonly-randconfig-004-20250712    clang-20
x86_64      buildonly-randconfig-004-20250712    gcc-12
x86_64      buildonly-randconfig-005-20250712    gcc-12
x86_64      buildonly-randconfig-006-20250712    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250712    clang-20
x86_64                randconfig-002-20250712    clang-20
x86_64                randconfig-003-20250712    clang-20
x86_64                randconfig-004-20250712    clang-20
x86_64                randconfig-005-20250712    clang-20
x86_64                randconfig-006-20250712    clang-20
x86_64                randconfig-007-20250712    clang-20
x86_64                randconfig-008-20250712    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250712    gcc-8.5.0
xtensa                randconfig-002-20250712    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


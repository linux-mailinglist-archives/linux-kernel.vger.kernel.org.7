Return-Path: <linux-kernel+bounces-882054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CB684C29826
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 23:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 13AA04E4903
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 22:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B564922422B;
	Sun,  2 Nov 2025 22:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RPI+tfWn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE569460
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 22:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762121378; cv=none; b=nO6qHi/u7pDBQrPl19soV9gZm8Aa38SPNMgO57d4QB5TfhfH7MrxkE49BRkZp4flRaeae31UvzNScG6VR/5WIsEpXpXxOLWlnNoWB2Gr+oobNEsa6Z+PZRolLv7f5LAb8ruyf1LjZ4so3Y7YH5c641zBYR8wr4vrpMEJ6FmZY7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762121378; c=relaxed/simple;
	bh=VRXKvAc/7VkryHC/dbBsQDtrMKs/D7KAKeakXR2ReU0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Hxa1a+lk9wwGTn0aZ0rhcQE/t4Atm5XFUoAAn3cinqi8PQZUmmPO6w4D5ipBShk5DxxnY6acklfl9pEXZPqD+gxmBg41/zznVm5wEcR4hDUSbw+M1QvM3gRbqfaQklc5DnPVMNxZJRyZo8xLvV7KqMpuswBsvJ1Ytn7M3+uvXz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RPI+tfWn; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762121377; x=1793657377;
  h=date:from:to:cc:subject:message-id;
  bh=VRXKvAc/7VkryHC/dbBsQDtrMKs/D7KAKeakXR2ReU0=;
  b=RPI+tfWnJ8ZJg7h6wm2+4RBUxWTwxw7H5ZWHQ5ZWHSxfYlih7jOGTIdD
   8D0gNAjhiX/8jPiEg2pGW5fdHkdxplZanPaRCdFgjUCZtJ4WjvMazrd//
   iYuvnkguH3cYRMcbvgoHxM4uQnUB4BnjbpMWOcfPCyk+a+lBT38shdt+a
   01CTjYqz64Ui/hv/vnDSU1sxXnQtfjvUJZPXTpq89379Vzi4X88y0Vseb
   wXHNRUweKvNMkvf81PG8cfk4ZO5ZJVHF4Uc8LW+KmdaK3rPf6ImfZGwsp
   VuBHf0qeMFoZVf3UiTw6DC2Rom0ImcrzgQ6FiduSCVL4z9ufXy6WSExD8
   g==;
X-CSE-ConnectionGUID: ZVfgK/mTSGmBwO+V1/8buw==
X-CSE-MsgGUID: ay7Ivx4JQiuQ1W81M8qumg==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="64239715"
X-IronPort-AV: E=Sophos;i="6.19,274,1754982000"; 
   d="scan'208";a="64239715"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2025 14:09:37 -0800
X-CSE-ConnectionGUID: xXIsjRvjRNGlAhIoIM4GHA==
X-CSE-MsgGUID: qm7s1n8aRGa3bqMHjQlsBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,274,1754982000"; 
   d="scan'208";a="190801258"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 02 Nov 2025 14:09:34 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vFgGS-000Pbb-24;
	Sun, 02 Nov 2025 22:09:32 +0000
Date: Mon, 03 Nov 2025 06:09:19 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2025.10.31a] BUILD SUCCESS
 44c59cb7d5c41cafd3e46b7d538db0530aef2324
Message-ID: <202511030612.C3blTaGt-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2025.10.31a
branch HEAD: 44c59cb7d5c41cafd3e46b7d538db0530aef2324  fixup! rcutorture: Make srcu{,d}_torture_init() announce the SRCU type

elapsed time: 1064m

configs tested: 179
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                   randconfig-001-20251102    gcc-14.3.0
arc                   randconfig-001-20251102    gcc-8.5.0
arc                   randconfig-002-20251102    gcc-14.3.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                   randconfig-001-20251102    gcc-14.3.0
arm                   randconfig-001-20251102    gcc-15.1.0
arm                   randconfig-002-20251102    gcc-10.5.0
arm                   randconfig-002-20251102    gcc-14.3.0
arm                   randconfig-003-20251102    gcc-14.3.0
arm                   randconfig-003-20251102    gcc-8.5.0
arm                   randconfig-004-20251102    gcc-14.3.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                            allyesconfig    gcc-15.1.0
arm64                 randconfig-001-20251102    gcc-12.5.0
arm64                 randconfig-002-20251102    gcc-12.5.0
arm64                 randconfig-003-20251102    gcc-12.5.0
arm64                 randconfig-004-20251102    gcc-12.5.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                  randconfig-001-20251102    gcc-12.5.0
csky                  randconfig-002-20251102    gcc-12.5.0
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon               randconfig-001-20251102    clang-22
hexagon               randconfig-001-20251102    gcc-15.1.0
hexagon               randconfig-002-20251102    clang-22
hexagon               randconfig-002-20251102    gcc-15.1.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20251102    gcc-14
i386        buildonly-randconfig-002-20251102    gcc-14
i386        buildonly-randconfig-003-20251102    gcc-14
i386        buildonly-randconfig-004-20251102    gcc-14
i386        buildonly-randconfig-005-20251102    gcc-14
i386        buildonly-randconfig-006-20251102    gcc-14
i386                  randconfig-001-20251102    clang-20
i386                  randconfig-002-20251102    clang-20
i386                  randconfig-003-20251102    clang-20
i386                  randconfig-004-20251102    clang-20
i386                  randconfig-005-20251102    clang-20
i386                  randconfig-006-20251102    clang-20
i386                  randconfig-007-20251102    clang-20
i386                  randconfig-011-20251102    clang-20
i386                  randconfig-012-20251102    clang-20
i386                  randconfig-013-20251102    clang-20
i386                  randconfig-014-20251102    clang-20
i386                  randconfig-015-20251102    clang-20
i386                  randconfig-016-20251102    clang-20
i386                  randconfig-017-20251102    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                        allyesconfig    gcc-15.1.0
loongarch             randconfig-001-20251102    gcc-15.1.0
loongarch             randconfig-002-20251102    gcc-15.1.0
m68k                             allmodconfig    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                            allyesconfig    clang-22
nios2                 randconfig-001-20251102    gcc-11.5.0
nios2                 randconfig-001-20251102    gcc-15.1.0
nios2                 randconfig-002-20251102    gcc-11.5.0
nios2                 randconfig-002-20251102    gcc-15.1.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                randconfig-001-20251102    gcc-8.5.0
parisc                randconfig-002-20251102    gcc-14.3.0
parisc                randconfig-002-20251102    gcc-8.5.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc               randconfig-001-20251102    gcc-8.5.0
powerpc               randconfig-001-20251102    gcc-9.5.0
powerpc               randconfig-002-20251102    clang-18
powerpc               randconfig-002-20251102    gcc-8.5.0
powerpc64             randconfig-001-20251102    gcc-14.3.0
powerpc64             randconfig-001-20251102    gcc-8.5.0
powerpc64             randconfig-002-20251102    gcc-8.5.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                 randconfig-001-20251102    gcc-13.4.0
riscv                 randconfig-002-20251102    gcc-14.3.0
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-002-20251102    gcc-11.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20251102    gcc-13.4.0
sh                    randconfig-002-20251102    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                            allyesconfig    clang-22
sparc                 randconfig-001-20251102    clang-22
sparc                 randconfig-002-20251102    clang-22
sparc64                          allmodconfig    clang-22
sparc64                          allyesconfig    clang-22
sparc64               randconfig-001-20251102    clang-22
sparc64               randconfig-002-20251102    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                    randconfig-001-20251102    clang-22
um                    randconfig-002-20251102    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251102    clang-20
x86_64      buildonly-randconfig-002-20251102    clang-20
x86_64      buildonly-randconfig-003-20251102    clang-20
x86_64      buildonly-randconfig-004-20251102    clang-20
x86_64      buildonly-randconfig-005-20251102    clang-20
x86_64      buildonly-randconfig-006-20251102    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251102    gcc-14
x86_64                randconfig-001-20251103    clang-20
x86_64                randconfig-002-20251102    gcc-14
x86_64                randconfig-002-20251103    clang-20
x86_64                randconfig-003-20251102    gcc-14
x86_64                randconfig-003-20251103    clang-20
x86_64                randconfig-004-20251102    gcc-14
x86_64                randconfig-004-20251103    clang-20
x86_64                randconfig-005-20251102    gcc-14
x86_64                randconfig-005-20251103    clang-20
x86_64                randconfig-006-20251102    gcc-14
x86_64                randconfig-006-20251103    clang-20
x86_64                randconfig-011-20251102    gcc-14
x86_64                randconfig-012-20251102    gcc-14
x86_64                randconfig-013-20251102    gcc-14
x86_64                randconfig-014-20251102    gcc-14
x86_64                randconfig-015-20251102    gcc-14
x86_64                randconfig-016-20251102    gcc-14
x86_64                randconfig-071-20251102    gcc-14
x86_64                randconfig-071-20251103    gcc-14
x86_64                randconfig-072-20251102    gcc-14
x86_64                randconfig-072-20251103    gcc-14
x86_64                randconfig-073-20251102    gcc-14
x86_64                randconfig-073-20251103    gcc-14
x86_64                randconfig-074-20251102    gcc-14
x86_64                randconfig-074-20251103    gcc-14
x86_64                randconfig-075-20251102    gcc-14
x86_64                randconfig-075-20251103    gcc-14
x86_64                randconfig-076-20251102    gcc-14
x86_64                randconfig-076-20251103    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20251102    clang-22
xtensa                randconfig-002-20251102    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


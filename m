Return-Path: <linux-kernel+bounces-737852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A07B0B142
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 20:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98D6AAA64AB
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 18:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE21D155725;
	Sat, 19 Jul 2025 18:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bvz8DRuG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FD79476
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 18:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752948590; cv=none; b=fxG6nk/pmYNyxcHH5Suy8EPuImhePpSf72CAoB0me+X9dDtCZ/98OnNmj7aFgDQdGuLl191O5wN4AKam8VgR6O+pFseYdQUmnZiNBMrdYHYU+8OG4NMspZi2bxl3E/eAGJ8AjB6fkz4yoKTCc7na+rBDd9Ha4EUn74cCgYnmE14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752948590; c=relaxed/simple;
	bh=jL+ZPZfLJ164ENn0W0XfbA44zB9nfw6C8JjNQlrp92I=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MaRsoqNtJ8Zz+EcsjGuKD0ny+1RFPJW0gZBCDZ3EWsE0GJvSRf6m5ddDloYk1K/UGE5wAsXOZ27KAiCrGhGTjrm6YNinD/XzzBHo7ygomjLs/L4oU0Ca/nj1PorVTm23xrXV/THgSoe60tjISdw8R0iop73Um4WreAm4m84QLi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bvz8DRuG; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752948589; x=1784484589;
  h=date:from:to:cc:subject:message-id;
  bh=jL+ZPZfLJ164ENn0W0XfbA44zB9nfw6C8JjNQlrp92I=;
  b=Bvz8DRuGYaC2MLJ2utkZ/PJVRpcbzxe+Ptqb5nGKCjiknpxkSAWcB4GO
   Nxh8CbUZk2yM74OLOA7ia+yV9rPzzdTCb4LSXQsYNzsryxE3H87tfbrHz
   avxdK8kDjFy0FkyYHvV+9rynsWzaT2HZxFZ5Jx2FoOFkwZiqS9tTOqcRj
   tQa1bqdnw+CQiCuA3xHFT720svOMOqCRzbSRrNW0R9144ey3sCdmZ8K9p
   14FjqYol12gvD3MCGmhAHhoOMDT9L/+zeBCAr6qElrRgBTkRKGVjZLrY8
   VwP/6iYL+y+UJxDJjEJrMsorfOzH7lVRJvnEdBU53bXi3r/k2jEUrgF46
   A==;
X-CSE-ConnectionGUID: 07MNscz9QvSLsSiMEs7gfQ==
X-CSE-MsgGUID: ItoGnRRgTSiYHigH0UOMig==
X-IronPort-AV: E=McAfee;i="6800,10657,11497"; a="55096493"
X-IronPort-AV: E=Sophos;i="6.16,324,1744095600"; 
   d="scan'208";a="55096493"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2025 11:09:48 -0700
X-CSE-ConnectionGUID: u3JW6ur5QB2QOeAL5AC+sw==
X-CSE-MsgGUID: 6PVC+03LQWKXXkEMC4Qc3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,324,1744095600"; 
   d="scan'208";a="164119211"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 19 Jul 2025 11:09:48 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1udC0G-000FhH-39;
	Sat, 19 Jul 2025 18:09:44 +0000
Date: Sun, 20 Jul 2025 02:09:02 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:non-rcu/next] BUILD SUCCESS
 b706eec9304fc3cbc48a6a09aff8533081815ebc
Message-ID: <202507200250.5rM1IdpC-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git non-rcu/next
branch HEAD: b706eec9304fc3cbc48a6a09aff8533081815ebc  Merge branches 'lkmm.2025.07.09a', 'ratelimit.2025.06.24a' and 'stop-machine.2025.07.17a' into HEAD

elapsed time: 1443m

configs tested: 105
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                        nsimosci_defconfig    gcc-15.1.0
arc                   randconfig-001-20250719    gcc-14.3.0
arc                   randconfig-002-20250719    gcc-15.1.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250719    gcc-14.3.0
arm                   randconfig-002-20250719    clang-21
arm                   randconfig-003-20250719    clang-21
arm                   randconfig-004-20250719    clang-16
arm                           sama5_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250719    clang-20
arm64                 randconfig-002-20250719    clang-18
arm64                 randconfig-003-20250719    gcc-15.1.0
arm64                 randconfig-004-20250719    clang-20
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250719    gcc-15.1.0
csky                  randconfig-002-20250719    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250719    clang-21
hexagon               randconfig-002-20250719    clang-21
i386        buildonly-randconfig-001-20250719    clang-20
i386        buildonly-randconfig-002-20250719    gcc-12
i386        buildonly-randconfig-003-20250719    gcc-12
i386        buildonly-randconfig-004-20250719    clang-20
i386        buildonly-randconfig-005-20250719    clang-20
i386        buildonly-randconfig-006-20250719    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch             randconfig-001-20250719    clang-18
loongarch             randconfig-002-20250719    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250719    gcc-11.5.0
nios2                 randconfig-002-20250719    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250719    gcc-8.5.0
parisc                randconfig-002-20250719    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                      arches_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250719    clang-19
powerpc               randconfig-002-20250719    gcc-10.5.0
powerpc               randconfig-003-20250719    gcc-12.5.0
powerpc64             randconfig-001-20250719    gcc-8.5.0
powerpc64             randconfig-002-20250719    clang-21
powerpc64             randconfig-003-20250719    gcc-10.5.0
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250719    clang-21
riscv                 randconfig-002-20250719    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250719    gcc-9.5.0
s390                  randconfig-002-20250719    gcc-9.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250719    gcc-13.4.0
sh                    randconfig-002-20250719    gcc-15.1.0
sh                           se7705_defconfig    gcc-15.1.0
sh                           se7724_defconfig    gcc-15.1.0
sh                             sh03_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250719    gcc-15.1.0
sparc                 randconfig-002-20250719    gcc-15.1.0
sparc64               randconfig-001-20250719    gcc-9.5.0
sparc64               randconfig-002-20250719    gcc-9.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250719    clang-16
um                    randconfig-002-20250719    clang-21
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20250719    clang-20
x86_64      buildonly-randconfig-002-20250719    clang-20
x86_64      buildonly-randconfig-003-20250719    clang-20
x86_64      buildonly-randconfig-004-20250719    gcc-12
x86_64      buildonly-randconfig-005-20250719    clang-20
x86_64      buildonly-randconfig-006-20250719    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250719    gcc-14.3.0
xtensa                randconfig-002-20250719    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


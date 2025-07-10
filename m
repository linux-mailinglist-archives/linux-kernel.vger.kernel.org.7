Return-Path: <linux-kernel+bounces-725044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D4AAFFA2D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D28BF7B0A28
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 06:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F732877E0;
	Thu, 10 Jul 2025 06:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a+McIPKx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEE1280A29
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 06:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752130288; cv=none; b=g2HEz3saewP/K5cEw7hnGGPQhc4saoIyrC6Q1urCHUH3J8jfvM/weDJcLtBo4rsSoN5uKHrv3y9WS0HVBbKaCw2WTnmTsWsJBPSU+0uKklgQyplIgLQjWc8acVmWQlazC5Mx7w4GeboUAjp79+kKNEzTTMaGZyjiQvsHNgj+QE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752130288; c=relaxed/simple;
	bh=AMa7lwkXMN2Ako2tIZIroNSipdngCsnbMYhwETe8I9Y=;
	h=Date:From:To:Cc:Subject:Message-ID; b=N1ceBS7g9yxCB+b+BSb4QEWg5DLCVTgF3+wBLZV6m4Dx8NsGw4R2TXvkpAKEu6fss2BrDAjNo9SPrHdFqxdZ20lAVyJNXX3AN73cR1SCTTzpDmQbhZboSeAf+/cwdfZSYvhuo4RHeepb0LDzg4px28aFb6MOeG6di+FF88VevXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a+McIPKx; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752130286; x=1783666286;
  h=date:from:to:cc:subject:message-id;
  bh=AMa7lwkXMN2Ako2tIZIroNSipdngCsnbMYhwETe8I9Y=;
  b=a+McIPKxnitw04XK0cnasyvfh/SdodzU6jFTxujnGTWWwvitdx+i3xr2
   Apq5F7upqEr5YB5ub4HmnbolSu/PqGONl0UNUl5lfWJY9DEABHTtmFcCc
   xFv2yLgUtE/8W+eMIjTNR1oIY20H2XYMO3B4FoGOG1h9ZlAboZsQJuNe6
   hwmaSoS/xaEoNMOJNB2hkd4tAysGXCbmpRN3VsH6Gf6UPqfXvUBNcyRqs
   yzjaPI+7EzuLp/JUjDIhnTp7JBvtZZPl80xfUquj3RXsSJPjWstNF2c69
   +8VPtMfA3evnrzCxTlYpjP1+4tOJtx7EZHu1trxd4l+wowPjZXgqt+Ykl
   A==;
X-CSE-ConnectionGUID: y1+LNILkRi6Dt5tzyFL78Q==
X-CSE-MsgGUID: dJv7v+51Tw2drdGLDmFyRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="57009671"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="57009671"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 23:51:25 -0700
X-CSE-ConnectionGUID: zaMH/uHoTQqazIJ1wIhwwA==
X-CSE-MsgGUID: LGrhkrLZQMmeTiA3HGpIqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="193192305"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 09 Jul 2025 23:51:24 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uZl7p-0004bb-1s;
	Thu, 10 Jul 2025 06:51:21 +0000
Date: Thu, 10 Jul 2025 14:51:06 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:non-rcu/next] BUILD SUCCESS
 125b9ae972197fa6ecc789b847427f6ad1156e52
Message-ID: <202507101454.4cCfBA3L-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git non-rcu/next
branch HEAD: 125b9ae972197fa6ecc789b847427f6ad1156e52  Merge branches 'lkmm.2025.07.09a' and 'ratelimit.2025.06.24a' into HEAD

elapsed time: 780m

configs tested: 201
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-21
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-21
arc                              allyesconfig    clang-19
arc                                 defconfig    clang-19
arc                   randconfig-001-20250710    clang-21
arc                   randconfig-001-20250710    gcc-15.1.0
arc                   randconfig-002-20250710    clang-21
arc                   randconfig-002-20250710    gcc-12.4.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-21
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                   randconfig-001-20250710    clang-21
arm                   randconfig-001-20250710    gcc-8.5.0
arm                   randconfig-002-20250710    clang-21
arm                   randconfig-003-20250710    clang-21
arm                   randconfig-004-20250710    clang-21
arm                   randconfig-004-20250710    gcc-8.5.0
arm                           spitz_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-21
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250710    clang-21
arm64                 randconfig-002-20250710    clang-21
arm64                 randconfig-003-20250710    clang-21
arm64                 randconfig-003-20250710    gcc-8.5.0
arm64                 randconfig-004-20250710    clang-21
csky                              allnoconfig    clang-21
csky                                defconfig    clang-19
csky                  randconfig-001-20250710    gcc-15.1.0
csky                  randconfig-002-20250710    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250710    clang-21
hexagon               randconfig-001-20250710    gcc-15.1.0
hexagon               randconfig-002-20250710    clang-21
hexagon               randconfig-002-20250710    gcc-15.1.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250710    clang-20
i386        buildonly-randconfig-001-20250710    gcc-12
i386        buildonly-randconfig-002-20250710    clang-20
i386        buildonly-randconfig-002-20250710    gcc-12
i386        buildonly-randconfig-003-20250710    clang-20
i386        buildonly-randconfig-004-20250710    clang-20
i386        buildonly-randconfig-004-20250710    gcc-11
i386        buildonly-randconfig-005-20250710    clang-20
i386        buildonly-randconfig-006-20250710    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250710    gcc-12
i386                  randconfig-002-20250710    gcc-12
i386                  randconfig-003-20250710    gcc-12
i386                  randconfig-004-20250710    gcc-12
i386                  randconfig-005-20250710    gcc-12
i386                  randconfig-006-20250710    gcc-12
i386                  randconfig-007-20250710    gcc-12
i386                  randconfig-011-20250710    clang-20
i386                  randconfig-012-20250710    clang-20
i386                  randconfig-013-20250710    clang-20
i386                  randconfig-014-20250710    clang-20
i386                  randconfig-015-20250710    clang-20
i386                  randconfig-016-20250710    clang-20
i386                  randconfig-017-20250710    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250710    gcc-14.3.0
loongarch             randconfig-001-20250710    gcc-15.1.0
loongarch             randconfig-002-20250710    gcc-15.1.0
m68k                             allmodconfig    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                         apollo_defconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                       m5249evb_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                      bmips_stb_defconfig    gcc-15.1.0
mips                 decstation_r4k_defconfig    gcc-15.1.0
mips                           rs90_defconfig    gcc-15.1.0
mips                   sb1250_swarm_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250710    gcc-15.1.0
nios2                 randconfig-001-20250710    gcc-9.3.0
nios2                 randconfig-002-20250710    gcc-12.4.0
nios2                 randconfig-002-20250710    gcc-15.1.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250710    gcc-15.1.0
parisc                randconfig-001-20250710    gcc-8.5.0
parisc                randconfig-002-20250710    gcc-15.1.0
parisc                randconfig-002-20250710    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc               randconfig-001-20250710    gcc-12.4.0
powerpc               randconfig-001-20250710    gcc-15.1.0
powerpc               randconfig-002-20250710    gcc-15.1.0
powerpc               randconfig-002-20250710    gcc-9.3.0
powerpc               randconfig-003-20250710    gcc-15.1.0
powerpc               randconfig-003-20250710    gcc-8.5.0
powerpc64             randconfig-001-20250710    gcc-11.5.0
powerpc64             randconfig-001-20250710    gcc-15.1.0
powerpc64             randconfig-002-20250710    clang-17
powerpc64             randconfig-002-20250710    gcc-15.1.0
powerpc64             randconfig-003-20250710    gcc-14.3.0
powerpc64             randconfig-003-20250710    gcc-15.1.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                 randconfig-001-20250710    gcc-12.4.0
riscv                 randconfig-001-20250710    gcc-15.1.0
riscv                 randconfig-002-20250710    gcc-10.5.0
riscv                 randconfig-002-20250710    gcc-12.4.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250710    gcc-12.4.0
s390                  randconfig-001-20250710    gcc-14.3.0
s390                  randconfig-002-20250710    clang-17
s390                  randconfig-002-20250710    gcc-12.4.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250710    gcc-12.4.0
sh                    randconfig-001-20250710    gcc-15.1.0
sh                    randconfig-002-20250710    gcc-12.4.0
sh                    randconfig-002-20250710    gcc-13.4.0
sh                           se7780_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250710    gcc-12.4.0
sparc                 randconfig-001-20250710    gcc-13.4.0
sparc                 randconfig-002-20250710    gcc-12.4.0
sparc                 randconfig-002-20250710    gcc-14.3.0
sparc64               randconfig-001-20250710    gcc-12.4.0
sparc64               randconfig-001-20250710    gcc-8.5.0
sparc64               randconfig-002-20250710    gcc-12.4.0
sparc64               randconfig-002-20250710    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                    randconfig-001-20250710    gcc-11
um                    randconfig-001-20250710    gcc-12.4.0
um                    randconfig-002-20250710    clang-16
um                    randconfig-002-20250710    gcc-12.4.0
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250710    clang-20
x86_64      buildonly-randconfig-001-20250710    gcc-12
x86_64      buildonly-randconfig-002-20250710    clang-20
x86_64      buildonly-randconfig-002-20250710    gcc-12
x86_64      buildonly-randconfig-003-20250710    clang-20
x86_64      buildonly-randconfig-003-20250710    gcc-12
x86_64      buildonly-randconfig-004-20250710    clang-20
x86_64      buildonly-randconfig-005-20250710    clang-20
x86_64      buildonly-randconfig-006-20250710    clang-20
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250710    gcc-12
x86_64                randconfig-002-20250710    gcc-12
x86_64                randconfig-003-20250710    gcc-12
x86_64                randconfig-004-20250710    gcc-12
x86_64                randconfig-005-20250710    gcc-12
x86_64                randconfig-006-20250710    gcc-12
x86_64                randconfig-007-20250710    gcc-12
x86_64                randconfig-008-20250710    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250710    gcc-12.4.0
xtensa                randconfig-002-20250710    gcc-12.4.0
xtensa                randconfig-002-20250710    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


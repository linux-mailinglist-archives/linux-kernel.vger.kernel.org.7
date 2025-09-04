Return-Path: <linux-kernel+bounces-800988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EA7B43E83
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36EB13AA534
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9B5307AD9;
	Thu,  4 Sep 2025 14:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zv9Di9lz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C324A3C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 14:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756995621; cv=none; b=dT+6RWH6kuzUqYRxye31zavA++cBkAHvs8D6Nb+pL69WJCmqEzts1Fsh5ZdNVYcSZbU642f8VHsEy9qO39oGN6r4EtwYj11msK6/QhCq3oxfQcG2u/bcmGdSxSyLYmwpbj/CISXDD2A0MHW+9X5qm3Lkjp+aGw1eoCr2a7uTZz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756995621; c=relaxed/simple;
	bh=kWoKzyTKFscBKjIKNbFjk/VUoWTWuEJeSdg3hEdk8qQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=FJUfO76kb2dTwFMvVvqvlHEAQI9OShM5s9JRrzWYp/1AN0wGM4gHAaito+YHcyDSJ/GjSiMnJ8VyqMUzXj3k22r1tJVWuo/m1PIqCQjEhEV3S+le+JNEma4AcNTOdWJMJT1OLBZ40WDXNwMLWzicg26u8lsPd27OAY5jSRyvIO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zv9Di9lz; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756995620; x=1788531620;
  h=date:from:to:cc:subject:message-id;
  bh=kWoKzyTKFscBKjIKNbFjk/VUoWTWuEJeSdg3hEdk8qQ=;
  b=Zv9Di9lzjYEDIXce/KqdNnNIgat4dk8G0Nlfh8ZZplvF8Cw0/lTj4Mqe
   f0iplBEvYHS15xDrcrcqFYuEEJWxJ0uHTxIOi/6TksSE5wnbd7Y+yYe2e
   nke75BXBxzGwHVSoL9eGwC0JcW+ByN+4E1l7k2F6ii9J9vsOtZjDewqMe
   dROCnrEmOJlooiH+KAyxDQqDBaxox3UEYqHLSSsG6iFLaHLY91+y/TrNg
   WzdQITvYbwUWkzlTCDb5KqTkrvGgQTX+t4WIwrY8SQYMhLKr9WK5undMI
   Rl1Thehm/QfrJQF2VmsWbqKC3soNJWE9/5TpfJlM3Vo/kQ5Eqru5tKjSn
   A==;
X-CSE-ConnectionGUID: 4+APCCzGQ9qGDPhb36pG5A==
X-CSE-MsgGUID: GwQAZvmVTrmwKWCKxNkyNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63165109"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63165109"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 07:20:20 -0700
X-CSE-ConnectionGUID: B2pcX8juSvSAUhK2YKquHw==
X-CSE-MsgGUID: eQ2NIGnEQf+ILiXpc9cYTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="171194086"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 04 Sep 2025 07:20:18 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uuAnk-0005Nd-1T;
	Thu, 04 Sep 2025 14:19:30 +0000
Date: Thu, 04 Sep 2025 22:17:31 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2025.09.02a] BUILD SUCCESS
 d53cdb008002a2d508bb9c8947ed7b48ec4f2d00
Message-ID: <202509042226.6P6kbp6c-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2025.09.02a
branch HEAD: d53cdb008002a2d508bb9c8947ed7b48ec4f2d00  fixup! tracing: Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with SRCU-fast

elapsed time: 1627m

configs tested: 102
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250903    gcc-15.1.0
arc                   randconfig-002-20250903    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                   randconfig-001-20250903    clang-22
arm                   randconfig-002-20250903    clang-16
arm                   randconfig-003-20250903    clang-22
arm                   randconfig-004-20250903    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250903    gcc-8.5.0
arm64                 randconfig-002-20250903    gcc-11.5.0
arm64                 randconfig-003-20250903    clang-22
arm64                 randconfig-004-20250903    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250903    gcc-9.5.0
csky                  randconfig-002-20250903    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250903    clang-22
hexagon               randconfig-002-20250903    clang-18
i386                             allmodconfig    gcc-13
i386                              allnoconfig    gcc-13
i386        buildonly-randconfig-001-20250903    gcc-13
i386        buildonly-randconfig-002-20250903    gcc-13
i386        buildonly-randconfig-003-20250903    clang-20
i386        buildonly-randconfig-004-20250903    clang-20
i386        buildonly-randconfig-005-20250903    clang-20
i386        buildonly-randconfig-006-20250903    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250903    gcc-15.1.0
loongarch             randconfig-002-20250903    clang-22
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
nios2                 randconfig-001-20250903    gcc-10.5.0
nios2                 randconfig-002-20250903    gcc-10.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250903    gcc-13.4.0
parisc                randconfig-002-20250903    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20250903    gcc-8.5.0
powerpc               randconfig-002-20250903    gcc-8.5.0
powerpc               randconfig-003-20250903    gcc-14.3.0
powerpc64             randconfig-001-20250903    clang-22
powerpc64             randconfig-002-20250903    clang-22
powerpc64             randconfig-003-20250903    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250903    gcc-8.5.0
riscv                 randconfig-002-20250903    gcc-9.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250903    gcc-8.5.0
s390                  randconfig-002-20250903    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250903    gcc-12.5.0
sh                    randconfig-002-20250903    gcc-10.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250903    gcc-11.5.0
sparc                 randconfig-002-20250903    gcc-15.1.0
sparc64               randconfig-001-20250903    gcc-8.5.0
sparc64               randconfig-002-20250903    gcc-11.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-13
um                    randconfig-001-20250903    gcc-13
um                    randconfig-002-20250903    clang-18
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250903    clang-20
x86_64      buildonly-randconfig-002-20250903    clang-20
x86_64      buildonly-randconfig-003-20250903    clang-20
x86_64      buildonly-randconfig-004-20250903    gcc-13
x86_64      buildonly-randconfig-005-20250903    clang-20
x86_64      buildonly-randconfig-006-20250903    gcc-13
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250903    gcc-11.5.0
xtensa                randconfig-002-20250903    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


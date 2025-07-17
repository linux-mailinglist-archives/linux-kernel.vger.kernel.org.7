Return-Path: <linux-kernel+bounces-735335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC19B08DE9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21F714A3159
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7F42E091E;
	Thu, 17 Jul 2025 13:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UeRyqniO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD81C2E0909
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752758028; cv=none; b=IqnFwVob7mX1MnZZaAox4MfOVkT0fB5Fm3EyE7cx+9dfPwdSIIuGtaj9fr4CwjTIPM7Bt2YuEqryWVvzPhgEi+ubp5KaV5jB2RUi5iobmuDU/LHspIKl4JucmEMGbT3amqaj/y7Yn1ULUNGeNBb9YTnQPmuR6BQCA5zyFfH1KhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752758028; c=relaxed/simple;
	bh=J2jkkRMcAaME+G4rzVGRkA/THt/SRHFB2AWIdQ2I8C0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nzGzHmeAyhvxkr/V4q1kheR0Px+S0Bx7EbIrzRBpdkm3xwPnzktHVw2pkIDC4GfnYoX7px+lA+Q92GiTjM57BAi2hY6qxGVgJDM3m8DbZTakZHbcdRcnFY6EnB5N3jzDZf9S33Rzlu8XCJnBL/p2HYdSgTVCfLSwgJejRmfOwXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UeRyqniO; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752758026; x=1784294026;
  h=date:from:to:cc:subject:message-id;
  bh=J2jkkRMcAaME+G4rzVGRkA/THt/SRHFB2AWIdQ2I8C0=;
  b=UeRyqniOv+jtWIoWSMvXPSt463bRX61GFlKu3t8+qD8lH+GOtP9rqPMi
   ysKUq40cL8wfgCagWnFo+PRpAQWyfEZJOiFIv1EJt88dxJINnBS+7DeUh
   sxqVYjhIa20i8nbEG5qSuok/6h1+7VcL9GY9dPRKtcQWq7wtDHnw4nJTt
   X/BoG+aUyp8J/BNSDLV6ZbrQkzhH6nSoJIntiPw8T59dxwCq5oguOiL3Y
   NT0ZBNapm+t9kKPtb2phIM/pmhag5+SsmzJbv73fOWM2DL7Gi4E9EAyBZ
   rKBD6mK/2xedvStVrOjCEy0TEsWWgBGJK6ws9qSGl2wGagHWdnFUlPcnZ
   w==;
X-CSE-ConnectionGUID: +7B/FJm5SrO57P9oi1t6wQ==
X-CSE-MsgGUID: wPuOEOW5QaKsedx0anGfQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="66382385"
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; 
   d="scan'208";a="66382385"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 06:13:43 -0700
X-CSE-ConnectionGUID: 234TN28bSJqNYaJIZCowgA==
X-CSE-MsgGUID: u67RyD0lTKe3uo0cnDtXGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; 
   d="scan'208";a="157465141"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 17 Jul 2025 06:13:42 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ucOQd-000Dei-3C;
	Thu, 17 Jul 2025 13:13:39 +0000
Date: Thu, 17 Jul 2025 21:13:12 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2025.07.11a] BUILD SUCCESS
 82d2c9da4e9f0cec17ee65793078aff6e9da1df3
Message-ID: <202507172100.noibFADZ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2025.07.11a
branch HEAD: 82d2c9da4e9f0cec17ee65793078aff6e9da1df3  smp: Document preemption and stop_machine() mutual exclusion

elapsed time: 924m

configs tested: 222
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
arc                   randconfig-001-20250717    clang-21
arc                   randconfig-001-20250717    gcc-8.5.0
arc                   randconfig-002-20250717    clang-21
arc                   randconfig-002-20250717    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-21
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                   randconfig-001-20250717    clang-21
arm                   randconfig-002-20250717    clang-21
arm                   randconfig-002-20250717    gcc-8.5.0
arm                   randconfig-003-20250717    clang-21
arm                   randconfig-003-20250717    gcc-8.5.0
arm                   randconfig-004-20250717    clang-21
arm                             rpc_defconfig    clang-21
arm                           sama5_defconfig    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-21
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250717    clang-18
arm64                 randconfig-001-20250717    clang-21
arm64                 randconfig-002-20250717    clang-18
arm64                 randconfig-002-20250717    clang-21
arm64                 randconfig-003-20250717    clang-21
arm64                 randconfig-003-20250717    gcc-10.5.0
arm64                 randconfig-004-20250717    clang-21
csky                              allnoconfig    clang-21
csky                                defconfig    clang-19
csky                  randconfig-001-20250717    gcc-12.4.0
csky                  randconfig-001-20250717    gcc-15.1.0
csky                  randconfig-002-20250717    gcc-12.4.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250717    clang-20
hexagon               randconfig-001-20250717    gcc-12.4.0
hexagon               randconfig-002-20250717    clang-19
hexagon               randconfig-002-20250717    gcc-12.4.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250717    clang-20
i386        buildonly-randconfig-001-20250717    gcc-12
i386        buildonly-randconfig-002-20250717    clang-20
i386        buildonly-randconfig-002-20250717    gcc-12
i386        buildonly-randconfig-003-20250717    clang-20
i386        buildonly-randconfig-004-20250717    clang-20
i386        buildonly-randconfig-005-20250717    clang-20
i386        buildonly-randconfig-006-20250717    clang-20
i386        buildonly-randconfig-006-20250717    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250717    gcc-12
i386                  randconfig-002-20250717    gcc-12
i386                  randconfig-003-20250717    gcc-12
i386                  randconfig-004-20250717    gcc-12
i386                  randconfig-005-20250717    gcc-12
i386                  randconfig-006-20250717    gcc-12
i386                  randconfig-007-20250717    gcc-12
i386                  randconfig-011-20250717    gcc-12
i386                  randconfig-012-20250717    gcc-12
i386                  randconfig-013-20250717    gcc-12
i386                  randconfig-014-20250717    gcc-12
i386                  randconfig-015-20250717    gcc-12
i386                  randconfig-016-20250717    gcc-12
i386                  randconfig-017-20250717    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250717    gcc-12.4.0
loongarch             randconfig-001-20250717    gcc-15.1.0
loongarch             randconfig-002-20250717    clang-21
loongarch             randconfig-002-20250717    gcc-12.4.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           xway_defconfig    clang-21
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250717    gcc-12.4.0
nios2                 randconfig-001-20250717    gcc-8.5.0
nios2                 randconfig-002-20250717    gcc-12.4.0
nios2                 randconfig-002-20250717    gcc-9.3.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250717    gcc-12.4.0
parisc                randconfig-001-20250717    gcc-9.3.0
parisc                randconfig-002-20250717    gcc-12.4.0
parisc                randconfig-002-20250717    gcc-9.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                        icon_defconfig    clang-21
powerpc                         ps3_defconfig    clang-21
powerpc               randconfig-001-20250717    clang-21
powerpc               randconfig-001-20250717    gcc-12.4.0
powerpc               randconfig-002-20250717    gcc-12.4.0
powerpc               randconfig-002-20250717    gcc-13.4.0
powerpc               randconfig-003-20250717    clang-21
powerpc               randconfig-003-20250717    gcc-12.4.0
powerpc64             randconfig-001-20250717    clang-21
powerpc64             randconfig-001-20250717    gcc-12.4.0
powerpc64             randconfig-002-20250717    clang-18
powerpc64             randconfig-002-20250717    gcc-12.4.0
powerpc64             randconfig-003-20250717    clang-21
powerpc64             randconfig-003-20250717    gcc-12.4.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250717    gcc-13.4.0
riscv                 randconfig-001-20250717    gcc-14.3.0
riscv                 randconfig-002-20250717    clang-21
riscv                 randconfig-002-20250717    gcc-13.4.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250717    gcc-13.4.0
s390                  randconfig-001-20250717    gcc-8.5.0
s390                  randconfig-002-20250717    gcc-13.4.0
s390                  randconfig-002-20250717    gcc-9.3.0
s390                       zfcpdump_defconfig    clang-21
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250717    gcc-13.4.0
sh                    randconfig-001-20250717    gcc-14.3.0
sh                    randconfig-002-20250717    gcc-13.4.0
sh                    randconfig-002-20250717    gcc-9.3.0
sh                   sh7724_generic_defconfig    clang-21
sparc                            alldefconfig    clang-21
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250717    gcc-13.4.0
sparc                 randconfig-001-20250717    gcc-14.3.0
sparc                 randconfig-002-20250717    gcc-13.4.0
sparc                 randconfig-002-20250717    gcc-8.5.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250717    gcc-12.4.0
sparc64               randconfig-001-20250717    gcc-13.4.0
sparc64               randconfig-002-20250717    clang-21
sparc64               randconfig-002-20250717    gcc-13.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250717    gcc-12
um                    randconfig-001-20250717    gcc-13.4.0
um                    randconfig-002-20250717    gcc-12
um                    randconfig-002-20250717    gcc-13.4.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250717    clang-20
x86_64      buildonly-randconfig-001-20250717    gcc-12
x86_64      buildonly-randconfig-002-20250717    clang-20
x86_64      buildonly-randconfig-002-20250717    gcc-12
x86_64      buildonly-randconfig-003-20250717    clang-20
x86_64      buildonly-randconfig-003-20250717    gcc-12
x86_64      buildonly-randconfig-004-20250717    gcc-12
x86_64      buildonly-randconfig-005-20250717    gcc-12
x86_64      buildonly-randconfig-006-20250717    clang-20
x86_64      buildonly-randconfig-006-20250717    gcc-12
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250717    gcc-11
x86_64                randconfig-002-20250717    gcc-11
x86_64                randconfig-003-20250717    gcc-11
x86_64                randconfig-004-20250717    gcc-11
x86_64                randconfig-005-20250717    gcc-11
x86_64                randconfig-006-20250717    gcc-11
x86_64                randconfig-007-20250717    gcc-11
x86_64                randconfig-008-20250717    gcc-11
x86_64                randconfig-071-20250717    gcc-12
x86_64                randconfig-072-20250717    gcc-12
x86_64                randconfig-073-20250717    gcc-12
x86_64                randconfig-074-20250717    gcc-12
x86_64                randconfig-075-20250717    gcc-12
x86_64                randconfig-076-20250717    gcc-12
x86_64                randconfig-077-20250717    gcc-12
x86_64                randconfig-078-20250717    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250717    gcc-13.4.0
xtensa                randconfig-002-20250717    gcc-13.4.0
xtensa                randconfig-002-20250717    gcc-9.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-kernel+bounces-765238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7B4B22D6D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C514116CD19
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC9A2F8BCC;
	Tue, 12 Aug 2025 16:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SCl3Z7Rh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318F72F83B0
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 16:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015682; cv=none; b=I49rf5rhS+fcaba/zhsjyfeTRBBPZvWEBRzSKawy7dXPQxiTnQRTN1w0jE/Pnz+/ykNIOmFG0ddLBMAgpZIOxSkznmiPaQdXJDxHPRoNZ/+T44AxdNHHj2pz1DcfVzxbjfKJ7siUtuQZLBuIraXXRjyWjtmmdCMrSjvtH1JPIYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015682; c=relaxed/simple;
	bh=ePrFv1VSbpCmwvj3Fck39HuQeWjuqxYkpiZbCnIiV7Y=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WNwGRO/u+2KfsLwnQvqObPtbe8GvlCBQL9KvS5GVOLp1WUEuMmQsf+qJfTzvBowSVgxgh4+YOCKLJlFRXcDQfIePya9gnU9h/gcYyFZJwZ68S25jPLwugYL44bVDwoklLFDpNCxvm7LdqCnargpq69nfd+4/rQQaWvsWm+s5Wh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SCl3Z7Rh; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755015682; x=1786551682;
  h=date:from:to:cc:subject:message-id;
  bh=ePrFv1VSbpCmwvj3Fck39HuQeWjuqxYkpiZbCnIiV7Y=;
  b=SCl3Z7RhPntb8FMNRfmAs6gtb5meM7k1uSAWEte4GJKSzSaJ4SR0j1Qu
   Z0hsmeQTlybUH7xl5sN493gK4PDOX25KbKWbrql1mliEWovaEc3ezhizM
   yaR8uf85M9irdnBfDr4URm45dKJgKr8Wox/6BSfUkLHzbFu8/EuczrpPu
   OYruAMmST/oVsiLQzxmDMIk6FB2HmrOBTZ13x1oItsAyM6V5QCB4zEyZ3
   PHcE0o7XDAMmptMY34LMQT9olc6jXna8vYGSrdEEd4UoDdtPy/i2u1+/h
   FfiBgdHf3ku9ha5pnANitVEad69vY2pMtO3S0SktQsN2ZNxAN7ExkGQYi
   A==;
X-CSE-ConnectionGUID: sA+KHC13Q0+YNzqGekRgjg==
X-CSE-MsgGUID: FOKbHRM4QQC5eYbn7shYng==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57443626"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="57443626"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 09:21:21 -0700
X-CSE-ConnectionGUID: wrgjjkJgTkiMMjTmgPPuEg==
X-CSE-MsgGUID: QkA2+ea9Ry67/Mb1xAkZIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="171571539"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 12 Aug 2025 09:21:19 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ulrkS-0006yx-3A;
	Tue, 12 Aug 2025 16:21:16 +0000
Date: Wed, 13 Aug 2025 00:21:08 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:locking/urgent] BUILD SUCCESS
 dfb36e4a8db0cd56f92d4cb445f54e85a9b40897
Message-ID: <202508130003.x90JuxIZ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/urgent
branch HEAD: dfb36e4a8db0cd56f92d4cb445f54e85a9b40897  futex: Use user_write_access_begin/_end() in futex_put_value()

elapsed time: 1444m

configs tested: 184
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250812    gcc-14.3.0
arc                   randconfig-001-20250812    gcc-8.5.0
arc                   randconfig-002-20250812    gcc-12.5.0
arc                   randconfig-002-20250812    gcc-14.3.0
arc                           tb10x_defconfig    gcc-15.1.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                        keystone_defconfig    gcc-15.1.0
arm                   randconfig-001-20250812    clang-22
arm                   randconfig-001-20250812    gcc-14.3.0
arm                   randconfig-002-20250812    clang-22
arm                   randconfig-002-20250812    gcc-14.3.0
arm                   randconfig-003-20250812    gcc-14.3.0
arm                   randconfig-004-20250812    gcc-10.5.0
arm                   randconfig-004-20250812    gcc-14.3.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250812    gcc-14.3.0
arm64                 randconfig-001-20250812    gcc-8.5.0
arm64                 randconfig-002-20250812    gcc-14.3.0
arm64                 randconfig-002-20250812    gcc-8.5.0
arm64                 randconfig-003-20250812    gcc-14.3.0
arm64                 randconfig-004-20250812    gcc-14.3.0
arm64                 randconfig-004-20250812    gcc-8.5.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250812    gcc-13.4.0
csky                  randconfig-002-20250812    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250812    clang-22
hexagon               randconfig-002-20250812    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250812    gcc-12
i386        buildonly-randconfig-002-20250812    gcc-12
i386        buildonly-randconfig-003-20250812    gcc-12
i386        buildonly-randconfig-004-20250812    clang-20
i386        buildonly-randconfig-004-20250812    gcc-12
i386        buildonly-randconfig-005-20250812    clang-20
i386        buildonly-randconfig-005-20250812    gcc-12
i386        buildonly-randconfig-006-20250812    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250812    clang-20
i386                  randconfig-002-20250812    clang-20
i386                  randconfig-003-20250812    clang-20
i386                  randconfig-004-20250812    clang-20
i386                  randconfig-005-20250812    clang-20
i386                  randconfig-006-20250812    clang-20
i386                  randconfig-007-20250812    clang-20
i386                  randconfig-011-20250812    gcc-12
i386                  randconfig-012-20250812    gcc-12
i386                  randconfig-013-20250812    gcc-12
i386                  randconfig-014-20250812    gcc-12
i386                  randconfig-015-20250812    gcc-12
i386                  randconfig-016-20250812    gcc-12
i386                  randconfig-017-20250812    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250812    gcc-15.1.0
loongarch             randconfig-002-20250812    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          ath25_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250812    gcc-10.5.0
nios2                 randconfig-002-20250812    gcc-11.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250812    gcc-10.5.0
parisc                randconfig-002-20250812    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                      bamboo_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250812    clang-19
powerpc               randconfig-002-20250812    clang-22
powerpc               randconfig-003-20250812    gcc-12.5.0
powerpc64             randconfig-001-20250812    clang-22
powerpc64             randconfig-002-20250812    clang-16
powerpc64             randconfig-003-20250812    clang-18
riscv                            alldefconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250812    clang-18
riscv                 randconfig-001-20250812    gcc-9.5.0
riscv                 randconfig-002-20250812    clang-18
riscv                 randconfig-002-20250812    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250812    clang-18
s390                  randconfig-002-20250812    clang-18
s390                  randconfig-002-20250812    clang-22
s390                       zfcpdump_defconfig    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250812    clang-18
sh                    randconfig-001-20250812    gcc-15.1.0
sh                    randconfig-002-20250812    clang-18
sh                    randconfig-002-20250812    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250812    clang-18
sparc                 randconfig-001-20250812    gcc-8.5.0
sparc                 randconfig-002-20250812    clang-18
sparc                 randconfig-002-20250812    gcc-8.5.0
sparc64               randconfig-001-20250812    clang-18
sparc64               randconfig-001-20250812    clang-22
sparc64               randconfig-002-20250812    clang-18
sparc64               randconfig-002-20250812    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                    randconfig-001-20250812    clang-18
um                    randconfig-001-20250812    gcc-11
um                    randconfig-002-20250812    clang-18
um                    randconfig-002-20250812    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250812    clang-20
x86_64      buildonly-randconfig-001-20250812    gcc-12
x86_64      buildonly-randconfig-002-20250812    gcc-12
x86_64      buildonly-randconfig-003-20250812    gcc-12
x86_64      buildonly-randconfig-004-20250812    gcc-12
x86_64      buildonly-randconfig-005-20250812    clang-20
x86_64      buildonly-randconfig-005-20250812    gcc-12
x86_64      buildonly-randconfig-006-20250812    gcc-12
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250812    gcc-11
x86_64                randconfig-002-20250812    gcc-11
x86_64                randconfig-003-20250812    gcc-11
x86_64                randconfig-004-20250812    gcc-11
x86_64                randconfig-005-20250812    gcc-11
x86_64                randconfig-006-20250812    gcc-11
x86_64                randconfig-007-20250812    gcc-11
x86_64                randconfig-008-20250812    gcc-11
x86_64                randconfig-071-20250812    clang-20
x86_64                randconfig-072-20250812    clang-20
x86_64                randconfig-073-20250812    clang-20
x86_64                randconfig-074-20250812    clang-20
x86_64                randconfig-075-20250812    clang-20
x86_64                randconfig-076-20250812    clang-20
x86_64                randconfig-077-20250812    clang-20
x86_64                randconfig-078-20250812    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250812    clang-18
xtensa                randconfig-001-20250812    gcc-10.5.0
xtensa                randconfig-002-20250812    clang-18
xtensa                randconfig-002-20250812    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


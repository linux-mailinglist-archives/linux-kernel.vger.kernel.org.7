Return-Path: <linux-kernel+bounces-759363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD03CB1DCA3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 19:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C6AD18C45E5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 17:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD81E1DF73A;
	Thu,  7 Aug 2025 17:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BpvhahkU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2993F4C85
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 17:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754588925; cv=none; b=NkSnglEdnS+9XGuZWHy+4XPbJjf9o4CwoSYeaww+5KVB5egvi6Fw0fBh2t45lN28HBgiK1YPKHf8r/0hUvfqEV1y9rh9DbZAvCjbuhXX3yqj6Mtl01ll1FX9mnpUWsobpC3e53bVe1ZOzCU/tcge33VGnOtFhzkCz8/wjXpyaTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754588925; c=relaxed/simple;
	bh=fDmfUw8rkgMAryqcdLKqpfbhU5fzBastDxmerxfaG4s=;
	h=Date:From:To:Cc:Subject:Message-ID; b=t7CehbG1qVx3VYyKsbInKQpDWvvfDBjcRU+8M5LNzwYhR8XZ0Pq88h9CdTH0ZNyxZlcVrv1SRYqg9d41s3kbp6TFrgVVGt7sdTILx7g3L+QBIEvzTAZQDFy8QRd6S8baP2bpqCU9VKl/OWjK/pDLzEfRhWUjnqn5Zz14KU1P1GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BpvhahkU; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754588924; x=1786124924;
  h=date:from:to:cc:subject:message-id;
  bh=fDmfUw8rkgMAryqcdLKqpfbhU5fzBastDxmerxfaG4s=;
  b=BpvhahkUgp7g7hSUIjZPZ51b7KFpdxXeq3enxeMGyBjeYhq5MeOuv4oX
   7wHdoROYwsIQDWgLJBZ34H802fBLSRX/UaIHoL/cYrb0OIbCCCXEGgU4y
   HmiadymbLoZpDmutA5n6oaFrCsDpp2ovjczjfabSx04393x6HraeVixrh
   pzRiRhIcZRxOWJr4ciZogCo8F+yY8ELfqJzGCy9mLiUGSRdz6W884/ipi
   WVO4zLmvglt2z4OiB/25tOF1SBo/d31FKkOursUARPKmFz4waZj18sbCC
   FTTyjC5AQIISG5RhHOVPxDpFp8ZwGGjKroe9NNU2hLo8UkEyRrVNE7RKt
   w==;
X-CSE-ConnectionGUID: ZVSOyJgpRR26tFpZcksRKg==
X-CSE-MsgGUID: qpgRTzBORN+3S/PubVQqcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="67630765"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="67630765"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 10:48:44 -0700
X-CSE-ConnectionGUID: tdhjDhsHSKW3y4DXgXEBIg==
X-CSE-MsgGUID: dmwDqSs1SdeklA7r6kwlFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="165536091"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 07 Aug 2025 10:48:42 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uk4jD-00033w-2k;
	Thu, 07 Aug 2025 17:48:37 +0000
Date: Fri, 08 Aug 2025 01:48:07 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:smp/urgent] BUILD SUCCESS
 da274853fe7dbc7124e2dd84dad802be52a09321
Message-ID: <202508080156.tRtjwsMT-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp/urgent
branch HEAD: da274853fe7dbc7124e2dd84dad802be52a09321  cpu: Remove obsolete comment from takedown_cpu()

elapsed time: 1235m

configs tested: 241
configs skipped: 7

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
arc                   randconfig-001-20250807    clang-22
arc                   randconfig-001-20250807    gcc-13.4.0
arc                   randconfig-002-20250807    clang-22
arc                   randconfig-002-20250807    gcc-12.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                         axm55xx_defconfig    clang-22
arm                                 defconfig    clang-19
arm                      jornada720_defconfig    clang-22
arm                   randconfig-001-20250807    clang-22
arm                   randconfig-002-20250807    clang-22
arm                   randconfig-002-20250807    gcc-10.5.0
arm                   randconfig-003-20250807    clang-22
arm                   randconfig-004-20250807    clang-22
arm                   randconfig-004-20250807    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250807    clang-22
arm64                 randconfig-001-20250807    gcc-8.5.0
arm64                 randconfig-002-20250807    clang-22
arm64                 randconfig-002-20250807    gcc-8.5.0
arm64                 randconfig-003-20250807    clang-22
arm64                 randconfig-004-20250807    clang-22
arm64                 randconfig-004-20250807    gcc-14.3.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                                defconfig    clang-22
csky                  randconfig-001-20250807    gcc-15.1.0
csky                  randconfig-002-20250807    gcc-15.1.0
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250807    clang-22
hexagon               randconfig-001-20250807    gcc-15.1.0
hexagon               randconfig-002-20250807    clang-22
hexagon               randconfig-002-20250807    gcc-15.1.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250807    clang-20
i386        buildonly-randconfig-001-20250807    gcc-12
i386        buildonly-randconfig-002-20250807    clang-20
i386        buildonly-randconfig-002-20250807    gcc-12
i386        buildonly-randconfig-003-20250807    gcc-12
i386        buildonly-randconfig-004-20250807    gcc-11
i386        buildonly-randconfig-004-20250807    gcc-12
i386        buildonly-randconfig-005-20250807    gcc-12
i386        buildonly-randconfig-006-20250807    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250807    gcc-12
i386                  randconfig-002-20250807    gcc-12
i386                  randconfig-003-20250807    gcc-12
i386                  randconfig-004-20250807    gcc-12
i386                  randconfig-005-20250807    gcc-12
i386                  randconfig-006-20250807    gcc-12
i386                  randconfig-007-20250807    gcc-12
i386                  randconfig-011-20250807    clang-20
i386                  randconfig-012-20250807    clang-20
i386                  randconfig-013-20250807    clang-20
i386                  randconfig-014-20250807    clang-20
i386                  randconfig-015-20250807    clang-20
i386                  randconfig-016-20250807    clang-20
i386                  randconfig-017-20250807    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250807    clang-22
loongarch             randconfig-001-20250807    gcc-15.1.0
loongarch             randconfig-002-20250807    gcc-15.1.0
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
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                            alldefconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250807    gcc-11.5.0
nios2                 randconfig-001-20250807    gcc-15.1.0
nios2                 randconfig-002-20250807    gcc-15.1.0
nios2                 randconfig-002-20250807    gcc-8.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250807    gcc-15.1.0
parisc                randconfig-001-20250807    gcc-8.5.0
parisc                randconfig-002-20250807    gcc-11.5.0
parisc                randconfig-002-20250807    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                    amigaone_defconfig    clang-22
powerpc                       ppc64_defconfig    clang-22
powerpc               randconfig-001-20250807    gcc-12.5.0
powerpc               randconfig-001-20250807    gcc-15.1.0
powerpc               randconfig-002-20250807    gcc-10.5.0
powerpc               randconfig-002-20250807    gcc-15.1.0
powerpc               randconfig-003-20250807    gcc-11.5.0
powerpc               randconfig-003-20250807    gcc-15.1.0
powerpc64             randconfig-001-20250807    gcc-11.5.0
powerpc64             randconfig-001-20250807    gcc-15.1.0
powerpc64             randconfig-002-20250807    clang-22
powerpc64             randconfig-002-20250807    gcc-15.1.0
powerpc64             randconfig-003-20250807    gcc-13.4.0
powerpc64             randconfig-003-20250807    gcc-15.1.0
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                    nommu_virt_defconfig    clang-22
riscv                 randconfig-001-20250807    gcc-12.5.0
riscv                 randconfig-002-20250807    gcc-12.5.0
riscv                 randconfig-002-20250807    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250807    clang-22
s390                  randconfig-001-20250807    gcc-12.5.0
s390                  randconfig-002-20250807    clang-22
s390                  randconfig-002-20250807    gcc-12.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250807    gcc-12.5.0
sh                    randconfig-001-20250807    gcc-14.3.0
sh                    randconfig-002-20250807    gcc-12.5.0
sh                    randconfig-002-20250807    gcc-9.5.0
sh                           se7721_defconfig    clang-22
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250807    gcc-12.5.0
sparc                 randconfig-001-20250807    gcc-14.3.0
sparc                 randconfig-002-20250807    gcc-12.5.0
sparc                 randconfig-002-20250807    gcc-15.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250807    clang-22
sparc64               randconfig-001-20250807    gcc-12.5.0
sparc64               randconfig-002-20250807    clang-22
sparc64               randconfig-002-20250807    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250807    gcc-12
um                    randconfig-001-20250807    gcc-12.5.0
um                    randconfig-002-20250807    gcc-11
um                    randconfig-002-20250807    gcc-12.5.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250807    clang-20
x86_64      buildonly-randconfig-001-20250807    gcc-11
x86_64      buildonly-randconfig-002-20250807    gcc-11
x86_64      buildonly-randconfig-002-20250807    gcc-12
x86_64      buildonly-randconfig-003-20250807    clang-20
x86_64      buildonly-randconfig-003-20250807    gcc-11
x86_64      buildonly-randconfig-004-20250807    clang-20
x86_64      buildonly-randconfig-004-20250807    gcc-11
x86_64      buildonly-randconfig-005-20250807    gcc-11
x86_64      buildonly-randconfig-006-20250807    gcc-11
x86_64      buildonly-randconfig-006-20250807    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250807    gcc-12
x86_64                randconfig-002-20250807    gcc-12
x86_64                randconfig-003-20250807    gcc-12
x86_64                randconfig-004-20250807    gcc-12
x86_64                randconfig-005-20250807    gcc-12
x86_64                randconfig-006-20250807    gcc-12
x86_64                randconfig-007-20250807    gcc-12
x86_64                randconfig-008-20250807    gcc-12
x86_64                randconfig-071-20250807    clang-20
x86_64                randconfig-072-20250807    clang-20
x86_64                randconfig-073-20250807    clang-20
x86_64                randconfig-074-20250807    clang-20
x86_64                randconfig-075-20250807    clang-20
x86_64                randconfig-076-20250807    clang-20
x86_64                randconfig-077-20250807    clang-20
x86_64                randconfig-078-20250807    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250807    gcc-12.5.0
xtensa                randconfig-001-20250807    gcc-15.1.0
xtensa                randconfig-002-20250807    gcc-12.5.0
xtensa                randconfig-002-20250807    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


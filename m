Return-Path: <linux-kernel+bounces-869858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5DCC08E07
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 10:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74B911C2822F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 08:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DAF2BD5A4;
	Sat, 25 Oct 2025 08:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UYQ3W8YI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F3072612
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 08:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761381955; cv=none; b=DEyzOcV2KYlpbOQdzM5egOfubXkUGN6FZ85jcqOAQ5tMzkmy0Z3GZKZTzePK7znTY5pvodOpjxLmHXVMQXztTjyVkm8aLruT4Wc4g1XCMFg36LDd4qFp5zV+z0KR9T7JmjomeeXEElUPrlthPoxUpNnqRDgUOfntsZ33puQDM+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761381955; c=relaxed/simple;
	bh=3WbUu2DMu8dfgLU/30VkR/iJ7Uw3FwbTyIWzEBVdV08=;
	h=Date:From:To:Cc:Subject:Message-ID; b=J0lnkHgmbrfvLsD3Nc1GXmS6r5OpCIS9R3+zoTaPxtLnK2yFiuLkpL6UQs8eTinEA/Umm3RTMyCWqCLCf1lbD5snr/tpnGst00Cb15cW/PlBRzEruBx/IE6GJ3UjmQY4njUV8Mj0vyqOx3eglUElm3xoQW3D/6GX9QFW5wwVmJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UYQ3W8YI; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761381954; x=1792917954;
  h=date:from:to:cc:subject:message-id;
  bh=3WbUu2DMu8dfgLU/30VkR/iJ7Uw3FwbTyIWzEBVdV08=;
  b=UYQ3W8YI1iG66g9u1hNRZGg6TFgQxbLUyawrxgOhf3yVxnSZms/nGFhl
   cATgBTUqs9lH3prGwIp33oYh4DmHzq+YWOBLCuHXbGNtr0/fB0DWSXsHA
   dTCtJGw4kUzAyEwdmy1VOQTp/HdYrDDJIfD+ZfN/35PGYt3bZxK8Mpt3z
   Pq3YCXlToFOWzPogxTrRwdCZHvLY32rlMhZDZuISMSBtJ4i9TH+j4G47v
   VXORpdSqnmMYTDdhI/P0K7keLm17oZ2QNu8M8MgnAHOp6BAfLYuSg9HIa
   chw2QCFOrw776i9+9C3jY1UIJkt30cwiWSgr7ig9zJdp8Eakw2t194lCI
   w==;
X-CSE-ConnectionGUID: PYFHolzVSAq/gq6DpDYkKQ==
X-CSE-MsgGUID: F+wmmQ+eRkObzytScp15jQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63247980"
X-IronPort-AV: E=Sophos;i="6.19,254,1754982000"; 
   d="scan'208";a="63247980"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2025 01:45:53 -0700
X-CSE-ConnectionGUID: kYuM9Q5yRAqe7gufc/nlYQ==
X-CSE-MsgGUID: L4eTL20fTg+wMzlbSx/pvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,254,1754982000"; 
   d="scan'208";a="185094462"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 25 Oct 2025 01:45:51 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vCZuH-000FCX-0n;
	Sat, 25 Oct 2025 08:45:49 +0000
Date: Sat, 25 Oct 2025 16:44:53 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/bugs] BUILD SUCCESS
 e9cc99142a145efc04b7fb871c2e19bffee2729c
Message-ID: <202510251647.hkik8ujl-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/bugs
branch HEAD: e9cc99142a145efc04b7fb871c2e19bffee2729c  x86/tsx: Get the tsx= command line parameter with early_param()

elapsed time: 721m

configs tested: 162
configs skipped: 134

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                            allyesconfig    clang-19
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-22
arc                              allyesconfig    clang-19
arc                                 defconfig    clang-19
arc                   randconfig-001-20251025    clang-22
arc                   randconfig-002-20251025    clang-22
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                   randconfig-001-20251025    clang-22
arm                   randconfig-002-20251025    clang-22
arm                   randconfig-003-20251025    clang-22
arm                   randconfig-004-20251025    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                            allyesconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20251025    clang-22
arm64                 randconfig-002-20251025    clang-22
arm64                 randconfig-003-20251025    clang-22
arm64                 randconfig-004-20251025    clang-22
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    clang-22
csky                             allyesconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20251025    gcc-10.5.0
csky                  randconfig-002-20251025    gcc-10.5.0
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20251025    gcc-10.5.0
hexagon               randconfig-002-20251025    gcc-10.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20251025    clang-20
i386        buildonly-randconfig-001-20251025    gcc-14
i386        buildonly-randconfig-002-20251025    clang-20
i386        buildonly-randconfig-002-20251025    gcc-14
i386        buildonly-randconfig-003-20251025    clang-20
i386        buildonly-randconfig-004-20251025    clang-20
i386        buildonly-randconfig-005-20251025    clang-20
i386        buildonly-randconfig-006-20251025    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20251025    clang-20
i386                  randconfig-002-20251025    clang-20
i386                  randconfig-003-20251025    clang-20
i386                  randconfig-004-20251025    clang-20
i386                  randconfig-005-20251025    clang-20
i386                  randconfig-006-20251025    clang-20
i386                  randconfig-007-20251025    clang-20
i386                  randconfig-011-20251025    gcc-14
i386                  randconfig-012-20251025    gcc-14
i386                  randconfig-013-20251025    gcc-14
i386                  randconfig-014-20251025    gcc-14
i386                  randconfig-015-20251025    gcc-14
i386                  randconfig-016-20251025    gcc-14
i386                  randconfig-017-20251025    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                        allyesconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251025    gcc-10.5.0
loongarch             randconfig-002-20251025    gcc-10.5.0
m68k                             allmodconfig    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    gcc-15.1.0
nios2                            allyesconfig    clang-22
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20251025    gcc-10.5.0
nios2                 randconfig-002-20251025    gcc-10.5.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-14
parisc                            allnoconfig    clang-22
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251025    gcc-10.5.0
parisc                randconfig-002-20251025    gcc-10.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc               randconfig-001-20251025    gcc-10.5.0
powerpc               randconfig-002-20251025    gcc-10.5.0
powerpc               randconfig-003-20251025    gcc-10.5.0
powerpc64             randconfig-001-20251025    gcc-10.5.0
powerpc64             randconfig-002-20251025    gcc-10.5.0
powerpc64             randconfig-003-20251025    gcc-10.5.0
riscv                             allnoconfig    clang-22
riscv                               defconfig    gcc-14
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                            allyesconfig    clang-22
sparc                               defconfig    gcc-15.1.0
sparc64                          allmodconfig    clang-22
sparc64                          allyesconfig    clang-22
sparc64                             defconfig    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251025    clang-20
x86_64      buildonly-randconfig-001-20251025    gcc-14
x86_64      buildonly-randconfig-002-20251025    clang-20
x86_64      buildonly-randconfig-002-20251025    gcc-14
x86_64      buildonly-randconfig-003-20251025    clang-20
x86_64      buildonly-randconfig-003-20251025    gcc-14
x86_64      buildonly-randconfig-004-20251025    clang-20
x86_64      buildonly-randconfig-005-20251025    clang-20
x86_64      buildonly-randconfig-006-20251025    clang-20
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251025    clang-20
x86_64                randconfig-002-20251025    clang-20
x86_64                randconfig-003-20251025    clang-20
x86_64                randconfig-004-20251025    clang-20
x86_64                randconfig-005-20251025    clang-20
x86_64                randconfig-006-20251025    clang-20
x86_64                randconfig-007-20251025    clang-20
x86_64                randconfig-008-20251025    clang-20
x86_64                randconfig-071-20251025    clang-20
x86_64                randconfig-072-20251025    clang-20
x86_64                randconfig-073-20251025    clang-20
x86_64                randconfig-074-20251025    clang-20
x86_64                randconfig-075-20251025    clang-20
x86_64                randconfig-076-20251025    clang-20
x86_64                randconfig-077-20251025    clang-20
x86_64                randconfig-078-20251025    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


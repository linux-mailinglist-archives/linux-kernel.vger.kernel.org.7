Return-Path: <linux-kernel+bounces-881369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61185C28173
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 16:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C9E14E5473
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 15:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD2E23BCE3;
	Sat,  1 Nov 2025 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A05vzw8C"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088B0A59
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 15:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762011712; cv=none; b=h315QVRMMXAxrIj+fqgNbaLRgznNgDFS3GgWQGl93FmvGqvEJ3zf6XzebLcEdMrqhHJIyApVok3DFSVV0OKiq+h8trUZQcwFNJCSAhxew8clQARyQTbmQEWba9C8qeSdjoNdMl3Yd36OpUpqtwZN8cFX7L7UWT3OelK0pSWr5C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762011712; c=relaxed/simple;
	bh=pySyZGTUYfYGfQGT5N1o/T8A3vUThMrPCbuMiDtrF2U=;
	h=Date:From:To:Cc:Subject:Message-ID; b=IKlD7fwpfQzeAiHbiBnsDbD7SUBcuoMu+4GwJoctf5PeehMCmcI4b03RJCkIvtzJy2yN0u5190H0j2xRoBb71j99CyO8xqNv61XCTNBrnr3HWhBKqFSxY/CwvJBy0rOFtBXdJBeG/tzyysOFjzsVd/LjMQX4a+fqRtnOlVeaMg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A05vzw8C; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762011711; x=1793547711;
  h=date:from:to:cc:subject:message-id;
  bh=pySyZGTUYfYGfQGT5N1o/T8A3vUThMrPCbuMiDtrF2U=;
  b=A05vzw8CUuMYZhvfmprkmAdu1lMPNFM23kiRpVk/iTd9u1Ub5iIS0t66
   dGHHnXgtLaCfyy9hTWEAikGYm3P3CwPLryYaU6R9ocg3zM93hudBKI7l9
   YGG9g3wv4siHRBY2QnY2k6hjeRUHtKuoawW8FP00VX3dtqn/fl6puQ2dP
   GBFWm2wZcLcvYMTEFZBkkNJUMA67EHwzX5l6Hmuppd12or1KdZ3okunZ6
   C25dI52wrVIaIVD7SwnhTQPZ/psESwjGHKQZUECGfVhyr88XBOsBI5Z4j
   f9fvixaHpUne61tj4kzkRRoQNpI8+JDI+dfjlVcrLmroypHnEhIXSmO6w
   g==;
X-CSE-ConnectionGUID: 4PLaqNqZRC+Z4aS/Ks61zw==
X-CSE-MsgGUID: l1WC3AV/QVmDIdLWjBV2pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11600"; a="75602973"
X-IronPort-AV: E=Sophos;i="6.19,272,1754982000"; 
   d="scan'208";a="75602973"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2025 08:41:51 -0700
X-CSE-ConnectionGUID: WgevYaU+S6qc3vWC6nWjSA==
X-CSE-MsgGUID: pImL6YYuSsKirZGBpj3+kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,272,1754982000"; 
   d="scan'208";a="190824446"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 01 Nov 2025 08:41:50 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vFDjf-000OPc-1K;
	Sat, 01 Nov 2025 15:41:47 +0000
Date: Sat, 01 Nov 2025 23:41:34 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 9b041a4b66b3b62c30251e700b5688324cf66625
Message-ID: <202511012328.T3rTthtR-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 9b041a4b66b3b62c30251e700b5688324cf66625  x86/mm: Ensure clear_page() variants always have __kcfi_typeid_ symbols

elapsed time: 1001m

configs tested: 142
configs skipped: 121

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                              allyesconfig    clang-19
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251101    gcc-8.5.0
arc                   randconfig-002-20251101    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                              allyesconfig    clang-19
arm                                 defconfig    gcc-15.1.0
arm                        mvebu_v7_defconfig    clang-22
arm                   randconfig-001-20251101    gcc-8.5.0
arm                   randconfig-002-20251101    gcc-8.5.0
arm                   randconfig-003-20251101    gcc-8.5.0
arm                   randconfig-004-20251101    gcc-8.5.0
arm                        spear3xx_defconfig    clang-22
arm                        spear6xx_defconfig    clang-22
arm                        vexpress_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                            allyesconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251101    gcc-14.3.0
arm64                 randconfig-002-20251101    gcc-14.3.0
arm64                 randconfig-003-20251101    gcc-14.3.0
arm64                 randconfig-004-20251101    gcc-14.3.0
csky                             allmodconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251101    gcc-14.3.0
csky                  randconfig-002-20251101    gcc-14.3.0
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20251101    clang-19
hexagon               randconfig-002-20251101    clang-19
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20251101    clang-20
i386        buildonly-randconfig-002-20251101    clang-20
i386        buildonly-randconfig-003-20251101    clang-20
i386        buildonly-randconfig-004-20251101    clang-20
i386        buildonly-randconfig-005-20251101    clang-20
i386        buildonly-randconfig-006-20251101    clang-20
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20251101    gcc-14
i386                  randconfig-002-20251101    gcc-14
i386                  randconfig-003-20251101    gcc-14
i386                  randconfig-004-20251101    gcc-14
i386                  randconfig-005-20251101    gcc-14
i386                  randconfig-006-20251101    gcc-14
i386                  randconfig-007-20251101    gcc-14
i386                  randconfig-011-20251101    clang-20
i386                  randconfig-012-20251101    clang-20
i386                  randconfig-013-20251101    clang-20
i386                  randconfig-014-20251101    clang-20
i386                  randconfig-015-20251101    clang-20
i386                  randconfig-016-20251101    clang-20
i386                  randconfig-017-20251101    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allyesconfig    gcc-15.1.0
loongarch             randconfig-001-20251101    clang-19
loongarch             randconfig-002-20251101    clang-19
m68k                             allmodconfig    clang-19
m68k                             allyesconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                       allyesconfig    clang-19
mips                             allmodconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                            allmodconfig    clang-22
nios2                            allyesconfig    clang-22
nios2                 randconfig-001-20251101    clang-19
nios2                 randconfig-002-20251101    clang-19
openrisc                         allmodconfig    clang-22
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                     skiroot_defconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-15.1.0
riscv                 randconfig-001-20251101    clang-17
riscv                 randconfig-002-20251101    clang-17
s390                             allmodconfig    gcc-15.1.0
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20251101    clang-17
s390                  randconfig-002-20251101    clang-17
sh                               allmodconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20251101    clang-17
sh                    randconfig-002-20251101    clang-17
sh                           se7206_defconfig    clang-22
sh                   secureedge5410_defconfig    clang-22
sparc                            allmodconfig    gcc-15.1.0
sparc                            allyesconfig    clang-22
sparc                               defconfig    gcc-15.1.0
sparc64                          allmodconfig    clang-22
sparc64                          allyesconfig    clang-22
sparc64                             defconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251101    gcc-14
x86_64      buildonly-randconfig-002-20251101    gcc-14
x86_64      buildonly-randconfig-003-20251101    gcc-14
x86_64      buildonly-randconfig-004-20251101    gcc-14
x86_64      buildonly-randconfig-005-20251101    gcc-14
x86_64      buildonly-randconfig-006-20251101    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251101    clang-20
x86_64                randconfig-002-20251101    clang-20
x86_64                randconfig-003-20251101    clang-20
x86_64                randconfig-004-20251101    clang-20
x86_64                randconfig-005-20251101    clang-20
x86_64                randconfig-006-20251101    clang-20
x86_64                randconfig-011-20251101    gcc-14
x86_64                randconfig-012-20251101    gcc-14
x86_64                randconfig-013-20251101    gcc-14
x86_64                randconfig-014-20251101    gcc-14
x86_64                randconfig-015-20251101    gcc-14
x86_64                randconfig-016-20251101    gcc-14
x86_64                randconfig-071-20251101    clang-20
x86_64                randconfig-072-20251101    clang-20
x86_64                randconfig-073-20251101    clang-20
x86_64                randconfig-074-20251101    clang-20
x86_64                randconfig-075-20251101    clang-20
x86_64                randconfig-076-20251101    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                           allyesconfig    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


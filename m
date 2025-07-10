Return-Path: <linux-kernel+bounces-725358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E29D6AFFE09
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C24B01C40F68
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC83298CBE;
	Thu, 10 Jul 2025 09:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CbuYJmt9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8237295520
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752139611; cv=none; b=P47HMBkW6h4+/m57XiDWhPiI4vshvtzYNBsa/xP54LHwniX4gDI7lG97ug5n4TPo79qZ7TM4p+beTHrn9hntGWBruBN8ZOORlRTBzyfm6eSSiy2ToXnUndbRL4MlIDEbKGXA3xnMR0rqL1+fPbERJIvUBMYc1M1e9cy4MiA4NIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752139611; c=relaxed/simple;
	bh=spaumYsxq5tXHi5QarNtXSofzvouKHUTLePVOKiVHok=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BRaiKRnh1ZzTdOz++oPWp5y8Hz5GF6fl5uVho69N4NoraYXB22YYpz7L6CuIgzKJ6j0gMR/GixlYZIBnBW2jIRgi9zt5pUF4cAa2L840zUGYZ0gi+T4NNs+Uy+cU85WyRlrJFxyV3sn4mqTmn+U3xE0GKq8wY9WjZ3Oi2spgLWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CbuYJmt9; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752139610; x=1783675610;
  h=date:from:to:cc:subject:message-id;
  bh=spaumYsxq5tXHi5QarNtXSofzvouKHUTLePVOKiVHok=;
  b=CbuYJmt9hFiKJg+9YsEqUqtR/ooPlQdBs7GYnbwJgtvUb9XRpak9NlN9
   MdkO5DH8iMtwdvt9v3TZ1cCcfWp9JkXb/Bpo8p5j/rclr5uXnwWP4szMV
   MaDX69/Lych1iO9d2mFs6ABIjNH/PG5AayhlxPJuIYg7HzeK8JzT/BTR3
   FUOIn7YvvXGcsxkt2TxJXK+K0A5IibL5pQwR6BwbGa74mRfW4SkeZI4yO
   Cafd8uNku9W4fWMHbkVlx7LsdmOgqKdN1uB9C4AXHNVlyNTXRDhLDOELC
   7kmph+ZarD7KDWSN11qeN46nB15Vj9rTSIX97mlw7/mu+h1sWqCnacOwn
   g==;
X-CSE-ConnectionGUID: 1TtCoE5vTkKxhmSM2CPprA==
X-CSE-MsgGUID: ZshsTW5JRueKqzUBuE+ULg==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54267137"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="54267137"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 02:26:50 -0700
X-CSE-ConnectionGUID: tgiF0T6GRcGicZKQClH9uw==
X-CSE-MsgGUID: vCJ/QuWjSuywjs5HFaivmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="193225644"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 10 Jul 2025 02:26:49 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uZnYD-0004rr-1u;
	Thu, 10 Jul 2025 09:26:45 +0000
Date: Thu, 10 Jul 2025 17:26:28 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/merge] BUILD SUCCESS
 b0f2df9876d7cb1f52985a57415de62d28373bc5
Message-ID: <202507101715.HvUJHuEO-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/merge
branch HEAD: b0f2df9876d7cb1f52985a57415de62d28373bc5  Merge branch 'x86/cpu' into x86/merge, to resolve conflict

elapsed time: 1449m

configs tested: 254
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-21
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-21
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20250709    gcc-8.5.0
arc                   randconfig-001-20250710    clang-21
arc                   randconfig-002-20250709    gcc-11.5.0
arc                   randconfig-002-20250710    clang-21
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                   randconfig-001-20250709    gcc-12.4.0
arm                   randconfig-001-20250710    clang-21
arm                   randconfig-002-20250709    gcc-10.5.0
arm                   randconfig-002-20250710    clang-21
arm                   randconfig-003-20250709    clang-21
arm                   randconfig-003-20250710    clang-21
arm                   randconfig-004-20250709    clang-21
arm                   randconfig-004-20250710    clang-21
arm                           spitz_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-21
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250709    clang-21
arm64                 randconfig-001-20250710    clang-21
arm64                 randconfig-002-20250709    gcc-15.1.0
arm64                 randconfig-002-20250710    clang-21
arm64                 randconfig-003-20250709    clang-21
arm64                 randconfig-003-20250710    clang-21
arm64                 randconfig-004-20250709    gcc-10.5.0
arm64                 randconfig-004-20250710    clang-21
csky                              allnoconfig    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250709    gcc-15.1.0
csky                  randconfig-001-20250710    gcc-15.1.0
csky                  randconfig-002-20250709    gcc-15.1.0
csky                  randconfig-002-20250710    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250709    clang-19
hexagon               randconfig-001-20250710    gcc-15.1.0
hexagon               randconfig-002-20250709    clang-21
hexagon               randconfig-002-20250710    gcc-15.1.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250709    gcc-12
i386        buildonly-randconfig-001-20250710    clang-20
i386        buildonly-randconfig-002-20250709    clang-20
i386        buildonly-randconfig-002-20250710    clang-20
i386        buildonly-randconfig-003-20250709    clang-20
i386        buildonly-randconfig-003-20250710    clang-20
i386        buildonly-randconfig-004-20250709    clang-20
i386        buildonly-randconfig-004-20250710    clang-20
i386        buildonly-randconfig-005-20250709    gcc-12
i386        buildonly-randconfig-005-20250710    clang-20
i386        buildonly-randconfig-006-20250709    clang-20
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
loongarch             randconfig-001-20250709    gcc-15.1.0
loongarch             randconfig-001-20250710    gcc-15.1.0
loongarch             randconfig-002-20250709    gcc-12.4.0
loongarch             randconfig-002-20250710    gcc-15.1.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                         apollo_defconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                       m5249evb_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                      bmips_stb_defconfig    gcc-15.1.0
mips                 decstation_r4k_defconfig    gcc-15.1.0
mips                           rs90_defconfig    gcc-15.1.0
mips                   sb1250_swarm_defconfig    gcc-15.1.0
nios2                            allmodconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
nios2                            allyesconfig    clang-21
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250709    gcc-14.2.0
nios2                 randconfig-001-20250710    gcc-15.1.0
nios2                 randconfig-002-20250709    gcc-14.2.0
nios2                 randconfig-002-20250710    gcc-15.1.0
openrisc                         allmodconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250709    gcc-15.1.0
parisc                randconfig-001-20250710    gcc-15.1.0
parisc                randconfig-002-20250709    gcc-14.3.0
parisc                randconfig-002-20250710    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc               randconfig-001-20250709    gcc-8.5.0
powerpc               randconfig-001-20250710    gcc-15.1.0
powerpc               randconfig-002-20250709    clang-21
powerpc               randconfig-002-20250710    gcc-15.1.0
powerpc               randconfig-003-20250709    clang-21
powerpc               randconfig-003-20250710    gcc-15.1.0
powerpc64             randconfig-001-20250709    gcc-10.5.0
powerpc64             randconfig-001-20250710    gcc-15.1.0
powerpc64             randconfig-002-20250709    gcc-10.5.0
powerpc64             randconfig-002-20250710    gcc-15.1.0
powerpc64             randconfig-003-20250709    clang-21
powerpc64             randconfig-003-20250710    gcc-15.1.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250709    gcc-10.5.0
riscv                 randconfig-001-20250710    gcc-12.4.0
riscv                 randconfig-002-20250709    clang-21
riscv                 randconfig-002-20250710    gcc-12.4.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250709    clang-17
s390                  randconfig-001-20250710    gcc-12.4.0
s390                  randconfig-002-20250709    clang-21
s390                  randconfig-002-20250710    gcc-12.4.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250709    gcc-10.5.0
sh                    randconfig-001-20250710    gcc-12.4.0
sh                    randconfig-002-20250709    gcc-14.3.0
sh                    randconfig-002-20250710    gcc-12.4.0
sh                           se7780_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                            allyesconfig    clang-21
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250709    gcc-15.1.0
sparc                 randconfig-001-20250710    gcc-12.4.0
sparc                 randconfig-002-20250709    gcc-10.3.0
sparc                 randconfig-002-20250710    gcc-12.4.0
sparc64                          allmodconfig    clang-21
sparc64                          allyesconfig    clang-21
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250709    clang-21
sparc64               randconfig-001-20250710    gcc-12.4.0
sparc64               randconfig-002-20250709    clang-21
sparc64               randconfig-002-20250710    gcc-12.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250709    clang-17
um                    randconfig-001-20250710    gcc-12.4.0
um                    randconfig-002-20250709    gcc-12
um                    randconfig-002-20250710    gcc-12.4.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250709    gcc-12
x86_64      buildonly-randconfig-001-20250710    clang-20
x86_64      buildonly-randconfig-002-20250709    clang-20
x86_64      buildonly-randconfig-002-20250710    clang-20
x86_64      buildonly-randconfig-003-20250709    gcc-12
x86_64      buildonly-randconfig-003-20250710    clang-20
x86_64      buildonly-randconfig-004-20250709    gcc-12
x86_64      buildonly-randconfig-004-20250710    clang-20
x86_64      buildonly-randconfig-005-20250709    clang-20
x86_64      buildonly-randconfig-005-20250710    clang-20
x86_64      buildonly-randconfig-006-20250709    gcc-12
x86_64      buildonly-randconfig-006-20250710    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250710    gcc-12
x86_64                randconfig-002-20250710    gcc-12
x86_64                randconfig-003-20250710    gcc-12
x86_64                randconfig-004-20250710    gcc-12
x86_64                randconfig-005-20250710    gcc-12
x86_64                randconfig-006-20250710    gcc-12
x86_64                randconfig-007-20250710    gcc-12
x86_64                randconfig-008-20250710    gcc-12
x86_64                randconfig-071-20250710    gcc-11
x86_64                randconfig-072-20250710    gcc-11
x86_64                randconfig-073-20250710    gcc-11
x86_64                randconfig-074-20250710    gcc-11
x86_64                randconfig-075-20250710    gcc-11
x86_64                randconfig-076-20250710    gcc-11
x86_64                randconfig-077-20250710    gcc-11
x86_64                randconfig-078-20250710    gcc-11
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    clang-21
xtensa                randconfig-001-20250709    gcc-8.5.0
xtensa                randconfig-001-20250710    gcc-12.4.0
xtensa                randconfig-002-20250709    gcc-11.5.0
xtensa                randconfig-002-20250710    gcc-12.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


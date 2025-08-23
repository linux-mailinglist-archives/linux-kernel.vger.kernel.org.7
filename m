Return-Path: <linux-kernel+bounces-783296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AE9B32B6F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 20:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 542DF56492C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F87B2E62D3;
	Sat, 23 Aug 2025 18:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ct+l51MW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D17315530C
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 18:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755972337; cv=none; b=DDv/NgEXw4AFWDr0awOGC8DDwLowd5yVzkziGDP7gqqfYxaSK1ULgZq3eDZMcBmeUbePOVH02WMN1wZJsUswFMaP6U1MTeo/pcKFe9uIwzYfHiEX/XdAaqwmjUIcd5xXP52xTejiu7YBMHOGzIgrolQkO+5qQHz7ESBR7IJOgEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755972337; c=relaxed/simple;
	bh=h5StqO1xOQI4IodbxTlqgFwTEb9TuOLPf2NrU/OuAJk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Nn8SB0f1yooqKljDW2zJ7a16CpzhNWS9kJoaWdWjRjNeP2dkRG98SU27xeUzSdGYNsHoFiBhoEhnzqHT/Z49kW3KZRAUtPQYQzlDDVVsi4J5j/1mmZMQzvLZXIwlLv1FwanZzLPKJXmPaaznVTLQG/wI6GncyXKXT7W1s8cfDoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ct+l51MW; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755972336; x=1787508336;
  h=date:from:to:cc:subject:message-id;
  bh=h5StqO1xOQI4IodbxTlqgFwTEb9TuOLPf2NrU/OuAJk=;
  b=ct+l51MWwpamBJJPAPpusBKupo1Q3RXhygxjoWZmz8w4mn5RuwQWAHOR
   2shx+83AnZHinx6YsY/Upa35nvkKlKrflXal0mfZ8kBy98dsBXiUMnudY
   gq11Tfpehs/82sGvo8sQK2va0cSo0oXVsmQJfKLpfzPvXewPcscjQFBkU
   KcU7bl7+bgoxZnF8iXPb1tSgwF+8njo+PLd/skRP/16aGPG6LEHAK7N4S
   X2Ce7t9l2Y1x/VppCT1rRA0ZF7V2EuOik4KdHRk+E0A6Eb9BL2RAAeCeq
   sU5fFCWu6x+i6znoLAU1jJ/+L1MibuPQhsrxUx2ZBfxJRCSRRb+IBXb7w
   Q==;
X-CSE-ConnectionGUID: 9o2zRqJ2SxSBf6vllqRlfQ==
X-CSE-MsgGUID: Xx61it56SN6Ft7kEvuDJtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62076118"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62076118"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2025 11:05:35 -0700
X-CSE-ConnectionGUID: 4i0IZvcRSUmKp6S0X7hZ4Q==
X-CSE-MsgGUID: +WozojHZRD27uGnFmqX6pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="174226923"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 23 Aug 2025 11:05:34 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upscN-000MUh-2r;
	Sat, 23 Aug 2025 18:05:31 +0000
Date: Sun, 24 Aug 2025 02:04:53 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2025.08.21a] BUILD SUCCESS
 ac5d5e956cf3e06a8c4597e42a9cca8e7c673eb5
Message-ID: <202508240247.MTgDVT9t-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2025.08.21a
branch HEAD: ac5d5e956cf3e06a8c4597e42a9cca8e7c673eb5  docs: rcu: Replace multiple dead OLS links in RTFP.txt

elapsed time: 1374m

configs tested: 230
configs skipped: 5

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
arc                   randconfig-001-20250823    clang-22
arc                   randconfig-001-20250823    gcc-9.5.0
arc                   randconfig-002-20250823    clang-22
arc                   randconfig-002-20250823    gcc-12.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                          exynos_defconfig    clang-22
arm                      jornada720_defconfig    clang-22
arm                   randconfig-001-20250823    clang-17
arm                   randconfig-001-20250823    clang-22
arm                   randconfig-002-20250823    clang-22
arm                   randconfig-002-20250823    gcc-15.1.0
arm                   randconfig-003-20250823    clang-20
arm                   randconfig-003-20250823    clang-22
arm                   randconfig-004-20250823    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                            allyesconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250823    clang-22
arm64                 randconfig-001-20250823    gcc-11.5.0
arm64                 randconfig-002-20250823    clang-22
arm64                 randconfig-003-20250823    clang-22
arm64                 randconfig-004-20250823    clang-22
arm64                 randconfig-004-20250823    gcc-15.1.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250823    clang-22
csky                  randconfig-001-20250823    gcc-15.1.0
csky                  randconfig-002-20250823    clang-22
csky                  randconfig-002-20250823    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250823    clang-22
hexagon               randconfig-002-20250823    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250823    clang-20
i386        buildonly-randconfig-002-20250823    clang-20
i386        buildonly-randconfig-003-20250823    clang-20
i386        buildonly-randconfig-004-20250823    clang-20
i386        buildonly-randconfig-005-20250823    clang-20
i386        buildonly-randconfig-006-20250823    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250823    clang-20
i386                  randconfig-002-20250823    clang-20
i386                  randconfig-003-20250823    clang-20
i386                  randconfig-004-20250823    clang-20
i386                  randconfig-005-20250823    clang-20
i386                  randconfig-006-20250823    clang-20
i386                  randconfig-007-20250823    clang-20
i386                  randconfig-011-20250823    gcc-12
i386                  randconfig-012-20250823    gcc-12
i386                  randconfig-013-20250823    gcc-12
i386                  randconfig-014-20250823    gcc-12
i386                  randconfig-015-20250823    gcc-12
i386                  randconfig-016-20250823    gcc-12
i386                  randconfig-017-20250823    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                        allyesconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250823    clang-22
loongarch             randconfig-002-20250823    clang-22
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                        bcm47xx_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250823    clang-22
nios2                 randconfig-001-20250823    gcc-11.5.0
nios2                 randconfig-002-20250823    clang-22
nios2                 randconfig-002-20250823    gcc-8.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250823    clang-22
parisc                randconfig-001-20250823    gcc-8.5.0
parisc                randconfig-002-20250823    clang-22
parisc                randconfig-002-20250823    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                    ge_imp3a_defconfig    clang-22
powerpc                 mpc832x_rdb_defconfig    clang-22
powerpc               randconfig-001-20250823    clang-22
powerpc               randconfig-002-20250823    clang-22
powerpc               randconfig-003-20250823    clang-22
powerpc64             randconfig-001-20250823    clang-22
powerpc64             randconfig-001-20250823    gcc-11.5.0
powerpc64             randconfig-002-20250823    clang-22
powerpc64             randconfig-003-20250823    clang-22
powerpc64             randconfig-003-20250823    gcc-10.5.0
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250823    clang-22
riscv                 randconfig-002-20250823    clang-22
riscv                 randconfig-002-20250823    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250823    clang-22
s390                  randconfig-001-20250823    gcc-9.5.0
s390                  randconfig-002-20250823    clang-22
sh                               alldefconfig    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250823    clang-22
sh                    randconfig-001-20250823    gcc-15.1.0
sh                    randconfig-002-20250823    clang-22
sh                    randconfig-002-20250823    gcc-15.1.0
sh                        sh7757lcr_defconfig    clang-22
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250823    clang-22
sparc                 randconfig-001-20250823    gcc-8.5.0
sparc                 randconfig-002-20250823    clang-22
sparc                 randconfig-002-20250823    gcc-8.5.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250823    clang-22
sparc64               randconfig-001-20250823    gcc-8.5.0
sparc64               randconfig-002-20250823    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250823    clang-22
um                    randconfig-002-20250823    clang-22
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250823    gcc-12
x86_64      buildonly-randconfig-002-20250823    gcc-12
x86_64      buildonly-randconfig-003-20250823    clang-20
x86_64      buildonly-randconfig-004-20250823    clang-20
x86_64      buildonly-randconfig-005-20250823    gcc-12
x86_64      buildonly-randconfig-006-20250823    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250823    gcc-12
x86_64                randconfig-002-20250823    gcc-12
x86_64                randconfig-003-20250823    gcc-12
x86_64                randconfig-004-20250823    gcc-12
x86_64                randconfig-005-20250823    gcc-12
x86_64                randconfig-006-20250823    gcc-12
x86_64                randconfig-007-20250823    gcc-12
x86_64                randconfig-008-20250823    gcc-12
x86_64                randconfig-071-20250823    gcc-11
x86_64                randconfig-072-20250823    gcc-11
x86_64                randconfig-073-20250823    gcc-11
x86_64                randconfig-074-20250823    gcc-11
x86_64                randconfig-075-20250823    gcc-11
x86_64                randconfig-076-20250823    gcc-11
x86_64                randconfig-077-20250823    gcc-11
x86_64                randconfig-078-20250823    gcc-11
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250823    clang-22
xtensa                randconfig-001-20250823    gcc-15.1.0
xtensa                randconfig-002-20250823    clang-22
xtensa                randconfig-002-20250823    gcc-13.4.0
xtensa                    xip_kc705_defconfig    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-kernel+bounces-847833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D98EBCBD9F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6F8D4EF017
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 07:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603B327586C;
	Fri, 10 Oct 2025 07:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KRYS1s0D"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB4A274FDC
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760079663; cv=none; b=dvpWF39z7w0qHO5cO+YzOL5AiTs08KP+MoeX3/EYB77Sdmg9Nd8qErvIiys2i2iCiJG3+RZ80SQQT1+kUZ7UlYW68FuXYKfb902moygmOXmr3s6UZM9teT1cKnIRpLlbCNS+16uGHVVArax5cEH/LWr01FfKgj9uMQuFAht7CLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760079663; c=relaxed/simple;
	bh=0O60l2DbJbSQlZqi0DdW1Cq4u7LAFuSra3IbKZaqR/0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mIXYhuScZTfOgb5SRa4JnfTrG/bHXQmklVCmpvYnJZVn7FYTa2nXakb6I9Tc3QADUBAd0voQcb0XbziYZ1eXbraJpa58C5J6u18YgoCOIcJ6dCYsiUZ4pv1Yrg1+ocqts6KpjaaO0qdwOiyt+XJqrgcnPbwp/xbPv8Kl9+Vqr6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KRYS1s0D; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760079661; x=1791615661;
  h=date:from:to:cc:subject:message-id;
  bh=0O60l2DbJbSQlZqi0DdW1Cq4u7LAFuSra3IbKZaqR/0=;
  b=KRYS1s0DezgWeFNYHUSgTeFg6gFbcdxNQq6MwMMlV9ZT4ndYVded8RTF
   AoUucuEaz54zXW6FxFJsbdZBm+vs0PCz0HE5Rt1UlZHxqic3jyb3mzx1G
   HTm2KO2hVTbo+jJmaILsYUJHgu6Z5Dc85Rgp2mAw1QM7fNuVnQpv/TMY7
   neImjj9fYWTDoq40mtzQlCyrbqo6aGaogVGBcwjGh9Df1fKqeNB4tZzTi
   vC7iZ1sxX8wzi7E7DdR4RlqL87czEL7Y+Bl6rS1burjVQ6zTHC2RsslBA
   cbdQdzQpcBHxs/d+/H6+J1OjhsgGU97keSHuDbMEEU6WPbB4LUqlz7UKc
   Q==;
X-CSE-ConnectionGUID: tDDsOKrvTMiCgbS3Xldd5g==
X-CSE-MsgGUID: qMUgLmNtR6GhhU4YuksFpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="72552989"
X-IronPort-AV: E=Sophos;i="6.19,218,1754982000"; 
   d="scan'208";a="72552989"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 00:01:00 -0700
X-CSE-ConnectionGUID: IO9gGPl0SOia5dmOir0lxA==
X-CSE-MsgGUID: zgURq9n3S5aS36Sv1QFYBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,218,1754982000"; 
   d="scan'208";a="180857585"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 10 Oct 2025 00:00:59 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v777Z-0002NQ-0m;
	Fri, 10 Oct 2025 07:00:57 +0000
Date: Fri, 10 Oct 2025 15:00:52 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 7d24c651ce163bc04e7683ec75bf976b6ff042e2
Message-ID: <202510101546.TpdjUxFk-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 7d24c651ce163bc04e7683ec75bf976b6ff042e2  Merge branch into tip/master: 'x86/core'

elapsed time: 1450m

configs tested: 240
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
arc                   randconfig-001-20251009    gcc-11.5.0
arc                   randconfig-001-20251010    gcc-8.5.0
arc                   randconfig-002-20251009    gcc-14.3.0
arc                   randconfig-002-20251010    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                         bcm2835_defconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                      integrator_defconfig    gcc-15.1.0
arm                   randconfig-001-20251009    gcc-10.5.0
arm                   randconfig-001-20251010    gcc-8.5.0
arm                   randconfig-002-20251009    gcc-11.5.0
arm                   randconfig-002-20251010    gcc-8.5.0
arm                   randconfig-003-20251009    gcc-11.5.0
arm                   randconfig-003-20251010    gcc-8.5.0
arm                   randconfig-004-20251009    gcc-12.5.0
arm                   randconfig-004-20251010    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20251009    gcc-8.5.0
arm64                 randconfig-001-20251010    gcc-8.5.0
arm64                 randconfig-002-20251009    gcc-14.3.0
arm64                 randconfig-002-20251010    gcc-8.5.0
arm64                 randconfig-003-20251009    gcc-9.5.0
arm64                 randconfig-003-20251010    gcc-8.5.0
arm64                 randconfig-004-20251009    gcc-8.5.0
arm64                 randconfig-004-20251010    gcc-8.5.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20251009    gcc-13.4.0
csky                  randconfig-001-20251010    gcc-14.3.0
csky                  randconfig-002-20251009    gcc-15.1.0
csky                  randconfig-002-20251010    gcc-14.3.0
hexagon                          alldefconfig    clang-22
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20251009    clang-16
hexagon               randconfig-001-20251010    gcc-14.3.0
hexagon               randconfig-002-20251009    clang-19
hexagon               randconfig-002-20251010    gcc-14.3.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20251010    gcc-14
i386        buildonly-randconfig-002-20251010    clang-20
i386        buildonly-randconfig-002-20251010    gcc-14
i386        buildonly-randconfig-003-20251010    clang-20
i386        buildonly-randconfig-003-20251010    gcc-14
i386        buildonly-randconfig-004-20251010    gcc-14
i386        buildonly-randconfig-005-20251010    gcc-14
i386        buildonly-randconfig-006-20251010    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251010    clang-20
i386                  randconfig-002-20251010    clang-20
i386                  randconfig-003-20251010    clang-20
i386                  randconfig-004-20251010    clang-20
i386                  randconfig-005-20251010    clang-20
i386                  randconfig-006-20251010    clang-20
i386                  randconfig-007-20251010    clang-20
i386                  randconfig-011-20251010    gcc-14
i386                  randconfig-012-20251010    gcc-14
i386                  randconfig-013-20251010    gcc-14
i386                  randconfig-014-20251010    gcc-14
i386                  randconfig-015-20251010    gcc-14
i386                  randconfig-016-20251010    gcc-14
i386                  randconfig-017-20251010    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251009    gcc-15.1.0
loongarch             randconfig-001-20251010    gcc-14.3.0
loongarch             randconfig-002-20251009    gcc-15.1.0
loongarch             randconfig-002-20251010    gcc-14.3.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                          sun3x_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          eyeq5_defconfig    clang-22
mips                           gcw0_defconfig    gcc-15.1.0
mips                           ip22_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20251009    gcc-8.5.0
nios2                 randconfig-001-20251010    gcc-14.3.0
nios2                 randconfig-002-20251009    gcc-11.5.0
nios2                 randconfig-002-20251010    gcc-14.3.0
openrisc                          allnoconfig    clang-22
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
openrisc                  or1klitex_defconfig    clang-22
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251009    gcc-8.5.0
parisc                randconfig-001-20251010    gcc-14.3.0
parisc                randconfig-002-20251009    gcc-9.5.0
parisc                randconfig-002-20251010    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                      mgcoge_defconfig    clang-22
powerpc                      pasemi_defconfig    clang-22
powerpc               randconfig-001-20251009    gcc-8.5.0
powerpc               randconfig-001-20251010    gcc-14.3.0
powerpc               randconfig-002-20251009    gcc-11.5.0
powerpc               randconfig-002-20251010    gcc-14.3.0
powerpc               randconfig-003-20251009    gcc-8.5.0
powerpc               randconfig-003-20251010    gcc-14.3.0
powerpc64             randconfig-001-20251010    gcc-14.3.0
powerpc64             randconfig-002-20251009    clang-22
powerpc64             randconfig-002-20251010    gcc-14.3.0
powerpc64             randconfig-003-20251009    clang-22
powerpc64             randconfig-003-20251010    gcc-14.3.0
riscv                             allnoconfig    clang-22
riscv                               defconfig    gcc-14
riscv                    nommu_k210_defconfig    gcc-15.1.0
riscv                 randconfig-001-20251009    gcc-8.5.0
riscv                 randconfig-001-20251010    gcc-9.5.0
riscv                 randconfig-002-20251009    clang-19
riscv                 randconfig-002-20251010    gcc-9.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20251009    clang-22
s390                  randconfig-001-20251010    gcc-9.5.0
s390                  randconfig-002-20251009    clang-22
s390                  randconfig-002-20251010    gcc-9.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20251009    gcc-15.1.0
sh                    randconfig-001-20251010    gcc-9.5.0
sh                    randconfig-002-20251009    gcc-12.5.0
sh                    randconfig-002-20251010    gcc-9.5.0
sh                           se7721_defconfig    clang-22
sh                            shmin_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251009    gcc-8.5.0
sparc                 randconfig-001-20251010    gcc-9.5.0
sparc                 randconfig-002-20251009    gcc-8.5.0
sparc                 randconfig-002-20251010    gcc-9.5.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251009    clang-22
sparc64               randconfig-001-20251010    gcc-9.5.0
sparc64               randconfig-002-20251009    clang-22
sparc64               randconfig-002-20251010    gcc-9.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251009    clang-17
um                    randconfig-001-20251010    gcc-9.5.0
um                    randconfig-002-20251009    gcc-14
um                    randconfig-002-20251010    gcc-9.5.0
um                           x86_64_defconfig    gcc-14
um                           x86_64_defconfig    gcc-15.1.0
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251010    clang-20
x86_64      buildonly-randconfig-001-20251010    gcc-14
x86_64      buildonly-randconfig-002-20251010    clang-20
x86_64      buildonly-randconfig-002-20251010    gcc-14
x86_64      buildonly-randconfig-003-20251010    clang-20
x86_64      buildonly-randconfig-003-20251010    gcc-14
x86_64      buildonly-randconfig-004-20251010    clang-20
x86_64      buildonly-randconfig-004-20251010    gcc-14
x86_64      buildonly-randconfig-005-20251010    gcc-14
x86_64      buildonly-randconfig-006-20251010    gcc-14
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251010    clang-20
x86_64                randconfig-002-20251010    clang-20
x86_64                randconfig-003-20251010    clang-20
x86_64                randconfig-004-20251010    clang-20
x86_64                randconfig-005-20251010    clang-20
x86_64                randconfig-006-20251010    clang-20
x86_64                randconfig-007-20251010    clang-20
x86_64                randconfig-008-20251010    clang-20
x86_64                randconfig-071-20251010    clang-20
x86_64                randconfig-072-20251010    clang-20
x86_64                randconfig-073-20251010    clang-20
x86_64                randconfig-074-20251010    clang-20
x86_64                randconfig-075-20251010    clang-20
x86_64                randconfig-076-20251010    clang-20
x86_64                randconfig-077-20251010    clang-20
x86_64                randconfig-078-20251010    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                generic_kc705_defconfig    gcc-15.1.0
xtensa                randconfig-001-20251009    gcc-11.5.0
xtensa                randconfig-001-20251010    gcc-9.5.0
xtensa                randconfig-002-20251009    gcc-8.5.0
xtensa                randconfig-002-20251010    gcc-9.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


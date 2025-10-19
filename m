Return-Path: <linux-kernel+bounces-859816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96830BEEAC7
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 19:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 255E81899552
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 17:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7FA21B918;
	Sun, 19 Oct 2025 17:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z2VbwI3c"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F062518D658
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 17:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760894655; cv=none; b=tF7ievVkq63mzQ/AN7edQDJ8LXUTja34iFoUSLN5IInvIe4G9QBHMl4n/hfWmebl8qnQC7tIerJ2G/AH/K69XoKABjx/izUwnX1hruVma0kll0cUwIAU7uuU8R5Ufz2gfx3Ao2dTqnRuTmfMl4vZ4MiYqc2aPtDk+k+Pjy4eUAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760894655; c=relaxed/simple;
	bh=Ge/ytKKVR0t64yiygXEm0yu1Ptq1Zmueb4CnaB0Cp9s=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gKQWlZC+hmSMpDulpIWdS6gf5dlipyjQIuDXsN7mN4WpOuPCmx/Iczv/EcOh+vWXTwaqFZjjyRA2UQPMOZJkYRMnIG104XgSS++5QuMfetz0lLzikKIvHkVYducv7mhQTvQ/4brg65Nz9SayLDzNtKk+Fs8C97/pNCGL+PNwfi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z2VbwI3c; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760894653; x=1792430653;
  h=date:from:to:cc:subject:message-id;
  bh=Ge/ytKKVR0t64yiygXEm0yu1Ptq1Zmueb4CnaB0Cp9s=;
  b=Z2VbwI3cUByuS0dIEkv17S6c1UMpGXjrKFRKUXCwaL0oIPT+zCbAMx5Z
   TR1VflQJK1pRecv1nVQyvLGZPoQNJzAga5xkXhX1hKE4jgQs/W/73XGVn
   4L+cnsu5eYJk6K44rO6ThqwGPxyJB72T7kuGH6L5C300gWoXvNOVOtoq8
   M4koM0fsZvvIot18tuIsYfRwthoWGGfXvsCYzeVFYfKVHz5rW0PVhsMgu
   CVRCgm2qgRyhQMOel17oZdhX6T1ZsvAwVG0igfh2e6YD+//FMqniM0s2A
   67NYWRScUkPZdOMPTFNBQGxtYGLq5Dzsh12uyiWhUr695ri3wMlnt1PW/
   w==;
X-CSE-ConnectionGUID: EXzAAkkGSIWR7pqxac8U2w==
X-CSE-MsgGUID: OzHaLAHRS2miwtpEohK5nQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11587"; a="74377555"
X-IronPort-AV: E=Sophos;i="6.19,241,1754982000"; 
   d="scan'208";a="74377555"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 10:24:10 -0700
X-CSE-ConnectionGUID: oxHEhRPdR3q0MT9sEOlz3w==
X-CSE-MsgGUID: TF9ULCnWQSGCQdva4QeSOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,241,1754982000"; 
   d="scan'208";a="183570144"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 19 Oct 2025 10:24:09 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vAX89-0009EP-33;
	Sun, 19 Oct 2025 17:23:49 +0000
Date: Mon, 20 Oct 2025 01:22:43 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 15b7ab079fc8fb3e45f520edf91a89264a7ce37b
Message-ID: <202510200135.tquP57cn-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 15b7ab079fc8fb3e45f520edf91a89264a7ce37b  Merge branch into tip/master: 'x86/sgx'

elapsed time: 1446m

configs tested: 218
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
arc                          axs101_defconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                        nsim_700_defconfig    gcc-15.1.0
arc                   randconfig-001-20251019    gcc-8.5.0
arc                   randconfig-002-20251019    gcc-13.4.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                   randconfig-001-20251019    clang-22
arm                   randconfig-002-20251019    gcc-11.5.0
arm                   randconfig-003-20251019    clang-22
arm                   randconfig-004-20251019    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20251019    gcc-13.4.0
arm64                 randconfig-002-20251019    clang-18
arm64                 randconfig-003-20251019    gcc-13.4.0
arm64                 randconfig-004-20251019    clang-22
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20251019    gcc-13.4.0
csky                  randconfig-002-20251019    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20251019    clang-20
hexagon               randconfig-002-20251019    clang-17
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251019    clang-20
i386        buildonly-randconfig-002-20251019    gcc-14
i386        buildonly-randconfig-003-20251019    gcc-14
i386        buildonly-randconfig-004-20251019    clang-20
i386        buildonly-randconfig-005-20251019    gcc-13
i386        buildonly-randconfig-006-20251019    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251019    clang-20
i386                  randconfig-002-20251019    clang-20
i386                  randconfig-003-20251019    clang-20
i386                  randconfig-004-20251019    clang-20
i386                  randconfig-005-20251019    clang-20
i386                  randconfig-006-20251019    clang-20
i386                  randconfig-007-20251019    clang-20
i386                  randconfig-011-20251019    gcc-14
i386                  randconfig-012-20251019    gcc-14
i386                  randconfig-013-20251019    gcc-14
i386                  randconfig-014-20251019    gcc-14
i386                  randconfig-015-20251019    gcc-14
i386                  randconfig-016-20251019    gcc-14
i386                  randconfig-017-20251019    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251019    clang-18
loongarch             randconfig-002-20251019    clang-22
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                         amcore_defconfig    gcc-15.1.0
m68k                         apollo_defconfig    gcc-15.1.0
m68k                          atari_defconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        bcm63xx_defconfig    clang-22
mips                           ip30_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20251019    gcc-8.5.0
nios2                 randconfig-002-20251019    gcc-11.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251019    gcc-15.1.0
parisc                randconfig-002-20251019    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                    amigaone_defconfig    gcc-15.1.0
powerpc                        fsp2_defconfig    gcc-15.1.0
powerpc                 mpc834x_itx_defconfig    clang-16
powerpc                  mpc866_ads_defconfig    clang-22
powerpc               randconfig-001-20251019    clang-17
powerpc               randconfig-002-20251019    gcc-10.5.0
powerpc               randconfig-003-20251019    gcc-11.5.0
powerpc                        warp_defconfig    gcc-15.1.0
powerpc64             randconfig-002-20251019    clang-16
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20251019    clang-19
riscv                 randconfig-001-20251019    gcc-11.5.0
riscv                 randconfig-002-20251019    gcc-11.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20251019    gcc-11.5.0
s390                  randconfig-001-20251019    gcc-8.5.0
s390                  randconfig-002-20251019    clang-22
s390                  randconfig-002-20251019    gcc-11.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                             espt_defconfig    gcc-15.1.0
sh                    randconfig-001-20251019    gcc-11.5.0
sh                    randconfig-001-20251019    gcc-15.1.0
sh                    randconfig-002-20251019    gcc-11.5.0
sh                    randconfig-002-20251019    gcc-15.1.0
sh                          sdk7786_defconfig    gcc-15.1.0
sparc                            alldefconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251019    gcc-11.5.0
sparc                 randconfig-002-20251019    gcc-11.5.0
sparc                 randconfig-002-20251019    gcc-13.4.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251019    gcc-11.5.0
sparc64               randconfig-001-20251019    gcc-8.5.0
sparc64               randconfig-002-20251019    gcc-11.5.0
sparc64               randconfig-002-20251019    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251019    gcc-11.5.0
um                    randconfig-001-20251019    gcc-13
um                    randconfig-002-20251019    clang-22
um                    randconfig-002-20251019    gcc-11.5.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251019    clang-20
x86_64      buildonly-randconfig-002-20251019    gcc-13
x86_64      buildonly-randconfig-003-20251019    clang-20
x86_64      buildonly-randconfig-004-20251019    gcc-14
x86_64      buildonly-randconfig-005-20251019    clang-20
x86_64      buildonly-randconfig-006-20251019    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251019    clang-20
x86_64                randconfig-002-20251019    clang-20
x86_64                randconfig-003-20251019    clang-20
x86_64                randconfig-004-20251019    clang-20
x86_64                randconfig-005-20251019    clang-20
x86_64                randconfig-006-20251019    clang-20
x86_64                randconfig-007-20251019    clang-20
x86_64                randconfig-008-20251019    clang-20
x86_64                randconfig-071-20251019    clang-20
x86_64                randconfig-072-20251019    clang-20
x86_64                randconfig-073-20251019    clang-20
x86_64                randconfig-074-20251019    clang-20
x86_64                randconfig-075-20251019    clang-20
x86_64                randconfig-076-20251019    clang-20
x86_64                randconfig-077-20251019    clang-20
x86_64                randconfig-078-20251019    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251019    gcc-11.5.0
xtensa                randconfig-001-20251019    gcc-14.3.0
xtensa                randconfig-002-20251019    gcc-11.5.0
xtensa                randconfig-002-20251019    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


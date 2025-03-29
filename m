Return-Path: <linux-kernel+bounces-580922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA070A75806
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Mar 2025 23:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EEE4169655
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Mar 2025 22:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770421E0DD9;
	Sat, 29 Mar 2025 22:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SN5ss+4m"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255F11DFDA5
	for <linux-kernel@vger.kernel.org>; Sat, 29 Mar 2025 22:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743288545; cv=none; b=bn7Lg8882pc8j4mB+Uk0V/XLfgfwm/6sWAFOtGu5JgMdhxLUCG5b82hFnnLJ1+buaH+gth+f8G1F6pA6Nx9AcVt0JeHnVNINUCSJOyZfn5IhKy2iEfbdP2KUxwKWgGTuEPU4/ZiIYFgTeeE0jboxKrylQuxKSo448bOU/gjRACQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743288545; c=relaxed/simple;
	bh=6QB0BO6vt+C6EQiMAGqDTKGuwcmVviIsWwa+wEqspho=;
	h=Date:From:To:Cc:Subject:Message-ID; b=uf6IJZZWRVC8IyNtZkERS3FRXsVaItxp1Je3rxysgXMF1FxyqjCxsBHb4VQ3qM2oZ72UV+PA5gNBarZgxm9fcqlCuGVCWLitq4aO8ed5HD1xX5DblMhZPxk7TM3CSxnU1HLQQg3KX82hiCujR6lppQ1V5Q3a5Z1dQtbA7+/pV8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SN5ss+4m; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743288544; x=1774824544;
  h=date:from:to:cc:subject:message-id;
  bh=6QB0BO6vt+C6EQiMAGqDTKGuwcmVviIsWwa+wEqspho=;
  b=SN5ss+4mq3eptVqiZ4K6t6xoYrcXERiqhG4heklNvpkWj6jtk7yW2eqq
   RcNICg4ra9aAKV9YhrZ66yUQWLr7463JWRmgP9DuJlGG/J4owuwoLpa0i
   s4jR0hILkDZXZuJaH/OOUNPQT1XJyr3hqrni2BAm/LLFUgGJzVkAHIPR8
   M1ajyb9cDqBnOzWxfBn5vb8HfGj9b7WUY2FUo4YpbkYBXMSXFly6kDEt6
   sF68n26l5pPjFWM8G0ATtK7F78aNvNLXNWQeFSrgHqHc07hZSZPEn1vJU
   K3D9zfcxtUvTEPR0kqmFKxVDSCKRCxwRWWksSjHWiCrfs632azM1v9I8d
   Q==;
X-CSE-ConnectionGUID: IRQNlWufS6KANlkyrPWQsA==
X-CSE-MsgGUID: zp5Vs0CoTIO20MUrt7ktRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11388"; a="44724158"
X-IronPort-AV: E=Sophos;i="6.14,286,1736841600"; 
   d="scan'208";a="44724158"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2025 15:49:04 -0700
X-CSE-ConnectionGUID: QH5g/RyOQ7W3GDbsrsDDBA==
X-CSE-MsgGUID: TAU4XuXTQ528ZpB1dYzXQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,286,1736841600"; 
   d="scan'208";a="148932783"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 29 Mar 2025 15:49:02 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tyez2-0008Pj-22;
	Sat, 29 Mar 2025 22:48:57 +0000
Date: Sun, 30 Mar 2025 06:48:27 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/asm] BUILD SUCCESS
 e29c5d0e5dc35ed8b8920b573925d8aa2f8bafb0
Message-ID: <202503300621.kC6k6XmJ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/asm
branch HEAD: e29c5d0e5dc35ed8b8920b573925d8aa2f8bafb0  x86/bitops: Simplify variable_ffz() as variable__ffs(~word)

elapsed time: 1442m

configs tested: 113
configs skipped: 128

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                                 defconfig    gcc-14.2.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                         axm55xx_defconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                          gemini_defconfig    gcc-14.2.0
arm                            mps2_defconfig    clang-21
arm                           spitz_defconfig    gcc-14.2.0
arm                         vf610m4_defconfig    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
hexagon                           allnoconfig    gcc-14.2.0
hexagon                             defconfig    gcc-14.2.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250329    gcc-12
i386        buildonly-randconfig-002-20250329    gcc-12
i386        buildonly-randconfig-003-20250329    clang-20
i386        buildonly-randconfig-004-20250329    gcc-11
i386        buildonly-randconfig-005-20250329    gcc-12
i386        buildonly-randconfig-006-20250329    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250330    clang-20
i386                  randconfig-002-20250330    clang-20
i386                  randconfig-003-20250330    clang-20
i386                  randconfig-004-20250330    clang-20
i386                  randconfig-005-20250330    clang-20
i386                  randconfig-006-20250330    clang-20
i386                  randconfig-007-20250330    clang-20
i386                  randconfig-011-20250330    clang-20
i386                  randconfig-012-20250330    clang-20
i386                  randconfig-013-20250330    clang-20
i386                  randconfig-014-20250330    clang-20
i386                  randconfig-015-20250330    clang-20
i386                  randconfig-016-20250330    clang-20
i386                  randconfig-017-20250330    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                       m5208evb_defconfig    gcc-14.2.0
m68k                        m5272c3_defconfig    clang-21
m68k                          multi_defconfig    gcc-14.2.0
m68k                            q40_defconfig    clang-21
microblaze                       allmodconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                          allyesconfig    gcc-14.2.0
powerpc                     asp8347_defconfig    gcc-14.2.0
powerpc                        fsp2_defconfig    clang-21
powerpc                      pmac32_defconfig    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
s390                                defconfig    gcc-12
sh                                  defconfig    gcc-12
sh                          lboxre2_defconfig    gcc-14.2.0
sh                   sh7770_generic_defconfig    clang-21
sparc64                             defconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250329    clang-20
x86_64      buildonly-randconfig-002-20250329    gcc-12
x86_64      buildonly-randconfig-003-20250329    gcc-12
x86_64      buildonly-randconfig-004-20250329    clang-20
x86_64      buildonly-randconfig-005-20250329    clang-20
x86_64      buildonly-randconfig-006-20250329    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250330    clang-20
x86_64                randconfig-002-20250330    clang-20
x86_64                randconfig-003-20250330    clang-20
x86_64                randconfig-004-20250330    clang-20
x86_64                randconfig-005-20250330    clang-20
x86_64                randconfig-006-20250330    clang-20
x86_64                randconfig-007-20250330    clang-20
x86_64                randconfig-008-20250330    clang-20
x86_64                randconfig-071-20250330    clang-20
x86_64                randconfig-072-20250330    clang-20
x86_64                randconfig-073-20250330    clang-20
x86_64                randconfig-074-20250330    clang-20
x86_64                randconfig-075-20250330    clang-20
x86_64                randconfig-076-20250330    clang-20
x86_64                randconfig-077-20250330    clang-20
x86_64                randconfig-078-20250330    clang-20
x86_64                               rhel-9.4    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


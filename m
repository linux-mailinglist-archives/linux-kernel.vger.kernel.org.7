Return-Path: <linux-kernel+bounces-737787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68180B0B094
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 17:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C88F3BE33B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 15:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AB52877E6;
	Sat, 19 Jul 2025 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LVahfT4h"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A824223322
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752938073; cv=none; b=DN8zLlxogQus6y13XQUMPQOh6CmYCcQg6Af16lmrrpHg5igX/cprahaU43kM5+jPPVp0eUbzikb2Mi6S4oZ7XKwoMZkn3IfM6tXyVfT1iz8gfpCPsIoWB9z7c/LVaSTYSHZrsO4U36nlWAwn7B+YlDPkAQv23AH90wteQGLBlMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752938073; c=relaxed/simple;
	bh=I+pgZ/SYgd1RCIVp+eBDS3uNDBFoktbHeLSAsllGJx8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Y9E9Depm0LsKzBt5H3VaEh0yWwFRurkapUOA/KdTQOqdkFpyuCHfRWVy4mHz6FuQnkpxt/ZaWxZHv1IUQbVyJs7lFtUEeUuzYU6JBhkCiW9HVdxXVgjOm+iT/iexwDpVz+imwY0L2PUZAHaVRnEzg6MDSB0SNmO2Vry7i2YDEgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LVahfT4h; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752938071; x=1784474071;
  h=date:from:to:cc:subject:message-id;
  bh=I+pgZ/SYgd1RCIVp+eBDS3uNDBFoktbHeLSAsllGJx8=;
  b=LVahfT4hKQ0VZ/NWOxnSD7gDxntQdl4t4V+DeF5tP28Z80bIQdHNaMQw
   C1KH8N+LtLIdmGijr1FU6g64O0zycNf0TmOUNU9KByccDnhEAs1B2WGkU
   USIB2KaOx3knkzH4ev7MGt3+UFXFUpvw+f9PHszCd24LtGtlI7vXYje9q
   OyAJg1wNmvSXXOW/nr33J1CrJJBYkpwS+6toYa6Lh+jfqmQ8sIhn91ghc
   9vEwtdn0MvcYsQ7Gw4kD6xWKKHNfh06cXkAotrcUD6eSvLmgrgwZqYWoy
   SJsVMo1dxw+EEcKRaBvA0njaGiPmG0HhIL1MKDJYOUcKy+RaKUOu/Adht
   Q==;
X-CSE-ConnectionGUID: oVen7H2UTpKAKAHjutmpeQ==
X-CSE-MsgGUID: W0GLzHm3Rm+7JMHZhT9QYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11497"; a="65901558"
X-IronPort-AV: E=Sophos;i="6.16,324,1744095600"; 
   d="scan'208";a="65901558"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2025 08:14:31 -0700
X-CSE-ConnectionGUID: LMP96vH+T1yPBrjWxAWXTA==
X-CSE-MsgGUID: +ZMH91ZVSpaI8XtaHf2Pmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,324,1744095600"; 
   d="scan'208";a="162490766"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 19 Jul 2025 08:14:30 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ud9Gd-000FZd-2w;
	Sat, 19 Jul 2025 15:14:27 +0000
Date: Sat, 19 Jul 2025 23:13:43 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/drivers] BUILD SUCCESS
 2aad477b5b734f52825f7c31780222a5a17c06d3
Message-ID: <202507192331.9UNQDkpI-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/drivers
branch HEAD: 2aad477b5b734f52825f7c31780222a5a17c06d3  irqchip/renesas-irqc: Convert to DEFINE_SIMPLE_DEV_PM_OPS()

elapsed time: 1418m

configs tested: 230
configs skipped: 5

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
arc                   randconfig-001-20250719    clang-20
arc                   randconfig-001-20250719    gcc-14.3.0
arc                   randconfig-002-20250719    clang-20
arc                   randconfig-002-20250719    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                       omap2plus_defconfig    gcc-15.1.0
arm                   randconfig-001-20250719    clang-20
arm                   randconfig-001-20250719    gcc-14.3.0
arm                   randconfig-002-20250719    clang-20
arm                   randconfig-002-20250719    clang-21
arm                   randconfig-003-20250719    clang-20
arm                   randconfig-003-20250719    clang-21
arm                   randconfig-004-20250719    clang-16
arm                   randconfig-004-20250719    clang-20
arm                        spear6xx_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-21
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250719    clang-20
arm64                 randconfig-002-20250719    clang-18
arm64                 randconfig-002-20250719    clang-20
arm64                 randconfig-003-20250719    clang-20
arm64                 randconfig-003-20250719    gcc-15.1.0
arm64                 randconfig-004-20250719    clang-20
csky                              allnoconfig    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250719    gcc-11.5.0
csky                  randconfig-001-20250719    gcc-15.1.0
csky                  randconfig-002-20250719    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250719    clang-21
hexagon               randconfig-001-20250719    gcc-11.5.0
hexagon               randconfig-002-20250719    clang-21
hexagon               randconfig-002-20250719    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250719    clang-20
i386        buildonly-randconfig-002-20250719    gcc-12
i386        buildonly-randconfig-003-20250719    gcc-12
i386        buildonly-randconfig-004-20250719    clang-20
i386        buildonly-randconfig-005-20250719    clang-20
i386        buildonly-randconfig-006-20250719    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250719    clang-20
i386                  randconfig-002-20250719    clang-20
i386                  randconfig-003-20250719    clang-20
i386                  randconfig-004-20250719    clang-20
i386                  randconfig-005-20250719    clang-20
i386                  randconfig-006-20250719    clang-20
i386                  randconfig-007-20250719    clang-20
i386                  randconfig-011-20250719    clang-20
i386                  randconfig-012-20250719    clang-20
i386                  randconfig-013-20250719    clang-20
i386                  randconfig-014-20250719    clang-20
i386                  randconfig-015-20250719    clang-20
i386                  randconfig-016-20250719    clang-20
i386                  randconfig-017-20250719    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250719    clang-18
loongarch             randconfig-001-20250719    gcc-11.5.0
loongarch             randconfig-002-20250719    gcc-11.5.0
loongarch             randconfig-002-20250719    gcc-15.1.0
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
mips                           ip32_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250719    gcc-11.5.0
nios2                 randconfig-002-20250719    gcc-11.5.0
nios2                 randconfig-002-20250719    gcc-8.5.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
openrisc                 simple_smp_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250719    gcc-11.5.0
parisc                randconfig-001-20250719    gcc-8.5.0
parisc                randconfig-002-20250719    gcc-11.5.0
parisc                randconfig-002-20250719    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-15.1.0
powerpc               randconfig-001-20250719    clang-19
powerpc               randconfig-001-20250719    gcc-11.5.0
powerpc               randconfig-002-20250719    gcc-10.5.0
powerpc               randconfig-002-20250719    gcc-11.5.0
powerpc               randconfig-003-20250719    gcc-11.5.0
powerpc               randconfig-003-20250719    gcc-12.5.0
powerpc                        warp_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250719    gcc-11.5.0
powerpc64             randconfig-001-20250719    gcc-8.5.0
powerpc64             randconfig-002-20250719    clang-21
powerpc64             randconfig-002-20250719    gcc-11.5.0
powerpc64             randconfig-003-20250719    gcc-10.5.0
powerpc64             randconfig-003-20250719    gcc-11.5.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250719    clang-21
riscv                 randconfig-001-20250719    gcc-13.4.0
riscv                 randconfig-002-20250719    clang-21
riscv                 randconfig-002-20250719    gcc-13.4.0
s390                             alldefconfig    gcc-15.1.0
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250719    gcc-13.4.0
s390                  randconfig-001-20250719    gcc-9.5.0
s390                  randconfig-002-20250719    gcc-13.4.0
s390                  randconfig-002-20250719    gcc-9.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                        edosk7705_defconfig    gcc-15.1.0
sh                             espt_defconfig    gcc-15.1.0
sh                    randconfig-001-20250719    gcc-13.4.0
sh                    randconfig-002-20250719    gcc-13.4.0
sh                    randconfig-002-20250719    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250719    gcc-13.4.0
sparc                 randconfig-001-20250719    gcc-15.1.0
sparc                 randconfig-002-20250719    gcc-13.4.0
sparc                 randconfig-002-20250719    gcc-15.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250719    gcc-13.4.0
sparc64               randconfig-001-20250719    gcc-9.5.0
sparc64               randconfig-002-20250719    gcc-13.4.0
sparc64               randconfig-002-20250719    gcc-9.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250719    clang-16
um                    randconfig-001-20250719    gcc-13.4.0
um                    randconfig-002-20250719    clang-21
um                    randconfig-002-20250719    gcc-13.4.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250719    clang-20
x86_64      buildonly-randconfig-002-20250719    clang-20
x86_64      buildonly-randconfig-003-20250719    clang-20
x86_64      buildonly-randconfig-004-20250719    clang-20
x86_64      buildonly-randconfig-004-20250719    gcc-12
x86_64      buildonly-randconfig-005-20250719    clang-20
x86_64      buildonly-randconfig-006-20250719    clang-20
x86_64      buildonly-randconfig-006-20250719    gcc-12
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250719    gcc-11
x86_64                randconfig-002-20250719    gcc-11
x86_64                randconfig-003-20250719    gcc-11
x86_64                randconfig-004-20250719    gcc-11
x86_64                randconfig-005-20250719    gcc-11
x86_64                randconfig-006-20250719    gcc-11
x86_64                randconfig-007-20250719    gcc-11
x86_64                randconfig-008-20250719    gcc-11
x86_64                randconfig-071-20250719    clang-20
x86_64                randconfig-072-20250719    clang-20
x86_64                randconfig-073-20250719    clang-20
x86_64                randconfig-074-20250719    clang-20
x86_64                randconfig-075-20250719    clang-20
x86_64                randconfig-076-20250719    clang-20
x86_64                randconfig-077-20250719    clang-20
x86_64                randconfig-078-20250719    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250719    gcc-13.4.0
xtensa                randconfig-001-20250719    gcc-14.3.0
xtensa                randconfig-002-20250719    gcc-13.4.0
xtensa                randconfig-002-20250719    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


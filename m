Return-Path: <linux-kernel+bounces-807412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7F6B4A416
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DF4D1899876
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7237D307AE8;
	Tue,  9 Sep 2025 07:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TnXtAsuK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB743081C3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 07:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757403692; cv=none; b=CRLlMIMKlTpt3t81PdpAGYODRSjycs/R6bPYx+JpYt9nkKRpn1TrU+28E6SjZgVlHfVMvLbALR3suI8qom5oOkM3Hnw7AMNWOSEMOsFlZRQI07c1RKcuqIuB5otwTYLVBbXG9m1anBxcWrZ/BSgqmrxiblL0iy51atCz9TXoYDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757403692; c=relaxed/simple;
	bh=jUBqF5cQZe/7hAM8LptJ4tcUwMVoJTiu7M8MfKFYL94=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LXFm4BE5qkyp7SjcF7KIxT1FEdYjAzBVM/2W6e4y5oUC9XJvXJDoMWiQCsB2OMOq+QRTwOXN0fayeVf25TO25FhMPqid8ZV6ZH2X5R+WSoPm8cqhmU35VEI5ZrP8VNCffBbUZw9o2hftKPp5sCPJj/65PAFh2gQ6Iwz5UWM7gkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TnXtAsuK; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757403691; x=1788939691;
  h=date:from:to:cc:subject:message-id;
  bh=jUBqF5cQZe/7hAM8LptJ4tcUwMVoJTiu7M8MfKFYL94=;
  b=TnXtAsuKy6DT+bK+YsPch/H9B55KuAXwY7Bag/UktaUZU4feEjNENi1S
   g56c0JZBUvM+TiOpoHglEd0P6fjwUcprVS+EV/EmXqmrILE+bpqIfFQn3
   6gfn2P9/HAaviFxKm4PvDRABwEaf5eaunq5rn3fosd8EHvWF9CwNTXt6W
   PScb06JbTsJys7XjjR0B4HRncji9CygiOAqs/dz/8boMozuJg1NZX/Img
   jdbWzyhpX6Vfa4W6Ho/J/TSpvO3GRD+YuL4flCXXrPgqR+tHI2+smuzII
   zKflBblcyzRa1lViPYJeeIjWQaiN3PnzRZRsq2BAa+1064tMZ8CqwAdUf
   w==;
X-CSE-ConnectionGUID: tYh0xbOsS7WBG6LUk4RHdQ==
X-CSE-MsgGUID: hhgTV4OtTTCU2A2bPGqvfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="59613658"
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="59613658"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 00:41:28 -0700
X-CSE-ConnectionGUID: 3PNLGZuCQCCjTuezYc5oJQ==
X-CSE-MsgGUID: 0CgCeRCdTtWI1AjqAOWpDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="172888165"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 09 Sep 2025 00:41:26 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uvsyi-0004bD-12;
	Tue, 09 Sep 2025 07:41:24 +0000
Date: Tue, 09 Sep 2025 15:40:36 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 c6c973dbfa5e34b1572bcd1852adcad1b5d08fab
Message-ID: <202509091525.tCn5Tfkq-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: c6c973dbfa5e34b1572bcd1852adcad1b5d08fab  x86/asm: Remove code depending on __GCC_ASM_FLAG_OUTPUTS__

elapsed time: 1028m

configs tested: 231
configs skipped: 6

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
arc                   randconfig-001-20250909    clang-16
arc                   randconfig-001-20250909    gcc-8.5.0
arc                   randconfig-002-20250909    clang-16
arc                   randconfig-002-20250909    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                        multi_v7_defconfig    clang-22
arm                             mxs_defconfig    clang-22
arm                       netwinder_defconfig    clang-22
arm                   randconfig-001-20250909    clang-16
arm                   randconfig-001-20250909    clang-18
arm                   randconfig-002-20250909    clang-16
arm                   randconfig-002-20250909    clang-17
arm                   randconfig-003-20250909    clang-16
arm                   randconfig-003-20250909    clang-22
arm                   randconfig-004-20250909    clang-16
arm                   randconfig-004-20250909    clang-19
arm                       versatile_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250909    clang-16
arm64                 randconfig-002-20250909    clang-16
arm64                 randconfig-002-20250909    gcc-11.5.0
arm64                 randconfig-003-20250909    clang-16
arm64                 randconfig-003-20250909    gcc-11.5.0
arm64                 randconfig-004-20250909    clang-16
arm64                 randconfig-004-20250909    clang-22
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250909    gcc-15.1.0
csky                  randconfig-001-20250909    gcc-8.5.0
csky                  randconfig-002-20250909    gcc-15.1.0
csky                  randconfig-002-20250909    gcc-8.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250909    clang-22
hexagon               randconfig-001-20250909    gcc-8.5.0
hexagon               randconfig-002-20250909    clang-22
hexagon               randconfig-002-20250909    gcc-8.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250909    clang-20
i386        buildonly-randconfig-001-20250909    gcc-13
i386        buildonly-randconfig-002-20250909    clang-20
i386        buildonly-randconfig-003-20250909    clang-20
i386        buildonly-randconfig-004-20250909    clang-20
i386        buildonly-randconfig-005-20250909    clang-20
i386        buildonly-randconfig-006-20250909    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250909    clang-20
i386                  randconfig-002-20250909    clang-20
i386                  randconfig-003-20250909    clang-20
i386                  randconfig-004-20250909    clang-20
i386                  randconfig-005-20250909    clang-20
i386                  randconfig-006-20250909    clang-20
i386                  randconfig-007-20250909    clang-20
i386                  randconfig-011-20250909    gcc-14
i386                  randconfig-012-20250909    gcc-14
i386                  randconfig-013-20250909    gcc-14
i386                  randconfig-014-20250909    gcc-14
i386                  randconfig-015-20250909    gcc-14
i386                  randconfig-016-20250909    gcc-14
i386                  randconfig-017-20250909    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250909    gcc-15.1.0
loongarch             randconfig-001-20250909    gcc-8.5.0
loongarch             randconfig-002-20250909    gcc-15.1.0
loongarch             randconfig-002-20250909    gcc-8.5.0
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
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250909    gcc-11.5.0
nios2                 randconfig-001-20250909    gcc-8.5.0
nios2                 randconfig-002-20250909    gcc-8.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250909    gcc-8.5.0
parisc                randconfig-002-20250909    gcc-12.5.0
parisc                randconfig-002-20250909    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                  mpc885_ads_defconfig    clang-22
powerpc                      pasemi_defconfig    clang-22
powerpc               randconfig-001-20250909    clang-22
powerpc               randconfig-001-20250909    gcc-8.5.0
powerpc               randconfig-002-20250909    clang-17
powerpc               randconfig-002-20250909    gcc-8.5.0
powerpc               randconfig-003-20250909    gcc-8.5.0
powerpc64             randconfig-001-20250909    clang-20
powerpc64             randconfig-001-20250909    gcc-8.5.0
powerpc64             randconfig-002-20250909    gcc-10.5.0
powerpc64             randconfig-002-20250909    gcc-8.5.0
powerpc64             randconfig-003-20250909    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20250909    clang-22
riscv                 randconfig-001-20250909    gcc-15.1.0
riscv                 randconfig-002-20250909    clang-22
riscv                 randconfig-002-20250909    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20250909    gcc-11.5.0
s390                  randconfig-001-20250909    gcc-15.1.0
s390                  randconfig-002-20250909    clang-18
s390                  randconfig-002-20250909    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20250909    gcc-15.1.0
sh                    randconfig-002-20250909    gcc-15.1.0
sh                    randconfig-002-20250909    gcc-9.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250909    gcc-15.1.0
sparc                 randconfig-001-20250909    gcc-8.5.0
sparc                 randconfig-002-20250909    gcc-15.1.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20250909    clang-22
sparc64               randconfig-001-20250909    gcc-15.1.0
sparc64               randconfig-002-20250909    gcc-15.1.0
sparc64               randconfig-002-20250909    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250909    gcc-14
um                    randconfig-001-20250909    gcc-15.1.0
um                    randconfig-002-20250909    gcc-14
um                    randconfig-002-20250909    gcc-15.1.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250908    clang-20
x86_64      buildonly-randconfig-001-20250909    gcc-14
x86_64      buildonly-randconfig-002-20250908    gcc-14
x86_64      buildonly-randconfig-002-20250909    gcc-14
x86_64      buildonly-randconfig-003-20250908    gcc-14
x86_64      buildonly-randconfig-003-20250909    gcc-14
x86_64      buildonly-randconfig-004-20250908    gcc-14
x86_64      buildonly-randconfig-004-20250909    gcc-14
x86_64      buildonly-randconfig-005-20250908    gcc-14
x86_64      buildonly-randconfig-005-20250909    gcc-14
x86_64      buildonly-randconfig-006-20250908    clang-20
x86_64      buildonly-randconfig-006-20250909    gcc-14
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250909    gcc-14
x86_64                randconfig-002-20250909    gcc-14
x86_64                randconfig-003-20250909    gcc-14
x86_64                randconfig-004-20250909    gcc-14
x86_64                randconfig-005-20250909    gcc-14
x86_64                randconfig-006-20250909    gcc-14
x86_64                randconfig-007-20250909    gcc-14
x86_64                randconfig-008-20250909    gcc-14
x86_64                randconfig-071-20250909    gcc-14
x86_64                randconfig-072-20250909    gcc-14
x86_64                randconfig-073-20250909    gcc-14
x86_64                randconfig-074-20250909    gcc-14
x86_64                randconfig-075-20250909    gcc-14
x86_64                randconfig-076-20250909    gcc-14
x86_64                randconfig-077-20250909    gcc-14
x86_64                randconfig-078-20250909    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250909    gcc-15.1.0
xtensa                randconfig-001-20250909    gcc-8.5.0
xtensa                randconfig-002-20250909    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


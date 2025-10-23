Return-Path: <linux-kernel+bounces-866247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6C3BFF4BB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 210BD4EC562
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 06:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7852F15687D;
	Thu, 23 Oct 2025 06:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E1L5jPIJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF12B254876
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761199507; cv=none; b=Al/i0YuDFP28jl1NZyd0oXSI3l+K4RKpB2yMS6JgoFwX4imT9XMo5+jYnjrGd/YZ3dGcP4+ftJhWak08Pk/k6qg6uL3fPIrEcuBtCHdFnHhluxB4MI2Kmwj1cwV0Gh/DAz+tk5T9al2YiDTLmytYRPdcjCYOnYWo0YWlP3ke2JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761199507; c=relaxed/simple;
	bh=UnpLwOE5gCNwosowdJqYQIYnBZYq6SrujnLwWKYrtIs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ivGPfSy3v2uyhV0LBASX6CJhjkK5c5PEcTf+c/uXnvXt5wjNDXL+mHJ+k8shXP5GMk5b4TaUNvTgQI/LpdM7BE978CgYX+op5++JGYeHzGpcEGy9kE5De8sp+H/s3F2pCdUlhhYS3W2JI5ohZYyb31se5kXvoGn8rQh5d5yURes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E1L5jPIJ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761199506; x=1792735506;
  h=date:from:to:cc:subject:message-id;
  bh=UnpLwOE5gCNwosowdJqYQIYnBZYq6SrujnLwWKYrtIs=;
  b=E1L5jPIJtotWrX00blTpoMgRQ1DNZsIDZ+qIEMcqdOOH6BmpGvYYwOlB
   a5u9LWqagHMX7yZ1/94XQXXFnROLPZaWenrh3LVDuhXgpjzTbp/B2ZCfd
   3+s6IlK5ZMEoptKdIRf3fDUudsGpt5cztE447Xr89PHB2FlclTsAK1DGo
   kgLpuBwnk3PMp78cVTf5pfuxIIdIKgHinF4OmsfAU/ob6pbtiDwXEdp+N
   PLnkNxIkeGMT+ZiJOKRCTAHHMFtbGGVuqBw+3yhE5X4rofu75AhrrBxO+
   NiTsLH2yEf9U6KtrSqC6zpxWCSu1vU/JdhfkMgCFtAVarboB2CLq34Uzd
   Q==;
X-CSE-ConnectionGUID: NUTN4u8DQySBp3LdoZHDwQ==
X-CSE-MsgGUID: 8wwgWnP3Qx6FA3qp8ZEI2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62388858"
X-IronPort-AV: E=Sophos;i="6.19,248,1754982000"; 
   d="scan'208";a="62388858"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 23:05:04 -0700
X-CSE-ConnectionGUID: 1n44s94KQECalwGLkY1fGw==
X-CSE-MsgGUID: by+3pO+PSvS0aSJIYGKKfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,248,1754982000"; 
   d="scan'208";a="184548720"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 22 Oct 2025 23:05:03 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vBoRY-000D5X-2E;
	Thu, 23 Oct 2025 06:05:00 +0000
Date: Thu, 23 Oct 2025 14:04:14 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:objtool/urgent] BUILD SUCCESS
 49c98f30f4021b560676a336f8a46a4f642eee2b
Message-ID: <202510231408.HpeDcQlA-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool/urgent
branch HEAD: 49c98f30f4021b560676a336f8a46a4f642eee2b  objtool: Fix failure when being compiled on x32 system

elapsed time: 998m

configs tested: 222
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-22
arc                              allyesconfig    clang-19
arc                                 defconfig    clang-19
arc                   randconfig-001-20251022    gcc-13.4.0
arc                   randconfig-001-20251023    gcc-8.5.0
arc                   randconfig-002-20251022    gcc-8.5.0
arc                   randconfig-002-20251023    gcc-8.5.0
arm                              alldefconfig    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                          gemini_defconfig    gcc-15.1.0
arm                           h3600_defconfig    clang-22
arm                           h3600_defconfig    gcc-15.1.0
arm                        multi_v7_defconfig    gcc-15.1.0
arm                   randconfig-001-20251022    gcc-11.5.0
arm                   randconfig-001-20251023    gcc-8.5.0
arm                   randconfig-002-20251022    gcc-10.5.0
arm                   randconfig-002-20251023    gcc-8.5.0
arm                   randconfig-003-20251022    gcc-10.5.0
arm                   randconfig-003-20251023    gcc-8.5.0
arm                   randconfig-004-20251022    clang-22
arm                   randconfig-004-20251023    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                               defconfig    clang-19
arm64                 randconfig-001-20251022    gcc-9.5.0
arm64                 randconfig-001-20251023    gcc-8.5.0
arm64                 randconfig-002-20251022    clang-18
arm64                 randconfig-002-20251023    gcc-8.5.0
arm64                 randconfig-003-20251022    gcc-10.5.0
arm64                 randconfig-003-20251023    gcc-8.5.0
arm64                 randconfig-004-20251022    gcc-12.5.0
arm64                 randconfig-004-20251023    gcc-8.5.0
csky                              allnoconfig    clang-22
csky                                defconfig    clang-19
csky                  randconfig-001-20251022    gcc-15.1.0
csky                  randconfig-001-20251023    gcc-10.5.0
csky                  randconfig-002-20251022    gcc-11.5.0
csky                  randconfig-002-20251023    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20251022    clang-22
hexagon               randconfig-001-20251023    gcc-10.5.0
hexagon               randconfig-002-20251022    clang-22
hexagon               randconfig-002-20251023    gcc-10.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20251022    clang-20
i386        buildonly-randconfig-001-20251023    clang-20
i386        buildonly-randconfig-002-20251022    clang-20
i386        buildonly-randconfig-002-20251023    clang-20
i386        buildonly-randconfig-003-20251022    gcc-14
i386        buildonly-randconfig-003-20251023    clang-20
i386        buildonly-randconfig-004-20251022    clang-20
i386        buildonly-randconfig-004-20251023    clang-20
i386        buildonly-randconfig-005-20251022    gcc-12
i386        buildonly-randconfig-005-20251023    clang-20
i386        buildonly-randconfig-006-20251022    gcc-14
i386        buildonly-randconfig-006-20251023    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20251023    clang-20
i386                  randconfig-002-20251023    clang-20
i386                  randconfig-003-20251023    clang-20
i386                  randconfig-004-20251023    clang-20
i386                  randconfig-005-20251023    clang-20
i386                  randconfig-006-20251023    clang-20
i386                  randconfig-007-20251023    clang-20
i386                  randconfig-011-20251023    gcc-14
i386                  randconfig-012-20251023    gcc-14
i386                  randconfig-013-20251023    gcc-14
i386                  randconfig-014-20251023    gcc-14
i386                  randconfig-015-20251023    gcc-14
i386                  randconfig-016-20251023    gcc-14
i386                  randconfig-017-20251023    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251022    gcc-12.5.0
loongarch             randconfig-001-20251023    gcc-10.5.0
loongarch             randconfig-002-20251022    gcc-15.1.0
loongarch             randconfig-002-20251023    gcc-10.5.0
m68k                             allmodconfig    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                         amcore_defconfig    clang-22
m68k                                defconfig    clang-19
m68k                        stmark2_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          eyeq5_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20251022    gcc-8.5.0
nios2                 randconfig-001-20251023    gcc-10.5.0
nios2                 randconfig-002-20251022    gcc-10.5.0
nios2                 randconfig-002-20251023    gcc-10.5.0
openrisc                          allnoconfig    clang-22
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251022    gcc-13.4.0
parisc                randconfig-001-20251023    gcc-10.5.0
parisc                randconfig-002-20251022    gcc-10.5.0
parisc                randconfig-002-20251023    gcc-10.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                     asp8347_defconfig    clang-22
powerpc                     ep8248e_defconfig    clang-22
powerpc               randconfig-001-20251022    gcc-8.5.0
powerpc               randconfig-001-20251023    gcc-10.5.0
powerpc               randconfig-002-20251022    gcc-8.5.0
powerpc               randconfig-002-20251023    gcc-10.5.0
powerpc               randconfig-003-20251022    gcc-8.5.0
powerpc               randconfig-003-20251023    gcc-10.5.0
powerpc                 xes_mpc85xx_defconfig    clang-22
powerpc64             randconfig-001-20251022    gcc-8.5.0
powerpc64             randconfig-001-20251023    gcc-10.5.0
powerpc64             randconfig-002-20251022    gcc-8.5.0
powerpc64             randconfig-002-20251023    gcc-10.5.0
powerpc64             randconfig-003-20251022    clang-22
powerpc64             randconfig-003-20251023    gcc-10.5.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20251023    gcc-8.5.0
riscv                 randconfig-002-20251023    gcc-8.5.0
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20251023    gcc-8.5.0
s390                  randconfig-002-20251023    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                             espt_defconfig    gcc-15.1.0
sh                     magicpanelr2_defconfig    clang-22
sh                            migor_defconfig    clang-22
sh                    randconfig-001-20251023    gcc-8.5.0
sh                    randconfig-002-20251023    gcc-8.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251023    gcc-8.5.0
sparc                 randconfig-002-20251023    gcc-8.5.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251023    gcc-8.5.0
sparc64               randconfig-002-20251023    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251023    gcc-8.5.0
um                    randconfig-002-20251023    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251022    clang-20
x86_64      buildonly-randconfig-001-20251023    gcc-14
x86_64      buildonly-randconfig-002-20251022    gcc-14
x86_64      buildonly-randconfig-002-20251023    gcc-14
x86_64      buildonly-randconfig-003-20251022    gcc-14
x86_64      buildonly-randconfig-003-20251023    gcc-14
x86_64      buildonly-randconfig-004-20251022    clang-20
x86_64      buildonly-randconfig-004-20251023    gcc-14
x86_64      buildonly-randconfig-005-20251022    gcc-14
x86_64      buildonly-randconfig-005-20251023    gcc-14
x86_64      buildonly-randconfig-006-20251022    gcc-14
x86_64      buildonly-randconfig-006-20251023    gcc-14
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251023    clang-20
x86_64                randconfig-002-20251023    clang-20
x86_64                randconfig-003-20251023    clang-20
x86_64                randconfig-004-20251023    clang-20
x86_64                randconfig-005-20251023    clang-20
x86_64                randconfig-006-20251023    clang-20
x86_64                randconfig-007-20251023    clang-20
x86_64                randconfig-008-20251023    clang-20
x86_64                randconfig-071-20251023    clang-20
x86_64                randconfig-072-20251023    clang-20
x86_64                randconfig-073-20251023    clang-20
x86_64                randconfig-074-20251023    clang-20
x86_64                randconfig-075-20251023    clang-20
x86_64                randconfig-076-20251023    clang-20
x86_64                randconfig-077-20251023    clang-20
x86_64                randconfig-078-20251023    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                  audio_kc705_defconfig    clang-22
xtensa                randconfig-001-20251023    gcc-8.5.0
xtensa                randconfig-002-20251023    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-kernel+bounces-880496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DF9C25E3D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AE3C461C42
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5675F2E1726;
	Fri, 31 Oct 2025 15:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EapjZcLT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B102E0418
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 15:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761925523; cv=none; b=TCg2J0AzgIYX9fcOgg2pPVm72k05eoycScSZL6BcgkDKXK8b9r2nJRGPDTv8d6JIU7ohc6xc1uh8z5mBrYDAtS7x/4ehtGENHZ77vs4Ubor5rlou4rcTcHWLvNOZjsutoy+ICXXZhnNHILrKIrfVMl6cDRSeaLU9YBf6mbvJxvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761925523; c=relaxed/simple;
	bh=wfzmU+lm5brudBQnnCmFkT5DSqW0qhWfji1dJIvs9Eo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WrQXi+WLOPcOicMgYXzHnqfYoCUWprPtxwkb8QhoScDFVF5vXSZpxB1yx3q0hwanJoLxeNjx9nwIN2bIgWKt8VhDBcRzOIRUcbKr461cABH+G+saH+Bf39+qRqDQDs/HXQyR7xPZA2inTZmMNEPpt9lbEs/pYEeI1a8E6d0sg+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EapjZcLT; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761925522; x=1793461522;
  h=date:from:to:cc:subject:message-id;
  bh=wfzmU+lm5brudBQnnCmFkT5DSqW0qhWfji1dJIvs9Eo=;
  b=EapjZcLT9fU7eMYpuoRvGRj+ZjogUHO88doXkZ1G/TSKyeyvpq2AATya
   NSXP485wfCt3GeybdO9oRRFOlrfKWJLtusaaZGURHVvGsdgMrfSGc4LR3
   uwhyHW4KH61O2qOFEeMXUnN4hGOO20VGijeJGLvXrLf5JOEjaj/V+/qyA
   Y0RsjFKzgCVo3nilP+iVzD0Yj85LoSbTCs4wNNGfVplhbGiNebbk0qyMR
   VzmqpGXIYVp9bB1FyJaA+q+/g35FG6+Nb4VEdcQ7czpUT6YxB4FsGmMVV
   DgYZu0hAPkcG/4aJwHITHPL1XRnySMVRcnpS13fF2B843am8YcCF7PQef
   Q==;
X-CSE-ConnectionGUID: WSEupAClQaaflLkvMFb1zg==
X-CSE-MsgGUID: deTKMj/LS6yDBOlJsNsplg==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="51660656"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="51660656"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 08:45:21 -0700
X-CSE-ConnectionGUID: BZh5U5AJTTyeQfb9SmoSiA==
X-CSE-MsgGUID: ExrZt8WaTBGll8wH+wPsNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="186382694"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 31 Oct 2025 08:45:20 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vErJV-000NNI-1r;
	Fri, 31 Oct 2025 15:45:17 +0000
Date: Fri, 31 Oct 2025 23:44:29 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/microcode] BUILD SUCCESS
 ca8313fd83399ea1d18e695c2ae9b259985c9e1f
Message-ID: <202510312324.ZcLxtzrI-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/microcode
branch HEAD: ca8313fd83399ea1d18e695c2ae9b259985c9e1f  x86/microcode: Mark early_parse_cmdline() as __init

elapsed time: 1121m

configs tested: 158
configs skipped: 121

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig    clang-19
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                              allyesconfig    clang-19
arc                                 defconfig    gcc-15.1.0
arc                            hsdk_defconfig    gcc-15.1.0
arc                   randconfig-001-20251031    gcc-8.5.0
arc                   randconfig-002-20251031    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                              allyesconfig    clang-19
arm                                 defconfig    gcc-15.1.0
arm                            dove_defconfig    gcc-15.1.0
arm                      jornada720_defconfig    clang-22
arm                   randconfig-001-20251031    gcc-8.5.0
arm                   randconfig-002-20251031    gcc-8.5.0
arm                   randconfig-003-20251031    gcc-8.5.0
arm                   randconfig-004-20251031    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251031    gcc-10.5.0
arm64                 randconfig-002-20251031    gcc-10.5.0
arm64                 randconfig-003-20251031    gcc-10.5.0
arm64                 randconfig-004-20251031    gcc-10.5.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251031    gcc-10.5.0
csky                  randconfig-002-20251031    gcc-10.5.0
hexagon                          allmodconfig    clang-19
hexagon                          allyesconfig    clang-19
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20251031    clang-22
hexagon               randconfig-002-20251031    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20251031    clang-20
i386        buildonly-randconfig-002-20251031    clang-20
i386        buildonly-randconfig-003-20251031    clang-20
i386        buildonly-randconfig-004-20251031    clang-20
i386        buildonly-randconfig-005-20251031    clang-20
i386        buildonly-randconfig-006-20251031    clang-20
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20251031    clang-20
i386                  randconfig-002-20251031    clang-20
i386                  randconfig-003-20251031    clang-20
i386                  randconfig-004-20251031    clang-20
i386                  randconfig-005-20251031    clang-20
i386                  randconfig-006-20251031    clang-20
i386                  randconfig-007-20251031    clang-20
i386                  randconfig-011-20251031    gcc-13
i386                  randconfig-012-20251031    gcc-13
i386                  randconfig-013-20251031    gcc-13
i386                  randconfig-014-20251031    gcc-13
i386                  randconfig-015-20251031    gcc-13
i386                  randconfig-016-20251031    gcc-13
i386                  randconfig-017-20251031    gcc-13
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251031    clang-22
loongarch             randconfig-002-20251031    clang-22
m68k                       bvme6000_defconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                       m5208evb_defconfig    clang-22
microblaze                          defconfig    clang-19
mips                         bigsur_defconfig    gcc-15.1.0
nios2                            allmodconfig    clang-22
nios2                            allyesconfig    clang-22
nios2                               defconfig    clang-19
nios2                 randconfig-001-20251031    clang-22
nios2                 randconfig-002-20251031    clang-22
openrisc                         allmodconfig    clang-22
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251031    clang-22
parisc                randconfig-002-20251031    clang-22
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                   lite5200b_defconfig    clang-22
powerpc                     mpc512x_defconfig    gcc-15.1.0
powerpc                     mpc5200_defconfig    clang-22
powerpc                      ppc6xx_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251031    clang-22
powerpc               randconfig-002-20251031    clang-22
powerpc                     taishan_defconfig    gcc-15.1.0
powerpc                     tqm8560_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251031    clang-22
powerpc64             randconfig-002-20251031    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-15.1.0
riscv                 randconfig-001-20251031    clang-17
riscv                 randconfig-002-20251031    clang-17
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20251031    clang-17
s390                  randconfig-002-20251031    clang-17
sh                                  defconfig    gcc-14
sh                    randconfig-001-20251031    clang-17
sh                    randconfig-002-20251031    clang-17
sh                           se7705_defconfig    clang-22
sh                           se7750_defconfig    clang-22
sh                            titan_defconfig    clang-22
sparc                            allyesconfig    clang-22
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251031    gcc-8.5.0
sparc                 randconfig-002-20251031    gcc-8.5.0
sparc64                          allmodconfig    clang-22
sparc64                          allyesconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251031    gcc-8.5.0
sparc64               randconfig-002-20251031    gcc-8.5.0
um                               allmodconfig    clang-19
um                               allyesconfig    clang-19
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251031    gcc-8.5.0
um                    randconfig-002-20251031    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251031    gcc-14
x86_64      buildonly-randconfig-002-20251031    gcc-14
x86_64      buildonly-randconfig-003-20251031    gcc-14
x86_64      buildonly-randconfig-004-20251031    gcc-14
x86_64      buildonly-randconfig-005-20251031    gcc-14
x86_64      buildonly-randconfig-006-20251031    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251031    gcc-14
x86_64                randconfig-002-20251031    gcc-14
x86_64                randconfig-003-20251031    gcc-14
x86_64                randconfig-004-20251031    gcc-14
x86_64                randconfig-005-20251031    gcc-14
x86_64                randconfig-006-20251031    gcc-14
x86_64                randconfig-011-20251031    gcc-14
x86_64                randconfig-012-20251031    gcc-14
x86_64                randconfig-013-20251031    gcc-14
x86_64                randconfig-014-20251031    gcc-14
x86_64                randconfig-015-20251031    gcc-14
x86_64                randconfig-016-20251031    gcc-14
x86_64                randconfig-071-20251031    clang-20
x86_64                randconfig-072-20251031    clang-20
x86_64                randconfig-073-20251031    clang-20
x86_64                randconfig-074-20251031    clang-20
x86_64                randconfig-075-20251031    clang-20
x86_64                randconfig-076-20251031    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20251031    gcc-8.5.0
xtensa                randconfig-002-20251031    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


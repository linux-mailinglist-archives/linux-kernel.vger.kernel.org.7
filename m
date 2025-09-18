Return-Path: <linux-kernel+bounces-823458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD6FB86863
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 20:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADBAD7B98FF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C742D29D7;
	Thu, 18 Sep 2025 18:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hx9CHR4w"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690C427B357
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 18:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758221390; cv=none; b=mHiiEnnVaBsj115OuIGnudsn5Eeah2CdPxESK9S2vihv91ExkVEYreZ7nOlfm6/+Fdb0UmJ/wgIcLouLYp2q/b/pvlQFm8f+M63E4xROJPUM8qXl2EyEKGX3dkCibIP25iYQB8B7AnHkGRnzC2yN+1u92nCzIPZcmBQTnvBoWXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758221390; c=relaxed/simple;
	bh=2D/5mzNpugv/zNOONHRLZO3ZNBKTVVxuXFGng84His8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tnXJ+2J3sznd2nCKqZwD84a4ozpe5wHjRWtmdaxvbtLcj56089OYlQ+jOerfjrnkRHs2QZQioijqR80CBk/ItEsME1lFni1oLPV2I2WzTE8UrPImoW5My2z3Xw/K2E0N3ZkAUZIalaZXePU0OFhi6M8Wu+fF7gAPZCAjDAwycP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hx9CHR4w; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758221389; x=1789757389;
  h=date:from:to:cc:subject:message-id;
  bh=2D/5mzNpugv/zNOONHRLZO3ZNBKTVVxuXFGng84His8=;
  b=hx9CHR4wR2TNb2NTQZi4onvcK22IRpYOPlWA+oRYTkKtlqGJ2OQM0dg+
   uDm4y8jjmjx/qiySC6ZViYwKxA7k7aJlnlVPP4cASu3OQGWAMXsfAErLQ
   jW63i5U1MJwLjDgAaZXD8c031uyfNFPrlknJh7AxRx4vGLBW9bHDVVSyv
   Hhrr19cFZ4v5uO9ULHckZqpkO7D79KGPLKE3A38nrzuBfEVXYlGKZcIqS
   2GQ+It3EdMJ8vvgFyqerGJ8Vs/w6ibbqGrzGLxSTgEERonRNE2pA+e2gp
   H9jl/2KhWcsIWZir3f3VUTHHFRQzkV2Vq2nDamtGybkhKDP++2mC6ZWDf
   Q==;
X-CSE-ConnectionGUID: 6dxyBOYYT+65H702tczR/w==
X-CSE-MsgGUID: /WIcs/SbTPWlrjvCv2knyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="83163854"
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="83163854"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 11:49:48 -0700
X-CSE-ConnectionGUID: DXDRAJRkSL+Batopkf4lbg==
X-CSE-MsgGUID: p2/NTqm5Rs2DXXUGKrsjAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="180050260"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 18 Sep 2025 11:49:46 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uzJhP-0003cb-2Y;
	Thu, 18 Sep 2025 18:49:43 +0000
Date: Fri, 19 Sep 2025 02:49:33 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:locking/futex] BUILD SUCCESS
 ed323aeda5e09fa1ab95946673939c8c425c329c
Message-ID: <202509190227.wcOnT0U8-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/futex
branch HEAD: ed323aeda5e09fa1ab95946673939c8c425c329c  selftest/futex: Compile also with libnuma < 2.0.16

elapsed time: 1447m

configs tested: 251
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-15.1.0
alpha                             allnoconfig    clang-22
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                               allnoconfig    clang-22
arc                          axs101_defconfig    clang-22
arc                                 defconfig    clang-19
arc                         haps_hs_defconfig    gcc-15.1.0
arc                   randconfig-001-20250918    clang-22
arc                   randconfig-001-20250918    gcc-8.5.0
arc                   randconfig-002-20250918    clang-22
arc                   randconfig-002-20250918    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                                 defconfig    clang-19
arm                   milbeaut_m10v_defconfig    clang-22
arm                       netwinder_defconfig    clang-22
arm                   randconfig-001-20250918    clang-22
arm                   randconfig-002-20250918    clang-22
arm                   randconfig-002-20250918    gcc-8.5.0
arm                   randconfig-003-20250918    clang-22
arm                   randconfig-004-20250918    clang-22
arm                   randconfig-004-20250918    gcc-11.5.0
arm                         s5pv210_defconfig    clang-22
arm64                             allnoconfig    clang-22
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250918    clang-22
arm64                 randconfig-002-20250918    clang-22
arm64                 randconfig-002-20250918    gcc-11.5.0
arm64                 randconfig-003-20250918    clang-22
arm64                 randconfig-004-20250918    clang-22
csky                              allnoconfig    clang-22
csky                                defconfig    clang-19
csky                  randconfig-001-20250918    clang-22
csky                  randconfig-001-20250918    gcc-15.1.0
csky                  randconfig-001-20250919    clang-22
csky                  randconfig-002-20250918    clang-22
csky                  randconfig-002-20250918    gcc-15.1.0
csky                  randconfig-002-20250919    clang-22
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250918    clang-22
hexagon               randconfig-001-20250919    clang-22
hexagon               randconfig-002-20250918    clang-22
hexagon               randconfig-002-20250919    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250918    clang-20
i386        buildonly-randconfig-001-20250918    gcc-14
i386        buildonly-randconfig-001-20250919    gcc-14
i386        buildonly-randconfig-002-20250918    gcc-14
i386        buildonly-randconfig-002-20250919    gcc-14
i386        buildonly-randconfig-003-20250918    gcc-14
i386        buildonly-randconfig-003-20250919    gcc-14
i386        buildonly-randconfig-004-20250918    clang-20
i386        buildonly-randconfig-004-20250918    gcc-14
i386        buildonly-randconfig-004-20250919    gcc-14
i386        buildonly-randconfig-005-20250918    gcc-14
i386        buildonly-randconfig-005-20250919    gcc-14
i386        buildonly-randconfig-006-20250918    clang-20
i386        buildonly-randconfig-006-20250918    gcc-14
i386        buildonly-randconfig-006-20250919    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20250918    gcc-14
i386                  randconfig-001-20250919    gcc-14
i386                  randconfig-002-20250918    gcc-14
i386                  randconfig-002-20250919    gcc-14
i386                  randconfig-003-20250918    gcc-14
i386                  randconfig-003-20250919    gcc-14
i386                  randconfig-004-20250918    gcc-14
i386                  randconfig-004-20250919    gcc-14
i386                  randconfig-005-20250918    gcc-14
i386                  randconfig-005-20250919    gcc-14
i386                  randconfig-006-20250918    gcc-14
i386                  randconfig-006-20250919    gcc-14
i386                  randconfig-007-20250918    gcc-14
i386                  randconfig-007-20250919    gcc-14
i386                  randconfig-011-20250918    gcc-14
i386                  randconfig-012-20250918    gcc-14
i386                  randconfig-013-20250918    gcc-14
i386                  randconfig-014-20250918    gcc-14
i386                  randconfig-015-20250918    gcc-14
i386                  randconfig-016-20250918    gcc-14
i386                  randconfig-017-20250918    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250918    clang-18
loongarch             randconfig-001-20250918    clang-22
loongarch             randconfig-001-20250919    clang-22
loongarch             randconfig-002-20250918    clang-18
loongarch             randconfig-002-20250918    clang-22
loongarch             randconfig-002-20250919    clang-22
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                         amcore_defconfig    clang-22
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                         db1xxx_defconfig    gcc-15.1.0
mips                        maltaup_defconfig    clang-22
mips                           mtx1_defconfig    clang-22
mips                         rt305x_defconfig    clang-22
nios2                         3c120_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250918    clang-22
nios2                 randconfig-001-20250918    gcc-10.5.0
nios2                 randconfig-001-20250919    clang-22
nios2                 randconfig-002-20250918    clang-22
nios2                 randconfig-002-20250918    gcc-8.5.0
nios2                 randconfig-002-20250919    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250918    clang-22
parisc                randconfig-001-20250918    gcc-12.5.0
parisc                randconfig-001-20250919    clang-22
parisc                randconfig-002-20250918    clang-22
parisc                randconfig-002-20250918    gcc-8.5.0
parisc                randconfig-002-20250919    clang-22
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                    ge_imp3a_defconfig    gcc-15.1.0
powerpc                 linkstation_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250918    clang-22
powerpc               randconfig-001-20250918    gcc-9.5.0
powerpc               randconfig-001-20250919    clang-22
powerpc               randconfig-002-20250918    clang-17
powerpc               randconfig-002-20250918    clang-22
powerpc               randconfig-002-20250919    clang-22
powerpc               randconfig-003-20250918    clang-19
powerpc               randconfig-003-20250918    clang-22
powerpc               randconfig-003-20250919    clang-22
powerpc64             randconfig-001-20250918    clang-22
powerpc64             randconfig-001-20250918    gcc-8.5.0
powerpc64             randconfig-001-20250919    clang-22
powerpc64             randconfig-002-20250918    clang-22
powerpc64             randconfig-002-20250918    gcc-14.3.0
powerpc64             randconfig-002-20250919    clang-22
powerpc64             randconfig-003-20250918    clang-22
powerpc64             randconfig-003-20250919    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20250918    clang-22
riscv                 randconfig-001-20250918    gcc-10.5.0
riscv                 randconfig-002-20250918    gcc-10.5.0
riscv                 randconfig-002-20250918    gcc-9.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20250918    gcc-10.5.0
s390                  randconfig-001-20250918    gcc-11.5.0
s390                  randconfig-002-20250918    gcc-10.5.0
s390                  randconfig-002-20250918    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20250918    gcc-10.5.0
sh                    randconfig-001-20250918    gcc-15.1.0
sh                    randconfig-002-20250918    gcc-10.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250918    gcc-10.5.0
sparc                 randconfig-001-20250918    gcc-11.5.0
sparc                 randconfig-002-20250918    gcc-10.5.0
sparc                 randconfig-002-20250918    gcc-15.1.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20250918    clang-20
sparc64               randconfig-001-20250918    gcc-10.5.0
sparc64               randconfig-002-20250918    gcc-10.5.0
sparc64               randconfig-002-20250918    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250918    clang-22
um                    randconfig-001-20250918    gcc-10.5.0
um                    randconfig-002-20250918    clang-18
um                    randconfig-002-20250918    gcc-10.5.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250918    clang-20
x86_64      buildonly-randconfig-002-20250918    clang-20
x86_64      buildonly-randconfig-003-20250918    clang-20
x86_64      buildonly-randconfig-004-20250918    clang-20
x86_64      buildonly-randconfig-005-20250918    clang-20
x86_64      buildonly-randconfig-006-20250918    clang-20
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250918    gcc-12
x86_64                randconfig-002-20250918    gcc-12
x86_64                randconfig-003-20250918    gcc-12
x86_64                randconfig-004-20250918    gcc-12
x86_64                randconfig-005-20250918    gcc-12
x86_64                randconfig-006-20250918    gcc-12
x86_64                randconfig-007-20250918    gcc-12
x86_64                randconfig-008-20250918    gcc-12
x86_64                randconfig-071-20250918    clang-20
x86_64                randconfig-072-20250918    clang-20
x86_64                randconfig-073-20250918    clang-20
x86_64                randconfig-074-20250918    clang-20
x86_64                randconfig-075-20250918    clang-20
x86_64                randconfig-076-20250918    clang-20
x86_64                randconfig-077-20250918    clang-20
x86_64                randconfig-078-20250918    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250918    gcc-10.5.0
xtensa                randconfig-001-20250918    gcc-8.5.0
xtensa                randconfig-002-20250918    gcc-10.5.0
xtensa                randconfig-002-20250918    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


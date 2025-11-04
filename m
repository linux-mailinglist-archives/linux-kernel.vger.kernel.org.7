Return-Path: <linux-kernel+bounces-884251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC08C2FBCB
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 08:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABE461899037
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 07:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3B430FF06;
	Tue,  4 Nov 2025 07:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gohpFV/u"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E3330FF08
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 07:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762243056; cv=none; b=IpWWb7nt4t6iNEksr9c/udMHrRbYbP9xpm/jz2d44mO/qSOEisPWQ+jOYIS6bPCgrLiUD8nn5RY7niKqG583adzI4NSIdGOQyLaZbEA6a/tkrKeMuY4X9cROOJ5F91XIKvzbS/x4BVFc05582BHpOumubTQo8BxUR7dexblxakU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762243056; c=relaxed/simple;
	bh=35uESaKZMXj0ORRkuaKJYTkJbt1z07tV7Jlm/pIFSSE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SZdgQo0oMRWD3aybLPgd3irGfcP2lsEypFcaSwVfKN3zn4nYpAtZ62hWw355FI9W6lvQTlYn87mY7wCmU7hGW9PKlg9uAZWVkZUw+4ZEyq/klvNRZBfJuYtRwWHy0kpM7OKKeGTNAHj4SYOHnxs294Q+KkllbM4qNWV64SkwwUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gohpFV/u; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762243055; x=1793779055;
  h=date:from:to:cc:subject:message-id;
  bh=35uESaKZMXj0ORRkuaKJYTkJbt1z07tV7Jlm/pIFSSE=;
  b=gohpFV/uUm2LoIRSpoEPB7ibGn1P9+R1CQc/TZovviO6brrHLMxTK7QG
   olycIsDM5c3wp2/SHdugBJPwQ80dcnT6dvTjqyMqTNTQtoNnto8W4UqFo
   yLUPcx5s30c1Qa1quj+hpMeDgceDnYh9Ae4X+lc523FHQx+Ycj7iQY1Ux
   oczGanoPMEtJdjQcaP8vGZCAa7cQ6kRHDBgsGCqs2yI/K+2Gdjmd990H+
   dK+GwLiYqwIOkAaonSMsjiE77su3NyFDqD74BGHKEAkwPncKeWIa6MtnP
   KzKlS8ZyNXYH5NpQWvHys82uw15YxjrEVfFPp4SJKR/QiEFGLqpMYteET
   w==;
X-CSE-ConnectionGUID: jeYbjao+ShSslIu6EUm6aw==
X-CSE-MsgGUID: wWuX+b9DQauLxKvdRzHvuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="64247289"
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="64247289"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 23:57:34 -0800
X-CSE-ConnectionGUID: nj4nQmi2RgWSssA9sCoBTg==
X-CSE-MsgGUID: 0nbr3pZXStSkdU79l9zZyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="187243095"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 03 Nov 2025 23:57:33 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGBv0-000R4i-1c;
	Tue, 04 Nov 2025 07:57:30 +0000
Date: Tue, 04 Nov 2025 15:56:34 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2025.11.01a] BUILD SUCCESS
 575f2729766054f23dfa6a4a9203899acca37330
Message-ID: <202511041527.voFp4V0b-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2025.11.01a
branch HEAD: 575f2729766054f23dfa6a4a9203899acca37330  fixup! rcutorture: Make srcu{,d}_torture_init() announce the SRCU type

elapsed time: 1454m

configs tested: 164
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                                 defconfig    clang-22
arm                        mvebu_v7_defconfig    clang-22
arm                             pxa_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
arm64                            allyesconfig    clang-22
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251104    gcc-13.4.0
arm64                 randconfig-002-20251104    clang-22
arm64                 randconfig-003-20251104    gcc-13.4.0
arm64                 randconfig-004-20251104    clang-22
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251104    gcc-10.5.0
csky                  randconfig-002-20251104    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251103    clang-22
hexagon               randconfig-002-20251103    clang-22
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251103    gcc-14
i386        buildonly-randconfig-002-20251103    clang-20
i386        buildonly-randconfig-003-20251103    clang-20
i386        buildonly-randconfig-004-20251103    gcc-14
i386        buildonly-randconfig-005-20251103    gcc-14
i386        buildonly-randconfig-006-20251103    gcc-13
i386                                defconfig    clang-20
i386                  randconfig-001-20251104    gcc-12
i386                  randconfig-002-20251104    gcc-14
i386                  randconfig-003-20251104    clang-20
i386                  randconfig-004-20251104    gcc-14
i386                  randconfig-005-20251104    gcc-14
i386                  randconfig-006-20251104    gcc-14
i386                  randconfig-007-20251104    gcc-14
i386                  randconfig-011-20251104    gcc-13
i386                  randconfig-012-20251104    clang-20
i386                  randconfig-013-20251104    gcc-14
i386                  randconfig-014-20251104    clang-20
i386                  randconfig-015-20251104    gcc-14
i386                  randconfig-016-20251104    clang-20
i386                  randconfig-017-20251104    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                        allyesconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251103    gcc-12.5.0
loongarch             randconfig-002-20251103    gcc-14.3.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                            mac_defconfig    gcc-15.1.0
m68k                        mvme16x_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251103    gcc-11.5.0
nios2                 randconfig-002-20251103    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
openrisc                 simple_smp_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251103    gcc-14.3.0
parisc                randconfig-002-20251103    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                   lite5200b_defconfig    clang-22
powerpc                      ppc44x_defconfig    clang-22
powerpc               randconfig-001-20251103    gcc-8.5.0
powerpc               randconfig-002-20251103    clang-20
powerpc64             randconfig-001-20251103    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251104    gcc-8.5.0
riscv                 randconfig-002-20251104    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251104    clang-22
s390                  randconfig-002-20251104    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251104    gcc-13.4.0
sh                    randconfig-002-20251104    gcc-11.5.0
sh                           se7343_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251104    gcc-13.4.0
sparc                 randconfig-002-20251104    gcc-12.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251104    gcc-8.5.0
sparc64               randconfig-002-20251104    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251104    clang-22
um                    randconfig-002-20251104    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251104    clang-20
x86_64      buildonly-randconfig-002-20251104    gcc-12
x86_64      buildonly-randconfig-003-20251104    gcc-14
x86_64      buildonly-randconfig-004-20251104    gcc-14
x86_64      buildonly-randconfig-005-20251104    gcc-12
x86_64      buildonly-randconfig-006-20251104    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251104    gcc-14
x86_64                randconfig-002-20251104    clang-20
x86_64                randconfig-003-20251104    gcc-13
x86_64                randconfig-004-20251104    clang-20
x86_64                randconfig-005-20251104    clang-20
x86_64                randconfig-006-20251104    gcc-14
x86_64                randconfig-011-20251104    gcc-14
x86_64                randconfig-012-20251104    gcc-14
x86_64                randconfig-013-20251104    clang-20
x86_64                randconfig-014-20251104    clang-20
x86_64                randconfig-015-20251104    gcc-14
x86_64                randconfig-016-20251104    clang-20
x86_64                randconfig-071-20251104    clang-20
x86_64                randconfig-072-20251104    clang-20
x86_64                randconfig-073-20251104    clang-20
x86_64                randconfig-074-20251104    gcc-14
x86_64                randconfig-075-20251104    clang-20
x86_64                randconfig-076-20251104    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251104    gcc-13.4.0
xtensa                randconfig-002-20251104    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


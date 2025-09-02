Return-Path: <linux-kernel+bounces-796869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D6EB4089C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 908E83A2F23
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB863148D5;
	Tue,  2 Sep 2025 15:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CZLZkkIw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFDC1DE2A0
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 15:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756825873; cv=none; b=PrmAPTvx2U4eLYcrGBjV79leKKSiPlbVhErkphkTFzM/bRDF+aOfiLclHW6gCYal97f3bHhEEYuGAcOltSasKWhKh+UK9HU+sy+CL2PPjGNauyAiPnQQH8vRw1FBZuuAVI+oFSVZhCorbzJBNyDMjZUsUBkovdX7qPVJC4tg2rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756825873; c=relaxed/simple;
	bh=NL5vg2Ct2KpPZ/ri46uVADCZBobDIbxVryPwb0KjzlM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=aAL1xEqf0GUjHDdmBZzuxOtAX8GbeUph1ynOZinMSbMRoOTHbdprVYqG6iiWhTxpnM5UXYk4DInye35ds6+m3pMWABso6BXrMVrywG75XxzqO02kZ6AWN4tveMJD6Jc28Y1zqC+OvCayEfZkNnDncN8VqGIf3ZD/buewjcASncE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CZLZkkIw; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756825872; x=1788361872;
  h=date:from:to:cc:subject:message-id;
  bh=NL5vg2Ct2KpPZ/ri46uVADCZBobDIbxVryPwb0KjzlM=;
  b=CZLZkkIwC1Yx6/FMmDEvAdLrCIsdc1UDkXuYoC3zAOo54ySQxLhmmvi3
   aexi3TwQuvRxKHbmDyFfO12ct3Up/vMgzJYLXAcS/7yJLzCaBxytsc4vK
   aVuHbZWXX/R35BRKeDftay2JBNCPFU7AIqVKOczpK7ifG0PDbrNFB634t
   L4tdL5R7QBEoCow+Lz5badhvqn/zpJW+/CbVKIZmu95A0dfXZP+i0i4UC
   9SoCvhBsPMV51OFszC/0dSFicaBwx5m2wbAvLKFB07YWAWArXuyHg8knJ
   S0joV7z+iqZiSf/BEE2h9x7RU5rWs3Qu2Zh2eR3pDHtIX7TXL1jNtaQwT
   A==;
X-CSE-ConnectionGUID: rShW0kvNQAmwRmBUpTzjxg==
X-CSE-MsgGUID: JSLcUnyJSyebju9wpZvFuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59173262"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59173262"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 08:11:12 -0700
X-CSE-ConnectionGUID: 7/WRpHgQQdW7fJqxtpwDNw==
X-CSE-MsgGUID: voEcdsRpR8yBlNwZvHQlpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="175669729"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 02 Sep 2025 08:11:10 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1utSf5-0002fS-2Y;
	Tue, 02 Sep 2025 15:11:07 +0000
Date: Tue, 02 Sep 2025 23:07:19 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:locking/futex] BUILD SUCCESS
 237bfb76c90b184f57bb18fe35ff366c19393dc8
Message-ID: <202509022305.zcSvh9qB-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/futex
branch HEAD: 237bfb76c90b184f57bb18fe35ff366c19393dc8  selftests/futex: Fix futex_wait() for 32bit ARM

elapsed time: 1463m

configs tested: 243
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
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                          axs103_defconfig    clang-22
arc                                 defconfig    clang-19
arc                        nsimosci_defconfig    clang-22
arc                 nsimosci_hs_smp_defconfig    clang-22
arc                   randconfig-001-20250902    gcc-11.5.0
arc                   randconfig-001-20250902    gcc-8.5.0
arc                   randconfig-002-20250902    gcc-8.5.0
arc                   randconfig-002-20250902    gcc-9.5.0
arc                           tb10x_defconfig    clang-22
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                     davinci_all_defconfig    clang-22
arm                                 defconfig    clang-19
arm                            hisi_defconfig    clang-22
arm                          ixp4xx_defconfig    clang-22
arm                      jornada720_defconfig    clang-22
arm                        multi_v7_defconfig    clang-22
arm                        neponset_defconfig    gcc-15.1.0
arm                   randconfig-001-20250902    gcc-15.1.0
arm                   randconfig-001-20250902    gcc-8.5.0
arm                   randconfig-002-20250902    gcc-8.5.0
arm                   randconfig-003-20250902    clang-22
arm                   randconfig-003-20250902    gcc-8.5.0
arm                   randconfig-004-20250902    clang-22
arm                   randconfig-004-20250902    gcc-8.5.0
arm                           stm32_defconfig    gcc-15.1.0
arm                    vt8500_v6_v7_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250902    gcc-8.5.0
arm64                 randconfig-002-20250902    clang-22
arm64                 randconfig-002-20250902    gcc-8.5.0
arm64                 randconfig-003-20250902    gcc-12.5.0
arm64                 randconfig-003-20250902    gcc-8.5.0
arm64                 randconfig-004-20250902    clang-22
arm64                 randconfig-004-20250902    gcc-8.5.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250902    gcc-11.5.0
csky                  randconfig-001-20250902    gcc-14.3.0
csky                  randconfig-002-20250902    gcc-11.5.0
csky                  randconfig-002-20250902    gcc-12.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250902    clang-18
hexagon               randconfig-001-20250902    gcc-11.5.0
hexagon               randconfig-002-20250902    clang-22
hexagon               randconfig-002-20250902    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250902    clang-20
i386        buildonly-randconfig-001-20250902    gcc-12
i386        buildonly-randconfig-002-20250902    clang-20
i386        buildonly-randconfig-002-20250902    gcc-12
i386        buildonly-randconfig-003-20250902    gcc-12
i386        buildonly-randconfig-004-20250902    clang-20
i386        buildonly-randconfig-004-20250902    gcc-12
i386        buildonly-randconfig-005-20250902    gcc-12
i386        buildonly-randconfig-006-20250902    clang-20
i386        buildonly-randconfig-006-20250902    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250902    gcc-12
i386                  randconfig-002-20250902    gcc-12
i386                  randconfig-003-20250902    gcc-12
i386                  randconfig-004-20250902    gcc-12
i386                  randconfig-005-20250902    gcc-12
i386                  randconfig-006-20250902    gcc-12
i386                  randconfig-007-20250902    gcc-12
i386                  randconfig-011-20250902    gcc-12
i386                  randconfig-012-20250902    gcc-12
i386                  randconfig-013-20250902    gcc-12
i386                  randconfig-014-20250902    gcc-12
i386                  randconfig-015-20250902    gcc-12
i386                  randconfig-016-20250902    gcc-12
i386                  randconfig-017-20250902    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250902    clang-22
loongarch             randconfig-001-20250902    gcc-11.5.0
loongarch             randconfig-002-20250902    clang-22
loongarch             randconfig-002-20250902    gcc-11.5.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                            mac_defconfig    clang-22
m68k                        mvme147_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        bcm63xx_defconfig    gcc-15.1.0
mips                      maltaaprp_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250902    gcc-11.5.0
nios2                 randconfig-001-20250902    gcc-9.5.0
nios2                 randconfig-002-20250902    gcc-11.5.0
openrisc                          allnoconfig    clang-22
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250902    gcc-11.5.0
parisc                randconfig-001-20250902    gcc-8.5.0
parisc                randconfig-002-20250902    gcc-11.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                     kmeter1_defconfig    clang-22
powerpc               randconfig-001-20250902    gcc-11.5.0
powerpc               randconfig-001-20250902    gcc-9.5.0
powerpc               randconfig-002-20250902    gcc-11.5.0
powerpc               randconfig-002-20250902    gcc-8.5.0
powerpc               randconfig-003-20250902    gcc-11.5.0
powerpc                     tqm8548_defconfig    clang-22
powerpc                        warp_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250902    gcc-11.5.0
powerpc64             randconfig-001-20250902    gcc-12.5.0
powerpc64             randconfig-002-20250902    clang-22
powerpc64             randconfig-002-20250902    gcc-11.5.0
powerpc64             randconfig-003-20250902    clang-22
powerpc64             randconfig-003-20250902    gcc-11.5.0
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250902    gcc-12.5.0
riscv                 randconfig-001-20250902    gcc-13.4.0
riscv                 randconfig-002-20250902    clang-22
riscv                 randconfig-002-20250902    gcc-12.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250902    clang-22
s390                  randconfig-001-20250902    gcc-12.5.0
s390                  randconfig-002-20250902    gcc-10.5.0
s390                  randconfig-002-20250902    gcc-12.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                          polaris_defconfig    clang-22
sh                    randconfig-001-20250902    gcc-12.5.0
sh                    randconfig-002-20250902    gcc-12.5.0
sh                           se7343_defconfig    clang-22
sh                        sh7757lcr_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250902    gcc-12.5.0
sparc                 randconfig-001-20250902    gcc-14.3.0
sparc                 randconfig-002-20250902    gcc-12.5.0
sparc                 randconfig-002-20250902    gcc-8.5.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250902    clang-20
sparc64               randconfig-001-20250902    gcc-12.5.0
sparc64               randconfig-002-20250902    gcc-12.5.0
sparc64               randconfig-002-20250902    gcc-9.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250902    gcc-12
um                    randconfig-001-20250902    gcc-12.5.0
um                    randconfig-002-20250902    gcc-12
um                    randconfig-002-20250902    gcc-12.5.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250902    clang-20
x86_64      buildonly-randconfig-002-20250902    clang-20
x86_64      buildonly-randconfig-003-20250902    clang-20
x86_64      buildonly-randconfig-004-20250902    clang-20
x86_64      buildonly-randconfig-004-20250902    gcc-12
x86_64      buildonly-randconfig-005-20250902    clang-20
x86_64      buildonly-randconfig-005-20250902    gcc-12
x86_64      buildonly-randconfig-006-20250902    clang-20
x86_64      buildonly-randconfig-006-20250902    gcc-12
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250902    clang-20
x86_64                randconfig-002-20250902    clang-20
x86_64                randconfig-003-20250902    clang-20
x86_64                randconfig-004-20250902    clang-20
x86_64                randconfig-005-20250902    clang-20
x86_64                randconfig-006-20250902    clang-20
x86_64                randconfig-007-20250902    clang-20
x86_64                randconfig-008-20250902    clang-20
x86_64                randconfig-071-20250902    clang-20
x86_64                randconfig-072-20250902    clang-20
x86_64                randconfig-073-20250902    clang-20
x86_64                randconfig-074-20250902    clang-20
x86_64                randconfig-075-20250902    clang-20
x86_64                randconfig-076-20250902    clang-20
x86_64                randconfig-077-20250902    clang-20
x86_64                randconfig-078-20250902    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250902    gcc-12.5.0
xtensa                randconfig-001-20250902    gcc-9.5.0
xtensa                randconfig-002-20250902    gcc-10.5.0
xtensa                randconfig-002-20250902    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


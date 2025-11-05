Return-Path: <linux-kernel+bounces-885689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 928B0C33B26
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 02:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8F9A189FB54
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 01:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED04927453;
	Wed,  5 Nov 2025 01:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Br65Yo2n"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD05E34D3BD
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 01:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762307169; cv=none; b=MdOfhyk8k+Zt4UXhUj3hJOvnulvpTQyPKI/Wst8oLnf/4sMhT7QuTei/9yxND9/faEb3lEGKoUDCocSl8W99v/SFMgYPf/46tXYFLQD7nzoBCm5PFOSASHFvFPFrOCbNKntd28U7dlzU4X5wDzfAvJLdUBtvehzHv0X0mqIAiPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762307169; c=relaxed/simple;
	bh=IYKdqvKaMbAmRGkHGr/1cr48x6eBVyZkuLOmRCS/xl0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RvVlE7Ii4eekZQTJyiz2NqLrw1dNfzyYSuEipBPNl83ajhGmF8APZ3u0l6hzx+diYIUPFhWkdN95hnQvrE+OxPLbsyPfB1O1uwm+zEjE31xMENKThsJgxTKRUPtDGMS4fzbPunZcGWxJNNoki3kUVNj0yxBnxvuXnKaWdaOr0M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Br65Yo2n; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762307163; x=1793843163;
  h=date:from:to:cc:subject:message-id;
  bh=IYKdqvKaMbAmRGkHGr/1cr48x6eBVyZkuLOmRCS/xl0=;
  b=Br65Yo2n/eCrRxaO1/1nUaYbeQlW6aDWZVlZCRGYytLXsE8WWeFm4mb1
   SXMkNcrnu9rSI18Pndd2LAejcdoJyNQLOnaEZwI4HuIiig+Vh7YjxzvgM
   w+HOCbEmlpnscNEC0cv8SDL+LVRnAQwO3d1doUUL5aEWk1QhLG27n2V1K
   OwVvG3g9/KMUrcE5F8D+OOTUL+y55LKDDwD9VxVcXDNwN3NVxvzaZIJm7
   pZl/rkZEqz66hpV/pVssLAf1w/hlYyWcbDCXKyX6yMgKxHtH3jPAd5/P3
   JmGRjU1vw6bdDStv+XELiA/688ef58NCSVga2qkZZo/wEE5OCzP3IuDzJ
   Q==;
X-CSE-ConnectionGUID: LwOp7Y1ZT+iRtL69j7wa0g==
X-CSE-MsgGUID: I8epp/X7SDmPbFrZzedVOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="81818963"
X-IronPort-AV: E=Sophos;i="6.19,280,1754982000"; 
   d="scan'208";a="81818963"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 17:46:01 -0800
X-CSE-ConnectionGUID: 19ByHLDJQLKO0R1iwiPoYw==
X-CSE-MsgGUID: g13wZwzGQVSrGZFu2vvdMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,280,1754982000"; 
   d="scan'208";a="218108739"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 04 Nov 2025 17:46:00 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGSaE-000S1g-14;
	Wed, 05 Nov 2025 01:45:28 +0000
Date: Wed, 05 Nov 2025 09:44:09 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 3d02464f7b12d3244f2fbc210afcdd0cdb7da4f7
Message-ID: <202511050903.57tADyEh-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: 3d02464f7b12d3244f2fbc210afcdd0cdb7da4f7  irqchip/sifive-plic: Fix call to __plic_toggle() in M-Mode code path

elapsed time: 1458m

configs tested: 129
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                          axs101_defconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                         lpc18xx_defconfig    clang-22
arm                           spitz_defconfig    gcc-15.1.0
arm                         vf610m4_defconfig    gcc-15.1.0
arm                         wpcm450_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
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
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20251104    clang-22
hexagon               randconfig-002-20251104    clang-16
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251104    gcc-14
i386        buildonly-randconfig-002-20251104    clang-20
i386        buildonly-randconfig-003-20251104    gcc-12
i386        buildonly-randconfig-004-20251104    gcc-14
i386        buildonly-randconfig-005-20251104    gcc-12
i386        buildonly-randconfig-006-20251104    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251104    gcc-12
i386                  randconfig-002-20251104    gcc-14
i386                  randconfig-003-20251104    clang-20
i386                  randconfig-004-20251104    gcc-14
i386                  randconfig-005-20251104    gcc-14
i386                  randconfig-006-20251104    gcc-14
i386                  randconfig-007-20251104    gcc-14
i386                  randconfig-011-20251105    clang-20
i386                  randconfig-012-20251105    clang-20
i386                  randconfig-013-20251105    clang-20
i386                  randconfig-014-20251105    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251104    gcc-15.1.0
loongarch             randconfig-002-20251104    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251104    gcc-8.5.0
nios2                 randconfig-002-20251104    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251104    gcc-8.5.0
parisc                randconfig-002-20251104    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                     mpc512x_defconfig    clang-22
powerpc               randconfig-001-20251104    gcc-15.1.0
powerpc               randconfig-002-20251104    clang-22
powerpc64             randconfig-001-20251104    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20251104    gcc-8.5.0
riscv                 randconfig-002-20251104    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20251104    clang-22
s390                  randconfig-002-20251104    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         ap325rxa_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251104    gcc-13.4.0
sh                    randconfig-002-20251104    gcc-11.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20251104    gcc-13.4.0
sparc                 randconfig-002-20251104    gcc-12.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251104    gcc-8.5.0
sparc64               randconfig-002-20251104    clang-22
um                                allnoconfig    clang-22
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
x86_64                randconfig-001-20251105    clang-20
x86_64                randconfig-002-20251105    gcc-14
x86_64                randconfig-003-20251105    gcc-12
x86_64                randconfig-004-20251105    gcc-14
x86_64                randconfig-005-20251105    gcc-14
x86_64                randconfig-006-20251105    clang-20
x86_64                randconfig-011-20251104    gcc-14
x86_64                randconfig-012-20251104    gcc-14
x86_64                randconfig-013-20251104    clang-20
x86_64                randconfig-014-20251104    clang-20
x86_64                randconfig-015-20251104    gcc-14
x86_64                randconfig-016-20251104    clang-20
x86_64                randconfig-071-20251105    gcc-14
x86_64                randconfig-073-20251105    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251104    gcc-13.4.0
xtensa                randconfig-002-20251104    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-kernel+bounces-783837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2450B3335E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 02:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DEAC200F70
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 00:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E187B537F8;
	Mon, 25 Aug 2025 00:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aaoXnUDM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5784F3A8F7
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 00:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756080902; cv=none; b=U9OrIpoNud7czyHsEScxdpAl3oDoLOXna7ei5QJ1Ac/5w/mpbJ+zl4y8Y1Uxl0TOffmmmgf+KB44dwo9AVp2N+6ryJCLuov54Alo2klw35BZMHht6ghnUhYfFoPvF40xeQV+oma5m8J54VkCUr2L3mwRi1jjOOg4FymxbzzOBDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756080902; c=relaxed/simple;
	bh=s6oFPe9epvz7BHkECwSXoksta/icBM0qdIPBFS5OKFc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Jbzf3RJ0z8wwYgKVUY2tafke+dJLNg9uCSxxAffLiQD8Yy7I8M2VhWGpztkxapffoFcJh6fumDzsFdaoy2M0qIzQDEo6R1Pt0DfR0AZHUbYiToKt6txg03mDMVyaCrxRJwBu51vIlglte5irE802GqLXRU5O+NaGJdKN9FRlkbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aaoXnUDM; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756080901; x=1787616901;
  h=date:from:to:cc:subject:message-id;
  bh=s6oFPe9epvz7BHkECwSXoksta/icBM0qdIPBFS5OKFc=;
  b=aaoXnUDMGMbcmLECzBbheWIeqQRTqJji2CMvIGEHKgAzpJM8FiIq6hrX
   VuQBN9Uy2bL8+Zk9AYbqHQqdJk2Z10B9MG48WRmDtWtNsWCeOeddEc+Vt
   cxV5A/cr0bOn3R1SWq4h5Z/q+09tsbJL1ab3Id6B+ZMrHfWaHGkFHCmKM
   XihHpMzXLq3X6gE1KQoARzVvw5PJEUGJas3ObSgKSeq5zT6rEW+ksryZJ
   /4vKROSgCTnhusIo5fQEEMlj+gA6cey9gUt1yJ3PJADMVLI12B6ZuacvO
   8vuLHHevzqtZqKKn+OiAkIhU+UppqUclE1yReKl2TRHL8u+h4178cC1mG
   w==;
X-CSE-ConnectionGUID: TL1qkR6TQhSsmo6VR9cNCw==
X-CSE-MsgGUID: CeOaj2DdSOe+5RYzler/jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11532"; a="58434473"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58434473"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2025 17:15:00 -0700
X-CSE-ConnectionGUID: TGqcbnP2Rje8XKRyQvVuLA==
X-CSE-MsgGUID: chwOVzC4RKOUVUI4kvuQ6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="169339664"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 24 Aug 2025 17:14:59 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uqKrK-000NH1-00;
	Mon, 25 Aug 2025 00:14:51 +0000
Date: Mon, 25 Aug 2025 08:14:34 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 55b48e23f5c4b6f5ca9b7ab09599b17dcf501c10
Message-ID: <202508250824.Vu7ZwZ2d-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: 55b48e23f5c4b6f5ca9b7ab09599b17dcf501c10  genirq/devres: Add error handling in devm_request_*_irq()

elapsed time: 725m

configs tested: 136
configs skipped: 3

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
arc                   randconfig-001-20250824    gcc-15.1.0
arc                   randconfig-002-20250824    gcc-10.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                            dove_defconfig    gcc-15.1.0
arm                   randconfig-001-20250824    clang-22
arm                   randconfig-002-20250824    gcc-13.4.0
arm                   randconfig-003-20250824    clang-22
arm                   randconfig-004-20250824    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250824    gcc-13.4.0
arm64                 randconfig-002-20250824    gcc-11.5.0
arm64                 randconfig-003-20250824    gcc-10.5.0
arm64                 randconfig-004-20250824    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250824    gcc-10.5.0
csky                  randconfig-002-20250824    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20250824    clang-22
hexagon               randconfig-002-20250824    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250824    gcc-12
i386        buildonly-randconfig-002-20250824    gcc-12
i386        buildonly-randconfig-003-20250824    gcc-12
i386        buildonly-randconfig-004-20250824    gcc-12
i386        buildonly-randconfig-005-20250824    gcc-12
i386        buildonly-randconfig-006-20250824    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250824    gcc-12.5.0
loongarch             randconfig-002-20250824    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                        m5307c3_defconfig    gcc-15.1.0
m68k                        mvme16x_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        omega2p_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250824    gcc-8.5.0
nios2                 randconfig-002-20250824    gcc-9.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                generic-32bit_defconfig    gcc-15.1.0
parisc                randconfig-001-20250824    gcc-9.5.0
parisc                randconfig-002-20250824    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                     kmeter1_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250824    gcc-9.5.0
powerpc               randconfig-002-20250824    clang-22
powerpc               randconfig-003-20250824    gcc-12.5.0
powerpc64             randconfig-001-20250824    gcc-8.5.0
powerpc64             randconfig-002-20250824    gcc-13.4.0
powerpc64             randconfig-003-20250824    gcc-12.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250824    gcc-11.5.0
riscv                 randconfig-002-20250824    gcc-9.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250824    clang-16
s390                  randconfig-002-20250824    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                          landisk_defconfig    gcc-15.1.0
sh                    randconfig-001-20250824    gcc-15.1.0
sh                    randconfig-002-20250824    gcc-15.1.0
sh                          urquell_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250824    gcc-14.3.0
sparc                 randconfig-002-20250824    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250824    clang-22
sparc64               randconfig-002-20250824    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250824    gcc-12
um                    randconfig-002-20250824    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250824    gcc-12
x86_64      buildonly-randconfig-002-20250824    clang-20
x86_64      buildonly-randconfig-003-20250824    gcc-12
x86_64      buildonly-randconfig-004-20250824    clang-20
x86_64      buildonly-randconfig-005-20250824    gcc-12
x86_64      buildonly-randconfig-006-20250824    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250824    gcc-9.5.0
xtensa                randconfig-002-20250824    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


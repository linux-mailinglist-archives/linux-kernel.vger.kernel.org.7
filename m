Return-Path: <linux-kernel+bounces-881682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 57841C28BF2
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 09:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0AA644EE03D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 08:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0452609FC;
	Sun,  2 Nov 2025 08:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YzJxkYgh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14D67261B
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 08:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762070806; cv=none; b=NfVPpdGgTz6SFgos6puPG+OKGZJF9zksNdfdvb3P2ZdkDTqPqVjTb06jz7ovgrmp3gfTnNkXkAFUyhxtdJVWdIBCkG4olDenx0harQaGMGNhLlWJ05n7mWd68AQk+Fpo+xilRVPV819usps2/nlD1ricFEN/1JbHlyOdC3i9rm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762070806; c=relaxed/simple;
	bh=e9Wwv94WUdW0HVUyyxQEzPDK7JX5EhIjgrJVvmuKjjw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=OS34VS3Ea6ycTUDpvKi0HvBh3wk+L3697PtJP6B3IC/868+9kBVOhddpgq6Tlyo/hLRcb9bjgSnxSZfHdjOecr3NN0hOHfCqjRs8jEcDZEhQVGHRWmH77sujTUgmhP2kVmDcD7WEVf2TSw3brTsoyNJU8pumak40E855NLhzkvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YzJxkYgh; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762070805; x=1793606805;
  h=date:from:to:cc:subject:message-id;
  bh=e9Wwv94WUdW0HVUyyxQEzPDK7JX5EhIjgrJVvmuKjjw=;
  b=YzJxkYghIM/EiiGR4yQxwTnJ0lYmbmG43hZr9he58qmH8+XIMOSlTo8B
   naiM6Z9tBicR3CdadKfTLBJEenS6GJUxjgDNDGM2aZhnzY5g/84YJ0ymu
   N56pRalwDEe44sw8eheKw5VK62RPymyJ21bCbIs8Ji1OvoXmI6v7BIVMq
   C4ch4zrKraVS8htogzt6GOcaPyeWON+pO6vOblFU/flzdOID0kAJvk1Oz
   1mYFqzyihNwvfVxRts4poxxdIhrG6P23S4qiU+olYVqa1MK+tQqRMpi2a
   LMeZz1taqoFuzCxONHkCQ0rIeZhWLqG9X4EzknA9iGOEwlu7WfewTAUWw
   w==;
X-CSE-ConnectionGUID: DTTBXRRaThq7irl4ZXogNQ==
X-CSE-MsgGUID: D3EcC4UbRM2B6F2/Q+s1Mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11600"; a="64094191"
X-IronPort-AV: E=Sophos;i="6.19,273,1754982000"; 
   d="scan'208";a="64094191"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2025 01:06:44 -0700
X-CSE-ConnectionGUID: I07wI3XrT1S/qtGND7Fxjw==
X-CSE-MsgGUID: 5bLcIK4NQ36PauG9G64yNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,273,1754982000"; 
   d="scan'208";a="186917839"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 02 Nov 2025 01:06:43 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vFT6k-000P50-25;
	Sun, 02 Nov 2025 08:06:39 +0000
Date: Sun, 02 Nov 2025 16:06:29 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:objtool/urgent] BUILD SUCCESS
 c44b4b9eeb71f5b0b617abf6fd66d1ef0aab6200
Message-ID: <202511021623.l13IjNLW-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool/urgent
branch HEAD: c44b4b9eeb71f5b0b617abf6fd66d1ef0aab6200  objtool: Fix skip_alt_group() for non-alternative STAC/CLAC

elapsed time: 1481m

configs tested: 100
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251101    gcc-8.5.0
arc                   randconfig-002-20251101    gcc-8.5.0
arc                           tb10x_defconfig    gcc-15.1.0
arc                    vdk_hs38_smp_defconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                   randconfig-001-20251101    gcc-13.4.0
arm                   randconfig-002-20251101    clang-22
arm                   randconfig-003-20251101    clang-18
arm                   randconfig-004-20251101    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251102    clang-22
arm64                 randconfig-002-20251102    gcc-10.5.0
arm64                 randconfig-003-20251102    gcc-11.5.0
arm64                 randconfig-004-20251102    gcc-12.5.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251102    gcc-15.1.0
csky                  randconfig-002-20251102    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20251101    clang-22
hexagon               randconfig-002-20251101    clang-22
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251102    gcc-14
i386        buildonly-randconfig-002-20251102    gcc-14
i386        buildonly-randconfig-003-20251102    gcc-14
i386        buildonly-randconfig-004-20251102    clang-20
i386        buildonly-randconfig-005-20251102    clang-20
i386        buildonly-randconfig-006-20251102    gcc-14
i386                                defconfig    clang-20
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20251101    clang-18
loongarch             randconfig-002-20251101    clang-19
m68k                              allnoconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           ip32_defconfig    clang-22
mips                        vocore2_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                 randconfig-001-20251101    gcc-9.5.0
nios2                 randconfig-002-20251101    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251102    gcc-8.5.0
parisc                randconfig-002-20251102    gcc-14.3.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                      cm5200_defconfig    clang-22
powerpc                 mpc8313_rdb_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251102    gcc-9.5.0
powerpc               randconfig-002-20251102    clang-18
powerpc64             randconfig-001-20251102    gcc-14.3.0
powerpc64             randconfig-002-20251102    gcc-8.5.0
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20251101    gcc-8.5.0
riscv                 randconfig-002-20251101    gcc-8.5.0
s390                              allnoconfig    clang-22
s390                                defconfig    clang-22
s390                  randconfig-001-20251101    clang-17
s390                  randconfig-002-20251101    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251101    gcc-15.1.0
sh                    randconfig-002-20251101    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251102    gcc-8.5.0
sparc                 randconfig-002-20251102    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251102    clang-20
sparc64               randconfig-002-20251102    clang-20
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251102    clang-22
um                    randconfig-002-20251102    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251102    gcc-14
x86_64      buildonly-randconfig-002-20251102    clang-20
x86_64      buildonly-randconfig-003-20251102    clang-20
x86_64      buildonly-randconfig-004-20251102    clang-20
x86_64      buildonly-randconfig-005-20251102    gcc-14
x86_64      buildonly-randconfig-006-20251102    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-011-20251102    gcc-14
x86_64                randconfig-012-20251102    gcc-14
x86_64                randconfig-013-20251102    gcc-12
x86_64                randconfig-014-20251102    gcc-14
x86_64                randconfig-015-20251102    gcc-14
x86_64                randconfig-016-20251102    gcc-14
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251102    gcc-8.5.0
xtensa                randconfig-002-20251102    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


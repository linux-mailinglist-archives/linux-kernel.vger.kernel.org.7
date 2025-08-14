Return-Path: <linux-kernel+bounces-767967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BA1B25B53
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BFEE1C261C7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 05:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB681221703;
	Thu, 14 Aug 2025 05:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LQNsS8PE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AB420F087
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 05:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755150768; cv=none; b=ZCH4RoYFtx7hqC2M9rxRBTS5RuDo4jyzRqII4K8pEYpbxyct5TzrvbdThK3AkGpgM27wHfu758yUDr+BIoZKamkvJjESne4gQClw87mPlnPhoLYPa0Kb9YUBd6FQLEVgaglrUIjFq4foe7helCKhqJeMaMiuoCVVVFyUP488fiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755150768; c=relaxed/simple;
	bh=9mIUCR9UgUGizLABJshz8jLJ+X6hBhfEyygyYZiwvUQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Pni1qUDfo1wTaxMOt25QW6oxbOQqU/eBy3oJwkMOGdZk3XtSTkaldcN59Lf1ReppGZNP3+pNS9XKHNcJ+2zs7tgl0YEvxgAEkMXOSC0MDwKahW2ViyxN8Go6bph0IQ0B9YdB18U5D1+EMFOMI/ya+F0XGD7KEOBuDSaJK7vs/OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LQNsS8PE; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755150766; x=1786686766;
  h=date:from:to:cc:subject:message-id;
  bh=9mIUCR9UgUGizLABJshz8jLJ+X6hBhfEyygyYZiwvUQ=;
  b=LQNsS8PEbBfVDCxSUkAz+iSNTFB+tjK2RfTxup6EG7t4f/6jw5YYrDsa
   nkMrPtoKIbGT9u6DK55Q9NZu/MTqj9H/yEb4NTm64PoSNB/4QO2a70bEY
   uc8rM9TwInbPEm3jU82iCQ+/DxhD46fs3A+S3Nw0QQJAQDsHufAS6Z/UD
   i0Go+LmfQUfEnZM2Mu79iBfrQNhYoshQMZwn0LdjX8CHIhI/scAKQXtV4
   xR7KDGpD16Ne+PK470rpmIS/4clGLxvofFu31qavx2EvKIm58+J5m2sA2
   iUX0JbXdK8T4RimPoSuQu9JDy5OOkS3x/ylSAmeVI415VMvrLlReNBQxy
   g==;
X-CSE-ConnectionGUID: KX2nWESsTiC+zTjE2OeXsw==
X-CSE-MsgGUID: Gi2uQx6NSMiR0DCrfD9JQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57527205"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="57527205"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 22:52:46 -0700
X-CSE-ConnectionGUID: OmAyYiQQT7KAOtnPUCM25w==
X-CSE-MsgGUID: 5/j7hEcPThezXScbe++Gnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="190378916"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 13 Aug 2025 22:52:45 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umQtG-000Ad2-2n;
	Thu, 14 Aug 2025 05:52:42 +0000
Date: Thu, 14 Aug 2025 13:52:07 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 4c699535a3d483562354432a945a035f15dfceeb
Message-ID: <202508141301.vDhP8LA0-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 4c699535a3d483562354432a945a035f15dfceeb  Merge branch into tip/master: 'timers/clocksource'

elapsed time: 1409m

configs tested: 123
configs skipped: 6

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
arc                        nsim_700_defconfig    gcc-15.1.0
arc                   randconfig-001-20250813    gcc-11.5.0
arc                   randconfig-002-20250813    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                          collie_defconfig    gcc-15.1.0
arm                   randconfig-003-20250813    clang-22
arm                   randconfig-004-20250813    gcc-8.5.0
arm                    vt8500_v6_v7_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-002-20250813    gcc-12.5.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250813    gcc-14.3.0
csky                  randconfig-002-20250813    gcc-13.4.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20250813    clang-22
hexagon               randconfig-002-20250813    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250813    gcc-11
i386        buildonly-randconfig-002-20250813    clang-20
i386        buildonly-randconfig-003-20250813    gcc-11
i386        buildonly-randconfig-004-20250813    clang-20
i386        buildonly-randconfig-005-20250813    gcc-12
i386        buildonly-randconfig-006-20250813    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250813    clang-19
loongarch             randconfig-002-20250813    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250813    gcc-11.5.0
nios2                 randconfig-002-20250813    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250813    gcc-14.3.0
parisc                randconfig-002-20250813    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250813    clang-18
powerpc               randconfig-002-20250813    clang-22
powerpc               randconfig-003-20250813    clang-20
powerpc64             randconfig-001-20250813    clang-22
powerpc64             randconfig-002-20250813    gcc-8.5.0
powerpc64             randconfig-003-20250813    clang-17
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv             nommu_k210_sdcard_defconfig    gcc-15.1.0
riscv                 randconfig-001-20250813    clang-22
riscv                 randconfig-002-20250813    gcc-14.3.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250813    clang-22
s390                  randconfig-002-20250813    clang-18
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250813    gcc-9.5.0
sh                    randconfig-002-20250813    gcc-9.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250813    gcc-8.5.0
sparc                 randconfig-002-20250813    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250813    gcc-8.5.0
sparc64               randconfig-002-20250813    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250813    gcc-12
um                    randconfig-002-20250813    gcc-11
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250813    gcc-12
x86_64      buildonly-randconfig-002-20250813    clang-20
x86_64      buildonly-randconfig-003-20250813    gcc-12
x86_64      buildonly-randconfig-004-20250813    clang-20
x86_64      buildonly-randconfig-005-20250813    clang-20
x86_64      buildonly-randconfig-006-20250813    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250813    gcc-10.5.0
xtensa                randconfig-002-20250813    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


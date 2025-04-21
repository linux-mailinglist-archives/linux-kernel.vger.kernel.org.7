Return-Path: <linux-kernel+bounces-612242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9089CA94C79
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 08:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55619189126D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 06:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2891525743C;
	Mon, 21 Apr 2025 06:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YhID1sUr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33181DE2A4
	for <linux-kernel@vger.kernel.org>; Mon, 21 Apr 2025 06:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745216360; cv=none; b=MBj3ABlh30JlXcC8DwKPiT3GdaMpxub9Lnx6MT2SfgDqOr4peNiI1i4UG6AoQBNjJ10XNAod1mgA14qVySLK2c4DplBsTjl+i/P4bYLKJ5N0UfhWDx4nB4/ONgl2cSiTjZbpeHOj6TgVf9pQf7SIy4hJGqItkc34DxzvUqHoKrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745216360; c=relaxed/simple;
	bh=HwzV/ngFo9XRIYxSDILlQawp4GJu4SEL5rBHh5jL5RA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HwX4924EjOk0mtejDC7O8u3iS2zs9JfI6yU5dIh++8yws56m57cNx/Jiy4UuMyh8cGuEzm/RHwNPy9n3Qi9yRqWD+4Herc4PzRbjhTnmEHF0CCIEQVw/iOvffLr+bxCYijaPdpW6xHATJIZ9Ou+wW/gj7qCGBXJ57+Ndg8Rpp0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YhID1sUr; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745216359; x=1776752359;
  h=date:from:to:cc:subject:message-id;
  bh=HwzV/ngFo9XRIYxSDILlQawp4GJu4SEL5rBHh5jL5RA=;
  b=YhID1sUrvQlGc2bYYKwzPrjqnJfzwgSjt7O18sjgphdr0Lhz2uFph5D2
   5y3uqwZFNHM53QtF6UYixgep26Ou1ov4YtLjkjDG5OfYaGpiICCUx1cDf
   vtFQE3HXRlCFJz9eB8CgxO6dutgi9vShYLjxqvFKKL6v0G6fo46yBjQWz
   icaZVdED8MZL6Lstcqx1G68SlqZfaCwsyMxdpLdAwJJIr0/EgmnOwViEe
   xDdfNxHi9kmw9UGwdTvX1SFp1pRIEu/ayCcXE03w3wjWOO21rlv1vmXe2
   eZ7WPrTwXLZlfLl4Z0RwYZuZpnRgV2IkZzsDZRyweM3bZygTv2XJjjHHk
   w==;
X-CSE-ConnectionGUID: u1wCgMXoT42JRRfFRlAWAA==
X-CSE-MsgGUID: X+bMStW+RxydpAxkyfwONg==
X-IronPort-AV: E=McAfee;i="6700,10204,11409"; a="57404596"
X-IronPort-AV: E=Sophos;i="6.15,227,1739865600"; 
   d="scan'208";a="57404596"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2025 23:19:18 -0700
X-CSE-ConnectionGUID: PNqC+st+R/6StFVWt2uFag==
X-CSE-MsgGUID: 6pQyVe0yRXqM4mwY9N7A4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,227,1739865600"; 
   d="scan'208";a="154810559"
Received: from lkp-server01.sh.intel.com (HELO 9c2f37e2d822) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 20 Apr 2025 23:19:17 -0700
Received: from kbuild by 9c2f37e2d822 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u6kUs-0000CH-2J;
	Mon, 21 Apr 2025 06:19:14 +0000
Date: Mon, 21 Apr 2025 14:18:28 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 6f3972af178b8d717c91ccde6cf2a43913b15e59
Message-ID: <202504211418.lTMnBJco-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 6f3972af178b8d717c91ccde6cf2a43913b15e59  Merge branch into tip/master: 'x86/sev'

elapsed time: 1447m

configs tested: 140
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                          axs103_defconfig    gcc-14.2.0
arc                      axs103_smp_defconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250420    gcc-12.4.0
arc                   randconfig-002-20250420    gcc-12.4.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    clang-21
arm                      footbridge_defconfig    clang-17
arm                   randconfig-001-20250420    clang-21
arm                   randconfig-002-20250420    gcc-8.5.0
arm                   randconfig-003-20250420    gcc-7.5.0
arm                   randconfig-004-20250420    gcc-8.5.0
arm                          sp7021_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250420    gcc-8.5.0
arm64                 randconfig-002-20250420    gcc-8.5.0
arm64                 randconfig-003-20250420    clang-21
arm64                 randconfig-004-20250420    gcc-6.5.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250420    gcc-14.2.0
csky                  randconfig-002-20250420    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250420    clang-21
hexagon               randconfig-002-20250420    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250420    clang-20
i386        buildonly-randconfig-002-20250420    clang-20
i386        buildonly-randconfig-003-20250420    clang-20
i386        buildonly-randconfig-004-20250420    clang-20
i386        buildonly-randconfig-005-20250420    clang-20
i386        buildonly-randconfig-006-20250420    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250420    gcc-12.4.0
loongarch             randconfig-002-20250420    gcc-12.4.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       bvme6000_defconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                           virt_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                      maltaaprp_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250420    gcc-14.2.0
nios2                 randconfig-002-20250420    gcc-8.5.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                generic-32bit_defconfig    gcc-14.2.0
parisc                randconfig-001-20250420    gcc-13.3.0
parisc                randconfig-002-20250420    gcc-7.5.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                   bluestone_defconfig    clang-21
powerpc                      cm5200_defconfig    clang-21
powerpc                       holly_defconfig    clang-21
powerpc                      mgcoge_defconfig    clang-21
powerpc               randconfig-001-20250420    clang-21
powerpc               randconfig-002-20250420    gcc-6.5.0
powerpc               randconfig-003-20250420    clang-21
powerpc64             randconfig-001-20250420    gcc-8.5.0
powerpc64             randconfig-002-20250420    clang-21
powerpc64             randconfig-003-20250420    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250420    clang-21
riscv                 randconfig-002-20250420    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250420    gcc-6.5.0
s390                  randconfig-002-20250420    gcc-9.3.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                     magicpanelr2_defconfig    gcc-14.2.0
sh                    randconfig-001-20250420    gcc-14.2.0
sh                    randconfig-002-20250420    gcc-14.2.0
sh                            titan_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250420    gcc-11.5.0
sparc                 randconfig-002-20250420    gcc-7.5.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250420    gcc-9.3.0
sparc64               randconfig-002-20250420    gcc-13.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250420    gcc-12
um                    randconfig-002-20250420    clang-21
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250420    clang-20
x86_64      buildonly-randconfig-002-20250420    gcc-12
x86_64      buildonly-randconfig-003-20250420    gcc-12
x86_64      buildonly-randconfig-004-20250420    gcc-12
x86_64      buildonly-randconfig-005-20250420    clang-20
x86_64      buildonly-randconfig-006-20250420    clang-20
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250420    gcc-9.3.0
xtensa                randconfig-002-20250420    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


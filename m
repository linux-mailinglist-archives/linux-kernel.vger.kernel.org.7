Return-Path: <linux-kernel+bounces-822507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6AFB84083
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8913954394F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AC0302166;
	Thu, 18 Sep 2025 10:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CYD+tbB0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D462F8BC0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190673; cv=none; b=Wb0pT/Zooev6CuiXvp4aFy5DxFxBorlQm7QxWHwH8ze3tORwNCOEFGZzCdYYT7m8BkBiKiOCbT/1yllvykADVzjIQBCUVj5wVoJEfd8dj9pFNt/Lf/tOfytle6kwKZjMEWeOVegDj+npYVGrjTQmx8W93CIC8dLICP2REx7q3do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190673; c=relaxed/simple;
	bh=2/XHcHl6cF0oJAlbwV1MUyhWN/yOq61DtQPGaO1yl2c=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Y0JVvUVo325tJEF7FR4F2vA5qyVNPpJCRkGHQNTvtG3b/9rE0az5XsSwPW1+m3UCBM4zjjIeVRTgn4AR6oWQnqP49V6ekH54TlErIrH69x6R6RRmZ87clT/QvcSZh8tTShmbBa9oOyA9VFIOa2oOYF0YR3CbPvtqWBR2BFQHK6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CYD+tbB0; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758190672; x=1789726672;
  h=date:from:to:cc:subject:message-id;
  bh=2/XHcHl6cF0oJAlbwV1MUyhWN/yOq61DtQPGaO1yl2c=;
  b=CYD+tbB0c/u5MwKzss9v2fbJhstVYE6kFMhwWzH+W5/RQVwaeyGCMFbT
   iOB95tbmXiDaIO5oFCMQsdHEkfU8Jp62bM1ZeU42ryJIMWEThFXNUrR5R
   Tf8t11kK8wO0Sy5/GvE+nr5112AlK/hgsXZGrdoaZOvWU+wLznFe4f3UI
   TBHrYsy1WqWfImZCJ56A99+cetS6KrCh/e+wLVj+2xTp1SfjqE/22vdTO
   Weqo9cBWwtL/FO/nQgJ8qas02rH22BASg0tT/nfgrLu7tt2MSi+OzkRz6
   1P4hoLejRZMjV7LOczclbj7Fkv3CJrF4JUfIUuflYE9lo2sLLu0Oq/wtd
   g==;
X-CSE-ConnectionGUID: jgrl7K1JS+2zHVzIeuWcvw==
X-CSE-MsgGUID: Zxtkib9YRHKCcYlau2vjTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="71620371"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="71620371"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 03:17:46 -0700
X-CSE-ConnectionGUID: LRmk3vKpQ6muh1Htvi6yjw==
X-CSE-MsgGUID: 9hT58eWZR1yHZrtkrmw8LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="199205646"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 18 Sep 2025 03:17:45 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uzBhu-00036b-1v;
	Thu, 18 Sep 2025 10:17:42 +0000
Date: Thu, 18 Sep 2025 18:17:00 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 dfca7e9ecc40e65628853594957725fa2d4a3faf
Message-ID: <202509181854.QDieEGbs-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: dfca7e9ecc40e65628853594957725fa2d4a3faf  Merge branch into tip/master: 'x86/tdx'

elapsed time: 1461m

configs tested: 106
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20250917    gcc-8.5.0
arc                   randconfig-002-20250917    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                   randconfig-001-20250917    clang-22
arm                   randconfig-002-20250917    gcc-12.5.0
arm                   randconfig-003-20250917    gcc-10.5.0
arm                   randconfig-004-20250917    clang-22
arm                           sama5_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250917    clang-22
arm64                 randconfig-002-20250917    clang-19
arm64                 randconfig-003-20250917    gcc-10.5.0
arm64                 randconfig-004-20250917    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250917    gcc-12.5.0
csky                  randconfig-002-20250917    gcc-9.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250917    clang-22
hexagon               randconfig-002-20250917    clang-22
i386        buildonly-randconfig-001-20250917    gcc-14
i386        buildonly-randconfig-002-20250917    clang-20
i386        buildonly-randconfig-003-20250917    gcc-14
i386        buildonly-randconfig-004-20250917    gcc-14
i386        buildonly-randconfig-005-20250917    gcc-14
i386        buildonly-randconfig-006-20250917    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250917    gcc-15.1.0
loongarch             randconfig-002-20250917    gcc-15.1.0
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
nios2                 randconfig-001-20250917    gcc-11.5.0
nios2                 randconfig-002-20250917    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250917    gcc-14.3.0
parisc                randconfig-002-20250917    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                       holly_defconfig    clang-22
powerpc                 mpc836x_rdk_defconfig    clang-22
powerpc               randconfig-001-20250917    clang-18
powerpc               randconfig-002-20250917    clang-22
powerpc               randconfig-003-20250917    gcc-9.5.0
powerpc                     sequoia_defconfig    clang-17
powerpc                      tqm8xx_defconfig    clang-19
powerpc64             randconfig-001-20250917    clang-19
powerpc64             randconfig-002-20250917    gcc-8.5.0
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250917    gcc-14.3.0
riscv                 randconfig-002-20250917    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250917    clang-22
s390                  randconfig-002-20250917    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                          r7785rp_defconfig    gcc-15.1.0
sh                    randconfig-001-20250917    gcc-14.3.0
sh                    randconfig-002-20250917    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250917    gcc-8.5.0
sparc                 randconfig-002-20250917    gcc-14.3.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250917    gcc-11.5.0
sparc64               randconfig-002-20250917    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250917    gcc-14
um                    randconfig-002-20250917    gcc-14
x86_64      buildonly-randconfig-001-20250917    gcc-14
x86_64      buildonly-randconfig-002-20250917    clang-20
x86_64      buildonly-randconfig-003-20250917    clang-20
x86_64      buildonly-randconfig-004-20250917    clang-20
x86_64      buildonly-randconfig-005-20250917    clang-20
x86_64      buildonly-randconfig-006-20250917    gcc-12
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250917    gcc-8.5.0
xtensa                randconfig-002-20250917    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


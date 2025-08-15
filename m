Return-Path: <linux-kernel+bounces-770106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C429AB276CB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90271189ED64
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC711CEACB;
	Fri, 15 Aug 2025 03:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aaf4XOdU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5933136358
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 03:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755228648; cv=none; b=STsoNYtC03SvgXEstlD+cb0ncGZhkhZ2kXSsnmcHLCLiggUCwHvGi3/kUqr0B6wlzI/qXSJXOGo7V7Lkk0kzEwEdmRabz/XbsUOHckPWmuiDU9kYRdZe2fkRw0d5qUxoQX4jEbFDPNTcFZkRWRAu5LNqCk5hlZTbxw6ygJvf99Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755228648; c=relaxed/simple;
	bh=Qg001yRlTINgTWH7RNG0F3vLWRZHFPjodmfO3hgLfSM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KMozElh66jR0ak5WOC7NnUy6jOK4bDShfFx19Xm1YvwtM/M86uOq+FCDxxzwyRFtT8Cs6wrx6M73LxPuACHRchsqj0MAxHjqLe7y0FIW+l/bqGZ0WRNGWe7I3JsvKV8cMZWxjJQr6L4cTnfROA+HSpZ2/LyEwUn8guvK4oPuIUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Aaf4XOdU; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755228646; x=1786764646;
  h=date:from:to:cc:subject:message-id;
  bh=Qg001yRlTINgTWH7RNG0F3vLWRZHFPjodmfO3hgLfSM=;
  b=Aaf4XOdUUxjTmySSnenyEx7tMNnHD9mKVj1ZWHDx5QhOqfGUlDf4ZyRl
   twtY4jwKr4m4gTNLXQgYmuUr4DyVR4Npp7BbiSKKUrqm+IW+FBBEyySro
   R05YG59uCMjZYcykH/l4N3WWbxCtkKOEcno3Md9873obLwQRCAGie7ane
   SetfZEVxpdsG/qhfhceslv082gbTWjEml4y56ra59a3A8BnZEY0sBxc2K
   +zGaOJcDpHOm5O4XLgEbgGYdJQrXgJ0hjUMvW2zzUPrj3wyhBXw6z4LkD
   MoSoXFqrzNHL6gF9bA7Xvv5zqyEdfyewDGvxhMYRFCR5kpo5pgjxl/bpq
   w==;
X-CSE-ConnectionGUID: Kimlrh/XTGmm+aPqx0UQ1Q==
X-CSE-MsgGUID: ndDhc49rRkupF2bR/6CYZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="61397009"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="61397009"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 20:30:46 -0700
X-CSE-ConnectionGUID: 361VOk0WQDWZ0idiGkG4pA==
X-CSE-MsgGUID: uYtb+ILVTjCcKdnl2Ezd7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="166106276"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 14 Aug 2025 20:30:45 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uml94-000BVg-0C;
	Fri, 15 Aug 2025 03:30:39 +0000
Date: Fri, 15 Aug 2025 11:30:13 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:tip/urgent] BUILD SUCCESS
 7cbdb8a9d7afeed921cf623bd2b65e17e461d4cd
Message-ID: <202508151104.Ey0lEtCA-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tip/urgent
branch HEAD: 7cbdb8a9d7afeed921cf623bd2b65e17e461d4cd  Merge branch into tip/master: 'x86/urgent'

elapsed time: 1255m

configs tested: 223
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20250814    gcc-12.5.0
arc                   randconfig-002-20250814    gcc-13.4.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                          pxa910_defconfig    gcc-15.1.0
arm                   randconfig-001-20250814    clang-22
arm                   randconfig-002-20250814    clang-22
arm                   randconfig-003-20250814    gcc-10.5.0
arm                   randconfig-004-20250814    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250814    clang-17
arm64                 randconfig-002-20250814    gcc-8.5.0
arm64                 randconfig-003-20250814    gcc-10.5.0
arm64                 randconfig-004-20250814    gcc-13.4.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250814    gcc-15.1.0
csky                  randconfig-001-20250815    gcc-11.5.0
csky                  randconfig-002-20250814    gcc-15.1.0
csky                  randconfig-002-20250815    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250814    clang-20
hexagon               randconfig-001-20250815    gcc-11.5.0
hexagon               randconfig-002-20250814    clang-22
hexagon               randconfig-002-20250815    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250814    clang-20
i386        buildonly-randconfig-001-20250815    gcc-12
i386        buildonly-randconfig-002-20250814    gcc-12
i386        buildonly-randconfig-002-20250815    gcc-12
i386        buildonly-randconfig-003-20250814    gcc-12
i386        buildonly-randconfig-003-20250815    gcc-12
i386        buildonly-randconfig-004-20250814    clang-20
i386        buildonly-randconfig-004-20250815    gcc-12
i386        buildonly-randconfig-005-20250814    gcc-12
i386        buildonly-randconfig-005-20250815    gcc-12
i386        buildonly-randconfig-006-20250814    gcc-12
i386        buildonly-randconfig-006-20250815    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250815    gcc-12
i386                  randconfig-002-20250815    gcc-12
i386                  randconfig-003-20250815    gcc-12
i386                  randconfig-004-20250815    gcc-12
i386                  randconfig-005-20250815    gcc-12
i386                  randconfig-006-20250815    gcc-12
i386                  randconfig-007-20250815    gcc-12
i386                  randconfig-011-20250815    gcc-12
i386                  randconfig-012-20250815    gcc-12
i386                  randconfig-013-20250815    gcc-12
i386                  randconfig-014-20250815    gcc-12
i386                  randconfig-015-20250815    gcc-12
i386                  randconfig-016-20250815    gcc-12
i386                  randconfig-017-20250815    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250814    clang-22
loongarch             randconfig-001-20250815    gcc-11.5.0
loongarch             randconfig-002-20250814    gcc-15.1.0
loongarch             randconfig-002-20250815    gcc-11.5.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250814    gcc-10.5.0
nios2                 randconfig-001-20250815    gcc-11.5.0
nios2                 randconfig-002-20250814    gcc-9.5.0
nios2                 randconfig-002-20250815    gcc-11.5.0
openrisc                         alldefconfig    gcc-15.1.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250814    gcc-10.5.0
parisc                randconfig-001-20250815    gcc-11.5.0
parisc                randconfig-002-20250814    gcc-13.4.0
parisc                randconfig-002-20250815    gcc-11.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                      mgcoge_defconfig    gcc-15.1.0
powerpc               mpc834x_itxgp_defconfig    gcc-15.1.0
powerpc                  mpc866_ads_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250814    gcc-8.5.0
powerpc               randconfig-001-20250815    gcc-11.5.0
powerpc               randconfig-002-20250814    gcc-8.5.0
powerpc               randconfig-002-20250815    gcc-11.5.0
powerpc               randconfig-003-20250814    gcc-10.5.0
powerpc               randconfig-003-20250815    gcc-11.5.0
powerpc64             randconfig-001-20250814    clang-22
powerpc64             randconfig-001-20250815    gcc-11.5.0
powerpc64             randconfig-002-20250814    clang-22
powerpc64             randconfig-002-20250815    gcc-11.5.0
powerpc64             randconfig-003-20250814    clang-22
powerpc64             randconfig-003-20250815    gcc-11.5.0
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250814    clang-22
riscv                 randconfig-002-20250814    clang-22
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250814    clang-22
s390                  randconfig-002-20250814    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250814    gcc-9.5.0
sh                    randconfig-002-20250814    gcc-15.1.0
sh                   secureedge5410_defconfig    gcc-15.1.0
sh                          urquell_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250814    gcc-14.3.0
sparc                 randconfig-002-20250814    gcc-12.5.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250814    clang-22
sparc64               randconfig-002-20250814    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250814    clang-22
um                    randconfig-002-20250814    clang-22
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250814    clang-20
x86_64      buildonly-randconfig-002-20250814    clang-20
x86_64      buildonly-randconfig-003-20250814    gcc-12
x86_64      buildonly-randconfig-004-20250814    clang-20
x86_64      buildonly-randconfig-005-20250814    gcc-12
x86_64      buildonly-randconfig-006-20250814    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250815    gcc-12
x86_64                randconfig-002-20250815    gcc-12
x86_64                randconfig-003-20250815    gcc-12
x86_64                randconfig-004-20250815    gcc-12
x86_64                randconfig-005-20250815    gcc-12
x86_64                randconfig-006-20250815    gcc-12
x86_64                randconfig-007-20250815    gcc-12
x86_64                randconfig-008-20250815    gcc-12
x86_64                randconfig-071-20250815    clang-20
x86_64                randconfig-072-20250815    clang-20
x86_64                randconfig-073-20250815    clang-20
x86_64                randconfig-074-20250815    clang-20
x86_64                randconfig-075-20250815    clang-20
x86_64                randconfig-076-20250815    clang-20
x86_64                randconfig-077-20250815    clang-20
x86_64                randconfig-078-20250815    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250814    gcc-8.5.0
xtensa                randconfig-002-20250814    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


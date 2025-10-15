Return-Path: <linux-kernel+bounces-854001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C364BDD4E2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 803AA1924416
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130FD2D23AD;
	Wed, 15 Oct 2025 08:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V4gbXPwE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1091313957E
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 08:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760515458; cv=none; b=XH0+S8UUwJWgwjwukvchxXK+6f4jXoqRSirX5wzsx85xwlSNHjqXr6moSjyRaEv1oqFW77ABF3S/Q2Ew4zb/YBomDpJzygXyavIlHm2DXEav70QYv2xNiOF9RoJ/En47LeHCriyuT6ieytRdxEXpdi1SYzfgg6aNxslBdlrmSW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760515458; c=relaxed/simple;
	bh=iwI93jWOnxHhDR7dbPhyHeaXPSTrMASo1X2swEEiQlQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=TM5zzzPMg44zNwfchNynBQeNix27K261KUAZnwkmyIpIlk4RXh3FOFmeSy+UEr5vhQ7rUAFE5nZRbUq0j8poxzweMllW/AM52YPfmOH0h10Qob1gOGX3gx37fNTzooIGudJAZ32PrekXMYYk4+270jljQGkcNxfONANkvsf5NSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V4gbXPwE; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760515457; x=1792051457;
  h=date:from:to:cc:subject:message-id;
  bh=iwI93jWOnxHhDR7dbPhyHeaXPSTrMASo1X2swEEiQlQ=;
  b=V4gbXPwEfrpmKjFp+1dXaZLNmDcFQ6C+6UA3HqJpTvPW3nu29oNgCD2B
   pPPLnwfvQxyCiiZjvWZo83zqG6axCJ78aksD6iWvQT+oJ1wA8oqJFdapC
   8NHwpj5M6WA+67IrdnArCCKpfsF4reO33bN+atGWEQYUiKbMlja+W9Loq
   68KKRvdnGu1sfEbU6oXiUNgBOzlA6Mw5uVhuBh+LvHvX/8vODwab9EU3P
   uTANIDkT/brnaZf9EBs3dPDhhuY4NjVGG1zBApKlOc85kxPTEtrzlqgrN
   5RAOugouWf+rcAfPZSraU/h/HDCWZBttfcK11kz/xT62AGjev9A/awo/j
   g==;
X-CSE-ConnectionGUID: itsLmeR3QpCvwPSYDFhwMQ==
X-CSE-MsgGUID: gZLiwNyYRPip9EvvMhqc9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="66510454"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="66510454"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 01:04:16 -0700
X-CSE-ConnectionGUID: iPOI9NrBRQitixT6KBgT5A==
X-CSE-MsgGUID: isTaD+NuTeqMzrUl023mdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="187401726"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 15 Oct 2025 01:04:14 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v8wUR-0003cF-39;
	Wed, 15 Oct 2025 08:04:08 +0000
Date: Wed, 15 Oct 2025 16:03:38 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 17e3e88ed0b6318fde0d1c14df1a804711cab1b5
Message-ID: <202510151633.jxQ1o3Z6-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/urgent
branch HEAD: 17e3e88ed0b6318fde0d1c14df1a804711cab1b5  sched/fair: Fix pelt lost idle time detection

elapsed time: 1180m

configs tested: 254
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-15.1.0
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                         haps_hs_defconfig    gcc-15.1.0
arc                        nsim_700_defconfig    clang-22
arc                   randconfig-001-20251014    gcc-15.1.0
arc                   randconfig-001-20251015    gcc-8.5.0
arc                   randconfig-002-20251014    gcc-8.5.0
arc                   randconfig-002-20251015    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                         bcm2835_defconfig    clang-22
arm                                 defconfig    clang-19
arm                        multi_v7_defconfig    clang-22
arm                   randconfig-001-20251014    gcc-15.1.0
arm                   randconfig-001-20251015    gcc-8.5.0
arm                   randconfig-002-20251014    gcc-13.4.0
arm                   randconfig-002-20251015    gcc-8.5.0
arm                   randconfig-003-20251014    clang-16
arm                   randconfig-003-20251015    gcc-8.5.0
arm                   randconfig-004-20251014    gcc-8.5.0
arm                   randconfig-004-20251015    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20251014    gcc-9.5.0
arm64                 randconfig-001-20251015    gcc-8.5.0
arm64                 randconfig-002-20251014    gcc-10.5.0
arm64                 randconfig-002-20251015    gcc-8.5.0
arm64                 randconfig-003-20251014    gcc-14.3.0
arm64                 randconfig-003-20251015    gcc-8.5.0
arm64                 randconfig-004-20251014    gcc-14.3.0
arm64                 randconfig-004-20251015    gcc-8.5.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20251014    gcc-15.1.0
csky                  randconfig-001-20251015    clang-22
csky                  randconfig-002-20251014    gcc-13.4.0
csky                  randconfig-002-20251015    clang-22
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20251014    clang-22
hexagon               randconfig-001-20251015    clang-22
hexagon               randconfig-002-20251014    clang-22
hexagon               randconfig-002-20251015    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251014    gcc-14
i386        buildonly-randconfig-001-20251015    clang-20
i386        buildonly-randconfig-002-20251014    clang-20
i386        buildonly-randconfig-002-20251015    clang-20
i386        buildonly-randconfig-003-20251014    clang-20
i386        buildonly-randconfig-003-20251015    clang-20
i386        buildonly-randconfig-004-20251014    gcc-14
i386        buildonly-randconfig-004-20251015    clang-20
i386        buildonly-randconfig-005-20251014    gcc-14
i386        buildonly-randconfig-005-20251015    clang-20
i386        buildonly-randconfig-006-20251014    clang-20
i386        buildonly-randconfig-006-20251015    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20251015    clang-20
i386                  randconfig-002-20251015    clang-20
i386                  randconfig-003-20251015    clang-20
i386                  randconfig-004-20251015    clang-20
i386                  randconfig-005-20251015    clang-20
i386                  randconfig-006-20251015    clang-20
i386                  randconfig-007-20251015    clang-20
i386                  randconfig-011-20251015    clang-20
i386                  randconfig-012-20251015    clang-20
i386                  randconfig-013-20251015    clang-20
i386                  randconfig-014-20251015    clang-20
i386                  randconfig-015-20251015    clang-20
i386                  randconfig-016-20251015    clang-20
i386                  randconfig-017-20251015    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251014    clang-18
loongarch             randconfig-001-20251015    clang-22
loongarch             randconfig-002-20251014    gcc-15.1.0
loongarch             randconfig-002-20251015    clang-22
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                       m5475evb_defconfig    gcc-15.1.0
m68k                          multi_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        bcm63xx_defconfig    gcc-15.1.0
mips                           gcw0_defconfig    gcc-15.1.0
mips                           ip22_defconfig    gcc-15.1.0
mips                           ip30_defconfig    clang-22
mips                           mtx1_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20251014    gcc-11.5.0
nios2                 randconfig-001-20251015    clang-22
nios2                 randconfig-002-20251014    gcc-8.5.0
nios2                 randconfig-002-20251015    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251014    gcc-11.5.0
parisc                randconfig-001-20251015    clang-22
parisc                randconfig-002-20251014    gcc-9.5.0
parisc                randconfig-002-20251015    clang-22
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                     ksi8560_defconfig    gcc-15.1.0
powerpc                   motionpro_defconfig    gcc-15.1.0
powerpc                     ppa8548_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251014    gcc-9.5.0
powerpc               randconfig-001-20251015    clang-22
powerpc               randconfig-002-20251014    clang-22
powerpc               randconfig-002-20251015    clang-22
powerpc               randconfig-003-20251014    gcc-14.3.0
powerpc               randconfig-003-20251015    clang-22
powerpc64             randconfig-001-20251014    gcc-8.5.0
powerpc64             randconfig-001-20251015    clang-22
powerpc64             randconfig-002-20251014    gcc-8.5.0
powerpc64             randconfig-002-20251015    clang-22
powerpc64             randconfig-003-20251014    gcc-8.5.0
powerpc64             randconfig-003-20251015    clang-22
riscv                            alldefconfig    clang-22
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                    nommu_virt_defconfig    clang-22
riscv                 randconfig-001-20251014    gcc-10.5.0
riscv                 randconfig-001-20251015    clang-22
riscv                 randconfig-002-20251014    gcc-10.5.0
riscv                 randconfig-002-20251015    clang-22
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20251014    clang-22
s390                  randconfig-001-20251015    clang-22
s390                  randconfig-002-20251014    clang-19
s390                  randconfig-002-20251015    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                ecovec24-romimage_defconfig    gcc-15.1.0
sh                        edosk7760_defconfig    clang-22
sh                    randconfig-001-20251014    gcc-14.3.0
sh                    randconfig-001-20251015    clang-22
sh                    randconfig-002-20251014    gcc-11.5.0
sh                    randconfig-002-20251015    clang-22
sh                          sdk7786_defconfig    gcc-15.1.0
sh                           se7724_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251014    gcc-15.1.0
sparc                 randconfig-001-20251015    clang-22
sparc                 randconfig-002-20251014    gcc-15.1.0
sparc                 randconfig-002-20251015    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251014    clang-20
sparc64               randconfig-001-20251015    clang-22
sparc64               randconfig-002-20251014    clang-22
sparc64               randconfig-002-20251015    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251014    gcc-14
um                    randconfig-001-20251015    clang-22
um                    randconfig-002-20251014    gcc-14
um                    randconfig-002-20251015    clang-22
um                           x86_64_defconfig    gcc-14
um                           x86_64_defconfig    gcc-15.1.0
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251014    gcc-14
x86_64      buildonly-randconfig-001-20251015    gcc-13
x86_64      buildonly-randconfig-002-20251014    clang-20
x86_64      buildonly-randconfig-002-20251015    gcc-13
x86_64      buildonly-randconfig-003-20251014    gcc-14
x86_64      buildonly-randconfig-003-20251015    gcc-13
x86_64      buildonly-randconfig-004-20251014    clang-20
x86_64      buildonly-randconfig-004-20251015    gcc-13
x86_64      buildonly-randconfig-005-20251014    clang-20
x86_64      buildonly-randconfig-005-20251015    gcc-13
x86_64      buildonly-randconfig-006-20251014    gcc-14
x86_64      buildonly-randconfig-006-20251015    gcc-13
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251015    clang-20
x86_64                randconfig-002-20251015    clang-20
x86_64                randconfig-003-20251015    clang-20
x86_64                randconfig-004-20251015    clang-20
x86_64                randconfig-005-20251015    clang-20
x86_64                randconfig-006-20251015    clang-20
x86_64                randconfig-007-20251015    clang-20
x86_64                randconfig-008-20251015    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251014    gcc-8.5.0
xtensa                randconfig-001-20251015    clang-22
xtensa                randconfig-002-20251014    gcc-8.5.0
xtensa                randconfig-002-20251015    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


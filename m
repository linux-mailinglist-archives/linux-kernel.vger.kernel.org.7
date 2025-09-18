Return-Path: <linux-kernel+bounces-822390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE6FB83BAF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40D061C2189B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9BB29BDB9;
	Thu, 18 Sep 2025 09:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IPtcS4xR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91C82D24B8
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758186939; cv=none; b=joX2d9iob8nDeKmQV59V6HTovdnU4cMJQBJLPqmE84H+E60Q0gxXbPl39dE3XqhL5LKcZrUwxDcDETbSExnsRspq1TtmZPXnkZSIgy81WHbotuWI87ybq5SVf4WsnLigP98HC9aotEbn+dKKDuLivDbp8BKHLXLvRDmAzhqYXnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758186939; c=relaxed/simple;
	bh=+TP7HmEd9hW4N/jp1SamrWFKTnzI51eA5zKjkdMyc/w=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PHS6gTqL2E4NnBY/KUrEflCaoCD2xemQHOCIJR2VyoUixiW5n1fKXzWFSKhz/OGu+ymRjncthkzbrM4n9ikgxB31Oku7nYYM5n0y0i59b9IYUeX5JDfoFXPvTHvzaREMuG+8ZM1xDhqvs+4PPrLRbkx/lvwsVpy10PyzxAWc4wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IPtcS4xR; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758186937; x=1789722937;
  h=date:from:to:cc:subject:message-id;
  bh=+TP7HmEd9hW4N/jp1SamrWFKTnzI51eA5zKjkdMyc/w=;
  b=IPtcS4xRdcOGzFxOzriHQ8HGn6wTJD5FzI1Xvk4d1IWCUN84TLCxQuZr
   1QQk2sopZG5BWF/A5tIpaPgk2u+yO+rEl6Svfpcdri27+tQPSdnMRLWhj
   W7sMbb5vCzJOiBns/cf72ytDY6NIapGZNktHx/jbQIlClv439i0wLW1B4
   HgS51OIyRgrSfKJ2mVgeR5yayr7tkh5WWnmJX3X32g9bSHCRvLOmzJyS6
   IdjVsNXU743ybVtcHsOAMvYfwcFX1JSzS4wTN0ABTUDo12Vgns11rCdqG
   k6nxxa8Ns/lrcLj5DmI6jLFmzVYp1XISenrtV+WlSNeZyO8a6CCjLnVuD
   w==;
X-CSE-ConnectionGUID: 2VAgZBgaQIC34zJ5UBdwaQ==
X-CSE-MsgGUID: mXEaVwglQ06HNZiV/XQc0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60430669"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60430669"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 02:15:37 -0700
X-CSE-ConnectionGUID: mOS/bcX9Teyl5uD4s2zZgQ==
X-CSE-MsgGUID: bCyIR8rKQwu974YeZtBkxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="212640666"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 18 Sep 2025 02:15:36 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uzAjl-00030u-2Z;
	Thu, 18 Sep 2025 09:15:33 +0000
Date: Thu, 18 Sep 2025 17:15:04 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:next] BUILD SUCCESS
 a38525f69074901a782e1d168812aa22bc27eab8
Message-ID: <202509181759.YKgIyjOW-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git next
branch HEAD: a38525f69074901a782e1d168812aa22bc27eab8  Merge branch 'torture.2025.08.14a' into HEAD

elapsed time: 1276m

configs tested: 233
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-22
arc                              allyesconfig    clang-19
arc                          axs101_defconfig    clang-22
arc                                 defconfig    clang-19
arc                   randconfig-001-20250917    gcc-8.5.0
arc                   randconfig-001-20250918    clang-22
arc                   randconfig-002-20250917    gcc-15.1.0
arc                   randconfig-002-20250918    clang-22
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                   milbeaut_m10v_defconfig    clang-22
arm                       netwinder_defconfig    clang-22
arm                   randconfig-001-20250917    clang-22
arm                   randconfig-001-20250918    clang-22
arm                   randconfig-002-20250917    gcc-12.5.0
arm                   randconfig-002-20250918    clang-22
arm                   randconfig-003-20250917    gcc-10.5.0
arm                   randconfig-003-20250918    clang-22
arm                   randconfig-004-20250917    clang-22
arm                   randconfig-004-20250918    clang-22
arm                         s5pv210_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250917    clang-22
arm64                 randconfig-001-20250918    clang-22
arm64                 randconfig-002-20250917    clang-19
arm64                 randconfig-002-20250918    clang-22
arm64                 randconfig-003-20250917    gcc-10.5.0
arm64                 randconfig-003-20250918    clang-22
arm64                 randconfig-004-20250917    clang-22
arm64                 randconfig-004-20250918    clang-22
csky                              allnoconfig    clang-22
csky                                defconfig    clang-19
csky                  randconfig-001-20250917    gcc-12.5.0
csky                  randconfig-001-20250918    clang-22
csky                  randconfig-002-20250917    gcc-9.5.0
csky                  randconfig-002-20250918    clang-22
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250917    clang-22
hexagon               randconfig-001-20250918    clang-22
hexagon               randconfig-002-20250917    clang-22
hexagon               randconfig-002-20250918    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250917    gcc-14
i386        buildonly-randconfig-001-20250918    gcc-14
i386        buildonly-randconfig-002-20250917    clang-20
i386        buildonly-randconfig-002-20250918    gcc-14
i386        buildonly-randconfig-003-20250917    gcc-14
i386        buildonly-randconfig-003-20250918    gcc-14
i386        buildonly-randconfig-004-20250917    gcc-14
i386        buildonly-randconfig-004-20250918    gcc-14
i386        buildonly-randconfig-005-20250917    gcc-14
i386        buildonly-randconfig-005-20250918    gcc-14
i386        buildonly-randconfig-006-20250917    clang-20
i386        buildonly-randconfig-006-20250918    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20250918    gcc-14
i386                  randconfig-002-20250918    gcc-14
i386                  randconfig-003-20250918    gcc-14
i386                  randconfig-004-20250918    gcc-14
i386                  randconfig-005-20250918    gcc-14
i386                  randconfig-006-20250918    gcc-14
i386                  randconfig-007-20250918    gcc-14
i386                  randconfig-011-20250918    gcc-14
i386                  randconfig-012-20250918    gcc-14
i386                  randconfig-013-20250918    gcc-14
i386                  randconfig-014-20250918    gcc-14
i386                  randconfig-015-20250918    gcc-14
i386                  randconfig-016-20250918    gcc-14
i386                  randconfig-017-20250918    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250917    gcc-15.1.0
loongarch             randconfig-001-20250918    clang-22
loongarch             randconfig-002-20250917    gcc-15.1.0
loongarch             randconfig-002-20250918    clang-22
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                         amcore_defconfig    clang-22
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        maltaup_defconfig    clang-22
mips                           mtx1_defconfig    clang-22
mips                         rt305x_defconfig    clang-22
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250917    gcc-11.5.0
nios2                 randconfig-001-20250918    clang-22
nios2                 randconfig-002-20250917    gcc-8.5.0
nios2                 randconfig-002-20250918    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250917    gcc-14.3.0
parisc                randconfig-001-20250918    clang-22
parisc                randconfig-002-20250917    gcc-14.3.0
parisc                randconfig-002-20250918    clang-22
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc               randconfig-001-20250917    clang-18
powerpc               randconfig-001-20250918    clang-22
powerpc               randconfig-002-20250917    clang-22
powerpc               randconfig-002-20250918    clang-22
powerpc               randconfig-003-20250917    gcc-9.5.0
powerpc               randconfig-003-20250918    clang-22
powerpc64             randconfig-001-20250917    clang-19
powerpc64             randconfig-001-20250918    clang-22
powerpc64             randconfig-002-20250917    gcc-8.5.0
powerpc64             randconfig-002-20250918    clang-22
powerpc64             randconfig-003-20250918    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20250917    gcc-14.3.0
riscv                 randconfig-001-20250918    gcc-10.5.0
riscv                 randconfig-002-20250917    clang-22
riscv                 randconfig-002-20250918    gcc-10.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20250917    clang-22
s390                  randconfig-001-20250918    gcc-10.5.0
s390                  randconfig-002-20250917    gcc-8.5.0
s390                  randconfig-002-20250918    gcc-10.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20250917    gcc-14.3.0
sh                    randconfig-001-20250918    gcc-10.5.0
sh                    randconfig-002-20250917    gcc-15.1.0
sh                    randconfig-002-20250918    gcc-10.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250917    gcc-8.5.0
sparc                 randconfig-001-20250918    gcc-10.5.0
sparc                 randconfig-002-20250917    gcc-14.3.0
sparc                 randconfig-002-20250918    gcc-10.5.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20250917    gcc-11.5.0
sparc64               randconfig-001-20250918    gcc-10.5.0
sparc64               randconfig-002-20250917    gcc-8.5.0
sparc64               randconfig-002-20250918    gcc-10.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250917    gcc-14
um                    randconfig-001-20250918    gcc-10.5.0
um                    randconfig-002-20250917    gcc-14
um                    randconfig-002-20250918    gcc-10.5.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250917    gcc-14
x86_64      buildonly-randconfig-001-20250918    clang-20
x86_64      buildonly-randconfig-002-20250917    clang-20
x86_64      buildonly-randconfig-002-20250918    clang-20
x86_64      buildonly-randconfig-003-20250917    clang-20
x86_64      buildonly-randconfig-003-20250918    clang-20
x86_64      buildonly-randconfig-004-20250917    clang-20
x86_64      buildonly-randconfig-004-20250918    clang-20
x86_64      buildonly-randconfig-005-20250917    clang-20
x86_64      buildonly-randconfig-005-20250918    clang-20
x86_64      buildonly-randconfig-006-20250917    gcc-12
x86_64      buildonly-randconfig-006-20250918    clang-20
x86_64                              defconfig    clang-20
x86_64                randconfig-001-20250918    gcc-12
x86_64                randconfig-002-20250918    gcc-12
x86_64                randconfig-003-20250918    gcc-12
x86_64                randconfig-004-20250918    gcc-12
x86_64                randconfig-005-20250918    gcc-12
x86_64                randconfig-006-20250918    gcc-12
x86_64                randconfig-007-20250918    gcc-12
x86_64                randconfig-008-20250918    gcc-12
x86_64                randconfig-071-20250918    clang-20
x86_64                randconfig-072-20250918    clang-20
x86_64                randconfig-073-20250918    clang-20
x86_64                randconfig-074-20250918    clang-20
x86_64                randconfig-075-20250918    clang-20
x86_64                randconfig-076-20250918    clang-20
x86_64                randconfig-077-20250918    clang-20
x86_64                randconfig-078-20250918    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250917    gcc-8.5.0
xtensa                randconfig-001-20250918    gcc-10.5.0
xtensa                randconfig-002-20250917    gcc-11.5.0
xtensa                randconfig-002-20250918    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-kernel+bounces-880982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6B5C271F0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 23:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ABB204E6FB6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 22:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD72C32AADE;
	Fri, 31 Oct 2025 22:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZXHWg664"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4876D32AADA
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 22:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761949323; cv=none; b=AP67j81tlIaBEPXvOn6IX4mCH40Nw+vuXMC+KWwXeD/TvgU6/Uq4vV9uMgBjA5E8t3XWKB0DKbV5KXJe3ZDtlefOXY2/831AfcbXyksqdphsAW16KQTjwZWLsEIfRS5ZvPzz14PpPniOVqZW4KOfQNV1SN27Q65HNSJp2aJARtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761949323; c=relaxed/simple;
	bh=/oBEVmQfT4jIYTPlmoK+o3J3u1LdT1SnbgPyEBMbhBI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WjA2pwTEkJf0smcNWKjgUDz4aI7Bqa81m6xchyim43ggAVbw0h6RhPOWU3HwNBEJJ49lrU6Hh9T4173kQT2Y5jFApY/aVetyVlGKs3zY/A8KiSkiSnEctbez0D3zY/hY+vccxZwQC+fJE3EuTY9x1g0Ga+Fh8Rc1sieh7PGXHxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZXHWg664; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761949321; x=1793485321;
  h=date:from:to:cc:subject:message-id;
  bh=/oBEVmQfT4jIYTPlmoK+o3J3u1LdT1SnbgPyEBMbhBI=;
  b=ZXHWg6649Y21v8GfzcgjI6ol8iP4/qPT48S7syVKIr2TtudWorWO+sRI
   sibNGw6H8HrjU4OsbMhupattTcr/iQFzlEe+BIQUUilffQHkVIRrpWoJk
   6QvFCCasJcXyGrIaIBHabkU3BcdDg+85NyTLdzjHEZ2A7pU2oeJ0za+XE
   D+FBuef7i1gxAHgmM6qQbBnWGgnP64lAzIIIjAfpul9ZQ4EnqBpat70W+
   4K1gYBfu6KXvm/1KR/IPEemN4gSaWS1oAphkUmfbLkjX3Ukj0t0CAGS82
   bOdFpJZVs5TPrIbD1da/DsPSxEDVQ0a95uqWoWd+OBJs5HnTLL1rkaqzL
   g==;
X-CSE-ConnectionGUID: /+gLaH23RMuow8VkFu+saw==
X-CSE-MsgGUID: i4EvWXoFRGyEVI3GorHeLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="63814101"
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="63814101"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 15:22:01 -0700
X-CSE-ConnectionGUID: hwMEwNwTRwql0w8w2L4vng==
X-CSE-MsgGUID: T8ndE8+cQKm/DDTeBR/L0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="191489232"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 31 Oct 2025 15:21:59 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vExVD-000Ngo-31;
	Fri, 31 Oct 2025 22:21:57 +0000
Date: Sat, 01 Nov 2025 06:19:41 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev] BUILD SUCCESS
 9231898def1e0a06e032afcda49a5b1d3d42f421
Message-ID: <202511010635.5HsxRwdU-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
branch HEAD: 9231898def1e0a06e032afcda49a5b1d3d42f421  srcu: Optimize SRCU-fast for arm64

elapsed time: 1370m

configs tested: 186
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251031    gcc-8.5.0
arc                   randconfig-002-20251031    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                                 defconfig    gcc-15.1.0
arm                      jornada720_defconfig    clang-22
arm                   randconfig-001-20251031    gcc-8.5.0
arm                   randconfig-002-20251031    gcc-8.5.0
arm                   randconfig-003-20251031    gcc-8.5.0
arm                   randconfig-004-20251031    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                            allyesconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251031    gcc-10.5.0
arm64                 randconfig-002-20251031    gcc-10.5.0
arm64                 randconfig-003-20251031    gcc-10.5.0
arm64                 randconfig-004-20251031    gcc-10.5.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251031    gcc-10.5.0
csky                  randconfig-002-20251031    gcc-10.5.0
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20251031    clang-22
hexagon               randconfig-002-20251031    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20251031    clang-20
i386        buildonly-randconfig-002-20251031    clang-20
i386        buildonly-randconfig-003-20251031    clang-20
i386        buildonly-randconfig-004-20251031    clang-20
i386        buildonly-randconfig-005-20251031    clang-20
i386        buildonly-randconfig-006-20251031    clang-20
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20251031    clang-20
i386                  randconfig-002-20251031    clang-20
i386                  randconfig-003-20251031    clang-20
i386                  randconfig-004-20251031    clang-20
i386                  randconfig-005-20251031    clang-20
i386                  randconfig-006-20251031    clang-20
i386                  randconfig-007-20251031    clang-20
i386                  randconfig-011-20251031    gcc-13
i386                  randconfig-012-20251031    gcc-13
i386                  randconfig-013-20251031    gcc-13
i386                  randconfig-014-20251031    gcc-13
i386                  randconfig-015-20251031    gcc-13
i386                  randconfig-016-20251031    gcc-13
i386                  randconfig-017-20251031    gcc-13
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                        allyesconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251031    clang-22
loongarch             randconfig-002-20251031    clang-22
m68k                             allmodconfig    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                                defconfig    clang-19
m68k                       m5208evb_defconfig    clang-22
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                            allyesconfig    clang-22
nios2                               defconfig    clang-19
nios2                 randconfig-001-20251031    clang-22
nios2                 randconfig-002-20251031    clang-22
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251031    clang-22
parisc                randconfig-002-20251031    clang-22
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                   lite5200b_defconfig    clang-22
powerpc                     mpc5200_defconfig    clang-22
powerpc               randconfig-001-20251031    clang-22
powerpc               randconfig-002-20251031    clang-22
powerpc64             randconfig-001-20251031    clang-22
powerpc64             randconfig-002-20251031    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-15.1.0
riscv                 randconfig-001-20251031    clang-17
riscv                 randconfig-002-20251031    clang-17
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20251031    clang-17
s390                  randconfig-002-20251031    clang-17
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20251031    clang-17
sh                    randconfig-002-20251031    clang-17
sh                           se7705_defconfig    clang-22
sh                           se7750_defconfig    clang-22
sh                            titan_defconfig    clang-22
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                            allyesconfig    clang-22
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251031    gcc-8.5.0
sparc                 randconfig-002-20251031    gcc-8.5.0
sparc64                          allmodconfig    clang-22
sparc64                          allyesconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251031    gcc-8.5.0
sparc64               randconfig-002-20251031    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251031    gcc-8.5.0
um                    randconfig-002-20251031    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251031    gcc-14
x86_64      buildonly-randconfig-002-20251031    gcc-14
x86_64      buildonly-randconfig-003-20251031    gcc-14
x86_64      buildonly-randconfig-004-20251031    gcc-14
x86_64      buildonly-randconfig-005-20251031    gcc-14
x86_64      buildonly-randconfig-006-20251031    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251031    gcc-14
x86_64                randconfig-002-20251031    gcc-14
x86_64                randconfig-003-20251031    gcc-14
x86_64                randconfig-004-20251031    gcc-14
x86_64                randconfig-005-20251031    gcc-14
x86_64                randconfig-006-20251031    gcc-14
x86_64                randconfig-011-20251031    gcc-14
x86_64                randconfig-012-20251031    gcc-14
x86_64                randconfig-013-20251031    gcc-14
x86_64                randconfig-014-20251031    gcc-14
x86_64                randconfig-015-20251031    gcc-14
x86_64                randconfig-016-20251031    gcc-14
x86_64                randconfig-071-20251031    clang-20
x86_64                randconfig-072-20251031    clang-20
x86_64                randconfig-073-20251031    clang-20
x86_64                randconfig-074-20251031    clang-20
x86_64                randconfig-075-20251031    clang-20
x86_64                randconfig-076-20251031    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20251031    gcc-8.5.0
xtensa                randconfig-002-20251031    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


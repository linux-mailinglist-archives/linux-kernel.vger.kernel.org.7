Return-Path: <linux-kernel+bounces-853991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E709BDD443
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 82BF34FCF2A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 07:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78EE315D47;
	Wed, 15 Oct 2025 07:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XRhkN0kZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01391221710
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760515148; cv=none; b=h5KtZcZjCuxXpV9RD0/2DqPSvHNxNACqDOx0QnOGiRd9vsg1DKRn9KUmZWXxMwSrIO7D/PjXl+2Kt4ndxXSrABDcVRHg8eruwfSEfU60PQHN3YWpSKnw3lcBtuvmQKrlo6BWG2MVUEhLmavU+S3NaYqd6oNPhGlUUgEMxnVRcjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760515148; c=relaxed/simple;
	bh=u4X5q6P/mCU+lPZIOuAHWIWiCihVSGzAyfvf2PaCGqU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Qg4rNa2Yodp4Qp0/7jqMbl8EnhzokamkkAgg0KDXdLnVbMkDpyISgbYMUFTmNHWcwYRy9lBLWvfhN/UzMDLkViRpT86kN2eRyDEyuGn/HpFAorXBVcY9t+tf90vVhtgKr0nq38Ncx3hKOoTV+mVhUF/mQjW9uPGDdiHPsqbLNu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XRhkN0kZ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760515132; x=1792051132;
  h=date:from:to:cc:subject:message-id;
  bh=u4X5q6P/mCU+lPZIOuAHWIWiCihVSGzAyfvf2PaCGqU=;
  b=XRhkN0kZQtZljJOSJscKoFogctJ8yUpG/QpUMYuXFpr9VZYU927sI8pN
   xc49Qgjr3NSH++JsZx+D/CZGQNCJcYVEQNLUxAhg1VB+FvY2gj1N7ef84
   sXJ43bUlaNhYWLMLeXz3kCJHmC2AhiBtaXE/d6DtC1Mzf/AyBghDPyNqJ
   FTOA7QQvOqDuArRYwUhwQMCcyQb8VyhmxacqJqbnhajkKO38EhrEb7TeT
   kfDBAL2KFYZjUTM5vai2SQwLSm/oh2ECrR0q2LyJmRwrjFcdkWdl+C9Qq
   Wf7sRd8VkzXIPboz05FBNngHIQhIsmFUoYn69PyxoktOfUh5m9DTTSDyO
   g==;
X-CSE-ConnectionGUID: y/Zvgx/rTPSNY3rTUxsMhQ==
X-CSE-MsgGUID: 8zcqxWSETMqgQKtPz5780w==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="73785262"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="73785262"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 00:58:51 -0700
X-CSE-ConnectionGUID: umpFlOg5QPaF3QODFnUeCA==
X-CSE-MsgGUID: woSUsOMsQty6F4UNPmt1bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="182529345"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 15 Oct 2025 00:58:50 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v8wPH-0003bh-31;
	Wed, 15 Oct 2025 07:58:47 +0000
Date: Wed, 15 Oct 2025 15:58:39 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/core] BUILD SUCCESS
 ad74016b919cbad78d203fa1c459ae18e73ce586
Message-ID: <202510151534.Fn1IJdjT-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
branch HEAD: ad74016b919cbad78d203fa1c459ae18e73ce586  x86/alternative: Drop not needed test after call of alt_replace_call()

elapsed time: 1030m

configs tested: 172
configs skipped: 128

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                              allyesconfig    clang-19
arc                                 defconfig    clang-19
arc                        nsim_700_defconfig    clang-22
arc                   randconfig-001-20251015    gcc-8.5.0
arc                   randconfig-002-20251015    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                              allyesconfig    clang-19
arm                         bcm2835_defconfig    clang-22
arm                                 defconfig    clang-19
arm                        multi_v7_defconfig    clang-22
arm                   randconfig-001-20251015    gcc-8.5.0
arm                   randconfig-002-20251015    gcc-8.5.0
arm                   randconfig-003-20251015    gcc-8.5.0
arm                   randconfig-004-20251015    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                               defconfig    clang-19
arm64                 randconfig-001-20251015    gcc-8.5.0
arm64                 randconfig-002-20251015    gcc-8.5.0
arm64                 randconfig-003-20251015    gcc-8.5.0
arm64                 randconfig-004-20251015    gcc-8.5.0
csky                                defconfig    clang-19
csky                  randconfig-001-20251015    clang-22
csky                  randconfig-002-20251015    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20251015    clang-22
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
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251015    clang-22
loongarch             randconfig-002-20251015    clang-22
m68k                             allmodconfig    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                                defconfig    clang-19
m68k                          multi_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        bcm63xx_defconfig    gcc-15.1.0
mips                           gcw0_defconfig    gcc-15.1.0
mips                           ip22_defconfig    gcc-15.1.0
mips                           ip30_defconfig    clang-22
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20251015    clang-22
nios2                 randconfig-002-20251015    clang-22
openrisc                          allnoconfig    clang-22
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251015    clang-22
parisc                randconfig-002-20251015    clang-22
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                   motionpro_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251015    clang-22
powerpc               randconfig-002-20251015    clang-22
powerpc               randconfig-003-20251015    clang-22
powerpc64             randconfig-001-20251015    clang-22
powerpc64             randconfig-002-20251015    clang-22
powerpc64             randconfig-003-20251015    clang-22
riscv                            alldefconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                    nommu_virt_defconfig    clang-22
riscv                 randconfig-001-20251015    clang-22
riscv                 randconfig-002-20251015    clang-22
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20251015    clang-22
s390                  randconfig-002-20251015    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                        edosk7760_defconfig    clang-22
sh                    randconfig-001-20251015    clang-22
sh                    randconfig-002-20251015    clang-22
sh                          sdk7786_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251015    clang-22
sparc                 randconfig-002-20251015    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251015    clang-22
sparc64               randconfig-002-20251015    clang-22
um                                allnoconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251015    clang-22
um                    randconfig-002-20251015    clang-22
um                           x86_64_defconfig    gcc-14
um                           x86_64_defconfig    gcc-15.1.0
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251015    clang-20
x86_64      buildonly-randconfig-001-20251015    gcc-13
x86_64      buildonly-randconfig-002-20251015    gcc-13
x86_64      buildonly-randconfig-002-20251015    gcc-14
x86_64      buildonly-randconfig-003-20251015    clang-20
x86_64      buildonly-randconfig-003-20251015    gcc-13
x86_64      buildonly-randconfig-004-20251015    clang-20
x86_64      buildonly-randconfig-004-20251015    gcc-13
x86_64      buildonly-randconfig-005-20251015    gcc-13
x86_64      buildonly-randconfig-005-20251015    gcc-14
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
xtensa                randconfig-001-20251015    clang-22
xtensa                randconfig-002-20251015    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


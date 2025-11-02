Return-Path: <linux-kernel+bounces-881906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A66D7C29305
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 18:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7878D1886F46
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 17:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF02121A459;
	Sun,  2 Nov 2025 17:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eBT5rdhU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B05B15E97
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 17:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762102853; cv=none; b=l/sMdtfCd39ikx3rwKo9hgorbxJWJxNi/fi785XlqQ5emUaVPhWwyLrgNoRTe6ARQmUu00NP6vcxTwWmuHln2J6gqQW9F2D9c0MUig/7Z3HGgxD/aAsb6j5laX5qVbJ6uaZm+m/WOjk6x5ctpVEJHMibK6CA4f9VtAsY1BfIpS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762102853; c=relaxed/simple;
	bh=eQk2Rvcz3zzyMzuQ5Jt1bAOfQcD7uG9oqBO8+XhLp9w=;
	h=Date:From:To:Cc:Subject:Message-ID; b=n2t4xYCqRkbBsik+tvG4zvEHL6kwbaZPNKS9eZtDy7lpPooU+DpVs9EYMlIAhlctkiwmk1BUdQ2wULpJl694KuF2cO3S7EC9wE2BqomxnIIriDGGoRchoCASDBDoZMpYXPYQeAItmsogkk0SQcDGc9KqMIqZ0yV1dFaBnY4Eh7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eBT5rdhU; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762102851; x=1793638851;
  h=date:from:to:cc:subject:message-id;
  bh=eQk2Rvcz3zzyMzuQ5Jt1bAOfQcD7uG9oqBO8+XhLp9w=;
  b=eBT5rdhUAIFv00q+3PPXD2fwSym1Jt2uoDk1BYFD21+UZ4pbQiOfGJBz
   4vwdFO+pzE4GPKmkFl0cDfUoba6t0sXgSkuL884cIUzhz12EtXzj+8WTv
   gcOuH3uUJ2CkbT/GAz3dvJiIHtxXTbiaV76THIH3K6wZajnDLfLuVnpC8
   2giYKex8pFQdW3RzY5uDJx0/X5sDnE257CYbbLFEKlOf7+xBlHgUYIumS
   LIK3UdrTw4S0fwXio3iOBITsSG7Abbm9Ejv2ua3auz4Pz5gzQeEzR26Do
   XXpk+f6Q+pyoawQxSTO13zL9JCH8Zq6dzinNRBHEpcAktSui+SkZfpB7U
   w==;
X-CSE-ConnectionGUID: vj7eLLU1QmuvRvz4TSKkzw==
X-CSE-MsgGUID: D3HXvWxbQq6IkCiyetGJqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64119065"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64119065"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2025 09:00:51 -0800
X-CSE-ConnectionGUID: ASjBmx04RSO0Vo+qdX3UKg==
X-CSE-MsgGUID: 4C1SBGipQJ+W2u0JZbx60w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,274,1754982000"; 
   d="scan'208";a="191007783"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 02 Nov 2025 09:00:49 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vFbRV-000PR8-1t;
	Sun, 02 Nov 2025 17:00:41 +0000
Date: Mon, 03 Nov 2025 00:58:28 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/vdso] BUILD SUCCESS WITH UNVERIFIED WARNING
 4c6736970fbf35aa65512ce7f82abd970f133c8e
Message-ID: <202511030021.9v1mIgts-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/vdso
branch HEAD: 4c6736970fbf35aa65512ce7f82abd970f133c8e  clocksource: Remove ARCH_CLOCKSOURCE_DATA

Unverified Warning (likely false positive, kindly check if interested):

    arch/sparc/include/uapi/../../../../lib/vdso/gettimeofday.c:325 __cvdso_clock_gettime_common() warn: bitwise AND condition is false here
    arch/sparc/include/uapi/../../../../lib/vdso/gettimeofday.c:325 __cvdso_clock_gettime_common() warn: right shifting more than type allows 32 vs 40

Warning ids grouped by kconfigs:

recent_errors
`-- sparc64-randconfig-r072-20251102
    |-- arch-sparc-include-uapi-..-..-..-..-lib-vdso-gettimeofday.c-__cvdso_clock_gettime_common()-warn:bitwise-AND-condition-is-false-here
    `-- arch-sparc-include-uapi-..-..-..-..-lib-vdso-gettimeofday.c-__cvdso_clock_gettime_common()-warn:right-shifting-more-than-type-allows-vs

elapsed time: 1266m

configs tested: 187
configs skipped: 7

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251102    gcc-14.3.0
arc                   randconfig-001-20251102    gcc-8.5.0
arc                   randconfig-002-20251102    gcc-14.3.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                                 defconfig    gcc-15.1.0
arm                         lpc18xx_defconfig    gcc-15.1.0
arm                          pxa910_defconfig    gcc-15.1.0
arm                   randconfig-001-20251102    gcc-14.3.0
arm                   randconfig-002-20251102    gcc-14.3.0
arm                   randconfig-003-20251102    gcc-14.3.0
arm                   randconfig-004-20251102    gcc-14.3.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                            allyesconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251102    gcc-12.5.0
arm64                 randconfig-002-20251102    gcc-12.5.0
arm64                 randconfig-003-20251102    gcc-12.5.0
arm64                 randconfig-004-20251102    gcc-12.5.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251102    gcc-12.5.0
csky                  randconfig-002-20251102    gcc-12.5.0
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20251102    clang-22
hexagon               randconfig-001-20251102    gcc-15.1.0
hexagon               randconfig-002-20251102    clang-22
hexagon               randconfig-002-20251102    gcc-15.1.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20251102    gcc-14
i386        buildonly-randconfig-002-20251102    gcc-14
i386        buildonly-randconfig-003-20251102    gcc-14
i386        buildonly-randconfig-004-20251102    gcc-14
i386        buildonly-randconfig-005-20251102    gcc-14
i386        buildonly-randconfig-006-20251102    gcc-14
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20251102    clang-20
i386                  randconfig-002-20251102    clang-20
i386                  randconfig-003-20251102    clang-20
i386                  randconfig-004-20251102    clang-20
i386                  randconfig-005-20251102    clang-20
i386                  randconfig-006-20251102    clang-20
i386                  randconfig-007-20251102    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                        allyesconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251102    gcc-15.1.0
loongarch             randconfig-002-20251102    gcc-15.1.0
m68k                             allmodconfig    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                                defconfig    clang-19
m68k                       m5249evb_defconfig    gcc-15.1.0
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
nios2                 randconfig-001-20251102    gcc-11.5.0
nios2                 randconfig-001-20251102    gcc-15.1.0
nios2                 randconfig-002-20251102    gcc-11.5.0
nios2                 randconfig-002-20251102    gcc-15.1.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251102    gcc-8.5.0
parisc                randconfig-002-20251102    gcc-14.3.0
parisc                randconfig-002-20251102    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                   lite5200b_defconfig    gcc-15.1.0
powerpc                  mpc885_ads_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251102    gcc-8.5.0
powerpc               randconfig-001-20251102    gcc-9.5.0
powerpc               randconfig-002-20251102    clang-18
powerpc               randconfig-002-20251102    gcc-8.5.0
powerpc64             randconfig-001-20251102    gcc-14.3.0
powerpc64             randconfig-001-20251102    gcc-8.5.0
powerpc64             randconfig-002-20251102    gcc-8.5.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-15.1.0
riscv                 randconfig-001-20251102    gcc-13.4.0
riscv                 randconfig-002-20251102    gcc-14.3.0
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-15.1.0
s390                  randconfig-002-20251102    gcc-11.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20251102    gcc-13.4.0
sh                    randconfig-002-20251102    gcc-15.1.0
sh                           se7721_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                            allyesconfig    clang-22
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251102    clang-22
sparc                 randconfig-002-20251102    clang-22
sparc64                          allmodconfig    clang-22
sparc64                          allyesconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251102    clang-22
sparc64               randconfig-002-20251102    clang-22
um                               alldefconfig    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251102    clang-22
um                    randconfig-002-20251102    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251102    clang-20
x86_64      buildonly-randconfig-002-20251102    clang-20
x86_64      buildonly-randconfig-003-20251102    clang-20
x86_64      buildonly-randconfig-004-20251102    clang-20
x86_64      buildonly-randconfig-005-20251102    clang-20
x86_64      buildonly-randconfig-006-20251102    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251102    gcc-14
x86_64                randconfig-002-20251102    gcc-14
x86_64                randconfig-003-20251102    gcc-14
x86_64                randconfig-004-20251102    gcc-14
x86_64                randconfig-005-20251102    gcc-14
x86_64                randconfig-006-20251102    gcc-14
x86_64                randconfig-011-20251102    gcc-14
x86_64                randconfig-012-20251102    gcc-14
x86_64                randconfig-013-20251102    gcc-14
x86_64                randconfig-014-20251102    gcc-14
x86_64                randconfig-015-20251102    gcc-14
x86_64                randconfig-016-20251102    gcc-14
x86_64                randconfig-071-20251102    gcc-14
x86_64                randconfig-072-20251102    gcc-14
x86_64                randconfig-073-20251102    gcc-14
x86_64                randconfig-074-20251102    gcc-14
x86_64                randconfig-075-20251102    gcc-14
x86_64                randconfig-076-20251102    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20251102    clang-22
xtensa                randconfig-002-20251102    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


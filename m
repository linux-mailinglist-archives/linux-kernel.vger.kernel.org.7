Return-Path: <linux-kernel+bounces-875637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFA4C197C4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF99F3BDB6B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684282E54A3;
	Wed, 29 Oct 2025 09:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yu+GudaX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AF02DE1E0
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761731249; cv=none; b=S2jbgvBDOst5V42YB0XQEcbk4jRFOG/tqMfis+CoGnHKKwMXrx2QZU1PMIMRtS8FvlYmrCpIBgbSSwq+KOzsJ55/TsSQztUMV2A0pEUgAe4Xn395M+gSTHZc9hBeuV+neuUBa4RGWccWEyvqwQ7NX0cj7+GiRaTWXbUCjm6MU04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761731249; c=relaxed/simple;
	bh=95vUa7Ezs2UoiwXfoTB0cFOQay4kJvQ2Ga9xmTFLTSs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jhSsw9EvAntTkq70TsaTEJhyHM6VhNHWb32rgQezdmNq9dsBFbF/fpdJfSyK8p3rTRNGblnGCZ2vrHkS6/+SgveB3PgyxLicia1MQALjyXvJSqAC8BmonP6x3V5TlF6vgkKsR8fOUEU6/1OHEc+HcqU31XH2LpeEwcN5MVqEsw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yu+GudaX; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761731249; x=1793267249;
  h=date:from:to:cc:subject:message-id;
  bh=95vUa7Ezs2UoiwXfoTB0cFOQay4kJvQ2Ga9xmTFLTSs=;
  b=Yu+GudaXQeMEIfWOErJqecjRFkn5+LdFvwQGCKSmXs6YeIWJWbHwmAQe
   pvv+OjCwvIZY4gLT4NYWYTGzvnRd/Ttnn0q6jHzfrn+fECy0zbx1k17YK
   4ob9kGJDrDb/Y1iEjJMW7C97Jyx+qYmKBmwEZM/h/+ljRVIiL+6hCv7kk
   qqQTgFBVBS9K9MfmebxEEwuGGHvheHtGMXvp9Y6/GChttl4RgKPay+LL3
   NuR9/JL1BTO2LSrpMtF1ouNAFpCqdp1oVYAgbzU3EwSYQ32OGqkDAS745
   KujfzAi5tH2TZ1fs1TtSKgSvbWL32jp/ijAP+lh96CSI5Al7F12NPIpSt
   Q==;
X-CSE-ConnectionGUID: /TvYrb/QQXWH2mTDvNbeXg==
X-CSE-MsgGUID: H6D7w8RgQvOCs1KvJw5FVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="86475650"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="86475650"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 02:47:28 -0700
X-CSE-ConnectionGUID: hiyD21MHS168afVkJGKZfQ==
X-CSE-MsgGUID: TZr9bNtxQ1660FEiSyNXHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="209203810"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 29 Oct 2025 02:47:26 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vE2m4-000KTD-0c;
	Wed, 29 Oct 2025 09:47:24 +0000
Date: Wed, 29 Oct 2025 17:46:48 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD REGRESSION
 b94d45b6bbb42571ec225d3be0e7457c8765a5b4
Message-ID: <202510291742.bGMetgBe-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
branch HEAD: b94d45b6bbb42571ec225d3be0e7457c8765a5b4  seqlock: Allow KASAN to fail optimizing

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202510250928.YLPmMRoX-lkp@intel.com
    https://lore.kernel.org/oe-kbuild-all/202510251641.idrNXhv5-lkp@intel.com

    array.c:(.text+0xc84): undefined reference to `__scoped_seqlock_bug'
    build_policy.c:(.text+0x9c64): undefined reference to `__scoped_seqlock_bug'
    include/linux/seqlock.h:1260:(.text+0x98c4): undefined reference to `__scoped_seqlock_bug'

Error/Warning ids grouped by kconfigs:

recent_errors
|-- arm-pxa_defconfig
|   `-- include-linux-seqlock.h:(.text):undefined-reference-to-__scoped_seqlock_bug
`-- arm-spitz_defconfig
    |-- array.c:(.text):undefined-reference-to-__scoped_seqlock_bug
    `-- build_policy.c:(.text):undefined-reference-to-__scoped_seqlock_bug

elapsed time: 1448m

configs tested: 125
configs skipped: 6

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                           imxrt_defconfig    clang-22
arm                             pxa_defconfig    gcc-15.1.0
arm                           spitz_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251028    clang-22
arm64                 randconfig-002-20251028    clang-22
arm64                 randconfig-003-20251028    gcc-11.5.0
arm64                 randconfig-004-20251028    gcc-8.5.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                  randconfig-001-20251028    gcc-15.1.0
csky                  randconfig-002-20251028    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20251028    clang-22
hexagon               randconfig-002-20251028    clang-17
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251028    gcc-14
i386        buildonly-randconfig-002-20251028    gcc-14
i386        buildonly-randconfig-003-20251028    gcc-14
i386        buildonly-randconfig-004-20251028    gcc-14
i386        buildonly-randconfig-005-20251028    gcc-14
i386        buildonly-randconfig-006-20251028    gcc-14
i386                  randconfig-001-20251028    gcc-14
i386                  randconfig-002-20251028    clang-20
i386                  randconfig-003-20251028    clang-20
i386                  randconfig-004-20251028    clang-20
i386                  randconfig-005-20251028    clang-20
i386                  randconfig-006-20251028    clang-20
i386                  randconfig-007-20251028    gcc-14
i386                  randconfig-011-20251028    gcc-14
i386                  randconfig-012-20251028    clang-20
i386                  randconfig-013-20251028    clang-20
i386                  randconfig-014-20251028    clang-20
i386                  randconfig-015-20251028    clang-20
i386                  randconfig-016-20251028    gcc-14
i386                  randconfig-017-20251028    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251028    gcc-12.5.0
loongarch             randconfig-002-20251028    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                            allyesconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251028    gcc-8.5.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251028    gcc-9.5.0
parisc                randconfig-002-20251028    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                   currituck_defconfig    clang-22
powerpc               randconfig-001-20251028    gcc-15.1.0
powerpc               randconfig-002-20251028    gcc-11.5.0
powerpc64             randconfig-001-20251028    clang-22
powerpc64             randconfig-002-20251028    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         apsh4a3a_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                        sh7757lcr_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                            allyesconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251028    gcc-8.5.0
sparc                 randconfig-002-20251028    gcc-12.5.0
sparc64                          allyesconfig    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251028    clang-22
sparc64               randconfig-002-20251028    gcc-9.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251028    gcc-14
um                    randconfig-002-20251028    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251028    clang-20
x86_64                randconfig-002-20251028    gcc-14
x86_64                randconfig-003-20251028    gcc-14
x86_64                randconfig-004-20251028    gcc-14
x86_64                randconfig-005-20251028    clang-20
x86_64                randconfig-006-20251028    clang-20
x86_64                randconfig-071-20251028    gcc-14
x86_64                randconfig-072-20251028    clang-20
x86_64                randconfig-073-20251028    gcc-14
x86_64                randconfig-074-20251028    gcc-12
x86_64                randconfig-075-20251028    gcc-14
x86_64                randconfig-076-20251028    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251028    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


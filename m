Return-Path: <linux-kernel+bounces-787713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC62B37A1F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 08:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 241997A7CCC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 06:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4912D73B4;
	Wed, 27 Aug 2025 06:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xvu05be9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E29186A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 06:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756274666; cv=none; b=U5c+HWOUDYdn4r6m9ExcJKbVWbBUoYsP10K79sDqwoyGBO+BtvqregTo3+0suZsKa2KYkVEFNmSK8VYXe2m0U8tqW4mYTE75w4hg+KtZo0cmbtV3rkLPu14elcN6mGeuIB4jLt8L5RahlWprgC6X4BQ0/lIlThQmIejhd2LQszo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756274666; c=relaxed/simple;
	bh=H9gAoo4LWqbpXTiCJbpfpLIaHMRYA0bf/MFTDK9wbE8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XSLCGxhGEbvQH94d+AaZWjhq+sQ7BJ4FU+S7SttF4tFePDV+O0fuVubva0xhqDDGu1ukZU1BCisSJwT2dPV5oo2jNahxglt0yWRVp+NUbM1EDu0St1YoA9EJX+DBHUukEQ5+t1SstDgR0CazMVwlY0Tx4qB1ttcADHMPVAUVoeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xvu05be9; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756274665; x=1787810665;
  h=date:from:to:cc:subject:message-id;
  bh=H9gAoo4LWqbpXTiCJbpfpLIaHMRYA0bf/MFTDK9wbE8=;
  b=Xvu05be9TCTF84s7fjBMFGUqd5kko7VxqdyUR59ohi/dikYxCJxQLS65
   hsj5Typg4MZeVm5Qswn+cy26uSCUcrNaC/GqGmaoOjIsgQI3Sf8MB4OXx
   crKGJxJtU88OaQ1aUmQSaGXj0MfSi3kRU396ZSMub4pxW0nyzXcT9EBz0
   EcQ34qtDPSbkSv935LAOweilrcxaVxl7XQ2E6Wer65hrjqbKqWOJjhYGm
   8l2SplYQElb3ocz+mxiggNscLgyQFBhnl7Lzo2/NRVz5ZP3xdGte0WIbS
   CESQZfRSRdR1/dTJsP4KdWcq/MxRDAygVj+1tD33oIjdBEAHGkXFbd/Ao
   w==;
X-CSE-ConnectionGUID: 13b1pLQqR++BI/GvQ4/ATQ==
X-CSE-MsgGUID: oXBmUTqxTSaVfy2zpFCwjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="58232394"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="58232394"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 23:04:24 -0700
X-CSE-ConnectionGUID: 5O6BAH2KR1O/s7ok7JHrlw==
X-CSE-MsgGUID: ZQRwKPB6RXypV3Kj/bF5jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="193409534"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 26 Aug 2025 23:04:23 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ur9Ga-000Sj2-2O;
	Wed, 27 Aug 2025 06:04:17 +0000
Date: Wed, 27 Aug 2025 14:03:04 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 16ed389227651330879e17bd83d43bd234006722
Message-ID: <202508271450.niot8ht5-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
branch HEAD: 16ed389227651330879e17bd83d43bd234006722  perf: Skip user unwind if the task is a kernel thread

elapsed time: 1201m

configs tested: 134
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                          axs103_defconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250826    gcc-11.5.0
arc                   randconfig-002-20250826    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                           imxrt_defconfig    clang-22
arm                   randconfig-001-20250826    gcc-12.5.0
arm                   randconfig-002-20250826    gcc-13.4.0
arm                   randconfig-003-20250826    gcc-8.5.0
arm                   randconfig-004-20250826    gcc-10.5.0
arm                           sunxi_defconfig    gcc-15.1.0
arm                           tegra_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250826    clang-22
arm64                 randconfig-002-20250826    gcc-8.5.0
arm64                 randconfig-003-20250826    clang-22
arm64                 randconfig-004-20250826    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250826    gcc-15.1.0
csky                  randconfig-002-20250826    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20250826    clang-19
hexagon               randconfig-002-20250826    clang-22
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250826    gcc-12
i386        buildonly-randconfig-002-20250826    gcc-12
i386        buildonly-randconfig-003-20250826    clang-20
i386        buildonly-randconfig-004-20250826    gcc-12
i386        buildonly-randconfig-005-20250826    clang-20
i386        buildonly-randconfig-006-20250826    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250826    gcc-14.3.0
loongarch             randconfig-002-20250826    gcc-14.3.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250826    gcc-8.5.0
nios2                 randconfig-002-20250826    gcc-10.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250826    gcc-8.5.0
parisc                randconfig-002-20250826    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250826    gcc-8.5.0
powerpc               randconfig-002-20250826    clang-22
powerpc               randconfig-003-20250826    gcc-13.4.0
powerpc                     skiroot_defconfig    clang-22
powerpc64             randconfig-001-20250826    gcc-10.5.0
powerpc64             randconfig-002-20250826    gcc-11.5.0
powerpc64             randconfig-003-20250826    gcc-14.3.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250826    gcc-8.5.0
riscv                 randconfig-002-20250826    gcc-11.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250826    clang-22
s390                  randconfig-002-20250826    clang-18
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                          r7780mp_defconfig    gcc-15.1.0
sh                    randconfig-001-20250826    gcc-11.5.0
sh                    randconfig-002-20250826    gcc-9.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250826    gcc-13.4.0
sparc                 randconfig-002-20250826    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250826    gcc-8.5.0
sparc64               randconfig-002-20250826    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250826    gcc-12
um                    randconfig-002-20250826    clang-17
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250826    clang-20
x86_64      buildonly-randconfig-002-20250826    clang-20
x86_64      buildonly-randconfig-003-20250826    gcc-12
x86_64      buildonly-randconfig-004-20250826    clang-20
x86_64      buildonly-randconfig-005-20250826    gcc-12
x86_64      buildonly-randconfig-006-20250826    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250826    gcc-11.5.0
xtensa                randconfig-002-20250826    gcc-8.5.0
xtensa                         virt_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


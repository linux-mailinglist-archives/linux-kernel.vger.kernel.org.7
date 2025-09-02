Return-Path: <linux-kernel+bounces-795638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6E7B3F5B0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C3C01A864CF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 06:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EF72E540B;
	Tue,  2 Sep 2025 06:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KOPEKUoI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E826F2E4254
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 06:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756795173; cv=none; b=Bl6+OzCmUZV7Szl6/sdItA4GSl3ZsWPnhAKMMSW2IVp/5yx45enov8ta6A368x+JFhu2HmwGSj94TbVco3UfY7Hjt5lrCrWtUhUx+Jw4wTLd7FgXf25jQuSgIVCiAoiZYR+nFgNma2LFd+SrVlI8znpUEJeZpzALv4IYd8+3oic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756795173; c=relaxed/simple;
	bh=Y3I3Nyr+fZaPeaq91n2jqK9k7tKHA4/4O1g4ATJWFLQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=f2G2NkjeFUlnrvSc/X4PQl/5jtILQ3NxORweZuENw0z5CM77vn/0RimBCdRJySVrq8ZxC8HpdqIgBdfbyqcZlsa197ojPoHcsHlHl7hQBVLT537tcciQM19jAZ3RWwghb0BhfY7b3btZoTJUJOyz63qsbHOwmuKjfC/DLsVPffk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KOPEKUoI; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756795172; x=1788331172;
  h=date:from:to:cc:subject:message-id;
  bh=Y3I3Nyr+fZaPeaq91n2jqK9k7tKHA4/4O1g4ATJWFLQ=;
  b=KOPEKUoI9PIdF5QG/0UhSqMnVC0yt8cWbx7KxOKpPFASRM8FKFHiDO8x
   rxB7VIPbKWt9YtRBh2/KTCecz2FxUPOAhQzqxtnXXz4M+v/z8IK+3QVYz
   KF8KJBbeDnn1n/BD3sYK6L4e+2aDc9Z0T8x1CkzvGlzmO4Ianpo1bXzqv
   yRb+N5iaNeGQAwvyFLCl+gwDdJTNaHcD1SBqF85F9NEzl1a69C8/mVfbC
   QHVpioaM889d+bTVB90nRCNyGBdWJLfCSjR9c194PYPSpW6usqHjX7e9y
   KCvOGRf7p38ZCycB8SFwit440r0GoPu+yP2UlK3L8E9bGK/ztrytfIlTu
   w==;
X-CSE-ConnectionGUID: z+zwM8oTQTm8nEN3xrQRtA==
X-CSE-MsgGUID: 8AaNVkvURZmuRukYJ4xsag==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="70482716"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="70482716"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 23:39:30 -0700
X-CSE-ConnectionGUID: blQXDv3RStinBKCstRC2Kw==
X-CSE-MsgGUID: he4RWRLJR8e0gppv49Jy4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="171556652"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 01 Sep 2025 23:39:28 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1utKfu-0001WX-0w;
	Tue, 02 Sep 2025 06:39:26 +0000
Date: Tue, 02 Sep 2025 14:36:58 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:tip/urgent] BUILD SUCCESS
 e76673374c75e01f250f99e279fdd3c6b4d69d42
Message-ID: <202509021444.0BvZDs1b-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tip/urgent
branch HEAD: e76673374c75e01f250f99e279fdd3c6b4d69d42  Merge branch into tip/master: 'locking/urgent'

elapsed time: 1468m

configs tested: 131
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250901    gcc-8.5.0
arc                   randconfig-002-20250901    gcc-11.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                       netwinder_defconfig    gcc-15.1.0
arm                   randconfig-001-20250901    clang-22
arm                   randconfig-002-20250901    clang-22
arm                   randconfig-003-20250901    clang-22
arm                   randconfig-004-20250901    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250901    clang-16
arm64                 randconfig-002-20250901    gcc-13.4.0
arm64                 randconfig-003-20250901    clang-22
arm64                 randconfig-004-20250901    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250901    gcc-12.5.0
csky                  randconfig-002-20250901    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20250901    clang-17
hexagon               randconfig-002-20250901    clang-17
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250901    clang-20
i386        buildonly-randconfig-002-20250901    clang-20
i386        buildonly-randconfig-003-20250901    gcc-12
i386        buildonly-randconfig-004-20250901    clang-20
i386        buildonly-randconfig-005-20250901    gcc-12
i386        buildonly-randconfig-006-20250901    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250901    gcc-15.1.0
loongarch             randconfig-002-20250901    clang-18
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           ip30_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250901    gcc-11.5.0
nios2                 randconfig-002-20250901    gcc-9.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250901    gcc-11.5.0
parisc                randconfig-002-20250901    gcc-11.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                     akebono_defconfig    clang-22
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                     mpc83xx_defconfig    clang-22
powerpc               randconfig-001-20250901    clang-22
powerpc               randconfig-002-20250901    clang-22
powerpc               randconfig-003-20250901    gcc-13.4.0
powerpc64             randconfig-001-20250901    clang-16
powerpc64             randconfig-002-20250901    gcc-13.4.0
powerpc64             randconfig-003-20250901    gcc-12.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250901    clang-22
riscv                 randconfig-002-20250901    clang-20
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250901    gcc-13.4.0
s390                  randconfig-002-20250901    gcc-13.4.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250901    gcc-15.1.0
sh                    randconfig-002-20250901    gcc-15.1.0
sh                           se7721_defconfig    gcc-15.1.0
sh                   sh7770_generic_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250901    gcc-8.5.0
sparc                 randconfig-002-20250901    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250901    clang-20
sparc64               randconfig-002-20250901    gcc-13.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250901    gcc-12
um                    randconfig-002-20250901    gcc-12
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250901    clang-20
x86_64      buildonly-randconfig-002-20250901    clang-20
x86_64      buildonly-randconfig-003-20250901    gcc-12
x86_64      buildonly-randconfig-004-20250901    clang-20
x86_64      buildonly-randconfig-005-20250901    gcc-12
x86_64      buildonly-randconfig-006-20250901    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                       common_defconfig    gcc-15.1.0
xtensa                randconfig-001-20250901    gcc-8.5.0
xtensa                randconfig-002-20250901    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


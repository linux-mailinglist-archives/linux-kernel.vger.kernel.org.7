Return-Path: <linux-kernel+bounces-724831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECE4AFF75B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 05:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F12E3B63B1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6595528032F;
	Thu, 10 Jul 2025 03:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JQPl5mDW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D9C2AD0F
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 03:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752117423; cv=none; b=oPSAbbek1zotq0E1N5hngKcIg8+N3jKhW3cwo8RosFp8qaY+jBwO1QiKWsnpiDcLDisargKRsQaQRtcIAviARgco6GkdUqfQWiz0NQwf/XGmOXSAdSWaYnun/jm1dRhZKSC6Brn51wz7Glo43n1Mjy4Up973sVCEsmWNlC9b3PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752117423; c=relaxed/simple;
	bh=/f55yKXdXBv1K65HPVaohpGotLfSEeOC1P+i89w9Ry4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=iQNaC+iLgKbKAAZp6yOo6TLpsBYm3x1DXVhzpzDK+YekfO825/cUXQrhlRjFQtcrmf6+AkSfaczhkkK5KkigipoYbN3rajL5OHi0I6nfoCBFvTSKIaVMPJSrM/aZeoR1KzYokBTtyNRYgSsF+UsRWMzUOW7ohyrJqLpT2X+191o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JQPl5mDW; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752117422; x=1783653422;
  h=date:from:to:cc:subject:message-id;
  bh=/f55yKXdXBv1K65HPVaohpGotLfSEeOC1P+i89w9Ry4=;
  b=JQPl5mDW950Yfk3rSGxg+XEr140JwRfJ9kPjxboMQydughser1BXaVYu
   CGCgfgLUyfwMeWcoUOPFmmd0hLzGDVXGU2i+de0R5nPuzwIJAshvL6MPY
   L6rg8/LCv+n6pwHlinP6s93c8AvwV9JV/bC+gT8CDObF4gvqkyqadFP/J
   b/D5f8R6TIromtH7PlY+VXRdusFL6Z9ZlsYbNvJr6gWJpsOESPYNigiy3
   k7N3OUsWHWXwgOpWPARYORYwLUjz4i9ssJbpAL2U4UEL4TvFAZsbX5/af
   GtLA+cUfH+eFm23EBNUn36W91f19+P+Km3zDm5nENTSKO8TxyzPerUKFe
   Q==;
X-CSE-ConnectionGUID: 8wOamgqeTsyFrGGJBSUKOQ==
X-CSE-MsgGUID: hFmkRudfQnyrekvD9dd4jA==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54241454"
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="54241454"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 20:17:01 -0700
X-CSE-ConnectionGUID: VRVo0qL6S4OHZ5KuepGzOQ==
X-CSE-MsgGUID: wUGe3RUVTMSuqzhB9yPgSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="156500617"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 09 Jul 2025 20:17:00 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uZhmM-0004PS-02;
	Thu, 10 Jul 2025 03:16:58 +0000
Date: Thu, 10 Jul 2025 11:16:49 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 829f5a6308ce11c3edaa31498a825f8c41b9e9aa
Message-ID: <202507101137.6zr47fg4-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
branch HEAD: 829f5a6308ce11c3edaa31498a825f8c41b9e9aa  perf/x86/intel/uncore: Add iMC freerunning for Panther Lake

elapsed time: 933m

configs tested: 143
configs skipped: 157

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-21
alpha                               defconfig    clang-19
arc                               allnoconfig    clang-21
arc                                 defconfig    clang-19
arc                   randconfig-001-20250710    clang-21
arc                   randconfig-002-20250710    clang-21
arm                               allnoconfig    clang-21
arm                                 defconfig    clang-19
arm                          exynos_defconfig    clang-21
arm                            qcom_defconfig    clang-21
arm                   randconfig-001-20250710    clang-21
arm                   randconfig-002-20250710    clang-21
arm                   randconfig-003-20250710    clang-21
arm                   randconfig-004-20250710    clang-21
arm                       spear13xx_defconfig    clang-21
arm64                             allnoconfig    clang-21
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250710    clang-21
arm64                 randconfig-002-20250710    clang-21
arm64                 randconfig-003-20250710    clang-21
arm64                 randconfig-004-20250710    clang-21
csky                              allnoconfig    clang-21
csky                                defconfig    clang-19
csky                  randconfig-001-20250710    gcc-15.1.0
csky                  randconfig-002-20250710    gcc-15.1.0
hexagon                           allnoconfig    clang-21
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250710    gcc-15.1.0
hexagon               randconfig-002-20250710    gcc-15.1.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250709    gcc-12
i386        buildonly-randconfig-001-20250710    clang-20
i386        buildonly-randconfig-002-20250709    clang-20
i386        buildonly-randconfig-002-20250710    clang-20
i386        buildonly-randconfig-003-20250709    clang-20
i386        buildonly-randconfig-003-20250710    clang-20
i386        buildonly-randconfig-004-20250709    clang-20
i386        buildonly-randconfig-004-20250710    clang-20
i386        buildonly-randconfig-005-20250709    gcc-12
i386        buildonly-randconfig-005-20250710    clang-20
i386        buildonly-randconfig-006-20250709    clang-20
i386        buildonly-randconfig-006-20250710    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250710    gcc-12
i386                  randconfig-002-20250710    gcc-12
i386                  randconfig-003-20250710    gcc-12
i386                  randconfig-004-20250710    gcc-12
i386                  randconfig-005-20250710    gcc-12
i386                  randconfig-006-20250710    gcc-12
i386                  randconfig-007-20250710    gcc-12
i386                  randconfig-011-20250710    clang-20
i386                  randconfig-012-20250710    clang-20
i386                  randconfig-013-20250710    clang-20
i386                  randconfig-014-20250710    clang-20
i386                  randconfig-015-20250710    clang-20
i386                  randconfig-016-20250710    clang-20
i386                  randconfig-017-20250710    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250710    gcc-15.1.0
loongarch             randconfig-002-20250710    gcc-15.1.0
m68k                             allmodconfig    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                                defconfig    clang-19
m68k                          sun3x_defconfig    clang-21
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-15.1.0
nios2                 randconfig-001-20250710    gcc-15.1.0
nios2                 randconfig-002-20250710    gcc-15.1.0
openrisc                  or1klitex_defconfig    clang-21
parisc                randconfig-001-20250710    gcc-15.1.0
parisc                randconfig-002-20250710    gcc-15.1.0
powerpc                      cm5200_defconfig    clang-21
powerpc                  iss476-smp_defconfig    clang-21
powerpc               randconfig-001-20250710    gcc-15.1.0
powerpc               randconfig-002-20250710    gcc-15.1.0
powerpc               randconfig-003-20250710    gcc-15.1.0
powerpc64             randconfig-001-20250710    gcc-15.1.0
powerpc64             randconfig-002-20250710    gcc-15.1.0
powerpc64             randconfig-003-20250710    gcc-15.1.0
riscv                 randconfig-001-20250710    gcc-12.4.0
riscv                 randconfig-002-20250710    gcc-12.4.0
s390                             allmodconfig    gcc-15.1.0
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250710    gcc-12.4.0
s390                  randconfig-002-20250710    gcc-12.4.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250710    gcc-12.4.0
sh                    randconfig-002-20250710    gcc-12.4.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250710    gcc-12.4.0
sparc                 randconfig-002-20250710    gcc-12.4.0
sparc64               randconfig-001-20250710    gcc-12.4.0
sparc64               randconfig-002-20250710    gcc-12.4.0
um                    randconfig-001-20250710    gcc-12.4.0
um                    randconfig-002-20250710    gcc-12.4.0
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250709    gcc-12
x86_64      buildonly-randconfig-001-20250710    clang-20
x86_64      buildonly-randconfig-002-20250709    clang-20
x86_64      buildonly-randconfig-002-20250710    clang-20
x86_64      buildonly-randconfig-003-20250709    gcc-12
x86_64      buildonly-randconfig-003-20250710    clang-20
x86_64      buildonly-randconfig-004-20250709    gcc-12
x86_64      buildonly-randconfig-004-20250710    clang-20
x86_64      buildonly-randconfig-005-20250709    clang-20
x86_64      buildonly-randconfig-005-20250710    clang-20
x86_64      buildonly-randconfig-006-20250709    gcc-12
x86_64      buildonly-randconfig-006-20250710    clang-20
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250710    gcc-12
x86_64                randconfig-002-20250710    gcc-12
x86_64                randconfig-003-20250710    gcc-12
x86_64                randconfig-004-20250710    gcc-12
x86_64                randconfig-005-20250710    gcc-12
x86_64                randconfig-006-20250710    gcc-12
x86_64                randconfig-007-20250710    gcc-12
x86_64                randconfig-008-20250710    gcc-12
x86_64                randconfig-071-20250710    gcc-11
x86_64                randconfig-072-20250710    gcc-11
x86_64                randconfig-073-20250710    gcc-11
x86_64                randconfig-074-20250710    gcc-11
x86_64                randconfig-075-20250710    gcc-11
x86_64                randconfig-076-20250710    gcc-11
x86_64                randconfig-077-20250710    gcc-11
x86_64                randconfig-078-20250710    gcc-11
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250710    gcc-12.4.0
xtensa                randconfig-002-20250710    gcc-12.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


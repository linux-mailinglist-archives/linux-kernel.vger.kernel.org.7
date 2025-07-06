Return-Path: <linux-kernel+bounces-716409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AC8AF8604
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 05:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6847D1C80F1E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 03:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4041DF725;
	Fri,  4 Jul 2025 03:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DHCr1653"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C5E1D63C6
	for <linux-kernel@vger.kernel.org>; Fri,  4 Jul 2025 03:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751599440; cv=none; b=EgyITppzrAulxDV/dwL0wZ5TdJDGJRStejzV2wvcai9uE8SGOYNeXvje2CIOmv/9r5jKQAV8SWkxHNhRbbUgJnlfwzmVkMlXIeI9xXzW6XJMotiMI+0fJ2uLLGxAb1KG5W6jh+3gAuVn5ntgaT6NJ50HSL8IsLT7+nHCj3K3RaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751599440; c=relaxed/simple;
	bh=pDC8GkmEZUhmgtmMWLDFwsD0ZU8Yg+GkHgW7d8CnWcE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=NlYpol54gmTK7yEIJdzj4E/bZPY4lfbGTmt6KIkQij/WWACX8bGa0fXZjeUohlt3nHCooe/nR5rVwsixu5+3Nu36x6Sd7KCRxQYEf9g1ywveoe/dcshAYGK3zh+SRRU3f/CIvr01UgVUOF1e4zQmlF5ZyjTkC31D5OAAq4kuedE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DHCr1653; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751599439; x=1783135439;
  h=date:from:to:cc:subject:message-id;
  bh=pDC8GkmEZUhmgtmMWLDFwsD0ZU8Yg+GkHgW7d8CnWcE=;
  b=DHCr16530COLFkKOwk3TPAIiOU6E3D5eFjLd73lmQAPjkZkeYl3pltAW
   e65V6f/oO0kYGk5LCX1vvVUZu2vRLVQrV9JWEaHMiaGvxnP2hv+5M1I+7
   WF0Vi9HXZ2N+ad56AGn0uR366TFCxbLmcTiV7+sp+6IMEeXoJq3WkNi8Z
   C+XQN4bvDp1pbAmuHmWPrj+fay2Le5HxqTwUQ35LXsYvXOLQi4fhp1T/T
   rz58+64c1tUmsnmwH+D3BwzUvazj9Er69K82QdXMw2fs0QAU2XUZG7dbG
   11nOfcaqLuWeHjAwDIVUR4BIfX2w2EY2nY2gfOhHUxm/R2jM778roqOHa
   Q==;
X-CSE-ConnectionGUID: 5mBRe+7QSs6DtSQtljg8DA==
X-CSE-MsgGUID: Sp435XYjS92orjD9Ewy6Hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53858490"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="53858490"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 20:23:58 -0700
X-CSE-ConnectionGUID: AYFlVNGPTXCbCZvML5fMIw==
X-CSE-MsgGUID: aP+/H1VrTgq2lx7mU1WHuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="155104948"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 03 Jul 2025 20:23:57 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uXX1n-0003H5-0p;
	Fri, 04 Jul 2025 03:23:55 +0000
Date: Fri, 04 Jul 2025 11:23:26 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 d398a68e8bcf430e231cccfbaa27cb25a7a6f224
Message-ID: <202507041113.w6K3zHUU-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: d398a68e8bcf430e231cccfbaa27cb25a7a6f224  Merge tag 'rust-sched.2025.06.24' of git://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux into sched/core

elapsed time: 1122m

configs tested: 112
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250703    gcc-11.5.0
arc                   randconfig-002-20250703    gcc-12.4.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250703    clang-21
arm                   randconfig-002-20250703    gcc-8.5.0
arm                   randconfig-003-20250703    clang-17
arm                   randconfig-004-20250703    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250703    clang-21
arm64                 randconfig-002-20250703    gcc-14.3.0
arm64                 randconfig-003-20250703    clang-21
arm64                 randconfig-004-20250703    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250703    gcc-14.3.0
csky                  randconfig-002-20250703    gcc-12.4.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250703    clang-21
hexagon               randconfig-002-20250703    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250703    clang-20
i386        buildonly-randconfig-002-20250703    gcc-12
i386        buildonly-randconfig-003-20250703    gcc-12
i386        buildonly-randconfig-004-20250703    clang-20
i386        buildonly-randconfig-005-20250703    gcc-12
i386        buildonly-randconfig-006-20250703    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch             randconfig-001-20250703    clang-18
loongarch             randconfig-002-20250703    clang-18
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250703    gcc-8.5.0
nios2                 randconfig-002-20250703    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250703    gcc-8.5.0
parisc                randconfig-002-20250703    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc               randconfig-001-20250703    gcc-10.5.0
powerpc               randconfig-002-20250703    clang-21
powerpc               randconfig-003-20250703    gcc-8.5.0
powerpc64             randconfig-001-20250703    clang-18
powerpc64             randconfig-002-20250703    clang-21
powerpc64             randconfig-003-20250703    gcc-14.3.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250703    gcc-13.4.0
riscv                 randconfig-002-20250703    gcc-14.3.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250703    gcc-12.4.0
s390                  randconfig-002-20250703    clang-21
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250703    gcc-9.3.0
sh                    randconfig-002-20250703    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250703    gcc-8.5.0
sparc                 randconfig-002-20250703    gcc-13.4.0
sparc64               randconfig-001-20250703    gcc-8.5.0
sparc64               randconfig-002-20250703    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250703    gcc-12
um                    randconfig-002-20250703    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250703    gcc-11
x86_64      buildonly-randconfig-002-20250703    gcc-12
x86_64      buildonly-randconfig-003-20250703    clang-20
x86_64      buildonly-randconfig-004-20250703    clang-20
x86_64      buildonly-randconfig-005-20250703    gcc-12
x86_64      buildonly-randconfig-006-20250703    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250703    gcc-14.3.0
xtensa                randconfig-002-20250703    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


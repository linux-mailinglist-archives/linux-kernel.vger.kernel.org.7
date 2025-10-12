Return-Path: <linux-kernel+bounces-849771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 486E5BD0D7E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 01:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01B003B4491
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 23:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F842D6E7A;
	Sun, 12 Oct 2025 23:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z2H0Kz7K"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57ACD21ABA4
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 23:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760310781; cv=none; b=cQiNZyUYDjU+UJrSEFdPiJcD+gPZAj3NuJF3OsQ0897mhpZBhGzlXQ+VIJtdNiDmk750giMwg9rbP0uMwnWuJTGq01T2PsJ5pvqPiIu69EGwcuFgf7guzhWCKlarxiFLS6vm07ks9I+8BnFWsyRPZFMbDRe0w6kEW1UAu4AQa5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760310781; c=relaxed/simple;
	bh=zVFJQWsRBaCqF1vJIlkub7W9kn7DUpLKx4gdqpa+cYo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MZAGZ/AxcdrWtVuHIweMtw8Ztul6FbMweccxTMpInFEcO+DPYMoS8Irrr09PXWmTSTzwLRCuBn34fx3R15Bil4fYAtd/AQFFL1PdNNuCQkStpqEgQNd8yQO4Djom1aH0Jv1BaVR2+pmFM9mafXfFte9BFMkbiE3wA1A8IA2SwYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z2H0Kz7K; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760310779; x=1791846779;
  h=date:from:to:cc:subject:message-id;
  bh=zVFJQWsRBaCqF1vJIlkub7W9kn7DUpLKx4gdqpa+cYo=;
  b=Z2H0Kz7Ks+qNGDGDatXCXUjjHT58bUr4VwKefRXrAYIL/VfkNW0c5Izi
   W+c1SFOxA4aZ5LuW5SELGITPZJ2J5D350MzB88RHe2GRVOvnZgwbxGgN6
   Iy2gf4xOaoPE0tVjy3Ornjl/FA8gv7LqBGkYWV613Ha0dCyBzDXOj970Q
   DvnDcrxOyqP2B+ZoyWgt+xVVfsned26/CT2q7evdoHbpOqdUAqYG/Iyh9
   lJt6siAChpDDMavd7OPHIHacwubKByd7q1DUiquM+/k2G89VhE+bAEWNX
   Jw4+1J5xD9s8ckB4MVf8HsBcoYqKeDc926BigFEmK32zV/9025YTZuSPN
   w==;
X-CSE-ConnectionGUID: WMZvfoskSWCvTwOzQeSZ9w==
X-CSE-MsgGUID: IBBvmOxNT4aQeUC2dHA6vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="73548171"
X-IronPort-AV: E=Sophos;i="6.19,224,1754982000"; 
   d="scan'208";a="73548171"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2025 16:12:59 -0700
X-CSE-ConnectionGUID: 7naE7hqzRrqN1ayBEJsTlQ==
X-CSE-MsgGUID: 3wkIxYdSRViujEESYkxI+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,224,1754982000"; 
   d="scan'208";a="205132525"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 12 Oct 2025 16:12:57 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v85FH-0004d9-1Y;
	Sun, 12 Oct 2025 23:12:55 +0000
Date: Mon, 13 Oct 2025 07:12:06 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 f7e9bf642fda94d0398fca7733f8499318256484
Message-ID: <202510130700.NLemSTEW-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: f7e9bf642fda94d0398fca7733f8499318256484  Merge branch into tip/master: 'core/bugs'

elapsed time: 734m

configs tested: 134
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
arc                   randconfig-001-20251012    gcc-8.5.0
arc                   randconfig-002-20251012    gcc-15.1.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                   randconfig-001-20251012    clang-19
arm                   randconfig-002-20251012    gcc-10.5.0
arm                   randconfig-003-20251012    clang-20
arm                   randconfig-004-20251012    gcc-10.5.0
arm                    vt8500_v6_v7_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251012    gcc-8.5.0
arm64                 randconfig-002-20251012    clang-22
arm64                 randconfig-003-20251012    gcc-14.3.0
arm64                 randconfig-004-20251012    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251012    gcc-15.1.0
csky                  randconfig-002-20251012    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251012    clang-22
hexagon               randconfig-002-20251012    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251012    clang-20
i386        buildonly-randconfig-002-20251012    clang-20
i386        buildonly-randconfig-003-20251012    gcc-14
i386        buildonly-randconfig-004-20251012    clang-20
i386        buildonly-randconfig-005-20251012    clang-20
i386        buildonly-randconfig-006-20251012    gcc-14
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20251012    gcc-12.5.0
loongarch             randconfig-002-20251012    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                        m5307c3_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251012    gcc-11.5.0
nios2                 randconfig-002-20251012    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
openrisc                    or1ksim_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251012    gcc-14.3.0
parisc                randconfig-002-20251012    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                       ebony_defconfig    clang-22
powerpc                   lite5200b_defconfig    clang-22
powerpc                 mpc834x_itx_defconfig    clang-16
powerpc               randconfig-001-20251012    gcc-12.5.0
powerpc               randconfig-002-20251012    clang-22
powerpc               randconfig-003-20251012    gcc-14.3.0
powerpc64             randconfig-001-20251012    clang-22
powerpc64             randconfig-002-20251012    gcc-12.5.0
powerpc64             randconfig-003-20251012    gcc-13.4.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251012    clang-22
riscv                 randconfig-002-20251012    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251012    gcc-8.5.0
s390                  randconfig-002-20251012    clang-17
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                               j2_defconfig    gcc-15.1.0
sh                    randconfig-001-20251012    gcc-15.1.0
sh                    randconfig-002-20251012    gcc-9.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251012    gcc-15.1.0
sparc                 randconfig-002-20251012    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251012    clang-20
sparc64               randconfig-002-20251012    gcc-11.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251012    clang-22
um                    randconfig-002-20251012    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251012    gcc-14
x86_64      buildonly-randconfig-002-20251012    gcc-14
x86_64      buildonly-randconfig-003-20251012    gcc-14
x86_64      buildonly-randconfig-004-20251012    gcc-14
x86_64      buildonly-randconfig-005-20251012    clang-20
x86_64      buildonly-randconfig-006-20251012    gcc-14
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251012    gcc-8.5.0
xtensa                randconfig-002-20251012    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


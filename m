Return-Path: <linux-kernel+bounces-751242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7254B166D5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BBA218C88A3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CA12DEA8F;
	Wed, 30 Jul 2025 19:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Da4fcqbg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B78F2BCFB
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 19:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753903326; cv=none; b=EjnTdvBBcdgg7N/OJdb8X+sKlnxd7ZO6IVFIDH9h79e5LnPt+fBkzVGwCCASM9IA+aFztcl3J3LuJSU4n+qE+KkMFOa0MKCd45ijbk5VyopbviUsgwwRDfL0IVv5KwdkBPweGIaJkta6BeiBHvI5FwBWVjMJyS2RrXE5tlZW3ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753903326; c=relaxed/simple;
	bh=4/6iUpVqAV7Gfv0sD9U4QvnlQDFRwjGmx7tBPGBLO8s=;
	h=Date:From:To:Cc:Subject:Message-ID; b=S7huP9AS2DtvcUuRQ8j/4xqsSD15XvthWY1u3GQQ5fZm+3ad7wWe7cTlZXpl7RZ3hw9YdV0ReU3xOLehITwuNv23tyPVdOb8GhFWTEBu9FFESSZqCaCM6DzOfvtfCMNMC3s0G46rhZ4D9IvpYVlGTUtZ0bbQe/o6YCy5Qt21Ba4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Da4fcqbg; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753903325; x=1785439325;
  h=date:from:to:cc:subject:message-id;
  bh=4/6iUpVqAV7Gfv0sD9U4QvnlQDFRwjGmx7tBPGBLO8s=;
  b=Da4fcqbg8g8O0awWfUuKBCssnsXwNHyYQ09SRiwNEY8o+II20HQr760U
   0u9loMVrYqgHwZZP7CZ/V6tArNFeA0U64FlyVTX0FRHvVBczrjn0386+U
   S8p+ftbAn9Dr/Tc2buj7G6ZRpw/DfB2ItJnmGDGcdJVQpWH91hL0s+MrS
   z4JrT6LecWgm67Uaw3nUwJYgN28m+vEN6dhFm+cHCXkw+6GU4KycOGjtt
   xE2AcCwwGnjV5Mz3HxnNtkQmyp9qN7UP9QasSz+AHOl3UPdYerrhLCcOv
   QWgoBCKPq9SV5k7Uf1FhGyuod5HfGXubdTR1gn7Bm9k2eNAmgphXXJOwM
   A==;
X-CSE-ConnectionGUID: hR4b65z+TjaVs+WgG52aog==
X-CSE-MsgGUID: cWBGHsztTbmmynR/AV8c2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="67658934"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="67658934"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 12:22:04 -0700
X-CSE-ConnectionGUID: EGH6W5onR5Sq4/aEIZJw6g==
X-CSE-MsgGUID: PUP9KDlHQymP9bzgvcQY8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="193912387"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 30 Jul 2025 12:22:03 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uhCNF-00034g-1X;
	Wed, 30 Jul 2025 19:22:01 +0000
Date: Thu, 31 Jul 2025 03:21:37 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 6cdd7ae1b73b49ce35529c65765a5d2617b83e5d
Message-ID: <202507310330.7nmkz0Mx-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 6cdd7ae1b73b49ce35529c65765a5d2617b83e5d  Merge branch into tip/master: 'timers/clocksource'

elapsed time: 726m

configs tested: 121
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250730    gcc-8.5.0
arc                   randconfig-002-20250730    gcc-14.3.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                       aspeed_g4_defconfig    clang-22
arm                        multi_v5_defconfig    gcc-15.1.0
arm                          pxa168_defconfig    clang-19
arm                   randconfig-001-20250730    clang-22
arm                   randconfig-002-20250730    clang-20
arm                   randconfig-003-20250730    gcc-8.5.0
arm                   randconfig-004-20250730    gcc-14.3.0
arm                           sunxi_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250730    clang-22
arm64                 randconfig-002-20250730    clang-20
arm64                 randconfig-003-20250730    clang-17
arm64                 randconfig-004-20250730    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250730    gcc-14.3.0
csky                  randconfig-002-20250730    gcc-12.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250730    clang-20
hexagon               randconfig-002-20250730    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250730    clang-20
i386        buildonly-randconfig-002-20250730    clang-20
i386        buildonly-randconfig-003-20250730    gcc-12
i386        buildonly-randconfig-004-20250730    gcc-12
i386        buildonly-randconfig-005-20250730    clang-20
i386        buildonly-randconfig-006-20250730    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250730    clang-22
loongarch             randconfig-002-20250730    clang-20
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250730    gcc-11.5.0
nios2                 randconfig-002-20250730    gcc-9.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250730    gcc-14.3.0
parisc                randconfig-002-20250730    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250730    gcc-8.5.0
powerpc               randconfig-002-20250730    gcc-8.5.0
powerpc               randconfig-003-20250730    clang-22
powerpc                  storcenter_defconfig    gcc-15.1.0
powerpc                     tqm8555_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250730    clang-22
powerpc64             randconfig-002-20250730    clang-22
powerpc64             randconfig-003-20250730    gcc-10.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250730    gcc-10.5.0
riscv                 randconfig-002-20250730    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250730    clang-20
s390                  randconfig-002-20250730    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                          polaris_defconfig    gcc-15.1.0
sh                    randconfig-001-20250730    gcc-12.5.0
sh                    randconfig-002-20250730    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250730    gcc-14.3.0
sparc                 randconfig-002-20250730    gcc-14.3.0
sparc64               randconfig-001-20250730    clang-22
sparc64               randconfig-002-20250730    clang-20
um                               alldefconfig    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                    randconfig-001-20250730    gcc-11
um                    randconfig-002-20250730    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250730    gcc-12
x86_64      buildonly-randconfig-002-20250730    clang-20
x86_64      buildonly-randconfig-003-20250730    clang-20
x86_64      buildonly-randconfig-004-20250730    clang-20
x86_64      buildonly-randconfig-005-20250730    clang-20
x86_64      buildonly-randconfig-006-20250730    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250730    gcc-11.5.0
xtensa                randconfig-002-20250730    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


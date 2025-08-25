Return-Path: <linux-kernel+bounces-783839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F089FB33362
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 02:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 913E34438CD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 00:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A8C1D5CD1;
	Mon, 25 Aug 2025 00:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lDIZ+f8e"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1B84A02
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 00:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756081429; cv=none; b=J31khIWlZBDMu/ZnJFcwbh7/1zLFjXQWEU4RFZm1BQD3O9UVfMRiL+SEYt9JZCgZCzkmg1nXfHVRr2HGdgLdaFZw9MWfdSPvKZ19TbFJR+Kh5nKZuWqcifOpK+x1ggyyJI8dKK611TGtCYEYnfSSoaxCoMeDWwADRn0g3/KVfMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756081429; c=relaxed/simple;
	bh=G7BKHdYdsJ7eT0/zy1mAQh42l5pWcLx2Qb69LcvuhTo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Vf4CJkQxBAdbt33mBtCrl8GuJZHeNzTjY9x+yJrINSIb4rrOx/r9LmP0ja+HVFQJuHSw4uvyOMjT26Srw/d8vU3HmxCreiNynT9tA7nm4ojITJgXRVG8mxAgbfwdEKwvf8p+IiuRTP9YjXycfFE784EY5M61FAG4XGwSn4drp68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lDIZ+f8e; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756081428; x=1787617428;
  h=date:from:to:cc:subject:message-id;
  bh=G7BKHdYdsJ7eT0/zy1mAQh42l5pWcLx2Qb69LcvuhTo=;
  b=lDIZ+f8eO55enTbBPRHPD299wMTzjVMaTXWiQED3Li4VbNdLrYkjVskX
   MUeMnZslsGp4Xv/Hgtsnl1erzBqW7J+0qGpx/uBl3X4RNQF8P6/a+fSYg
   OJg07cCP+30m/flXLFaZ/zVZon0dGFNhdozWGAdw+YrPbrRTJgVDpgdAn
   WiLiZJuG9p5GKNF1SLDYy0rUceIq74DCRY9sAOj87zkfT6AzvTaZ/+W0H
   ZxgQUbk1+PkKcRBWkyvoJ896g7Na22e0xbJevgDyg9igb+3VIdhniz3FK
   JrPSnM44Fl163ZyqHrcPJRvOY4VUIxt+w1yE7or19T0u1xlc6MVCbd2rl
   Q==;
X-CSE-ConnectionGUID: FR3ISskUS8+c0XZHxPmkJA==
X-CSE-MsgGUID: KvTlP5WpRy+xa5UiENWv9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11532"; a="58000345"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58000345"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2025 17:23:47 -0700
X-CSE-ConnectionGUID: sF9yc0p/Qn+pZcxGx6ZAUg==
X-CSE-MsgGUID: PdDrnkfJSMmqGtp63CmXdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="173344262"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 24 Aug 2025 17:23:46 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uqKzN-000NHF-2X;
	Mon, 25 Aug 2025 00:23:20 +0000
Date: Mon, 25 Aug 2025 08:21:39 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 35c23871be0072738ccc7ca00354c791711e5640
Message-ID: <202508250829.P0vZopKk-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
branch HEAD: 35c23871be0072738ccc7ca00354c791711e5640  irqchip/gic-v5: Remove undue WARN_ON()s in the IRS affinity parsing

elapsed time: 806m

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
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250824    gcc-15.1.0
arc                   randconfig-002-20250824    gcc-10.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                   randconfig-001-20250824    clang-22
arm                   randconfig-002-20250824    gcc-13.4.0
arm                   randconfig-003-20250824    clang-22
arm                   randconfig-004-20250824    clang-22
arm                        realview_defconfig    clang-16
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250824    gcc-13.4.0
arm64                 randconfig-002-20250824    gcc-11.5.0
arm64                 randconfig-003-20250824    gcc-10.5.0
arm64                 randconfig-004-20250824    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250824    gcc-10.5.0
csky                  randconfig-002-20250824    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20250824    clang-22
hexagon               randconfig-002-20250824    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250824    gcc-12
i386        buildonly-randconfig-002-20250824    gcc-12
i386        buildonly-randconfig-003-20250824    gcc-12
i386        buildonly-randconfig-004-20250824    gcc-12
i386        buildonly-randconfig-005-20250824    gcc-12
i386        buildonly-randconfig-006-20250824    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250824    gcc-12.5.0
loongarch             randconfig-002-20250824    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                          multi_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                   sb1250_swarm_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250824    gcc-8.5.0
nios2                 randconfig-002-20250824    gcc-9.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250824    gcc-9.5.0
parisc                randconfig-002-20250824    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250824    gcc-9.5.0
powerpc               randconfig-002-20250824    clang-22
powerpc               randconfig-003-20250824    gcc-12.5.0
powerpc                     redwood_defconfig    clang-22
powerpc64             randconfig-001-20250824    gcc-8.5.0
powerpc64             randconfig-002-20250824    gcc-13.4.0
powerpc64             randconfig-003-20250824    gcc-12.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250824    gcc-11.5.0
riscv                 randconfig-002-20250824    gcc-9.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250824    clang-16
s390                  randconfig-002-20250824    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                        edosk7760_defconfig    gcc-15.1.0
sh                    randconfig-001-20250824    gcc-15.1.0
sh                    randconfig-002-20250824    gcc-15.1.0
sh                           se7705_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250824    gcc-14.3.0
sparc                 randconfig-002-20250824    gcc-8.5.0
sparc                       sparc32_defconfig    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250824    clang-22
sparc64               randconfig-002-20250824    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250824    gcc-12
um                    randconfig-002-20250824    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250824    gcc-12
x86_64      buildonly-randconfig-002-20250824    clang-20
x86_64      buildonly-randconfig-003-20250824    gcc-12
x86_64      buildonly-randconfig-004-20250824    clang-20
x86_64      buildonly-randconfig-005-20250824    gcc-12
x86_64      buildonly-randconfig-006-20250824    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250824    gcc-9.5.0
xtensa                randconfig-002-20250824    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


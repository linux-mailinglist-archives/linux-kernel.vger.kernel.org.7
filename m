Return-Path: <linux-kernel+bounces-754553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC776B196D6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 01:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA1A4188F89C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 23:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3D1214A94;
	Sun,  3 Aug 2025 23:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="etFFwG6T"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617A51F4165
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 23:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754263781; cv=none; b=Z3EDZuS9QO5vIIhxVPaRpr/1jMzXgAuE7HqU8z0TDsFaaci9t4lOEIQRvIOEDFWd+M9zcs/qqxLzHWRytIO48BWZBYkDgEq/BCI4DFHLt88eTcJLx2m0nVMgTnkMzM0ZL1LgkzUnifX2LOdU3w/HHjIFDPIzJP4WdnBHFib7Kg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754263781; c=relaxed/simple;
	bh=TzuWQHXOSTYET0eCzBzbFKc4by0sIkF5Ew4aL2y0VaQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Mu8xCKthkQyGwGvqnPgMXungGgUGaC7mXoz7tRez23eLaKYLYQjsOU4lAUnpSxXr73vIn8yo0xW5weqoThvBuLSX+fAxxXFNmwqhHZSv1y6xAaEZswKCpnXa50pGTxyTuLL/ix6xzRCDVEfT5y0KnHGi3y0FLvuwQeHSUz1aLlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=etFFwG6T; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754263779; x=1785799779;
  h=date:from:to:cc:subject:message-id;
  bh=TzuWQHXOSTYET0eCzBzbFKc4by0sIkF5Ew4aL2y0VaQ=;
  b=etFFwG6TupI+UYLL2AFqDlrK9Yt87bcFuJouOP6CGEpr95asQ08IyTYV
   ke6jL/QsRvdqw5keTENtdOzYvo1Bv3cepNOihf/NiNbn9NZYbfXTskU+w
   D3XqCPa1eSUf2H1ujUD1Te/NDQCJ8ghCKGdmijxgaeey0DA5SuJpHtPPU
   L4jnBQomj9qZDrcqrRV2S3XCt8WHCr4SsAgjCJzgmZ8ExLh/d471GQtee
   zABVKl/w6jA6tVUmKzJqP3oABvfgzEZlC+moHxlbhnEdTh9X7PU5yIwVq
   /aT/ILKpLOzcZUJ9mGgoknoy+723lxJvnXpYI1+vqsZp2LmPPcjP46sQJ
   A==;
X-CSE-ConnectionGUID: mVuTdHsWRqehnO84E0AGzQ==
X-CSE-MsgGUID: beza16OtSEeikoURgEGN3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11511"; a="60334341"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="60334341"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2025 16:29:35 -0700
X-CSE-ConnectionGUID: 2nddgN/eR2eAhZmdEl49Zg==
X-CSE-MsgGUID: jIcFKruXSI29/FJEugwNkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="163693825"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 03 Aug 2025 16:29:34 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uii8x-0006gG-31;
	Sun, 03 Aug 2025 23:29:31 +0000
Date: Mon, 04 Aug 2025 07:29:11 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 8d260bf78488bd576e619fb53806290c2a195cba
Message-ID: <202508040701.pXjdPGY5-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
branch HEAD: 8d260bf78488bd576e619fb53806290c2a195cba  irqchip/riscv-imsic: Don't dereference before NULL pointer check

elapsed time: 723m

configs tested: 135
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
arc                   randconfig-001-20250803    gcc-15.1.0
arc                   randconfig-002-20250803    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                          gemini_defconfig    clang-20
arm                          pxa3xx_defconfig    clang-22
arm                   randconfig-001-20250803    gcc-8.5.0
arm                   randconfig-002-20250803    gcc-8.5.0
arm                   randconfig-003-20250803    clang-22
arm                   randconfig-004-20250803    clang-22
arm                        realview_defconfig    clang-16
arm                          sp7021_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250803    gcc-8.5.0
arm64                 randconfig-002-20250803    gcc-11.5.0
arm64                 randconfig-003-20250803    clang-17
arm64                 randconfig-004-20250803    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250803    gcc-11.5.0
csky                  randconfig-002-20250803    gcc-15.1.0
hexagon                          alldefconfig    clang-22
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20250803    clang-22
hexagon               randconfig-002-20250803    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250803    gcc-12
i386        buildonly-randconfig-002-20250803    clang-20
i386        buildonly-randconfig-003-20250803    gcc-12
i386        buildonly-randconfig-004-20250803    gcc-12
i386        buildonly-randconfig-005-20250803    clang-20
i386        buildonly-randconfig-006-20250803    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250803    gcc-15.1.0
loongarch             randconfig-002-20250803    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           xway_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250803    gcc-8.5.0
nios2                 randconfig-002-20250803    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250803    gcc-13.4.0
parisc                randconfig-002-20250803    gcc-13.4.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                      ppc44x_defconfig    clang-22
powerpc               randconfig-001-20250803    gcc-8.5.0
powerpc               randconfig-002-20250803    gcc-8.5.0
powerpc               randconfig-003-20250803    gcc-13.4.0
powerpc64             randconfig-001-20250803    clang-17
powerpc64             randconfig-002-20250803    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250803    clang-22
riscv                 randconfig-002-20250803    clang-17
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250803    gcc-13.4.0
s390                  randconfig-002-20250803    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                        dreamcast_defconfig    gcc-15.1.0
sh                    randconfig-001-20250803    gcc-15.1.0
sh                    randconfig-002-20250803    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250803    gcc-8.5.0
sparc                 randconfig-002-20250803    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250803    clang-22
sparc64               randconfig-002-20250803    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250803    clang-22
um                    randconfig-002-20250803    clang-16
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250803    gcc-12
x86_64      buildonly-randconfig-002-20250803    clang-20
x86_64      buildonly-randconfig-003-20250803    gcc-12
x86_64      buildonly-randconfig-004-20250803    gcc-12
x86_64      buildonly-randconfig-005-20250803    gcc-12
x86_64      buildonly-randconfig-006-20250803    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250803    gcc-12.5.0
xtensa                randconfig-002-20250803    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


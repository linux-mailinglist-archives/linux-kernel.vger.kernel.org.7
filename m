Return-Path: <linux-kernel+bounces-651558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1697AABA00E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 17:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40C4A7B940B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 15:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403521BCA07;
	Fri, 16 May 2025 15:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nYFQ2341"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B741CAA7B
	for <linux-kernel@vger.kernel.org>; Fri, 16 May 2025 15:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747409880; cv=none; b=oD32Ri6nIw4WukdxR+U4LWbq/CQ/7xAvc3ypGvoNRjhnbhqXmh5aowokKW2sTUymSbbU8eTwdl9o54s8hZHiNtlw8FnO8rNsLM0gjRlXlsLHa9bNgTPTExE0iznYi754pHfJFlRoHcOh5w4O4N4pKKpGubmrWBK4U3puGJJatsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747409880; c=relaxed/simple;
	bh=77833V1triZR7LQ9D1GIy1YRnNQblpVZsTvfhve3XVQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=f6aV+TtpuNSoVcWrKpal5psmtdoe4WMYvg22b2XZOMH7adp10ZVQG97tOx0/jfOfOptziYtgMIfErGR4iYI9do/e+bxdON1q7pB651CqUKvYw2BHaP9aqQcaEJuKiW7DY9UHrtplERt2wHAY/7DlI/ozFzb4/KydbcuV/IUrU8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nYFQ2341; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747409879; x=1778945879;
  h=date:from:to:cc:subject:message-id;
  bh=77833V1triZR7LQ9D1GIy1YRnNQblpVZsTvfhve3XVQ=;
  b=nYFQ2341n6gtNoMqGG3rfwhDxhPJ/knuqQc+Vd78zPcJdXaeyTe133Q3
   L8Pd0DcOY80IPgAW+xvRRbDy12RCReMGLvZojI59soieMVyC9QPG8WufK
   X1zhFMOWrL/ReOkcaykY3hqf1hh0Vklrcq/57CXMGaiGFU+ZqulS6xbgv
   zTck0qJXqlGaJ1Hbnw0yxT6NYTJknwq9h47uhEI8D7qqwSrLMlryiyA7D
   kcixJyM6ewcDuJQQnAEpYRkVITqTILFPlw5Kl5g4ivQBjv0AxR27SIvjg
   A4Z2iXip0gKo4ES8SA0YvZNShcpfTZ4ezeLOKdr+3jHiS6Ac5uGkwud6k
   Q==;
X-CSE-ConnectionGUID: L0NIzMAxSaCqM7aTJ2br4A==
X-CSE-MsgGUID: cEDg7nrZScS/VylmEyrGyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="60412908"
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="60412908"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 08:37:58 -0700
X-CSE-ConnectionGUID: g15TFyEWQ9i11AgCRCx+Sg==
X-CSE-MsgGUID: plTp645CRfOx6mTLSWtocw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="138579873"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 16 May 2025 08:37:57 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uFx8F-000JT6-03;
	Fri, 16 May 2025 15:37:55 +0000
Date: Fri, 16 May 2025 23:37:41 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 788019eb559fd0b365f501467ceafce540e377cc
Message-ID: <202505162332.kUBCcbRp-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: 788019eb559fd0b365f501467ceafce540e377cc  genirq: Retain disable depth for managed interrupts across CPU hotplug

elapsed time: 1445m

configs tested: 118
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                          axs101_defconfig    gcc-14.2.0
arc                            hsdk_defconfig    gcc-14.2.0
arc                        nsim_700_defconfig    gcc-14.2.0
arc                   randconfig-001-20250516    gcc-13.3.0
arc                   randconfig-002-20250516    gcc-13.3.0
arm                               allnoconfig    clang-21
arm                       aspeed_g4_defconfig    clang-21
arm                          pxa910_defconfig    gcc-14.2.0
arm                   randconfig-001-20250516    gcc-7.5.0
arm                   randconfig-002-20250516    clang-21
arm                   randconfig-003-20250516    clang-21
arm                   randconfig-004-20250516    clang-21
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250516    gcc-9.5.0
arm64                 randconfig-002-20250516    gcc-9.5.0
arm64                 randconfig-003-20250516    gcc-5.5.0
arm64                 randconfig-004-20250516    gcc-9.5.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250516    gcc-14.2.0
csky                  randconfig-002-20250516    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250516    clang-19
hexagon               randconfig-002-20250516    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250516    clang-20
i386        buildonly-randconfig-002-20250516    gcc-12
i386        buildonly-randconfig-003-20250516    clang-20
i386        buildonly-randconfig-004-20250516    clang-20
i386        buildonly-randconfig-005-20250516    clang-20
i386        buildonly-randconfig-006-20250516    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250516    gcc-14.2.0
loongarch             randconfig-002-20250516    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250516    gcc-13.3.0
nios2                 randconfig-002-20250516    gcc-13.3.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250516    gcc-10.5.0
parisc                randconfig-002-20250516    gcc-12.4.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                      cm5200_defconfig    clang-21
powerpc                 mpc836x_rdk_defconfig    clang-21
powerpc                 mpc837x_rdb_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250516    gcc-5.5.0
powerpc               randconfig-002-20250516    gcc-5.5.0
powerpc               randconfig-003-20250516    clang-17
powerpc                     redwood_defconfig    clang-21
powerpc64             randconfig-001-20250516    clang-21
powerpc64             randconfig-002-20250516    clang-21
powerpc64             randconfig-003-20250516    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250516    gcc-7.5.0
riscv                 randconfig-002-20250516    gcc-14.2.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250516    gcc-7.5.0
s390                  randconfig-002-20250516    gcc-7.5.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                        dreamcast_defconfig    gcc-14.2.0
sh                    randconfig-001-20250516    gcc-7.5.0
sh                    randconfig-002-20250516    gcc-9.3.0
sh                           se7206_defconfig    gcc-14.2.0
sh                          urquell_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250516    gcc-8.5.0
sparc                 randconfig-002-20250516    gcc-8.5.0
sparc64               randconfig-001-20250516    gcc-12.4.0
sparc64               randconfig-002-20250516    gcc-14.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250516    clang-21
um                    randconfig-002-20250516    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250516    clang-20
x86_64      buildonly-randconfig-002-20250516    gcc-12
x86_64      buildonly-randconfig-003-20250516    clang-20
x86_64      buildonly-randconfig-004-20250516    clang-20
x86_64      buildonly-randconfig-005-20250516    gcc-12
x86_64      buildonly-randconfig-006-20250516    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250516    gcc-10.5.0
xtensa                randconfig-002-20250516    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


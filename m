Return-Path: <linux-kernel+bounces-868364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C96C050B6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A4F4188F184
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CDF305960;
	Fri, 24 Oct 2025 08:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qn4zADt2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84271A5B9D
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761294642; cv=none; b=K+YypE9y0wK7Iyn7Wx9ZpVYQZa5ri1cjvOWshdBlNkxDxPCs6qtX3925Fninv6T2Q8+FUHAkXY1GeAULXRlDMlNWIvHeB/pMs+KKP7PuSMJoRZUgV/0ICmqZbQ8ewOIusUOcKy2T4txGcgla7DBKEPquCHS0ENQIHZFs2n/I5b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761294642; c=relaxed/simple;
	bh=u6swQJLD4rclOrsGkAn4caO05vCLupsTtgh7++oyDk4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=iDIPc8MPiFs4kQd3S/JpihKOm9zzGwRTqh9URD8nZryTD81deE0bdXMVXPeutrj5PJ3MBK/VF3OdeKcOilpi46RR8nx7ZaW6elc/Hrfs6g8/lrr8cNSJB6/wsB/JmXktqmtppS0K1kDPS271m36XRHUNjvqKeD/6fHTZnEubHUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qn4zADt2; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761294641; x=1792830641;
  h=date:from:to:cc:subject:message-id;
  bh=u6swQJLD4rclOrsGkAn4caO05vCLupsTtgh7++oyDk4=;
  b=Qn4zADt2niovY3jK6PpsDdtBmDJsN2+Lq5KusoxPiCcLp4OggsWTYQhh
   8RZ1B7/Snow8AtWby7HzdyIejgCp879Nkye3M+G4CR+bJKbCpNI+4NecP
   kLont9BE1IriiCaSGG8Q9cLpJXjQXiphGgNMBUvEQxtQQ6hlfiZwgHmSJ
   0rwHJFf3aPNnFG9/U5ZcX9c6dS/bMk/BJsCIi9vPpi3XQB9q3pTPfMr9u
   RdXdpWTltosphiWGFIsjIPuxcmKfIAEprdA5KJfWUUk3t31OwLWpmPKqZ
   3yP7cQ6nuKrMb91ddCKxgYylN39fZT9qifVHxQDPI8TwWH3gVDqWDtTwv
   g==;
X-CSE-ConnectionGUID: Xl3J2+Z+TzSX1tNvs8ve8A==
X-CSE-MsgGUID: kILCYtpgQ/2iv8gLQi7g+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67309673"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="67309673"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 01:30:40 -0700
X-CSE-ConnectionGUID: x687JKIVQ7CAfPEhg6JK3g==
X-CSE-MsgGUID: VmErXXHYSrqCLuJ39E/4TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="215300266"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 24 Oct 2025 01:30:39 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vCDC1-000EL7-0C;
	Fri, 24 Oct 2025 08:30:37 +0000
Date: Fri, 24 Oct 2025 16:29:47 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 db4bce9b769c5034f70cb16fcb1afe956fd7cc65
Message-ID: <202510241642.tlSsKxKf-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: db4bce9b769c5034f70cb16fcb1afe956fd7cc65  Merge branch into tip/master: 'x86/sgx'

elapsed time: 1450m

configs tested: 117
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20251023    gcc-8.5.0
arc                   randconfig-002-20251023    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                        clps711x_defconfig    clang-22
arm                          pxa168_defconfig    clang-19
arm                   randconfig-001-20251023    clang-22
arm                   randconfig-002-20251023    clang-19
arm                   randconfig-003-20251023    gcc-8.5.0
arm                   randconfig-004-20251023    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251023    clang-22
arm64                 randconfig-002-20251023    gcc-8.5.0
arm64                 randconfig-003-20251023    gcc-8.5.0
arm64                 randconfig-004-20251023    clang-17
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251023    gcc-11.5.0
csky                  randconfig-002-20251023    gcc-13.4.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20251023    clang-22
hexagon               randconfig-002-20251023    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251023    clang-20
i386        buildonly-randconfig-002-20251023    clang-20
i386        buildonly-randconfig-003-20251023    gcc-14
i386        buildonly-randconfig-004-20251023    clang-20
i386        buildonly-randconfig-005-20251023    clang-20
i386        buildonly-randconfig-006-20251023    clang-20
i386                                defconfig    clang-20
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20251023    clang-22
loongarch             randconfig-002-20251023    clang-18
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                       m5208evb_defconfig    gcc-15.1.0
m68k                            mac_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          rb532_defconfig    clang-18
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251023    gcc-8.5.0
nios2                 randconfig-002-20251023    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251023    gcc-9.5.0
parisc                randconfig-002-20251023    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                   bluestone_defconfig    clang-22
powerpc               mpc834x_itxgp_defconfig    clang-22
powerpc               randconfig-001-20251023    gcc-12.5.0
powerpc               randconfig-002-20251023    clang-22
powerpc               randconfig-003-20251023    clang-22
powerpc64             randconfig-001-20251023    clang-22
powerpc64             randconfig-002-20251023    gcc-10.5.0
powerpc64             randconfig-003-20251023    gcc-10.5.0
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20251023    gcc-8.5.0
riscv                 randconfig-002-20251023    gcc-14.3.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20251023    clang-19
s390                  randconfig-002-20251023    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                          r7785rp_defconfig    gcc-15.1.0
sh                    randconfig-001-20251023    gcc-15.1.0
sh                    randconfig-002-20251023    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251023    gcc-12.5.0
sparc                 randconfig-002-20251023    gcc-8.5.0
sparc64               randconfig-001-20251023    clang-22
sparc64               randconfig-002-20251023    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                    randconfig-001-20251023    gcc-13
um                    randconfig-002-20251023    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251023    clang-20
x86_64      buildonly-randconfig-002-20251023    gcc-13
x86_64      buildonly-randconfig-003-20251023    clang-20
x86_64      buildonly-randconfig-004-20251023    gcc-14
x86_64      buildonly-randconfig-005-20251023    clang-20
x86_64      buildonly-randconfig-006-20251023    gcc-14
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251023    gcc-8.5.0
xtensa                randconfig-002-20251023    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


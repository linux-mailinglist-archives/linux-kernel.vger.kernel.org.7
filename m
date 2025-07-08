Return-Path: <linux-kernel+bounces-720671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B90DAFBF1B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 02:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E583217D370
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 00:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B953A92E;
	Tue,  8 Jul 2025 00:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kUWm0Bcq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8267E7464
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 00:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751933329; cv=none; b=E3/fR9slDFnt5B3Hw3ILCRXXWa9JGnumy4IEDR2fFCUfdCJxL3nFdtwQRlhSbzOinpgzW//iQkk+zQAzwTw7wH5tSPq2PD7PGJOvKR/mn0poBwVV3MnMktZIa/DgCTBFZWz5MMm783AhRBSCk3DPjiRf6nmqTEFbFkGz7kIHXFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751933329; c=relaxed/simple;
	bh=3/aOGeGt5Sc3gE9hzvDfyz/YTB0QLXRulhtEXq1lvX4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ey+qEfMIsZ1YWY0CZ90shOP4/0ELaFnGyCktWzwlAYUsEOCXXYeXAg6wFmDyWgL7DbNFeua5Nvzv+V8Q8gsqnhFTWo0hr7YiNsf3ugW9DisaaU7VxakjAovrof9ubbeV00I+oL0if40183oFc3I13BLJim2R3N2GbS6XHXCd8xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kUWm0Bcq; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751933327; x=1783469327;
  h=date:from:to:cc:subject:message-id;
  bh=3/aOGeGt5Sc3gE9hzvDfyz/YTB0QLXRulhtEXq1lvX4=;
  b=kUWm0BcqOCm6daOBFG5XZ66e8UtM9x3Kvw5BbE+B+599PlkGdz1+EEtJ
   YNqhvrJ+jIoI1J4128nRzjiU4oBHFT/cCdfbd3duHHZ0lY8Y2a00WZn2e
   YNX2frf6l6p8G+h6m5dXtW2DWKoF2MacnZWuz8pnJEqx0RuJvWNErdDrd
   Rqhn8HcxiVHqVrDTHhZhqMKRCgCTRFBPZit12o4L3piZaZsUVvbN6vdgH
   IW2B7C5TIRx3DRowDCBDOclHy328SfnPXnbsOG0J1WaYx0DTDDWtDiJ8I
   xcT4vFr6DkCwdQTxGCEzPy/V/YGadMW0mffQELt+XzKSKMX7uvBb67DHp
   g==;
X-CSE-ConnectionGUID: 1SbfSJsER3yU+K2493CP6A==
X-CSE-MsgGUID: DF/jsB+lSRekYX9cb4Y/pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54048827"
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="54048827"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 17:08:47 -0700
X-CSE-ConnectionGUID: atIGTfRXSaG4UJaAYNrFyg==
X-CSE-MsgGUID: j3zxHzj5SBG0XsqAZiYEkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="156093675"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 07 Jul 2025 17:08:45 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uYvt5-0000q5-31;
	Tue, 08 Jul 2025 00:08:43 +0000
Date: Tue, 08 Jul 2025 08:08:34 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/ptp] BUILD SUCCESS WITH WARNING
 7893ea1006fcbb876ddf53ad4ebba4a054add4b2
Message-ID: <202507080820.1fRovuEx-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/ptp
branch HEAD: 7893ea1006fcbb876ddf53ad4ebba4a054add4b2  vdso/gettimeofday: Add support for auxiliary clocks

Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202507080348.hKtUspGk-lkp@intel.com

    lib/vdso/gettimeofday.c:335:17: warning: shift count >= width of type [-Wshift-count-overflow]

Warning ids grouped by kconfigs:

recent_errors
`-- powerpc-allyesconfig
    `-- lib-vdso-gettimeofday.c:warning:shift-count-width-of-type

elapsed time: 1001m

configs tested: 254
configs skipped: 7

tested configs:
alpha                             allnoconfig    clang-21
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-21
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20250707    gcc-15.1.0
arc                   randconfig-001-20250708    clang-17
arc                   randconfig-002-20250707    gcc-8.5.0
arc                   randconfig-002-20250708    clang-17
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                           imxrt_defconfig    clang-21
arm                        neponset_defconfig    gcc-15.1.0
arm                   randconfig-001-20250707    gcc-10.5.0
arm                   randconfig-001-20250708    clang-17
arm                   randconfig-002-20250707    gcc-11.5.0
arm                   randconfig-002-20250708    clang-17
arm                   randconfig-003-20250707    clang-21
arm                   randconfig-003-20250708    clang-17
arm                   randconfig-004-20250707    clang-21
arm                   randconfig-004-20250708    clang-17
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-21
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250707    gcc-8.5.0
arm64                 randconfig-001-20250708    clang-17
arm64                 randconfig-002-20250707    gcc-11.5.0
arm64                 randconfig-002-20250708    clang-17
arm64                 randconfig-003-20250707    gcc-12.3.0
arm64                 randconfig-003-20250708    clang-17
arm64                 randconfig-004-20250707    gcc-14.3.0
arm64                 randconfig-004-20250708    clang-17
csky                              allnoconfig    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250707    gcc-12.4.0
csky                  randconfig-001-20250707    gcc-15.1.0
csky                  randconfig-002-20250707    gcc-12.4.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250707    clang-21
hexagon               randconfig-001-20250707    gcc-12.4.0
hexagon               randconfig-002-20250707    clang-21
hexagon               randconfig-002-20250707    gcc-12.4.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250707    gcc-12
i386        buildonly-randconfig-002-20250707    clang-20
i386        buildonly-randconfig-003-20250707    gcc-12
i386        buildonly-randconfig-004-20250707    gcc-12
i386        buildonly-randconfig-005-20250707    gcc-12
i386        buildonly-randconfig-006-20250707    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250708    gcc-11
i386                  randconfig-002-20250708    gcc-11
i386                  randconfig-003-20250708    gcc-11
i386                  randconfig-004-20250708    gcc-11
i386                  randconfig-005-20250708    gcc-11
i386                  randconfig-006-20250708    gcc-11
i386                  randconfig-007-20250708    gcc-11
i386                  randconfig-011-20250708    clang-20
i386                  randconfig-012-20250708    clang-20
i386                  randconfig-013-20250708    clang-20
i386                  randconfig-014-20250708    clang-20
i386                  randconfig-015-20250708    clang-20
i386                  randconfig-016-20250708    clang-20
i386                  randconfig-017-20250708    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250707    clang-21
loongarch             randconfig-001-20250707    gcc-12.4.0
loongarch             randconfig-002-20250707    gcc-12.4.0
loongarch             randconfig-002-20250707    gcc-15.1.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                          multi_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          ath25_defconfig    gcc-15.1.0
mips                        maltaup_defconfig    clang-21
mips                        maltaup_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-14.2.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250707    gcc-10.5.0
nios2                 randconfig-001-20250707    gcc-12.4.0
nios2                 randconfig-002-20250707    gcc-12.4.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                generic-64bit_defconfig    gcc-15.1.0
parisc                randconfig-001-20250707    gcc-12.4.0
parisc                randconfig-001-20250707    gcc-8.5.0
parisc                randconfig-002-20250707    gcc-12.4.0
parisc                randconfig-002-20250707    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-15.1.0
powerpc                      bamboo_defconfig    gcc-15.1.0
powerpc                  mpc866_ads_defconfig    clang-21
powerpc               randconfig-001-20250707    gcc-12.4.0
powerpc               randconfig-001-20250707    gcc-8.5.0
powerpc               randconfig-002-20250707    clang-21
powerpc               randconfig-002-20250707    gcc-12.4.0
powerpc               randconfig-003-20250707    gcc-12.4.0
powerpc               randconfig-003-20250707    gcc-8.5.0
powerpc64             randconfig-001-20250707    gcc-12.4.0
powerpc64             randconfig-001-20250707    gcc-8.5.0
powerpc64             randconfig-002-20250707    gcc-10.5.0
powerpc64             randconfig-002-20250707    gcc-12.4.0
powerpc64             randconfig-003-20250707    clang-21
powerpc64             randconfig-003-20250707    gcc-12.4.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    clang-21
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250707    clang-21
riscv                 randconfig-001-20250708    clang-17
riscv                 randconfig-002-20250707    clang-21
riscv                 randconfig-002-20250708    clang-17
s390                             alldefconfig    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-21
s390                                defconfig    gcc-12
s390                  randconfig-001-20250707    clang-21
s390                  randconfig-001-20250708    clang-17
s390                  randconfig-002-20250707    gcc-11.5.0
s390                  randconfig-002-20250708    clang-17
s390                       zfcpdump_defconfig    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250707    gcc-15.1.0
sh                    randconfig-001-20250708    clang-17
sh                    randconfig-002-20250707    gcc-15.1.0
sh                    randconfig-002-20250708    clang-17
sh                   sh7724_generic_defconfig    gcc-15.1.0
sh                  sh7785lcr_32bit_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250707    gcc-12.4.0
sparc                 randconfig-001-20250708    clang-17
sparc                 randconfig-002-20250707    gcc-8.5.0
sparc                 randconfig-002-20250708    clang-17
sparc64                          alldefconfig    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250707    clang-20
sparc64               randconfig-001-20250708    clang-17
sparc64               randconfig-002-20250707    gcc-15.1.0
sparc64               randconfig-002-20250708    clang-17
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250707    gcc-12
um                    randconfig-001-20250708    clang-17
um                    randconfig-002-20250707    gcc-12
um                    randconfig-002-20250708    clang-17
um                           x86_64_defconfig    clang-21
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250707    gcc-12
x86_64      buildonly-randconfig-001-20250708    gcc-12
x86_64      buildonly-randconfig-002-20250707    gcc-12
x86_64      buildonly-randconfig-002-20250708    gcc-12
x86_64      buildonly-randconfig-003-20250707    gcc-12
x86_64      buildonly-randconfig-003-20250708    gcc-12
x86_64      buildonly-randconfig-004-20250707    clang-20
x86_64      buildonly-randconfig-004-20250708    gcc-12
x86_64      buildonly-randconfig-005-20250707    gcc-12
x86_64      buildonly-randconfig-005-20250708    gcc-12
x86_64      buildonly-randconfig-006-20250707    clang-20
x86_64      buildonly-randconfig-006-20250708    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250707    gcc-12
x86_64                randconfig-002-20250707    gcc-12
x86_64                randconfig-003-20250707    gcc-12
x86_64                randconfig-004-20250707    gcc-12
x86_64                randconfig-005-20250707    gcc-12
x86_64                randconfig-006-20250707    gcc-12
x86_64                randconfig-007-20250707    gcc-12
x86_64                randconfig-008-20250707    gcc-12
x86_64                randconfig-071-20250708    clang-20
x86_64                randconfig-072-20250708    clang-20
x86_64                randconfig-073-20250708    clang-20
x86_64                randconfig-074-20250708    clang-20
x86_64                randconfig-075-20250708    clang-20
x86_64                randconfig-076-20250708    clang-20
x86_64                randconfig-077-20250708    clang-20
x86_64                randconfig-078-20250708    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250707    gcc-12.4.0
xtensa                randconfig-001-20250708    clang-17
xtensa                randconfig-002-20250707    gcc-8.5.0
xtensa                randconfig-002-20250708    clang-17

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


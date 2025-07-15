Return-Path: <linux-kernel+bounces-731258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC4CB051DE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D62A01AA096E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 06:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11E9266574;
	Tue, 15 Jul 2025 06:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nj12e0UM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C5AB672
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 06:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752561326; cv=none; b=XxT1roEo6mgOHUUqjCgPFEsZt9Xn9ix+0DdDusBlNmXeSXMHqbERZtx8NlSwVpehoDE3xXOfzTfmcOebrMrkadsQHYWNHmnQ3ahYWBPXxjkJ5PfmCPZI0AGlCmJunSbJkQxd6aMdgg9pmPGqlHuElR1pGnabmNRBtXW2BpfVZBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752561326; c=relaxed/simple;
	bh=UZAIn5lSqB7iNAmmUwpAM1Ed9iuWdKd2AOL3bdicEvI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=orJbPuCJ3MpevvMhynubVVJnnKHsuDHeSV/5WIgq3Zwiu8PjQ7u1GAf3HlxAr47ywqap2j5q/llNqZheld3ec42OJb/dDr42GtKka5lXvDf5G+Wx+75VYOlUpQw5RkbjWNzUT7uLrA3wE8B1DZCak05kUidKcs8GrrLrj0O1b4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nj12e0UM; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752561325; x=1784097325;
  h=date:from:to:cc:subject:message-id;
  bh=UZAIn5lSqB7iNAmmUwpAM1Ed9iuWdKd2AOL3bdicEvI=;
  b=Nj12e0UMem7Ecb0Jr7ybfdiHDDgMvPvcqHevcKqjjDj293WkYnpSuXdF
   7CRuYaERUiWpfbY1DuPuk5Qe2jT4opgZNUck0qcf6fosjP/sBujvuSVoK
   vjwGfwrCDVCFz7tP6/ZNIJVCrlqUrh+9XvYfCnYwagHwuVsJPWYIf6O2F
   DKiybYyKYTEf72PgJZHJ9YlGDIId3008eQBWq0Y6TbMntdmDoFs/O67PL
   9NpR4npVSreYvrLUzWNyDh77MDzPh9LEJcopgRngH5xMHtqxI+o53nN9C
   VLQ96en/sem0a+Pm0Yjqa5vmwP/5dnTGjZkLCcGffnG477I5xa7KXejWl
   A==;
X-CSE-ConnectionGUID: zCwOJ5WNS5e0C6Q+Pd10Dg==
X-CSE-MsgGUID: 2ck3busxS+Kc15Lc4yg9mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54475871"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="54475871"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 23:35:24 -0700
X-CSE-ConnectionGUID: jh2VS5SkTTWoxXa0Qcw0HQ==
X-CSE-MsgGUID: 7PlRriFnTAiAuks5lUY/3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="157854276"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 14 Jul 2025 23:35:22 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ubZG4-0009k7-2R;
	Tue, 15 Jul 2025 06:35:20 +0000
Date: Tue, 15 Jul 2025 14:35:17 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/kconfig] BUILD SUCCESS
 9df5e79bf1a30b94dc068ab2ed2279e40f430b88
Message-ID: <202507151405.zCzwnjiX-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/kconfig
branch HEAD: 9df5e79bf1a30b94dc068ab2ed2279e40f430b88  x86/tools: insn_sanity.c: Emit standard build success messages

elapsed time: 907m

configs tested: 118
configs skipped: 120

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-21
arc                               allnoconfig    clang-21
arc                   randconfig-001-20250715    clang-21
arc                   randconfig-002-20250715    clang-21
arm                               allnoconfig    clang-21
arm                            mps2_defconfig    clang-21
arm                   randconfig-001-20250715    clang-21
arm                   randconfig-002-20250715    clang-21
arm                   randconfig-003-20250715    clang-21
arm                   randconfig-004-20250715    clang-21
arm                        shmobile_defconfig    clang-21
arm                          sp7021_defconfig    clang-21
arm64                             allnoconfig    clang-21
arm64                 randconfig-001-20250715    clang-21
arm64                 randconfig-002-20250715    clang-21
arm64                 randconfig-003-20250715    clang-21
arm64                 randconfig-004-20250715    clang-21
csky                              allnoconfig    clang-21
csky                  randconfig-001-20250715    gcc-12.4.0
csky                  randconfig-002-20250715    gcc-12.4.0
hexagon                           allnoconfig    clang-21
hexagon               randconfig-001-20250715    gcc-12.4.0
hexagon               randconfig-002-20250715    gcc-12.4.0
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250715    clang-20
i386        buildonly-randconfig-001-20250715    gcc-12
i386        buildonly-randconfig-002-20250715    clang-20
i386        buildonly-randconfig-002-20250715    gcc-12
i386        buildonly-randconfig-003-20250715    clang-20
i386        buildonly-randconfig-003-20250715    gcc-12
i386        buildonly-randconfig-004-20250715    clang-20
i386        buildonly-randconfig-005-20250715    clang-20
i386        buildonly-randconfig-006-20250715    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250715    clang-20
i386                  randconfig-002-20250715    clang-20
i386                  randconfig-003-20250715    clang-20
i386                  randconfig-004-20250715    clang-20
i386                  randconfig-005-20250715    clang-20
i386                  randconfig-006-20250715    clang-20
i386                  randconfig-007-20250715    clang-20
i386                  randconfig-011-20250715    gcc-12
i386                  randconfig-012-20250715    gcc-12
i386                  randconfig-013-20250715    gcc-12
i386                  randconfig-014-20250715    gcc-12
i386                  randconfig-015-20250715    gcc-12
i386                  randconfig-016-20250715    gcc-12
i386                  randconfig-017-20250715    gcc-12
loongarch                         allnoconfig    clang-21
loongarch             randconfig-001-20250715    gcc-12.4.0
loongarch             randconfig-002-20250715    gcc-12.4.0
m68k                              allnoconfig    gcc-15.1.0
m68k                        mvme16x_defconfig    clang-21
microblaze                        allnoconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        omega2p_defconfig    clang-21
nios2                             allnoconfig    gcc-15.1.0
nios2                 randconfig-001-20250715    gcc-12.4.0
nios2                 randconfig-002-20250715    gcc-12.4.0
openrisc                          allnoconfig    clang-21
openrisc                            defconfig    gcc-12
parisc                            allnoconfig    clang-21
parisc                randconfig-001-20250715    gcc-12.4.0
parisc                randconfig-002-20250715    gcc-12.4.0
powerpc                           allnoconfig    clang-21
powerpc                        icon_defconfig    clang-21
powerpc                   motionpro_defconfig    clang-21
powerpc               randconfig-001-20250715    gcc-12.4.0
powerpc               randconfig-002-20250715    gcc-12.4.0
powerpc               randconfig-003-20250715    gcc-12.4.0
powerpc                     tqm8540_defconfig    clang-21
powerpc64             randconfig-001-20250715    gcc-12.4.0
powerpc64             randconfig-003-20250715    gcc-12.4.0
riscv                             allnoconfig    clang-21
riscv                               defconfig    gcc-12
s390                              allnoconfig    clang-21
s390                                defconfig    gcc-12
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sparc                             allnoconfig    gcc-15.1.0
sparc64                             defconfig    gcc-12
um                                allnoconfig    clang-21
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250715    clang-20
x86_64      buildonly-randconfig-001-20250715    gcc-12
x86_64      buildonly-randconfig-002-20250715    gcc-12
x86_64      buildonly-randconfig-003-20250715    gcc-12
x86_64      buildonly-randconfig-004-20250715    gcc-11
x86_64      buildonly-randconfig-004-20250715    gcc-12
x86_64      buildonly-randconfig-005-20250715    gcc-12
x86_64      buildonly-randconfig-006-20250715    gcc-12
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250715    gcc-12
x86_64                randconfig-002-20250715    gcc-12
x86_64                randconfig-003-20250715    gcc-12
x86_64                randconfig-004-20250715    gcc-12
x86_64                randconfig-005-20250715    gcc-12
x86_64                randconfig-006-20250715    gcc-12
x86_64                randconfig-007-20250715    gcc-12
x86_64                randconfig-008-20250715    gcc-12
x86_64                randconfig-071-20250715    gcc-12
x86_64                randconfig-072-20250715    gcc-12
x86_64                randconfig-073-20250715    gcc-12
x86_64                randconfig-074-20250715    gcc-12
x86_64                randconfig-075-20250715    gcc-12
x86_64                randconfig-076-20250715    gcc-12
x86_64                randconfig-077-20250715    gcc-12
x86_64                randconfig-078-20250715    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


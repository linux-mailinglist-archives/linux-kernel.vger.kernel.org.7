Return-Path: <linux-kernel+bounces-732858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D73AFB06CEA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 07:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E43503A3DD0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 05:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7221DB95E;
	Wed, 16 Jul 2025 05:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="brJ0wxRZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC19411CA9
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 05:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752642326; cv=none; b=p2vq0n4O0YYLBRFnV/q2Cg0ff+TBetWXg3qIczYWM4aZ4MWS3CYNMIaRCUKm1N/LiGlo61zGG2OK0Fw9N1XT96f3MfA55onUDQtqRuP64v0aBmsTK3vb4dVRgYrV8DRolOI+SFBOerB25j2/ZtLPF17n4rark+tkoIXphwk8sPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752642326; c=relaxed/simple;
	bh=mqLLuq5/A8TnSxCS66KlbgRKGec4uN3Kso2n8RBy+t8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZVSu4z/Gmoxvj9+ITCb4lDgLVsd3QW7Y86gwWFNcWl0rHLTQDf8pBB5POD1/SjnmTlW0HAh3bby8RuhDkEdOFfbYU/IeH1hd52POwvsDDbJNYAOe94oP/w9dequkHsr45eGtxDyU+d+6iwory/jV7CvolqQ70m7RFbNebPyVFys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=brJ0wxRZ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752642325; x=1784178325;
  h=date:from:to:cc:subject:message-id;
  bh=mqLLuq5/A8TnSxCS66KlbgRKGec4uN3Kso2n8RBy+t8=;
  b=brJ0wxRZNSSPe9qPi6bPaS+QslrlvI7ai8Zap12uPaqNtQnv2ky6a3nj
   vhfXJpddTnAROIKgrgCi0wj81/qso6geCVyOS1Vuq4zIjhY9O5cL2/BLy
   rlVAiRE9bSjAygZuOJHCF7Vlr58JOW+7+r5IW5Tgt/YaGpXkwtgBvDLXd
   DCL4GcRKyKyPupsUfhu2ixHJDkMegnd/l/XVgavRdNR9ashTLndAgwMAL
   UxfKVaWaMQjnnehVrxsQ4DCNTYNK8xDTNzyi8gtsxkX7oA9+JFl5xNIBZ
   YBA8ukMIolRxS3rsg3jzQwPvArfo74oJXqmY+OvfbYUNt6nyEjZfLX8gi
   w==;
X-CSE-ConnectionGUID: Tw4Klxs/ToejSUjLosmLOg==
X-CSE-MsgGUID: V7EnEkbATNyJKEiLCQjM5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="58644238"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="58644238"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 22:05:24 -0700
X-CSE-ConnectionGUID: SAwfb0GbSHqwOkrfJYlL+A==
X-CSE-MsgGUID: SYySutI3TESl1jl4R7JVxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="161721218"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 15 Jul 2025 22:05:23 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ubuKW-000BuZ-1W;
	Wed, 16 Jul 2025 05:05:20 +0000
Date: Wed, 16 Jul 2025 13:04:42 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:tip/urgent] BUILD SUCCESS
 ffd9dbccbd55dfbe2d6a0a5328475c40aa74144f
Message-ID: <202507161329.pDrqafvt-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tip/urgent
branch HEAD: ffd9dbccbd55dfbe2d6a0a5328475c40aa74144f  Merge branch into tip/master: 'sched/urgent'

elapsed time: 1307m

configs tested: 125
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                          axs103_defconfig    gcc-15.1.0
arc                      axs103_smp_defconfig    gcc-15.1.0
arc                   randconfig-001-20250715    gcc-8.5.0
arc                   randconfig-002-20250715    gcc-11.5.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250715    clang-21
arm                   randconfig-002-20250715    gcc-10.5.0
arm                   randconfig-003-20250715    clang-21
arm                   randconfig-004-20250715    gcc-12.4.0
arm                         s3c6400_defconfig    gcc-15.1.0
arm64                            alldefconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250715    clang-16
arm64                 randconfig-002-20250715    gcc-12.3.0
arm64                 randconfig-003-20250715    gcc-8.5.0
arm64                 randconfig-004-20250715    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250715    gcc-9.3.0
csky                  randconfig-002-20250715    gcc-12.4.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250715    clang-18
hexagon               randconfig-002-20250715    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250715    gcc-12
i386        buildonly-randconfig-002-20250715    gcc-12
i386        buildonly-randconfig-003-20250715    gcc-12
i386        buildonly-randconfig-004-20250715    clang-20
i386        buildonly-randconfig-005-20250715    clang-20
i386        buildonly-randconfig-006-20250715    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch             randconfig-001-20250715    clang-21
loongarch             randconfig-002-20250715    gcc-15.1.0
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
nios2                 randconfig-001-20250715    gcc-11.5.0
nios2                 randconfig-002-20250715    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250715    gcc-10.5.0
parisc                randconfig-002-20250715    gcc-9.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                      cm5200_defconfig    clang-21
powerpc               randconfig-001-20250715    clang-21
powerpc               randconfig-002-20250715    clang-21
powerpc               randconfig-003-20250715    gcc-8.5.0
powerpc64             randconfig-001-20250715    clang-21
powerpc64             randconfig-003-20250715    clang-17
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250715    clang-21
riscv                 randconfig-002-20250715    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250715    gcc-8.5.0
s390                  randconfig-002-20250715    gcc-12.4.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                          kfr2r09_defconfig    gcc-15.1.0
sh                    randconfig-001-20250715    gcc-11.5.0
sh                    randconfig-002-20250715    gcc-15.1.0
sh                  sh7785lcr_32bit_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250715    gcc-8.5.0
sparc                 randconfig-002-20250715    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250715    clang-20
sparc64               randconfig-002-20250715    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250715    gcc-12
um                    randconfig-002-20250715    gcc-12
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250715    clang-20
x86_64      buildonly-randconfig-002-20250715    gcc-12
x86_64      buildonly-randconfig-003-20250715    gcc-12
x86_64      buildonly-randconfig-004-20250715    gcc-11
x86_64      buildonly-randconfig-005-20250715    gcc-12
x86_64      buildonly-randconfig-006-20250715    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250715    gcc-8.5.0
xtensa                randconfig-002-20250715    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


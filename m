Return-Path: <linux-kernel+bounces-743761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E65CB102F4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 260A8AC65A2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC19B2741B5;
	Thu, 24 Jul 2025 08:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SEs/gxe4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1EA2741B0
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753344540; cv=none; b=OyI5RLk67UqzJBNSHHRvbJifPuMRZRi0kcgH4OIiL0ty5y0mZJu0wYf6tN9oQtuGxbQxnw0+uH++3UHke4DLv4H7Omb/FzUH7E3g6iDzu/k4jiPB2TZJ4AB+XzkDZiLlJHcEzOzCdwSvwDftB7A8jrXiqLQVMT5UhIw7J/hFKYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753344540; c=relaxed/simple;
	bh=gTVfQVvXl0sH5UqS6jdHWXKQoah+GBUuOTq1e9ktcvQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LPRRN5kdiUwYSvTj0nDrpVNG9rNUF9YJj//uA+g8AEsTy/yhcQZI6b/NtIKdIlP5/InJvNh0794L/CzgXyJp/NfggahNo1hUSYcT9oxvkS0dXVyfqzBeTuRyF/9b6byRsZyeExWQicQ/eeXDDCgvhNTHcw91ChpR30/cNinM5u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SEs/gxe4; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753344539; x=1784880539;
  h=date:from:to:cc:subject:message-id;
  bh=gTVfQVvXl0sH5UqS6jdHWXKQoah+GBUuOTq1e9ktcvQ=;
  b=SEs/gxe4w0RT48oDT0mHdZ9BwDzEEUj2qAnJzwcLpZiovVtN0njA5MHr
   T1vadHQ8a4+SFpjtOdH7riyLGaCpjZAiygAbEf6vz4RzGmg/mpGyIFRpT
   MxlRzIyzQsREdz6ZP2/pio7CHRhg232cfsy7RK3FbVwkEoTthf2xXCngU
   y9THu1bDWlvrtc5nbNFmCFgPGh3nhq6v+k6VEyi5cBoURjFyoEYRGzE9q
   eipXxKu8hkgkga64rCCBXcW5/ic8CE/CBxsMsa7XtNKPH2MyG7lyUpgV0
   R6L7Idif5Rm9/wRH4NIbrXBUmDatCHfMR6L32uQi3Q6bT2dLsx1L7NppU
   A==;
X-CSE-ConnectionGUID: WhK1V37XR/CqmhdL34nNKw==
X-CSE-MsgGUID: qaQmI0KMR02cKgSTmRHCbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="78184841"
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="78184841"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 01:08:58 -0700
X-CSE-ConnectionGUID: ZxvJ7hYmTny5n6OuQbN1+w==
X-CSE-MsgGUID: PbDSyOzfQ3ihb5TQDNS8hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="190989346"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 24 Jul 2025 01:08:57 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uer0Z-000KCs-0f;
	Thu, 24 Jul 2025 08:08:55 +0000
Date: Thu, 24 Jul 2025 16:08:32 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/clocksource] BUILD SUCCESS
 799387f1da4e58be5bfa16dd4b4d95244e875c7f
Message-ID: <202507241620.PyuNCyiw-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/clocksource
branch HEAD: 799387f1da4e58be5bfa16dd4b4d95244e875c7f  Merge tag 'timers-v6.17-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/daniel.lezcano/linux into timers/clocksource

elapsed time: 1454m

configs tested: 244
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20250723    gcc-8.5.0
arc                   randconfig-001-20250724    clang-22
arc                   randconfig-002-20250723    gcc-9.5.0
arc                   randconfig-002-20250724    clang-22
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                           omap1_defconfig    gcc-15.1.0
arm                   randconfig-001-20250723    gcc-13.4.0
arm                   randconfig-001-20250724    clang-22
arm                   randconfig-002-20250723    gcc-13.4.0
arm                   randconfig-002-20250724    clang-22
arm                   randconfig-003-20250723    clang-16
arm                   randconfig-003-20250724    clang-22
arm                   randconfig-004-20250723    clang-22
arm                   randconfig-004-20250724    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250723    clang-22
arm64                 randconfig-001-20250724    clang-22
arm64                 randconfig-002-20250723    clang-16
arm64                 randconfig-002-20250724    clang-22
arm64                 randconfig-003-20250723    clang-16
arm64                 randconfig-003-20250724    clang-22
arm64                 randconfig-004-20250723    clang-22
arm64                 randconfig-004-20250724    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250723    gcc-12.5.0
csky                  randconfig-001-20250724    gcc-14.3.0
csky                  randconfig-002-20250723    gcc-14.3.0
csky                  randconfig-002-20250724    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250723    clang-22
hexagon               randconfig-001-20250724    gcc-14.3.0
hexagon               randconfig-002-20250723    clang-22
hexagon               randconfig-002-20250724    gcc-14.3.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250723    clang-20
i386        buildonly-randconfig-001-20250724    gcc-12
i386        buildonly-randconfig-002-20250723    clang-20
i386        buildonly-randconfig-002-20250724    gcc-12
i386        buildonly-randconfig-003-20250723    clang-20
i386        buildonly-randconfig-003-20250724    gcc-12
i386        buildonly-randconfig-004-20250723    clang-20
i386        buildonly-randconfig-004-20250724    gcc-12
i386        buildonly-randconfig-005-20250723    gcc-11
i386        buildonly-randconfig-005-20250724    gcc-12
i386        buildonly-randconfig-006-20250723    clang-20
i386        buildonly-randconfig-006-20250724    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250724    clang-20
i386                  randconfig-002-20250724    clang-20
i386                  randconfig-003-20250724    clang-20
i386                  randconfig-004-20250724    clang-20
i386                  randconfig-005-20250724    clang-20
i386                  randconfig-006-20250724    clang-20
i386                  randconfig-007-20250724    clang-20
i386                  randconfig-011-20250724    gcc-12
i386                  randconfig-012-20250724    gcc-12
i386                  randconfig-013-20250724    gcc-12
i386                  randconfig-014-20250724    gcc-12
i386                  randconfig-015-20250724    gcc-12
i386                  randconfig-016-20250724    gcc-12
i386                  randconfig-017-20250724    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250723    gcc-15.1.0
loongarch             randconfig-001-20250724    gcc-14.3.0
loongarch             randconfig-002-20250723    clang-22
loongarch             randconfig-002-20250724    gcc-14.3.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                        stmark2_defconfig    gcc-15.1.0
m68k                          sun3x_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                         3c120_defconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250723    gcc-8.5.0
nios2                 randconfig-001-20250724    gcc-14.3.0
nios2                 randconfig-002-20250723    gcc-11.5.0
nios2                 randconfig-002-20250724    gcc-14.3.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
openrisc                 simple_smp_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250723    gcc-8.5.0
parisc                randconfig-001-20250724    gcc-14.3.0
parisc                randconfig-002-20250723    gcc-15.1.0
parisc                randconfig-002-20250724    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc               randconfig-001-20250723    gcc-10.5.0
powerpc               randconfig-001-20250724    gcc-14.3.0
powerpc               randconfig-002-20250723    gcc-8.5.0
powerpc               randconfig-002-20250724    gcc-14.3.0
powerpc               randconfig-003-20250723    gcc-12.5.0
powerpc               randconfig-003-20250724    gcc-14.3.0
powerpc                     tqm8541_defconfig    clang-22
powerpc64             randconfig-001-20250723    clang-22
powerpc64             randconfig-001-20250724    gcc-14.3.0
powerpc64             randconfig-002-20250723    clang-22
powerpc64             randconfig-002-20250724    gcc-14.3.0
powerpc64             randconfig-003-20250723    clang-22
powerpc64             randconfig-003-20250724    gcc-14.3.0
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250723    gcc-9.5.0
riscv                 randconfig-001-20250724    gcc-13.4.0
riscv                 randconfig-002-20250723    clang-22
riscv                 randconfig-002-20250724    gcc-13.4.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250723    clang-22
s390                  randconfig-001-20250724    gcc-13.4.0
s390                  randconfig-002-20250723    clang-20
s390                  randconfig-002-20250724    gcc-13.4.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250723    gcc-12.5.0
sh                    randconfig-001-20250724    gcc-13.4.0
sh                    randconfig-002-20250723    gcc-9.5.0
sh                    randconfig-002-20250724    gcc-13.4.0
sh                           se7722_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250723    gcc-8.5.0
sparc                 randconfig-001-20250724    gcc-13.4.0
sparc                 randconfig-002-20250723    gcc-8.5.0
sparc                 randconfig-002-20250724    gcc-13.4.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250723    gcc-12.5.0
sparc64               randconfig-001-20250724    gcc-13.4.0
sparc64               randconfig-002-20250723    gcc-14.3.0
sparc64               randconfig-002-20250724    gcc-13.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250723    gcc-12
um                    randconfig-001-20250724    gcc-13.4.0
um                    randconfig-002-20250723    clang-22
um                    randconfig-002-20250724    gcc-13.4.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250723    gcc-12
x86_64      buildonly-randconfig-001-20250724    gcc-12
x86_64      buildonly-randconfig-002-20250723    gcc-11
x86_64      buildonly-randconfig-002-20250724    gcc-12
x86_64      buildonly-randconfig-003-20250723    gcc-11
x86_64      buildonly-randconfig-003-20250724    gcc-12
x86_64      buildonly-randconfig-004-20250723    clang-20
x86_64      buildonly-randconfig-004-20250724    gcc-12
x86_64      buildonly-randconfig-005-20250723    gcc-12
x86_64      buildonly-randconfig-005-20250724    gcc-12
x86_64      buildonly-randconfig-006-20250723    gcc-12
x86_64      buildonly-randconfig-006-20250724    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250724    gcc-12
x86_64                randconfig-002-20250724    gcc-12
x86_64                randconfig-003-20250724    gcc-12
x86_64                randconfig-004-20250724    gcc-12
x86_64                randconfig-005-20250724    gcc-12
x86_64                randconfig-006-20250724    gcc-12
x86_64                randconfig-007-20250724    gcc-12
x86_64                randconfig-008-20250724    gcc-12
x86_64                randconfig-071-20250724    clang-20
x86_64                randconfig-072-20250724    clang-20
x86_64                randconfig-073-20250724    clang-20
x86_64                randconfig-074-20250724    clang-20
x86_64                randconfig-075-20250724    clang-20
x86_64                randconfig-076-20250724    clang-20
x86_64                randconfig-077-20250724    clang-20
x86_64                randconfig-078-20250724    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250723    gcc-13.4.0
xtensa                randconfig-001-20250724    gcc-13.4.0
xtensa                randconfig-002-20250723    gcc-10.5.0
xtensa                randconfig-002-20250724    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


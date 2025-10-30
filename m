Return-Path: <linux-kernel+bounces-878259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE327C20209
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ABAF46223C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6224934028F;
	Thu, 30 Oct 2025 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eVpu6FdO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C322F6169
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761828966; cv=none; b=dTczFLs1Zi/ex+e/z/IsIrAzkQ/aMYMX/+L/M+IcGudHnVSFAxcAx1VdojOe1J0yR3MMGVAW27PxGd57OIihb3KB0fLMWMbP2+hszCgjWEquenzyhkiVc0KgkwB/NhRhlzDvwAW9hqs5pBTnEsDfHL1oTBL5JRh7nig/w2VPgQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761828966; c=relaxed/simple;
	bh=gVRTX4nTXTei8GPFlbiqtlpEv1NHhl/f0i3/yF0DOeI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=IKSEm4vTzJHHZfLu2Vl5BFZCGPB6e4vfChp/+MWAGqbkv3SKzSoUzEME/FQd/mKuQhRSty3yvOLDSJH2hp1eV9oRTP4ifwi9fE7ek7zvqi5hVozt/TCAoOgl7zVLzor9eh8tsiztmqSd+uFNv3SzuC546BPXCoomeV3QSq6uYqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eVpu6FdO; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761828965; x=1793364965;
  h=date:from:to:cc:subject:message-id;
  bh=gVRTX4nTXTei8GPFlbiqtlpEv1NHhl/f0i3/yF0DOeI=;
  b=eVpu6FdO/xSyUIuhIPIWxmNLcphOJOqsni6ew4ZMzOxLjQSZbqNGEY3c
   QTpjJsiGllXrie6cQnY1elpT8xZn/h4ZdWaqt6YoTV+6t8HCtKYLa/HV0
   +PUfW3fYJf1p0v+7+hYGHXh7hjeQvSWROX8YZBwOpfk1RoX7IizOqbMbT
   TSROGvgo4jGRU/hUW/Ykon01JSeYmyHg6DDAJItWsXK0YI+0FXyQ0JoK/
   DmEyH1dYevI3jUbaES6+7r3FisOVfCFIu6qcUndxvXodUjh3/ip8D3aGW
   8ZxUZXLscmXeQSu5ztNZnxQz3kKr7NnPD/3ZXdz/4DmYIOnU3H3dkq8sy
   Q==;
X-CSE-ConnectionGUID: DtVqz/Z6RKaQ2PkIczqjaA==
X-CSE-MsgGUID: U0AWHZYxT8SB49xq79M5yA==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="64064847"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="64064847"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 05:56:04 -0700
X-CSE-ConnectionGUID: SMUTD3KVQpu6q1SC70nTbA==
X-CSE-MsgGUID: gnYbcEOvQni6+3fgXt7vHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="223168696"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 30 Oct 2025 05:56:03 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vESC6-000Lzg-0W;
	Thu, 30 Oct 2025 12:55:58 +0000
Date: Thu, 30 Oct 2025 20:54:27 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/core] BUILD SUCCESS
 ced37e9ceae50e4cb6cd058963bd315ec9afa651
Message-ID: <202510302021.q9cDnQig-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
branch HEAD: ced37e9ceae50e4cb6cd058963bd315ec9afa651  x86/dumpstack: Prevent KASAN false positive warnings in __show_regs()

elapsed time: 1459m

configs tested: 167
configs skipped: 121

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig    clang-19
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                              allyesconfig    clang-19
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251030    gcc-11.5.0
arc                   randconfig-002-20251030    gcc-11.5.0
arm                              allmodconfig    clang-19
arm                              allyesconfig    clang-19
arm                                 defconfig    gcc-15.1.0
arm                   randconfig-001-20251030    gcc-11.5.0
arm                   randconfig-002-20251030    gcc-11.5.0
arm                   randconfig-003-20251030    gcc-11.5.0
arm                   randconfig-004-20251030    gcc-11.5.0
arm                           sama5_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                            allyesconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251030    clang-17
arm64                 randconfig-002-20251030    clang-17
arm64                 randconfig-003-20251030    clang-17
arm64                 randconfig-004-20251030    clang-17
csky                             allmodconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251030    clang-17
csky                  randconfig-002-20251030    clang-17
hexagon                          allmodconfig    clang-19
hexagon                          allyesconfig    clang-19
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20251030    clang-22
hexagon               randconfig-002-20251030    clang-22
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251030    gcc-14
i386        buildonly-randconfig-002-20251030    gcc-14
i386        buildonly-randconfig-003-20251030    gcc-14
i386        buildonly-randconfig-004-20251030    gcc-14
i386        buildonly-randconfig-005-20251030    gcc-14
i386        buildonly-randconfig-006-20251030    gcc-14
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20251030    clang-20
i386                  randconfig-002-20251030    clang-20
i386                  randconfig-003-20251030    clang-20
i386                  randconfig-004-20251030    clang-20
i386                  randconfig-005-20251030    clang-20
i386                  randconfig-006-20251030    clang-20
i386                  randconfig-007-20251030    clang-20
i386                  randconfig-011-20251030    gcc-14
i386                  randconfig-012-20251030    gcc-14
i386                  randconfig-013-20251030    gcc-14
i386                  randconfig-014-20251030    gcc-14
i386                  randconfig-015-20251030    gcc-14
i386                  randconfig-016-20251030    gcc-14
i386                  randconfig-017-20251030    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allyesconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251030    clang-22
loongarch             randconfig-002-20251030    clang-22
m68k                             allmodconfig    clang-19
m68k                             allyesconfig    clang-19
m68k                                defconfig    clang-19
m68k                            mac_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allyesconfig    clang-19
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                            allmodconfig    clang-22
nios2                            allyesconfig    clang-22
nios2                               defconfig    clang-19
nios2                 randconfig-001-20251030    clang-22
nios2                 randconfig-002-20251030    clang-22
openrisc                         allmodconfig    clang-22
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251030    clang-22
parisc                randconfig-002-20251030    clang-22
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                    gamecube_defconfig    gcc-15.1.0
powerpc                        icon_defconfig    gcc-15.1.0
powerpc                     ksi8560_defconfig    gcc-15.1.0
powerpc                      mgcoge_defconfig    gcc-15.1.0
powerpc                      ppc44x_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251030    clang-22
powerpc               randconfig-002-20251030    clang-22
powerpc                     redwood_defconfig    gcc-15.1.0
powerpc                  storcenter_defconfig    gcc-15.1.0
powerpc                      tqm8xx_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251030    clang-22
powerpc64             randconfig-002-20251030    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-15.1.0
riscv                 randconfig-001-20251030    gcc-15.1.0
riscv                 randconfig-002-20251030    gcc-15.1.0
s390                             allmodconfig    gcc-15.1.0
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20251030    gcc-15.1.0
s390                  randconfig-002-20251030    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                          lboxre2_defconfig    gcc-15.1.0
sh                            migor_defconfig    gcc-15.1.0
sh                    randconfig-001-20251030    gcc-15.1.0
sh                    randconfig-002-20251030    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                            allyesconfig    clang-22
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251030    gcc-11.5.0
sparc                 randconfig-002-20251030    gcc-11.5.0
sparc64                          allmodconfig    clang-22
sparc64                          allyesconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251030    gcc-11.5.0
sparc64               randconfig-002-20251030    gcc-11.5.0
um                               allmodconfig    clang-19
um                               allyesconfig    clang-19
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251030    gcc-11.5.0
um                    randconfig-002-20251030    gcc-11.5.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251030    clang-20
x86_64      buildonly-randconfig-002-20251030    clang-20
x86_64      buildonly-randconfig-003-20251030    clang-20
x86_64      buildonly-randconfig-004-20251030    clang-20
x86_64      buildonly-randconfig-005-20251030    clang-20
x86_64      buildonly-randconfig-006-20251030    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251030    clang-20
x86_64                randconfig-002-20251030    clang-20
x86_64                randconfig-003-20251030    clang-20
x86_64                randconfig-004-20251030    clang-20
x86_64                randconfig-005-20251030    clang-20
x86_64                randconfig-006-20251030    clang-20
x86_64                randconfig-011-20251030    clang-20
x86_64                randconfig-012-20251030    clang-20
x86_64                randconfig-013-20251030    clang-20
x86_64                randconfig-014-20251030    clang-20
x86_64                randconfig-015-20251030    clang-20
x86_64                randconfig-016-20251030    clang-20
x86_64                randconfig-071-20251030    gcc-14
x86_64                randconfig-072-20251030    gcc-14
x86_64                randconfig-073-20251030    gcc-14
x86_64                randconfig-074-20251030    gcc-14
x86_64                randconfig-075-20251030    gcc-14
x86_64                randconfig-076-20251030    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
xtensa                           allyesconfig    clang-22
xtensa                          iss_defconfig    gcc-15.1.0
xtensa                randconfig-001-20251030    gcc-11.5.0
xtensa                randconfig-002-20251030    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


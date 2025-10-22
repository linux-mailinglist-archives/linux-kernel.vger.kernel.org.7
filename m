Return-Path: <linux-kernel+bounces-864860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4CABFBB7C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F43A5088C8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09161340A74;
	Wed, 22 Oct 2025 11:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cks4iEEl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3AE340A62
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761133496; cv=none; b=lKu4N5QfhV+i5eGc3sp9LBfLgQu6UjqAm4WDJlUlBe5lu70Ojv/wxfhQ3hFfvyYZ/aLkALLK2cdDBhy4Aw+Rt+EuNY9hRRWLrg03TH8ItwuYGCrIZ29IDMf/OnC/c66TfewGuRtc2HaQOmoRdH7lDgzi8mqHamTvrZD0D4uesrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761133496; c=relaxed/simple;
	bh=87cV3ULwieUcGTFzggF8zhVkxVEWQuaHeWLlJu/9CV4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=dLI+xjBg/i9GLhJFU0JZVGKFTmtX5UhQIjbNZz6OKzPEOZkNb8xLhzF42qYP+5jGxtWlbXT4UmRaKMCJKnfm+ojPYeTW9/uUUvHzUKv8uQ5SlyS32zfXwljA2iPJVB/LOV7TLoeoAZ5D5g8AZ8DcNYTUigfYDRh7LQ4meWksmOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cks4iEEl; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761133495; x=1792669495;
  h=date:from:to:cc:subject:message-id;
  bh=87cV3ULwieUcGTFzggF8zhVkxVEWQuaHeWLlJu/9CV4=;
  b=Cks4iEElTgoBC0T5fJ5JvkHJgnP0g3Fu6uNNNfzXOnUFe2PNoSjLHec2
   iXM6tlqpGOTpMmM6Micjjy6eIrnD/vkA/40wRGWX/jb+TdMCwa9lyDotV
   GV3wtBCEV75vf55osX1A287j1+BTARiRIIRILOBVJ9j9gKdl4bHbUwPp5
   sIHuv7A1XHgpvim3uLyIb8N+f6VSLY1TtxM99lawJQSv1GtLkfWezO8I9
   YhLFniPq8+nPb0KNQ0pmFsd3cQlhqrc0jJFcrusDHOlL5e2QgZP0OmTT+
   4rD+cCDMofq+/M8sWPPfR7lFOq4vXGF17k/sBRVLtsD22gYpfC/WRBGiw
   g==;
X-CSE-ConnectionGUID: MAZMH6e4THGPCDdue7DUOQ==
X-CSE-MsgGUID: 0QTXKIYtSia9sh5keOuZdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63199434"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63199434"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 04:44:53 -0700
X-CSE-ConnectionGUID: uIt90nf3QuKcU5zyKugVTA==
X-CSE-MsgGUID: +VAK70qUQTi0tCyyXL+gvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="183063012"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 22 Oct 2025 04:44:52 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vBXGr-000CJ7-20;
	Wed, 22 Oct 2025 11:44:49 +0000
Date: Wed, 22 Oct 2025 19:44:06 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 204ced4108f5d38f6804968fd9543cc69c3f8da6
Message-ID: <202510221900.G0LcgxX1-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 204ced4108f5d38f6804968fd9543cc69c3f8da6  x86/bugs: Qualify RETBLEED_INTEL_MSG

elapsed time: 1449m

configs tested: 261
configs skipped: 4

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
arc                   randconfig-001-20251021    gcc-8.5.0
arc                   randconfig-001-20251022    clang-22
arc                   randconfig-002-20251021    gcc-9.5.0
arc                   randconfig-002-20251022    clang-22
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                   randconfig-001-20251021    clang-22
arm                   randconfig-001-20251022    clang-22
arm                   randconfig-002-20251021    clang-22
arm                   randconfig-002-20251022    clang-22
arm                   randconfig-003-20251021    clang-22
arm                   randconfig-003-20251022    clang-22
arm                   randconfig-004-20251021    clang-22
arm                   randconfig-004-20251022    clang-22
arm                        spear6xx_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20251021    gcc-15.1.0
arm64                 randconfig-001-20251022    clang-22
arm64                 randconfig-002-20251021    clang-22
arm64                 randconfig-002-20251022    clang-22
arm64                 randconfig-003-20251021    gcc-12.5.0
arm64                 randconfig-003-20251022    clang-22
arm64                 randconfig-004-20251021    clang-18
arm64                 randconfig-004-20251022    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20251021    gcc-15.1.0
csky                  randconfig-001-20251022    clang-22
csky                  randconfig-002-20251021    gcc-11.5.0
csky                  randconfig-002-20251022    clang-22
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20251021    clang-22
hexagon               randconfig-001-20251022    clang-22
hexagon               randconfig-002-20251021    clang-17
hexagon               randconfig-002-20251022    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251021    clang-20
i386        buildonly-randconfig-001-20251022    gcc-14
i386        buildonly-randconfig-002-20251021    clang-20
i386        buildonly-randconfig-002-20251022    gcc-14
i386        buildonly-randconfig-003-20251021    clang-20
i386        buildonly-randconfig-003-20251022    gcc-14
i386        buildonly-randconfig-004-20251021    gcc-14
i386        buildonly-randconfig-004-20251022    gcc-14
i386        buildonly-randconfig-005-20251021    gcc-14
i386        buildonly-randconfig-005-20251022    gcc-14
i386        buildonly-randconfig-006-20251021    clang-20
i386        buildonly-randconfig-006-20251022    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251022    gcc-14
i386                  randconfig-002-20251022    gcc-14
i386                  randconfig-003-20251022    gcc-14
i386                  randconfig-004-20251022    gcc-14
i386                  randconfig-005-20251022    gcc-14
i386                  randconfig-006-20251022    gcc-14
i386                  randconfig-007-20251022    gcc-14
i386                  randconfig-011-20251022    gcc-13
i386                  randconfig-012-20251022    gcc-13
i386                  randconfig-013-20251022    gcc-13
i386                  randconfig-014-20251022    gcc-13
i386                  randconfig-015-20251022    gcc-13
i386                  randconfig-016-20251022    gcc-13
i386                  randconfig-017-20251022    gcc-13
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch                 loongson3_defconfig    clang-22
loongarch             randconfig-001-20251021    clang-22
loongarch             randconfig-001-20251022    clang-22
loongarch             randconfig-002-20251021    clang-22
loongarch             randconfig-002-20251022    clang-22
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                          amiga_defconfig    gcc-15.1.0
m68k                          atari_defconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                           sun3_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        bcm47xx_defconfig    gcc-15.1.0
mips                       bmips_be_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20251021    gcc-10.5.0
nios2                 randconfig-001-20251022    clang-22
nios2                 randconfig-002-20251021    gcc-8.5.0
nios2                 randconfig-002-20251022    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251021    gcc-8.5.0
parisc                randconfig-001-20251022    clang-22
parisc                randconfig-002-20251021    gcc-15.1.0
parisc                randconfig-002-20251022    clang-22
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                        fsp2_defconfig    gcc-15.1.0
powerpc                 mpc836x_rdk_defconfig    clang-22
powerpc               randconfig-001-20251021    clang-22
powerpc               randconfig-001-20251022    clang-22
powerpc               randconfig-002-20251021    clang-19
powerpc               randconfig-002-20251022    clang-22
powerpc               randconfig-003-20251021    clang-22
powerpc               randconfig-003-20251022    clang-22
powerpc                     redwood_defconfig    clang-22
powerpc64             randconfig-001-20251021    clang-22
powerpc64             randconfig-001-20251022    clang-22
powerpc64             randconfig-002-20251021    gcc-12.5.0
powerpc64             randconfig-002-20251022    clang-22
powerpc64             randconfig-003-20251021    gcc-8.5.0
powerpc64             randconfig-003-20251022    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20251021    gcc-8.5.0
riscv                 randconfig-001-20251022    gcc-14.3.0
riscv                 randconfig-002-20251021    clang-22
riscv                 randconfig-002-20251022    gcc-14.3.0
s390                             alldefconfig    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                                defconfig    gcc-14
s390                  randconfig-001-20251021    clang-22
s390                  randconfig-001-20251022    gcc-14.3.0
s390                  randconfig-002-20251021    gcc-11.5.0
s390                  randconfig-002-20251022    gcc-14.3.0
s390                       zfcpdump_defconfig    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.1.0
sh                            hp6xx_defconfig    gcc-15.1.0
sh                          lboxre2_defconfig    gcc-15.1.0
sh                    randconfig-001-20251021    gcc-9.5.0
sh                    randconfig-001-20251022    gcc-14.3.0
sh                    randconfig-002-20251021    gcc-10.5.0
sh                    randconfig-002-20251022    gcc-14.3.0
sh                      rts7751r2d1_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251021    gcc-8.5.0
sparc                 randconfig-001-20251022    gcc-14.3.0
sparc                 randconfig-002-20251021    gcc-14.3.0
sparc                 randconfig-002-20251022    gcc-14.3.0
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251021    gcc-8.5.0
sparc64               randconfig-001-20251022    gcc-14.3.0
sparc64               randconfig-002-20251021    gcc-10.5.0
sparc64               randconfig-002-20251022    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251021    gcc-14
um                    randconfig-001-20251022    gcc-14.3.0
um                    randconfig-002-20251021    gcc-14
um                    randconfig-002-20251022    gcc-14.3.0
um                           x86_64_defconfig    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251021    gcc-13
x86_64      buildonly-randconfig-001-20251022    clang-20
x86_64      buildonly-randconfig-002-20251021    clang-20
x86_64      buildonly-randconfig-002-20251022    clang-20
x86_64      buildonly-randconfig-003-20251021    clang-20
x86_64      buildonly-randconfig-003-20251022    clang-20
x86_64      buildonly-randconfig-004-20251021    clang-20
x86_64      buildonly-randconfig-004-20251022    clang-20
x86_64      buildonly-randconfig-005-20251021    gcc-14
x86_64      buildonly-randconfig-005-20251022    clang-20
x86_64      buildonly-randconfig-006-20251021    clang-20
x86_64      buildonly-randconfig-006-20251022    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251022    clang-20
x86_64                randconfig-002-20251022    clang-20
x86_64                randconfig-003-20251022    clang-20
x86_64                randconfig-004-20251022    clang-20
x86_64                randconfig-005-20251022    clang-20
x86_64                randconfig-006-20251022    clang-20
x86_64                randconfig-007-20251022    clang-20
x86_64                randconfig-008-20251022    clang-20
x86_64                randconfig-071-20251022    clang-20
x86_64                randconfig-072-20251022    clang-20
x86_64                randconfig-073-20251022    clang-20
x86_64                randconfig-074-20251022    clang-20
x86_64                randconfig-075-20251022    clang-20
x86_64                randconfig-076-20251022    clang-20
x86_64                randconfig-077-20251022    clang-20
x86_64                randconfig-078-20251022    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251021    gcc-8.5.0
xtensa                randconfig-001-20251022    gcc-14.3.0
xtensa                randconfig-002-20251021    gcc-13.4.0
xtensa                randconfig-002-20251022    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


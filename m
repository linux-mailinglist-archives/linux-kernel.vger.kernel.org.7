Return-Path: <linux-kernel+bounces-818216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C3BB58E4E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28431322834
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 06:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2F62DF6E6;
	Tue, 16 Sep 2025 06:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lfy1ZCwq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B266322D4D3
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 06:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758003361; cv=none; b=nnhJcAnwH0xYNaL5U1t9nA1iCEOJUjvfaC5mACx/qrBDQR5Sh1yMgMzh4L/e2PD1MNTqxZtVCqlfaPugAd+HfOmJp0JqYVcVmohxQDWsNiiRlEJF2GWctwKPXCXBLxewMZyrqaXCFVSsYjNXEyKbqkBFlcvU6A50YzES+5NKOMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758003361; c=relaxed/simple;
	bh=uq5RiGsFBei//V/wxnEbfxjegAS43tr3J+tOr0YV6SY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MaICu9HfpSonEeUWa2PLqZMfOvpdEmTK5rloSZMQv4eAB2D7W3/RKLNd+NOR9sbIKYhDKabQT9DSDkHyN0DOWkGjJioqyFbJ0dGFnuOJfeiRwE4ge/HShOgARfpXKoJsvw1cqVHd80xzkF30GXC6aXTxK11uaBq+T47dYpu2fVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lfy1ZCwq; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758003360; x=1789539360;
  h=date:from:to:cc:subject:message-id;
  bh=uq5RiGsFBei//V/wxnEbfxjegAS43tr3J+tOr0YV6SY=;
  b=Lfy1ZCwqErWGbLQaTf8PZRK3DqSdh7VHEQJKyq2e/VQGKnu9TMazVbx3
   ge8BDMjADbw5b9INCC5k6K4yrHtAS9mMPUb93EE5VdN0QBnSpeVpWMZtI
   +o+/AwH/8jBezMULvvISz18cgO0QvxVBB2J6f8yjrTzikfn4pZgcNYEew
   GtV+CXmX+peM4Q4Q+t88HSEAzKp2MWlP65dra1riXIvXtIeOu3uVCR6i2
   /zkP8r+9rzbvWtdL4gvPl4an0b08fEhcFO7VUkT/MKzY24T5OY8sDiED5
   NTgteUmLIia5DxnwHEj+yHaKy/EaOF51/Nyb1w1gz1yiZGtgUQoCqBPXx
   A==;
X-CSE-ConnectionGUID: nckL0/HeTEmV6vhWl5MWdA==
X-CSE-MsgGUID: HqBfPAPzTbOiIM+LjTWRvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60221968"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60221968"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 23:15:59 -0700
X-CSE-ConnectionGUID: vTjhkCYaQ+acC7iMq/tkTQ==
X-CSE-MsgGUID: qvpSoVpuRgOMkBma9SPRaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; 
   d="scan'208";a="174148131"
Received: from lkp-server01.sh.intel.com (HELO 5b01dd97f97c) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 15 Sep 2025 23:15:58 -0700
Received: from kbuild by 5b01dd97f97c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uyOyp-00013c-20;
	Tue, 16 Sep 2025 06:15:55 +0000
Date: Tue, 16 Sep 2025 14:15:20 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cache] BUILD SUCCESS
 d79bab8a48bfcf5495f72d10bf609478a4a3b916
Message-ID: <202509161403.YG5M1gQH-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cache
branch HEAD: d79bab8a48bfcf5495f72d10bf609478a4a3b916  MAINTAINERS: resctrl: Add myself as reviewer

elapsed time: 1089m

configs tested: 255
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20250915    gcc-9.5.0
arc                   randconfig-001-20250916    clang-22
arc                   randconfig-002-20250915    gcc-9.5.0
arc                   randconfig-002-20250916    clang-22
arc                           tb10x_defconfig    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                         bcm2835_defconfig    clang-22
arm                                 defconfig    clang-19
arm                       imx_v4_v5_defconfig    clang-22
arm                            mmp2_defconfig    gcc-15.1.0
arm                       netwinder_defconfig    gcc-15.1.0
arm                   randconfig-001-20250915    gcc-13.4.0
arm                   randconfig-001-20250916    clang-22
arm                   randconfig-002-20250915    clang-20
arm                   randconfig-002-20250916    clang-22
arm                   randconfig-003-20250915    gcc-8.5.0
arm                   randconfig-003-20250916    clang-22
arm                   randconfig-004-20250915    gcc-11.5.0
arm                   randconfig-004-20250916    clang-22
arm                           sama5_defconfig    gcc-15.1.0
arm                           sama7_defconfig    clang-22
arm                           sama7_defconfig    gcc-15.1.0
arm                        spear6xx_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250915    clang-22
arm64                 randconfig-001-20250916    clang-22
arm64                 randconfig-002-20250915    clang-22
arm64                 randconfig-002-20250916    clang-22
arm64                 randconfig-003-20250915    gcc-8.5.0
arm64                 randconfig-003-20250916    clang-22
arm64                 randconfig-004-20250915    gcc-11.5.0
arm64                 randconfig-004-20250916    clang-22
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250915    gcc-15.1.0
csky                  randconfig-001-20250916    clang-22
csky                  randconfig-002-20250915    gcc-15.1.0
csky                  randconfig-002-20250916    clang-22
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250915    clang-22
hexagon               randconfig-001-20250916    clang-22
hexagon               randconfig-002-20250915    clang-22
hexagon               randconfig-002-20250916    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20250915    clang-20
i386        buildonly-randconfig-001-20250916    clang-20
i386        buildonly-randconfig-002-20250915    gcc-14
i386        buildonly-randconfig-002-20250916    clang-20
i386        buildonly-randconfig-003-20250915    gcc-14
i386        buildonly-randconfig-003-20250916    clang-20
i386        buildonly-randconfig-004-20250915    gcc-14
i386        buildonly-randconfig-004-20250916    clang-20
i386        buildonly-randconfig-005-20250915    gcc-14
i386        buildonly-randconfig-005-20250916    clang-20
i386        buildonly-randconfig-006-20250915    gcc-14
i386        buildonly-randconfig-006-20250916    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250916    clang-20
i386                  randconfig-002-20250916    clang-20
i386                  randconfig-003-20250916    clang-20
i386                  randconfig-004-20250916    clang-20
i386                  randconfig-005-20250916    clang-20
i386                  randconfig-006-20250916    clang-20
i386                  randconfig-007-20250916    clang-20
i386                  randconfig-011-20250916    gcc-14
i386                  randconfig-012-20250916    gcc-14
i386                  randconfig-013-20250916    gcc-14
i386                  randconfig-014-20250916    gcc-14
i386                  randconfig-015-20250916    gcc-14
i386                  randconfig-016-20250916    gcc-14
i386                  randconfig-017-20250916    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250915    clang-22
loongarch             randconfig-001-20250916    clang-22
loongarch             randconfig-002-20250915    gcc-12.5.0
loongarch             randconfig-002-20250916    clang-22
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250915    gcc-11.5.0
nios2                 randconfig-001-20250916    clang-22
nios2                 randconfig-002-20250915    gcc-11.5.0
nios2                 randconfig-002-20250916    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
openrisc                    or1ksim_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250915    gcc-9.5.0
parisc                randconfig-001-20250916    clang-22
parisc                randconfig-002-20250915    gcc-14.3.0
parisc                randconfig-002-20250916    clang-22
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                 canyonlands_defconfig    clang-22
powerpc               randconfig-001-20250915    gcc-14.3.0
powerpc               randconfig-001-20250916    clang-22
powerpc               randconfig-002-20250915    gcc-8.5.0
powerpc               randconfig-002-20250916    clang-22
powerpc               randconfig-003-20250915    clang-22
powerpc               randconfig-003-20250916    clang-22
powerpc                     tqm5200_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250915    clang-20
powerpc64             randconfig-001-20250916    clang-22
powerpc64             randconfig-002-20250915    clang-22
powerpc64             randconfig-002-20250916    clang-22
powerpc64             randconfig-003-20250915    clang-22
powerpc64             randconfig-003-20250916    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20250915    gcc-8.5.0
riscv                 randconfig-001-20250916    gcc-15.1.0
riscv                 randconfig-002-20250915    clang-22
riscv                 randconfig-002-20250916    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                          debug_defconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20250915    clang-22
s390                  randconfig-001-20250916    gcc-15.1.0
s390                  randconfig-002-20250915    clang-22
s390                  randconfig-002-20250916    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20250915    gcc-15.1.0
sh                    randconfig-001-20250916    gcc-15.1.0
sh                    randconfig-002-20250915    gcc-13.4.0
sh                    randconfig-002-20250916    gcc-15.1.0
sh                           se7619_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250915    gcc-8.5.0
sparc                 randconfig-001-20250916    gcc-15.1.0
sparc                 randconfig-002-20250915    gcc-8.5.0
sparc                 randconfig-002-20250916    gcc-15.1.0
sparc                       sparc32_defconfig    gcc-15.1.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20250915    gcc-13.4.0
sparc64               randconfig-001-20250916    gcc-15.1.0
sparc64               randconfig-002-20250915    gcc-12.5.0
sparc64               randconfig-002-20250916    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250915    gcc-14
um                    randconfig-001-20250916    gcc-15.1.0
um                    randconfig-002-20250915    gcc-14
um                    randconfig-002-20250916    gcc-15.1.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250915    clang-20
x86_64      buildonly-randconfig-001-20250916    clang-20
x86_64      buildonly-randconfig-002-20250915    gcc-12
x86_64      buildonly-randconfig-002-20250916    clang-20
x86_64      buildonly-randconfig-003-20250915    gcc-14
x86_64      buildonly-randconfig-003-20250916    clang-20
x86_64      buildonly-randconfig-004-20250915    clang-20
x86_64      buildonly-randconfig-004-20250916    clang-20
x86_64      buildonly-randconfig-005-20250915    clang-20
x86_64      buildonly-randconfig-005-20250916    clang-20
x86_64      buildonly-randconfig-006-20250915    gcc-14
x86_64      buildonly-randconfig-006-20250916    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250916    clang-20
x86_64                randconfig-002-20250916    clang-20
x86_64                randconfig-003-20250916    clang-20
x86_64                randconfig-004-20250916    clang-20
x86_64                randconfig-005-20250916    clang-20
x86_64                randconfig-006-20250916    clang-20
x86_64                randconfig-007-20250916    clang-20
x86_64                randconfig-008-20250916    clang-20
x86_64                randconfig-071-20250916    gcc-14
x86_64                randconfig-072-20250916    gcc-14
x86_64                randconfig-073-20250916    gcc-14
x86_64                randconfig-074-20250916    gcc-14
x86_64                randconfig-075-20250916    gcc-14
x86_64                randconfig-076-20250916    gcc-14
x86_64                randconfig-077-20250916    gcc-14
x86_64                randconfig-078-20250916    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250915    gcc-9.5.0
xtensa                randconfig-001-20250916    gcc-15.1.0
xtensa                randconfig-002-20250915    gcc-11.5.0
xtensa                randconfig-002-20250916    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


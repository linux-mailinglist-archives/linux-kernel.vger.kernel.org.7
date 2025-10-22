Return-Path: <linux-kernel+bounces-864239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8540EBFA400
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D2D20342634
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4FC2EF66A;
	Wed, 22 Oct 2025 06:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OCryEUjO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B862E718F
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761114890; cv=none; b=DpJASe6+XIdqHJuXOW25edDd2vNJUcn/JFTcflnx6VV8GI/DzoLk7jBXpyVjVgOcQ9Pz6sOLvBTDnKBqYCOejGYsBTnJKhQTSyPqc2uGyeDlQjZKXpeNp/tQXSSygVJ7Tm7TcCEN8KktRnZjNESSDQVuBJqtOL6LJWBg0ntLpyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761114890; c=relaxed/simple;
	bh=KbhYcV1i0gLbv9pUxr7uPr3DgX9w9V5P+oAqI7iBKZw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=a2i1ju+Fx8bOQSOLPZLL25cS+uRU1YiNWuklO8qO2Eqkt75MVcEEcFALLPr/wiKURNFupBZlKDRpDQrawOObMiCQpcvgC1KWve9XaU8+jg6NxLA/rnoips2iNMSIyq8RQB43Bt53bbj3vqslSUHV2FLlZWy6PLcODxBLkFEHyB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OCryEUjO; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761114888; x=1792650888;
  h=date:from:to:cc:subject:message-id;
  bh=KbhYcV1i0gLbv9pUxr7uPr3DgX9w9V5P+oAqI7iBKZw=;
  b=OCryEUjO379EAWL1dImtCFb5W/xOgXkTcitPrUkv45vBlzPbLSW9PCBf
   kIR65bdiPfX2C7txemktEMPDqQMAvIzocdJdMnslK3quL4eh57TVLxWr0
   OE5UA5eDpjep3B4Vd5jN0QmOq2GOcrXn+zlrbuziFsidv/H10H1ZMs7X+
   6AZLPEQaVn1W9dcHvV6kk789ovpT/l7VY/ADrjreficOg1q/nily/OmGa
   ExNCNUtv//M9IfX/4PJlz7ERO0WDWehnmg5L6XuqfTm5kpwmBCVbbHo6A
   RNbfGpNLT3NdP4ZW1fLzfA8MmPzDYucCfmwJ3N0TGKFFtId7Ec9IHloNU
   A==;
X-CSE-ConnectionGUID: ieU0xlAzSs21Lu96Ooat8g==
X-CSE-MsgGUID: lCVrmczyRamAZDJksyOmSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74597181"
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="74597181"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 23:34:47 -0700
X-CSE-ConnectionGUID: wa0RXJ+LQ9G0vFKo2yS47w==
X-CSE-MsgGUID: KeUhvJv+QWqfCQRtEPXQ2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="183728195"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 21 Oct 2025 23:34:46 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vBSQM-000C45-2i;
	Wed, 22 Oct 2025 06:34:35 +0000
Date: Wed, 22 Oct 2025 14:34:08 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20251021] BUILD SUCCESS
 732346d865dcd047d7acccd0725246f9a883b37d
Message-ID: <202510221403.x1GZBZ0D-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20251021
branch HEAD: 732346d865dcd047d7acccd0725246f9a883b37d  scsi: libsas/aci94xx: Avoid multiple -Wflex-array-member-not-at-end warnings

elapsed time: 1140m

configs tested: 213
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20251021    gcc-8.5.0
arc                   randconfig-001-20251022    clang-22
arc                   randconfig-002-20251021    gcc-9.5.0
arc                   randconfig-002-20251022    clang-22
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20251021    clang-22
arm                   randconfig-001-20251022    clang-22
arm                   randconfig-002-20251021    clang-22
arm                   randconfig-002-20251022    clang-22
arm                   randconfig-003-20251021    clang-22
arm                   randconfig-003-20251022    clang-22
arm                   randconfig-004-20251021    clang-22
arm                   randconfig-004-20251022    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                 randconfig-001-20251021    gcc-15.1.0
arm64                 randconfig-001-20251022    clang-22
arm64                 randconfig-002-20251021    clang-22
arm64                 randconfig-002-20251022    clang-22
arm64                 randconfig-003-20251021    gcc-12.5.0
arm64                 randconfig-003-20251022    clang-22
arm64                 randconfig-004-20251021    clang-18
arm64                 randconfig-004-20251022    clang-22
csky                              allnoconfig    clang-22
csky                  randconfig-001-20251021    gcc-15.1.0
csky                  randconfig-001-20251022    clang-22
csky                  randconfig-002-20251021    gcc-11.5.0
csky                  randconfig-002-20251022    clang-22
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
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
loongarch                 loongson3_defconfig    clang-22
loongarch             randconfig-001-20251021    clang-22
loongarch             randconfig-001-20251022    clang-22
loongarch             randconfig-002-20251021    clang-22
loongarch             randconfig-002-20251022    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                          atari_defconfig    clang-22
m68k                           sun3_defconfig    clang-22
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20251021    gcc-10.5.0
nios2                 randconfig-001-20251022    clang-22
nios2                 randconfig-002-20251021    gcc-8.5.0
nios2                 randconfig-002-20251022    clang-22
openrisc                          allnoconfig    clang-22
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251021    gcc-8.5.0
parisc                randconfig-001-20251022    clang-22
parisc                randconfig-002-20251021    gcc-15.1.0
parisc                randconfig-002-20251022    clang-22
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                        fsp2_defconfig    clang-22
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
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20251021    gcc-8.5.0
riscv                 randconfig-002-20251021    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20251021    clang-22
s390                  randconfig-002-20251021    gcc-11.5.0
s390                       zfcpdump_defconfig    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20251021    gcc-9.5.0
sh                    randconfig-002-20251021    gcc-10.5.0
sh                      rts7751r2d1_defconfig    clang-22
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251021    gcc-8.5.0
sparc                 randconfig-002-20251021    gcc-14.3.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251021    gcc-8.5.0
sparc64               randconfig-002-20251021    gcc-10.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251021    gcc-14
um                    randconfig-002-20251021    gcc-14
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
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251021    gcc-8.5.0
xtensa                randconfig-002-20251021    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


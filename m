Return-Path: <linux-kernel+bounces-760865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CB5B1F12C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 01:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAB17188AFA6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 23:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2628726E17F;
	Fri,  8 Aug 2025 23:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bU8/fTRp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1B520E71D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 22:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754694001; cv=none; b=VOJ6eKL22nyr6mTxGo8vBoFZmtcGL6/yZ1sG6ZV1nCnM61nPDwJAW/x+k0Wqd1iGyRzpuVXNS/qci8PAAw1rOKDNZmf9QhC6SJTlp7wBwTnX22UcHo9850P3EH65ssZyKnoVipaPMS/u85dTQIvU98UXRoGpDu7qb9x8dY/sctc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754694001; c=relaxed/simple;
	bh=6zcuk4cn2/HxFpNaSUcmDD6gDp6dJAJFfxGgg79vTVI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=B49qT3ZaClcZ2XDzKe+ZwszISlVCafCH/imo6//i2OJ0T22oZZDMSWD2TdSGUkDY3tCnB9+NNmi0H1JqhrM/cxRAV/DdjG8gQSRtC7IZcfAjNVS8nVjuaM6ZulWlWMMxBQFO9T9u9DmT6EhI247MXOc+L9E4YF34MjUyVS/1dpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bU8/fTRp; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754693999; x=1786229999;
  h=date:from:to:cc:subject:message-id;
  bh=6zcuk4cn2/HxFpNaSUcmDD6gDp6dJAJFfxGgg79vTVI=;
  b=bU8/fTRpoQkKi1QengG/NW0QdjJkwP6qBNFUVc0ek7eeQ1oEJpbXqK75
   OWfvFQYsGAE9msM4iWTp1zmLw4WMSx/7JEVqHpMQwDeEEHGsLJaGuU/s2
   DbCkJcsmDZrM0KOkap3fFL2V/1/AtSBU6BdRqxWrTSaPQhMiIehU+Lo5Q
   tP/S7/24kKjq10oElv3REX2xtmyv9UVvY5HdidTaSVgWarahdCCBSyZfp
   YLXuQ8Cn2wPA5MfWWL6lKI6FSx6EQxz/qcxD0j6w9A78njIZ/Dwpma7lo
   rWDIr0S/tiuOF5UW3wOkwnVqFBxBko7lKxq8e57f+B19ulFgL7jBLSoQh
   g==;
X-CSE-ConnectionGUID: zw2Afew2QxGYOkdt9iPocQ==
X-CSE-MsgGUID: US262F84Rw6i/U5KFhxqyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="57125185"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="57125185"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 15:59:59 -0700
X-CSE-ConnectionGUID: gFM4bAaRQ6KN9rV8U70xJA==
X-CSE-MsgGUID: tQpDoj/RRpiRi8SgfPwSrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="164660501"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 08 Aug 2025 15:59:57 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ukW43-0004Nk-1R;
	Fri, 08 Aug 2025 22:59:55 +0000
Date: Sat, 09 Aug 2025 06:59:27 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:tip/urgent] BUILD SUCCESS
 54b0c49290f7a314730612b4b6376cb4e09405a8
Message-ID: <202508090621.3DSpZTKn-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tip/urgent
branch HEAD: 54b0c49290f7a314730612b4b6376cb4e09405a8  Merge branch into tip/master: 'x86/urgent'

elapsed time: 1064m

configs tested: 244
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250808    gcc-14.3.0
arc                   randconfig-001-20250809    gcc-8.5.0
arc                   randconfig-002-20250808    gcc-12.5.0
arc                   randconfig-002-20250809    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                        neponset_defconfig    gcc-15.1.0
arm                   randconfig-001-20250808    gcc-14.3.0
arm                   randconfig-001-20250809    gcc-8.5.0
arm                   randconfig-002-20250808    gcc-10.5.0
arm                   randconfig-002-20250809    gcc-8.5.0
arm                   randconfig-003-20250808    clang-22
arm                   randconfig-003-20250809    gcc-8.5.0
arm                   randconfig-004-20250808    clang-22
arm                   randconfig-004-20250809    gcc-8.5.0
arm                         socfpga_defconfig    gcc-15.1.0
arm                        spear3xx_defconfig    clang-17
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250808    clang-20
arm64                 randconfig-001-20250809    gcc-8.5.0
arm64                 randconfig-002-20250808    gcc-10.5.0
arm64                 randconfig-002-20250809    gcc-8.5.0
arm64                 randconfig-003-20250808    clang-22
arm64                 randconfig-003-20250809    gcc-8.5.0
arm64                 randconfig-004-20250808    gcc-8.5.0
arm64                 randconfig-004-20250809    gcc-8.5.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250808    gcc-15.1.0
csky                  randconfig-001-20250809    gcc-9.5.0
csky                  randconfig-002-20250808    gcc-12.5.0
csky                  randconfig-002-20250809    gcc-9.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20250808    clang-20
hexagon               randconfig-001-20250809    gcc-9.5.0
hexagon               randconfig-002-20250808    clang-22
hexagon               randconfig-002-20250809    gcc-9.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250808    clang-20
i386        buildonly-randconfig-001-20250809    clang-20
i386        buildonly-randconfig-002-20250808    clang-20
i386        buildonly-randconfig-002-20250809    clang-20
i386        buildonly-randconfig-003-20250808    gcc-12
i386        buildonly-randconfig-003-20250809    clang-20
i386        buildonly-randconfig-004-20250808    clang-20
i386        buildonly-randconfig-004-20250809    clang-20
i386        buildonly-randconfig-005-20250808    gcc-12
i386        buildonly-randconfig-005-20250809    clang-20
i386        buildonly-randconfig-006-20250808    clang-20
i386        buildonly-randconfig-006-20250809    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250809    gcc-12
i386                  randconfig-002-20250809    gcc-12
i386                  randconfig-003-20250809    gcc-12
i386                  randconfig-004-20250809    gcc-12
i386                  randconfig-005-20250809    gcc-12
i386                  randconfig-006-20250809    gcc-12
i386                  randconfig-007-20250809    gcc-12
i386                  randconfig-011-20250809    clang-20
i386                  randconfig-012-20250809    clang-20
i386                  randconfig-013-20250809    clang-20
i386                  randconfig-014-20250809    clang-20
i386                  randconfig-015-20250809    clang-20
i386                  randconfig-016-20250809    clang-20
i386                  randconfig-017-20250809    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250808    clang-22
loongarch             randconfig-001-20250809    gcc-9.5.0
loongarch             randconfig-002-20250808    gcc-15.1.0
loongarch             randconfig-002-20250809    gcc-9.5.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                       m5249evb_defconfig    gcc-15.1.0
m68k                        mvme16x_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          rb532_defconfig    gcc-15.1.0
mips                         rt305x_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250808    gcc-9.5.0
nios2                 randconfig-001-20250809    gcc-9.5.0
nios2                 randconfig-002-20250808    gcc-8.5.0
nios2                 randconfig-002-20250809    gcc-9.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250808    gcc-8.5.0
parisc                randconfig-001-20250809    gcc-9.5.0
parisc                randconfig-002-20250808    gcc-13.4.0
parisc                randconfig-002-20250809    gcc-9.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                      arches_defconfig    gcc-15.1.0
powerpc                     mpc512x_defconfig    clang-22
powerpc               randconfig-001-20250808    clang-22
powerpc               randconfig-001-20250809    gcc-9.5.0
powerpc               randconfig-002-20250808    clang-18
powerpc               randconfig-002-20250809    gcc-9.5.0
powerpc               randconfig-003-20250808    clang-22
powerpc               randconfig-003-20250809    gcc-9.5.0
powerpc64             randconfig-001-20250808    clang-18
powerpc64             randconfig-001-20250809    gcc-9.5.0
powerpc64             randconfig-002-20250808    clang-22
powerpc64             randconfig-002-20250809    gcc-9.5.0
powerpc64             randconfig-003-20250808    clang-16
powerpc64             randconfig-003-20250809    gcc-9.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                               defconfig    gcc-12
riscv                    nommu_k210_defconfig    gcc-15.1.0
riscv                 randconfig-001-20250808    clang-22
riscv                 randconfig-001-20250809    clang-22
riscv                 randconfig-002-20250808    clang-22
riscv                 randconfig-002-20250809    clang-22
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                                defconfig    gcc-12
s390                  randconfig-001-20250808    gcc-10.5.0
s390                  randconfig-001-20250809    clang-22
s390                  randconfig-002-20250808    gcc-10.5.0
s390                  randconfig-002-20250809    clang-22
sh                               alldefconfig    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250808    gcc-13.4.0
sh                    randconfig-001-20250809    clang-22
sh                    randconfig-002-20250808    gcc-10.5.0
sh                    randconfig-002-20250809    clang-22
sh                             sh03_defconfig    gcc-15.1.0
sh                   sh7770_generic_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250808    gcc-12.5.0
sparc                 randconfig-001-20250809    clang-22
sparc                 randconfig-002-20250808    gcc-8.5.0
sparc                 randconfig-002-20250809    clang-22
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250808    clang-22
sparc64               randconfig-001-20250809    clang-22
sparc64               randconfig-002-20250808    clang-22
sparc64               randconfig-002-20250809    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    clang-22
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250808    gcc-12
um                    randconfig-001-20250809    clang-22
um                    randconfig-002-20250808    gcc-12
um                    randconfig-002-20250809    clang-22
um                           x86_64_defconfig    clang-22
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250808    clang-20
x86_64      buildonly-randconfig-001-20250809    gcc-12
x86_64      buildonly-randconfig-002-20250808    gcc-12
x86_64      buildonly-randconfig-002-20250809    gcc-12
x86_64      buildonly-randconfig-003-20250808    clang-20
x86_64      buildonly-randconfig-003-20250809    gcc-12
x86_64      buildonly-randconfig-004-20250808    clang-20
x86_64      buildonly-randconfig-004-20250809    gcc-12
x86_64      buildonly-randconfig-005-20250808    gcc-12
x86_64      buildonly-randconfig-005-20250809    gcc-12
x86_64      buildonly-randconfig-006-20250808    clang-20
x86_64      buildonly-randconfig-006-20250809    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250809    gcc-12
x86_64                randconfig-002-20250809    gcc-12
x86_64                randconfig-003-20250809    gcc-12
x86_64                randconfig-004-20250809    gcc-12
x86_64                randconfig-005-20250809    gcc-12
x86_64                randconfig-006-20250809    gcc-12
x86_64                randconfig-007-20250809    gcc-12
x86_64                randconfig-008-20250809    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250808    gcc-9.5.0
xtensa                randconfig-001-20250809    clang-22
xtensa                randconfig-002-20250808    gcc-8.5.0
xtensa                randconfig-002-20250809    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


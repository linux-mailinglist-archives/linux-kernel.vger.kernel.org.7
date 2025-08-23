Return-Path: <linux-kernel+bounces-782976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF854B327EB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 11:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 412D81B6526C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 09:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBAE23B612;
	Sat, 23 Aug 2025 09:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XL03/fSU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3380A1E2853
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 09:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755941213; cv=none; b=K00T0P6bybHFlmclhZEQRe2Kvei75IkRcrEsP9LSQ2I8AClItztt8dtx1TQ0jdsIVIp0vsh9otP5w4zAVDP57PnCpc4btuUgCldmGWNnB4rSU7gHU/oJQr8grIDKKROGlO9BxpqpE1cSYfshJsmB/AGNvhyV5PFZTPb0rrnHMSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755941213; c=relaxed/simple;
	bh=HX9zz+acMHeanaDUupWv9KDm2rTj8tMZKeomK8rm+sc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MYKkSLZ8jslrmpjjtpUOBATtU9r180bBczfMm9PNR+NJZ6JzjEF0oWdik4SHAvC4L4aWGF6X5GIJvegJdE/qRLr+nwjLaBl8bfTEtIGsv/HSlaDLqfxyCnoP+Njs4V84PlSFwG3rSiyU+rt1M9+QWs/2s9Sl8FqbXpjafXV+e4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XL03/fSU; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755941211; x=1787477211;
  h=date:from:to:cc:subject:message-id;
  bh=HX9zz+acMHeanaDUupWv9KDm2rTj8tMZKeomK8rm+sc=;
  b=XL03/fSUPimnJn47A11ru/GfSUnEfwxa9EXXk6q0NK6DmRlRFW1N1cU1
   PG9XEyHa398fqoPQSOCdIS8XsRufhpVDfXkFWk5Cx2ljOd1XtKv0ZaNb0
   6Sd6cxDSd7MBzGWE2kUJL4wZcd3YR/OEk7v0LSkYq8bNtFMbsD9U0divL
   PL5SfjlTXC79k8XjUPJov2WurF3EHgBr4mBmTKCuH0WwU2T9KElAVDBeR
   flhZa349ERtSGGlRf07KzNvXXyycB+JOE2eO8eGA5y+0+/0zE3y6oyN2+
   MGEbFH4dERqByqUXn8zSlX/rMNCfnK4iHy4md+f1IhrVzULDBQlJWwrwQ
   g==;
X-CSE-ConnectionGUID: A8OjjkfCQiuJBX0AljFuHA==
X-CSE-MsgGUID: xlN77B73Q9qAA6shF5Pvig==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="58300755"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58300755"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2025 02:26:51 -0700
X-CSE-ConnectionGUID: VolEda3CQPCUon7xQ+tGXw==
X-CSE-MsgGUID: CCur564jTxe7kHW2cq7kzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="173159638"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 23 Aug 2025 02:26:49 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upkWN-000MER-1T;
	Sat, 23 Aug 2025 09:26:47 +0000
Date: Sat, 23 Aug 2025 17:26:25 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/tdx] BUILD SUCCESS
 01fb93a363e0583a3ce48098aca5ab9825a5b790
Message-ID: <202508231719.hjN3DAZ0-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/tdx
branch HEAD: 01fb93a363e0583a3ce48098aca5ab9825a5b790  x86/tdx: Skip clearing reclaimed pages unless X86_BUG_TDX_PW_MCE is present

elapsed time: 1073m

configs tested: 218
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
arc                   randconfig-001-20250823    clang-22
arc                   randconfig-001-20250823    gcc-9.5.0
arc                   randconfig-002-20250823    clang-22
arc                   randconfig-002-20250823    gcc-12.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                          exynos_defconfig    clang-22
arm                      jornada720_defconfig    clang-22
arm                   randconfig-001-20250823    clang-17
arm                   randconfig-001-20250823    clang-22
arm                   randconfig-002-20250823    clang-22
arm                   randconfig-002-20250823    gcc-15.1.0
arm                   randconfig-003-20250823    clang-20
arm                   randconfig-003-20250823    clang-22
arm                   randconfig-004-20250823    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250823    clang-22
arm64                 randconfig-001-20250823    gcc-11.5.0
arm64                 randconfig-002-20250823    clang-22
arm64                 randconfig-003-20250823    clang-22
arm64                 randconfig-004-20250823    clang-22
arm64                 randconfig-004-20250823    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250823    clang-22
csky                  randconfig-001-20250823    gcc-15.1.0
csky                  randconfig-002-20250823    clang-22
csky                  randconfig-002-20250823    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250823    clang-22
hexagon               randconfig-002-20250823    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250823    clang-20
i386        buildonly-randconfig-002-20250823    clang-20
i386        buildonly-randconfig-003-20250823    clang-20
i386        buildonly-randconfig-004-20250823    clang-20
i386        buildonly-randconfig-005-20250823    clang-20
i386        buildonly-randconfig-006-20250823    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250823    clang-20
i386                  randconfig-002-20250823    clang-20
i386                  randconfig-003-20250823    clang-20
i386                  randconfig-004-20250823    clang-20
i386                  randconfig-005-20250823    clang-20
i386                  randconfig-006-20250823    clang-20
i386                  randconfig-007-20250823    clang-20
i386                  randconfig-011-20250823    gcc-12
i386                  randconfig-012-20250823    gcc-12
i386                  randconfig-013-20250823    gcc-12
i386                  randconfig-014-20250823    gcc-12
i386                  randconfig-015-20250823    gcc-12
i386                  randconfig-016-20250823    gcc-12
i386                  randconfig-017-20250823    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250823    clang-22
loongarch             randconfig-002-20250823    clang-22
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        bcm47xx_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250823    clang-22
nios2                 randconfig-001-20250823    gcc-11.5.0
nios2                 randconfig-002-20250823    clang-22
nios2                 randconfig-002-20250823    gcc-8.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250823    clang-22
parisc                randconfig-001-20250823    gcc-8.5.0
parisc                randconfig-002-20250823    clang-22
parisc                randconfig-002-20250823    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                    ge_imp3a_defconfig    clang-22
powerpc                 mpc832x_rdb_defconfig    clang-22
powerpc               randconfig-001-20250823    clang-22
powerpc               randconfig-002-20250823    clang-22
powerpc               randconfig-003-20250823    clang-22
powerpc64             randconfig-001-20250823    clang-22
powerpc64             randconfig-001-20250823    gcc-11.5.0
powerpc64             randconfig-002-20250823    clang-22
powerpc64             randconfig-003-20250823    clang-22
powerpc64             randconfig-003-20250823    gcc-10.5.0
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250823    clang-22
riscv                 randconfig-002-20250823    clang-22
riscv                 randconfig-002-20250823    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250823    clang-22
s390                  randconfig-001-20250823    gcc-9.5.0
s390                  randconfig-002-20250823    clang-22
sh                               alldefconfig    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250823    clang-22
sh                    randconfig-001-20250823    gcc-15.1.0
sh                    randconfig-002-20250823    clang-22
sh                    randconfig-002-20250823    gcc-15.1.0
sh                        sh7757lcr_defconfig    clang-22
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250823    clang-22
sparc                 randconfig-001-20250823    gcc-8.5.0
sparc                 randconfig-002-20250823    clang-22
sparc                 randconfig-002-20250823    gcc-8.5.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250823    clang-22
sparc64               randconfig-001-20250823    gcc-8.5.0
sparc64               randconfig-002-20250823    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250823    clang-22
um                    randconfig-002-20250823    clang-22
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250823    gcc-12
x86_64      buildonly-randconfig-002-20250823    gcc-12
x86_64      buildonly-randconfig-003-20250823    clang-20
x86_64      buildonly-randconfig-003-20250823    gcc-12
x86_64      buildonly-randconfig-004-20250823    clang-20
x86_64      buildonly-randconfig-004-20250823    gcc-12
x86_64      buildonly-randconfig-005-20250823    gcc-12
x86_64      buildonly-randconfig-006-20250823    gcc-12
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250823    gcc-12
x86_64                randconfig-002-20250823    gcc-12
x86_64                randconfig-003-20250823    gcc-12
x86_64                randconfig-004-20250823    gcc-12
x86_64                randconfig-005-20250823    gcc-12
x86_64                randconfig-006-20250823    gcc-12
x86_64                randconfig-007-20250823    gcc-12
x86_64                randconfig-008-20250823    gcc-12
x86_64                randconfig-071-20250823    gcc-11
x86_64                randconfig-072-20250823    gcc-11
x86_64                randconfig-073-20250823    gcc-11
x86_64                randconfig-074-20250823    gcc-11
x86_64                randconfig-075-20250823    gcc-11
x86_64                randconfig-076-20250823    gcc-11
x86_64                randconfig-077-20250823    gcc-11
x86_64                randconfig-078-20250823    gcc-11
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250823    clang-22
xtensa                randconfig-001-20250823    gcc-15.1.0
xtensa                randconfig-002-20250823    clang-22
xtensa                randconfig-002-20250823    gcc-13.4.0
xtensa                    xip_kc705_defconfig    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-kernel+bounces-855513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DCEBE1827
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 07:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 08B6F4E49D2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 05:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED780229B0F;
	Thu, 16 Oct 2025 05:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GYyqE7fy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB1610E3
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 05:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760592437; cv=none; b=Q78eN8/R3sDLJiq8G6FJSJgXRHLT2J/XKT8Ktmbrg3N37mVbWkC4JX9zSRBA76i8qDi+iHUjDz1w4vBCr94Arwpw5mZfi81J217bTTOr3UIK727IRLgHSpcNkJjGS9vWZaY7hlq3DreIs0tY443uCzGK1+x9ZQ9QuW8D1OzksvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760592437; c=relaxed/simple;
	bh=kFh0XJ1r7YrRTBkt0G42aWQkyibUpLAiCw+ujdbtdlo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XJDIbsaH8YokGJ9cVliaOXwCzMhtgxYWsRxZEQJ4tjeMuk5pgIUzFdLD/uwadeYb5dztsonNHKXOgNj6Ske/8Qzzyjwj1JVMTewQZ7XQ55qZesfnV0wDwgq90rF8DimKhpviM/vRbXqDmbbD4KsYtY6JdNUjj5Sr69E4fjEd08o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GYyqE7fy; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760592435; x=1792128435;
  h=date:from:to:cc:subject:message-id;
  bh=kFh0XJ1r7YrRTBkt0G42aWQkyibUpLAiCw+ujdbtdlo=;
  b=GYyqE7fy+h31r8Y0mwQ/rIln8Hq1YdmAul3dE5ODyFQSabl6OMxorznH
   5/2WYJIQaPTlhkVy1YVqXW/0Vrr37Pt3AG9InAoQ3xdh3T3VNkngQcvKp
   lf2otGnNitpva8ZcBZcX5m3yKz0Kp6xjJXfXk6RJPB+e2OdpF6VNtlLfW
   Pv8t9wyS/ETj+J1lRMtTvxjnjl/SmlZ94JUydP/afDfavS49pdHgfrsnU
   6688yJRqC/gVQLTUQeVOaGdPaKEkEmYE7gezniuz9yUcGFzcWQ6LnVnpA
   9Rhb/imJ5aMVPH0a8M3/qVrygtAxpTou3f17+AOdr891iGzDylhRBay8T
   g==;
X-CSE-ConnectionGUID: sFoZFVGkS/iKa4Y1OanaqQ==
X-CSE-MsgGUID: 3CZQE9pXRjC+Y2gX2+jdfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="65393257"
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="65393257"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 22:27:14 -0700
X-CSE-ConnectionGUID: hgEWreKsT+6Tumut/pqGRQ==
X-CSE-MsgGUID: u6rbcZ8gT9W+dRfyHQr8pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="182343951"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 15 Oct 2025 22:27:14 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9GW7-0004Tj-0S;
	Thu, 16 Oct 2025 05:27:11 +0000
Date: Thu, 16 Oct 2025 13:26:14 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:tip/urgent] BUILD SUCCESS
 31be4f0030c9a40b3631d2e79b8b7d88c7c94fcc
Message-ID: <202510161308.nH7XTV7A-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tip/urgent
branch HEAD: 31be4f0030c9a40b3631d2e79b8b7d88c7c94fcc  Merge branch into tip/master: 'x86/urgent'

elapsed time: 1114m

configs tested: 226
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                        nsimosci_defconfig    gcc-15.1.0
arc                   randconfig-001-20251015    gcc-8.5.0
arc                   randconfig-001-20251016    clang-22
arc                   randconfig-002-20251015    gcc-8.5.0
arc                   randconfig-002-20251016    clang-22
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                          pxa3xx_defconfig    gcc-15.1.0
arm                   randconfig-001-20251015    clang-22
arm                   randconfig-001-20251016    clang-22
arm                   randconfig-002-20251015    clang-22
arm                   randconfig-002-20251016    clang-22
arm                   randconfig-003-20251015    gcc-8.5.0
arm                   randconfig-003-20251016    clang-22
arm                   randconfig-004-20251015    clang-22
arm                   randconfig-004-20251016    clang-22
arm                       spear13xx_defconfig    gcc-15.1.0
arm                           sunxi_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20251015    clang-22
arm64                 randconfig-001-20251016    clang-22
arm64                 randconfig-002-20251015    gcc-13.4.0
arm64                 randconfig-002-20251016    clang-22
arm64                 randconfig-003-20251015    clang-22
arm64                 randconfig-003-20251016    clang-22
arm64                 randconfig-004-20251015    clang-22
arm64                 randconfig-004-20251016    clang-22
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20251015    gcc-15.1.0
csky                  randconfig-001-20251016    clang-22
csky                  randconfig-002-20251015    gcc-9.5.0
csky                  randconfig-002-20251016    clang-22
hexagon                          alldefconfig    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20251015    clang-22
hexagon               randconfig-001-20251016    clang-22
hexagon               randconfig-002-20251015    clang-19
hexagon               randconfig-002-20251016    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251015    gcc-13
i386        buildonly-randconfig-001-20251016    clang-20
i386        buildonly-randconfig-002-20251015    gcc-14
i386        buildonly-randconfig-002-20251016    clang-20
i386        buildonly-randconfig-003-20251015    clang-20
i386        buildonly-randconfig-003-20251016    clang-20
i386        buildonly-randconfig-004-20251015    clang-20
i386        buildonly-randconfig-004-20251016    clang-20
i386        buildonly-randconfig-005-20251015    clang-20
i386        buildonly-randconfig-005-20251016    clang-20
i386        buildonly-randconfig-006-20251015    clang-20
i386        buildonly-randconfig-006-20251016    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20251016    clang-20
i386                  randconfig-002-20251016    clang-20
i386                  randconfig-003-20251016    clang-20
i386                  randconfig-004-20251016    clang-20
i386                  randconfig-005-20251016    clang-20
i386                  randconfig-006-20251016    clang-20
i386                  randconfig-007-20251016    clang-20
i386                  randconfig-011-20251016    gcc-14
i386                  randconfig-012-20251016    gcc-14
i386                  randconfig-013-20251016    gcc-14
i386                  randconfig-014-20251016    gcc-14
i386                  randconfig-015-20251016    gcc-14
i386                  randconfig-016-20251016    gcc-14
i386                  randconfig-017-20251016    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251015    gcc-15.1.0
loongarch             randconfig-001-20251016    clang-22
loongarch             randconfig-002-20251015    gcc-15.1.0
loongarch             randconfig-002-20251016    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                          sun3x_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20251015    gcc-8.5.0
nios2                 randconfig-001-20251016    clang-22
nios2                 randconfig-002-20251015    gcc-8.5.0
nios2                 randconfig-002-20251016    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251015    gcc-9.5.0
parisc                randconfig-001-20251016    clang-22
parisc                randconfig-002-20251015    gcc-8.5.0
parisc                randconfig-002-20251016    clang-22
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                   bluestone_defconfig    clang-22
powerpc                        cell_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251015    gcc-15.1.0
powerpc               randconfig-001-20251016    clang-22
powerpc               randconfig-002-20251015    gcc-12.5.0
powerpc               randconfig-002-20251016    clang-22
powerpc               randconfig-003-20251015    clang-22
powerpc               randconfig-003-20251016    clang-22
powerpc                    sam440ep_defconfig    gcc-15.1.0
powerpc                     tqm8560_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251015    clang-22
powerpc64             randconfig-002-20251015    clang-22
powerpc64             randconfig-002-20251016    clang-22
powerpc64             randconfig-003-20251015    gcc-13.4.0
powerpc64             randconfig-003-20251016    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20251015    gcc-10.5.0
riscv                 randconfig-001-20251016    gcc-10.5.0
riscv                 randconfig-002-20251015    clang-22
riscv                 randconfig-002-20251016    gcc-10.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20251015    gcc-12.5.0
s390                  randconfig-001-20251016    gcc-10.5.0
s390                  randconfig-002-20251015    clang-22
s390                  randconfig-002-20251016    gcc-10.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                            migor_defconfig    gcc-15.1.0
sh                    randconfig-001-20251015    gcc-11.5.0
sh                    randconfig-001-20251016    gcc-10.5.0
sh                    randconfig-002-20251015    gcc-11.5.0
sh                    randconfig-002-20251016    gcc-10.5.0
sh                             sh03_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251015    gcc-8.5.0
sparc                 randconfig-001-20251016    gcc-10.5.0
sparc                 randconfig-002-20251015    gcc-13.4.0
sparc                 randconfig-002-20251016    gcc-10.5.0
sparc64               randconfig-001-20251015    clang-22
sparc64               randconfig-001-20251016    gcc-10.5.0
sparc64               randconfig-002-20251015    gcc-11.5.0
sparc64               randconfig-002-20251016    gcc-10.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                    randconfig-001-20251015    clang-22
um                    randconfig-001-20251016    gcc-10.5.0
um                    randconfig-002-20251015    clang-22
um                    randconfig-002-20251016    gcc-10.5.0
um                           x86_64_defconfig    gcc-15.1.0
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251015    clang-20
x86_64      buildonly-randconfig-001-20251016    gcc-12
x86_64      buildonly-randconfig-002-20251015    gcc-14
x86_64      buildonly-randconfig-002-20251016    gcc-12
x86_64      buildonly-randconfig-003-20251015    clang-20
x86_64      buildonly-randconfig-003-20251016    gcc-12
x86_64      buildonly-randconfig-004-20251015    clang-20
x86_64      buildonly-randconfig-004-20251016    gcc-12
x86_64      buildonly-randconfig-005-20251015    gcc-14
x86_64      buildonly-randconfig-005-20251016    gcc-12
x86_64      buildonly-randconfig-006-20251015    gcc-13
x86_64      buildonly-randconfig-006-20251016    gcc-12
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251016    clang-20
x86_64                randconfig-002-20251016    clang-20
x86_64                randconfig-003-20251016    clang-20
x86_64                randconfig-004-20251016    clang-20
x86_64                randconfig-005-20251016    clang-20
x86_64                randconfig-006-20251016    clang-20
x86_64                randconfig-007-20251016    clang-20
x86_64                randconfig-008-20251016    clang-20
x86_64                randconfig-071-20251016    gcc-14
x86_64                randconfig-072-20251016    gcc-14
x86_64                randconfig-073-20251016    gcc-14
x86_64                randconfig-074-20251016    gcc-14
x86_64                randconfig-075-20251016    gcc-14
x86_64                randconfig-076-20251016    gcc-14
x86_64                randconfig-077-20251016    gcc-14
x86_64                randconfig-078-20251016    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251015    gcc-9.5.0
xtensa                randconfig-001-20251016    gcc-10.5.0
xtensa                randconfig-002-20251015    gcc-15.1.0
xtensa                randconfig-002-20251016    gcc-10.5.0
xtensa                    xip_kc705_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


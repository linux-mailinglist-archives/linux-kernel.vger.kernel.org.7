Return-Path: <linux-kernel+bounces-891338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9F3C4276E
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 06:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76D23188E108
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 05:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34AD2D7DDC;
	Sat,  8 Nov 2025 05:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iX3JFA5r"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B082D5A07
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 05:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762578255; cv=none; b=Vyn2dFy0SsPn4W8mKYkqH0/gpuMAiWuAdvD+7p0xXmvzVxE6swmpXwYrVU92icxf78H4eUjQf9uZzxzhQGMoq26HabV0lM7358F13jLasyKXqXAc3DQh8uDxE42xBG1/GlZmgCZsGk3Gwwr6nE3CKH8vfBrV6iyLf4GW82JKhbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762578255; c=relaxed/simple;
	bh=mZLCLWlaM99YSACVH9Gdqz8ROlSW/R03SqJTA3/KR7I=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WWwHQ7j1Oz/cpCXHEg/3lT8QDhLNlX66O6dhlfqP4R53OATeA9Zw2QJg06J2WeYxcVkZWLIWhI9q4/TrkyKqQM6PR0izBDg6f6+pBe/IyMFIK3Znwkhf2aPoVnWzqpDjnEVSPIaKhRggB6w4xLMAuml72oQ5hJ0ziVkDRQPz/88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iX3JFA5r; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762578254; x=1794114254;
  h=date:from:to:cc:subject:message-id;
  bh=mZLCLWlaM99YSACVH9Gdqz8ROlSW/R03SqJTA3/KR7I=;
  b=iX3JFA5rL3Uv/7Qws5xHufq2Lb+tiiSJNTsTclxw30JMojid2M2MLB7p
   ediQsyA6AnQ/ErQRtMJ+DAe9R1b0nR5dxp0dqIuTL/wtcEhP//gK++Ko3
   LUPh+GkYm2oQ7UeFjTviu8r4kFJVIE1dfFhhqai7h5heKdFn8kX5gbAG5
   l5wDsoafuxpO20HUq26FQulpsj8xOXoPZgIe8DzkvV/15GSQqDMOMSdTv
   YKy13TaIZt85cH5qiLmqIq6XhKJgEdcV24W2FYIXNwqhyyp2E7xgY/343
   /nkrsoHByy3npzflMvQQfZsZpZ+fgMj+2BisUQBSDudaytHlcmBMSkD7T
   w==;
X-CSE-ConnectionGUID: h3GwWMpNRyuXbNbS3AS1Dw==
X-CSE-MsgGUID: sLerO8t1SVi5Ng7R1SErnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64650467"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64650467"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 21:04:13 -0800
X-CSE-ConnectionGUID: jFRYOGXOSSGdA0gzBMvZOA==
X-CSE-MsgGUID: dJVHMtMgRtW/RR9sgPqjcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,288,1754982000"; 
   d="scan'208";a="188933720"
Received: from lkp-server01.sh.intel.com (HELO 6ef82f2de774) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 07 Nov 2025 21:04:12 -0800
Received: from kbuild by 6ef82f2de774 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vHb7S-0000lP-1O;
	Sat, 08 Nov 2025 05:04:10 +0000
Date: Sat, 08 Nov 2025 13:03:49 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2025.11.05b] BUILD SUCCESS
 8e808de43edd0c3e83c4d09e6ebe1ca338c3e1a6
Message-ID: <202511081344.KRrWBF3r-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2025.11.05b
branch HEAD: 8e808de43edd0c3e83c4d09e6ebe1ca338c3e1a6  fixup! rcutorture: Parallelize kvm-series.sh guest-OS execution

elapsed time: 1906m

configs tested: 121
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                     nsimosci_hs_defconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                                 defconfig    clang-22
arm                        shmobile_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251108    gcc-8.5.0
arm64                 randconfig-002-20251108    clang-22
arm64                 randconfig-003-20251108    clang-22
arm64                 randconfig-004-20251108    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251108    gcc-15.1.0
csky                  randconfig-002-20251108    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-22
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251108    gcc-14
i386        buildonly-randconfig-002-20251108    gcc-14
i386        buildonly-randconfig-003-20251108    gcc-14
i386        buildonly-randconfig-004-20251108    gcc-14
i386        buildonly-randconfig-005-20251108    clang-20
i386        buildonly-randconfig-006-20251108    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251108    clang-20
i386                  randconfig-002-20251108    clang-20
i386                  randconfig-003-20251108    gcc-12
i386                  randconfig-004-20251108    gcc-12
i386                  randconfig-005-20251108    clang-20
i386                  randconfig-006-20251108    gcc-14
i386                  randconfig-007-20251108    gcc-14
i386                  randconfig-011-20251108    gcc-14
i386                  randconfig-012-20251108    clang-20
i386                  randconfig-013-20251108    gcc-14
i386                  randconfig-014-20251108    clang-20
i386                  randconfig-015-20251108    gcc-14
i386                  randconfig-016-20251108    gcc-14
i386                  randconfig-017-20251108    clang-20
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                          amiga_defconfig    gcc-15.1.0
m68k                          atari_defconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251107    gcc-8.5.0
parisc                randconfig-002-20251107    gcc-12.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20251107    clang-22
powerpc               randconfig-002-20251107    clang-22
powerpc64             randconfig-001-20251107    gcc-14.3.0
powerpc64             randconfig-002-20251107    clang-22
riscv                            alldefconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251107    clang-22
riscv                 randconfig-002-20251107    gcc-13.4.0
s390                              allnoconfig    clang-22
s390                                defconfig    clang-22
s390                  randconfig-001-20251107    gcc-8.5.0
s390                  randconfig-002-20251107    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                         ap325rxa_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                            hp6xx_defconfig    gcc-15.1.0
sh                    randconfig-001-20251107    gcc-13.4.0
sh                    randconfig-002-20251107    gcc-11.5.0
sh                          rsk7201_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251108    gcc-14.3.0
sparc                 randconfig-002-20251108    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251108    clang-20
sparc64               randconfig-002-20251108    clang-20
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251108    gcc-14
um                    randconfig-002-20251108    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251108    gcc-14
x86_64      buildonly-randconfig-002-20251108    gcc-12
x86_64      buildonly-randconfig-003-20251108    clang-20
x86_64      buildonly-randconfig-004-20251108    gcc-14
x86_64      buildonly-randconfig-005-20251108    gcc-14
x86_64      buildonly-randconfig-006-20251108    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251108    clang-20
x86_64                randconfig-002-20251108    clang-20
x86_64                randconfig-003-20251108    clang-20
x86_64                randconfig-004-20251108    gcc-14
x86_64                randconfig-011-20251108    clang-20
x86_64                randconfig-012-20251108    gcc-14
x86_64                randconfig-013-20251108    clang-20
x86_64                randconfig-014-20251108    clang-20
x86_64                randconfig-015-20251108    clang-20
x86_64                randconfig-016-20251108    gcc-14
x86_64                randconfig-071-20251108    gcc-14
x86_64                randconfig-072-20251108    clang-20
x86_64                randconfig-073-20251108    clang-20
x86_64                randconfig-074-20251108    clang-20
x86_64                randconfig-075-20251108    gcc-12
x86_64                randconfig-076-20251108    gcc-14
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251108    gcc-8.5.0
xtensa                randconfig-002-20251108    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


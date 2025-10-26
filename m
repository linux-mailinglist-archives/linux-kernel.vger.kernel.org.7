Return-Path: <linux-kernel+bounces-870535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBF0C0B13F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 20:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8111B4ED58E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 19:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170812FE059;
	Sun, 26 Oct 2025 19:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WPZL6qHL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE941E32D7
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 19:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761506547; cv=none; b=U2eBu6GiJImknxndtN2jkfsWasylUQzObEJvQ6a+LKkvjSpC76VLB01syS8+Jiec1EiIPDgdN/GjVL36dUEvEqPh7srSnCv389CX96yWZYR/M/QF0TT0emm44fut1kYirgiFGn2Xi3QpP1fv/ytvzHdyK/9coeww0eguF3pGEbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761506547; c=relaxed/simple;
	bh=Efj+jCAidaze8GPR+7621n0MJZSky9/vMIBjrlMyka8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=adzpIzQeIKFroMfn9YzWlz4pqKQnxaGtTdFGJKTSrHLJMn+g+3yxfwMlf0xFpiKqRqXgVT+1IR/inCi4ThyoH+EpIDImIvZjOI4B0gpXxISps/60W7oYUpDdqMzQeFJsOUbzV8n4M6DWePiwtk44yRGGlOkrMQPXu52bWTwel+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WPZL6qHL; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761506545; x=1793042545;
  h=date:from:to:cc:subject:message-id;
  bh=Efj+jCAidaze8GPR+7621n0MJZSky9/vMIBjrlMyka8=;
  b=WPZL6qHLTKwnbUOFG99c6PxlsQcA/j3Wd54j6tKvKJQCExCOR1JELCud
   ZfxB9jwKQhqPB/4w0yZlSH8UhKfPQJ5+NyDrjsRKxDKI8Jvsolz5xoiAc
   8ggyuN3CdFoIjk2KiK8EMkVV/G+WcR7btXIlC0/ueKtIlN200qq9Rrxpv
   iYpAEM3zmgeCS9ykXzgaJsbQpsHJsmHEDAwGLfDDAdqAUuxHId+TyOTQ3
   Nair6213JZYS/SCFpxdeAb3GKzzOHL9B7sEEpXP9nuB1Ojgrpxsp1GbOC
   300KAMwcLsKJWG2VHIjrSypFYzjA8MAW5oGGOvi+ePOfonDpXwhXHyO7+
   Q==;
X-CSE-ConnectionGUID: A5r0Qs0hQLSbDnZPauF3kw==
X-CSE-MsgGUID: JgZO6xqjTzqtMOnIvFMSkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74941959"
X-IronPort-AV: E=Sophos;i="6.19,257,1754982000"; 
   d="scan'208";a="74941959"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2025 12:22:24 -0700
X-CSE-ConnectionGUID: 1BBaM5HeQx2Yby96ag3Y2w==
X-CSE-MsgGUID: TQ0b6CtaTGCvjZxv9Lqxbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,257,1754982000"; 
   d="scan'208";a="184569736"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 26 Oct 2025 12:22:23 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vD6Jp-000GJN-1L;
	Sun, 26 Oct 2025 19:22:21 +0000
Date: Mon, 27 Oct 2025 03:21:26 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:tip/urgent] BUILD SUCCESS
 f4d34a10015c6766d178dc411cc6badca928b51c
Message-ID: <202510270320.nb6qBv31-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tip/urgent
branch HEAD: f4d34a10015c6766d178dc411cc6badca928b51c  Merge branch into tip/master: 'x86/urgent'

elapsed time: 720m

configs tested: 121
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251026    gcc-13.4.0
arc                   randconfig-002-20251026    gcc-9.5.0
arc                    vdk_hs38_smp_defconfig    gcc-15.1.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                           h3600_defconfig    gcc-15.1.0
arm                        multi_v5_defconfig    gcc-15.1.0
arm                   randconfig-001-20251026    clang-22
arm                   randconfig-002-20251026    clang-20
arm                   randconfig-003-20251026    clang-17
arm                   randconfig-004-20251026    clang-20
arm                        vexpress_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251026    gcc-15.1.0
arm64                 randconfig-002-20251026    clang-22
arm64                 randconfig-003-20251026    gcc-8.5.0
arm64                 randconfig-004-20251026    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251026    gcc-15.1.0
csky                  randconfig-002-20251026    gcc-9.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251026    clang-18
hexagon               randconfig-002-20251026    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251026    gcc-14
i386        buildonly-randconfig-002-20251026    clang-20
i386        buildonly-randconfig-003-20251026    gcc-14
i386        buildonly-randconfig-004-20251026    clang-20
i386        buildonly-randconfig-005-20251026    clang-20
i386        buildonly-randconfig-006-20251026    gcc-14
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251026    clang-22
loongarch             randconfig-002-20251026    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        maltaup_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251026    gcc-8.5.0
nios2                 randconfig-002-20251026    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251026    gcc-12.5.0
parisc                randconfig-002-20251026    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                    mvme5100_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251026    gcc-13.4.0
powerpc               randconfig-002-20251026    gcc-8.5.0
powerpc               randconfig-003-20251026    gcc-10.5.0
powerpc64             randconfig-001-20251026    gcc-10.5.0
powerpc64             randconfig-002-20251026    gcc-12.5.0
powerpc64             randconfig-003-20251026    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                           se7750_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc64                             defconfig    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251026    clang-20
x86_64      buildonly-randconfig-002-20251026    gcc-12
x86_64      buildonly-randconfig-003-20251026    gcc-14
x86_64      buildonly-randconfig-004-20251026    gcc-14
x86_64      buildonly-randconfig-005-20251026    clang-20
x86_64      buildonly-randconfig-006-20251026    gcc-14
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


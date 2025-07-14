Return-Path: <linux-kernel+bounces-730668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8750FB047E6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 21:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EE411A678EC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 19:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D4D27781E;
	Mon, 14 Jul 2025 19:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OPwlKzBP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BF826C3B3
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 19:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752521226; cv=none; b=LjKILDpmi4wOxtKn/ChSa0cQreytCuPeDhyFZtsGaEd/w16KTYLOnN42DpwnLXa7defx9WOvFvHs2bRJLwiUtOjxpE+lArM6ZCxORKjKwbx/h35wlH2Kwg2QHxfQm7rKXDwcPY7MMAXLC3bKmQ2neiwPnUzeQiqSUItHjU6i348=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752521226; c=relaxed/simple;
	bh=013cixo8jL+LFkWq49lTGMdr0rVrb5CJ5jT1PA9amDU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=quKxotmLLbSIpnHg9T3W/c9FYUlweAK+gF/ZID69iL6TjpJ/w78JIaEjd/dCkNHSG2yTBjrB4B0XHMWJ2P4OjRNZc4Nk7GYCgj4mRT1ovNIiV1x4Kpw1V89T9iFgrpxixBntoRSE65HS8XFIM+i5TPc7nLs91USn5WEZ/4oHat0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OPwlKzBP; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752521225; x=1784057225;
  h=date:from:to:cc:subject:message-id;
  bh=013cixo8jL+LFkWq49lTGMdr0rVrb5CJ5jT1PA9amDU=;
  b=OPwlKzBPmshkO9wWkaQrS1ugLkYG4zpu6K6ioftp4rZC/CgxIPygWnmY
   g+4c4vN4Y0RVX5rUOt5tg7gCUBgKCmpMU/z7B5ZGrq4u9aJarIqYG9ayL
   x63Qwa8l8GZcw9B2DeqJ5wYerXwaXDjJcrDbuu5mqomi4u1fhLq5wV5Jf
   l3/Ix/UcmWo8ZyErZx7RSnpKUIf4LxSP1OWDxKQ7DFg622m7glrmTSFad
   D1yVPqqYljBfPESLp38HT/gPX+cRdP5hBt8cIIRj0OtcZ7iislPDSFCf6
   CjVVzkHHT0bKC9xAU8LD/Z3e4LTbjlO5eb6WJ9blky74ofq745C3K9TVy
   w==;
X-CSE-ConnectionGUID: VhTw06HrR3OXo8XwNbMK0g==
X-CSE-MsgGUID: 5lRV3VNQSyiSr0C9GKiZlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="72303749"
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="72303749"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 12:27:00 -0700
X-CSE-ConnectionGUID: qL8Zev2TTiSjnxi96+qTCg==
X-CSE-MsgGUID: iAumD8KeQRmSuRvMHeW2Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="194179926"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 14 Jul 2025 12:26:59 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ubOpE-0009GB-0c;
	Mon, 14 Jul 2025 19:26:56 +0000
Date: Tue, 15 Jul 2025 03:26:07 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:tip/urgent] BUILD SUCCESS
 3b686b841c22e42368536345b5890718dcbe35ac
Message-ID: <202507150355.LbANhRC9-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tip/urgent
branch HEAD: 3b686b841c22e42368536345b5890718dcbe35ac  Merge branch into tip/master: 'locking/urgent'

elapsed time: 755m

configs tested: 129
configs skipped: 4

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
arc                   randconfig-001-20250714    gcc-8.5.0
arc                   randconfig-002-20250714    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250714    clang-21
arm                   randconfig-002-20250714    gcc-8.5.0
arm                   randconfig-003-20250714    clang-21
arm                   randconfig-004-20250714    gcc-8.5.0
arm                           tegra_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250714    gcc-13.4.0
arm64                 randconfig-002-20250714    gcc-8.5.0
arm64                 randconfig-003-20250714    gcc-8.5.0
arm64                 randconfig-004-20250714    gcc-14.3.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250714    gcc-10.5.0
csky                  randconfig-002-20250714    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250714    clang-21
hexagon               randconfig-002-20250714    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250714    gcc-12
i386        buildonly-randconfig-002-20250714    clang-20
i386        buildonly-randconfig-003-20250714    gcc-12
i386        buildonly-randconfig-004-20250714    gcc-12
i386        buildonly-randconfig-005-20250714    gcc-12
i386        buildonly-randconfig-006-20250714    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch             randconfig-001-20250714    gcc-15.1.0
loongarch             randconfig-002-20250714    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          eyeq6_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250714    gcc-12.4.0
nios2                 randconfig-002-20250714    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
openrisc                       virt_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250714    gcc-8.5.0
parisc                randconfig-002-20250714    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                     akebono_defconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc               randconfig-001-20250714    gcc-10.5.0
powerpc               randconfig-002-20250714    gcc-10.5.0
powerpc               randconfig-003-20250714    gcc-8.5.0
powerpc                     tqm8548_defconfig    clang-21
powerpc64             randconfig-001-20250714    clang-16
powerpc64             randconfig-002-20250714    gcc-8.5.0
powerpc64             randconfig-003-20250714    clang-21
riscv                            alldefconfig    gcc-15.1.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250714    gcc-8.5.0
riscv                 randconfig-002-20250714    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250714    clang-21
s390                  randconfig-002-20250714    clang-18
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250714    gcc-12.4.0
sh                    randconfig-002-20250714    gcc-11.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250714    gcc-8.5.0
sparc                 randconfig-002-20250714    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250714    clang-21
sparc64               randconfig-002-20250714    clang-21
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250714    gcc-12
um                    randconfig-002-20250714    gcc-11
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250714    gcc-12
x86_64      buildonly-randconfig-002-20250714    clang-20
x86_64      buildonly-randconfig-003-20250714    gcc-12
x86_64      buildonly-randconfig-004-20250714    gcc-12
x86_64      buildonly-randconfig-005-20250714    clang-20
x86_64      buildonly-randconfig-006-20250714    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250714    gcc-8.5.0
xtensa                randconfig-002-20250714    gcc-12.4.0
xtensa                    smp_lx200_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


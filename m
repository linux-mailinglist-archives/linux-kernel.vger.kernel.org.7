Return-Path: <linux-kernel+bounces-785556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB1BB34DAF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 23:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2B601895F5E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 21:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AC3287257;
	Mon, 25 Aug 2025 21:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gsu1+THP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945CA28F1
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 21:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756156185; cv=none; b=FlKbTNC0gd3WEVZ2Bt8iBcbr951VqDYDCw/2KMErKgL0gwN0fFHGWn6Y0oHFECwdYRrXt+abPCnP0VyeeCC0JQfxEjYP3BQTpYplWpSeS6qCXaeaFZklFLFTJd3aJxTiaqPPzGWsE2XnNWe2d7WT6ln5xI2nXRjafWQY6GPSj0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756156185; c=relaxed/simple;
	bh=8npjZxx9xLKig/hLrbZAB5fWUDlMJAYwuCrzWjXwqtw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=vC1VK7WDItW4xTCwMaPb/A7QZtKJlbcisprd0eKkm+y3C0NJ5C9Ac0xU00me5HysDlmYQr1slPP3UwU3UDtsjfBztueHsAeC/wcrHGwqfZ+NvQ5Guhyit2vRdheA/8lU9EsqKCW8WaNTs8hdnzTSVBwh2Ut+gmQzmE+xWHjOvQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gsu1+THP; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756156185; x=1787692185;
  h=date:from:to:cc:subject:message-id;
  bh=8npjZxx9xLKig/hLrbZAB5fWUDlMJAYwuCrzWjXwqtw=;
  b=gsu1+THPSkzoKFfS/GE7TW5W3CpFdcL3XVVHEmNh2pH58EqPdtfoaD1F
   HFupX9RG0AplO109wFULbSmcKOVwtuSk1br2lhXcAhkh+i7gUKjnZSZzi
   3Kq+Rrl9eOtCQ9Y7BZM+p8Q459PSJCJ8ENiEdyqNINjfhfMx1PazeKOrP
   uSY0BYcG+8kcuPaABOPiZXguXPbhYSHbN40wlhoQ23nl9NxGhVwln5kOD
   ei2q0YT3+d7PhPbIQQhLbGmwVQkA/3MxRNQ/hO6V6Gx6inr8ILh2jJkwv
   mN2N80L8iEjarG3w12XYlv+kBNi/syUEMUnJ1HXDGCP559SJhD6XBkJUj
   A==;
X-CSE-ConnectionGUID: HgjpVhscR3quTPIcE6lSlg==
X-CSE-MsgGUID: ioydHFCMTLa2m6XXSMJjNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62207952"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62207952"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 14:09:44 -0700
X-CSE-ConnectionGUID: thB3PTEQTgKxzXgxTFCCPQ==
X-CSE-MsgGUID: p6xXA7zeQ9Cf13Z9eDx+rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="206555378"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 25 Aug 2025 14:09:42 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uqeRb-000O0k-0E;
	Mon, 25 Aug 2025 21:09:36 +0000
Date: Tue, 26 Aug 2025 05:09:22 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:tip/urgent] BUILD SUCCESS
 8d4c2c3183e48b897a6b2b80a8489afc9e33cde0
Message-ID: <202508260513.loDCbouY-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tip/urgent
branch HEAD: 8d4c2c3183e48b897a6b2b80a8489afc9e33cde0  Merge branch into tip/master: 'irq/urgent'

elapsed time: 806m

configs tested: 135
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
arc                   randconfig-001-20250825    gcc-8.5.0
arc                   randconfig-002-20250825    gcc-12.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                           h3600_defconfig    gcc-15.1.0
arm                   randconfig-001-20250825    gcc-12.5.0
arm                   randconfig-002-20250825    gcc-13.4.0
arm                   randconfig-003-20250825    gcc-8.5.0
arm                   randconfig-004-20250825    clang-22
arm                        spear3xx_defconfig    clang-17
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250825    gcc-8.5.0
arm64                 randconfig-002-20250825    gcc-8.5.0
arm64                 randconfig-003-20250825    clang-22
arm64                 randconfig-004-20250825    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250825    gcc-12.5.0
csky                  randconfig-002-20250825    gcc-11.5.0
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20250825    clang-18
hexagon               randconfig-002-20250825    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250825    gcc-12
i386        buildonly-randconfig-002-20250825    clang-20
i386        buildonly-randconfig-003-20250825    clang-20
i386        buildonly-randconfig-004-20250825    gcc-12
i386        buildonly-randconfig-005-20250825    gcc-12
i386        buildonly-randconfig-006-20250825    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250825    gcc-12.5.0
loongarch             randconfig-002-20250825    clang-18
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                       m5249evb_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        qi_lb60_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250825    gcc-8.5.0
nios2                 randconfig-002-20250825    gcc-9.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250825    gcc-8.5.0
parisc                randconfig-002-20250825    gcc-9.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250825    clang-22
powerpc               randconfig-002-20250825    clang-22
powerpc               randconfig-003-20250825    clang-22
powerpc                     tqm8541_defconfig    clang-22
powerpc64             randconfig-001-20250825    gcc-13.4.0
powerpc64             randconfig-002-20250825    gcc-15.1.0
powerpc64             randconfig-003-20250825    clang-20
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250825    clang-18
riscv                 randconfig-002-20250825    gcc-12.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250825    gcc-12.5.0
s390                  randconfig-002-20250825    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250825    gcc-14.3.0
sh                    randconfig-002-20250825    gcc-13.4.0
sh                          rsk7201_defconfig    gcc-15.1.0
sh                           se7724_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250825    gcc-15.1.0
sparc                 randconfig-002-20250825    gcc-14.3.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250825    clang-22
sparc64               randconfig-002-20250825    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250825    clang-22
um                    randconfig-002-20250825    clang-20
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250825    clang-20
x86_64      buildonly-randconfig-002-20250825    gcc-12
x86_64      buildonly-randconfig-003-20250825    gcc-12
x86_64      buildonly-randconfig-004-20250825    clang-20
x86_64      buildonly-randconfig-005-20250825    clang-20
x86_64      buildonly-randconfig-006-20250825    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                           alldefconfig    gcc-15.1.0
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250825    gcc-8.5.0
xtensa                randconfig-002-20250825    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


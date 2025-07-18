Return-Path: <linux-kernel+bounces-736477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 670F9B09D5E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFC851C262B4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8A12206A6;
	Fri, 18 Jul 2025 08:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GHR1xsR2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8601DA3D
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752825941; cv=none; b=QHcioKc2BfCKSeIRZeIkX1h3VGwVjo+8J8EHtKXcR4JNqDAJSXamBRRSWzFCAfwoD1+c+F79U6pfSA5E89I9pzkI5qUWMk8asM/GYkH/ir+yioX1ospVqPdTpYTPRFZOHHzNk5VnRKu3bjcUYErNjuEMmg9Q7zULToGa4TGa21I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752825941; c=relaxed/simple;
	bh=txm0svqLeI7cXz8vE/1pGx3+GJrrIFCPI95Z1hPbIMM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZmzP959QEpI6F7JNUMwfRejsv0Gx2SCWIp8iy/24LxOJiR1heDa5o3ziyViJrZCyZQAnJa5ibVSUMpI0CIipuiG0LjDg0yj73ahCePuuw6MWPKkZBHAjdCGN7Gj5g37Wy2JykKZT7a90Ni8WpZ01L9lMaleO9ThyN/8IR+hWnN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GHR1xsR2; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752825940; x=1784361940;
  h=date:from:to:cc:subject:message-id;
  bh=txm0svqLeI7cXz8vE/1pGx3+GJrrIFCPI95Z1hPbIMM=;
  b=GHR1xsR2Ukup3Ms81kWQZ/jOp0Tk7NvFzae7z1HEEYe3Mq416Y3nnBs1
   tBgwRhLiVx9cZ0lZ7ylT0xxwhWGha3htPdPRD/8bro6U96izKuBtcuvAr
   VNgdo/U5TV2xF79dlUS/xTkSRWhyqddLfv+egQpj5SYw66a0juD4pKToK
   /AJHbovQwNZ3IlHCO2gwSSMw7WD73yat7mL0uCeIwmxgopn7wxsFEjEiM
   fp1IQ1cughSbzyzOqP3G76zybNxfd44VEXGeWunsCS8JtRL6/p6Nk8imV
   DK5KZf5CGocojfKH64tSEFxwDsME8SqLTdP++oMLs45JB9lufk5E+aNlU
   A==;
X-CSE-ConnectionGUID: KaRqz1jhR1e50W8PwjYxdw==
X-CSE-MsgGUID: bdrM+NCaTRaeemSYF2wkpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="54827074"
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; 
   d="scan'208";a="54827074"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 01:05:37 -0700
X-CSE-ConnectionGUID: FtISiMYwSzaZf5eW8sxaig==
X-CSE-MsgGUID: PzRVMOsZQ1SKqvRq2rCSkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; 
   d="scan'208";a="162523987"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 18 Jul 2025 01:05:36 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ucg62-000EQR-0E;
	Fri, 18 Jul 2025 08:05:34 +0000
Date: Fri, 18 Jul 2025 16:04:41 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 4d94176b272f3e63356d8d388db34610dbad0019
Message-ID: <202507181629.wNqjPR4c-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 4d94176b272f3e63356d8d388db34610dbad0019  Merge branch into tip/master: 'x86/sev'

elapsed time: 1453m

configs tested: 127
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
arc                   randconfig-001-20250717    gcc-8.5.0
arc                   randconfig-002-20250717    gcc-15.1.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                           h3600_defconfig    gcc-15.1.0
arm                          ixp4xx_defconfig    gcc-15.1.0
arm                   randconfig-001-20250717    clang-21
arm                   randconfig-002-20250717    gcc-8.5.0
arm                   randconfig-003-20250717    gcc-8.5.0
arm                   randconfig-004-20250717    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250717    clang-18
arm64                 randconfig-002-20250717    clang-18
arm64                 randconfig-003-20250717    gcc-10.5.0
arm64                 randconfig-004-20250717    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250717    gcc-15.1.0
csky                  randconfig-002-20250717    gcc-12.4.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250717    clang-20
hexagon               randconfig-002-20250717    clang-19
i386                              allnoconfig    gcc-12
i386        buildonly-randconfig-001-20250717    gcc-12
i386        buildonly-randconfig-002-20250717    gcc-12
i386        buildonly-randconfig-003-20250717    clang-20
i386        buildonly-randconfig-004-20250717    clang-20
i386        buildonly-randconfig-005-20250717    clang-20
i386        buildonly-randconfig-006-20250717    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch             randconfig-001-20250717    gcc-15.1.0
loongarch             randconfig-002-20250717    clang-21
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
nios2                 randconfig-001-20250717    gcc-8.5.0
nios2                 randconfig-002-20250717    gcc-9.3.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250717    gcc-9.3.0
parisc                randconfig-002-20250717    gcc-9.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                 mpc836x_rdk_defconfig    clang-21
powerpc               randconfig-001-20250717    clang-21
powerpc               randconfig-002-20250717    gcc-13.4.0
powerpc               randconfig-003-20250717    clang-21
powerpc64             randconfig-001-20250717    clang-21
powerpc64             randconfig-002-20250717    clang-18
powerpc64             randconfig-003-20250717    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250717    gcc-14.3.0
riscv                 randconfig-002-20250717    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250717    gcc-8.5.0
s390                  randconfig-002-20250717    gcc-9.3.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250717    gcc-14.3.0
sh                    randconfig-002-20250717    gcc-9.3.0
sh                          sdk7786_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250717    gcc-14.3.0
sparc                 randconfig-002-20250717    gcc-8.5.0
sparc                       sparc64_defconfig    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250717    gcc-12.4.0
sparc64               randconfig-002-20250717    clang-21
um                               alldefconfig    clang-21
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250717    gcc-12
um                    randconfig-002-20250717    gcc-12
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250717    clang-20
x86_64      buildonly-randconfig-002-20250717    clang-20
x86_64      buildonly-randconfig-003-20250717    clang-20
x86_64      buildonly-randconfig-004-20250717    gcc-12
x86_64      buildonly-randconfig-005-20250717    gcc-12
x86_64      buildonly-randconfig-006-20250717    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250717    gcc-13.4.0
xtensa                randconfig-002-20250717    gcc-9.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


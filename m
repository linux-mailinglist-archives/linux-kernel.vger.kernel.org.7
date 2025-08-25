Return-Path: <linux-kernel+bounces-783841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA453B33366
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 02:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66D103A7752
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 00:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5111F4622;
	Mon, 25 Aug 2025 00:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ft4OMhPH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2FB2629C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 00:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756082789; cv=none; b=Q9+ULLpQbHW+i/JVrD/4NIDeGoqrY7pJXe+H85+7f51dS8xkjbaIfbqsFJkbeuwWALpFtZGAhHjXJbAZcDjPzhEXp5UuVXeI9vSKoLefNcMViRuRyavxPfrll0rwTGGk+TXiCxI/L5/9wv6kU2edd/66KI2y5nlGDHD/ySsJO8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756082789; c=relaxed/simple;
	bh=yJjt5sr7PNDbPHTmPcfFFQ4wbLoSBEzTs7pxtl84W2M=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pdb0RKHBOLQmcQuCJWiJkO0EGxc4teigeqoOETp/NC9B1YtQ75EX2/JGb8iW3yscYoO6tdXI13n6SLffSmp7K9NMqIoUk+ib7yy/2YN3jQTGm090zxlN7w281/aYlCBmOH431JC7YbBmTgdSBG7N7cyXrey5KLPBTiySmNeutgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ft4OMhPH; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756082787; x=1787618787;
  h=date:from:to:cc:subject:message-id;
  bh=yJjt5sr7PNDbPHTmPcfFFQ4wbLoSBEzTs7pxtl84W2M=;
  b=ft4OMhPHOI1596R5FxRQLiPLL6DMMexPvcWQRCp0btyBRibh5Iyc2yqb
   5teeEBorJo7mLZdbwhVt8TC7Wdg+rFLtLreoe7waE1xlT7leaYqJQpfsc
   m/kJxEriO5Cc9LqXlMGvpY9dgP9dIvH/aiHuwYbibSHt4PfWKEViKVLQR
   MSsvNYLH4hGTkK56QZqIpG67QBkK4s76SrHPwzxKbJJ6gu1jRYLrlJvyq
   SiE+DaA68bgk+uqzfo7Gyp0ApbcUvnWF4UD3dHj5a1NcowNURZj1T28ql
   WS1LaeXBPPSxH5p2l68UyAphMRk9GuOT13WoxkRUciHGJxb2Inhyb8HOP
   Q==;
X-CSE-ConnectionGUID: l1N0BG3oSeiTp7WPP/UkVw==
X-CSE-MsgGUID: IAovMrpnTSegdoGEJQDjTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11532"; a="45864091"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="45864091"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2025 17:46:26 -0700
X-CSE-ConnectionGUID: F9gbaaa4Q6e6nJyKaM1AlQ==
X-CSE-MsgGUID: wemTBVEwTmqHP+5H2fEuXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="168662629"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 24 Aug 2025 17:46:25 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uqLLY-000NHX-20;
	Mon, 25 Aug 2025 00:46:11 +0000
Date: Mon, 25 Aug 2025 08:45:45 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/drivers] BUILD SUCCESS
 8ff1c16c753e293c3ba20583cb64f81ea7b9a451
Message-ID: <202508250830.HPAGiaKq-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/drivers
branch HEAD: 8ff1c16c753e293c3ba20583cb64f81ea7b9a451  irqchip/loongson-eiointc: Add multiple interrupt pin routing support

elapsed time: 830m

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
arc                   randconfig-001-20250824    gcc-15.1.0
arc                   randconfig-002-20250824    gcc-10.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                   randconfig-001-20250824    clang-22
arm                   randconfig-002-20250824    gcc-13.4.0
arm                   randconfig-003-20250824    clang-22
arm                   randconfig-004-20250824    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250824    gcc-13.4.0
arm64                 randconfig-002-20250824    gcc-11.5.0
arm64                 randconfig-003-20250824    gcc-10.5.0
arm64                 randconfig-004-20250824    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250824    gcc-10.5.0
csky                  randconfig-002-20250824    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20250824    clang-22
hexagon               randconfig-002-20250824    clang-22
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250824    gcc-12
i386        buildonly-randconfig-002-20250824    gcc-12
i386        buildonly-randconfig-003-20250824    gcc-12
i386        buildonly-randconfig-004-20250824    gcc-12
i386        buildonly-randconfig-005-20250824    gcc-12
i386        buildonly-randconfig-006-20250824    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250824    gcc-12.5.0
loongarch             randconfig-002-20250824    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                           sun3_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
microblaze                      mmu_defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           ip27_defconfig    gcc-15.1.0
mips                           jazz_defconfig    clang-17
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250824    gcc-8.5.0
nios2                 randconfig-002-20250824    gcc-9.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250824    gcc-9.5.0
parisc                randconfig-002-20250824    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                      ep88xc_defconfig    gcc-15.1.0
powerpc                     mpc5200_defconfig    clang-22
powerpc                     mpc83xx_defconfig    clang-22
powerpc               randconfig-001-20250824    gcc-9.5.0
powerpc               randconfig-002-20250824    clang-22
powerpc               randconfig-003-20250824    gcc-12.5.0
powerpc64             randconfig-001-20250824    gcc-8.5.0
powerpc64             randconfig-002-20250824    gcc-13.4.0
powerpc64             randconfig-003-20250824    gcc-12.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250824    gcc-11.5.0
riscv                 randconfig-002-20250824    gcc-9.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250824    clang-16
s390                  randconfig-002-20250824    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250824    gcc-15.1.0
sh                    randconfig-002-20250824    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250824    gcc-14.3.0
sparc                 randconfig-002-20250824    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250824    clang-22
sparc64               randconfig-002-20250824    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250824    gcc-12
um                    randconfig-002-20250824    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250824    gcc-12
x86_64      buildonly-randconfig-002-20250824    clang-20
x86_64      buildonly-randconfig-003-20250824    gcc-12
x86_64      buildonly-randconfig-004-20250824    clang-20
x86_64      buildonly-randconfig-005-20250824    gcc-12
x86_64      buildonly-randconfig-006-20250824    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                          iss_defconfig    gcc-15.1.0
xtensa                randconfig-001-20250824    gcc-9.5.0
xtensa                randconfig-002-20250824    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


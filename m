Return-Path: <linux-kernel+bounces-803731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD5DB4646B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 22:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA4E61CC5967
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 20:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1989D2874FA;
	Fri,  5 Sep 2025 20:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZXTTNQd2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D300F2848B4
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 20:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757103120; cv=none; b=eQw7/WFXa6iHdxEZakfNe9Mgu3uq6JdWy1BPHo+mEZGOV/fcxKP1lU4z6CCr7/TzPh0+g1X7lXvNpVHFiasRvdykmGNElGduviSoG7XdhKPvO6jzcveVZxl8Z8qPMQk1kI7P3Np1w/ro1b1l0QTIxmM0xRqZzXc4UZ8CO0qRGcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757103120; c=relaxed/simple;
	bh=+0Jdk5nn2aI/0rDaAcAE4o9MtvPfKlpQp82ScVmwaoM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=url6qpFybUJlChkTkDPgfsEqocwsLhnNgPyB/NFqVxo4+yyRH1hItFiQhGDQuGZSC960by5paoyQ0ZGC5x+cj9NxXRfWhTS6FrmSLPt9/pId3ELxNNt+cb41nORrsiropKuDUjKUz5nB4R8IHZhejlTSdJC2DmSvpsozdaRf3KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZXTTNQd2; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757103119; x=1788639119;
  h=date:from:to:cc:subject:message-id;
  bh=+0Jdk5nn2aI/0rDaAcAE4o9MtvPfKlpQp82ScVmwaoM=;
  b=ZXTTNQd2Z2KTGyHBh70dpQXrvztcpzr1mSLDqa3cyx2bu+O2JGD1L6Ip
   4TOHvDQkwjTQv7ZTKcxYrsHaoX+DrT0VGGesnovbDy7yADHPr85PEaFcR
   USG82H1FBt69cFxOGrhBmVofBBKt0ciq7g1MyiPZluMV77+scwoccGduJ
   U1RAbnVUoH3EpBIHn8YAaiYsJ0BOFjoD0oR340+SD5vUo6G2cvKAfJaKO
   XKMhgkYbnaLFoinz6jN4ev4Lzg0kc/fcglNZILa3bMyPaMbH2P4iyPsec
   BnJzPm1cP2mBKvNUzgoc5JYvDT+P/is7ltxwukHRCfGxy+ItxZJM1F2F6
   g==;
X-CSE-ConnectionGUID: 3DFHMnVQT2aNEcrZPRLhDw==
X-CSE-MsgGUID: g5+1nTSGSKW94qHz1zS2HA==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="59532416"
X-IronPort-AV: E=Sophos;i="6.18,242,1751266800"; 
   d="scan'208";a="59532416"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 13:11:58 -0700
X-CSE-ConnectionGUID: ZIuZ6MEAS8GiMIsBukOI9Q==
X-CSE-MsgGUID: I8PdEylVRnKOn38EtlUahg==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 05 Sep 2025 13:11:57 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uucmp-0000nj-10;
	Fri, 05 Sep 2025 20:11:55 +0000
Date: Sat, 06 Sep 2025 04:11:24 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/apic] BUILD SUCCESS
 d4bc3b11c12b41fdb5650f5ad797de97f8dce869
Message-ID: <202509060418.1gjjp32o-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/apic
branch HEAD: d4bc3b11c12b41fdb5650f5ad797de97f8dce869  x86/apic/savic: Do not use snp_abort()

elapsed time: 1939m

configs tested: 100
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                          axs101_defconfig    gcc-15.1.0
arc                   randconfig-001-20250904    gcc-9.5.0
arc                   randconfig-002-20250904    gcc-11.5.0
arm                               allnoconfig    clang-22
arm                   randconfig-001-20250904    gcc-10.5.0
arm                   randconfig-002-20250904    gcc-13.4.0
arm                   randconfig-003-20250904    gcc-8.5.0
arm                   randconfig-004-20250904    gcc-13.4.0
arm                        spear6xx_defconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250904    gcc-8.5.0
arm64                 randconfig-002-20250904    gcc-8.5.0
arm64                 randconfig-003-20250904    clang-22
arm64                 randconfig-004-20250904    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250905    gcc-15.1.0
csky                  randconfig-002-20250905    gcc-13.4.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250905    clang-22
hexagon               randconfig-002-20250905    clang-22
i386                             allmodconfig    gcc-13
i386                              allnoconfig    gcc-13
i386                             allyesconfig    gcc-13
i386        buildonly-randconfig-001-20250904    clang-20
i386        buildonly-randconfig-002-20250904    gcc-12
i386        buildonly-randconfig-003-20250904    gcc-13
i386        buildonly-randconfig-004-20250904    gcc-13
i386        buildonly-randconfig-005-20250904    clang-20
i386        buildonly-randconfig-006-20250904    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250905    clang-18
loongarch             randconfig-002-20250905    clang-18
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                 randconfig-001-20250905    gcc-10.5.0
nios2                 randconfig-002-20250905    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                randconfig-001-20250905    gcc-15.1.0
parisc                randconfig-002-20250905    gcc-8.5.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                    mvme5100_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250905    gcc-8.5.0
powerpc               randconfig-002-20250905    clang-22
powerpc               randconfig-003-20250905    gcc-8.5.0
powerpc                     tqm8541_defconfig    clang-22
powerpc                     tqm8548_defconfig    clang-22
powerpc64             randconfig-001-20250905    clang-22
powerpc64             randconfig-002-20250905    clang-22
powerpc64             randconfig-003-20250905    gcc-14.3.0
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250904    gcc-8.5.0
riscv                 randconfig-002-20250904    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250904    gcc-10.5.0
s390                  randconfig-002-20250904    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250904    gcc-12.5.0
sh                    randconfig-002-20250904    gcc-10.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250904    gcc-11.5.0
sparc                 randconfig-002-20250904    gcc-15.1.0
sparc64               randconfig-001-20250904    gcc-12.5.0
sparc64               randconfig-002-20250904    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-13
um                    randconfig-001-20250904    gcc-13
um                    randconfig-002-20250904    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250904    gcc-12
x86_64      buildonly-randconfig-002-20250904    clang-20
x86_64      buildonly-randconfig-003-20250904    gcc-13
x86_64      buildonly-randconfig-004-20250904    gcc-13
x86_64      buildonly-randconfig-005-20250904    gcc-13
x86_64      buildonly-randconfig-006-20250904    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250904    gcc-10.5.0
xtensa                randconfig-002-20250904    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


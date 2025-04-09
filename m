Return-Path: <linux-kernel+bounces-596990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A29B8A833AA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 23:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C700E8A38DF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 21:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3983E215F4B;
	Wed,  9 Apr 2025 21:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P2rFK/Al"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01A31E7C1C
	for <linux-kernel@vger.kernel.org>; Wed,  9 Apr 2025 21:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744235464; cv=none; b=k/fB1SBfzNGtyL7yFHP6uXPwp9tNSpCIQET7syzopJIQrj4fDw8Mu7U8LWi2ZrRV7VEwhTO5ZpvaC7eXXy6AtS2551vD+q0KCLUewmE5nZdduDtNw2GaVWA9Xgg20uj7nMf3DrzZc5yHBU24Rosbm+R4X98IvEVWvOaxpfz+E0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744235464; c=relaxed/simple;
	bh=IW0BqpYqA0y4T/87+lDOzRvpjOMOW6KCWhC4EV90+m4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=dCFyHSbf3XB+Gx2RGq0c1aQaiO5HRcaJJ65KV82HSI6Y2XzDbss2rG4AbFkJXmv5zc0A0EqcI1B+UJeeRuzuCCsnwTsEx+Ph2uMWTkgbV6/s3gAS98dwWuyMcvn4Tdss7cmbn8Oge0Wo1q2OUVrWF1lpsblSWAOgTxBkV1JJwfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P2rFK/Al; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744235463; x=1775771463;
  h=date:from:to:cc:subject:message-id;
  bh=IW0BqpYqA0y4T/87+lDOzRvpjOMOW6KCWhC4EV90+m4=;
  b=P2rFK/AlsueCtzMMma4d2wu8IL/wStINx+jB02bV3LYNB3UdXnxKfKYo
   203yfpex7h2B+nY4CuLjvBef0dDoFncxyR8Qhd+6cFJtJ+UsXIZgLqaS3
   r5D0KTzHmgmrtnyNtXiRrdFtg2pfILvGm8ZPEcymuzS2PXa1kJuExw27t
   qE9u5bK8eLiTFs/rddyas+QWTLT9ZzFxCoLL5O5oqLmGpH27yJA1d+HuL
   wavEcgltO+4J7SbSWbHhFqOXmBoyIlcWUdIGAD9gPaUVX08tOpZpPb11r
   nqQuQdsmdM/ppK7LJdjHFICAMDpMssR5jyKavCc4qLdtDPDEleTCFmIfi
   A==;
X-CSE-ConnectionGUID: CNV7O4mhQsO62rnUXqGSyg==
X-CSE-MsgGUID: 57MSA2txQGy7lRVuwstMmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="45627806"
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="45627806"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 14:51:02 -0700
X-CSE-ConnectionGUID: Vh2TgW3ASniw7TzX1dsz9g==
X-CSE-MsgGUID: AjzxehQ+SmmBijiJph7+mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="128452280"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 09 Apr 2025 14:51:01 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u2dJz-0009M6-0A;
	Wed, 09 Apr 2025 21:50:59 +0000
Date: Thu, 10 Apr 2025 05:50:49 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/drivers] BUILD SUCCESS
 771487050f83b030090079133b192de6e3cf5909
Message-ID: <202504100532.8sFRkOqH-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/drivers
branch HEAD: 771487050f83b030090079133b192de6e3cf5909  genirq/generic-chip: Fix incorrect lock guard conversions

elapsed time: 1474m

configs tested: 89
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250409    gcc-12.4.0
arc                   randconfig-002-20250409    gcc-10.5.0
arm                   randconfig-001-20250409    gcc-7.5.0
arm                   randconfig-002-20250409    gcc-7.5.0
arm                   randconfig-003-20250409    gcc-7.5.0
arm                   randconfig-004-20250409    clang-14
arm64                 randconfig-001-20250409    clang-21
arm64                 randconfig-002-20250409    clang-21
arm64                 randconfig-003-20250409    clang-15
arm64                 randconfig-004-20250409    gcc-6.5.0
csky                  randconfig-001-20250409    gcc-14.2.0
csky                  randconfig-002-20250409    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250409    clang-21
hexagon               randconfig-002-20250409    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250409    gcc-12
i386        buildonly-randconfig-002-20250409    clang-20
i386        buildonly-randconfig-003-20250409    gcc-11
i386        buildonly-randconfig-004-20250409    clang-20
i386        buildonly-randconfig-005-20250409    gcc-12
i386        buildonly-randconfig-006-20250409    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch             randconfig-001-20250409    gcc-14.2.0
loongarch             randconfig-002-20250409    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       m5208evb_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250409    gcc-10.5.0
nios2                 randconfig-002-20250409    gcc-8.5.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                  or1klitex_defconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                randconfig-001-20250409    gcc-13.3.0
parisc                randconfig-002-20250409    gcc-13.3.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250409    gcc-6.5.0
powerpc               randconfig-002-20250409    clang-21
powerpc               randconfig-003-20250409    clang-21
powerpc64             randconfig-001-20250409    clang-21
powerpc64             randconfig-002-20250409    gcc-8.5.0
powerpc64             randconfig-003-20250409    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250409    clang-21
riscv                 randconfig-002-20250409    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250409    gcc-9.3.0
s390                  randconfig-002-20250409    gcc-9.3.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250409    gcc-12.4.0
sh                    randconfig-002-20250409    gcc-12.4.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250409    gcc-13.3.0
sparc                 randconfig-002-20250409    gcc-7.5.0
sparc64               randconfig-001-20250409    gcc-11.5.0
sparc64               randconfig-002-20250409    gcc-13.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250409    gcc-12
um                    randconfig-002-20250409    clang-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250409    clang-20
x86_64      buildonly-randconfig-002-20250409    gcc-12
x86_64      buildonly-randconfig-003-20250409    clang-20
x86_64      buildonly-randconfig-004-20250409    clang-20
x86_64      buildonly-randconfig-005-20250409    gcc-12
x86_64      buildonly-randconfig-006-20250409    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250409    gcc-11.5.0
xtensa                randconfig-002-20250409    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


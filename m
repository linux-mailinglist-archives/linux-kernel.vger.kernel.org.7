Return-Path: <linux-kernel+bounces-728082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FBDB02387
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E213B4077B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEE72AEF1;
	Fri, 11 Jul 2025 18:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VYCHx3yo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFE02F1FF2
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752258125; cv=none; b=obCzVMYrc09wMEqdP727y+vXt6cothIV90d6bjVSDbgfiMoCtlQNZ/WNBjY439eTDDxuz27wMdG/hDjQnBWrrru56dVseNWw1H6hI/BduEO9yE1p4rTsaQ66HScQn+GDzt7UcyfxS6+gxUtsh5PynUtn35Xk+p3ogbYvGV17IXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752258125; c=relaxed/simple;
	bh=D5ImEWmvGQEYgCMDc8LH2KUE2uPMRM+Mu9b5q8O/L2M=;
	h=Date:From:To:Cc:Subject:Message-ID; b=E7vslLzXONkiB4TwG4C7UgjPdyNkmq/OgoaXFihBLWDiuiFhgmlWcACqLNZ/Cl+WZdlFxf68nDJzGafpm62nkTlTuzGqmIjtHlCde7Hu9vQ8+RsuEj7IGtBschXMX1RpTo/QcFftWJd/D7w2uC2iUB0ylIMwyS4d/br0oNYjKlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VYCHx3yo; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752258123; x=1783794123;
  h=date:from:to:cc:subject:message-id;
  bh=D5ImEWmvGQEYgCMDc8LH2KUE2uPMRM+Mu9b5q8O/L2M=;
  b=VYCHx3yoREwH9FaYtjZFBFd8QhLlQp9XHIigjl/co6NUTE7CmCgZn4pj
   3lXhmiaN/AJ770wlABb+C9sKZ1FTtW3kBZyrS5/Gj9mACeIo4MPyHoZiB
   e1o07pOfdZbgRQQ2J2mIUzYRwOJKTAeL1p6zGcLFTyOocYgYtlcnB+Qux
   eyvVSDqDB2cpHNl0x9aNfjV7xbPRf8UtmiOXtt1tppWApTkQrfzW/sE/S
   m7zqSGVLVZbeHXCY8EbTmuAd8jzxYJiLE+tH3whO4wIbwxNR7URbc+nzC
   y7V3Gsc7HKRhhEF59MVtQdaB1zJIk54ITUtbdQxpw4fMY37ZO1k77cnWS
   w==;
X-CSE-ConnectionGUID: pYBqJosUSUi0iXRkFEFLfA==
X-CSE-MsgGUID: BFNumuUgS0GcHNaJ0WkPRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="65912414"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="65912414"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 11:22:02 -0700
X-CSE-ConnectionGUID: 4CVhs+ywTvqUxS3AqZ9i6Q==
X-CSE-MsgGUID: DODl8R4XRrOIW66U5PId5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="161999289"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 11 Jul 2025 11:22:01 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uaINi-0006ef-2Q;
	Fri, 11 Jul 2025 18:21:58 +0000
Date: Sat, 12 Jul 2025 02:21:06 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 a8b289f0f2dcbadd8c207ad8f33cf7ba2b4eb088
Message-ID: <202507120254.rfKBTRgw-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
branch HEAD: a8b289f0f2dcbadd8c207ad8f33cf7ba2b4eb088  irqchip/irq-msi-lib: Fix build with PCI disabled

elapsed time: 1216m

configs tested: 118
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                          axs103_defconfig    gcc-15.1.0
arc                   randconfig-001-20250711    gcc-8.5.0
arc                   randconfig-002-20250711    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                         at91_dt_defconfig    clang-21
arm                     davinci_all_defconfig    clang-19
arm                   randconfig-001-20250711    clang-19
arm                   randconfig-002-20250711    clang-21
arm                   randconfig-003-20250711    gcc-15.1.0
arm                   randconfig-004-20250711    clang-20
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250711    clang-18
arm64                 randconfig-002-20250711    clang-21
arm64                 randconfig-003-20250711    gcc-12.3.0
arm64                 randconfig-004-20250711    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250711    gcc-14.3.0
csky                  randconfig-002-20250711    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250711    clang-19
hexagon               randconfig-002-20250711    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250711    gcc-12
i386        buildonly-randconfig-002-20250711    gcc-12
i386        buildonly-randconfig-003-20250711    clang-20
i386        buildonly-randconfig-004-20250711    clang-20
i386        buildonly-randconfig-005-20250711    gcc-11
i386        buildonly-randconfig-006-20250711    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch             randconfig-001-20250711    clang-21
loongarch             randconfig-002-20250711    clang-21
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                          multi_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250711    gcc-10.5.0
nios2                 randconfig-002-20250711    gcc-14.2.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250711    gcc-12.4.0
parisc                randconfig-002-20250711    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                      mgcoge_defconfig    clang-21
powerpc               randconfig-001-20250711    clang-18
powerpc               randconfig-002-20250711    clang-21
powerpc               randconfig-003-20250711    clang-21
powerpc                     skiroot_defconfig    clang-21
powerpc64             randconfig-001-20250711    clang-21
powerpc64             randconfig-002-20250711    clang-21
powerpc64             randconfig-003-20250711    gcc-13.4.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250711    gcc-8.5.0
riscv                 randconfig-002-20250711    gcc-12.4.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250711    clang-21
s390                  randconfig-002-20250711    gcc-10.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250711    gcc-12.4.0
sh                    randconfig-002-20250711    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250711    gcc-10.3.0
sparc                 randconfig-002-20250711    gcc-12.4.0
sparc64               randconfig-001-20250711    gcc-8.5.0
sparc64               randconfig-002-20250711    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250711    clang-20
um                    randconfig-002-20250711    clang-19
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250711    clang-20
x86_64      buildonly-randconfig-002-20250711    clang-20
x86_64      buildonly-randconfig-003-20250711    clang-20
x86_64      buildonly-randconfig-004-20250711    gcc-12
x86_64      buildonly-randconfig-005-20250711    clang-20
x86_64      buildonly-randconfig-006-20250711    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250711    gcc-9.3.0
xtensa                randconfig-002-20250711    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


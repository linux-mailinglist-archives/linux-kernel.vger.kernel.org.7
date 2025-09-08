Return-Path: <linux-kernel+bounces-805136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95411B4846B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ADE5162FE8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 06:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE4D2DF707;
	Mon,  8 Sep 2025 06:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oBgIuiRJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9495122B8B6
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 06:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757314083; cv=none; b=Gd3tqVdp2GIR4+ALbpGN5QR0OZmP/Cj+xr50TI2VdCcjJUbkb2xDfNAem8mgBPsru3K7HJqRh8uW4OO0DGLvILiO0ygNsVKho1eTzt8nJN0tdFraeR2q0oOMlGiEZ2lwGHHB5Fv4wKEMy0glOz6TqOx//kRf3sT4ilTagJEP/eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757314083; c=relaxed/simple;
	bh=yfJ4Lpp5rGJomkdYDStA/bfcRNIbak3BeJUPRuyHxx0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DbP9tOhpffXN/qM/dkDqnjiBgj+BsOhIXBeOBixQ7NQ70GrM6wU6mG3A0LLwkmqaPrcJg1RG5wiunyPUDjllvxAnrvZK5ZWGQN3rxMs+UVZ07QVcm1BcS4LyI0LoWZm5TKopOwo+Gk3f9e35gyGRHd+mcQqcGJkeRAsbYLrWGmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oBgIuiRJ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757314081; x=1788850081;
  h=date:from:to:cc:subject:message-id;
  bh=yfJ4Lpp5rGJomkdYDStA/bfcRNIbak3BeJUPRuyHxx0=;
  b=oBgIuiRJaFT6zFA//DZl0MaLIhovcEJtXsRBe8Q9UCsThOgGmwft9cjM
   N04B01W114dmr+qLCXGAIErKgC4Ir9pLJVUll2TPwbOq8RpmVuA65zKMS
   m0l3NQxf9RU9fGBDvB7dKGiR5gm/FWwD9qwTA8i8QisWqh8pttmxv1POz
   uxwpsK564e2fpQ6laCW52L4FUSABl+p+oTbhVIvW1pCmMlHN5NoHJmXxQ
   yy1wlj4EIWNhCKe7mOjEjM8EQWVPrmMnvAXyJ4pyTvHvJPIgGQ99ygt6E
   KXZdh3YAIeIbe6is9J8/BiGyAIdxBrQk8Z/yJB294RnjFSD/SvfsyCBoL
   g==;
X-CSE-ConnectionGUID: GJMdQJc5Q52Xza6DKWzYIQ==
X-CSE-MsgGUID: ME0NGAhEQDqn4fy4o/GU5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="63390956"
X-IronPort-AV: E=Sophos;i="6.18,247,1751266800"; 
   d="scan'208";a="63390956"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 23:48:01 -0700
X-CSE-ConnectionGUID: aYj5u7vKT4+SHEVm0tuWyA==
X-CSE-MsgGUID: K2kE5zzqR8WMFS7bFarmLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,247,1751266800"; 
   d="scan'208";a="203498305"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 07 Sep 2025 23:47:59 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uvVfR-0003ab-1V;
	Mon, 08 Sep 2025 06:47:57 +0000
Date: Mon, 08 Sep 2025 14:47:47 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:tip/urgent] BUILD SUCCESS
 0d084e56668432a12ed7db9594fc31f6a9bba8c5
Message-ID: <202509081434.qMtVIU8z-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tip/urgent
branch HEAD: 0d084e56668432a12ed7db9594fc31f6a9bba8c5  Merge branch into tip/master: 'timers/urgent'

elapsed time: 1151m

configs tested: 122
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250907    gcc-8.5.0
arc                   randconfig-002-20250907    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                     am200epdkit_defconfig    gcc-15.1.0
arm                        multi_v7_defconfig    gcc-15.1.0
arm                   randconfig-001-20250907    gcc-8.5.0
arm                   randconfig-002-20250907    clang-22
arm                   randconfig-003-20250907    clang-22
arm                   randconfig-004-20250907    gcc-10.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250907    clang-22
arm64                 randconfig-002-20250907    gcc-14.3.0
arm64                 randconfig-003-20250907    clang-22
arm64                 randconfig-004-20250907    gcc-9.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250908    gcc-14.3.0
csky                  randconfig-002-20250908    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250908    clang-17
hexagon               randconfig-002-20250908    clang-20
i386                             allmodconfig    gcc-13
i386                              allnoconfig    gcc-13
i386                             allyesconfig    gcc-13
i386        buildonly-randconfig-001-20250907    clang-20
i386        buildonly-randconfig-002-20250907    clang-20
i386        buildonly-randconfig-003-20250907    gcc-13
i386        buildonly-randconfig-004-20250907    clang-20
i386        buildonly-randconfig-005-20250907    clang-20
i386        buildonly-randconfig-006-20250907    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250908    gcc-15.1.0
loongarch             randconfig-002-20250908    clang-18
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                        m5272c3_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250908    gcc-8.5.0
nios2                 randconfig-002-20250908    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
openrisc                 simple_smp_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250908    gcc-13.4.0
parisc                randconfig-002-20250908    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                 canyonlands_defconfig    clang-22
powerpc                     mpc5200_defconfig    clang-22
powerpc               randconfig-001-20250908    gcc-15.1.0
powerpc               randconfig-002-20250908    clang-19
powerpc               randconfig-003-20250908    gcc-9.5.0
powerpc64             randconfig-001-20250908    gcc-8.5.0
powerpc64             randconfig-002-20250908    gcc-10.5.0
powerpc64             randconfig-003-20250908    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250907    clang-22
riscv                 randconfig-002-20250907    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250907    gcc-8.5.0
s390                  randconfig-002-20250907    gcc-14.3.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250907    gcc-12.5.0
sh                    randconfig-002-20250907    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250907    gcc-13.4.0
sparc                 randconfig-002-20250907    gcc-15.1.0
sparc64               randconfig-001-20250907    gcc-12.5.0
sparc64               randconfig-002-20250907    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-13
um                    randconfig-001-20250907    gcc-13
um                    randconfig-002-20250907    gcc-13
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250907    gcc-13
x86_64      buildonly-randconfig-002-20250907    clang-20
x86_64      buildonly-randconfig-003-20250907    gcc-13
x86_64      buildonly-randconfig-004-20250907    gcc-13
x86_64      buildonly-randconfig-005-20250907    gcc-13
x86_64      buildonly-randconfig-006-20250907    gcc-13
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                          iss_defconfig    gcc-15.1.0
xtensa                randconfig-001-20250907    gcc-10.5.0
xtensa                randconfig-002-20250907    gcc-9.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


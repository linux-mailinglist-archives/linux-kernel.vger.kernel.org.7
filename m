Return-Path: <linux-kernel+bounces-809908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA67B5135F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68AA51888AAE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617FF3128B6;
	Wed, 10 Sep 2025 10:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WShEHeX2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6241DFF7
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757498403; cv=none; b=FluOLCUplQbAPfw+hwWyu77wk3m6BoRXAKmaWMFTw5KUU31Kj0f3fGl+AxG8Oepmsp4cJL29cSqazL9manZyHsOJd/7Mfqdqr4pH6LsHE7qekl0sPJkyC4GlzytsRLuSB1cIbTbTrmEQ6ZyiZ36kUbyRlgwagmRUHkpLhUElyi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757498403; c=relaxed/simple;
	bh=nbcH9bX0Ttssp7R8YBSXa2cSjCct+na91q1wzR6d9vs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=oKMVRu/ryj3CCy1tgJVyt8De9cUCge50FechF8I+7Fn4Pf1K5zrqp+3OtrAnGrWe88DlXBMEiVdt6ACspN8g4oLCfNGPUmJcfrLEft7ud/OJ2JpiEk5csEQrhfk9nvEAA7+NizTq65iGSwc5uEjc3622UnKcSwTW1AmMKe627tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WShEHeX2; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757498401; x=1789034401;
  h=date:from:to:cc:subject:message-id;
  bh=nbcH9bX0Ttssp7R8YBSXa2cSjCct+na91q1wzR6d9vs=;
  b=WShEHeX2CkzVcd/aYyVv6qLTgdCNi1z7DDra+bG0BZItcFQhmdCnEmWZ
   45DUXcTQEbQYUVdeQooEsRJ0lJv4rbz94RKRsPrfCz1NdPhWH8zBuj5K+
   oFLsdQN3x8TeClduvsU5GSCPmt9PTLOkYkM8fzJdFAZweEVRLbbE3RSlx
   W6I92VAtZmpr+P2THSHz0wI2NHcjPvWFY+K5QhPcWwB10NpjlnZbj+n7u
   qHzbywXqf7qxU5MiZR6hdfo6qzP5MefzZQDG8qjI9FMnmXepnvdrviGuB
   6y9lPdYgibOMy+DEXr4zXCN9OUt456Ug6awmNQ+WIsJWEf5wddj8G9UZo
   A==;
X-CSE-ConnectionGUID: 0EnQx/+NSIeBueXi7LK/+A==
X-CSE-MsgGUID: hO7T5b3ZThin7IXMtvh4Ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59866498"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59866498"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 03:00:01 -0700
X-CSE-ConnectionGUID: QHWWIz6YQM6R0XsCqRcspQ==
X-CSE-MsgGUID: ajGtKjGbSz+cut3+xd5geA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="172637492"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 10 Sep 2025 03:00:00 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uwHcL-0005o9-1S;
	Wed, 10 Sep 2025 09:59:57 +0000
Date: Wed, 10 Sep 2025 17:59:47 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/vdso] BUILD SUCCESS
 e82bf7570d5ca3667a9038a3c5a42d451b949d89
Message-ID: <202509101737.pWTGy0aS-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/vdso
branch HEAD: e82bf7570d5ca3667a9038a3c5a42d451b949d89  selftests: vDSO: Drop vdso_test_clock_getres

elapsed time: 1452m

configs tested: 116
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                          axs101_defconfig    gcc-15.1.0
arc                   randconfig-001-20250909    gcc-8.5.0
arc                   randconfig-002-20250909    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                   randconfig-001-20250909    clang-18
arm                   randconfig-002-20250909    clang-17
arm                   randconfig-003-20250909    clang-22
arm                   randconfig-004-20250909    clang-19
arm                           spitz_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250909    clang-16
arm64                 randconfig-002-20250909    gcc-11.5.0
arm64                 randconfig-003-20250909    gcc-11.5.0
arm64                 randconfig-004-20250909    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250909    gcc-15.1.0
csky                  randconfig-002-20250909    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250909    clang-22
hexagon               randconfig-002-20250909    clang-22
i386        buildonly-randconfig-001-20250909    gcc-13
i386        buildonly-randconfig-002-20250909    clang-20
i386        buildonly-randconfig-003-20250909    clang-20
i386        buildonly-randconfig-004-20250909    clang-20
i386        buildonly-randconfig-005-20250909    clang-20
i386        buildonly-randconfig-006-20250909    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250909    gcc-15.1.0
loongarch             randconfig-002-20250909    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                        m5307c3_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250909    gcc-11.5.0
nios2                 randconfig-002-20250909    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           alldefconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250909    gcc-8.5.0
parisc                randconfig-002-20250909    gcc-12.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                        cell_defconfig    gcc-15.1.0
powerpc                    ge_imp3a_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250909    clang-22
powerpc               randconfig-002-20250909    clang-17
powerpc               randconfig-003-20250909    gcc-8.5.0
powerpc64             randconfig-001-20250909    clang-20
powerpc64             randconfig-002-20250909    gcc-10.5.0
powerpc64             randconfig-003-20250909    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250909    clang-22
riscv                 randconfig-002-20250909    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250909    gcc-11.5.0
s390                  randconfig-002-20250909    clang-18
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250909    gcc-15.1.0
sh                    randconfig-002-20250909    gcc-9.5.0
sh                        sh7785lcr_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250909    gcc-8.5.0
sparc                 randconfig-002-20250909    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250909    clang-22
sparc64               randconfig-002-20250909    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250909    gcc-14
um                    randconfig-002-20250909    gcc-14
um                           x86_64_defconfig    clang-22
x86_64      buildonly-randconfig-001-20250909    clang-20
x86_64      buildonly-randconfig-002-20250909    clang-20
x86_64      buildonly-randconfig-003-20250909    gcc-14
x86_64      buildonly-randconfig-004-20250909    clang-20
x86_64      buildonly-randconfig-005-20250909    gcc-14
x86_64      buildonly-randconfig-006-20250909    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250909    gcc-8.5.0
xtensa                randconfig-002-20250909    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-kernel+bounces-757543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87814B1C36B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DD45163474
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D90D276023;
	Wed,  6 Aug 2025 09:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Av2aiihN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D732B2D7
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 09:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754472855; cv=none; b=lmIH1hA36jkWjMk52nEBNryrdNADI1wuxIqXMl5GmKbK717NjLZrtBtmzbTA5ANt5EdcziZ+iYT9UpNTRig2wiIfwvgD7oGzpqOrYZaXMlxyDgpW9g4qumluYFnuMSn+Fp/P6maTEW4DDeErrOtpa27sZhzGFMDT6PPdPZzvDq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754472855; c=relaxed/simple;
	bh=vQC8QnkJcS5/urxCod+6ADkHiMjwAZHuJsVKDc3N5kw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=e7704AuHaE4Wfe6Sfoswt7u4xj8PP5xTA7lOV2jt7TkfWa7tGPs8EkP5VIewRBAapvVTkwc0pvb8qiS1avE1SsdThHPfNbajYsKIYOtUBnFUZx5ihLH6NSNZviOdVQo4aqRvevNCI+2TGWW6EznL7hbgjhXI2jDC8WdLU4JB0uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Av2aiihN; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754472850; x=1786008850;
  h=date:from:to:cc:subject:message-id;
  bh=vQC8QnkJcS5/urxCod+6ADkHiMjwAZHuJsVKDc3N5kw=;
  b=Av2aiihNLWZb/Zh+bsa2n+tShEb8a/tbfkSfVFvIRlwShPfM915gg1QE
   ZpoYC2LbWMA4ckmBQtGowc3PJHYCIJAN6fop1nLm34BDnSFYj9g1pRLrv
   S1fsynPSKBzuRF9qQIkRHyMbfCJM3FUUnmrIPJnwJI1t2Ot0H0581btDI
   g6TnH6UXNm8m63fHhrDySpYZPeMfdnsnLbsfthi/e01u69poVz0qNR/Pq
   E9GvXpAqQxNUajcm8Dy4lQIs3w3rxGdA/jc7NOWLOTz/+SuCK2PUcbY1k
   O6PiZfsqcSpSENwJiSSS0vq+VDXYYVByEP/5E5OXMFiod4tEG9KMht1hB
   A==;
X-CSE-ConnectionGUID: A1nRlCBwT8uuasjMSl+GNQ==
X-CSE-MsgGUID: /5m4tpaOR+eGuG6nmNIrjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="68234356"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="68234356"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 02:34:10 -0700
X-CSE-ConnectionGUID: GugF/JpVQwmV5TCBdRJDPA==
X-CSE-MsgGUID: xqbkcCFtQMChY774caaG7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="168905532"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 06 Aug 2025 02:34:09 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ujaWq-0001Tg-15;
	Wed, 06 Aug 2025 09:33:54 +0000
Date: Wed, 06 Aug 2025 17:32:53 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:core/bugs] BUILD SUCCESS
 a53d0cf7f1cb3182ad533ff5cacfa5fd29c419ad
Message-ID: <202508061743.agRpd89j-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/bugs
branch HEAD: a53d0cf7f1cb3182ad533ff5cacfa5fd29c419ad  Merge commit 'linus' into core/bugs, to resolve conflicts

elapsed time: 1441m

configs tested: 136
configs skipped: 6

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
arc                   randconfig-001-20250805    gcc-8.5.0
arc                   randconfig-002-20250805    gcc-10.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                          collie_defconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                           omap1_defconfig    gcc-15.1.0
arm                   randconfig-001-20250805    gcc-11.5.0
arm                   randconfig-002-20250805    clang-22
arm                   randconfig-003-20250805    gcc-12.5.0
arm                   randconfig-004-20250805    clang-18
arm                       versatile_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250805    gcc-12.5.0
arm64                 randconfig-002-20250805    clang-20
arm64                 randconfig-003-20250805    gcc-11.5.0
arm64                 randconfig-004-20250805    gcc-13.4.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250805    gcc-12.5.0
csky                  randconfig-002-20250805    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20250805    clang-20
hexagon               randconfig-002-20250805    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386        buildonly-randconfig-001-20250805    clang-20
i386        buildonly-randconfig-002-20250805    gcc-12
i386        buildonly-randconfig-003-20250805    gcc-12
i386        buildonly-randconfig-004-20250805    gcc-12
i386        buildonly-randconfig-005-20250805    gcc-12
i386        buildonly-randconfig-006-20250805    gcc-12
i386                                defconfig    clang-20
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250805    gcc-15.1.0
loongarch             randconfig-002-20250805    gcc-12.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                         bigsur_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250805    gcc-11.5.0
nios2                 randconfig-002-20250805    gcc-8.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250805    gcc-10.5.0
parisc                randconfig-002-20250805    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                     ppa8548_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250805    clang-22
powerpc               randconfig-002-20250805    clang-22
powerpc               randconfig-003-20250805    gcc-9.5.0
powerpc                        warp_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250805    clang-22
powerpc64             randconfig-002-20250805    clang-19
powerpc64             randconfig-003-20250805    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250805    clang-18
riscv                 randconfig-002-20250805    gcc-9.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250805    clang-22
s390                  randconfig-002-20250805    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250805    gcc-9.5.0
sh                    randconfig-002-20250805    gcc-14.3.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250805    gcc-8.5.0
sparc                 randconfig-002-20250805    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250805    gcc-9.5.0
sparc64               randconfig-002-20250805    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250805    gcc-12
um                    randconfig-002-20250805    gcc-12
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250805    gcc-12
x86_64      buildonly-randconfig-002-20250805    gcc-12
x86_64      buildonly-randconfig-003-20250805    clang-20
x86_64      buildonly-randconfig-004-20250805    gcc-12
x86_64      buildonly-randconfig-005-20250805    clang-20
x86_64      buildonly-randconfig-006-20250805    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                generic_kc705_defconfig    gcc-15.1.0
xtensa                randconfig-001-20250805    gcc-14.3.0
xtensa                randconfig-002-20250805    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-kernel+bounces-822475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8260DB83F8F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1156F1C07372
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B7A2BEFFE;
	Thu, 18 Sep 2025 10:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZwZIiM3T"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED4A2727EB
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190308; cv=none; b=GQTM65uKSN92KAuvn0jYpwU477xXcPOhs6l1/CKYHqID5jsUSOeubyLJROvVCMktKp5vvH/E/P3kLNkhcMeicdPG723mGYVS9gobldAcqScIzrQpfJ1lnjK4s46+bPyqItAXVzvL66uccu9yX+UIMj815Ga5h/zxZCTIxRtiBOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190308; c=relaxed/simple;
	bh=oxjefNDjnmjJFZJuuL4CYoAYe3KkSHFIbhkW/rROcn8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=t6jKY82m1A3pOZV4xGaTMe6CVTRUvlf9SnMqJSDDDzSY513J/29oSc0xwys3LRz5ROBttix79g4q4ygj2EjfNl2u8ZXdbb/ZndG5XRSQbKbsU02q9VsAGm9YNWt8sWtpd4uE4N7lK36xjWftSNd35y1uPpILgQ2Ye7q5RS28tOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZwZIiM3T; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758190307; x=1789726307;
  h=date:from:to:cc:subject:message-id;
  bh=oxjefNDjnmjJFZJuuL4CYoAYe3KkSHFIbhkW/rROcn8=;
  b=ZwZIiM3T+PAlBRp9zCVyTbAEvHgHxOd5fq2+meuQUqmUgAH2Adue0M7i
   UDrBQSeZ3ij6akB11RyusVk2edO+U3zvW/CKl9PvMk+AptfRW7S9o8iCl
   +wNej/BCrvtwUAZs2LdvNE9Z/5OqPqIMjr5fn4+T0AUv+ChKp/PJwVAhT
   b8acwVL/+pfeTFWfBgjcVUqCsLhez1tjesC88BfdPkG5at8jbwxOzBAQa
   kg9empxdgcXhyWi5+UaKJhCD180i7WuDtrlDpF91IK6OSg0Dt0Jwq1BWa
   JipQhETzCuLtYbCtcIMC4Svxc+us8ODR+KwvM/VP/1dc0c2kLMFcplTL9
   g==;
X-CSE-ConnectionGUID: cHV3b946Rty4ZwtohhI+fg==
X-CSE-MsgGUID: iMfzpB9yRkixkqjw2NDS3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="63143217"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="63143217"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 03:11:45 -0700
X-CSE-ConnectionGUID: MFehyTZYRoS+6f2eGelJcg==
X-CSE-MsgGUID: Ju/+rVjASiSorpLBB+DqrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="180779191"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 18 Sep 2025 03:11:43 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uzBc5-000367-2h;
	Thu, 18 Sep 2025 10:11:41 +0000
Date: Thu, 18 Sep 2025 18:10:42 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cache] BUILD SUCCESS
 dd86b69d20fb9fa7e941ed01ff05f1e662fcc3ff
Message-ID: <202509181836.II3sDBcc-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cache
branch HEAD: dd86b69d20fb9fa7e941ed01ff05f1e662fcc3ff  fs/resctrl: Fix counter auto-assignment on mkdir with mbm_event enabled

elapsed time: 1455m

configs tested: 114
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                      axs103_smp_defconfig    gcc-15.1.0
arc                   randconfig-001-20250917    gcc-8.5.0
arc                   randconfig-002-20250917    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                        keystone_defconfig    gcc-15.1.0
arm                   randconfig-001-20250917    clang-22
arm                   randconfig-002-20250917    gcc-12.5.0
arm                   randconfig-003-20250917    gcc-10.5.0
arm                   randconfig-004-20250917    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250917    clang-22
arm64                 randconfig-002-20250917    clang-19
arm64                 randconfig-003-20250917    gcc-10.5.0
arm64                 randconfig-004-20250917    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250917    gcc-12.5.0
csky                  randconfig-002-20250917    gcc-9.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250917    clang-22
hexagon               randconfig-002-20250917    clang-22
i386        buildonly-randconfig-001-20250917    gcc-14
i386        buildonly-randconfig-002-20250917    clang-20
i386        buildonly-randconfig-003-20250917    gcc-14
i386        buildonly-randconfig-004-20250917    gcc-14
i386        buildonly-randconfig-005-20250917    gcc-14
i386        buildonly-randconfig-006-20250917    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250917    gcc-15.1.0
loongarch             randconfig-002-20250917    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                          amiga_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           ip22_defconfig    gcc-15.1.0
mips                           ip27_defconfig    gcc-15.1.0
mips                        qi_lb60_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250917    gcc-11.5.0
nios2                 randconfig-002-20250917    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250917    gcc-14.3.0
parisc                randconfig-002-20250917    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250917    clang-18
powerpc               randconfig-002-20250917    clang-22
powerpc               randconfig-003-20250917    gcc-9.5.0
powerpc64             randconfig-001-20250917    clang-19
powerpc64             randconfig-002-20250917    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250917    gcc-14.3.0
riscv                 randconfig-002-20250917    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250917    clang-22
s390                  randconfig-002-20250917    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                        edosk7705_defconfig    gcc-15.1.0
sh                    randconfig-001-20250917    gcc-14.3.0
sh                    randconfig-002-20250917    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250917    gcc-8.5.0
sparc                 randconfig-002-20250917    gcc-14.3.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250917    gcc-11.5.0
sparc64               randconfig-002-20250917    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250917    gcc-14
um                    randconfig-002-20250917    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20250917    gcc-14
x86_64      buildonly-randconfig-002-20250917    clang-20
x86_64      buildonly-randconfig-003-20250917    clang-20
x86_64      buildonly-randconfig-004-20250917    clang-20
x86_64      buildonly-randconfig-005-20250917    clang-20
x86_64      buildonly-randconfig-006-20250917    gcc-12
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250917    gcc-8.5.0
xtensa                randconfig-002-20250917    gcc-11.5.0
xtensa                    xip_kc705_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


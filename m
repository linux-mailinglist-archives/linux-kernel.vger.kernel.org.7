Return-Path: <linux-kernel+bounces-856341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 400C7BE3E9F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 275174FDE24
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DC833CEBB;
	Thu, 16 Oct 2025 14:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c4z3Tnx8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588D41D54FA
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760625049; cv=none; b=aV71yhbJdbdZtFDO+4mNDD4Dm1MRtdjhuTIMvlarTuaUA9wM7GTQ1vTdYK7yI5USuDUcEhDGPN0XhdblKZkSzBOUbdMGO3IcgVwzx0NAkBIvudf1eZyH+1XMbuK9zBhjljB+36ahvYr/yt4RJKn781gYD9EsrP2qK6dV/ybSyEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760625049; c=relaxed/simple;
	bh=eva6UsqOKMkiJ3Jucx4zIEf1xSWjFiHSw3IWWTdXD5g=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mjwZjr83b3QC37ddt/nHIMxNOW5avIfIHxj7CWdXKwtYVDwAEVNMDinonZ1Uw1xjcdq2X4eNzW7ulyru4qWD1m2XcL56ujGp8TZA+ZOXhNHKhjCMITTumtuscSHhbab3tTE+w89+LwOhoP9QddrMLg57lgk0pRcK7dD1++PY0yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c4z3Tnx8; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760625047; x=1792161047;
  h=date:from:to:cc:subject:message-id;
  bh=eva6UsqOKMkiJ3Jucx4zIEf1xSWjFiHSw3IWWTdXD5g=;
  b=c4z3Tnx8zambpAS3ASXxWrLtTYTNcevSitvGTlnkVmqlt2mYl6/c9S82
   gThmGWt8NkSDKl+rI8fhY2GoWvm8eiW8pOMGhXLk57dIEH7rzoaqsEYDB
   4KhaZCpYFDk/akhn7FftxUiT3LsuLnteJABzzur/L5Cm9nzmL0dhX6d4b
   UO3M4UBKu0fVMh/BcRb/5XMxFfCqYQydhDGnJfICzMoOCIhLX7Qvoyd9S
   cOfxO6Q5LlgVp8ln2E5IMW4ZjG7Ndd4dJ/5x5eJW9FbtL88yodeE35qR3
   nqbnTumrYvfcumELURMAEomMMLoXhMG4lVQvx2U+kk19fdsKVC0VjO3t4
   Q==;
X-CSE-ConnectionGUID: 2wS/mxNNQTy5oI8LdXPy5A==
X-CSE-MsgGUID: xdITYzYoRO+60u9eiGBaWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="61848460"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="61848460"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 07:30:47 -0700
X-CSE-ConnectionGUID: +bfVP8xISeytl03Uox3KjQ==
X-CSE-MsgGUID: FPVnoIq8RbeG9X5xW1Y8WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="182149023"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 16 Oct 2025 07:30:46 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9P07-0004tx-2C;
	Thu, 16 Oct 2025 14:30:43 +0000
Date: Thu, 16 Oct 2025 22:29:49 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/microcode] BUILD SUCCESS
 bffeb2fd0b9c99d8af348da88335bff408c63882
Message-ID: <202510162243.fiwG0TdV-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/microcode
branch HEAD: bffeb2fd0b9c99d8af348da88335bff408c63882  x86/microcode/intel: Enable staging when available

elapsed time: 1283m

configs tested: 166
configs skipped: 120

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                            allyesconfig    clang-19
alpha                               defconfig    clang-19
arc                               allnoconfig    clang-22
arc                                 defconfig    clang-19
arc                   randconfig-001-20251016    clang-22
arc                   randconfig-002-20251016    clang-22
arm                               allnoconfig    clang-22
arm                                 defconfig    clang-19
arm                          pxa3xx_defconfig    gcc-15.1.0
arm                   randconfig-001-20251016    clang-22
arm                   randconfig-002-20251016    clang-22
arm                   randconfig-003-20251016    clang-22
arm                   randconfig-004-20251016    clang-22
arm                       spear13xx_defconfig    gcc-15.1.0
arm                           sunxi_defconfig    gcc-15.1.0
arm64                             allnoconfig    clang-22
arm64                               defconfig    clang-19
arm64                 randconfig-001-20251016    clang-22
arm64                 randconfig-002-20251016    clang-22
arm64                 randconfig-003-20251016    clang-22
arm64                 randconfig-004-20251016    clang-22
csky                              allnoconfig    clang-22
csky                                defconfig    clang-19
csky                  randconfig-001-20251016    clang-22
csky                  randconfig-002-20251016    clang-22
hexagon                          alldefconfig    gcc-15.1.0
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20251016    clang-22
hexagon               randconfig-002-20251016    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251016    clang-20
i386        buildonly-randconfig-002-20251016    clang-20
i386        buildonly-randconfig-002-20251016    gcc-14
i386        buildonly-randconfig-003-20251016    clang-20
i386        buildonly-randconfig-004-20251016    clang-20
i386        buildonly-randconfig-005-20251016    clang-20
i386        buildonly-randconfig-006-20251016    clang-20
i386        buildonly-randconfig-006-20251016    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251016    clang-20
i386                  randconfig-002-20251016    clang-20
i386                  randconfig-003-20251016    clang-20
i386                  randconfig-004-20251016    clang-20
i386                  randconfig-005-20251016    clang-20
i386                  randconfig-006-20251016    clang-20
i386                  randconfig-007-20251016    clang-20
i386                  randconfig-011-20251016    gcc-14
i386                  randconfig-012-20251016    gcc-14
i386                  randconfig-013-20251016    gcc-14
i386                  randconfig-014-20251016    gcc-14
i386                  randconfig-015-20251016    gcc-14
i386                  randconfig-016-20251016    gcc-14
i386                  randconfig-017-20251016    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251016    clang-22
loongarch             randconfig-002-20251016    clang-22
m68k                             allmodconfig    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                                defconfig    clang-19
m68k                          sun3x_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20251016    clang-22
nios2                 randconfig-002-20251016    clang-22
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-14
parisc                            allnoconfig    clang-22
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251016    clang-22
parisc                randconfig-002-20251016    clang-22
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc               randconfig-001-20251016    clang-22
powerpc               randconfig-002-20251016    clang-22
powerpc               randconfig-003-20251016    clang-22
powerpc64             randconfig-002-20251016    clang-22
powerpc64             randconfig-003-20251016    clang-22
riscv                             allnoconfig    clang-22
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20251016    gcc-10.5.0
riscv                 randconfig-002-20251016    gcc-10.5.0
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20251016    gcc-10.5.0
s390                  randconfig-002-20251016    gcc-10.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20251016    gcc-10.5.0
sh                    randconfig-002-20251016    gcc-10.5.0
sh                             sh03_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251016    gcc-10.5.0
sparc                 randconfig-002-20251016    gcc-10.5.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251016    gcc-10.5.0
sparc64               randconfig-002-20251016    gcc-10.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251016    gcc-10.5.0
um                    randconfig-002-20251016    gcc-10.5.0
um                           x86_64_defconfig    gcc-14
um                           x86_64_defconfig    gcc-15.1.0
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251016    clang-20
x86_64      buildonly-randconfig-001-20251016    gcc-12
x86_64      buildonly-randconfig-002-20251016    gcc-12
x86_64      buildonly-randconfig-002-20251016    gcc-14
x86_64      buildonly-randconfig-003-20251016    gcc-12
x86_64      buildonly-randconfig-003-20251016    gcc-14
x86_64      buildonly-randconfig-004-20251016    gcc-12
x86_64      buildonly-randconfig-005-20251016    gcc-12
x86_64      buildonly-randconfig-005-20251016    gcc-14
x86_64      buildonly-randconfig-006-20251016    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251016    clang-20
x86_64                randconfig-002-20251016    clang-20
x86_64                randconfig-003-20251016    clang-20
x86_64                randconfig-004-20251016    clang-20
x86_64                randconfig-005-20251016    clang-20
x86_64                randconfig-006-20251016    clang-20
x86_64                randconfig-007-20251016    clang-20
x86_64                randconfig-008-20251016    clang-20
x86_64                randconfig-071-20251016    gcc-14
x86_64                randconfig-072-20251016    gcc-14
x86_64                randconfig-073-20251016    gcc-14
x86_64                randconfig-074-20251016    gcc-14
x86_64                randconfig-075-20251016    gcc-14
x86_64                randconfig-076-20251016    gcc-14
x86_64                randconfig-077-20251016    gcc-14
x86_64                randconfig-078-20251016    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251016    gcc-10.5.0
xtensa                randconfig-002-20251016    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


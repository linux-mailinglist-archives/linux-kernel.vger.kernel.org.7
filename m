Return-Path: <linux-kernel+bounces-886141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 818DEC34D4C
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 10:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BECF7562E13
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 09:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F3230AADC;
	Wed,  5 Nov 2025 09:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RTIxZP9Z"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996F52FDC35
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 09:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334382; cv=none; b=PsDQrPkmXaaWOQd9nQ2IAW35skO4dj/Vki8XSCGtPHtv2f9wnwoYt0lHBWARMbpIVMfyUmb458WHeUf6HnK9On9MbdkPzNb5y8KvpD7rDd6vKVV82PWmJ448VcYkj1sZ9/JhC7dryuCprAP3LXLgVCo3SwSwMwr03j+0cBYWwMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334382; c=relaxed/simple;
	bh=V42QtcJZ8FUh072qTDf/D7Guy0ATAyEhatPFCG+jmxg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=E2VrrRWlGOYQHZP5ggXM4CUoGgOMgvo/BliCdppkEBIf2S9aARP9b3qFQD2U3pXAzFY8GWV19EkrIgqUNdCUxqK3i2npCJvjWqZcblktQ1ruhgd0F/6wxeR8nMu3InLB8L7zEtIcRleHNKAbCmiKXDbvKZqz7SuQ43ReyyUCoCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RTIxZP9Z; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762334379; x=1793870379;
  h=date:from:to:cc:subject:message-id;
  bh=V42QtcJZ8FUh072qTDf/D7Guy0ATAyEhatPFCG+jmxg=;
  b=RTIxZP9ZqwatqQBzCnBoZ8TymglIB0a8/RvZ2C0XC6okDFB1HDQpmXYJ
   Z53CduG4FzV8YbjtggYwy028ELQtaQXmrBin2xGTfzXV1ZQU05vUEvh1D
   01u3jrbagKQ6Qu5V/pDlVvnk9lYYatrMyzkUvV4TEkVHy//uuNNkFZu8o
   7vzkGTBzSKxNFrQAUFu1OKlacCoBxej8qdx/D1ZeXzYUldhQdXtE4XDAf
   UHSAY+6Jj+Bg/LhQ2gtieWsInGPRJqjWEd6CoFoHgiW0qJJpTVItEELDK
   3Ex3GJ3+lXY5rUrrvKYglctf0tkyH9ky53tpUrVXOjoPAA+imT3mBPPV9
   Q==;
X-CSE-ConnectionGUID: fmDltrOKQouORTIDo8WvdQ==
X-CSE-MsgGUID: iDHw8i4PTbiWBC2h1pyCDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="64474714"
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="64474714"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 01:19:38 -0800
X-CSE-ConnectionGUID: 5N4ATGe4Tgq2T7CtL3ggHQ==
X-CSE-MsgGUID: RAm4ZjBmTreRzfkTo9aMrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="188129454"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 05 Nov 2025 01:19:37 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGZfy-000SMK-1v;
	Wed, 05 Nov 2025 09:19:34 +0000
Date: Wed, 05 Nov 2025 17:19:21 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:core/rseq] BUILD SUCCESS
 1fe4002cf7f23d70c79bda429ca2a9423ebcfdfa
Message-ID: <202511051716.3YBxhNhb-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/rseq
branch HEAD: 1fe4002cf7f23d70c79bda429ca2a9423ebcfdfa  x86/ptrace: Always inline trivial accessors

elapsed time: 1474m

configs tested: 118
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                     nsimosci_hs_defconfig    gcc-15.1.0
arc                   randconfig-001-20251105    gcc-8.5.0
arc                   randconfig-002-20251105    gcc-13.4.0
arm                               allnoconfig    clang-22
arm                                 defconfig    clang-22
arm                          pxa168_defconfig    clang-19
arm                   randconfig-001-20251105    clang-22
arm                   randconfig-002-20251105    clang-22
arm                   randconfig-003-20251105    clang-22
arm                   randconfig-004-20251105    gcc-12.5.0
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251105    clang-17
arm64                 randconfig-002-20251105    gcc-13.4.0
arm64                 randconfig-003-20251105    gcc-8.5.0
arm64                 randconfig-004-20251105    clang-17
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251105    gcc-15.1.0
csky                  randconfig-002-20251105    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251104    clang-22
hexagon               randconfig-002-20251104    clang-16
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251105    gcc-14
i386        buildonly-randconfig-002-20251105    gcc-14
i386        buildonly-randconfig-003-20251105    clang-20
i386        buildonly-randconfig-004-20251105    gcc-14
i386        buildonly-randconfig-005-20251105    gcc-14
i386        buildonly-randconfig-006-20251105    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20251105    clang-20
i386                  randconfig-002-20251105    gcc-14
i386                  randconfig-003-20251105    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251104    gcc-15.1.0
loongarch             randconfig-002-20251104    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251104    gcc-8.5.0
nios2                 randconfig-002-20251104    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                randconfig-001-20251104    gcc-8.5.0
parisc                randconfig-002-20251104    gcc-15.1.0
parisc64                         alldefconfig    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                     kmeter1_defconfig    gcc-15.1.0
powerpc                         ps3_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251104    gcc-15.1.0
powerpc               randconfig-002-20251104    clang-22
powerpc64             randconfig-001-20251104    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20251104    gcc-8.5.0
riscv                 randconfig-002-20251104    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20251104    clang-22
s390                  randconfig-002-20251104    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                          landisk_defconfig    gcc-15.1.0
sh                    randconfig-001-20251104    gcc-13.4.0
sh                    randconfig-002-20251104    gcc-11.5.0
sh                           se7721_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20251105    gcc-12.5.0
sparc                 randconfig-002-20251105    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251105    clang-22
sparc64               randconfig-002-20251105    gcc-10.5.0
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251105    clang-22
um                    randconfig-002-20251105    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251105    clang-20
x86_64      buildonly-randconfig-002-20251105    gcc-13
x86_64      buildonly-randconfig-003-20251105    gcc-14
x86_64      buildonly-randconfig-004-20251105    gcc-13
x86_64      buildonly-randconfig-005-20251105    gcc-14
x86_64      buildonly-randconfig-006-20251105    gcc-13
x86_64                              defconfig    gcc-14
x86_64                randconfig-011-20251105    clang-20
x86_64                randconfig-012-20251105    clang-20
x86_64                randconfig-013-20251105    clang-20
x86_64                randconfig-014-20251105    gcc-14
x86_64                randconfig-015-20251105    clang-20
x86_64                randconfig-016-20251105    gcc-14
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251105    gcc-11.5.0
xtensa                randconfig-002-20251105    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


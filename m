Return-Path: <linux-kernel+bounces-847406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4ACABCABBC
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 21:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2AA53B136D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 19:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0680925CC62;
	Thu,  9 Oct 2025 19:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nHzI9tll"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED8225A359
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 19:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760039740; cv=none; b=srtIFBYJbVi8eVZiORfni/UejnBUh4U4yk+QMF3lN6sd5GWWgN3mQiEUTbAvyuPk81M0pqCUYBD4bbmt/CtWnDdTLhKOufjS0CFgypKVr5YpjP2mb3lXdG7z2YsxHnE42bPwsgT8+w88d4e93RcwhHG81IeIiglDOZ3CkMYjAe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760039740; c=relaxed/simple;
	bh=evPBnbz8CUDXUmSSj+bVDS17Up8Gu45pGBAdUmuGObU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nBTwPiN4+EBQn0V7TKz3TQ2g6ADbAnNhQs9ofWvRuF1fsqZmm+OAbLVyU803i2fhhCXc7G73qAT2V2BuHCxsi2BlJOJBAwuD2a7If0WAYLEXei+A2M2ouCA4qeoHY5RYLeg4mAd2LCYSYIKX0uET2eirhKBRx7H9smoBIK7V7sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nHzI9tll; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760039738; x=1791575738;
  h=date:from:to:cc:subject:message-id;
  bh=evPBnbz8CUDXUmSSj+bVDS17Up8Gu45pGBAdUmuGObU=;
  b=nHzI9tllF3XFyiujx79/OaqmliZDIy1XSYcksQ3V5227dfjrvhjt8Roy
   Tl8juDjv3iCHTRI/q+U90hupOgmddvOTWJjNHI/w80cvT7A3nEYelm/z5
   h7JHAH/WgiXXO64diuR/hx5BAqs74Tt2ul0bKSJGng5T3+0Ak4bBu5d19
   EhkGD3TwYk87tQjw7/vyZ6q7ObepGf8Ou9b918wifGi6tWjr7eIyp2PEJ
   pBK4Ngh//qL77VPoq8b1lzWTNxYIOXWjUD5QSCFat0pzaYTtDLzYyL8a2
   mwu1G2dg9B2JhApjkXE2PO+oZvlN+2KWnO77Z96Ap93M+DwiO7CzUy1rv
   g==;
X-CSE-ConnectionGUID: 2pORhSDXQ/uRSsfyBU+mUg==
X-CSE-MsgGUID: KOOtFVJvQcGlmocVOlY/lQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="72873264"
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; 
   d="scan'208";a="72873264"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 12:55:37 -0700
X-CSE-ConnectionGUID: JlRKuFWqTiuwk/j+zByPvg==
X-CSE-MsgGUID: QRdfWU0RQJWSVyK4hKPcWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; 
   d="scan'208";a="211758915"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 09 Oct 2025 12:55:36 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v6wjd-0001LP-1w;
	Thu, 09 Oct 2025 19:55:33 +0000
Date: Fri, 10 Oct 2025 03:55:27 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2025.10.04a] BUILD SUCCESS
 0c9ebd400d9a65155516b770637030886df3fca6
Message-ID: <202510100322.b7Zrwoku-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2025.10.04a
branch HEAD: 0c9ebd400d9a65155516b770637030886df3fca6  torture: Add kvm-series.sh to test commit/scenario combination

elapsed time: 7775m

configs tested: 228
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                            allyesconfig    clang-19
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-22
arc                              allyesconfig    clang-19
arc                          axs101_defconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20251004    gcc-8.5.0
arc                   randconfig-001-20251009    gcc-10.5.0
arc                   randconfig-002-20251004    gcc-10.5.0
arc                   randconfig-002-20251009    gcc-10.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                      footbridge_defconfig    gcc-15.1.0
arm                       imx_v4_v5_defconfig    gcc-15.1.0
arm                   randconfig-001-20251004    gcc-8.5.0
arm                   randconfig-001-20251009    gcc-10.5.0
arm                   randconfig-002-20251004    gcc-15.1.0
arm                   randconfig-002-20251009    gcc-10.5.0
arm                   randconfig-003-20251004    gcc-12.5.0
arm                   randconfig-003-20251009    gcc-10.5.0
arm                   randconfig-004-20251004    gcc-11.5.0
arm                   randconfig-004-20251009    gcc-10.5.0
arm                         s3c6400_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                               defconfig    clang-19
arm64                 randconfig-001-20251004    clang-20
arm64                 randconfig-001-20251009    gcc-10.5.0
arm64                 randconfig-002-20251004    gcc-8.5.0
arm64                 randconfig-002-20251009    gcc-10.5.0
arm64                 randconfig-003-20251009    gcc-10.5.0
arm64                 randconfig-004-20251009    gcc-10.5.0
csky                              allnoconfig    clang-22
csky                                defconfig    clang-19
csky                  randconfig-001-20251009    clang-16
csky                  randconfig-002-20251009    clang-16
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20251009    clang-16
hexagon               randconfig-002-20251009    clang-16
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20251004    gcc-13
i386        buildonly-randconfig-001-20251009    gcc-14
i386        buildonly-randconfig-002-20251004    clang-20
i386        buildonly-randconfig-002-20251009    gcc-14
i386        buildonly-randconfig-003-20251004    clang-20
i386        buildonly-randconfig-003-20251009    gcc-14
i386        buildonly-randconfig-004-20251004    clang-20
i386        buildonly-randconfig-004-20251009    gcc-14
i386        buildonly-randconfig-005-20251004    clang-20
i386        buildonly-randconfig-005-20251009    gcc-14
i386        buildonly-randconfig-006-20251004    clang-20
i386        buildonly-randconfig-006-20251009    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251009    gcc-14
i386                  randconfig-001-20251010    clang-20
i386                  randconfig-002-20251009    gcc-14
i386                  randconfig-002-20251010    clang-20
i386                  randconfig-003-20251009    gcc-14
i386                  randconfig-003-20251010    clang-20
i386                  randconfig-004-20251009    gcc-14
i386                  randconfig-004-20251010    clang-20
i386                  randconfig-005-20251009    gcc-14
i386                  randconfig-005-20251010    clang-20
i386                  randconfig-006-20251009    gcc-14
i386                  randconfig-006-20251010    clang-20
i386                  randconfig-007-20251009    gcc-14
i386                  randconfig-007-20251010    clang-20
i386                  randconfig-011-20251009    clang-20
i386                  randconfig-012-20251009    clang-20
i386                  randconfig-013-20251009    clang-20
i386                  randconfig-014-20251009    clang-20
i386                  randconfig-015-20251009    clang-20
i386                  randconfig-016-20251009    clang-20
i386                  randconfig-017-20251009    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251009    clang-16
loongarch             randconfig-002-20251009    clang-16
m68k                             allmodconfig    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                                defconfig    clang-19
m68k                          hp300_defconfig    gcc-15.1.0
m68k                        m5272c3_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20251009    clang-16
nios2                 randconfig-002-20251009    clang-16
openrisc                          allnoconfig    clang-22
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
openrisc                    or1ksim_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251009    clang-16
parisc                randconfig-002-20251009    clang-16
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                 canyonlands_defconfig    gcc-15.1.0
powerpc                        icon_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251009    clang-16
powerpc               randconfig-002-20251009    clang-16
powerpc               randconfig-003-20251009    clang-16
powerpc64             randconfig-002-20251009    clang-16
powerpc64             randconfig-003-20251009    clang-16
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20251004    clang-22
riscv                 randconfig-001-20251009    clang-22
riscv                 randconfig-001-20251009    gcc-8.5.0
riscv                 randconfig-002-20251004    clang-22
riscv                 randconfig-002-20251009    clang-19
riscv                 randconfig-002-20251009    clang-22
s390                             alldefconfig    gcc-15.1.0
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20251004    gcc-8.5.0
s390                  randconfig-001-20251009    clang-22
s390                  randconfig-002-20251004    clang-22
s390                  randconfig-002-20251009    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                         ecovec24_defconfig    gcc-15.1.0
sh                    randconfig-001-20251004    gcc-15.1.0
sh                    randconfig-001-20251009    clang-22
sh                    randconfig-001-20251009    gcc-15.1.0
sh                    randconfig-002-20251004    gcc-15.1.0
sh                    randconfig-002-20251009    clang-22
sh                    randconfig-002-20251009    gcc-12.5.0
sh                   sh7724_generic_defconfig    gcc-15.1.0
sh                             shx3_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251004    gcc-8.5.0
sparc                 randconfig-001-20251009    clang-22
sparc                 randconfig-001-20251009    gcc-8.5.0
sparc                 randconfig-002-20251004    gcc-15.1.0
sparc                 randconfig-002-20251009    clang-22
sparc                 randconfig-002-20251009    gcc-8.5.0
sparc                       sparc32_defconfig    gcc-15.1.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251004    gcc-14.3.0
sparc64               randconfig-001-20251009    clang-22
sparc64               randconfig-002-20251004    clang-22
sparc64               randconfig-002-20251009    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251004    clang-18
um                    randconfig-001-20251009    clang-17
um                    randconfig-001-20251009    clang-22
um                    randconfig-002-20251004    clang-22
um                    randconfig-002-20251009    clang-22
um                    randconfig-002-20251009    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                           alldefconfig    gcc-15.1.0
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251004    gcc-14
x86_64      buildonly-randconfig-001-20251009    clang-20
x86_64      buildonly-randconfig-002-20251004    clang-20
x86_64      buildonly-randconfig-002-20251009    clang-20
x86_64      buildonly-randconfig-003-20251004    clang-20
x86_64      buildonly-randconfig-003-20251009    clang-20
x86_64      buildonly-randconfig-004-20251004    clang-20
x86_64      buildonly-randconfig-004-20251009    clang-20
x86_64      buildonly-randconfig-005-20251004    gcc-14
x86_64      buildonly-randconfig-005-20251009    clang-20
x86_64      buildonly-randconfig-006-20251004    gcc-14
x86_64      buildonly-randconfig-006-20251009    clang-20
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251009    clang-20
x86_64                randconfig-002-20251009    clang-20
x86_64                randconfig-003-20251009    clang-20
x86_64                randconfig-004-20251009    clang-20
x86_64                randconfig-005-20251009    clang-20
x86_64                randconfig-006-20251009    clang-20
x86_64                randconfig-007-20251009    clang-20
x86_64                randconfig-008-20251009    clang-20
x86_64                randconfig-071-20251009    gcc-14
x86_64                randconfig-072-20251009    gcc-14
x86_64                randconfig-073-20251009    gcc-14
x86_64                randconfig-074-20251009    gcc-14
x86_64                randconfig-075-20251009    gcc-14
x86_64                randconfig-076-20251009    gcc-14
x86_64                randconfig-077-20251009    gcc-14
x86_64                randconfig-078-20251009    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251009    clang-22
xtensa                randconfig-001-20251009    gcc-11.5.0
xtensa                randconfig-002-20251009    clang-22
xtensa                randconfig-002-20251009    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


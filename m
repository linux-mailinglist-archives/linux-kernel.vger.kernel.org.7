Return-Path: <linux-kernel+bounces-849178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 25499BCF5AC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 15:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 11004349DAD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 13:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F550278753;
	Sat, 11 Oct 2025 13:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SvvX37TD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA4D2652B7
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 13:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760188979; cv=none; b=C/E6AlHLuR/dZBaXSgSScdBNz1UjT+G/kdBnQvrnFXL+tGrggVBD462FbtRCnewzXns6hpEztAp0OUpDhVw39TSTHZImauhfmTw/pOuKml+3AvnuSP6JmwZRvjPq7Zb7gZIk+mTu9qs5Hkl0dP6dKsdhFQxvZ3naot0rJS/zxAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760188979; c=relaxed/simple;
	bh=AEBqc3nqNPRUr0hTwg73YH6qXWARfhCpyKyce0hkpW4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GUn2nUb4VEHKOkFZH31jQqUvbuWp1fPQOHQHpET7LcUAi6ehHzh1mpzhUfFdNfVqLQDwFHVEoTRyVzNnOCfhXs6Jt79/3ktfK2+fY07nLjaFAYj1tUW6DmI7KJx6yOfOm2wUqWpbTqjltXnZ16GIEORQ6vZ4xWBszTdu2AolA/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SvvX37TD; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760188978; x=1791724978;
  h=date:from:to:cc:subject:message-id;
  bh=AEBqc3nqNPRUr0hTwg73YH6qXWARfhCpyKyce0hkpW4=;
  b=SvvX37TDgugUXJc56FOPSdDeWKCEzAU0m+Wbw9Bm2rSePCl308tT3vKZ
   bXW3pQXC/XbRF1xtV7w2/Zryu3QcempP2lnPALQz+waZkcMG6USi/lqks
   fPFD6HdTpf8hCPhnLi7dILbGWzlZRF58ShLTVBFmD/31PbMd7UpKaXKs0
   oA5xzkvtUsZGJSzVi2IjwKNCxQQfO0gkOgGLAenpUT5OQm5N+rUjGvgXy
   hmlT7K+vNBzjmGcPlKvhVMguH5rhUo9QiyCBzTHzx6VnlfHCLb9i/vG3j
   PJU3jeAKWEQ9lNaOqyGPNeH0J1C1O7QSD14eCd/xrTYo7YCKyf70mUW/9
   w==;
X-CSE-ConnectionGUID: sEjD8U3kRYqAL3IUEfaObg==
X-CSE-MsgGUID: oWuuEe0wTji4eNo51PWJoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11579"; a="73830469"
X-IronPort-AV: E=Sophos;i="6.19,221,1754982000"; 
   d="scan'208";a="73830469"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2025 06:22:58 -0700
X-CSE-ConnectionGUID: ZRBu/bkOQS+ppGoeJn5o6A==
X-CSE-MsgGUID: lCowRsVoScKr51lQKRuleg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,221,1754982000"; 
   d="scan'208";a="185446249"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 11 Oct 2025 06:22:56 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v7ZYj-0003nD-32;
	Sat, 11 Oct 2025 13:22:53 +0000
Date: Sat, 11 Oct 2025 21:22:22 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20251009] BUILD SUCCESS
 17c1a3fdbae3916ab0b603813a960a6f164014ba
Message-ID: <202510112116.4peUx6EP-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20251009
branch HEAD: 17c1a3fdbae3916ab0b603813a960a6f164014ba  scsi: libsas/aci94xx: Avoid multiple -Wflex-array-member-not-at-end warnings

elapsed time: 1444m

configs tested: 126
configs skipped: 4

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
arc                   randconfig-001-20251010    gcc-12.5.0
arc                   randconfig-002-20251010    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20251010    gcc-8.5.0
arm                   randconfig-002-20251010    gcc-13.4.0
arm                   randconfig-003-20251010    gcc-8.5.0
arm                   randconfig-004-20251010    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251010    gcc-14.3.0
arm64                 randconfig-002-20251010    clang-19
arm64                 randconfig-003-20251010    clang-17
arm64                 randconfig-004-20251010    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251010    gcc-15.1.0
csky                  randconfig-002-20251010    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20251010    clang-22
hexagon               randconfig-002-20251010    clang-18
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251010    gcc-14
i386        buildonly-randconfig-002-20251010    clang-20
i386        buildonly-randconfig-003-20251010    clang-20
i386        buildonly-randconfig-004-20251010    gcc-14
i386        buildonly-randconfig-005-20251010    gcc-14
i386        buildonly-randconfig-006-20251010    gcc-14
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20251010    clang-22
loongarch             randconfig-002-20251010    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                        m5272c3_defconfig    gcc-15.1.0
m68k                            mac_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251010    gcc-11.5.0
nios2                 randconfig-002-20251010    gcc-9.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           alldefconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251010    gcc-8.5.0
parisc                randconfig-002-20251010    gcc-12.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                        fsp2_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251010    clang-22
powerpc               randconfig-002-20251010    gcc-15.1.0
powerpc               randconfig-003-20251010    clang-22
powerpc64             randconfig-001-20251010    clang-22
powerpc64             randconfig-002-20251010    gcc-14.3.0
powerpc64             randconfig-003-20251010    gcc-13.4.0
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251010    clang-22
riscv                 randconfig-002-20251010    gcc-9.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251010    gcc-14.3.0
s390                  randconfig-002-20251010    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                        apsh4ad0a_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                ecovec24-romimage_defconfig    gcc-15.1.0
sh                    randconfig-001-20251010    gcc-15.1.0
sh                    randconfig-002-20251010    gcc-15.1.0
sh                        sh7757lcr_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251010    gcc-11.5.0
sparc                 randconfig-002-20251010    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251010    clang-20
sparc64               randconfig-002-20251010    gcc-10.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251010    gcc-14
um                    randconfig-002-20251010    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251010    clang-20
x86_64      buildonly-randconfig-002-20251010    clang-20
x86_64      buildonly-randconfig-003-20251010    clang-20
x86_64      buildonly-randconfig-004-20251010    clang-20
x86_64      buildonly-randconfig-005-20251010    gcc-14
x86_64      buildonly-randconfig-006-20251010    gcc-14
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251010    gcc-8.5.0
xtensa                randconfig-002-20251010    gcc-9.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


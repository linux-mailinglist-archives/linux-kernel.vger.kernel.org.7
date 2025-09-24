Return-Path: <linux-kernel+bounces-829934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE91B9844A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 07:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20C3A1719EA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 05:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798C9146588;
	Wed, 24 Sep 2025 05:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mVc3Oawa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370DB63B9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 05:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758690966; cv=none; b=Wl1Ly5UwqyOGtHHtvMMEHmcC/BtFcIFtfeIdFl9upJ9nOdFPUKmWoyRk6Jle1ZmIZ196ldOjj5lbk52tx+UJDlCqAChyyfT/hUr8SzDRuyoTp9PXaOB+3nKEXK619NIkOFWaGNUTRGvd8HYH3cSFU7Hy4hApOgg0FSWy09d+qwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758690966; c=relaxed/simple;
	bh=GHA728MYxYzdKQVESUgKEn7i5JdaME5pENg/gvxT7Fw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Dz7YgNvLcpF+EuducAr1XM8Z57VZ0WZyUKlMXwmg9t2YxdpnEpbwgxd0SgdlAVw+ZS3JuJiFijAPBFeDzEJwpraDdbIhquIdtdPdihfu8hFmwzAEcvVzK4wSEuKtzcbOJtyOJGnR2OJuHvyg1jYhZyNLVmTd5EStkjxpAHfui94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mVc3Oawa; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758690961; x=1790226961;
  h=date:from:to:cc:subject:message-id;
  bh=GHA728MYxYzdKQVESUgKEn7i5JdaME5pENg/gvxT7Fw=;
  b=mVc3OawaX40qUDgs40OEIiwLgXoRaCKK7ZPuCctCIylKkTmoRaQLcD36
   xVi4kI8EYxnB0a8J423fQpLhV4LEp76MTRywZC4GY0yf/Bjdo1vB/fPHp
   CwXmKBFFZxOIj15Nb++/NC3pBpEPAumOOcDU/jgx1wUkt6fiL0yg14MYL
   V2PO8M+mVxKmvG+UZ9sKJ4cawfPKO89hbqd9It6mlt8Nt+sOrshipE5DY
   +5ipFcUCNruSLEq0UTSUNRHQyW5HgsXSCG+xzklQYHq47cbmAkWMo2m9M
   6M5Tb8+hfDe3t6m7iUybbbQGbAL/Gj4/A4EQui7WObxiS4z0FbgSPPYXY
   A==;
X-CSE-ConnectionGUID: 5k90A27YQ+ejMSLRlGbRpQ==
X-CSE-MsgGUID: md7ytVB/Tdq5r1yDHypndg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60921726"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60921726"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 22:16:01 -0700
X-CSE-ConnectionGUID: w2GpN1IySz2E33ZuEFD2yw==
X-CSE-MsgGUID: EXb5mzwlTjups8SY8x96RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="176885282"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 23 Sep 2025 22:15:59 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v1Hr8-0003ob-0a;
	Wed, 24 Sep 2025 05:15:54 +0000
Date: Wed, 24 Sep 2025 13:14:52 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:next.2025.09.23a] BUILD SUCCESS
 1d289fc5691c7a970a285bc53292bac9e37c89a6
Message-ID: <202509241342.NkMQJ4JL-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git next.2025.09.23a
branch HEAD: 1d289fc5691c7a970a285bc53292bac9e37c89a6  Merge branch 'torture.2025.08.14a' into HEAD

elapsed time: 1172m

configs tested: 247
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20250923    gcc-12.5.0
arc                   randconfig-001-20250924    gcc-11.5.0
arc                   randconfig-002-20250923    gcc-12.5.0
arc                   randconfig-002-20250924    gcc-11.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                            mmp2_defconfig    clang-22
arm                            mps2_defconfig    clang-22
arm                   randconfig-001-20250923    gcc-12.5.0
arm                   randconfig-001-20250924    gcc-11.5.0
arm                   randconfig-002-20250923    clang-17
arm                   randconfig-002-20250924    gcc-11.5.0
arm                   randconfig-003-20250923    gcc-8.5.0
arm                   randconfig-003-20250924    gcc-11.5.0
arm                   randconfig-004-20250923    clang-22
arm                   randconfig-004-20250924    gcc-11.5.0
arm                             rpc_defconfig    clang-22
arm                           stm32_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250923    gcc-8.5.0
arm64                 randconfig-001-20250924    gcc-11.5.0
arm64                 randconfig-002-20250923    clang-18
arm64                 randconfig-002-20250924    gcc-11.5.0
arm64                 randconfig-003-20250923    gcc-8.5.0
arm64                 randconfig-003-20250924    gcc-11.5.0
arm64                 randconfig-004-20250923    gcc-11.5.0
arm64                 randconfig-004-20250924    gcc-11.5.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250923    gcc-9.5.0
csky                  randconfig-001-20250924    clang-22
csky                  randconfig-002-20250923    gcc-15.1.0
csky                  randconfig-002-20250924    clang-22
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250923    clang-22
hexagon               randconfig-001-20250924    clang-22
hexagon               randconfig-002-20250923    clang-22
hexagon               randconfig-002-20250924    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20250923    gcc-14
i386        buildonly-randconfig-001-20250924    gcc-14
i386        buildonly-randconfig-002-20250923    clang-20
i386        buildonly-randconfig-002-20250924    gcc-14
i386        buildonly-randconfig-003-20250923    clang-20
i386        buildonly-randconfig-003-20250924    gcc-14
i386        buildonly-randconfig-004-20250923    gcc-14
i386        buildonly-randconfig-004-20250924    gcc-14
i386        buildonly-randconfig-005-20250923    clang-20
i386        buildonly-randconfig-005-20250924    gcc-14
i386        buildonly-randconfig-006-20250923    clang-20
i386        buildonly-randconfig-006-20250924    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20250924    clang-20
i386                  randconfig-002-20250924    clang-20
i386                  randconfig-003-20250924    clang-20
i386                  randconfig-004-20250924    clang-20
i386                  randconfig-005-20250924    clang-20
i386                  randconfig-006-20250924    clang-20
i386                  randconfig-007-20250924    clang-20
i386                  randconfig-011-20250924    gcc-14
i386                  randconfig-012-20250924    gcc-14
i386                  randconfig-013-20250924    gcc-14
i386                  randconfig-014-20250924    gcc-14
i386                  randconfig-015-20250924    gcc-14
i386                  randconfig-016-20250924    gcc-14
i386                  randconfig-017-20250924    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250923    gcc-15.1.0
loongarch             randconfig-001-20250924    clang-22
loongarch             randconfig-002-20250923    gcc-15.1.0
loongarch             randconfig-002-20250924    clang-22
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                        mvme147_defconfig    clang-22
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250923    gcc-11.5.0
nios2                 randconfig-001-20250924    clang-22
nios2                 randconfig-002-20250923    gcc-11.5.0
nios2                 randconfig-002-20250924    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250923    gcc-15.1.0
parisc                randconfig-001-20250924    clang-22
parisc                randconfig-002-20250923    gcc-9.5.0
parisc                randconfig-002-20250924    clang-22
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                     kmeter1_defconfig    clang-22
powerpc               randconfig-001-20250923    gcc-8.5.0
powerpc               randconfig-001-20250924    clang-22
powerpc               randconfig-002-20250923    clang-16
powerpc               randconfig-002-20250924    clang-22
powerpc               randconfig-003-20250923    gcc-12.5.0
powerpc               randconfig-003-20250924    clang-22
powerpc                      tqm8xx_defconfig    clang-22
powerpc64             randconfig-001-20250923    gcc-10.5.0
powerpc64             randconfig-001-20250924    clang-22
powerpc64             randconfig-002-20250923    clang-22
powerpc64             randconfig-002-20250924    clang-22
powerpc64             randconfig-003-20250924    clang-22
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20250923    gcc-12.5.0
riscv                 randconfig-001-20250924    gcc-8.5.0
riscv                 randconfig-002-20250923    clang-22
riscv                 randconfig-002-20250924    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20250923    gcc-8.5.0
s390                  randconfig-001-20250924    gcc-8.5.0
s390                  randconfig-002-20250923    clang-22
s390                  randconfig-002-20250924    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20250923    gcc-15.1.0
sh                    randconfig-001-20250924    gcc-8.5.0
sh                    randconfig-002-20250923    gcc-10.5.0
sh                    randconfig-002-20250924    gcc-8.5.0
sh                           se7705_defconfig    clang-22
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250923    gcc-8.5.0
sparc                 randconfig-001-20250924    gcc-8.5.0
sparc                 randconfig-002-20250923    gcc-12.5.0
sparc                 randconfig-002-20250924    gcc-8.5.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20250923    clang-22
sparc64               randconfig-001-20250924    gcc-8.5.0
sparc64               randconfig-002-20250923    gcc-8.5.0
sparc64               randconfig-002-20250924    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250923    clang-22
um                    randconfig-001-20250924    gcc-8.5.0
um                    randconfig-002-20250923    clang-22
um                    randconfig-002-20250924    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250923    gcc-14
x86_64      buildonly-randconfig-001-20250924    clang-20
x86_64      buildonly-randconfig-002-20250923    gcc-14
x86_64      buildonly-randconfig-002-20250924    clang-20
x86_64      buildonly-randconfig-003-20250923    gcc-14
x86_64      buildonly-randconfig-003-20250924    clang-20
x86_64      buildonly-randconfig-004-20250923    clang-20
x86_64      buildonly-randconfig-004-20250924    clang-20
x86_64      buildonly-randconfig-005-20250923    clang-20
x86_64      buildonly-randconfig-005-20250924    clang-20
x86_64      buildonly-randconfig-006-20250923    clang-20
x86_64      buildonly-randconfig-006-20250924    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250924    gcc-14
x86_64                randconfig-002-20250924    gcc-14
x86_64                randconfig-003-20250924    gcc-14
x86_64                randconfig-004-20250924    gcc-14
x86_64                randconfig-005-20250924    gcc-14
x86_64                randconfig-006-20250924    gcc-14
x86_64                randconfig-007-20250924    gcc-14
x86_64                randconfig-008-20250924    gcc-14
x86_64                randconfig-071-20250924    clang-20
x86_64                randconfig-072-20250924    clang-20
x86_64                randconfig-073-20250924    clang-20
x86_64                randconfig-074-20250924    clang-20
x86_64                randconfig-075-20250924    clang-20
x86_64                randconfig-076-20250924    clang-20
x86_64                randconfig-077-20250924    clang-20
x86_64                randconfig-078-20250924    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250923    gcc-8.5.0
xtensa                randconfig-001-20250924    gcc-8.5.0
xtensa                randconfig-002-20250923    gcc-8.5.0
xtensa                randconfig-002-20250924    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


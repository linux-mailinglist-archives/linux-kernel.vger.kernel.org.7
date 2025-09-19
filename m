Return-Path: <linux-kernel+bounces-824858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D24B8A515
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F2183B7E0B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15163176E7;
	Fri, 19 Sep 2025 15:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KFnsQdbB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1E33168FF
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758296093; cv=none; b=d7J1vHclFsNf4i0jQCrAviCO4i99YAHKIFP5GdPpLeD/qMNbwvJAymd1ldVMRc+ytvyZJxJZX8n21MizkjPFJDhDOOyc7J+X2ml8nsPwyg+cO2MzTxf1Ns/U/nd8TiNwLKfnH+WFXGWG9MTtbOlUIsbuxjpKl3ZbtS8ZL/0Z6y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758296093; c=relaxed/simple;
	bh=XvU+6NPIXeA89/qPxx/fVM9DJdPzmipLpixmeq67JDY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WcRUYHiddW498SI0HEmb9ILv2+WLxE+tmv07EreJFzmb6lOcmYB7De78duF/K5pyUIspNgXBOyPuLk3xonYDcEoIWskf2xVHDsTr6D3+r+jrKfCDKeqNHuijYMuaCtKrX4Y8a5Ng5Fs+6JLB6qIXPXYG99n3+1jLDH756+XVdP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KFnsQdbB; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758296091; x=1789832091;
  h=date:from:to:cc:subject:message-id;
  bh=XvU+6NPIXeA89/qPxx/fVM9DJdPzmipLpixmeq67JDY=;
  b=KFnsQdbBC3Ll11D7hsiStsQZqGFeMGbJsp2wkdk/lNC/2Uy5HKyXS2Ry
   LN/O8tLWszyBhwRHjuXWZ1GdzDVzUBl1e/HKYha3jLF3CTp9/o+0CBOZI
   6IBUDmJsU7osedWqpcwDbqu4vaJJ2GodUL6ysCYUTRFgexoVNB4dhgglV
   wL2M8/0z/1VMsKRC9aUdWM28PpoH6m7/smWn3m3riRoKLTy5bVABQzxDT
   Ysiih6SfAl0oTkHjcJ7mnjF6THPAlnCtYoq6vK941GMQyuXA7HFOf2vCA
   VcdibnlnV201J2yeldpHwnTGdsir0CXBihDkejySoC9qlIv96PL7NmAQe
   g==;
X-CSE-ConnectionGUID: Pgeaat3BSZOZMc9Civ9LsQ==
X-CSE-MsgGUID: 7vv2mGkOSseXYlSVkeg1Tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="60532512"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="60532512"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 08:34:51 -0700
X-CSE-ConnectionGUID: Propb+pCQJCRdYK9WoDMiA==
X-CSE-MsgGUID: h5WoTqU8QFqEZ4As+LAlAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="206805396"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 19 Sep 2025 08:34:49 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uzd8I-0004Q7-20;
	Fri, 19 Sep 2025 15:34:46 +0000
Date: Fri, 19 Sep 2025 23:34:13 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2025.09.15a] BUILD SUCCESS
 f81c21ec3fca688bfcb6fa0abaf70404655765dc
Message-ID: <202509192307.KeK8zXjC-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2025.09.15a
branch HEAD: f81c21ec3fca688bfcb6fa0abaf70404655765dc  rcutorture: Exercise DEFINE_STATIC_SRCU_FAST() and init_srcu_struct_fast()

elapsed time: 1373m

configs tested: 231
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-15.1.0
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                                 defconfig    clang-19
arc                         haps_hs_defconfig    gcc-15.1.0
arc                   randconfig-001-20250919    gcc-11.5.0
arc                   randconfig-001-20250919    gcc-15.1.0
arc                   randconfig-002-20250919    gcc-11.5.0
arc                   randconfig-002-20250919    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                   randconfig-001-20250919    gcc-11.5.0
arm                   randconfig-001-20250919    gcc-12.5.0
arm                   randconfig-002-20250919    gcc-10.5.0
arm                   randconfig-002-20250919    gcc-11.5.0
arm                   randconfig-003-20250919    gcc-11.5.0
arm                   randconfig-003-20250919    gcc-12.5.0
arm                   randconfig-004-20250919    clang-22
arm                   randconfig-004-20250919    gcc-11.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250919    gcc-11.5.0
arm64                 randconfig-001-20250919    gcc-15.1.0
arm64                 randconfig-002-20250919    gcc-11.5.0
arm64                 randconfig-002-20250919    gcc-8.5.0
arm64                 randconfig-003-20250919    gcc-11.5.0
arm64                 randconfig-003-20250919    gcc-12.5.0
arm64                 randconfig-004-20250919    gcc-11.5.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250919    clang-22
csky                  randconfig-001-20250919    gcc-14.3.0
csky                  randconfig-002-20250919    clang-22
csky                  randconfig-002-20250919    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250919    clang-22
hexagon               randconfig-002-20250919    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20250919    clang-20
i386        buildonly-randconfig-001-20250919    gcc-14
i386        buildonly-randconfig-002-20250919    gcc-14
i386        buildonly-randconfig-003-20250919    gcc-14
i386        buildonly-randconfig-004-20250919    gcc-14
i386        buildonly-randconfig-005-20250919    clang-20
i386        buildonly-randconfig-005-20250919    gcc-14
i386        buildonly-randconfig-006-20250919    clang-20
i386        buildonly-randconfig-006-20250919    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20250919    gcc-14
i386                  randconfig-002-20250919    gcc-14
i386                  randconfig-003-20250919    gcc-14
i386                  randconfig-004-20250919    gcc-14
i386                  randconfig-005-20250919    gcc-14
i386                  randconfig-006-20250919    gcc-14
i386                  randconfig-007-20250919    gcc-14
i386                  randconfig-011-20250919    clang-20
i386                  randconfig-012-20250919    clang-20
i386                  randconfig-013-20250919    clang-20
i386                  randconfig-014-20250919    clang-20
i386                  randconfig-015-20250919    clang-20
i386                  randconfig-016-20250919    clang-20
i386                  randconfig-017-20250919    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250919    clang-22
loongarch             randconfig-001-20250919    gcc-15.1.0
loongarch             randconfig-002-20250919    clang-22
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                         db1xxx_defconfig    gcc-15.1.0
nios2                         3c120_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250919    clang-22
nios2                 randconfig-001-20250919    gcc-10.5.0
nios2                 randconfig-002-20250919    clang-22
nios2                 randconfig-002-20250919    gcc-8.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250919    clang-22
parisc                randconfig-001-20250919    gcc-15.1.0
parisc                randconfig-002-20250919    clang-22
parisc                randconfig-002-20250919    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                    ge_imp3a_defconfig    gcc-15.1.0
powerpc                 linkstation_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250919    clang-22
powerpc               randconfig-001-20250919    gcc-10.5.0
powerpc               randconfig-002-20250919    clang-22
powerpc               randconfig-002-20250919    gcc-8.5.0
powerpc               randconfig-003-20250919    clang-18
powerpc               randconfig-003-20250919    clang-22
powerpc64             randconfig-001-20250919    clang-22
powerpc64             randconfig-001-20250919    gcc-8.5.0
powerpc64             randconfig-002-20250919    clang-22
powerpc64             randconfig-002-20250919    gcc-13.4.0
powerpc64             randconfig-003-20250919    clang-18
powerpc64             randconfig-003-20250919    clang-22
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20250919    gcc-10.5.0
riscv                 randconfig-002-20250919    gcc-10.5.0
riscv                 randconfig-002-20250919    gcc-13.4.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20250919    gcc-10.5.0
s390                  randconfig-001-20250919    gcc-8.5.0
s390                  randconfig-002-20250919    gcc-10.5.0
s390                  randconfig-002-20250919    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20250919    gcc-10.5.0
sh                    randconfig-001-20250919    gcc-12.5.0
sh                    randconfig-002-20250919    gcc-10.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250919    gcc-10.5.0
sparc                 randconfig-001-20250919    gcc-14.3.0
sparc                 randconfig-002-20250919    gcc-10.5.0
sparc                 randconfig-002-20250919    gcc-8.5.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20250919    clang-22
sparc64               randconfig-001-20250919    gcc-10.5.0
sparc64               randconfig-002-20250919    gcc-10.5.0
sparc64               randconfig-002-20250919    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250919    gcc-10.5.0
um                    randconfig-001-20250919    gcc-12
um                    randconfig-002-20250919    clang-22
um                    randconfig-002-20250919    gcc-10.5.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250919    clang-20
x86_64      buildonly-randconfig-002-20250919    clang-20
x86_64      buildonly-randconfig-002-20250919    gcc-14
x86_64      buildonly-randconfig-003-20250919    clang-20
x86_64      buildonly-randconfig-003-20250919    gcc-14
x86_64      buildonly-randconfig-004-20250919    clang-20
x86_64      buildonly-randconfig-005-20250919    clang-20
x86_64      buildonly-randconfig-006-20250919    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20250919    clang-20
x86_64                randconfig-002-20250919    clang-20
x86_64                randconfig-003-20250919    clang-20
x86_64                randconfig-004-20250919    clang-20
x86_64                randconfig-005-20250919    clang-20
x86_64                randconfig-006-20250919    clang-20
x86_64                randconfig-007-20250919    clang-20
x86_64                randconfig-008-20250919    clang-20
x86_64                randconfig-071-20250919    gcc-14
x86_64                randconfig-072-20250919    gcc-14
x86_64                randconfig-073-20250919    gcc-14
x86_64                randconfig-074-20250919    gcc-14
x86_64                randconfig-075-20250919    gcc-14
x86_64                randconfig-076-20250919    gcc-14
x86_64                randconfig-077-20250919    gcc-14
x86_64                randconfig-078-20250919    gcc-14
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250919    gcc-10.5.0
xtensa                randconfig-001-20250919    gcc-11.5.0
xtensa                randconfig-002-20250919    gcc-10.5.0
xtensa                randconfig-002-20250919    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


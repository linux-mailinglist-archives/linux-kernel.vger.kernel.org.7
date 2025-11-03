Return-Path: <linux-kernel+bounces-882390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F37C2A54B
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 08:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77A2F4ED249
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 07:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24BE2BE63F;
	Mon,  3 Nov 2025 07:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ixX/ZIUd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4F32BDC05
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 07:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762155033; cv=none; b=iQBT8gOzjNH/H7vz6BannXOfvQnmdP6pLeMGlFx80YOLirba95v3NhrhgZ38l/65EGrZD2ICA9P4urKeFPXe5XGPxA51sFq1Bejf0bafozNXaRlfSpTRo6fWyNRLG3/AMgVK5MOC00PRxUkzDBaBt00vhfrRPCTLsm6mIKHhQjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762155033; c=relaxed/simple;
	bh=XtNKwrJIvIVLAswLsfLShVLPkpOrARbdoT4P0lA/Th8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=D6GwN2pxKxya2AQNN9zPmMT6QelWFQxDbPhCzEg1UeJywbkTOQkFidV60d0rYlSB3FJhC9qzmUFy+DOpdKfcCM8q2hECD5dbYlQqoZ85mN1Sw8e9lqXBNsa1zG8K59I/oZUQAgqUORxmwhtBQVfy8xC2IWXBytb586h9qKY2/LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ixX/ZIUd; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762155032; x=1793691032;
  h=date:from:to:cc:subject:message-id;
  bh=XtNKwrJIvIVLAswLsfLShVLPkpOrARbdoT4P0lA/Th8=;
  b=ixX/ZIUdL95UPNwHBwI6h1dBNfds+ggH/hS2BHSXGlO1L8ATBNSV7//2
   5pxOVFlIoVcuwqqC8HOPjwB4o6IL+uQLXtBAzlnNAUYqA4hJiIleTKK6W
   x7bblGPSYe8NjsY7zN5lfmkykLKqwNBnwJgqIRDolZ5MS9FMWBlnvUpRI
   xnJhYCrowfrqewN+sCqCwz+Ae/4H5uDKZ9tuefhwHTCRS9fij/vZ8zr36
   6ti/bkdSansW07HwFZwEvPhAIUMaAPUNDMQiIhnzqTfxtaVAlbMYWbHMA
   g1NsszyouC6OYZXuTfzajJ6+eq1UEZ5j9M8xSHCq/U0b1fk72VlxqAPJS
   A==;
X-CSE-ConnectionGUID: 64PdOjSjRuamLRXwrseuFQ==
X-CSE-MsgGUID: hGD/nsMhQHeCcCRrDZEBQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="74902835"
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="74902835"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2025 23:30:32 -0800
X-CSE-ConnectionGUID: w5t91PjdRpOfkexmfa245w==
X-CSE-MsgGUID: wDw4O2jdSjS3BocT6M5IxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="186470929"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 02 Nov 2025 23:30:30 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vFp1E-000Puq-2H;
	Mon, 03 Nov 2025 07:30:25 +0000
Date: Mon, 03 Nov 2025 15:29:53 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 3eaa2454f5701a95dd0e7d080b3afd60b1e83ffa
Message-ID: <202511031548.T7VNiRvO-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 3eaa2454f5701a95dd0e7d080b3afd60b1e83ffa  Merge branch into tip/master: 'timers/vdso'

elapsed time: 1455m

configs tested: 167
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
arc                   randconfig-001-20251102    gcc-8.5.0
arc                   randconfig-002-20251102    gcc-14.3.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                          ixp4xx_defconfig    gcc-15.1.0
arm                            mmp2_defconfig    gcc-15.1.0
arm                   randconfig-001-20251102    gcc-15.1.0
arm                   randconfig-002-20251102    gcc-10.5.0
arm                   randconfig-003-20251102    gcc-8.5.0
arm                   randconfig-004-20251102    gcc-14.3.0
arm                    vt8500_v6_v7_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
arm64                            allyesconfig    clang-22
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251103    clang-22
arm64                 randconfig-002-20251103    gcc-13.4.0
arm64                 randconfig-003-20251103    gcc-14.3.0
arm64                 randconfig-004-20251103    gcc-8.5.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251103    gcc-15.1.0
csky                  randconfig-002-20251103    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251102    clang-22
hexagon               randconfig-002-20251102    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251103    gcc-14
i386        buildonly-randconfig-002-20251103    clang-20
i386        buildonly-randconfig-003-20251103    clang-20
i386        buildonly-randconfig-004-20251103    gcc-14
i386        buildonly-randconfig-005-20251103    gcc-14
i386        buildonly-randconfig-006-20251103    gcc-13
i386                                defconfig    clang-20
i386                  randconfig-001-20251103    clang-20
i386                  randconfig-002-20251103    gcc-14
i386                  randconfig-003-20251103    gcc-14
i386                  randconfig-005-20251103    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                        allyesconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251102    gcc-15.1.0
loongarch             randconfig-002-20251102    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                        stmark2_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                   sb1250_swarm_defconfig    gcc-15.1.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                            allyesconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251102    gcc-11.5.0
nios2                 randconfig-002-20251102    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251102    gcc-8.5.0
parisc                randconfig-002-20251102    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                    gamecube_defconfig    clang-22
powerpc                   motionpro_defconfig    clang-22
powerpc               randconfig-001-20251102    gcc-9.5.0
powerpc               randconfig-002-20251102    clang-18
powerpc64             randconfig-001-20251102    gcc-14.3.0
powerpc64             randconfig-002-20251102    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251102    gcc-13.4.0
riscv                 randconfig-002-20251102    gcc-14.3.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-002-20251102    gcc-11.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251102    gcc-13.4.0
sh                    randconfig-002-20251102    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                            allyesconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251103    gcc-15.1.0
sparc                 randconfig-002-20251103    gcc-11.5.0
sparc64                          allmodconfig    clang-22
sparc64                          allyesconfig    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251103    clang-22
sparc64               randconfig-002-20251103    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251103    clang-19
um                    randconfig-002-20251103    clang-22
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251103    clang-20
x86_64      buildonly-randconfig-002-20251103    gcc-14
x86_64      buildonly-randconfig-003-20251103    gcc-13
x86_64      buildonly-randconfig-004-20251103    clang-20
x86_64      buildonly-randconfig-005-20251103    gcc-14
x86_64      buildonly-randconfig-006-20251103    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251103    clang-20
x86_64                randconfig-002-20251103    clang-20
x86_64                randconfig-003-20251103    gcc-14
x86_64                randconfig-004-20251103    gcc-14
x86_64                randconfig-005-20251103    gcc-14
x86_64                randconfig-006-20251103    clang-20
x86_64                randconfig-011-20251103    clang-20
x86_64                randconfig-012-20251103    clang-20
x86_64                randconfig-013-20251103    gcc-14
x86_64                randconfig-014-20251103    gcc-14
x86_64                randconfig-015-20251103    clang-20
x86_64                randconfig-016-20251103    gcc-13
x86_64                randconfig-071-20251103    gcc-14
x86_64                randconfig-072-20251103    gcc-14
x86_64                randconfig-073-20251103    clang-20
x86_64                randconfig-074-20251103    gcc-14
x86_64                randconfig-075-20251103    clang-20
x86_64                randconfig-076-20251103    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    gcc-15.1.0
xtensa                randconfig-001-20251103    gcc-13.4.0
xtensa                randconfig-002-20251103    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


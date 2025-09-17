Return-Path: <linux-kernel+bounces-820161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F6DB7D848
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83065172D81
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 07:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E2E2FFF8D;
	Wed, 17 Sep 2025 07:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bQvGp1XF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A5827FD48
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 07:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758094749; cv=none; b=nqhIXGOGekqyJh1kjyFCmfVypm4kSi3Dgr9nEry5sOkXSW0jkhCVY2Xaq1zeZPsoxfhqsoxVC/tfkmDVbgLwp6XIyl4PalFSTBkWUK5PyZlbpNIAtINV/92aqUGtpXzH9wpdhCafMoCLEYov8thS2FupL+XaQLIvEP3LXsUCfu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758094749; c=relaxed/simple;
	bh=EoFNnZZ2dJxLde143xappXie9t21YKjZssTOOAOdkzk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Vw5GRRcJRqWqc/jc1GcQSVH3e/XT11hO3Rv32OmOM6Z2tuYyb+o1GCxKuFIaBM9vOj8bN51GArD9Gx/WhTpilOauEBALZjaGGOob6pSigAJqEJrvtafV/DgNEccnDa4o3ww3MuOXEXqN9tWYfv7oeGntRHpEEld7MAFZmREjXW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bQvGp1XF; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758094748; x=1789630748;
  h=date:from:to:cc:subject:message-id;
  bh=EoFNnZZ2dJxLde143xappXie9t21YKjZssTOOAOdkzk=;
  b=bQvGp1XF3T/UDerDs+Cfgm8osJCJCyEaaDZIxxaSr+EP1a4adg9IUiWj
   OhPax0geyIsTeT3aad7EnXAlBTMWg/k1rlp9teCAf0M0WAvQNOwWnzhqX
   wRRz9AMlN+SX0jz2MvOWxtdVY2ZKA4slxYGaymxy/pWfEKuLafukYK3Wp
   hkg9fnPNJH3Do158tznPD4ar8UW+RtluWItXXhfKyThM6UN206nYJOYhW
   zq51JVmnLNaPRW75xjtW2Voibj63ojky8LXzXl0jQcD6o33vAW/QTme7a
   xjmiD6lOFw8Fl9B9CnMuqk8k+3vw06aIj22M/FwOC43ShztqlwuvVWGqW
   w==;
X-CSE-ConnectionGUID: 3pv81D0XQ3qwHVtcMg4P3w==
X-CSE-MsgGUID: xmHTLP9nQgOYNu6KqeGGHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="71076902"
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="71076902"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:39:06 -0700
X-CSE-ConnectionGUID: iYhTsRMAQUWabBa+wT/OtQ==
X-CSE-MsgGUID: Obcc6jsBRm2achx+hL3EUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="174276583"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 17 Sep 2025 00:39:05 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uymko-0001E7-1k;
	Wed, 17 Sep 2025 07:39:02 +0000
Date: Wed, 17 Sep 2025 15:38:56 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 194cd35fad1e04ae1540a5f46db2b4a6b65a0b86
Message-ID: <202509171550.F4HoQ4SM-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 194cd35fad1e04ae1540a5f46db2b4a6b65a0b86  Merge branch into tip/master: 'x86/tdx'

elapsed time: 1466m

configs tested: 98
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-002-20250916    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                          pxa3xx_defconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250916    gcc-14.3.0
csky                  randconfig-002-20250916    gcc-11.5.0
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250916    clang-22
hexagon               randconfig-002-20250916    clang-22
i386                             allmodconfig    gcc-14
i386        buildonly-randconfig-001-20250916    gcc-14
i386        buildonly-randconfig-002-20250916    gcc-14
i386        buildonly-randconfig-003-20250916    clang-20
i386        buildonly-randconfig-004-20250916    gcc-14
i386        buildonly-randconfig-005-20250916    gcc-14
i386        buildonly-randconfig-006-20250916    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250916    clang-18
loongarch             randconfig-002-20250916    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                        m5407c3_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250916    gcc-11.5.0
nios2                 randconfig-002-20250916    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250916    gcc-9.5.0
parisc                randconfig-002-20250916    gcc-13.4.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          g5_defconfig    gcc-15.1.0
powerpc                  mpc866_ads_defconfig    clang-22
powerpc               randconfig-001-20250916    clang-16
powerpc               randconfig-002-20250916    clang-22
powerpc               randconfig-003-20250916    clang-22
powerpc64             randconfig-001-20250916    clang-22
powerpc64             randconfig-002-20250916    gcc-8.5.0
powerpc64             randconfig-003-20250916    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250916    clang-22
riscv                 randconfig-002-20250916    gcc-10.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250916    gcc-13.4.0
s390                  randconfig-002-20250916    gcc-8.5.0
sh                               alldefconfig    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         apsh4a3a_defconfig    gcc-15.1.0
sh                    randconfig-001-20250916    gcc-15.1.0
sh                    randconfig-002-20250916    gcc-15.1.0
sh                        sh7763rdp_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250916    gcc-8.5.0
sparc                 randconfig-002-20250916    gcc-8.5.0
sparc64               randconfig-001-20250916    gcc-11.5.0
sparc64               randconfig-002-20250916    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                    randconfig-001-20250916    gcc-14
um                    randconfig-002-20250916    clang-19
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20250916    gcc-14
x86_64      buildonly-randconfig-002-20250916    clang-20
x86_64      buildonly-randconfig-003-20250916    clang-20
x86_64      buildonly-randconfig-004-20250916    clang-20
x86_64      buildonly-randconfig-005-20250916    clang-20
x86_64      buildonly-randconfig-006-20250916    clang-20
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                  audio_kc705_defconfig    gcc-15.1.0
xtensa                randconfig-001-20250916    gcc-8.5.0
xtensa                randconfig-002-20250916    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


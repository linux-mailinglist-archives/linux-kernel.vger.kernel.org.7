Return-Path: <linux-kernel+bounces-800421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D30B43770
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E4A758569A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F672F747C;
	Thu,  4 Sep 2025 09:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ECfItict"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E822F83C2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 09:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756979100; cv=none; b=oO5qWFcbwcsMaNcQBK5jAINssDx0vIXfPRwWclEkBqKsnqCT6rdXlOdJku141YSpp7TKpnxzxQcOUiKxD+oOHbGWA4hfpBDtB29vihhFDMv0SZYAek6FCFdiUEGdYII2mJFhNbVqLTDneIxxB1cf0+8HMemXxXwo3f0rhQnX9Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756979100; c=relaxed/simple;
	bh=W94vOUz70pBIHGN9IVxetj7JDxTaG0txSfEZJoVe3X8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=e5u+s+27scJO5GWW3GvsHqdQiy2JjK7j1o1YpYPVz5wjbCYiXE+iBK7ttLbCNt6QYYxrpwBZNqBxDzlsc6WIuAlID7a6RRynDj38Nnl6Mb2i77Ag4iFcCDsx6gBNcn6PwvufWapEKZS+On/I0aB+qkeXcBiVhn5d5FushqQA2QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ECfItict; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756979099; x=1788515099;
  h=date:from:to:cc:subject:message-id;
  bh=W94vOUz70pBIHGN9IVxetj7JDxTaG0txSfEZJoVe3X8=;
  b=ECfItictvHSjIkELs22FM6Sd8IoEMjtupNVO2jvsQscl8OZN7gFVnbMk
   hYa1FUcf1Fyik20YjIGaPuY9Q7m0XO/FjHPkgypb18u4gBC9Mw11wEbEl
   Ny8bYHqWAs6IZYo0+KMskQQSZsMkJawgdFTbqOP17wS7JC4B1+hb+T/+B
   lMPC6rnGt0oCY/4tNefi3ACCTQQTi1ePW38f0+5nvMSgeOheZFQrHOcKu
   DYdeMWF870b2rN2FZgTMYTi/lQ+Ws+K+yQ7a7X4SVY7CMzChlD75tyQdv
   7u/vFhqO8eVJS/XTO/FfkK9d/Azx2PzJ3toYHrRxaV4pVKH4eZLTivxYu
   A==;
X-CSE-ConnectionGUID: VZ/bgidJSaSf66QT4Wv4QQ==
X-CSE-MsgGUID: C+TSbjezRiKCZ225EpEnlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="70017039"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="70017039"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 02:44:58 -0700
X-CSE-ConnectionGUID: FtkrvVTYSwKjUJMs/KEpCA==
X-CSE-MsgGUID: znHEsg5bTiCd+ZqfwPEK2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="171423388"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 04 Sep 2025 02:44:51 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uu6Uz-00054Y-0l;
	Thu, 04 Sep 2025 09:43:47 +0000
Date: Thu, 04 Sep 2025 17:37:42 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 5b726e9bf9544a349090879a513a5e00da486c14
Message-ID: <202509041736.nQ1U3dYy-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 5b726e9bf9544a349090879a513a5e00da486c14  sched/fair: Get rid of throttled_lb_pair()

elapsed time: 1493m

configs tested: 100
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250903    gcc-15.1.0
arc                   randconfig-002-20250903    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250903    clang-22
arm                   randconfig-002-20250903    clang-16
arm                   randconfig-003-20250903    clang-22
arm                   randconfig-004-20250903    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250903    gcc-8.5.0
arm64                 randconfig-002-20250903    gcc-11.5.0
arm64                 randconfig-003-20250903    clang-22
arm64                 randconfig-004-20250903    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250903    gcc-9.5.0
csky                  randconfig-002-20250903    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250903    clang-22
hexagon               randconfig-002-20250903    clang-18
i386                             allmodconfig    gcc-13
i386                              allnoconfig    gcc-13
i386                             allyesconfig    gcc-13
i386        buildonly-randconfig-001-20250903    gcc-13
i386        buildonly-randconfig-002-20250903    gcc-13
i386        buildonly-randconfig-003-20250903    clang-20
i386        buildonly-randconfig-004-20250903    clang-20
i386        buildonly-randconfig-005-20250903    clang-20
i386        buildonly-randconfig-006-20250903    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250903    gcc-15.1.0
loongarch             randconfig-002-20250903    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                 randconfig-001-20250903    gcc-10.5.0
nios2                 randconfig-002-20250903    gcc-10.5.0
openrisc                          allnoconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                randconfig-001-20250903    gcc-13.4.0
parisc                randconfig-002-20250903    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20250903    gcc-8.5.0
powerpc               randconfig-002-20250903    gcc-8.5.0
powerpc               randconfig-003-20250903    gcc-14.3.0
powerpc64             randconfig-001-20250903    clang-22
powerpc64             randconfig-002-20250903    clang-22
powerpc64             randconfig-003-20250903    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250903    gcc-8.5.0
riscv                 randconfig-002-20250903    gcc-9.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250903    gcc-8.5.0
s390                  randconfig-002-20250903    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250903    gcc-12.5.0
sh                    randconfig-002-20250903    gcc-10.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250903    gcc-11.5.0
sparc                 randconfig-002-20250903    gcc-15.1.0
sparc64               randconfig-001-20250903    gcc-8.5.0
sparc64               randconfig-002-20250903    gcc-11.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-13
um                    randconfig-001-20250903    gcc-13
um                    randconfig-002-20250903    clang-18
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250903    clang-20
x86_64      buildonly-randconfig-002-20250903    clang-20
x86_64      buildonly-randconfig-003-20250903    clang-20
x86_64      buildonly-randconfig-004-20250903    gcc-13
x86_64      buildonly-randconfig-005-20250903    clang-20
x86_64      buildonly-randconfig-006-20250903    gcc-13
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250903    gcc-11.5.0
xtensa                randconfig-002-20250903    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


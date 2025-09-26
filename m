Return-Path: <linux-kernel+bounces-833797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B203BA31A0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B7853BA3B5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0246B296BB3;
	Fri, 26 Sep 2025 09:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MVvGAU7l"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D18828D829
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758878273; cv=none; b=mjXyOAQ9iU9ndtyevJX0G5D6uMepi+dkUE6QOINf1WgNMaMB+//l1hOWYSNKu5uF4dhZE/2baZu1yB38tXUhTT0TGMJtlgizSVvdVrrM6olXktipYWygTvC9LzpMVlVh8jjgY1pxlvhk6CS8NjPO8qSSRM3dFcU6KWXFb4jJ2Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758878273; c=relaxed/simple;
	bh=bIVCruAjKDRjo1CztZYmPZfOqa4hOL7clCbnfPB0dKQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=a2l9dvAZqrxzAsxoX+FNmlwUueOND5EW94oRw+iUhb6zejuptPiukXWJD1JlOqRpqkbs7nin91jR1+H31WmqbH5qa+0kv1aM1MDwcP3guIYt8AHh/dsTzMOvfrjFm92WQqBz5M2XH0klHWiXj+rTJhlJZIRwryPJwE+8V9+HYd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MVvGAU7l; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758878272; x=1790414272;
  h=date:from:to:cc:subject:message-id;
  bh=bIVCruAjKDRjo1CztZYmPZfOqa4hOL7clCbnfPB0dKQ=;
  b=MVvGAU7lOQxXdV8E6X+CNFU3NAhjYRMCvDy32iS1ewEjWPiZ2tOjLmro
   j1G4h0rUY/0GKO3n5gc03i/jr8ZEKXesCx83M3wwmB4NSpzDPfLDES1Bz
   U3isw84GMNUSTqa6WLraKBBgrbQX1NF4sWsUthgL5kqewu6yMhP3t9K39
   WxSZ/SmmEfEtnWpe9MmZqlHkOU6Glr66zjOYjmOhPyed3TdHJZcgpL72s
   5LHvUoq/W3H5y41Zw6TTxh1Gd+O5ISDvZPteGYcg4aLmpM7T0zFbRhm4J
   uO/jd/D7ty2HneFldlCiGgM2kuqXOuEW5V5MD1eST1sYNJzI0RbbN/UXO
   g==;
X-CSE-ConnectionGUID: WHZKWsqOR0eJdZY8UywwUw==
X-CSE-MsgGUID: sTfO8WpLSY+PF/vneckacQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61160263"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61160263"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 02:17:51 -0700
X-CSE-ConnectionGUID: +APthYNlRe+ubCGtNDnX9w==
X-CSE-MsgGUID: loggRBGQT8ixssS8TBnCxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,294,1751266800"; 
   d="scan'208";a="208500353"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 26 Sep 2025 02:17:49 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v24aJ-00064j-2Z;
	Fri, 26 Sep 2025 09:17:47 +0000
Date: Fri, 26 Sep 2025 17:17:26 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 45b7f780739a3145aeef24d2dfa02517a6c82ed6
Message-ID: <202509261717.BA6pPb9S-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 45b7f780739a3145aeef24d2dfa02517a6c82ed6  sched: Fix some typos in include/linux/preempt.h

elapsed time: 1475m

configs tested: 104
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20250925    gcc-13.4.0
arc                   randconfig-002-20250925    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                         axm55xx_defconfig    clang-22
arm                   randconfig-001-20250925    gcc-11.5.0
arm                   randconfig-002-20250925    gcc-10.5.0
arm                   randconfig-003-20250925    gcc-8.5.0
arm                   randconfig-004-20250925    gcc-14.3.0
arm                        realview_defconfig    clang-16
arm                           stm32_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250925    gcc-11.5.0
arm64                 randconfig-002-20250925    gcc-15.1.0
arm64                 randconfig-003-20250925    clang-19
arm64                 randconfig-004-20250925    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250925    gcc-14.3.0
csky                  randconfig-002-20250925    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250925    clang-22
hexagon               randconfig-002-20250925    clang-22
i386        buildonly-randconfig-001-20250925    clang-20
i386        buildonly-randconfig-002-20250925    clang-20
i386        buildonly-randconfig-003-20250925    gcc-14
i386        buildonly-randconfig-004-20250925    gcc-14
i386        buildonly-randconfig-005-20250925    clang-20
i386        buildonly-randconfig-006-20250925    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250925    clang-18
loongarch             randconfig-002-20250925    gcc-12.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                         10m50_defconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250925    gcc-8.5.0
nios2                 randconfig-002-20250925    gcc-10.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250925    gcc-8.5.0
parisc                randconfig-002-20250925    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20250925    clang-22
powerpc               randconfig-002-20250925    gcc-8.5.0
powerpc               randconfig-003-20250925    gcc-8.5.0
powerpc                     skiroot_defconfig    clang-22
powerpc64             randconfig-001-20250925    clang-22
powerpc64             randconfig-002-20250925    gcc-14.3.0
powerpc64             randconfig-003-20250925    gcc-8.5.0
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250925    clang-22
riscv                 randconfig-002-20250925    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250925    gcc-15.1.0
s390                  randconfig-002-20250925    gcc-13.4.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                        edosk7705_defconfig    gcc-15.1.0
sh                    randconfig-001-20250925    gcc-15.1.0
sh                    randconfig-002-20250925    gcc-13.4.0
sh                          rsk7201_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250925    gcc-15.1.0
sparc                 randconfig-002-20250925    gcc-12.5.0
sparc64               randconfig-001-20250925    gcc-10.5.0
sparc64               randconfig-002-20250925    gcc-10.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                    randconfig-001-20250925    gcc-14
um                    randconfig-002-20250925    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20250925    clang-20
x86_64      buildonly-randconfig-002-20250925    gcc-14
x86_64      buildonly-randconfig-003-20250925    gcc-14
x86_64      buildonly-randconfig-004-20250925    clang-20
x86_64      buildonly-randconfig-005-20250925    clang-20
x86_64      buildonly-randconfig-006-20250925    gcc-14
x86_64                              defconfig    gcc-14
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250925    gcc-12.5.0
xtensa                randconfig-002-20250925    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


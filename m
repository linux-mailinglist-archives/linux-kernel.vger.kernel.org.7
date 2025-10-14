Return-Path: <linux-kernel+bounces-851905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B50ACBD794F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFF861920CCF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517432BF00A;
	Tue, 14 Oct 2025 06:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZvQ4/+1q"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057F825A353
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760423865; cv=none; b=hxMoDLEvMt5dhSOW3Xyy4cIU+eRaiPFo7R7FbC0HQMjdF7VAgcFypbT7UCbQHWNl/gf8oXLm1qm/vF/GBuhoELfRaD3WKMyWFoSbqo48V5HA6e4zjGKlppVL2pmTtlBlsBnzSlspEYAAo8rtrbHbqDhTTjr/Eat63DmkXeB6jug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760423865; c=relaxed/simple;
	bh=NYkvp+p2voCH4RCmlb/xXYOu7wBOq0CPLwcfmkUf/vg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=oY78rNwYCjoHKE7aLP3ZSU/+2BQshStlk5BQsDxetzhh+Us7b+lDRRSs7FQVrRm5QfTHlX7qW5VTc9FEKQ8FFmBRZskY1PzUvYRip30JZX4uxdkoG3fbYAbmIEjKGAjyEP8UQFpNNCTTygPW3Z3NLf1U3d11c8F+iMcyRsqAf6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZvQ4/+1q; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760423864; x=1791959864;
  h=date:from:to:cc:subject:message-id;
  bh=NYkvp+p2voCH4RCmlb/xXYOu7wBOq0CPLwcfmkUf/vg=;
  b=ZvQ4/+1q0XO6cmxm1HxN7XVsWluWUuzJqGwSbG/e/gbrGeeVaIS1u1GE
   cLjJiATErEyFQr+AB2EoPAw1zw8Jj7Ug8pHehwmy03dPNqg/eUeBeFsJZ
   GOTyq4SslcGOl878OVEMdvqW8O/RzIF14824A6AjOL7jmnHX9/PM5bAtW
   9s5CYkmHlC1XhQ/Xy0pbpNO4DgSBmnCr10UdoDM7sPRpwwmkVu6V/8Aop
   3oEGBmSCHi7KtU0e5arxhUKiN/+RgWWZuk1eTOVadQWkgREDSZiBa2yLu
   RjGj05sGz+FLTmE7LO62ttgNn/2cJuEx6lYUrSaL4y4fsDspHmGd1dwzt
   Q==;
X-CSE-ConnectionGUID: EKn4BVMvSDuzh6sI7I0SHg==
X-CSE-MsgGUID: E/fwkGKYTACHzvuLHISyEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="62726421"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="62726421"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 23:37:44 -0700
X-CSE-ConnectionGUID: cw/nR9rUSTC2cWabBA90vw==
X-CSE-MsgGUID: XWl+8Em0SIeHcc9CJLrJgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="181030543"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 13 Oct 2025 23:37:43 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v8Yf9-0002Tn-0a;
	Tue, 14 Oct 2025 06:37:37 +0000
Date: Tue, 14 Oct 2025 14:36:54 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cache] BUILD SUCCESS
 a0a0999507752574b80d7fbd179cce052c92791b
Message-ID: <202510141448.qbWkWT2F-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cache
branch HEAD: a0a0999507752574b80d7fbd179cce052c92791b  x86/resctrl: Support Sub-NUMA Cluster (SNC) mode on Clearwater Forest

elapsed time: 851m

configs tested: 146
configs skipped: 119

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig    clang-19
arc                   randconfig-001-20251014    clang-16
arc                   randconfig-002-20251014    clang-16
arm                   milbeaut_m10v_defconfig    gcc-15.1.0
arm                        multi_v5_defconfig    gcc-15.1.0
arm                   randconfig-001-20251014    clang-16
arm                   randconfig-002-20251014    clang-16
arm                   randconfig-003-20251014    clang-16
arm                   randconfig-004-20251014    clang-16
arm64                 randconfig-001-20251014    clang-16
arm64                 randconfig-002-20251014    clang-16
arm64                 randconfig-003-20251014    clang-16
arm64                 randconfig-004-20251014    clang-16
csky                  randconfig-001-20251014    gcc-8.5.0
csky                  randconfig-002-20251014    gcc-8.5.0
hexagon                          allmodconfig    clang-19
hexagon                          allyesconfig    clang-19
hexagon               randconfig-001-20251014    gcc-8.5.0
hexagon               randconfig-002-20251014    gcc-8.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20251014    gcc-14
i386        buildonly-randconfig-002-20251014    clang-20
i386        buildonly-randconfig-002-20251014    gcc-14
i386        buildonly-randconfig-003-20251014    clang-20
i386        buildonly-randconfig-003-20251014    gcc-14
i386        buildonly-randconfig-004-20251014    gcc-14
i386        buildonly-randconfig-005-20251014    gcc-14
i386        buildonly-randconfig-006-20251014    clang-20
i386        buildonly-randconfig-006-20251014    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251014    clang-20
i386                  randconfig-002-20251014    clang-20
i386                  randconfig-003-20251014    clang-20
i386                  randconfig-004-20251014    clang-20
i386                  randconfig-005-20251014    clang-20
i386                  randconfig-006-20251014    clang-20
i386                  randconfig-007-20251014    clang-20
i386                  randconfig-011-20251014    gcc-14
i386                  randconfig-012-20251014    gcc-14
i386                  randconfig-013-20251014    gcc-14
i386                  randconfig-014-20251014    gcc-14
i386                  randconfig-015-20251014    gcc-14
i386                  randconfig-016-20251014    gcc-14
i386                  randconfig-017-20251014    gcc-14
loongarch                        allmodconfig    clang-19
loongarch             randconfig-001-20251014    gcc-8.5.0
loongarch             randconfig-002-20251014    gcc-8.5.0
m68k                             allmodconfig    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                   sb1250_swarm_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20251014    gcc-8.5.0
nios2                 randconfig-002-20251014    gcc-8.5.0
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-14
parisc                            allnoconfig    clang-22
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251014    gcc-8.5.0
parisc                randconfig-002-20251014    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc               randconfig-001-20251014    gcc-8.5.0
powerpc               randconfig-002-20251014    gcc-8.5.0
powerpc               randconfig-003-20251014    gcc-8.5.0
powerpc                     redwood_defconfig    gcc-15.1.0
powerpc                     tqm8540_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251014    gcc-8.5.0
powerpc64             randconfig-002-20251014    gcc-8.5.0
powerpc64             randconfig-003-20251014    gcc-8.5.0
riscv                             allnoconfig    clang-22
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20251014    gcc-10.5.0
riscv                 randconfig-002-20251014    gcc-10.5.0
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20251014    gcc-10.5.0
s390                  randconfig-002-20251014    gcc-10.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         apsh4a3a_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20251014    gcc-10.5.0
sh                    randconfig-002-20251014    gcc-10.5.0
sh                          sdk7786_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251014    gcc-10.5.0
sparc                 randconfig-002-20251014    gcc-10.5.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251014    gcc-10.5.0
sparc64               randconfig-002-20251014    gcc-10.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251014    gcc-10.5.0
um                    randconfig-002-20251014    gcc-10.5.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251014    gcc-14
x86_64      buildonly-randconfig-002-20251014    clang-20
x86_64      buildonly-randconfig-003-20251014    gcc-14
x86_64      buildonly-randconfig-004-20251014    clang-20
x86_64      buildonly-randconfig-005-20251014    clang-20
x86_64      buildonly-randconfig-006-20251014    gcc-14
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251014    gcc-14
x86_64                randconfig-002-20251014    gcc-14
x86_64                randconfig-003-20251014    gcc-14
x86_64                randconfig-004-20251014    gcc-14
x86_64                randconfig-005-20251014    gcc-14
x86_64                randconfig-006-20251014    gcc-14
x86_64                randconfig-007-20251014    gcc-14
x86_64                randconfig-008-20251014    gcc-14
x86_64                randconfig-071-20251014    gcc-14
x86_64                randconfig-072-20251014    gcc-14
x86_64                randconfig-073-20251014    gcc-14
x86_64                randconfig-074-20251014    gcc-14
x86_64                randconfig-075-20251014    gcc-14
x86_64                randconfig-076-20251014    gcc-14
x86_64                randconfig-077-20251014    gcc-14
x86_64                randconfig-078-20251014    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251014    gcc-10.5.0
xtensa                randconfig-002-20251014    gcc-10.5.0
xtensa                         virt_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


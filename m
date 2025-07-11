Return-Path: <linux-kernel+bounces-727413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C22B019DB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 12:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A115E561DD9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E456228643F;
	Fri, 11 Jul 2025 10:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NzKPsAWy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB2C283C8E
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752230010; cv=none; b=NiKKFlccjudiKl48fpJSZWl8/HDjCpP93c6V933HpHdeJpARE06zqpFsueauuLfaG7St/I9h6EgahJ1bEiQ7GjR1XInsh42SWpqLkdbpzltO7EPXgTo3iebSTX+mLm8KiAtd4etT0SMV/h38DTRgNdOhIaVz7YahR218HhKlyy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752230010; c=relaxed/simple;
	bh=wIn+WptI4DqPix65QQCKTCB0GSIOdAeYVCKcpVSeVr8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=o2cCBuMQLCRNP/qu+fRGIbFbypNQSFDj8Z/1oOoF3T3hNyO+mGOukBGLQINgCly0y3BcM51XliwR4BmfNP7D0qLAosiXRDcV12GaCc25ys/hBV/KychkT0tkBe1oGp2bY4TVqxKVkBTYtTfeKHZI0y2TXMT6ew+hqPpjTLlFn3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NzKPsAWy; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752230008; x=1783766008;
  h=date:from:to:cc:subject:message-id;
  bh=wIn+WptI4DqPix65QQCKTCB0GSIOdAeYVCKcpVSeVr8=;
  b=NzKPsAWyoQiZmXHS+yvdKiLCDFmYwIClRrA9rRkxf9Co+F0URamcHMMn
   CGKhrdfOj5YduI6URhlZSJ2pMNC4S5Bss9mS4ru4QYnjps6/kdOac4vnY
   fuuDJ1bN4CaQNpeAp5HhVjTsdVdNB4xBXpssDzDYha6UHhehKacDypaBa
   tnTzoJS9FYGuTNdI4N4avRrs9yq4W3Bd+Q3tTtvBSsff3C1Rv1MYA9G0l
   rrIx9Eeuz05A0wdVU4vnMqF9t1csSqgF0//Itf/vWD+TC2rTVNpE5hlv3
   RDsbSy4qKsZdFsU+p/NpG4EDidhcoeuEXQCGulQWQ8wSkUE6VluTYiUZz
   A==;
X-CSE-ConnectionGUID: WfRZPZj4TE+K96tm1Bsu4w==
X-CSE-MsgGUID: BhcXZi9zT/69y4YD0qDkTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54243192"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="54243192"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 03:32:19 -0700
X-CSE-ConnectionGUID: BlYe8+GlQdWnyA6p3hWgIQ==
X-CSE-MsgGUID: /iE6104zRFiiobZqivhnxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="160353894"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 11 Jul 2025 03:32:17 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uaB39-0006Gg-0y;
	Fri, 11 Jul 2025 10:32:15 +0000
Date: Fri, 11 Jul 2025 18:31:31 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/core] BUILD SUCCESS
 4fdc3431e03b9c11803f399f91837fca487029a1
Message-ID: <202507111818.jVehZQRx-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
branch HEAD: 4fdc3431e03b9c11803f399f91837fca487029a1  x86/lib: Add WBINVD and WBNOINVD helpers to target multiple CPUs

elapsed time: 1194m

configs tested: 174
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-21
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-21
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250711    gcc-8.5.0
arc                   randconfig-002-20250711    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250711    clang-19
arm                   randconfig-002-20250711    clang-21
arm                   randconfig-003-20250711    gcc-15.1.0
arm                   randconfig-004-20250711    clang-20
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-21
arm64                 randconfig-001-20250711    clang-18
arm64                 randconfig-002-20250711    clang-21
arm64                 randconfig-003-20250711    gcc-12.3.0
arm64                 randconfig-004-20250711    clang-21
csky                              allnoconfig    clang-21
csky                  randconfig-001-20250711    gcc-14.3.0
csky                  randconfig-002-20250711    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250711    clang-19
hexagon               randconfig-002-20250711    clang-21
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250711    gcc-12
i386        buildonly-randconfig-002-20250711    gcc-12
i386        buildonly-randconfig-003-20250711    clang-20
i386        buildonly-randconfig-004-20250711    clang-20
i386        buildonly-randconfig-005-20250711    gcc-11
i386        buildonly-randconfig-006-20250711    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250711    gcc-12
i386                  randconfig-002-20250711    gcc-12
i386                  randconfig-003-20250711    gcc-12
i386                  randconfig-004-20250711    gcc-12
i386                  randconfig-005-20250711    gcc-12
i386                  randconfig-006-20250711    gcc-12
i386                  randconfig-007-20250711    gcc-12
i386                  randconfig-011-20250711    gcc-12
i386                  randconfig-012-20250711    gcc-12
i386                  randconfig-013-20250711    gcc-12
i386                  randconfig-014-20250711    gcc-12
i386                  randconfig-015-20250711    gcc-12
i386                  randconfig-016-20250711    gcc-12
i386                  randconfig-017-20250711    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch             randconfig-001-20250711    clang-21
loongarch             randconfig-002-20250711    clang-21
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-14.2.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250711    gcc-10.5.0
nios2                 randconfig-002-20250711    gcc-14.2.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250711    gcc-12.4.0
parisc                randconfig-002-20250711    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc               randconfig-001-20250711    clang-18
powerpc               randconfig-002-20250711    clang-21
powerpc               randconfig-003-20250711    clang-21
powerpc64             randconfig-001-20250711    clang-21
powerpc64             randconfig-002-20250711    clang-21
powerpc64             randconfig-003-20250711    gcc-13.4.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250711    gcc-8.5.0
riscv                 randconfig-002-20250711    gcc-12.4.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250711    clang-21
s390                  randconfig-002-20250711    gcc-10.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250711    gcc-12.4.0
sh                    randconfig-002-20250711    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250711    gcc-10.3.0
sparc                 randconfig-002-20250711    gcc-12.4.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250711    gcc-8.5.0
sparc64               randconfig-002-20250711    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250711    clang-20
um                    randconfig-002-20250711    clang-19
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250710    gcc-12
x86_64      buildonly-randconfig-002-20250710    gcc-12
x86_64      buildonly-randconfig-003-20250710    gcc-12
x86_64      buildonly-randconfig-004-20250710    clang-20
x86_64      buildonly-randconfig-005-20250710    clang-20
x86_64      buildonly-randconfig-006-20250710    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250711    clang-20
x86_64                randconfig-002-20250711    clang-20
x86_64                randconfig-003-20250711    clang-20
x86_64                randconfig-004-20250711    clang-20
x86_64                randconfig-005-20250711    clang-20
x86_64                randconfig-006-20250711    clang-20
x86_64                randconfig-007-20250711    clang-20
x86_64                randconfig-008-20250711    clang-20
x86_64                randconfig-071-20250711    clang-20
x86_64                randconfig-072-20250711    clang-20
x86_64                randconfig-073-20250711    clang-20
x86_64                randconfig-074-20250711    clang-20
x86_64                randconfig-075-20250711    clang-20
x86_64                randconfig-076-20250711    clang-20
x86_64                randconfig-077-20250711    clang-20
x86_64                randconfig-078-20250711    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250711    gcc-9.3.0
xtensa                randconfig-002-20250711    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-kernel+bounces-779320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C31E8B2F25A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 752857B1CE5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F67257821;
	Thu, 21 Aug 2025 08:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P1l336SE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177F22BD001
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755765442; cv=none; b=VXjVk4vTaBZEmcIqGmzSFRJ3xSUa+LJhAxlNkOYjjMJ3nV4Hw/neIjM9P4sXc9JFWFNuzrRpIcBYp3pzBtle0lYAJAxZPEnwVgKbiTtF8m+6dUuQGsx8zj46B/O1AcnjSdPQbsEevcuRIFoMB2TKuGHClco6jXpVGWWcbJdExck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755765442; c=relaxed/simple;
	bh=u5k3iWtHl1CFnP2ObVOpx7hcnofLIlRbyAoG0KUteK8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=aVhl5gdg5jkLjReKP4K8fKQoEveA47JPGpINTn5HZDaiRv7ORA44kBV/WIfvia1+99kdvpE4g/qJGQeZOYT4LO/2lXanppm2lKYAvw04uJCxyXx2O2kYaGRGSZQfThDm/dYl8NQGVcBRDMTVJy7vbiaIBc8n33glxzb54Zg4KCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P1l336SE; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755765441; x=1787301441;
  h=date:from:to:cc:subject:message-id;
  bh=u5k3iWtHl1CFnP2ObVOpx7hcnofLIlRbyAoG0KUteK8=;
  b=P1l336SEfoyz7REqJAVFbqNTLNi89+bpOjWB3zLs5Vp0naWMLoS5vl76
   69e8cyrvK5xariVsLO8xaefOy9ofKTk9D79FpL5nBzFaBndHsh1n4BWb5
   LCmDqzn0mLHO896yrv3hT2Dh5XW8PDP4dg287j1YDiHePpTTQ+fZOvc7P
   9leQfBfIZwC9EYUK7f9O9IzoRYdxrfnfNYHQGsFpP9KvYB3vyjonSj8jC
   DfJnq7sEpi+BN5060zHgA1suLtnltdcMUewDWmsXv9vi7s6VclTXqvhwQ
   tdmgIPvfyeX0YSoRKqmr6H/bJhEL+mfWiML1w5xZuzBZRtjTFKP1yfiAD
   w==;
X-CSE-ConnectionGUID: zBmFWdhkRJmqj4qWVXAVgw==
X-CSE-MsgGUID: dxvUOs47T0C1Lw9SOtoATg==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="69422338"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="69422338"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 01:37:20 -0700
X-CSE-ConnectionGUID: 7sS6YkCkQvmmbxrFVXTmuA==
X-CSE-MsgGUID: LKMqhqZnS+GW9Mo2adMUsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="168275257"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 21 Aug 2025 01:37:19 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1up0nM-000K6N-3D;
	Thu, 21 Aug 2025 08:37:16 +0000
Date: Thu, 21 Aug 2025 16:36:38 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 a35da57357221a989e59ced9407ba4f2d4d6d2d2
Message-ID: <202508211632.1qTKoa3E-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: a35da57357221a989e59ced9407ba4f2d4d6d2d2  crypto: x86 - Remove CONFIG_AS_GFNI

elapsed time: 816m

configs tested: 149
configs skipped: 120

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                            allyesconfig    clang-19
arc                               allnoconfig    clang-22
arc                   randconfig-001-20250821    clang-22
arc                   randconfig-002-20250821    clang-22
arm                               allnoconfig    clang-22
arm                       imx_v6_v7_defconfig    clang-22
arm                   randconfig-001-20250821    clang-22
arm                   randconfig-002-20250821    clang-22
arm                   randconfig-003-20250821    clang-22
arm                   randconfig-004-20250821    clang-22
arm                           stm32_defconfig    clang-22
arm                        vexpress_defconfig    clang-22
arm64                             allnoconfig    clang-22
arm64                 randconfig-001-20250821    clang-22
arm64                 randconfig-002-20250821    clang-22
arm64                 randconfig-003-20250821    clang-22
arm64                 randconfig-004-20250821    clang-22
csky                              allnoconfig    clang-22
csky                  randconfig-001-20250821    clang-22
csky                  randconfig-002-20250821    clang-22
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon               randconfig-001-20250821    clang-22
hexagon               randconfig-002-20250821    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250821    gcc-12
i386        buildonly-randconfig-002-20250821    gcc-12
i386        buildonly-randconfig-003-20250821    clang-20
i386        buildonly-randconfig-003-20250821    gcc-12
i386        buildonly-randconfig-004-20250821    gcc-12
i386        buildonly-randconfig-005-20250821    gcc-12
i386        buildonly-randconfig-006-20250821    clang-20
i386        buildonly-randconfig-006-20250821    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250821    gcc-11
i386                  randconfig-002-20250821    gcc-11
i386                  randconfig-003-20250821    gcc-11
i386                  randconfig-004-20250821    gcc-11
i386                  randconfig-005-20250821    gcc-11
i386                  randconfig-006-20250821    gcc-11
i386                  randconfig-007-20250821    gcc-11
i386                  randconfig-011-20250821    gcc-12
i386                  randconfig-012-20250821    gcc-12
i386                  randconfig-013-20250821    gcc-12
i386                  randconfig-014-20250821    gcc-12
i386                  randconfig-015-20250821    gcc-12
i386                  randconfig-016-20250821    gcc-12
i386                  randconfig-017-20250821    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250821    clang-22
loongarch             randconfig-002-20250821    clang-22
m68k                             allmodconfig    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
mips                              allnoconfig    gcc-15.1.0
mips                   sb1250_swarm_defconfig    clang-22
nios2                             allnoconfig    gcc-15.1.0
nios2                 randconfig-001-20250821    clang-22
nios2                 randconfig-002-20250821    clang-22
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-12
parisc                            allnoconfig    clang-22
parisc                randconfig-001-20250821    clang-22
parisc                randconfig-002-20250821    clang-22
powerpc                           allnoconfig    clang-22
powerpc               mpc834x_itxgp_defconfig    clang-22
powerpc                      ppc44x_defconfig    clang-22
powerpc               randconfig-001-20250821    clang-22
powerpc               randconfig-002-20250821    clang-22
powerpc               randconfig-003-20250821    clang-22
powerpc64             randconfig-002-20250821    clang-22
powerpc64             randconfig-003-20250821    clang-22
riscv                             allnoconfig    clang-22
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250821    clang-18
riscv                 randconfig-002-20250821    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250821    clang-18
s390                  randconfig-002-20250821    clang-18
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                ecovec24-romimage_defconfig    clang-22
sh                    randconfig-001-20250821    clang-18
sh                    randconfig-002-20250821    clang-18
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250821    clang-18
sparc                 randconfig-002-20250821    clang-18
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250821    clang-18
sparc64               randconfig-002-20250821    clang-18
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250821    clang-18
um                    randconfig-002-20250821    clang-18
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250821    clang-20
x86_64      buildonly-randconfig-002-20250821    clang-20
x86_64      buildonly-randconfig-003-20250821    clang-20
x86_64      buildonly-randconfig-004-20250821    clang-20
x86_64      buildonly-randconfig-004-20250821    gcc-12
x86_64      buildonly-randconfig-005-20250821    clang-20
x86_64      buildonly-randconfig-006-20250821    clang-20
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250821    clang-20
x86_64                randconfig-002-20250821    clang-20
x86_64                randconfig-003-20250821    clang-20
x86_64                randconfig-004-20250821    clang-20
x86_64                randconfig-005-20250821    clang-20
x86_64                randconfig-006-20250821    clang-20
x86_64                randconfig-007-20250821    clang-20
x86_64                randconfig-008-20250821    clang-20
x86_64                randconfig-071-20250821    clang-20
x86_64                randconfig-072-20250821    clang-20
x86_64                randconfig-073-20250821    clang-20
x86_64                randconfig-074-20250821    clang-20
x86_64                randconfig-075-20250821    clang-20
x86_64                randconfig-076-20250821    clang-20
x86_64                randconfig-077-20250821    clang-20
x86_64                randconfig-078-20250821    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250821    clang-18
xtensa                randconfig-002-20250821    clang-18

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


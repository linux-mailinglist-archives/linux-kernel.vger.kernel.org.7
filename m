Return-Path: <linux-kernel+bounces-772300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EEDB29102
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 02:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 565AC480010
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 00:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC104AEE2;
	Sun, 17 Aug 2025 00:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D4XOz9XE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A58645
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 00:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755390138; cv=none; b=Lkbf/MmWcLYMtzrAHUWbe41bs2dvU5eWjzzbWYe3OaSW/OzXUwKCgBZSQtYjHw2uhQSPtG16DH/8ZIAoFyJs+q55wtXKRz/BlqAhjQerjXwUNvmCetbdFa3pAedEenuZsWhgQtB1myZsup6ZfjV03xSHSRXqsTAgjQedK3zcn1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755390138; c=relaxed/simple;
	bh=HzUS/ANJZ+pP1UEOuT1DGIETiwEnSHfyFvRZtXTD+/0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DP7kJ/5tc4fK78u/eLcrZ5K1/NnLe5x/3sWQwMC1Zsy09sIbIu7T5VA07Sb/J06rnUMbd/bg7izp+o07FcNqky5n5/TdT+hCjpdHBrN48ZGzdyN30B1x5YjfPDBNDHdNZH63dew7TqN0ke3nobV2AbElk3Xi3pcLWQ/v04XUgm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D4XOz9XE; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755390137; x=1786926137;
  h=date:from:to:cc:subject:message-id;
  bh=HzUS/ANJZ+pP1UEOuT1DGIETiwEnSHfyFvRZtXTD+/0=;
  b=D4XOz9XEVfRORQfKEMqz7QjXr8DX79KD2NqqUH3Y0YLmzDwtkh5PX/O4
   D1gn9nrzVMWNaI5jTzi5Nvfi8HY3bg7dEgHmajzGPDO2bS9JVdkQI3nI+
   PsQ9cJ5j07x2VspTbSHAx4B5CeJA4C+aCeSsbFYrkJ4vK8bA7nl8zzeyx
   aJsTr4EBx77GKjx99zLMQwppQZHtwLBzC/6jc7TkIqqjd8NkAg2KCC6w5
   ksqSUlNGHIGwCqy51sXf7mwlyxuqlJJfnPUIGu4YqdnchdFPTDaHzl+65
   TVyon5O+3Yl2B7wcjjGwcotUaabN4lC5NeMa6ZXvoU2uADSsdj9htyu3A
   w==;
X-CSE-ConnectionGUID: 89aSn+94Rpe2nKVgTBWsLQ==
X-CSE-MsgGUID: Y7HYrZgsQwKibGOJ1gKnCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="69030365"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="69030365"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2025 17:22:16 -0700
X-CSE-ConnectionGUID: OofRZ+L6QB6hJdA5urRQ/A==
X-CSE-MsgGUID: o4mZTqjHQFKxXFeSn+x4ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="204450027"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 16 Aug 2025 17:22:16 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1unR9o-000DHD-0o;
	Sun, 17 Aug 2025 00:22:08 +0000
Date: Sun, 17 Aug 2025 08:21:54 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:tip/urgent] BUILD SUCCESS
 bfc22e5ae0a8375d2b9cb83f0194e7aca1283eb2
Message-ID: <202508170849.qgLhnJjQ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tip/urgent
branch HEAD: bfc22e5ae0a8375d2b9cb83f0194e7aca1283eb2  Merge branch into tip/master: 'x86/urgent'

elapsed time: 1057m

configs tested: 122
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250816    gcc-8.5.0
arc                   randconfig-002-20250816    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                        keystone_defconfig    gcc-15.1.0
arm                          pxa910_defconfig    gcc-15.1.0
arm                   randconfig-001-20250816    gcc-12.5.0
arm                   randconfig-002-20250816    gcc-10.5.0
arm                   randconfig-003-20250816    gcc-10.5.0
arm                   randconfig-004-20250816    gcc-10.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250816    clang-22
arm64                 randconfig-002-20250816    clang-22
arm64                 randconfig-003-20250816    gcc-8.5.0
arm64                 randconfig-004-20250816    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250816    gcc-15.1.0
csky                  randconfig-002-20250816    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250816    clang-19
hexagon               randconfig-002-20250816    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250816    clang-20
i386        buildonly-randconfig-002-20250816    gcc-12
i386        buildonly-randconfig-003-20250816    gcc-12
i386        buildonly-randconfig-004-20250816    gcc-12
i386        buildonly-randconfig-005-20250816    gcc-12
i386        buildonly-randconfig-006-20250816    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250816    gcc-15.1.0
loongarch             randconfig-002-20250816    gcc-14.3.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                       bvme6000_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          eyeq5_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250816    gcc-10.5.0
nios2                 randconfig-002-20250816    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250816    gcc-10.5.0
parisc                randconfig-002-20250816    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250816    clang-20
powerpc               randconfig-002-20250816    clang-22
powerpc               randconfig-003-20250816    clang-22
powerpc64             randconfig-001-20250816    gcc-8.5.0
powerpc64             randconfig-002-20250816    clang-22
powerpc64             randconfig-003-20250816    clang-16
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250816    clang-22
riscv                 randconfig-002-20250816    gcc-13.4.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250816    clang-22
s390                  randconfig-002-20250816    gcc-12.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250816    gcc-15.1.0
sh                    randconfig-002-20250816    gcc-12.5.0
sh                          rsk7203_defconfig    gcc-15.1.0
sh                           se7722_defconfig    gcc-15.1.0
sh                        sh7757lcr_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250816    gcc-15.1.0
sparc                 randconfig-002-20250816    gcc-15.1.0
sparc64               randconfig-001-20250816    gcc-11.5.0
sparc64               randconfig-002-20250816    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                    randconfig-001-20250816    gcc-12
um                    randconfig-002-20250816    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250816    gcc-12
x86_64      buildonly-randconfig-002-20250816    gcc-12
x86_64      buildonly-randconfig-003-20250816    gcc-12
x86_64      buildonly-randconfig-004-20250816    clang-20
x86_64      buildonly-randconfig-005-20250816    clang-20
x86_64      buildonly-randconfig-006-20250816    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250816    gcc-10.5.0
xtensa                randconfig-002-20250816    gcc-9.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


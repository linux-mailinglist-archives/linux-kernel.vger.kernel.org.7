Return-Path: <linux-kernel+bounces-846288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE9FBC77A5
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 08:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6F4919E2A09
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 06:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E79290D81;
	Thu,  9 Oct 2025 06:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W3PL2kKt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD02824BD
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 06:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759989713; cv=none; b=mMiwsrqddYfYvAjOV9rrKnvoGBBgpGwKWYWTkNN6/Jmei1XN3Loy4DyCKlsfVPg6wRVXODST+4wAhv09kMQXxgop1XG07UE701ROaEaG+9dNRgJLXneqaPQ7ZEX04pgQRjRACQ/rOGftCtqpDEyAC49wEMOEyl2bVTLaNbK6i3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759989713; c=relaxed/simple;
	bh=LDdcqJn+iMLubgZOuOTPj06VLecleJD/h9z8nx5pgNI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=X6ETRFsz2effvPwNc6dRyzF65xtYu487WFSU0+UQBTdWygH4LpsvlodBRIa42NtDZ64Oi4HURCwN7QD+jvseHXNbFRPqJsbg7IaUio453pEnQN2+q2+253VWZwpsVyLkV7WO5nFImyZc4oFCbNAjYLyCoH+zEt8nzEku9kY5gEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W3PL2kKt; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759989712; x=1791525712;
  h=date:from:to:cc:subject:message-id;
  bh=LDdcqJn+iMLubgZOuOTPj06VLecleJD/h9z8nx5pgNI=;
  b=W3PL2kKtk5+zg7HlwhHKpUlv+eaOWuYluh/dFjtGNQezdjdULkZODLA1
   TfCU13/yUAAop7LZctfGf/xfTft4o/K1Mxbz92wUYIqPQVTf5kfAIGSwF
   KhFMI0Axvt+KCQhd7aw+kuC7rmzoAVx1/Sitza0FHRcasu+PIyDGZtNve
   tZ4HW0UjpxE+ek5u1/lz6qSapZ4fjPTeDtiVULds1gCNlRbdj6h3Q4u7B
   RBVhnEL6RFeXBTHFN7N0ez8lMFTWS7UN7dDSIs69OlTRw99H0rHQgI7rn
   h7MygzyBD7Vg02wV0fZVlonTvaaTGwKYi040nMfSClsVYoGICxNvNuAlE
   Q==;
X-CSE-ConnectionGUID: Q2XhbL+FQaCo35UK6yhq+w==
X-CSE-MsgGUID: u3wTh1RyTPO7wtHWUddZ0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="73619912"
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; 
   d="scan'208";a="73619912"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 23:01:51 -0700
X-CSE-ConnectionGUID: R41BchXHQkSgVEM5FL/YGg==
X-CSE-MsgGUID: K65GZ6FxQQ6KkGcpzceq6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; 
   d="scan'208";a="185003427"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 08 Oct 2025 23:01:50 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v6jim-00002x-1A;
	Thu, 09 Oct 2025 06:01:48 +0000
Date: Thu, 09 Oct 2025 14:01:10 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2025.10.02a] BUILD SUCCESS
 cd11bc508dd46dfd976ed66e8bf6a8136a779cdf
Message-ID: <202510091405.PRgKx08m-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2025.10.02a
branch HEAD: cd11bc508dd46dfd976ed66e8bf6a8136a779cdf  fixup! torture: Add kvm-series.sh to test commit/scenario combination

elapsed time: 6942m

configs tested: 94
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20251004    gcc-8.5.0
arc                   randconfig-002-20251004    gcc-10.5.0
arc                        vdk_hs38_defconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                   randconfig-001-20251004    gcc-8.5.0
arm                   randconfig-002-20251004    gcc-15.1.0
arm                   randconfig-003-20251004    gcc-12.5.0
arm                   randconfig-004-20251004    gcc-11.5.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251004    clang-20
arm64                 randconfig-002-20251004    gcc-8.5.0
arm64                 randconfig-003-20251004    clang-22
arm64                 randconfig-004-20251004    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251004    gcc-15.1.0
csky                  randconfig-002-20251004    gcc-10.5.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20251004    clang-22
hexagon               randconfig-002-20251004    clang-20
i386        buildonly-randconfig-001-20251004    gcc-13
i386        buildonly-randconfig-002-20251004    clang-20
i386        buildonly-randconfig-003-20251004    clang-20
i386        buildonly-randconfig-004-20251004    clang-20
i386        buildonly-randconfig-005-20251004    clang-20
i386        buildonly-randconfig-006-20251004    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20251004    gcc-15.1.0
loongarch             randconfig-002-20251004    clang-22
m68k                             alldefconfig    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                   sb1250_swarm_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251004    gcc-10.5.0
nios2                 randconfig-002-20251004    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251004    gcc-8.5.0
parisc                randconfig-002-20251004    gcc-13.4.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                  mpc866_ads_defconfig    clang-22
powerpc               randconfig-001-20251004    clang-22
powerpc               randconfig-002-20251004    gcc-8.5.0
powerpc               randconfig-003-20251004    clang-22
powerpc64             randconfig-001-20251004    gcc-14.3.0
powerpc64             randconfig-002-20251004    clang-22
powerpc64             randconfig-003-20251004    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20251004    clang-22
riscv                 randconfig-002-20251004    clang-22
s390                              allnoconfig    clang-22
s390                  randconfig-001-20251004    gcc-8.5.0
s390                  randconfig-002-20251004    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                        edosk7705_defconfig    gcc-15.1.0
sh                    randconfig-001-20251004    gcc-15.1.0
sh                    randconfig-002-20251004    gcc-15.1.0
sh                          rsk7201_defconfig    gcc-15.1.0
sh                           se7206_defconfig    gcc-15.1.0
sh                           sh2007_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251004    gcc-8.5.0
sparc                 randconfig-002-20251004    gcc-15.1.0
sparc64               randconfig-001-20251004    gcc-14.3.0
sparc64               randconfig-002-20251004    clang-22
um                                allnoconfig    clang-22
um                    randconfig-001-20251004    clang-18
um                    randconfig-002-20251004    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251004    gcc-14
x86_64      buildonly-randconfig-002-20251004    clang-20
x86_64      buildonly-randconfig-003-20251004    clang-20
x86_64      buildonly-randconfig-004-20251004    clang-20
x86_64      buildonly-randconfig-005-20251004    gcc-14
x86_64      buildonly-randconfig-006-20251004    gcc-14
x86_64                              defconfig    gcc-14
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251004    gcc-13.4.0
xtensa                randconfig-002-20251004    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


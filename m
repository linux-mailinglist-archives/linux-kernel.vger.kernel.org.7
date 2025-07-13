Return-Path: <linux-kernel+bounces-728869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6B8B02E47
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 02:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CB10189D4CC
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 00:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCA18F6F;
	Sun, 13 Jul 2025 00:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cN0MZDc7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CB31876
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 00:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752366826; cv=none; b=ZkzAqL6TFF8f2u+y2In0W85zoXq1g7tCOckOC8YcTJLDnTeD62ZHHLl7q2SIp58uzXcowwJorchB25/IP8R6fo0u1vI5lZVGCMWB8eMHQCu2H9N9TqjPxZAf5ox91oJ9ieHLl665h9pqN95ArV/lItaZ9ZPzGuquq4KpnGZEGpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752366826; c=relaxed/simple;
	bh=eRFIspVpUJA4qN0N3W48ScaGvVVuz5bBF4GY5gyxkvk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=C8zj3JBmTKfVMK2dx1WIYJItBfvwtFTkPbLGFF536JeUCRHCzqDvNLRsNzbb9n5Hd5iSTlk2C86hyz2JmjYJ4UH887QF3KKWrO1L59XXpIqKiOyo9ejCvnERLudU/XY9CrN4uR2NQan3jG56dLSlbDt4pxtEL27qeeGNGhJwt4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cN0MZDc7; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752366825; x=1783902825;
  h=date:from:to:cc:subject:message-id;
  bh=eRFIspVpUJA4qN0N3W48ScaGvVVuz5bBF4GY5gyxkvk=;
  b=cN0MZDc7mwCzOIUdUEdBzfItSFQvwSOVdt7vrQe6Obo2RdmGVmu7GHio
   HSV59u2F2eBvnqcZPcWr3h3g/S2E6mvJRVuitKR2Qx70KuDf9DLq9MIp7
   XpZD1+ORI1U03kz8Qzxo68FtRwLa/1/lPPrUxf4txxQajxtzLn1k65YuG
   g4pnlqsobeq44DGX9xuSSmgcpUOHSoCP7pwUVMBXRZ34jXrRDmm90l6KQ
   SQPx75ozOES2fc5WtH/cLQHLCqkcUIwMpyR+ASvr/ttAc6Jl6iOWmYlDC
   EvQmWuTZ27COEdSRPN1J7c7hj3rtgHNXu5/nbAcWIrpozGyXIqu1nfdOm
   Q==;
X-CSE-ConnectionGUID: S3JPW4jbT4SBmf7MLSE1Pg==
X-CSE-MsgGUID: P9lTKkfBTxKaCnryVpN5gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="65675486"
X-IronPort-AV: E=Sophos;i="6.16,307,1744095600"; 
   d="scan'208";a="65675486"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2025 17:33:41 -0700
X-CSE-ConnectionGUID: 0AyKmiijR7W6IFQ3gAp5FQ==
X-CSE-MsgGUID: 9bL1NeBNRCeoQhyxkWfbKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,307,1744095600"; 
   d="scan'208";a="156052312"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 12 Jul 2025 17:33:40 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uakev-0007mZ-1I;
	Sun, 13 Jul 2025 00:33:37 +0000
Date: Sun, 13 Jul 2025 08:32:52 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev] BUILD SUCCESS
 a326e72a6362a0c8f5d12e950fdd8ca4553f4664
Message-ID: <202507130840.LiBizVMb-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
branch HEAD: a326e72a6362a0c8f5d12e950fdd8ca4553f4664  EXP arm64: enable PREEMPT_LAZY

elapsed time: 1442m

configs tested: 81
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20250712    gcc-10.5.0
arc                   randconfig-002-20250712    gcc-13.4.0
arm                               allnoconfig    clang-21
arm                   randconfig-001-20250712    gcc-8.5.0
arm                   randconfig-002-20250712    gcc-10.5.0
arm                   randconfig-003-20250712    clang-21
arm                   randconfig-004-20250712    clang-21
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250712    gcc-12.3.0
arm64                 randconfig-002-20250712    gcc-12.3.0
arm64                 randconfig-003-20250712    gcc-8.5.0
arm64                 randconfig-004-20250712    gcc-13.4.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250712    gcc-14.3.0
csky                  randconfig-002-20250712    gcc-11.5.0
hexagon                           allnoconfig    clang-21
hexagon               randconfig-001-20250712    clang-21
hexagon               randconfig-002-20250712    clang-18
i386        buildonly-randconfig-001-20250712    clang-20
i386        buildonly-randconfig-002-20250712    gcc-11
i386        buildonly-randconfig-003-20250712    gcc-12
i386        buildonly-randconfig-004-20250712    gcc-12
i386        buildonly-randconfig-005-20250712    gcc-12
i386        buildonly-randconfig-006-20250712    clang-20
loongarch                         allnoconfig    clang-21
loongarch             randconfig-001-20250712    gcc-15.1.0
loongarch             randconfig-002-20250712    gcc-14.3.0
m68k                              allnoconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250712    gcc-11.5.0
nios2                 randconfig-002-20250712    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250712    gcc-8.5.0
parisc                randconfig-002-20250712    gcc-12.4.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20250712    gcc-15.1.0
powerpc               randconfig-002-20250712    gcc-8.5.0
powerpc               randconfig-003-20250712    clang-21
powerpc64             randconfig-002-20250712    clang-21
powerpc64             randconfig-003-20250712    clang-19
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250712    gcc-8.5.0
riscv                 randconfig-002-20250712    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250712    clang-21
s390                  randconfig-002-20250712    clang-21
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250712    gcc-15.1.0
sh                    randconfig-002-20250712    gcc-14.3.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250712    gcc-13.4.0
sparc                 randconfig-002-20250712    gcc-15.1.0
sparc64               randconfig-001-20250712    clang-20
sparc64               randconfig-002-20250712    gcc-14.3.0
um                                allnoconfig    clang-21
um                    randconfig-001-20250712    gcc-12
um                    randconfig-002-20250712    clang-21
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20250712    gcc-12
x86_64      buildonly-randconfig-002-20250712    gcc-12
x86_64      buildonly-randconfig-003-20250712    clang-20
x86_64      buildonly-randconfig-004-20250712    clang-20
x86_64      buildonly-randconfig-005-20250712    gcc-12
x86_64      buildonly-randconfig-006-20250712    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250712    gcc-8.5.0
xtensa                randconfig-002-20250712    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


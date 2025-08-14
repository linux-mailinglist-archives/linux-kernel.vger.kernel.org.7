Return-Path: <linux-kernel+bounces-769069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2280AB269D4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 554B2603829
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7EE212B31;
	Thu, 14 Aug 2025 14:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="criA7+fh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537401DE3A7
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755181925; cv=none; b=OXGLHyq8isqOowhpusEpEHWNkgSpCFUXuBuZVbiAuSTLGepW7qraojYYNZxC3itZJ7icsP5Fx4uZcwrpo0whc9g/YV2V2q2iXxidoNAbs6THUHFWW4CEcrkVl1waV1z4DovbG8BJpYiQxRo9nJC3+y3YakrmkPiT8wYddjsM4k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755181925; c=relaxed/simple;
	bh=bRxQEGQritKo6hvebzuEHHPhSGevunmErjAdGHTJibI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=o4h2uqS77KYvKBn9DiqGwM+dzI1FgwUBcRDKHYvIqwXDN739dn07kkdPZ/WfXW4oU3lpU3T5fnmoEBlGCFFGxM/J1roipm/f4mWA2/gweIP3crcIz1MUDdovdOhIFFRtUStbCt1EqbTzqMb7my0L4W5CSRhtzi1DLsgfPnHIHJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=criA7+fh; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755181923; x=1786717923;
  h=date:from:to:cc:subject:message-id;
  bh=bRxQEGQritKo6hvebzuEHHPhSGevunmErjAdGHTJibI=;
  b=criA7+fhnP30NmzW4gTcVyQj5tzidf8h+7bbjxrIMKxb0ZvUDBrNaWbK
   pyx+yEtAfG02nXdyGtV2zDtui3I4AXZu2Wna2mR4wgUowe8H1XrGtK+t+
   QCRULvLatu4YevaOCXApZy3TmcrjST2ynMQkE4NqQfe6to2rZGMRA2jnV
   L1cKmyDc0rAXt0RhKX0oRyIOVYLeo3OqOYgTHR2jytlU7MMgjbzZ3nDTT
   QNXb0V6nwS8irYSJdeewvPep5zyDYDdnlJGQuZpRIsJJUAUd6KBTENi6F
   vKucgcJ535qAowHO6W/0M/NzHeb/Tn+oGqjJtmAQfEv7CQVRHp6r1QndS
   g==;
X-CSE-ConnectionGUID: W5D20fjqTN2DDXwigV/Kyw==
X-CSE-MsgGUID: ISClBmUIRQq5STWTkFQaQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="68103882"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="68103882"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 07:32:02 -0700
X-CSE-ConnectionGUID: lTF9n0iuRKWUSaMmjI73PA==
X-CSE-MsgGUID: s/9900L6Tf6fBIFy2ZM4FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="166684537"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 14 Aug 2025 07:32:02 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umYzn-000B2S-2E;
	Thu, 14 Aug 2025 14:31:59 +0000
Date: Thu, 14 Aug 2025 22:31:18 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:locking/urgent] BUILD SUCCESS
 21924af67d69d7c9fdaf845be69043cfe75196a1
Message-ID: <202508142204.Aw6oYUoM-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/urgent
branch HEAD: 21924af67d69d7c9fdaf845be69043cfe75196a1  locking: Fix __clear_task_blocked_on() warning from __ww_mutex_wound() path

elapsed time: 1448m

configs tested: 113
configs skipped: 3

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
arc                   randconfig-001-20250813    gcc-11.5.0
arc                   randconfig-002-20250813    gcc-8.5.0
arc                    vdk_hs38_smp_defconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250813    clang-22
arm                   randconfig-002-20250813    gcc-8.5.0
arm                   randconfig-003-20250813    clang-22
arm                   randconfig-004-20250813    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250813    clang-22
arm64                 randconfig-002-20250813    gcc-12.5.0
arm64                 randconfig-003-20250813    clang-22
arm64                 randconfig-004-20250813    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250813    gcc-14.3.0
csky                  randconfig-002-20250813    gcc-13.4.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250813    clang-22
hexagon               randconfig-002-20250813    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250813    gcc-11
i386        buildonly-randconfig-002-20250813    clang-20
i386        buildonly-randconfig-003-20250813    gcc-11
i386        buildonly-randconfig-004-20250813    clang-20
i386        buildonly-randconfig-005-20250813    gcc-12
i386        buildonly-randconfig-006-20250813    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250813    clang-19
loongarch             randconfig-002-20250813    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                       m5249evb_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250813    gcc-11.5.0
nios2                 randconfig-002-20250813    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250813    gcc-14.3.0
parisc                randconfig-002-20250813    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20250813    clang-18
powerpc               randconfig-002-20250813    clang-22
powerpc               randconfig-003-20250813    clang-20
powerpc64             randconfig-001-20250813    clang-22
powerpc64             randconfig-002-20250813    gcc-8.5.0
powerpc64             randconfig-003-20250813    clang-17
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250813    clang-22
riscv                 randconfig-002-20250813    gcc-14.3.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250813    clang-22
s390                  randconfig-002-20250813    clang-18
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250813    gcc-9.5.0
sh                    randconfig-002-20250813    gcc-9.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250813    gcc-8.5.0
sparc                 randconfig-002-20250813    gcc-15.1.0
sparc64               randconfig-001-20250813    gcc-8.5.0
sparc64               randconfig-002-20250813    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                    randconfig-001-20250813    gcc-12
um                    randconfig-002-20250813    gcc-11
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250813    gcc-12
x86_64      buildonly-randconfig-002-20250813    clang-20
x86_64      buildonly-randconfig-003-20250813    gcc-12
x86_64      buildonly-randconfig-004-20250813    clang-20
x86_64      buildonly-randconfig-005-20250813    clang-20
x86_64      buildonly-randconfig-006-20250813    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250813    gcc-10.5.0
xtensa                randconfig-002-20250813    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


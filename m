Return-Path: <linux-kernel+bounces-757195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 890ECB1BEF0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 05:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 449BD6256E0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 03:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEE11C84DE;
	Wed,  6 Aug 2025 03:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B99+xUNe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E963D2E3718
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 03:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754449245; cv=none; b=LnJoy3sitLB3vCd0bqg2Ah2emBq/dftzmQLV3lJNyz9GM8nyt68lNXSxdHEH49Nqia25EW0U0dLzmP/o2L6aorZ7gNSf49GbEpp6E2udu+R5hsMPOPm2AC1GMAr+BMMedf2EwjxqlUocYqqwcemZHWKPE9oTJ5lFP9x2cyTTi5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754449245; c=relaxed/simple;
	bh=xjYuEpfnvnCjurxlj4LVu8ebax0mj08bsQN+yw5wb5c=;
	h=Date:From:To:Cc:Subject:Message-ID; b=f4aZuKXI3B8WqfY2FppDqIZHn+gJGUMdZtP8cqpsGmztIu9f37V/2h5Na+ehPOBH/GFOdQ7ZmfL0pI2REZ5dAdIZ9nmvmYntANuPSyIlibtHHMRD06QA09GEBF5vryOltdshHw4tA1Q7F73VBiCsvFr5nrQypQSiEaRKjrK/7NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B99+xUNe; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754449236; x=1785985236;
  h=date:from:to:cc:subject:message-id;
  bh=xjYuEpfnvnCjurxlj4LVu8ebax0mj08bsQN+yw5wb5c=;
  b=B99+xUNeVaAq9yqfO553BABhQ4AudD08jSV8z7sydG0GXkUIT1ji+P6O
   t8HEe0EEB9lBh83mL3ohiMZQmSUhTExdyYhuHpQkyBWrhWvnTqjzynbMq
   UDvpze5G2qVXO1TPDkI8f+lsxNQJ40GXHIoerNnYU78DO9gWqmH7hi2OZ
   Hfyc0NKx9jPBtgLSAl6z7116a5jX5lv5PtPTqtUeQn6UBLDOWeq3CZivu
   2WXixX3W4fckSFbKYPj+qDAWg3koZQO47gFqh/HfQ2jZjehfG18xhTd5S
   pcj6OKcPCKDoiNfIqjePHjiuMji6zSviHwhiE5oBDbHUlopOlxO5el4p4
   g==;
X-CSE-ConnectionGUID: ISMdPFnoTUSLe8PpW31APQ==
X-CSE-MsgGUID: mKXcvzc/SXO9qrxYra0txw==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="74217654"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="74217654"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 20:00:35 -0700
X-CSE-ConnectionGUID: CL5RDgPKQ6e6X+rFmkwBkQ==
X-CSE-MsgGUID: WrjnqnsEQvyXMfqbUPnSqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="169922951"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 05 Aug 2025 20:00:33 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ujUNu-00012o-1C;
	Wed, 06 Aug 2025 03:00:18 +0000
Date: Wed, 06 Aug 2025 11:00:09 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20250804] BUILD SUCCESS
 507b5e0fdab39fa2f31766a321c8aac405ed3739
Message-ID: <202508061059.6tkr6q7z-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20250804
branch HEAD: 507b5e0fdab39fa2f31766a321c8aac405ed3739  wifi: iwlwifi: mei: remove unused flexible-array member

elapsed time: 1444m

configs tested: 127
configs skipped: 5

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
arc                   randconfig-001-20250805    gcc-8.5.0
arc                   randconfig-002-20250805    gcc-10.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                            hisi_defconfig    gcc-15.1.0
arm                       multi_v4t_defconfig    clang-16
arm                       omap2plus_defconfig    gcc-15.1.0
arm                   randconfig-001-20250805    gcc-11.5.0
arm                   randconfig-002-20250805    clang-22
arm                   randconfig-003-20250805    gcc-12.5.0
arm                   randconfig-004-20250805    clang-18
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250805    gcc-12.5.0
arm64                 randconfig-002-20250805    clang-20
arm64                 randconfig-003-20250805    gcc-11.5.0
arm64                 randconfig-004-20250805    gcc-13.4.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250805    gcc-12.5.0
csky                  randconfig-002-20250805    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250805    clang-20
hexagon               randconfig-002-20250805    clang-22
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250805    clang-20
i386        buildonly-randconfig-002-20250805    gcc-12
i386        buildonly-randconfig-003-20250805    gcc-12
i386        buildonly-randconfig-004-20250805    gcc-12
i386        buildonly-randconfig-005-20250805    gcc-12
i386        buildonly-randconfig-006-20250805    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250805    gcc-15.1.0
loongarch             randconfig-002-20250805    gcc-12.5.0
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
nios2                 randconfig-001-20250805    gcc-11.5.0
nios2                 randconfig-002-20250805    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250805    gcc-10.5.0
parisc                randconfig-002-20250805    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250805    clang-22
powerpc               randconfig-002-20250805    clang-22
powerpc               randconfig-003-20250805    gcc-9.5.0
powerpc                 xes_mpc85xx_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250805    clang-22
powerpc64             randconfig-002-20250805    clang-19
powerpc64             randconfig-003-20250805    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250805    clang-18
riscv                 randconfig-002-20250805    gcc-9.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250805    clang-22
s390                  randconfig-002-20250805    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250805    gcc-9.5.0
sh                    randconfig-002-20250805    gcc-14.3.0
sh                        sh7763rdp_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250805    gcc-8.5.0
sparc                 randconfig-002-20250805    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250805    gcc-9.5.0
sparc64               randconfig-002-20250805    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250805    gcc-12
um                    randconfig-002-20250805    gcc-12
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250805    gcc-12
x86_64      buildonly-randconfig-002-20250805    gcc-12
x86_64      buildonly-randconfig-003-20250805    clang-20
x86_64      buildonly-randconfig-004-20250805    gcc-12
x86_64      buildonly-randconfig-005-20250805    clang-20
x86_64      buildonly-randconfig-006-20250805    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250805    gcc-14.3.0
xtensa                randconfig-002-20250805    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


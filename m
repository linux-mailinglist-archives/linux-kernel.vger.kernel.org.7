Return-Path: <linux-kernel+bounces-798369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E76B41CFC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E1E4A4E11A0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45B32F8BD1;
	Wed,  3 Sep 2025 11:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XiOBHHYm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20EB2F9995
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 11:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756898785; cv=none; b=digc6gPiO2/M8dk4GUVrWNogJ7SwipYdiUrhw400dTNQ7zfTygWf4iBhK5FqOLDrcYBv8xg3/qV49F2t++6WB3AdG2EuQgEw0p7ILLPsbEooMDSsw0hlc3qDzOcwoDXsWCL7lJuX3Ptd9HYIwDlpCqaj38qbm3x+qR0+b2zlcPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756898785; c=relaxed/simple;
	bh=FLnkrn2U6dvUznuYqgkwunyCJ4/cmH9iWOeYtc4jMeU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=FAaDz/p35ZdkG0ogU8HlsOzNI4NpCJ1biQfzqrYTl14LS2PEtqhFfGTb5mlzDxcPDTuymFQDJGV874LnZX3j9g3cCb4aMXWZmb+E78AilOf8IRYBkC5KQn+h84pGpV9tO4hXNICq827cB+cxRvUjXbB03weyF7pYouwMhtDHZPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XiOBHHYm; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756898784; x=1788434784;
  h=date:from:to:cc:subject:message-id;
  bh=FLnkrn2U6dvUznuYqgkwunyCJ4/cmH9iWOeYtc4jMeU=;
  b=XiOBHHYmomH1AM2IJDxbpULQGVgwCzvDVZ7sOo5PdqUv2oWN4lczdP1f
   7nDf/wbmRTKQwdlJDwK5QT4fCbj0LafvGI6AhpItu3S8wHFVO2F+4tRmA
   QQMpkz3eHQv7aEc0eS8eJSwyXm5JZbJbcS5pP+a4qs02wCGgGQu+oZ8W5
   hHT92cGIIvFz0QOBgRyNroHVI8xYTGhCB49sJ/GDVtSGv/vMRRq/04AIi
   kQWj3wXViQ1EkHu0hDVOAlwF+SEfJJOVALEYg+6xjzcerFSfj2wcuwxaO
   kOaUpjaCp99rIEyHqRTq9CtYHJHOnD/wPFGjOPPFbNMYw9NJfe+DC2zKp
   Q==;
X-CSE-ConnectionGUID: w8IoGt8DStCABdXqzAKKuA==
X-CSE-MsgGUID: vlk9OEOPT4GoiAdWwRA2CA==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="46781921"
X-IronPort-AV: E=Sophos;i="6.18,235,1751266800"; 
   d="scan'208";a="46781921"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 04:26:23 -0700
X-CSE-ConnectionGUID: CEJmL0e5T/W6oDRkRjJa3Q==
X-CSE-MsgGUID: 838nzofMQMaGG5gp+UP+Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,235,1751266800"; 
   d="scan'208";a="175927625"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 03 Sep 2025 04:26:22 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1utlcr-0003mQ-20;
	Wed, 03 Sep 2025 11:26:14 +0000
Date: Wed, 03 Sep 2025 19:25:19 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/apic] BUILD SUCCESS
 27a17e02418e978198513edfb389b65237f4eaf5
Message-ID: <202509031905.BfeFItau-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/apic
branch HEAD: 27a17e02418e978198513edfb389b65237f4eaf5  x86/sev: Indicate the SEV-SNP guest supports Secure AVIC

elapsed time: 1478m

configs tested: 110
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250902    gcc-11.5.0
arc                   randconfig-002-20250902    gcc-9.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250902    gcc-15.1.0
arm                   randconfig-002-20250902    gcc-8.5.0
arm                   randconfig-003-20250902    clang-22
arm                   randconfig-004-20250902    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250902    gcc-8.5.0
arm64                 randconfig-002-20250902    clang-22
arm64                 randconfig-003-20250902    gcc-12.5.0
arm64                 randconfig-004-20250902    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250902    gcc-14.3.0
csky                  randconfig-002-20250902    gcc-12.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250902    clang-18
hexagon               randconfig-002-20250902    clang-22
i386                             allmodconfig    gcc-13
i386                              allnoconfig    gcc-13
i386                             allyesconfig    gcc-13
i386        buildonly-randconfig-001-20250902    clang-20
i386        buildonly-randconfig-002-20250902    clang-20
i386        buildonly-randconfig-003-20250902    gcc-12
i386        buildonly-randconfig-004-20250902    clang-20
i386        buildonly-randconfig-005-20250902    gcc-12
i386        buildonly-randconfig-006-20250902    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250902    clang-22
loongarch             randconfig-002-20250902    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250902    gcc-9.5.0
nios2                 randconfig-002-20250902    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250902    gcc-8.5.0
parisc                randconfig-002-20250902    gcc-11.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250902    gcc-9.5.0
powerpc               randconfig-002-20250902    gcc-8.5.0
powerpc               randconfig-003-20250902    gcc-11.5.0
powerpc64             randconfig-001-20250902    gcc-12.5.0
powerpc64             randconfig-002-20250902    clang-22
powerpc64             randconfig-003-20250902    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250902    gcc-13.4.0
riscv                 randconfig-002-20250902    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250902    clang-22
s390                  randconfig-002-20250902    gcc-10.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250902    gcc-12.5.0
sh                    randconfig-002-20250902    gcc-12.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250902    gcc-14.3.0
sparc                 randconfig-002-20250902    gcc-8.5.0
sparc64               randconfig-001-20250902    clang-20
sparc64               randconfig-002-20250902    gcc-9.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                    randconfig-001-20250902    gcc-12
um                    randconfig-002-20250902    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250902    clang-20
x86_64      buildonly-randconfig-002-20250902    clang-20
x86_64      buildonly-randconfig-003-20250902    clang-20
x86_64      buildonly-randconfig-004-20250902    gcc-12
x86_64      buildonly-randconfig-005-20250902    gcc-12
x86_64      buildonly-randconfig-006-20250902    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250902    gcc-9.5.0
xtensa                randconfig-002-20250902    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


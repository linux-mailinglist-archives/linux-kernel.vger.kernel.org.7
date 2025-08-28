Return-Path: <linux-kernel+bounces-789234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABABB39299
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 06:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FEA97B2EE1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 04:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4CE1A8F84;
	Thu, 28 Aug 2025 04:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mxu5NM76"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5969A367
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 04:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756355536; cv=none; b=fgsVK1R6vmkpvNa9jrcXWR9igYlQj81OPfPyvvpRBfM6qR2AzgJicarCCRXmyYEOKudlYRWcMGaqAA288ykF7yOmleWC1aBP5OojNErAVmOVyqXfuxjybZmKyVOKODY5lV4/1AVpxnq5zvW9a4nniC7eyTsyxNdJHFfdj6okWKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756355536; c=relaxed/simple;
	bh=rS3JQnTJ5KHCBNmhBTwkXlNQXwhqQzZ1kOZ8BrH78To=;
	h=Date:From:To:Cc:Subject:Message-ID; b=YKBmqlNfNP4oJ0xXwLDmrjyq8Ik7sg6vEd1TkOs05qp0V9VlT7zX7jgT1FzCQ727YuAs2TOXMDjQj6c6RfOKUnBGEmNWzxHIIake13EEKNVPqHvcRNtV9tTgTa4v7dgTaV1Y4TspEQcALgNEIi/nB5nxO85jmUWz2yKO5eA/uIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mxu5NM76; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756355535; x=1787891535;
  h=date:from:to:cc:subject:message-id;
  bh=rS3JQnTJ5KHCBNmhBTwkXlNQXwhqQzZ1kOZ8BrH78To=;
  b=mxu5NM76oO+Diiebb4ScZhPNg4AwvzDsECY8zGoTXCLfX/3mFhnU2O5H
   KGtYY1Z9lZvugUtWe0XyeWeWE7wkJurCBEWzBUc7Tus14hrUPnviuheXw
   MTenzgGf1lBLGdBVXSMlAJtPmpkbnZ+N2IATBxeN+K1ZaM62ZMeo3D5Ga
   Hdq2f0qaXr/3Y8DnaDFtV85pcYjBIKcSzEVGaMbK1U/K4+9rDR+w5gZ5D
   +M0W8XViTKBB9zyqaLHgYmgXJFIApPuTMtXcdWUtG755yD634xCBkioWs
   J89hoc84NxXo/khDOBZVoVoFmxNU3/dO9q7/VLScECmH7SYzl3+bMwU3Z
   A==;
X-CSE-ConnectionGUID: AmZwFZoBRh+q/fHOf9NLdQ==
X-CSE-MsgGUID: 6vLO0BusRay+7nFziT6qUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58538710"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58538710"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 21:32:14 -0700
X-CSE-ConnectionGUID: oG8ZF5KqSFqlyl/j2WqBoQ==
X-CSE-MsgGUID: PZotYDAdQV+AyvjBGJxgNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="175306704"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 27 Aug 2025 21:32:13 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1urUJ0-000TQD-0w;
	Thu, 28 Aug 2025 04:32:10 +0000
Date: Thu, 28 Aug 2025 12:31:14 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:tip/urgent] BUILD SUCCESS
 be079f417e7a10111043480c1c1e46b870563efb
Message-ID: <202508281205.fThCDqmM-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tip/urgent
branch HEAD: be079f417e7a10111043480c1c1e46b870563efb  Merge branch into tip/master: 'x86/urgent'

elapsed time: 1341m

configs tested: 133
configs skipped: 4

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
arc                   randconfig-001-20250827    gcc-12.5.0
arc                   randconfig-002-20250827    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                           imxrt_defconfig    clang-22
arm                          pxa910_defconfig    gcc-15.1.0
arm                   randconfig-001-20250827    clang-22
arm                   randconfig-002-20250827    clang-22
arm                   randconfig-003-20250827    clang-22
arm                   randconfig-004-20250827    clang-22
arm                           stm32_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250827    gcc-11.5.0
arm64                 randconfig-002-20250827    gcc-8.5.0
arm64                 randconfig-003-20250827    clang-22
arm64                 randconfig-004-20250827    gcc-9.5.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250827    gcc-10.5.0
csky                  randconfig-002-20250827    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20250827    clang-22
hexagon               randconfig-002-20250827    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250827    clang-20
i386        buildonly-randconfig-002-20250827    clang-20
i386        buildonly-randconfig-003-20250827    clang-20
i386        buildonly-randconfig-004-20250827    clang-20
i386        buildonly-randconfig-005-20250827    clang-20
i386        buildonly-randconfig-006-20250827    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250827    gcc-15.1.0
loongarch             randconfig-002-20250827    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           xway_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250827    gcc-8.5.0
nios2                 randconfig-002-20250827    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250827    gcc-12.5.0
parisc                randconfig-002-20250827    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250827    clang-22
powerpc               randconfig-002-20250827    clang-22
powerpc               randconfig-003-20250827    clang-22
powerpc                     redwood_defconfig    clang-22
powerpc64             randconfig-001-20250827    gcc-11.5.0
powerpc64             randconfig-002-20250827    gcc-11.5.0
powerpc64             randconfig-003-20250827    gcc-13.4.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250827    clang-19
riscv                 randconfig-002-20250827    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250827    gcc-13.4.0
s390                  randconfig-002-20250827    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         apsh4a3a_defconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250827    gcc-15.1.0
sh                    randconfig-002-20250827    gcc-9.5.0
sh                   rts7751r2dplus_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250827    gcc-15.1.0
sparc                 randconfig-002-20250827    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250827    gcc-11.5.0
sparc64               randconfig-002-20250827    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250827    gcc-12
um                    randconfig-002-20250827    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250827    clang-20
x86_64      buildonly-randconfig-002-20250827    clang-20
x86_64      buildonly-randconfig-003-20250827    gcc-12
x86_64      buildonly-randconfig-004-20250827    gcc-12
x86_64      buildonly-randconfig-005-20250827    clang-20
x86_64      buildonly-randconfig-006-20250827    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250827    gcc-10.5.0
xtensa                randconfig-002-20250827    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


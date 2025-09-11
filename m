Return-Path: <linux-kernel+bounces-812435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FEEB5381B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9040AA51DD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653DC35209F;
	Thu, 11 Sep 2025 15:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A5NbsW1G"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CAC23815D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 15:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757605574; cv=none; b=nTzB2Hr4iFqxVWugmk2PHPpcewwwETTag16VgoAYU+1TzAPNWZhHKIzEttQ4xVSptbh8qrRaX1kaHrGlLgJuxaeKCYkGZ0WiFbgV05pWWDzwMayoLse5Yto+OTIO23m2he6IBZ6DcaMmd2WCK3HQSehaVPUtTkMT7fsa9Wo09MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757605574; c=relaxed/simple;
	bh=EBzL31prAgJJ/FFdYS0lNwxRdE4+SYcxDhv3sXo3+dU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kuTZHVrqxdR8S1sJBRj72NMfriXE9Fw+BHw++tkPRQ2Uz/5baEPUzEpZtFNVLMEF3/wr8OXCcUg24hrYo2i0rRivuxRSo2Vxmp5bqEk/xvo2ZNOdPoderQrEqc9rTd3o4vnJpcOhs4tMQOzkV1IMfuis2DsFnXk5MDEyVfTtQeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A5NbsW1G; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757605573; x=1789141573;
  h=date:from:to:cc:subject:message-id;
  bh=EBzL31prAgJJ/FFdYS0lNwxRdE4+SYcxDhv3sXo3+dU=;
  b=A5NbsW1Gk1eR70XAFCx1CrJPiVJfc4ILf4vld0QOXNa57ZtEumW39iwY
   4XEdgdQYfrAcIiQHgSGUM3+y6VXReGTXrMjbjGdLICBzmhPAOdYFx6wJ9
   qj0Fi0xCP0CAbtHm4zfnHttFRbQrXzHvkvbDkMfWQt8ANQf7FdIvxKu0c
   Mivsiri6JpSyudYkk90fUSsT1NwGoAQkOMkKQFS8//b8pP4UYFSNDDE1d
   dQQb9W+YNw52jxFKwPnB1/jFiMtEV23tOfKtfd4D6WbVX4RGyt/TPVNMB
   amjJCcGpyoFQ51Ta3CuthkX3sMuxpzW7nSZ+T65wVLGsxpKQZ9l4uvrdQ
   w==;
X-CSE-ConnectionGUID: btAiCyiUTj67fBsnwRVlrQ==
X-CSE-MsgGUID: Yfw4oXeLRw+9pqfz5uoj/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="82530603"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="82530603"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 08:46:10 -0700
X-CSE-ConnectionGUID: bzC/9o3fQBSCxOhX22f/Qw==
X-CSE-MsgGUID: s57dJcScRSalOfMCdyjQLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="178933598"
Received: from lkp-server02.sh.intel.com (HELO eb5fdfb2a9b7) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 11 Sep 2025 08:46:08 -0700
Received: from kbuild by eb5fdfb2a9b7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uwjUr-0000Q2-1E;
	Thu, 11 Sep 2025 15:46:05 +0000
Date: Thu, 11 Sep 2025 23:45:16 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/sev] BUILD SUCCESS
 8d73829b78ca1a0e6eb93380f3bf5193d58c281c
Message-ID: <202509112306.yCV7WC95-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sev
branch HEAD: 8d73829b78ca1a0e6eb93380f3bf5193d58c281c  x86/startup/sev: Document the CPUID flow in the boot #VC handler

elapsed time: 1452m

configs tested: 109
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              alldefconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250911    gcc-8.5.0
arc                   randconfig-002-20250911    gcc-12.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250911    clang-22
arm                   randconfig-002-20250911    gcc-14.3.0
arm                   randconfig-003-20250911    clang-22
arm                   randconfig-004-20250911    clang-16
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250911    gcc-13.4.0
arm64                 randconfig-002-20250911    gcc-8.5.0
arm64                 randconfig-003-20250911    gcc-8.5.0
arm64                 randconfig-004-20250911    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250911    gcc-15.1.0
csky                  randconfig-002-20250911    gcc-13.4.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250911    clang-20
hexagon               randconfig-002-20250911    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20250911    clang-20
i386        buildonly-randconfig-002-20250911    clang-20
i386        buildonly-randconfig-003-20250911    clang-20
i386        buildonly-randconfig-004-20250911    clang-20
i386        buildonly-randconfig-005-20250911    clang-20
i386        buildonly-randconfig-006-20250911    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250911    gcc-15.1.0
loongarch             randconfig-002-20250911    gcc-15.1.0
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
nios2                 randconfig-001-20250911    gcc-11.5.0
nios2                 randconfig-002-20250911    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250911    gcc-8.5.0
parisc                randconfig-002-20250911    gcc-8.5.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                       eiger_defconfig    clang-22
powerpc               randconfig-001-20250911    gcc-8.5.0
powerpc               randconfig-002-20250911    gcc-15.1.0
powerpc               randconfig-003-20250911    gcc-8.5.0
powerpc64             randconfig-001-20250911    clang-22
powerpc64             randconfig-002-20250911    gcc-11.5.0
powerpc64             randconfig-003-20250911    gcc-8.5.0
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250911    clang-20
riscv                 randconfig-002-20250911    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250911    gcc-11.5.0
s390                  randconfig-002-20250911    clang-16
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250911    gcc-9.5.0
sh                    randconfig-002-20250911    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250911    gcc-15.1.0
sparc                 randconfig-002-20250911    gcc-15.1.0
sparc64               randconfig-001-20250911    gcc-8.5.0
sparc64               randconfig-002-20250911    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                    randconfig-001-20250911    clang-22
um                    randconfig-002-20250911    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250911    gcc-14
x86_64      buildonly-randconfig-002-20250911    gcc-14
x86_64      buildonly-randconfig-003-20250911    clang-20
x86_64      buildonly-randconfig-004-20250911    clang-20
x86_64      buildonly-randconfig-005-20250911    clang-20
x86_64      buildonly-randconfig-006-20250911    gcc-14
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250911    gcc-12.5.0
xtensa                randconfig-002-20250911    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


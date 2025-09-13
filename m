Return-Path: <linux-kernel+bounces-815375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4617B56383
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 00:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3EE77A89B8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 22:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49472BCF68;
	Sat, 13 Sep 2025 22:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bXuNwCPw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D858C283FD3
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 22:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757801094; cv=none; b=svv4b85SMXpkUeGdecwEjU14hpn5Fdk/sykXIN1OXVDtoNNjuQlrh1xjbZAYeMqPqCNjht4sao7NJ2Dv5M7qrkyCkCTexo5K/2AhvTNuW038F+PlgUFxWh/bsWZUodBCGXxUoDv/0TLSm6Y7aloygjE5VKxckx/4nu54ejBvEPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757801094; c=relaxed/simple;
	bh=DRs5bi0rnSvVIIjWYueuO8SaOOSHiYoziIGKiszpiJ8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=U4P8JGbi9B/+Z+R/QCmyVP+s6hvo8uh6zHFzZyq/h+O+5vX6ugMqu6v01xdLIVGWpcOPhuCFO2DcmQmi9iUEr6PfNMbLXytQobPk/29ankr+kvlaoeSFiBltdG9UTLDw8TOOr+9b2a5wDMLMiuJ8r8+uOkF7J+WSZnTfQJAGmQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bXuNwCPw; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757801091; x=1789337091;
  h=date:from:to:cc:subject:message-id;
  bh=DRs5bi0rnSvVIIjWYueuO8SaOOSHiYoziIGKiszpiJ8=;
  b=bXuNwCPwgci8FpTjYwTbWVPK5bI+ZUHZ424ImdiSLr3V0dvAwjc9cTmj
   XgIohX3dt+TaQIR/AtpdgcM0jukJD15YeuhGFG4Y0OdzkXiB7AOQXU+SV
   AdL3+vokxY/9cm1kwHQdsD11INx3k6qutgPSJoBR/Z3vWlv31R3ZndLAJ
   6ppOHe5F8K+NV4QrWS8phsMWCkFrWF5JFVlSxmQo+mB2LaZEQOKpwNNjk
   GHJSlU2EQEkZ7CYwd8cy+p75U+9Zp2yUD4KvKeNsA9j3D9K9e2Oxo+CMb
   xRMOEH0IwP/C25bUF3XQ7eA27LJZs6n/ns+ggZugAnReFjUuDHJlcDksH
   A==;
X-CSE-ConnectionGUID: tQUD/uHvSWS9VD7lBQH6Xg==
X-CSE-MsgGUID: KzUuBYUvQ1KnRzhaekBeWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11552"; a="71531169"
X-IronPort-AV: E=Sophos;i="6.18,262,1751266800"; 
   d="scan'208";a="71531169"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2025 15:04:51 -0700
X-CSE-ConnectionGUID: jKJ5CyAvSvqldnw/EtmIcg==
X-CSE-MsgGUID: ohpkTWFdT5WrGPMqlZPoMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,262,1751266800"; 
   d="scan'208";a="179454289"
Received: from lkp-server02.sh.intel.com (HELO eb5fdfb2a9b7) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 13 Sep 2025 15:04:51 -0700
Received: from kbuild by eb5fdfb2a9b7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uxYMR-0001tc-1K;
	Sat, 13 Sep 2025 22:04:47 +0000
Date: Sun, 14 Sep 2025 06:04:37 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/bugs] BUILD SUCCESS
 5799d5d8a6c877f03ad5b5a640977053be45059a
Message-ID: <202509140627.9udJqtlX-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/bugs
branch HEAD: 5799d5d8a6c877f03ad5b5a640977053be45059a  x86/bugs: Add attack vector controls for VMSCAPE

elapsed time: 1443m

configs tested: 111
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
arc                   randconfig-001-20250913    gcc-10.5.0
arc                   randconfig-002-20250913    gcc-11.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                       netwinder_defconfig    gcc-15.1.0
arm                   randconfig-001-20250913    clang-20
arm                   randconfig-002-20250913    clang-22
arm                   randconfig-003-20250913    clang-22
arm                   randconfig-004-20250913    gcc-14.3.0
arm                         s3c6400_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250913    clang-22
arm64                 randconfig-002-20250913    gcc-14.3.0
arm64                 randconfig-003-20250913    clang-22
arm64                 randconfig-004-20250913    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250913    gcc-11.5.0
csky                  randconfig-002-20250913    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250913    clang-16
hexagon               randconfig-002-20250913    clang-22
i386        buildonly-randconfig-001-20250913    gcc-14
i386        buildonly-randconfig-002-20250913    clang-20
i386        buildonly-randconfig-003-20250913    clang-20
i386        buildonly-randconfig-004-20250913    clang-20
i386        buildonly-randconfig-005-20250913    clang-20
i386        buildonly-randconfig-006-20250913    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250913    clang-18
loongarch             randconfig-002-20250913    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                            gpr_defconfig    clang-18
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250913    gcc-8.5.0
nios2                 randconfig-002-20250913    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250913    gcc-12.5.0
parisc                randconfig-002-20250913    gcc-9.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                       ppc64_defconfig    clang-22
powerpc               randconfig-001-20250913    gcc-8.5.0
powerpc               randconfig-002-20250913    clang-22
powerpc               randconfig-003-20250913    gcc-10.5.0
powerpc                     sequoia_defconfig    clang-17
powerpc64             randconfig-001-20250913    gcc-10.5.0
powerpc64             randconfig-002-20250913    clang-22
powerpc64             randconfig-003-20250913    gcc-8.5.0
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250913    gcc-13.4.0
riscv                 randconfig-002-20250913    clang-20
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250913    clang-22
s390                  randconfig-002-20250913    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                             espt_defconfig    gcc-15.1.0
sh                    randconfig-001-20250913    gcc-9.5.0
sh                    randconfig-002-20250913    gcc-14.3.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250913    gcc-15.1.0
sparc                 randconfig-002-20250913    gcc-8.5.0
sparc                       sparc32_defconfig    gcc-15.1.0
sparc64               randconfig-001-20250913    gcc-8.5.0
sparc64               randconfig-002-20250913    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                    randconfig-001-20250913    gcc-14
um                    randconfig-002-20250913    clang-22
x86_64      buildonly-randconfig-001-20250913    clang-20
x86_64      buildonly-randconfig-002-20250913    gcc-14
x86_64      buildonly-randconfig-003-20250913    gcc-12
x86_64      buildonly-randconfig-004-20250913    gcc-14
x86_64      buildonly-randconfig-005-20250913    clang-20
x86_64      buildonly-randconfig-006-20250913    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250913    gcc-14.3.0
xtensa                randconfig-002-20250913    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


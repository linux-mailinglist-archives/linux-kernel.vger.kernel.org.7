Return-Path: <linux-kernel+bounces-869981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB23C092CC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 17:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ADC33AADE6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 15:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E2C28850B;
	Sat, 25 Oct 2025 15:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q32lShl9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CDB303CA2
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 15:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761407548; cv=none; b=QHvQQ7GEUryOLbjLQWW44aoNCpSgJnBLGvyJlTzisA3p9ZTMilJNIxiXJhcVmLbd3/j8t0xUqVq6TXBN8Qz17Y6sYbxgkbCby5VLtA+UclwkYDmb4JzJbCyNyIryuXsehOZLlarS9a+7xpJxZ1HkHzDCSfsg76cIzy+Egyf0zss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761407548; c=relaxed/simple;
	bh=lJcPxsYFVAFImNpkLMva3TTOSwkONdRDy9IzFZsoDX4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ihqlge+9MNUXCDmvJ6I5JmEHwqNDHDpk4WE+K//3oEDNGNM5OmTBGx8Kb4qYvfKMpwMFwpwqxKgrXf5IM8LTkZpXnCaDNfuWDfLloULHOFtMM5wcimtx48rpV7bBR3NkAolRBnRPPDvf8MLH3eONhExMZehIqg+I+PZzONl7PTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q32lShl9; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761407546; x=1792943546;
  h=date:from:to:cc:subject:message-id;
  bh=lJcPxsYFVAFImNpkLMva3TTOSwkONdRDy9IzFZsoDX4=;
  b=Q32lShl9e+283xPUyQHqP7dKbLJNoxoj8tx4SEA00WWB1OXNeYsaDCKb
   oz6kQV0RqO0hN+3zhn15rHh44E+4NeJlNHwCCuxsbJcrdqgkNUuo0AhR/
   GnyXlElSY9VQnTpxsG4g/VEdXV4PZ92/uP9N15s/h1Gwiz6LfqTt7ARQx
   3AHWAMK+dAkMtQ9Lutppsk7MymNE4uVwT6mLBHukqgMGVdI//QXEoed2K
   Q3NJBFMVsxLEd3Ax386YuelVG7EW8ihETygeSaPTxijdFyPF8HcLFa+2S
   KHpAspeVspcL0PvTD0B/d2dKSeGoAWjyXJVSojgIHleiltkd808zANSaj
   w==;
X-CSE-ConnectionGUID: neAC3HuySWC66VUVrgCFsw==
X-CSE-MsgGUID: HqRTxnP3RSyvlCPrukMYZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67389716"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="67389716"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2025 08:52:26 -0700
X-CSE-ConnectionGUID: VeU9VLKaTnW+ogMIrp5uGg==
X-CSE-MsgGUID: zivpGYKmSHepzhPu9/UPkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,255,1754982000"; 
   d="scan'208";a="183845644"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 25 Oct 2025 08:52:25 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vCgZ4-000FOq-1J;
	Sat, 25 Oct 2025 15:52:22 +0000
Date: Sat, 25 Oct 2025 23:52:14 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 84dfce65a7ae7b11c7b13285a1b23e9a94ad37b7
Message-ID: <202510252308.Qbo0Cuwp-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 84dfce65a7ae7b11c7b13285a1b23e9a94ad37b7  x86/bugs: Remove dead code which might prevent from building

elapsed time: 1367m

configs tested: 168
configs skipped: 119

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                            allyesconfig    clang-19
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-22
arc                              allyesconfig    clang-19
arc                                 defconfig    clang-19
arc                   randconfig-001-20251025    clang-22
arc                   randconfig-002-20251025    clang-22
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                            hisi_defconfig    clang-22
arm                   randconfig-001-20251025    clang-22
arm                   randconfig-002-20251025    clang-22
arm                   randconfig-003-20251025    clang-22
arm                   randconfig-004-20251025    clang-22
arm                           sama7_defconfig    clang-22
arm                        spear6xx_defconfig    clang-22
arm                           u8500_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                               defconfig    clang-19
arm64                 randconfig-001-20251025    clang-22
arm64                 randconfig-002-20251025    clang-22
arm64                 randconfig-003-20251025    clang-22
arm64                 randconfig-004-20251025    clang-22
csky                              allnoconfig    clang-22
csky                                defconfig    clang-19
csky                  randconfig-001-20251025    gcc-10.5.0
csky                  randconfig-002-20251025    gcc-10.5.0
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20251025    gcc-10.5.0
hexagon               randconfig-002-20251025    gcc-10.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251025    clang-20
i386        buildonly-randconfig-001-20251025    gcc-14
i386        buildonly-randconfig-002-20251025    clang-20
i386        buildonly-randconfig-002-20251025    gcc-14
i386        buildonly-randconfig-003-20251025    clang-20
i386        buildonly-randconfig-004-20251025    clang-20
i386        buildonly-randconfig-005-20251025    clang-20
i386        buildonly-randconfig-006-20251025    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20251025    clang-20
i386                  randconfig-002-20251025    clang-20
i386                  randconfig-003-20251025    clang-20
i386                  randconfig-004-20251025    clang-20
i386                  randconfig-005-20251025    clang-20
i386                  randconfig-006-20251025    clang-20
i386                  randconfig-007-20251025    clang-20
i386                  randconfig-011-20251025    gcc-14
i386                  randconfig-012-20251025    gcc-14
i386                  randconfig-013-20251025    gcc-14
i386                  randconfig-014-20251025    gcc-14
i386                  randconfig-015-20251025    gcc-14
i386                  randconfig-016-20251025    gcc-14
i386                  randconfig-017-20251025    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251025    gcc-10.5.0
loongarch             randconfig-002-20251025    gcc-10.5.0
m68k                             allmodconfig    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        vocore2_defconfig    clang-22
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20251025    gcc-10.5.0
nios2                 randconfig-002-20251025    gcc-10.5.0
openrisc                          allnoconfig    clang-22
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251025    gcc-10.5.0
parisc                randconfig-002-20251025    gcc-10.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                       ebony_defconfig    clang-22
powerpc               randconfig-001-20251025    gcc-10.5.0
powerpc               randconfig-002-20251025    gcc-10.5.0
powerpc               randconfig-003-20251025    gcc-10.5.0
powerpc64             randconfig-001-20251025    gcc-10.5.0
powerpc64             randconfig-002-20251025    gcc-10.5.0
powerpc64             randconfig-003-20251025    gcc-10.5.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                   sh7724_generic_defconfig    clang-22
sh                            titan_defconfig    clang-22
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc64                             defconfig    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251025    clang-20
x86_64      buildonly-randconfig-001-20251025    gcc-14
x86_64      buildonly-randconfig-002-20251025    clang-20
x86_64      buildonly-randconfig-002-20251025    gcc-14
x86_64      buildonly-randconfig-003-20251025    clang-20
x86_64      buildonly-randconfig-003-20251025    gcc-14
x86_64      buildonly-randconfig-004-20251025    clang-20
x86_64      buildonly-randconfig-005-20251025    clang-20
x86_64      buildonly-randconfig-006-20251025    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251025    clang-20
x86_64                randconfig-002-20251025    clang-20
x86_64                randconfig-003-20251025    clang-20
x86_64                randconfig-004-20251025    clang-20
x86_64                randconfig-005-20251025    clang-20
x86_64                randconfig-006-20251025    clang-20
x86_64                randconfig-007-20251025    clang-20
x86_64                randconfig-008-20251025    clang-20
x86_64                randconfig-071-20251025    clang-20
x86_64                randconfig-072-20251025    clang-20
x86_64                randconfig-073-20251025    clang-20
x86_64                randconfig-074-20251025    clang-20
x86_64                randconfig-075-20251025    clang-20
x86_64                randconfig-076-20251025    clang-20
x86_64                randconfig-077-20251025    clang-20
x86_64                randconfig-078-20251025    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


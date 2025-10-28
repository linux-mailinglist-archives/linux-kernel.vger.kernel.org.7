Return-Path: <linux-kernel+bounces-874306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 454DCC15FA8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D1CDE4E4B13
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45858316188;
	Tue, 28 Oct 2025 16:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ktT4nqIY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAD333DEE8
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761670565; cv=none; b=RgEkhUx4eKtVaCxGjpXA28EAJ8TMZaxbAk2SxmglaIME9N7QBDQVwTNbV7+2bKqgt/wLwLTZWBtbFJ3BPnpcZYUzvS0VWkwrG+FNkL3M1wBkHzV+lzQerxL4Dr30YtJc+ik61cQ0s78khWVf+8qBQfOqdHCHMT2RTPq7s0TMecc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761670565; c=relaxed/simple;
	bh=dLpZLvJ5s4lfMIW/Q1i3WK2b6ChFwImjU+Ef1nh3Fzg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=okWlpDoK8z61BlJWmyKn0gbRk3seKr6Epdc32CTIlMw+HIACXXJxIktkY3vpBReYK5lOZ7smHEzeZORByxSe25o3mq8t7oX4qsnu7hXTy1KleO/QIVyN+V0OHkgbrfv5SgfefldftiSQjxCyk7VpvZIAfHizF7Bqu9CjG/347Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ktT4nqIY; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761670563; x=1793206563;
  h=date:from:to:cc:subject:message-id;
  bh=dLpZLvJ5s4lfMIW/Q1i3WK2b6ChFwImjU+Ef1nh3Fzg=;
  b=ktT4nqIY/QpcfGH+JhqgV96qfMcP2luyv81YMopW2UrPmMGcrUQUE0Xw
   E4W7HSzziP4Hh5Eown8Ex9PAnL2B8xs2SqPJJ/U7aU91jUxlg1ul1ArQu
   tBPQhjtmTjjwQl7dbPp1qnaI8/mbjFgEmrmvy7ZD77/leGlxG99EqTMe/
   oB8OxaQx+9WzeH+/XQoqAwdSOfTnT62aTabIi9L0ryWlumXrCN8SrBevm
   FeZ33Jmis6EGyOwwlutLIiPplo2ml3ZC7gLKfzuHB2ERcJ0UtldMhKXp7
   JoJQ2/7nVQ2EgIhQADVji2rcbTE0g9yz8YCZJ3El1E8WpYHatqN4s47/E
   Q==;
X-CSE-ConnectionGUID: KD0KWCW+SAaJLuS/2Edhwg==
X-CSE-MsgGUID: mcLDnpDzTpevRW13rtIXvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63685674"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="63685674"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 09:56:01 -0700
X-CSE-ConnectionGUID: 4h0lRapFRzKAJAMm6B+PZg==
X-CSE-MsgGUID: hFT8EWRwSYeWSUOE1azm4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="222623717"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 28 Oct 2025 09:55:59 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vDmzF-000JTn-0K;
	Tue, 28 Oct 2025 16:55:57 +0000
Date: Wed, 29 Oct 2025 00:54:27 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 fa9d2777387346645a40ab37cfb0c37b3ef40cc9
Message-ID: <202510290022.WOUdCXPT-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: fa9d2777387346645a40ab37cfb0c37b3ef40cc9  perf: arm_pmu: Kill last use of per-CPU cpu_armpmu pointer

elapsed time: 1451m

configs tested: 190
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                        nsimosci_defconfig    clang-22
arc                   randconfig-001-20251028    gcc-8.5.0
arc                   randconfig-002-20251028    gcc-13.4.0
arc                   randconfig-002-20251028    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    gcc-15.1.0
arm                       aspeed_g5_defconfig    gcc-15.1.0
arm                        multi_v5_defconfig    gcc-15.1.0
arm                        multi_v7_defconfig    gcc-15.1.0
arm                   randconfig-001-20251028    clang-22
arm                   randconfig-001-20251028    gcc-8.5.0
arm                   randconfig-002-20251028    clang-22
arm                   randconfig-002-20251028    gcc-8.5.0
arm                   randconfig-003-20251028    clang-22
arm                   randconfig-003-20251028    gcc-8.5.0
arm                   randconfig-004-20251028    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                            allyesconfig    gcc-15.1.0
arm64                 randconfig-001-20251028    clang-22
arm64                 randconfig-001-20251028    gcc-8.5.0
arm64                 randconfig-002-20251028    clang-22
arm64                 randconfig-002-20251028    gcc-8.5.0
arm64                 randconfig-003-20251028    gcc-11.5.0
arm64                 randconfig-003-20251028    gcc-8.5.0
arm64                 randconfig-004-20251028    gcc-8.5.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                  randconfig-001-20251028    gcc-15.1.0
csky                  randconfig-002-20251028    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.1.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20251028    clang-22
hexagon               randconfig-002-20251028    clang-17
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.1.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20251028    gcc-14
i386        buildonly-randconfig-002-20251028    gcc-14
i386        buildonly-randconfig-003-20251028    gcc-14
i386        buildonly-randconfig-004-20251028    gcc-14
i386        buildonly-randconfig-005-20251028    gcc-14
i386        buildonly-randconfig-006-20251028    gcc-14
i386                  randconfig-001-20251028    clang-20
i386                  randconfig-002-20251028    clang-20
i386                  randconfig-003-20251028    clang-20
i386                  randconfig-004-20251028    clang-20
i386                  randconfig-005-20251028    clang-20
i386                  randconfig-006-20251028    clang-20
i386                  randconfig-007-20251028    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                        allyesconfig    gcc-15.1.0
loongarch             randconfig-001-20251028    gcc-12.5.0
loongarch             randconfig-002-20251028    clang-22
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                           sun3_defconfig    clang-22
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                      maltaaprp_defconfig    clang-22
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                            allyesconfig    clang-22
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20251028    gcc-8.5.0
nios2                 randconfig-002-20251028    gcc-9.5.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251028    gcc-9.5.0
parisc                randconfig-002-20251028    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                   bluestone_defconfig    gcc-15.1.0
powerpc                 mpc8313_rdb_defconfig    clang-22
powerpc               randconfig-001-20251028    gcc-15.1.0
powerpc               randconfig-002-20251028    gcc-11.5.0
powerpc               randconfig-003-20251028    gcc-8.5.0
powerpc                    socrates_defconfig    clang-22
powerpc                     tqm8541_defconfig    clang-22
powerpc64             randconfig-001-20251028    clang-22
powerpc64             randconfig-002-20251028    clang-22
powerpc64             randconfig-003-20251028    gcc-13.4.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                          r7785rp_defconfig    clang-22
sparc                            alldefconfig    clang-22
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                            allyesconfig    clang-22
sparc                               defconfig    gcc-15.1.0
sparc64                          allmodconfig    clang-22
sparc64                          allyesconfig    clang-22
sparc64                             defconfig    gcc-14
um                               alldefconfig    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251028    clang-20
x86_64      buildonly-randconfig-001-20251028    gcc-14
x86_64      buildonly-randconfig-002-20251028    clang-20
x86_64      buildonly-randconfig-002-20251028    gcc-14
x86_64      buildonly-randconfig-003-20251028    clang-20
x86_64      buildonly-randconfig-004-20251028    clang-20
x86_64      buildonly-randconfig-005-20251028    clang-20
x86_64      buildonly-randconfig-006-20251028    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251028    clang-20
x86_64                randconfig-002-20251028    clang-20
x86_64                randconfig-003-20251028    clang-20
x86_64                randconfig-004-20251028    clang-20
x86_64                randconfig-005-20251028    clang-20
x86_64                randconfig-006-20251028    clang-20
x86_64                randconfig-011-20251028    clang-20
x86_64                randconfig-012-20251028    clang-20
x86_64                randconfig-013-20251028    clang-20
x86_64                randconfig-014-20251028    clang-20
x86_64                randconfig-015-20251028    clang-20
x86_64                randconfig-016-20251028    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


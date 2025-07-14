Return-Path: <linux-kernel+bounces-730928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F9CB04C89
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 01:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7576A1A679CD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 23:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35621273D95;
	Mon, 14 Jul 2025 23:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l18vKFex"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E1524EAB2
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 23:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752536982; cv=none; b=A5LEzqbGCa3lbJTs8G1VovnRytYbGugGVd7CqrbnAFWekrloQvjs6WUK78o84U7DtZPVB3lkaIN7VwQXjF/9H2eSsj6vTNGaFIc+KtJ6xKwDUq9wNx/CuL6oSvLAzBawWgfogZRChrIqtixs7Hm70AiZQHH69UGFaAVV/w5qtJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752536982; c=relaxed/simple;
	bh=C3z1tGCJNCo1u6Fjges00acFM/tPq74CrwTHG6OaKRc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=EgSxRwzVLbbpAIJf0gJ2uA/Ge7tKDPbPPiMCYUO+9DcHnDI/0QGV4bevCD6FiZgdQc3tccVVp7IIxU+bj1p3tie96JvEsBYVc0BqlwdmEB7+K4NkRJQOWiad7kikkgpGIwZaun5AUedEwoYRYmrkdgPtIoJLgu8Q35riwet65qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l18vKFex; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752536980; x=1784072980;
  h=date:from:to:cc:subject:message-id;
  bh=C3z1tGCJNCo1u6Fjges00acFM/tPq74CrwTHG6OaKRc=;
  b=l18vKFex2Do6KfMT8+22+KEfrwKDzdL0SfLTtf8Sqz2+J9neAvG5pqTD
   OJjsgVs/fomadiLF2mWwBdrrz6Twabiipzmc4saKn5YeOvvxKFqWLuxqk
   eaksAu69zv77r3/lqnY28RuOmAgwuFqOGgXOqGqrEU/Nhkbwu5a2pauTc
   iAi6AQ71684VkLFZPFTLBgFxjLQbbmVwhSvzj9aT9QkKwGd+ku/NuDmr9
   zTvEsmyQj0VUB041JVS2EaeRK5EJUBvzuMwwlrIuy+SCT0dO1iSNVlsAi
   YqrMfEx6RzMcDdhEgbWWs4MZ+ORUtaprVzXKQw5AoWzzsUHznHZV+/z1V
   w==;
X-CSE-ConnectionGUID: XOfczegkQNGaaqjmPkcEIg==
X-CSE-MsgGUID: 1DlR/w60SD675hHKVrI+Ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="66102622"
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="66102622"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 16:49:38 -0700
X-CSE-ConnectionGUID: w9b9fOLCTYS5yHxP8Jh41Q==
X-CSE-MsgGUID: tpW8oiRBREi9lYlxVjAJgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="188066555"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 14 Jul 2025 16:49:37 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ubSvP-0009S5-0w;
	Mon, 14 Jul 2025 23:49:35 +0000
Date: Tue, 15 Jul 2025 07:49:04 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 36569780b0d64de283f9d6c2195fd1a43e221ee8
Message-ID: <202507150752.ZY4L522H-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/urgent
branch HEAD: 36569780b0d64de283f9d6c2195fd1a43e221ee8  sched: Change nr_uninterruptible type to unsigned long

elapsed time: 866m

configs tested: 254
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-21
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-21
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20250714    gcc-8.5.0
arc                   randconfig-001-20250715    clang-21
arc                   randconfig-002-20250714    gcc-8.5.0
arc                   randconfig-002-20250715    clang-21
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                          moxart_defconfig    gcc-15.1.0
arm                        multi_v5_defconfig    gcc-15.1.0
arm                        multi_v7_defconfig    gcc-15.1.0
arm                   randconfig-001-20250714    clang-21
arm                   randconfig-001-20250715    clang-21
arm                   randconfig-002-20250714    gcc-8.5.0
arm                   randconfig-002-20250715    clang-21
arm                   randconfig-003-20250714    clang-21
arm                   randconfig-003-20250715    clang-21
arm                   randconfig-004-20250714    gcc-8.5.0
arm                   randconfig-004-20250715    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-21
arm64                             allnoconfig    gcc-15.1.0
arm64                            allyesconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250714    gcc-13.4.0
arm64                 randconfig-001-20250715    clang-21
arm64                 randconfig-002-20250714    gcc-8.5.0
arm64                 randconfig-002-20250715    clang-21
arm64                 randconfig-003-20250714    gcc-8.5.0
arm64                 randconfig-003-20250715    clang-21
arm64                 randconfig-004-20250714    gcc-14.3.0
arm64                 randconfig-004-20250715    clang-21
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250714    gcc-10.5.0
csky                  randconfig-001-20250715    gcc-12.4.0
csky                  randconfig-002-20250714    gcc-15.1.0
csky                  randconfig-002-20250715    gcc-12.4.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250714    clang-21
hexagon               randconfig-001-20250715    gcc-12.4.0
hexagon               randconfig-002-20250714    clang-21
hexagon               randconfig-002-20250715    gcc-12.4.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250714    gcc-12
i386        buildonly-randconfig-002-20250714    clang-20
i386        buildonly-randconfig-003-20250714    gcc-12
i386        buildonly-randconfig-004-20250714    gcc-12
i386        buildonly-randconfig-005-20250714    gcc-12
i386        buildonly-randconfig-006-20250714    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250715    clang-20
i386                  randconfig-002-20250715    clang-20
i386                  randconfig-003-20250715    clang-20
i386                  randconfig-004-20250715    clang-20
i386                  randconfig-005-20250715    clang-20
i386                  randconfig-006-20250715    clang-20
i386                  randconfig-007-20250715    clang-20
i386                  randconfig-011-20250715    gcc-12
i386                  randconfig-012-20250715    gcc-12
i386                  randconfig-013-20250715    gcc-12
i386                  randconfig-014-20250715    gcc-12
i386                  randconfig-015-20250715    gcc-12
i386                  randconfig-016-20250715    gcc-12
i386                  randconfig-017-20250715    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch                        allyesconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250714    gcc-15.1.0
loongarch             randconfig-001-20250715    gcc-12.4.0
loongarch             randconfig-002-20250714    gcc-15.1.0
loongarch             randconfig-002-20250715    gcc-12.4.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                      loongson3_defconfig    gcc-15.1.0
nios2                            allmodconfig    clang-21
nios2                             allnoconfig    gcc-15.1.0
nios2                            allyesconfig    clang-21
nios2                               defconfig    gcc-14.2.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250714    gcc-12.4.0
nios2                 randconfig-001-20250715    gcc-12.4.0
nios2                 randconfig-002-20250714    gcc-8.5.0
nios2                 randconfig-002-20250715    gcc-12.4.0
openrisc                         allmodconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250714    gcc-8.5.0
parisc                randconfig-001-20250715    gcc-12.4.0
parisc                randconfig-002-20250714    gcc-8.5.0
parisc                randconfig-002-20250715    gcc-12.4.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-15.1.0
powerpc               randconfig-001-20250714    gcc-10.5.0
powerpc               randconfig-001-20250715    gcc-12.4.0
powerpc               randconfig-002-20250714    gcc-10.5.0
powerpc               randconfig-002-20250715    gcc-12.4.0
powerpc               randconfig-003-20250714    gcc-8.5.0
powerpc               randconfig-003-20250715    gcc-12.4.0
powerpc64             randconfig-001-20250714    clang-16
powerpc64             randconfig-001-20250715    gcc-12.4.0
powerpc64             randconfig-002-20250714    gcc-8.5.0
powerpc64             randconfig-002-20250715    gcc-12.4.0
powerpc64             randconfig-003-20250714    clang-21
powerpc64             randconfig-003-20250715    gcc-12.4.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250714    gcc-8.5.0
riscv                 randconfig-001-20250715    gcc-8.5.0
riscv                 randconfig-002-20250714    gcc-15.1.0
riscv                 randconfig-002-20250715    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250714    clang-21
s390                  randconfig-001-20250715    gcc-8.5.0
s390                  randconfig-002-20250714    clang-18
s390                  randconfig-002-20250715    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250714    gcc-12.4.0
sh                    randconfig-001-20250715    gcc-8.5.0
sh                    randconfig-002-20250714    gcc-11.5.0
sh                    randconfig-002-20250715    gcc-8.5.0
sh                           se7343_defconfig    gcc-15.1.0
sh                           sh2007_defconfig    gcc-15.1.0
sparc                            alldefconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                            allyesconfig    clang-21
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250714    gcc-8.5.0
sparc                 randconfig-001-20250715    gcc-8.5.0
sparc                 randconfig-002-20250714    gcc-8.5.0
sparc                 randconfig-002-20250715    gcc-8.5.0
sparc64                          allmodconfig    clang-21
sparc64                          allyesconfig    clang-21
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250714    clang-21
sparc64               randconfig-001-20250715    gcc-8.5.0
sparc64               randconfig-002-20250714    clang-21
sparc64               randconfig-002-20250715    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250714    gcc-12
um                    randconfig-001-20250715    gcc-8.5.0
um                    randconfig-002-20250714    gcc-11
um                    randconfig-002-20250715    gcc-8.5.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250714    gcc-12
x86_64      buildonly-randconfig-001-20250715    gcc-12
x86_64      buildonly-randconfig-002-20250714    clang-20
x86_64      buildonly-randconfig-002-20250715    gcc-12
x86_64      buildonly-randconfig-003-20250714    gcc-12
x86_64      buildonly-randconfig-003-20250715    gcc-12
x86_64      buildonly-randconfig-004-20250714    gcc-12
x86_64      buildonly-randconfig-004-20250715    gcc-12
x86_64      buildonly-randconfig-005-20250714    clang-20
x86_64      buildonly-randconfig-005-20250715    gcc-12
x86_64      buildonly-randconfig-006-20250714    gcc-12
x86_64      buildonly-randconfig-006-20250715    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250715    gcc-12
x86_64                randconfig-002-20250715    gcc-12
x86_64                randconfig-003-20250715    gcc-12
x86_64                randconfig-004-20250715    gcc-12
x86_64                randconfig-005-20250715    gcc-12
x86_64                randconfig-006-20250715    gcc-12
x86_64                randconfig-007-20250715    gcc-12
x86_64                randconfig-008-20250715    gcc-12
x86_64                randconfig-071-20250715    gcc-12
x86_64                randconfig-072-20250715    gcc-12
x86_64                randconfig-073-20250715    gcc-12
x86_64                randconfig-074-20250715    gcc-12
x86_64                randconfig-075-20250715    gcc-12
x86_64                randconfig-076-20250715    gcc-12
x86_64                randconfig-077-20250715    gcc-12
x86_64                randconfig-078-20250715    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    clang-21
xtensa                randconfig-001-20250714    gcc-8.5.0
xtensa                randconfig-001-20250715    gcc-8.5.0
xtensa                randconfig-002-20250714    gcc-12.4.0
xtensa                randconfig-002-20250715    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


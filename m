Return-Path: <linux-kernel+bounces-886201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3035C34FA3
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 10:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBF483B31B3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 09:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE022309EE8;
	Wed,  5 Nov 2025 09:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tr9Pnzm2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7333B21FF48
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 09:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762336425; cv=none; b=LVq6F4omlWJYr0wnlymu1KnMd5+hdlgcrqXmOEnXc1aWYM/Z/uwLLMa5QDB1LfuHbhA67r8Xv89A92xdvHlGEnpXdBJjBkqV4XDm+NgGsegri1Ubj6moPd636B1sksMPd4eMVWmmQI/J0ry8oe19YGNzpQO3fB6t8XvzU7GnoVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762336425; c=relaxed/simple;
	bh=nIoDBMDAawU9DurJzEG3Y7tbAJTaBddYSPkw3hUhXB8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=NLIb9MkdiN6IjaA3YwdCUt10sUTP80CHz3znZiVFywFKf+DE4L//r/2HrQEQ+1/US3WnoYfJLyWAhvSt5nh/l7fvcd0v1b6wXV/14VVk+Ocd8UnljwYRJbfVr7hpkL8fIusBim+vulqu8X57ulXwC73A905T+T+FpQmYY901gko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tr9Pnzm2; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762336424; x=1793872424;
  h=date:from:to:cc:subject:message-id;
  bh=nIoDBMDAawU9DurJzEG3Y7tbAJTaBddYSPkw3hUhXB8=;
  b=Tr9Pnzm2gQqXvbh+CFrwNVWPcwtwsV3/N7ytfamllMl2LikWTyNgfSYm
   VLvhHb/nEjh/1u7pyF3dy1hRdWZ3+/gcppE+U6kWjjxTZ6Djig1jJoREf
   qi8mRRH/7yswlUzNydNhmHroCCvgQ6rNOlaP0owCw59kFGDDCi1pEQvX2
   HdjgmzUkek8hggM+tWO1e1b7sZv/6KCNnLmnV+eqLymJhgmvemSRq3Wbn
   b9i1uDcj/rF6k8SGK8zQMZnODqkA80kU6L2AmW+HWXET0rWXuKMxWfd+3
   2zc+HKEEN5kb56FP8qs0NZb2Lr6uJ3LZpE3aI1mS0Jnu4z+eev+BUfhCB
   Q==;
X-CSE-ConnectionGUID: JYZuoVEQRIiLCURkPeMjtg==
X-CSE-MsgGUID: uGI8uRuKTG6VixyIIoYiJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="75554664"
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="75554664"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 01:53:44 -0800
X-CSE-ConnectionGUID: 54V7RmdZSSG4pUmutrgWfQ==
X-CSE-MsgGUID: M3aOO4rDSneGO5WNsyNywg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="191510666"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 05 Nov 2025 01:53:42 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGaCx-000SOE-1O;
	Wed, 05 Nov 2025 09:53:39 +0000
Date: Wed, 05 Nov 2025 17:53:22 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:tip/urgent] BUILD SUCCESS
 02d7ba924ed2ed43131a133d98884bfdcf38b9c1
Message-ID: <202511051716.nyk4X0AN-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tip/urgent
branch HEAD: 02d7ba924ed2ed43131a133d98884bfdcf38b9c1  Merge branch into tip/master: 'x86/urgent'

elapsed time: 1507m

configs tested: 101
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20251104    gcc-12.5.0
arc                   randconfig-002-20251104    gcc-9.5.0
arm                               allnoconfig    clang-22
arm                   randconfig-001-20251104    gcc-14.3.0
arm                   randconfig-002-20251104    gcc-10.5.0
arm                   randconfig-003-20251104    clang-22
arm                   randconfig-004-20251104    gcc-8.5.0
arm64                             allnoconfig    gcc-15.1.0
arm64                            allyesconfig    clang-22
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon               randconfig-001-20251104    clang-22
hexagon               randconfig-002-20251104    clang-16
i386                              allnoconfig    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                        allyesconfig    clang-22
loongarch             randconfig-001-20251104    gcc-15.1.0
loongarch             randconfig-002-20251104    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                            allyesconfig    clang-22
nios2                 randconfig-001-20251104    gcc-8.5.0
nios2                 randconfig-002-20251104    gcc-11.5.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                randconfig-001-20251104    gcc-8.5.0
parisc                randconfig-002-20251104    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc               randconfig-001-20251104    gcc-15.1.0
powerpc               randconfig-002-20251104    clang-22
powerpc64             randconfig-001-20251104    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                 randconfig-001-20251104    gcc-8.5.0
riscv                 randconfig-002-20251104    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20251104    clang-22
s390                  randconfig-002-20251104    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20251104    gcc-13.4.0
sh                    randconfig-002-20251104    gcc-11.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                            allyesconfig    clang-22
sparc                 randconfig-001-20251105    gcc-12.5.0
sparc                 randconfig-002-20251105    gcc-15.1.0
sparc64                          allmodconfig    clang-22
sparc64                          allyesconfig    clang-22
sparc64               randconfig-001-20251105    clang-22
sparc64               randconfig-002-20251105    gcc-10.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                    randconfig-001-20251105    clang-22
um                    randconfig-002-20251105    gcc-14
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251105    clang-20
x86_64      buildonly-randconfig-002-20251105    gcc-13
x86_64      buildonly-randconfig-003-20251105    gcc-14
x86_64      buildonly-randconfig-004-20251105    gcc-13
x86_64      buildonly-randconfig-005-20251105    gcc-14
x86_64      buildonly-randconfig-006-20251105    gcc-13
x86_64                                  kexec    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20251105    gcc-11.5.0
xtensa                randconfig-002-20251105    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


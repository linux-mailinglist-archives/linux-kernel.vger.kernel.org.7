Return-Path: <linux-kernel+bounces-815080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCD0B55F21
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 09:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58A6C1B2469F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 07:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933EB2E7F07;
	Sat, 13 Sep 2025 07:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="adI5EIKO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7EF8488
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 07:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757748693; cv=none; b=YeBs2+RJI3D6bV7OGrlHaTvfwow5TPWJJGGTqk8ufVecNhgK4KZBQNt4rJ0z8sAZSK71bo00SN8asYtHc06fyDT5zNyuowwF4i8ugA2buQyFVToJvvyXr8FlNJ6eLXP9SKrI5VrT/3MDNSlZ7x0oKm22mgVI6c9b+MLobKedz3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757748693; c=relaxed/simple;
	bh=P4bLcGlr7o1CgPzDUqHdF4TsaXGxGtKexYGR+3+axpo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fJk9PnYizcNGnnl0ssXudgUTTIupTrEAcn1sspjICbzUecUIYWOpj1DB2FJ21e2vxCwIkRBxH03pbztrhq5sbnbvuHKIuPu8EWrPAnPF0UtApBv3UjBZ+9i4/ooWrmeoJwXyR/P2bFjwzV0vsb4kN7pz/hz1tbKbZX/zs3ORoLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=adI5EIKO; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757748692; x=1789284692;
  h=date:from:to:cc:subject:message-id;
  bh=P4bLcGlr7o1CgPzDUqHdF4TsaXGxGtKexYGR+3+axpo=;
  b=adI5EIKOyoUFnwgSP7IqCo8kAu/FR6UDFB1gakV8KKH8KIZFkMOJG4gw
   Yc6YFvJvJBXf5fW0Bx4GivklNlZzo6gHEH/he7tNmLCTA4+UMx1J3/4aX
   g1bsyrBA08Qxi36sRdvxG7iL02HVFEpKASlFDg/CpTPjci+2YzY+v7GOr
   qRr1BSSK1RNxH5ArTuWnkPgbArA9hWShYtFMk8QG8MhkSaaeZNaFaTMs/
   hX1v9HQvDe5fJ/Q9qKA6ZooSR78ikssIuzVw4Jh0gyI7OdgoazE7ZDS7I
   PcSs10acOBAxWFDZ3f8EQ1ph7PKRgy04wjYjx3VT+eX2OfpyqczZQIvqB
   Q==;
X-CSE-ConnectionGUID: KSawJ752RZyyrdE262ek1w==
X-CSE-MsgGUID: mJEKgN56QU2veawU5r9ndw==
X-IronPort-AV: E=McAfee;i="6800,10657,11551"; a="70338553"
X-IronPort-AV: E=Sophos;i="6.18,261,1751266800"; 
   d="scan'208";a="70338553"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2025 00:31:31 -0700
X-CSE-ConnectionGUID: ES+MGgE2RGe5IO7WVfrRkA==
X-CSE-MsgGUID: B5MHztF7Q4+yrWBQj80rYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,261,1751266800"; 
   d="scan'208";a="179341835"
Received: from lkp-server02.sh.intel.com (HELO eb5fdfb2a9b7) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 13 Sep 2025 00:31:30 -0700
Received: from kbuild by eb5fdfb2a9b7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uxKjH-0001PE-2M;
	Sat, 13 Sep 2025 07:31:27 +0000
Date: Sat, 13 Sep 2025 15:30:52 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:tip/urgent] BUILD SUCCESS
 72dfe83e9fe2a9ebae30b0045c05a0ececd844e8
Message-ID: <202509131542.mzJ3IHiS-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tip/urgent
branch HEAD: 72dfe83e9fe2a9ebae30b0045c05a0ececd844e8  Merge branch into tip/master: 'x86/urgent'

elapsed time: 1445m

configs tested: 126
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
arc                   randconfig-001-20250912    gcc-10.5.0
arc                   randconfig-002-20250912    gcc-12.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                   milbeaut_m10v_defconfig    clang-19
arm                   randconfig-001-20250912    clang-22
arm                   randconfig-002-20250912    gcc-14.3.0
arm                   randconfig-003-20250912    clang-22
arm                   randconfig-004-20250912    gcc-10.5.0
arm                           sama5_defconfig    gcc-15.1.0
arm                        spear6xx_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250912    clang-20
arm64                 randconfig-002-20250912    clang-16
arm64                 randconfig-003-20250912    clang-22
arm64                 randconfig-004-20250912    clang-19
csky                             alldefconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250912    gcc-15.1.0
csky                  randconfig-002-20250912    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250912    clang-22
hexagon               randconfig-002-20250912    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20250912    gcc-14
i386        buildonly-randconfig-002-20250912    clang-20
i386        buildonly-randconfig-003-20250912    gcc-13
i386        buildonly-randconfig-004-20250912    clang-20
i386        buildonly-randconfig-005-20250912    gcc-14
i386        buildonly-randconfig-006-20250912    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250912    gcc-15.1.0
loongarch             randconfig-002-20250912    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                          atari_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                         bigsur_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250912    gcc-11.5.0
nios2                 randconfig-002-20250912    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250912    gcc-14.3.0
parisc                randconfig-002-20250912    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250912    gcc-8.5.0
powerpc               randconfig-002-20250912    clang-22
powerpc               randconfig-003-20250912    clang-17
powerpc64             randconfig-001-20250912    gcc-12.5.0
powerpc64             randconfig-002-20250912    clang-22
powerpc64             randconfig-003-20250912    clang-19
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250912    clang-16
riscv                 randconfig-002-20250912    gcc-9.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250912    gcc-10.5.0
s390                  randconfig-002-20250912    gcc-10.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                        edosk7705_defconfig    gcc-15.1.0
sh                    randconfig-001-20250912    gcc-15.1.0
sh                    randconfig-002-20250912    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250912    gcc-8.5.0
sparc                 randconfig-002-20250912    gcc-13.4.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250912    gcc-8.5.0
sparc64               randconfig-002-20250912    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                    randconfig-001-20250912    clang-22
um                    randconfig-002-20250912    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250912    gcc-14
x86_64      buildonly-randconfig-002-20250912    gcc-14
x86_64      buildonly-randconfig-003-20250912    clang-20
x86_64      buildonly-randconfig-004-20250912    clang-20
x86_64      buildonly-randconfig-005-20250912    clang-20
x86_64      buildonly-randconfig-006-20250912    gcc-14
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250912    gcc-9.5.0
xtensa                randconfig-002-20250912    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


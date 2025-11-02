Return-Path: <linux-kernel+bounces-882055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED735C29829
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 23:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35D5C3AA76F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 22:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F1522422B;
	Sun,  2 Nov 2025 22:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ue2SEWAt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701EC9460
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 22:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762121438; cv=none; b=AUVrG+k4wzdIMOCYPEDO/kRhd7urxqFsmK0OqoxGtmU8KPMTqslwuYT0MiP3F/GdKOJ3ufqAHCe7jOWNg8sk7KUpWpvupAwJRWBOVisTSnM3BhHU2Zpd4Fx9BQg4s2eDYg2y+mi/kSxp/RqGRnZxpvir50f7Z8fmRsRb5dQTV2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762121438; c=relaxed/simple;
	bh=sSNGD699H3fqP8iP1x3cfIqILYxRD2de/LEG6ag/h9M=;
	h=Date:From:To:Cc:Subject:Message-ID; b=QvzKpGWrwcUDx7rHjL6RZo+Qhcrl0Y3x4TAsj5MAJXYIRRFL6o891VqjrfAblM+L1lnTLj4e75ZKn5s8UZSjQzzE0Kx9WV4hNP6/DHMdOCE75gFXNcWjx2VHdTcL7Vd83CBqbhOO+xl4JArqrfNpu7dg2AxL1/z2qdE5Yc0bskk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ue2SEWAt; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762121437; x=1793657437;
  h=date:from:to:cc:subject:message-id;
  bh=sSNGD699H3fqP8iP1x3cfIqILYxRD2de/LEG6ag/h9M=;
  b=Ue2SEWAtBF2rwVjfD+5xWt42Rl2joVUG3OGrI5qsDbQafuyc2U9kXgwu
   OBS/1qQHlqDWudNdWfAANuMn5sIHUGkx0Sk7Uvn6bfGn3RhwkZQCMWaSA
   ZWQ/YRPOw9GMEUa0iPlOd+RrvwCDIqG7jlEsd3/eUTzCLYHU6+ASFPnby
   yj29xCJzumFkQh3Vr9DH3VTv6TzYXgExt1zrSAV6LshfK7hV/VndZgWP0
   UTi49WDvdsFtcwBKlG4CRYka6rfsygoBNWs5vJ2RcIkBo1YJMDoqCbMKi
   WqNu98e7dNDJASUvXpGFcDENosdejReey04SNbZmRKSe/+2H21u1kKa37
   Q==;
X-CSE-ConnectionGUID: ITmbhrxATCWh+V/3z1N9Ow==
X-CSE-MsgGUID: i/lDkr75RvmHTm76qSZrBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="67855201"
X-IronPort-AV: E=Sophos;i="6.19,274,1754982000"; 
   d="scan'208";a="67855201"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2025 14:10:37 -0800
X-CSE-ConnectionGUID: /2jNJVJxRR6QTFejtJB5WQ==
X-CSE-MsgGUID: wISCRudsT7ewhYAMMvV8OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,274,1754982000"; 
   d="scan'208";a="186386106"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 02 Nov 2025 14:10:35 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vFgHQ-000Pbg-2K;
	Sun, 02 Nov 2025 22:10:32 +0000
Date: Mon, 03 Nov 2025 06:09:39 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:next.2025.11.01a] BUILD SUCCESS
 2fd20521e6f8bafcc753efc9d0cb7f4c34378038
Message-ID: <202511030633.AJXqjrgP-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git next.2025.11.01a
branch HEAD: 2fd20521e6f8bafcc753efc9d0cb7f4c34378038  refscale: Add SRCU-fast-updown readers

elapsed time: 1064m

configs tested: 179
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                   randconfig-001-20251102    gcc-14.3.0
arc                   randconfig-001-20251102    gcc-8.5.0
arc                   randconfig-002-20251102    gcc-14.3.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                   randconfig-001-20251102    gcc-14.3.0
arm                   randconfig-001-20251102    gcc-15.1.0
arm                   randconfig-002-20251102    gcc-10.5.0
arm                   randconfig-002-20251102    gcc-14.3.0
arm                   randconfig-003-20251102    gcc-14.3.0
arm                   randconfig-003-20251102    gcc-8.5.0
arm                   randconfig-004-20251102    gcc-14.3.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                            allyesconfig    gcc-15.1.0
arm64                 randconfig-001-20251102    gcc-12.5.0
arm64                 randconfig-002-20251102    gcc-12.5.0
arm64                 randconfig-003-20251102    gcc-12.5.0
arm64                 randconfig-004-20251102    gcc-12.5.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                  randconfig-001-20251102    gcc-12.5.0
csky                  randconfig-002-20251102    gcc-12.5.0
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon               randconfig-001-20251102    clang-22
hexagon               randconfig-001-20251102    gcc-15.1.0
hexagon               randconfig-002-20251102    clang-22
hexagon               randconfig-002-20251102    gcc-15.1.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20251102    gcc-14
i386        buildonly-randconfig-002-20251102    gcc-14
i386        buildonly-randconfig-003-20251102    gcc-14
i386        buildonly-randconfig-004-20251102    gcc-14
i386        buildonly-randconfig-005-20251102    gcc-14
i386        buildonly-randconfig-006-20251102    gcc-14
i386                  randconfig-001-20251102    clang-20
i386                  randconfig-002-20251102    clang-20
i386                  randconfig-003-20251102    clang-20
i386                  randconfig-004-20251102    clang-20
i386                  randconfig-005-20251102    clang-20
i386                  randconfig-006-20251102    clang-20
i386                  randconfig-007-20251102    clang-20
i386                  randconfig-011-20251102    clang-20
i386                  randconfig-012-20251102    clang-20
i386                  randconfig-013-20251102    clang-20
i386                  randconfig-014-20251102    clang-20
i386                  randconfig-015-20251102    clang-20
i386                  randconfig-016-20251102    clang-20
i386                  randconfig-017-20251102    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                        allyesconfig    gcc-15.1.0
loongarch             randconfig-001-20251102    gcc-15.1.0
loongarch             randconfig-002-20251102    gcc-15.1.0
m68k                             allmodconfig    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                            allyesconfig    clang-22
nios2                 randconfig-001-20251102    gcc-11.5.0
nios2                 randconfig-001-20251102    gcc-15.1.0
nios2                 randconfig-002-20251102    gcc-11.5.0
nios2                 randconfig-002-20251102    gcc-15.1.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                randconfig-001-20251102    gcc-8.5.0
parisc                randconfig-002-20251102    gcc-14.3.0
parisc                randconfig-002-20251102    gcc-8.5.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc               randconfig-001-20251102    gcc-8.5.0
powerpc               randconfig-001-20251102    gcc-9.5.0
powerpc               randconfig-002-20251102    clang-18
powerpc               randconfig-002-20251102    gcc-8.5.0
powerpc64             randconfig-001-20251102    gcc-14.3.0
powerpc64             randconfig-001-20251102    gcc-8.5.0
powerpc64             randconfig-002-20251102    gcc-8.5.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                 randconfig-001-20251102    gcc-13.4.0
riscv                 randconfig-002-20251102    gcc-14.3.0
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-002-20251102    gcc-11.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20251102    gcc-13.4.0
sh                    randconfig-002-20251102    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                            allyesconfig    clang-22
sparc                 randconfig-001-20251102    clang-22
sparc                 randconfig-002-20251102    clang-22
sparc64                          allmodconfig    clang-22
sparc64                          allyesconfig    clang-22
sparc64               randconfig-001-20251102    clang-22
sparc64               randconfig-002-20251102    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                    randconfig-001-20251102    clang-22
um                    randconfig-002-20251102    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251102    clang-20
x86_64      buildonly-randconfig-002-20251102    clang-20
x86_64      buildonly-randconfig-003-20251102    clang-20
x86_64      buildonly-randconfig-004-20251102    clang-20
x86_64      buildonly-randconfig-005-20251102    clang-20
x86_64      buildonly-randconfig-006-20251102    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251102    gcc-14
x86_64                randconfig-001-20251103    clang-20
x86_64                randconfig-002-20251102    gcc-14
x86_64                randconfig-002-20251103    clang-20
x86_64                randconfig-003-20251102    gcc-14
x86_64                randconfig-003-20251103    clang-20
x86_64                randconfig-004-20251102    gcc-14
x86_64                randconfig-004-20251103    clang-20
x86_64                randconfig-005-20251102    gcc-14
x86_64                randconfig-005-20251103    clang-20
x86_64                randconfig-006-20251102    gcc-14
x86_64                randconfig-006-20251103    clang-20
x86_64                randconfig-011-20251102    gcc-14
x86_64                randconfig-012-20251102    gcc-14
x86_64                randconfig-013-20251102    gcc-14
x86_64                randconfig-014-20251102    gcc-14
x86_64                randconfig-015-20251102    gcc-14
x86_64                randconfig-016-20251102    gcc-14
x86_64                randconfig-071-20251102    gcc-14
x86_64                randconfig-071-20251103    gcc-14
x86_64                randconfig-072-20251102    gcc-14
x86_64                randconfig-072-20251103    gcc-14
x86_64                randconfig-073-20251102    gcc-14
x86_64                randconfig-073-20251103    gcc-14
x86_64                randconfig-074-20251102    gcc-14
x86_64                randconfig-074-20251103    gcc-14
x86_64                randconfig-075-20251102    gcc-14
x86_64                randconfig-075-20251103    gcc-14
x86_64                randconfig-076-20251102    gcc-14
x86_64                randconfig-076-20251103    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20251102    clang-22
xtensa                randconfig-002-20251102    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


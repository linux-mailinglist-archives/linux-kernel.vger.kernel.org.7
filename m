Return-Path: <linux-kernel+bounces-882161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DEFC29C8E
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 02:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD22F3AD8CA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 01:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC625275AF0;
	Mon,  3 Nov 2025 01:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BHO1tpvE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6DC2749F1
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 01:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762133628; cv=none; b=dwm5QIlvakGQfqlJjlT8AGM/XFiHQu4T4oUVv6SqPphP/cyGPTzDdQC/8qzDQ0Q9HmdIlGF9xEBZCAXX2JtjhBdWk/j/jiziDMMd/WJ0IXcigSSFGpAdTPIUa4eHXQORSb7iYXfgvbP4t98DaptgD8C/w3zwBdI90Tj1wzpTrfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762133628; c=relaxed/simple;
	bh=1zyiSKJ4Xr5OKM2SNCkfEH4/z2/1I8m77T/K247e8pk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XSQ31gb7qQKl7hozOBzKRDPIH6xTvWdu9vhiWZaEyEHoTYKAqYso+gvC/KIYq6LIy+42rTKYgOaQyXBRHhfJz3V8B3ZPalfOT51CJPEaVVRJH/nrbC82RUrDBGQflCePkPdFrQv0ufwUhlGuuiL8oXt6hNNLkWkYbCATntZwmvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BHO1tpvE; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762133626; x=1793669626;
  h=date:from:to:cc:subject:message-id;
  bh=1zyiSKJ4Xr5OKM2SNCkfEH4/z2/1I8m77T/K247e8pk=;
  b=BHO1tpvEbXUxR2l5hg+AIBbCzov0fUgcLQ/Be6HAEu88KtLcMr3cn6US
   CTr8NeIsA5jF91wFkQCgTttcwVCsRP4/s8AvyfUGfbk72wsH4bYs85Egc
   my5GnIJvFkgVj9qvB976ngRyUutE9S5HPpT0g6beX9g00EPeiER+TOTZJ
   qsqX7AqAM2QrILmTTGnTa5HrKK6y98AEAxjZn/nzpGAOKsuUnsQWvwGhJ
   DaL1Iw520TSr5u9JUTOySkY9AO5c/58fM5x0e+pLCaaoyTyHxZi8dsFb9
   /vMCFTzpUE5t16tjzqKoIWYVe+F/AM3aC/mnJpyOi+jwIlyhBcghwUzVP
   g==;
X-CSE-ConnectionGUID: 2MAldgAZSQqdMvsXYhQaDA==
X-CSE-MsgGUID: t2J/H1+iQxqaLpnscGpBPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="64238934"
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="64238934"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2025 17:33:45 -0800
X-CSE-ConnectionGUID: IJJlZwmgRley1hZav95BDw==
X-CSE-MsgGUID: RkO7+kjUR6eEYdnZj5TX3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="210273013"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 02 Nov 2025 17:33:45 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vFjRx-000PiK-0C;
	Mon, 03 Nov 2025 01:33:42 +0000
Date: Mon, 03 Nov 2025 09:32:36 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev] BUILD SUCCESS
 106ba23fb08b048cb9fb8f0b6928a95768c66fe7
Message-ID: <202511030931.zZnaXeQ8-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
branch HEAD: 106ba23fb08b048cb9fb8f0b6928a95768c66fe7  rcutorture: Test rcu_tasks_trace_expedite_current()

elapsed time: 1268m

configs tested: 144
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                   randconfig-001-20251102    gcc-14.3.0
arc                   randconfig-002-20251102    gcc-14.3.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                   randconfig-001-20251102    gcc-14.3.0
arm                   randconfig-002-20251102    gcc-14.3.0
arm                   randconfig-003-20251102    gcc-14.3.0
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
hexagon               randconfig-001-20251102    gcc-15.1.0
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
nios2                 randconfig-001-20251102    gcc-15.1.0
nios2                 randconfig-002-20251102    gcc-15.1.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                randconfig-001-20251102    gcc-8.5.0
parisc                randconfig-002-20251102    gcc-8.5.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc               randconfig-001-20251102    gcc-8.5.0
powerpc               randconfig-002-20251102    gcc-8.5.0
powerpc64             randconfig-001-20251102    gcc-8.5.0
powerpc64             randconfig-002-20251102    gcc-8.5.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
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
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251103    clang-20
x86_64                randconfig-002-20251103    clang-20
x86_64                randconfig-003-20251103    clang-20
x86_64                randconfig-004-20251103    clang-20
x86_64                randconfig-005-20251103    clang-20
x86_64                randconfig-006-20251103    clang-20
x86_64                randconfig-011-20251102    gcc-14
x86_64                randconfig-012-20251102    gcc-14
x86_64                randconfig-013-20251102    gcc-14
x86_64                randconfig-014-20251102    gcc-14
x86_64                randconfig-015-20251102    gcc-14
x86_64                randconfig-016-20251102    gcc-14
x86_64                randconfig-071-20251102    gcc-14
x86_64                randconfig-072-20251102    gcc-14
x86_64                randconfig-073-20251102    gcc-14
x86_64                randconfig-074-20251102    gcc-14
x86_64                randconfig-075-20251102    gcc-14
x86_64                randconfig-076-20251102    gcc-14
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


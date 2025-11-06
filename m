Return-Path: <linux-kernel+bounces-888828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 726A9C3C030
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 16:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D5E51351194
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 15:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738192676DE;
	Thu,  6 Nov 2025 15:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XOpgCZxf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE9C2475D0
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762442490; cv=none; b=LoQhcevrhr1OuWsv8DKnDS5+TUwmmzt6dmE4hSyEV0eEfCzPaXx3EpenU0YfmZ7GpGRqTs0MY9lHMYhENjMGS0IPbCHrvB5dfz2c+Nm3R96ltQ9Ykorx3MxyB4KGQKOA+PT2Bc7JW9zNaiyzZBrj8U4z1WTzIbBmZitqWivXN6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762442490; c=relaxed/simple;
	bh=isREqGd92ZpBt2/tQSwXj2q5bNieqCxB8qmfdeJT948=;
	h=Date:From:To:Cc:Subject:Message-ID; b=O7fLIUzsGNZoEZMgJArh0lGwfcTKX6GhovYJ0dyhohn5xhUvI6U+yxetfcV9GO10AdvRiQEEGmPrOFX4GwVtabjSUMXIb5XGKjnvziL2OuQqsiCBPbAc8MPfX19uFmqHwOTlcTN2s+JGAcZEhYhcxcaqC2a729UYOADFKRbOhtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XOpgCZxf; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762442489; x=1793978489;
  h=date:from:to:cc:subject:message-id;
  bh=isREqGd92ZpBt2/tQSwXj2q5bNieqCxB8qmfdeJT948=;
  b=XOpgCZxfXgVkohGa7Me1y7Kv2t7HunyW5Ag0nLcdkY05Zq/jwUSi9cJ6
   bIwXJFQW3f3QNMTWgmOaZCiE3vkKi7uBs18EnhxtreySwJJad6lOgnUdy
   t27S33Ha/MUReBAZ5osm2kNqzEF07tle5BPnmluDBXrPKgTLmLin57yAE
   oh/5HPvlBsQE2a54paIp2KgFYZxeOvobnRZV1rMtWjfCiaem6AADZYl5Z
   6NYH+Y2spzmuuqxd5lYuxcV0Aa7Og3LENa8+KUiktmNYWX18T+Nr2lrht
   SjO33RJ1Ey2mlziSf9MZcafuXM+Lpp3A5QpIYDOOjfAxbSp/KUofm4QW0
   A==;
X-CSE-ConnectionGUID: mslvcKvwRKuJTNckc2emkw==
X-CSE-MsgGUID: 5aUWheriSoqwziq75k/aUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="67192637"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="67192637"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 07:21:28 -0800
X-CSE-ConnectionGUID: A7jORZPNRMO3xdUeahNRjw==
X-CSE-MsgGUID: 7UtivsLYTui9ey9xNhe/Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="187073249"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 06 Nov 2025 07:21:27 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vH1nh-000U4Z-0E;
	Thu, 06 Nov 2025 15:21:25 +0000
Date: Thu, 06 Nov 2025 23:21:03 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 cf76553aaa363620f58a6b6409bf544f4bcfa8de
Message-ID: <202511062357.d3PVdgvx-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
branch HEAD: cf76553aaa363620f58a6b6409bf544f4bcfa8de  entry,unwind/deferred: Fix unwind_reset_info() placement

elapsed time: 1565m

configs tested: 99
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                            hsdk_defconfig    gcc-15.1.0
arc                   randconfig-001-20251106    gcc-12.5.0
arc                   randconfig-002-20251106    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                       omap2plus_defconfig    gcc-15.1.0
arm                   randconfig-001-20251106    gcc-11.5.0
arm                   randconfig-002-20251106    clang-22
arm                   randconfig-003-20251106    gcc-10.5.0
arm                   randconfig-004-20251106    gcc-8.5.0
arm                        vexpress_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251106    gcc-11.5.0
arm64                 randconfig-002-20251106    clang-19
arm64                 randconfig-003-20251106    gcc-14.3.0
arm64                 randconfig-004-20251106    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251106    gcc-12.5.0
csky                  randconfig-002-20251106    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20251106    clang-19
hexagon               randconfig-002-20251106    clang-20
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251106    clang-20
i386        buildonly-randconfig-002-20251106    clang-20
i386        buildonly-randconfig-003-20251106    gcc-14
i386        buildonly-randconfig-004-20251106    clang-20
i386        buildonly-randconfig-005-20251106    gcc-14
i386        buildonly-randconfig-006-20251106    gcc-14
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251106    gcc-15.1.0
loongarch             randconfig-002-20251106    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           ip28_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251106    gcc-9.5.0
nios2                 randconfig-002-20251106    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                randconfig-001-20251106    gcc-10.5.0
parisc                randconfig-002-20251106    gcc-10.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20251106    gcc-14.3.0
powerpc               randconfig-002-20251106    clang-22
powerpc64             randconfig-002-20251106    gcc-8.5.0
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20251105    gcc-8.5.0
riscv                 randconfig-002-20251105    clang-18
s390                              allnoconfig    clang-22
s390                  randconfig-001-20251105    gcc-8.5.0
s390                  randconfig-002-20251105    gcc-14.3.0
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251105    gcc-10.5.0
sh                    randconfig-002-20251105    gcc-11.5.0
sh                      rts7751r2d1_defconfig    gcc-15.1.0
sh                           se7712_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20251106    gcc-15.1.0
sparc                 randconfig-002-20251106    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251106    gcc-13.4.0
sparc64               randconfig-002-20251106    clang-20
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251106    gcc-14
um                    randconfig-002-20251106    clang-22
um                           x86_64_defconfig    clang-22
x86_64                           alldefconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251106    gcc-12
x86_64      buildonly-randconfig-002-20251106    gcc-14
x86_64      buildonly-randconfig-003-20251106    gcc-14
x86_64      buildonly-randconfig-004-20251106    gcc-14
x86_64      buildonly-randconfig-005-20251106    clang-20
x86_64      buildonly-randconfig-006-20251106    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-011-20251106    clang-20
x86_64                randconfig-012-20251106    clang-20
x86_64                randconfig-013-20251106    clang-20
x86_64                randconfig-014-20251106    gcc-14
x86_64                randconfig-015-20251106    gcc-14
x86_64                randconfig-016-20251106    gcc-12
xtensa                            allnoconfig    gcc-15.1.0
xtensa                  audio_kc705_defconfig    gcc-15.1.0
xtensa                randconfig-001-20251106    gcc-9.5.0
xtensa                randconfig-002-20251106    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


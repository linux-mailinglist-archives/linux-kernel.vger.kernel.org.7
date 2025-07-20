Return-Path: <linux-kernel+bounces-738009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E5CB0B316
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 03:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89E401897AAC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 01:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A0551022;
	Sun, 20 Jul 2025 01:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nH1s7huP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F933288DA
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 01:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752974965; cv=none; b=jETs1TtbW+VqO32+923UYrUY29sNAxktu1LgPizN9wXXzYEhxSiAensiPTvnr7BOB9nfDpZtrJHvdEVUU+QAwFJoi2PJuudWsGbPsWipGBJhN69wqCOCb0OxUr8ZYyZfyLQ1B9Ai4Xl9tDKiUCB6nIGd3rps2owbYA6eFl4NaVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752974965; c=relaxed/simple;
	bh=Ccq+GcEqunnxHaGts2WxpD6wDDanpa6jzm6BmCclnDw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=eKD16j47Xk0FjAFN5uER3IDDWbM/D8hfBF9jwLFlXBs68fH6RvNdaQ4o9/6UXpclvlYaQ3AjAfIo/e+Zvk8f/flMn0SA7vqt36Tf1YBPTWulnKHBJTywRqSO+mvzp/FRyhAcne42EvCIXGEiW0A+R8jweHFayePMADSwgdyu438=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nH1s7huP; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752974963; x=1784510963;
  h=date:from:to:cc:subject:message-id;
  bh=Ccq+GcEqunnxHaGts2WxpD6wDDanpa6jzm6BmCclnDw=;
  b=nH1s7huPldpqGQJzSIhPJEaDHH7d+8PRLT4GzN9XjsESXmbOCwVngHTX
   r6iD5X2uBDwy8Ks2mSgFYO9vugLZGlurGms450PgyM3fmMQFDbBoM7TQI
   YLCOmhSzsmwXAty4moth8u6yJMy6A2hn1gTwrDshiVSQN2Ge8z7RHX6y0
   tPUNlv2ERnshnnKO0BOa9pJ2HdkD2M6fiU7MtkH1Mmltcn4I+zra9VeJX
   FXQoj7dLw59+BRrHr+2vuH9aaDK+gAyWpNJQ7ok/zjwP+8KIFc02ikBBo
   oh8vvnK2g5Tciw/3s0A9fD92WwT+jQFGqrO0djbt9k676mwmecEl6cvgX
   Q==;
X-CSE-ConnectionGUID: GSvxiin1Q8u8lMoZfdcR/g==
X-CSE-MsgGUID: 6swSBvaHTeKX3LXCTG40ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11497"; a="80671340"
X-IronPort-AV: E=Sophos;i="6.16,325,1744095600"; 
   d="scan'208";a="80671340"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2025 18:29:23 -0700
X-CSE-ConnectionGUID: mUaU9kN1SBiqsaeQSpiulA==
X-CSE-MsgGUID: h0Wawq30TFGLw8KwGwmnhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,325,1744095600"; 
   d="scan'208";a="158575289"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 19 Jul 2025 18:29:22 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1udIrf-000FsZ-1b;
	Sun, 20 Jul 2025 01:29:19 +0000
Date: Sun, 20 Jul 2025 09:29:18 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev] BUILD SUCCESS
 3de60a9e1494218f076cfe06b09294092f2398d9
Message-ID: <202507200906.BEHwoTjx-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
branch HEAD: 3de60a9e1494218f076cfe06b09294092f2398d9  EXP arm64: enable PREEMPT_LAZY

elapsed time: 1445m

configs tested: 77
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20250719    gcc-14.3.0
arc                   randconfig-002-20250719    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                   randconfig-001-20250719    gcc-14.3.0
arm                   randconfig-002-20250719    clang-21
arm                   randconfig-003-20250719    clang-21
arm                   randconfig-004-20250719    clang-16
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250719    clang-20
arm64                 randconfig-002-20250719    clang-18
arm64                 randconfig-003-20250719    gcc-15.1.0
arm64                 randconfig-004-20250719    clang-20
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250720    gcc-15.1.0
csky                  randconfig-002-20250720    gcc-13.4.0
hexagon                           allnoconfig    clang-21
hexagon               randconfig-001-20250720    clang-21
hexagon               randconfig-002-20250720    clang-21
i386        buildonly-randconfig-001-20250719    clang-20
i386        buildonly-randconfig-002-20250719    gcc-12
i386        buildonly-randconfig-003-20250719    gcc-12
i386        buildonly-randconfig-004-20250719    clang-20
i386        buildonly-randconfig-005-20250719    clang-20
i386        buildonly-randconfig-006-20250719    clang-20
loongarch                         allnoconfig    clang-21
loongarch             randconfig-001-20250720    clang-18
loongarch             randconfig-002-20250720    clang-18
m68k                              allnoconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                 randconfig-001-20250720    gcc-9.5.0
nios2                 randconfig-002-20250720    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                randconfig-001-20250720    gcc-8.5.0
parisc                randconfig-002-20250720    gcc-8.5.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20250720    gcc-10.5.0
powerpc               randconfig-002-20250720    gcc-8.5.0
powerpc               randconfig-003-20250720    gcc-11.5.0
powerpc64             randconfig-001-20250720    gcc-10.5.0
powerpc64             randconfig-002-20250720    gcc-8.5.0
powerpc64             randconfig-003-20250720    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250719    clang-21
riscv                 randconfig-002-20250719    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250719    gcc-9.5.0
s390                  randconfig-002-20250719    gcc-9.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250719    gcc-13.4.0
sh                    randconfig-002-20250719    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250719    gcc-15.1.0
sparc                 randconfig-002-20250719    gcc-15.1.0
sparc64               randconfig-001-20250719    gcc-9.5.0
sparc64               randconfig-002-20250719    gcc-9.5.0
um                                allnoconfig    clang-21
um                    randconfig-001-20250719    clang-16
um                    randconfig-002-20250719    clang-21
x86_64      buildonly-randconfig-001-20250719    clang-20
x86_64      buildonly-randconfig-002-20250719    clang-20
x86_64      buildonly-randconfig-003-20250719    clang-20
x86_64      buildonly-randconfig-004-20250719    gcc-12
x86_64      buildonly-randconfig-005-20250719    clang-20
x86_64      buildonly-randconfig-006-20250719    gcc-12
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250719    gcc-14.3.0
xtensa                randconfig-002-20250719    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


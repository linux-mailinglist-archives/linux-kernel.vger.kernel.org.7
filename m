Return-Path: <linux-kernel+bounces-877459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4EAC1E28B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 03:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 213334E2255
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 02:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBFF32AADB;
	Thu, 30 Oct 2025 02:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ARHAs7jR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CA3264F96
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761792548; cv=none; b=G2dPy8qO7P1Em+yGNXe3qWANSXalW3toI+e1LqdZttQqp4TnJt0emMVoNg6oYa7W80YcaBUplOOWUUwZ5By4y55eZF3eCtV92uE7xMgaCmKZ4/FmOuYVi9oQlBx35NlovEB2n7kdmmC2oFCEjqg2ry4dUy1KtMCdHwPKAYhNXII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761792548; c=relaxed/simple;
	bh=OESeLapDHFHLWeeCn3u5du4nwmNj0LtI4GPRrXkwZ6U=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DmqA/Hygjn6huNox4PKCiM5bhhfE3auz2GeRb9L0ast7Aoe3UnPPPVM0/LgOcJO2vGN/8xLVA14nvYhe11Hg1wFRUJSwfL/8VtVO5x6RahrdKa3XiQxunzTqAwq57RSV+bMgpCommsJ2buI1Quik/Gk+uOq/5TQvNwG+HQavUTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ARHAs7jR; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761792547; x=1793328547;
  h=date:from:to:cc:subject:message-id;
  bh=OESeLapDHFHLWeeCn3u5du4nwmNj0LtI4GPRrXkwZ6U=;
  b=ARHAs7jR8r8hI6dKkXc2Fa1vwn4SX+lZVpu9p9GC6bi6vbJsCyZMBjEA
   QtoKXf9JKTxmdZI9dW4O6Sx4wslqXbOIlPYGre7BHtWpjcf0PrFvaRvnc
   0ZeT6k/OQSw9Uk4Fqc8FAAO38WBE1wfnQuJldgc2ckpmBSFPZ3+yWWU2e
   bDWmwz81HiZeeKVPgGmbNu62sJrXl5GrJ0HLaBXc7Ngj1dWu10k0ZTONz
   MhHnofC1v6JBvQHTd53++7W7Ek+mduBAhZUKHY1e0DaK82ZGX4es3ZGtS
   NHj/W6nyYExi/e15JSjOKYlk3/wUTdz2ZTrp5WBw/9+lCrTPmtYcCnO7i
   w==;
X-CSE-ConnectionGUID: myLq2ftDQXOnYePqyRgj/Q==
X-CSE-MsgGUID: UQ74Ni9pQke2FaTqsLh0KQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="74218600"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="74218600"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 19:49:06 -0700
X-CSE-ConnectionGUID: 0jZyIBy6TVyCi3RKCsPMgQ==
X-CSE-MsgGUID: Runq7G77QpOzO60+3kkN2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="185713083"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 29 Oct 2025 19:49:05 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vEIih-000LO0-1h;
	Thu, 30 Oct 2025 02:49:00 +0000
Date: Thu, 30 Oct 2025 10:48:51 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2025.10.04b] BUILD SUCCESS
 67ac598b08778041e1ef69f686b4c68ce61a1fed
Message-ID: <202510301046.FvaEg5QE-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2025.10.04b
branch HEAD: 67ac598b08778041e1ef69f686b4c68ce61a1fed  fixup! rcutorture: Make srcu{,d}_torture_init() announce the SRCU type

elapsed time: 1520m

configs tested: 105
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                           sama5_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251029    gcc-12.5.0
arm64                 randconfig-002-20251029    clang-22
arm64                 randconfig-003-20251029    gcc-13.4.0
arm64                 randconfig-004-20251029    gcc-11.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251029    gcc-9.5.0
csky                  randconfig-002-20251029    gcc-11.5.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20251029    clang-20
hexagon               randconfig-002-20251029    clang-22
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251029    gcc-14
i386        buildonly-randconfig-002-20251029    gcc-14
i386        buildonly-randconfig-003-20251029    clang-20
i386        buildonly-randconfig-004-20251029    gcc-14
i386        buildonly-randconfig-005-20251029    gcc-14
i386        buildonly-randconfig-006-20251029    gcc-14
i386                  randconfig-001-20251030    gcc-14
i386                  randconfig-002-20251030    gcc-14
i386                  randconfig-003-20251030    clang-20
i386                  randconfig-004-20251030    clang-20
i386                  randconfig-005-20251030    clang-20
i386                  randconfig-011-20251030    gcc-14
i386                  randconfig-012-20251030    gcc-14
i386                  randconfig-013-20251030    gcc-14
i386                  randconfig-014-20251030    clang-20
i386                  randconfig-015-20251030    gcc-14
i386                  randconfig-016-20251030    gcc-14
i386                  randconfig-017-20251030    gcc-14
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20251029    clang-22
loongarch             randconfig-002-20251029    clang-22
m68k                              allnoconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                 randconfig-001-20251029    gcc-11.5.0
nios2                 randconfig-002-20251029    gcc-9.5.0
openrisc                          allnoconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                randconfig-001-20251029    gcc-12.5.0
parisc                randconfig-002-20251029    gcc-8.5.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                     ksi8560_defconfig    gcc-15.1.0
powerpc                      mgcoge_defconfig    clang-22
powerpc                      ppc44x_defconfig    clang-22
powerpc               randconfig-001-20251029    clang-22
powerpc               randconfig-002-20251029    gcc-12.5.0
powerpc                     redwood_defconfig    clang-22
powerpc                  storcenter_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251029    clang-22
powerpc64             randconfig-002-20251029    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20251029    clang-20
riscv                 randconfig-002-20251029    clang-19
s390                              allnoconfig    clang-22
s390                  randconfig-001-20251029    gcc-11.5.0
s390                  randconfig-002-20251029    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251029    gcc-11.5.0
sh                    randconfig-002-20251029    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20251029    gcc-8.5.0
sparc                 randconfig-002-20251029    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251029    clang-20
sparc64               randconfig-002-20251029    clang-22
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251029    clang-22
um                    randconfig-002-20251029    clang-22
um                           x86_64_defconfig    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251030    clang-20
x86_64      buildonly-randconfig-002-20251030    gcc-14
x86_64      buildonly-randconfig-003-20251030    gcc-13
x86_64      buildonly-randconfig-004-20251030    gcc-14
x86_64      buildonly-randconfig-005-20251030    clang-20
x86_64      buildonly-randconfig-006-20251030    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-011-20251030    clang-20
x86_64                randconfig-013-20251030    gcc-13
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251029    gcc-8.5.0
xtensa                randconfig-002-20251029    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


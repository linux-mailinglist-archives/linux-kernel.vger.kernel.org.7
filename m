Return-Path: <linux-kernel+bounces-783124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CAFB329A2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 17:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 597311C21E31
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 15:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0283E2E7BBB;
	Sat, 23 Aug 2025 15:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IZYIUwsy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2310AD4B
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 15:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755963341; cv=none; b=mT6hRYMOXPDZKhatggmRKsAkKuC+A+INgLJ6xCueljEtLY4aGPFDKFdHM1n3htm0e1OE/aQ9xi2FnyTETTncQHwuBBZ+EgFQ5A5VRLWP8vTJaYbMHsiDfJ6H4DFZU509WhUagbETnWwMFPgUMfEviX4vkaMsMdis2LEur1M10lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755963341; c=relaxed/simple;
	bh=0ySifwPJWtCUXDb9MvsFRgoJwiVzCxKZHzeWfER8sAo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=q5L3H3fFrTOr+n5PmqVM9m1BSaaFIvMygtVPYsdOJjzECNYeiSabbuki0PWnrhDQtcQcVeTPgDMMjmAX/VYDMqUGUysVcIxxiUuGkkmbjYV79GyBA+QYb1QHwwfAcmLaBaU4U+IRuWnUmPYGrZpcE7GWpPYXLzkmiX5l3NwOjFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IZYIUwsy; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755963339; x=1787499339;
  h=date:from:to:cc:subject:message-id;
  bh=0ySifwPJWtCUXDb9MvsFRgoJwiVzCxKZHzeWfER8sAo=;
  b=IZYIUwsy8bWwVzvR1klphwgIQc21lXUttoauE9FH42d0ewtkwvauITa+
   M6q1PbOaKLtGUsG95sOwAyer4jfWctSfwBDLo00FdX4LHGsbAFxERo4h3
   1PU+YZjnlEy+4lMjcZfoF7h2+Yc+PkdoOvtwssGDVuFrU7VMQ7lKjxM4j
   o14OLowm93GVMYfe+anPQ9IfCc+k7DpcXLyWG1/celvhinQDDldmNz2zp
   /RIreYdA/X2l2lrxaUZOAIYoS/CGrydUO1njzpCwCUpGWyyr4mpBXdteb
   3ffMXarpydi57hebwd81EbAs/PMXNwhJ4vzJ4WZdAkBHMa+DaQKZJXI2W
   Q==;
X-CSE-ConnectionGUID: LvY/dZVwR3+ym2+w8SZzIg==
X-CSE-MsgGUID: G/sXf+EOSE6+7+9jJAGaSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="57261898"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="57261898"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2025 08:35:38 -0700
X-CSE-ConnectionGUID: pDaWAtZ0QEqyIkt3Y5uYgQ==
X-CSE-MsgGUID: P4ZClv+cSLiD+2Vd7y8SZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="168161035"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 23 Aug 2025 08:13:29 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uppvn-000MMn-0C;
	Sat, 23 Aug 2025 15:13:24 +0000
Date: Sat, 23 Aug 2025 23:12:11 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD SUCCESS
 86e6815b316ec0ea8c4bb3c16a033219a52b6060
Message-ID: <202508232305.uhJbdeHb-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
branch HEAD: 86e6815b316ec0ea8c4bb3c16a033219a52b6060  x86/mm: Change cpa_flush() to call flush_kernel_range() directly

elapsed time: 1272m

configs tested: 127
configs skipped: 120

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                            allyesconfig    clang-19
arc                               allnoconfig    clang-22
arc                   randconfig-001-20250823    clang-22
arc                   randconfig-002-20250823    clang-22
arm                               allnoconfig    clang-22
arm                       aspeed_g4_defconfig    gcc-15.1.0
arm                   randconfig-001-20250823    clang-22
arm                   randconfig-002-20250823    clang-22
arm                   randconfig-003-20250823    clang-22
arm                   randconfig-004-20250823    clang-22
arm                    vt8500_v6_v7_defconfig    gcc-15.1.0
arm64                             allnoconfig    clang-22
arm64                 randconfig-001-20250823    clang-22
arm64                 randconfig-002-20250823    clang-22
arm64                 randconfig-003-20250823    clang-22
arm64                 randconfig-004-20250823    clang-22
csky                              allnoconfig    clang-22
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250823    clang-20
i386        buildonly-randconfig-002-20250823    clang-20
i386        buildonly-randconfig-003-20250823    clang-20
i386        buildonly-randconfig-004-20250823    clang-20
i386        buildonly-randconfig-005-20250823    clang-20
i386        buildonly-randconfig-006-20250823    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250823    clang-20
i386                  randconfig-002-20250823    clang-20
i386                  randconfig-003-20250823    clang-20
i386                  randconfig-004-20250823    clang-20
i386                  randconfig-005-20250823    clang-20
i386                  randconfig-006-20250823    clang-20
i386                  randconfig-007-20250823    clang-20
i386                  randconfig-011-20250823    gcc-12
i386                  randconfig-012-20250823    gcc-12
i386                  randconfig-013-20250823    gcc-12
i386                  randconfig-014-20250823    gcc-12
i386                  randconfig-015-20250823    gcc-12
i386                  randconfig-016-20250823    gcc-12
i386                  randconfig-017-20250823    gcc-12
loongarch                         allnoconfig    clang-22
m68k                              allnoconfig    gcc-15.1.0
m68k                       m5475evb_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           ci20_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-15.1.0
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-12
parisc                            allnoconfig    clang-22
powerpc                           allnoconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250823    clang-22
riscv                 randconfig-002-20250823    clang-22
s390                              allnoconfig    clang-22
s390                                defconfig    gcc-12
s390                  randconfig-001-20250823    clang-22
s390                  randconfig-002-20250823    clang-22
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                          kfr2r09_defconfig    gcc-15.1.0
sh                    randconfig-001-20250823    clang-22
sh                    randconfig-002-20250823    clang-22
sh                           se7705_defconfig    gcc-15.1.0
sh                        sh7763rdp_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250823    clang-22
sparc                 randconfig-002-20250823    clang-22
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250823    clang-22
sparc64               randconfig-002-20250823    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250823    clang-22
um                    randconfig-002-20250823    clang-22
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250823    gcc-12
x86_64      buildonly-randconfig-002-20250823    gcc-12
x86_64      buildonly-randconfig-003-20250823    clang-20
x86_64      buildonly-randconfig-003-20250823    gcc-12
x86_64      buildonly-randconfig-004-20250823    clang-20
x86_64      buildonly-randconfig-004-20250823    gcc-12
x86_64      buildonly-randconfig-005-20250823    gcc-12
x86_64      buildonly-randconfig-006-20250823    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250823    gcc-12
x86_64                randconfig-002-20250823    gcc-12
x86_64                randconfig-003-20250823    gcc-12
x86_64                randconfig-004-20250823    gcc-12
x86_64                randconfig-005-20250823    gcc-12
x86_64                randconfig-006-20250823    gcc-12
x86_64                randconfig-007-20250823    gcc-12
x86_64                randconfig-008-20250823    gcc-12
x86_64                randconfig-071-20250823    gcc-11
x86_64                randconfig-072-20250823    gcc-11
x86_64                randconfig-073-20250823    gcc-11
x86_64                randconfig-074-20250823    gcc-11
x86_64                randconfig-075-20250823    gcc-11
x86_64                randconfig-076-20250823    gcc-11
x86_64                randconfig-077-20250823    gcc-11
x86_64                randconfig-078-20250823    gcc-11
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250823    clang-22
xtensa                randconfig-002-20250823    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


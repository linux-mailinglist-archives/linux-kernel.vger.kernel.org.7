Return-Path: <linux-kernel+bounces-884262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6896C2FC28
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 09:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 842093B045B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC9627587C;
	Tue,  4 Nov 2025 08:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lAgmYrVy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83A42C181
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 08:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762243473; cv=none; b=o/mq4o8XGwQmXQ+dlFV9CXqCktCIGpfiiHPwFdnm5jhhUp9rv6PDFzy2im3id3Hii1N/BBCIIneXkl0l2VDLMdY7KCo8kqoNFtKH1UhphOFE67XdSlGUqf0CROnfi/f8fYuKr0HbpxSzt+DmwUQ8PN6tjtwwr1iieMmKFBsM7AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762243473; c=relaxed/simple;
	bh=FbH7+Ot7wVUuEs+2bF25ZaB2Y59nG5N6/f7pDGiGFbU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=cO/IfDNFlAcOSbq1jN54HVlvgRFRtOI1AW8C1DyeKuLO+Fjd0wX/o8gbxbx8jmf4alFBWa2aZoewZ8TNhk20PWGg9ehjPxjvaDj+dUJdJTGWaeYd9D4begfrnz3zwRySetPDJy7Tsn2AHvDfPJYyD9gEIOs85aKy7hLGStY1MKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lAgmYrVy; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762243470; x=1793779470;
  h=date:from:to:cc:subject:message-id;
  bh=FbH7+Ot7wVUuEs+2bF25ZaB2Y59nG5N6/f7pDGiGFbU=;
  b=lAgmYrVy6B79MzirkvFQaPA+wVrQ2H2R5XbpjlSGXOfajQrrvZhFlCzK
   H9Dh7t3uu0EjYvBxT5JVyGkRvSgwgQys8hfLFLpkcwm4uIssKVbVh5cMw
   nDj2xiW3xwuOFeswsYU6A0gJXV1MEKGgH0RVhw3mqq4xvGgfJ+dCfZTKv
   ++clMWG5oki7Ubo85bcUnL/eojFMCrBOoiaV4rUGh0D/yBqwPeomr0gGB
   xYNzr/ZCScUBAtyXltSM6UIcrPr+nLFTp/JvySF5/mQnjo+c8HB8ZKol2
   n1Hk+l8ter3aFsHvNrQla/AW+Lo1vkAcQQatxRxHbBiHADvhb2bF3XcCM
   A==;
X-CSE-ConnectionGUID: DjjbgWP/QRqO3WGTWElsZg==
X-CSE-MsgGUID: TE1ujJ0WS9isaAhBAnGT6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="63535081"
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="63535081"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 00:04:30 -0800
X-CSE-ConnectionGUID: jrKLRGL5TdupU8MMXMMT5w==
X-CSE-MsgGUID: zhFVxKNxTfCn4GGvrj8DsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="186781564"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 04 Nov 2025 00:04:30 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGC1e-000R5A-0p;
	Tue, 04 Nov 2025 08:04:23 +0000
Date: Tue, 04 Nov 2025 16:03:30 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:next.2025.11.02a] BUILD SUCCESS
 d25feeb0e06f3c16b622ab2f88e5cce223814114
Message-ID: <202511041624.UFISkadp-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git next.2025.11.02a
branch HEAD: d25feeb0e06f3c16b622ab2f88e5cce223814114  refscale: Add SRCU-fast-updown readers

elapsed time: 1461m

configs tested: 162
configs skipped: 8

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
arc                        nsimosci_defconfig    gcc-15.1.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                           imxrt_defconfig    clang-22
arm                         s3c6400_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                            allyesconfig    clang-22
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251103    clang-22
arm64                 randconfig-002-20251103    gcc-13.4.0
arm64                 randconfig-003-20251103    gcc-14.3.0
arm64                 randconfig-004-20251103    gcc-8.5.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251103    gcc-15.1.0
csky                  randconfig-002-20251103    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251103    clang-22
hexagon               randconfig-002-20251103    clang-22
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251103    gcc-14
i386        buildonly-randconfig-002-20251103    clang-20
i386        buildonly-randconfig-003-20251103    clang-20
i386        buildonly-randconfig-004-20251103    gcc-14
i386        buildonly-randconfig-005-20251103    gcc-14
i386        buildonly-randconfig-006-20251103    gcc-13
i386                                defconfig    clang-20
i386                  randconfig-001-20251104    gcc-12
i386                  randconfig-002-20251104    gcc-14
i386                  randconfig-003-20251104    clang-20
i386                  randconfig-004-20251104    gcc-14
i386                  randconfig-005-20251104    gcc-14
i386                  randconfig-006-20251104    gcc-14
i386                  randconfig-007-20251104    gcc-14
i386                  randconfig-011-20251104    gcc-13
i386                  randconfig-012-20251104    clang-20
i386                  randconfig-013-20251104    gcc-14
i386                  randconfig-014-20251104    clang-20
i386                  randconfig-015-20251104    gcc-14
i386                  randconfig-016-20251104    clang-20
i386                  randconfig-017-20251104    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                        allyesconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251103    gcc-12.5.0
loongarch             randconfig-002-20251103    gcc-14.3.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251103    gcc-11.5.0
nios2                 randconfig-002-20251103    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251103    gcc-14.3.0
parisc                randconfig-002-20251103    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20251103    gcc-8.5.0
powerpc               randconfig-002-20251103    clang-20
powerpc64             randconfig-001-20251103    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251104    gcc-8.5.0
riscv                 randconfig-002-20251104    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251104    clang-22
s390                  randconfig-002-20251104    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251104    gcc-13.4.0
sh                    randconfig-002-20251104    gcc-11.5.0
sh                          rsk7203_defconfig    gcc-15.1.0
sh                           se7722_defconfig    gcc-15.1.0
sh                             shx3_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251104    gcc-13.4.0
sparc                 randconfig-002-20251104    gcc-12.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251104    gcc-8.5.0
sparc64               randconfig-002-20251104    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251104    clang-22
um                    randconfig-002-20251104    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251104    clang-20
x86_64      buildonly-randconfig-002-20251104    gcc-12
x86_64      buildonly-randconfig-003-20251104    gcc-14
x86_64      buildonly-randconfig-004-20251104    gcc-14
x86_64      buildonly-randconfig-005-20251104    gcc-12
x86_64      buildonly-randconfig-006-20251104    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251104    gcc-14
x86_64                randconfig-002-20251104    clang-20
x86_64                randconfig-003-20251104    gcc-13
x86_64                randconfig-004-20251104    clang-20
x86_64                randconfig-005-20251104    clang-20
x86_64                randconfig-006-20251104    gcc-14
x86_64                randconfig-011-20251104    gcc-14
x86_64                randconfig-012-20251104    gcc-14
x86_64                randconfig-013-20251104    clang-20
x86_64                randconfig-014-20251104    clang-20
x86_64                randconfig-015-20251104    gcc-14
x86_64                randconfig-016-20251104    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
xtensa                            allnoconfig    gcc-15.1.0
xtensa                  nommu_kc705_defconfig    gcc-15.1.0
xtensa                randconfig-001-20251104    gcc-13.4.0
xtensa                randconfig-002-20251104    gcc-11.5.0
xtensa                    smp_lx200_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


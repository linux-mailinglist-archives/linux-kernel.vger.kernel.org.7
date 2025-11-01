Return-Path: <linux-kernel+bounces-881231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01037C27C85
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 12:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F5FC3B0F19
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 11:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A7A2E5406;
	Sat,  1 Nov 2025 11:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e1XU4ulT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AD21D6DB5
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 11:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761995629; cv=none; b=ILuwGpJ0ANh4kkvTLQU5B+uDeCwizSOwhQynFMOQIKpGIpHhkYc52545PxbktbUB1yoEF6N1FIhiZjtf284CaYyNztWNj9fCICfyFKdsdbq6Ujm/31omS0rBpSgata6i4uPEMPVObXyeoO2yYpY621iuEd2EUQ7eLwhsYurqxmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761995629; c=relaxed/simple;
	bh=rpNf0mE6cAdDaK1mclD77ot3Jj5Si3A9Gpp08KRJZ5U=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hKxMZ3UbMMHbxhukvKexUUDcNt69fPM+6lyRoCQpgnTyFCsC8lextwssVFPK7WC0rJa4jaE6I9vZ8ny+rxmH2A6t9TbPJroPGImn3jf4xel30j+Qqd7UmaQV6TStK7jfcTXi8lELNIPUy4UtZVGoc72LlZCa4cXn9lGhdRBzg84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e1XU4ulT; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761995627; x=1793531627;
  h=date:from:to:cc:subject:message-id;
  bh=rpNf0mE6cAdDaK1mclD77ot3Jj5Si3A9Gpp08KRJZ5U=;
  b=e1XU4ulT2N+4kM9dQO8Q/Ipe1P7Ybpe+/yALZxPkT0aETQf5lz3ilQN7
   SogCNZZmOTYSKcsLmXqa0XjDSe5lC4UMae3gRXU4gawp26fFxto1bOrlk
   Ni7MFXhA9zhTCudk5TiyX+tCH0Kwes/fcarR8Om+oBiND02MqJjuHNoSO
   D7l1OG60Vy9o3woyJ9Ga5ZjWSg4tHMRIhJyn3exT6BVi8YVHXpJ2Z0INa
   cHTUEpCuV45V74Hs/hkqZgMdgo2uwwLKBdwoFY9J4SaIzbyi4vudDJnD9
   imbVPewU78AM270wO6eq+Bp6x9h2oS+sOnWvBAmXj4plmGw7qPZEi0E++
   Q==;
X-CSE-ConnectionGUID: PuEYWNHbRcmHgovNSFjjDA==
X-CSE-MsgGUID: 75klEr1ZSKykWkHIBZJ3MQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64069465"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64069465"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2025 04:13:45 -0700
X-CSE-ConnectionGUID: 49XnAu5RSOiZ+Wbry2kbTw==
X-CSE-MsgGUID: fvwAtx/9SAGOJfxirTyAuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,271,1754982000"; 
   d="scan'208";a="185665911"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 01 Nov 2025 04:13:45 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vF9YA-000OB8-0E;
	Sat, 01 Nov 2025 11:13:40 +0000
Date: Sat, 01 Nov 2025 19:12:42 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:objtool/core] BUILD SUCCESS
 6568f14cb5ae68cd6c612604ca0c89301cf3a0d0
Message-ID: <202511011937.dMysHLFL-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool/core
branch HEAD: 6568f14cb5ae68cd6c612604ca0c89301cf3a0d0  vmlinux.lds: Exclude .text.startup and .text.exit from TEXT_MAIN

elapsed time: 1459m

configs tested: 151
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20251031    gcc-8.5.0
arc                   randconfig-001-20251101    gcc-8.5.0
arc                   randconfig-002-20251031    gcc-8.5.0
arc                   randconfig-002-20251101    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                   randconfig-001-20251031    gcc-14.3.0
arm                   randconfig-001-20251101    gcc-8.5.0
arm                   randconfig-002-20251031    clang-22
arm                   randconfig-002-20251101    gcc-8.5.0
arm                   randconfig-003-20251031    gcc-11.5.0
arm                   randconfig-003-20251101    gcc-8.5.0
arm                   randconfig-004-20251031    clang-22
arm                   randconfig-004-20251101    gcc-8.5.0
arm                          sp7021_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
arm64                            allyesconfig    gcc-15.1.0
arm64                 randconfig-001-20251101    gcc-14.3.0
arm64                 randconfig-001-20251101    gcc-8.5.0
arm64                 randconfig-002-20251101    clang-22
arm64                 randconfig-002-20251101    gcc-14.3.0
arm64                 randconfig-003-20251101    clang-17
arm64                 randconfig-003-20251101    gcc-14.3.0
arm64                 randconfig-004-20251101    gcc-14.3.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                  randconfig-001-20251101    gcc-14.3.0
csky                  randconfig-001-20251101    gcc-15.1.0
csky                  randconfig-002-20251101    gcc-14.3.0
csky                  randconfig-002-20251101    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20251031    clang-22
hexagon               randconfig-001-20251101    clang-19
hexagon               randconfig-002-20251031    clang-22
hexagon               randconfig-002-20251101    clang-19
i386                             alldefconfig    gcc-14
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251101    clang-20
i386        buildonly-randconfig-002-20251101    gcc-13
i386        buildonly-randconfig-003-20251101    clang-20
i386        buildonly-randconfig-004-20251101    gcc-14
i386        buildonly-randconfig-005-20251101    clang-20
i386        buildonly-randconfig-006-20251101    clang-20
loongarch                         allnoconfig    clang-22
loongarch                        allyesconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251031    gcc-15.1.0
loongarch             randconfig-001-20251101    clang-19
loongarch             randconfig-002-20251031    gcc-14.3.0
loongarch             randconfig-002-20251101    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                       m5249evb_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                        bcm63xx_defconfig    clang-22
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                            allyesconfig    clang-22
nios2                            allyesconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20251031    gcc-9.5.0
nios2                 randconfig-001-20251101    clang-19
nios2                 randconfig-002-20251031    gcc-11.5.0
nios2                 randconfig-002-20251101    clang-19
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251101    clang-20
parisc                randconfig-001-20251101    gcc-11.5.0
parisc                randconfig-002-20251101    clang-20
parisc                randconfig-002-20251101    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                 linkstation_defconfig    clang-20
powerpc               randconfig-001-20251101    clang-20
powerpc               randconfig-001-20251101    gcc-11.5.0
powerpc               randconfig-002-20251101    clang-20
powerpc               randconfig-002-20251101    clang-22
powerpc64             randconfig-001-20251101    clang-20
powerpc64             randconfig-001-20251101    gcc-11.5.0
powerpc64             randconfig-002-20251101    clang-20
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-15.1.0
riscv                 randconfig-001-20251031    gcc-8.5.0
riscv                 randconfig-001-20251101    clang-17
riscv                 randconfig-002-20251031    clang-17
riscv                 randconfig-002-20251101    clang-17
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20251031    clang-16
s390                  randconfig-001-20251101    clang-17
s390                  randconfig-002-20251031    gcc-12.5.0
s390                  randconfig-002-20251101    clang-17
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251031    gcc-14.3.0
sh                    randconfig-001-20251101    clang-17
sh                    randconfig-002-20251031    gcc-14.3.0
sh                    randconfig-002-20251101    clang-17
sh                   secureedge5410_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                            allyesconfig    clang-22
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251101    gcc-15.1.0
sparc                 randconfig-002-20251101    gcc-14.3.0
sparc64                          allmodconfig    clang-22
sparc64                          allyesconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251101    gcc-15.1.0
sparc64               randconfig-002-20251101    clang-22
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251101    clang-16
um                    randconfig-002-20251101    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251101    clang-20
x86_64      buildonly-randconfig-002-20251101    gcc-14
x86_64      buildonly-randconfig-003-20251101    gcc-13
x86_64      buildonly-randconfig-005-20251101    gcc-13
x86_64                              defconfig    gcc-14
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    clang-22
xtensa                  cadence_csp_defconfig    gcc-15.1.0
xtensa                randconfig-001-20251101    gcc-13.4.0
xtensa                randconfig-002-20251101    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


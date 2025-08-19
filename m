Return-Path: <linux-kernel+bounces-776145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B6FB2C91E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E58972325C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED77A285419;
	Tue, 19 Aug 2025 16:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IG4OmV+m"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11E2284883
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 16:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755619773; cv=none; b=fMBz/qolyRupIS4TFtzxFlrDYwMZML5UWKOVHs6/Y/6+pEcmpKiWOlF/MHu/9f6K8EdpjYsfNxICtSMudwbivlLpfx5foacPIkC2SWkdvTOChWb1EDtlRbttSNMeAKKhRQyUXHT03pOEjY+R5J1tIPoBTTLkdwL5mp2AN8GIQO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755619773; c=relaxed/simple;
	bh=XRG7x6Ugi3XFtQw+HOPyHznUmd7QblI+d/MuhF4lbvw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=b+YvKFJZoVR6i94Pqph4wlCE4m8ZR1jepJW+qgcIvuNqiY8254tpRlZEFgfjjT7hb1wF0cJhBHQSlr7CrprncOUUbJZ2Yj6cJ3AYdIxKxheo0+LiY/tz0gMMSj/Bsdv+Btb1enAdAbO8wL9pUVUFoHuBXNzW+5pBVnTKosr6J64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IG4OmV+m; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755619772; x=1787155772;
  h=date:from:to:cc:subject:message-id;
  bh=XRG7x6Ugi3XFtQw+HOPyHznUmd7QblI+d/MuhF4lbvw=;
  b=IG4OmV+mEJ5ZSfIhwU2iAZhBwgSEWhTtmM0u3Vt3oe2BxVNBWRH0MGrz
   AhTgnrI/mXMYcK/FOPj/QYZyZ+ptWJxhaZnFumouJH8C4w7H9qp8lBEC7
   8ndJlMN+QdttwZnBXro/3Y3IWgx9a6nqOipxiw4nZqWp0IQ1A+kmZWxIa
   XRX2+AzBh35prOlU3Co+DYngvw/pPAv8yC4jKMZ0ZW0yeTEUbsW5YHtUn
   C2XZSnNmavU5bKNE43mmooxCBNitfrOinYByTo41a+dvvh1wqv3rGhZin
   whr4kCqHt1UjuT7mvzVzQ7EHTy5qru8OptN9KQdyNDOPTFZoangdpTOxU
   Q==;
X-CSE-ConnectionGUID: sItuYmqnSa6qLjVFUikVhg==
X-CSE-MsgGUID: NPC+vhMCQRm4ZOphkr/sZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57075018"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="57075018"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 09:09:31 -0700
X-CSE-ConnectionGUID: +wzVOW0YSICjsgPOYjQKXg==
X-CSE-MsgGUID: YQGMAyeVSnqSXG+ml2QHhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="198743415"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 19 Aug 2025 09:09:30 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uoOto-000H6E-1a;
	Tue, 19 Aug 2025 16:09:26 +0000
Date: Wed, 20 Aug 2025 00:08:08 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/misc] BUILD SUCCESS
 26178b713f2b3f5bc411ed8316d1635615896111
Message-ID: <202508200002.PTIdJIxp-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/misc
branch HEAD: 26178b713f2b3f5bc411ed8316d1635615896111  x86/insn: Add XOP prefix instructions decoder support

elapsed time: 1446m

configs tested: 238
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                     nsimosci_hs_defconfig    gcc-15.1.0
arc                   randconfig-001-20250819    gcc-14.3.0
arc                   randconfig-001-20250819    gcc-8.5.0
arc                   randconfig-002-20250819    gcc-11.5.0
arc                   randconfig-002-20250819    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                         at91_dt_defconfig    gcc-15.1.0
arm                         bcm2835_defconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                   randconfig-001-20250819    gcc-12.5.0
arm                   randconfig-001-20250819    gcc-8.5.0
arm                   randconfig-002-20250819    gcc-10.5.0
arm                   randconfig-002-20250819    gcc-8.5.0
arm                   randconfig-003-20250819    gcc-10.5.0
arm                   randconfig-003-20250819    gcc-8.5.0
arm                   randconfig-004-20250819    clang-22
arm                   randconfig-004-20250819    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250819    gcc-14.3.0
arm64                 randconfig-001-20250819    gcc-8.5.0
arm64                 randconfig-002-20250819    clang-22
arm64                 randconfig-002-20250819    gcc-8.5.0
arm64                 randconfig-003-20250819    gcc-8.5.0
arm64                 randconfig-004-20250819    clang-16
arm64                 randconfig-004-20250819    gcc-8.5.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250819    clang-22
csky                  randconfig-001-20250819    gcc-15.1.0
csky                  randconfig-002-20250819    clang-22
csky                  randconfig-002-20250819    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250819    clang-22
hexagon               randconfig-002-20250819    clang-18
hexagon               randconfig-002-20250819    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250819    gcc-12
i386        buildonly-randconfig-002-20250819    clang-20
i386        buildonly-randconfig-002-20250819    gcc-12
i386        buildonly-randconfig-003-20250819    clang-20
i386        buildonly-randconfig-003-20250819    gcc-12
i386        buildonly-randconfig-004-20250819    clang-20
i386        buildonly-randconfig-004-20250819    gcc-12
i386        buildonly-randconfig-005-20250819    clang-20
i386        buildonly-randconfig-005-20250819    gcc-12
i386        buildonly-randconfig-006-20250819    clang-20
i386        buildonly-randconfig-006-20250819    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250819    clang-20
i386                  randconfig-002-20250819    clang-20
i386                  randconfig-003-20250819    clang-20
i386                  randconfig-004-20250819    clang-20
i386                  randconfig-005-20250819    clang-20
i386                  randconfig-006-20250819    clang-20
i386                  randconfig-007-20250819    clang-20
i386                  randconfig-011-20250819    gcc-12
i386                  randconfig-012-20250819    gcc-12
i386                  randconfig-013-20250819    gcc-12
i386                  randconfig-014-20250819    gcc-12
i386                  randconfig-015-20250819    gcc-12
i386                  randconfig-016-20250819    gcc-12
i386                  randconfig-017-20250819    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250819    clang-22
loongarch             randconfig-001-20250819    gcc-15.1.0
loongarch             randconfig-002-20250819    clang-18
loongarch             randconfig-002-20250819    clang-22
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           xway_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250819    clang-22
nios2                 randconfig-001-20250819    gcc-8.5.0
nios2                 randconfig-002-20250819    clang-22
nios2                 randconfig-002-20250819    gcc-8.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250819    clang-22
parisc                randconfig-001-20250819    gcc-10.5.0
parisc                randconfig-002-20250819    clang-22
parisc                randconfig-002-20250819    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                          g5_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250819    clang-22
powerpc               randconfig-002-20250819    clang-22
powerpc               randconfig-002-20250819    gcc-10.5.0
powerpc               randconfig-003-20250819    clang-22
powerpc64             randconfig-001-20250819    clang-22
powerpc64             randconfig-002-20250819    clang-22
powerpc64             randconfig-003-20250819    clang-22
powerpc64             randconfig-003-20250819    gcc-10.5.0
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250819    clang-22
riscv                 randconfig-001-20250819    gcc-8.5.0
riscv                 randconfig-002-20250819    clang-22
riscv                 randconfig-002-20250819    gcc-8.5.0
s390                             alldefconfig    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250819    gcc-8.5.0
s390                  randconfig-002-20250819    gcc-12.5.0
s390                  randconfig-002-20250819    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                          kfr2r09_defconfig    gcc-15.1.0
sh                    randconfig-001-20250819    gcc-15.1.0
sh                    randconfig-001-20250819    gcc-8.5.0
sh                    randconfig-002-20250819    gcc-15.1.0
sh                    randconfig-002-20250819    gcc-8.5.0
sh                          urquell_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250819    gcc-8.5.0
sparc                 randconfig-002-20250819    gcc-11.5.0
sparc                 randconfig-002-20250819    gcc-8.5.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250819    clang-22
sparc64               randconfig-001-20250819    gcc-8.5.0
sparc64               randconfig-002-20250819    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250819    clang-18
um                    randconfig-001-20250819    gcc-8.5.0
um                    randconfig-002-20250819    gcc-12
um                    randconfig-002-20250819    gcc-8.5.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250819    clang-20
x86_64      buildonly-randconfig-002-20250819    clang-20
x86_64      buildonly-randconfig-003-20250819    clang-20
x86_64      buildonly-randconfig-004-20250819    clang-20
x86_64      buildonly-randconfig-005-20250819    clang-20
x86_64      buildonly-randconfig-006-20250819    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250819    gcc-12
x86_64                randconfig-002-20250819    gcc-12
x86_64                randconfig-003-20250819    gcc-12
x86_64                randconfig-004-20250819    gcc-12
x86_64                randconfig-005-20250819    gcc-12
x86_64                randconfig-006-20250819    gcc-12
x86_64                randconfig-007-20250819    gcc-12
x86_64                randconfig-008-20250819    gcc-12
x86_64                randconfig-071-20250819    clang-20
x86_64                randconfig-072-20250819    clang-20
x86_64                randconfig-073-20250819    clang-20
x86_64                randconfig-074-20250819    clang-20
x86_64                randconfig-075-20250819    clang-20
x86_64                randconfig-076-20250819    clang-20
x86_64                randconfig-077-20250819    clang-20
x86_64                randconfig-078-20250819    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250819    gcc-8.5.0
xtensa                randconfig-002-20250819    gcc-15.1.0
xtensa                randconfig-002-20250819    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


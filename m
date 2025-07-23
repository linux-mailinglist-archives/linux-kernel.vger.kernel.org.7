Return-Path: <linux-kernel+bounces-743057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B50B0FA06
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 20:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D35173B0D91
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 18:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384861E5B71;
	Wed, 23 Jul 2025 18:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fhHpz5f6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B697982C60
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 18:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753294312; cv=none; b=jdvVoYbvT9p6+G9M3G6+NA3CdQ/KJuU9ih6MHR5v0Qt3z/yI8n4+fSUbWBCSq7XzGr+oC7wKFKdexbIS1HTRKRF2Qs+d5XrF4tlddjZ/jJdCKzqa/dQ+niQWKYcumknH3drr2LgGFag7SoJZ32tPE5Q+92QrxjNL3bUrA0rB+R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753294312; c=relaxed/simple;
	bh=jE99mkUUZ7qNOCu2ebaQSywscv5EfwUeWfPRAK7lYAE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hd3Z8Xnt5ogFuitB5HbhZOHvpBOLu4whRjpp7F6B7SdkTfGzTiDaLg32FMbJj3z4W92euga5b8S2yVzOj4MxiuEXMh7pk5HDEMy5ecjTtn6vlJ4XQm613A86PZEzR0nDk/sZ2K/K/2m1Oo5iIxjafW1VvLLMzkli9zdt6e9t0ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fhHpz5f6; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753294311; x=1784830311;
  h=date:from:to:cc:subject:message-id;
  bh=jE99mkUUZ7qNOCu2ebaQSywscv5EfwUeWfPRAK7lYAE=;
  b=fhHpz5f6CRrVLjcZQrwmEyUBICUuFS7uDSFR2JHdhPWO/+9OYID2cVi0
   P8DOmQUqPglV2rkWHLDqVnriN08JWu7+yCSkXNozC5FTYudIVDLzMPZSE
   EWdm9pGRp2X0LNiFfR+SgZP5elx/OlfwWkvl6zuCXr7oO1Nlc2xNliFcZ
   jnrHNKkMfcD3Axr+TanqVowi7dWKmuaofNcIn+A8N9ixwFJoWTk4ZxHxx
   ZP+E+dPWPwuWl/aB0TPj927Daw1I3u2tsOQoNQuaF2O7/jZGrsJLVmCft
   liAM8D8B3+1HauQ5qMQk8B6M1jKvHEUDkoDBZqZV3jHCOYpnSXlFqRntf
   Q==;
X-CSE-ConnectionGUID: RJBW4CUERt2TWwTfpPDtWQ==
X-CSE-MsgGUID: rch6INr7R/iP4U6o3Cr3QA==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55702185"
X-IronPort-AV: E=Sophos;i="6.16,335,1744095600"; 
   d="scan'208";a="55702185"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 11:11:50 -0700
X-CSE-ConnectionGUID: R1Pq03t0ReepfE2LnhAmaw==
X-CSE-MsgGUID: MtAddYbyQiqijDNMgU3ysw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,335,1744095600"; 
   d="scan'208";a="160074584"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 23 Jul 2025 11:11:49 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uedwQ-000JfJ-38;
	Wed, 23 Jul 2025 18:11:46 +0000
Date: Thu, 24 Jul 2025 02:10:53 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2025.07.18b] BUILD SUCCESS
 15623ed33fb9e5de6bec1e7f3003d1cca83e7e45
Message-ID: <202507240241.b4N4HVVG-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2025.07.18b
branch HEAD: 15623ed33fb9e5de6bec1e7f3003d1cca83e7e45  srcu: Document srcu_flip() memory-barrier D relation to SRCU-fast

elapsed time: 1134m

configs tested: 214
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                                 defconfig    clang-19
arc                   randconfig-001-20250723    clang-16
arc                   randconfig-001-20250723    gcc-8.5.0
arc                   randconfig-002-20250723    clang-16
arc                   randconfig-002-20250723    gcc-9.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                          ixp4xx_defconfig    clang-22
arm                   randconfig-001-20250723    clang-16
arm                   randconfig-001-20250723    gcc-13.4.0
arm                   randconfig-002-20250723    clang-16
arm                   randconfig-002-20250723    gcc-13.4.0
arm                   randconfig-003-20250723    clang-16
arm                   randconfig-004-20250723    clang-16
arm                   randconfig-004-20250723    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250723    clang-16
arm64                 randconfig-001-20250723    clang-22
arm64                 randconfig-002-20250723    clang-16
arm64                 randconfig-003-20250723    clang-16
arm64                 randconfig-004-20250723    clang-16
arm64                 randconfig-004-20250723    clang-22
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250723    gcc-12.5.0
csky                  randconfig-001-20250723    gcc-8.5.0
csky                  randconfig-002-20250723    gcc-14.3.0
csky                  randconfig-002-20250723    gcc-8.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250723    clang-22
hexagon               randconfig-001-20250723    gcc-8.5.0
hexagon               randconfig-002-20250723    clang-22
hexagon               randconfig-002-20250723    gcc-8.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250723    clang-20
i386        buildonly-randconfig-002-20250723    clang-20
i386        buildonly-randconfig-003-20250723    clang-20
i386        buildonly-randconfig-004-20250723    clang-20
i386        buildonly-randconfig-005-20250723    clang-20
i386        buildonly-randconfig-005-20250723    gcc-11
i386        buildonly-randconfig-006-20250723    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250723    clang-20
i386                  randconfig-002-20250723    clang-20
i386                  randconfig-003-20250723    clang-20
i386                  randconfig-004-20250723    clang-20
i386                  randconfig-005-20250723    clang-20
i386                  randconfig-006-20250723    clang-20
i386                  randconfig-007-20250723    clang-20
i386                  randconfig-011-20250723    clang-20
i386                  randconfig-012-20250723    clang-20
i386                  randconfig-013-20250723    clang-20
i386                  randconfig-014-20250723    clang-20
i386                  randconfig-015-20250723    clang-20
i386                  randconfig-016-20250723    clang-20
i386                  randconfig-017-20250723    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250723    gcc-15.1.0
loongarch             randconfig-001-20250723    gcc-8.5.0
loongarch             randconfig-002-20250723    clang-22
loongarch             randconfig-002-20250723    gcc-8.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                      maltaaprp_defconfig    clang-22
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250723    gcc-8.5.0
nios2                 randconfig-002-20250723    gcc-11.5.0
nios2                 randconfig-002-20250723    gcc-8.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250723    gcc-8.5.0
parisc                randconfig-002-20250723    gcc-15.1.0
parisc                randconfig-002-20250723    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                       ebony_defconfig    clang-22
powerpc                       holly_defconfig    clang-22
powerpc                      mgcoge_defconfig    clang-22
powerpc                    mvme5100_defconfig    clang-22
powerpc               randconfig-001-20250723    gcc-10.5.0
powerpc               randconfig-001-20250723    gcc-8.5.0
powerpc               randconfig-002-20250723    gcc-8.5.0
powerpc               randconfig-003-20250723    gcc-12.5.0
powerpc               randconfig-003-20250723    gcc-8.5.0
powerpc64             randconfig-001-20250723    clang-22
powerpc64             randconfig-001-20250723    gcc-8.5.0
powerpc64             randconfig-002-20250723    clang-22
powerpc64             randconfig-002-20250723    gcc-8.5.0
powerpc64             randconfig-003-20250723    clang-22
powerpc64             randconfig-003-20250723    gcc-8.5.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                    nommu_virt_defconfig    clang-22
riscv                 randconfig-001-20250723    gcc-9.5.0
riscv                 randconfig-002-20250723    clang-22
riscv                 randconfig-002-20250723    gcc-9.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250723    clang-22
s390                  randconfig-001-20250723    gcc-9.5.0
s390                  randconfig-002-20250723    clang-20
s390                  randconfig-002-20250723    gcc-9.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250723    gcc-12.5.0
sh                    randconfig-001-20250723    gcc-9.5.0
sh                    randconfig-002-20250723    gcc-9.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250723    gcc-8.5.0
sparc                 randconfig-001-20250723    gcc-9.5.0
sparc                 randconfig-002-20250723    gcc-8.5.0
sparc                 randconfig-002-20250723    gcc-9.5.0
sparc64               randconfig-001-20250723    gcc-12.5.0
sparc64               randconfig-001-20250723    gcc-9.5.0
sparc64               randconfig-002-20250723    gcc-14.3.0
sparc64               randconfig-002-20250723    gcc-9.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                    randconfig-001-20250723    gcc-12
um                    randconfig-001-20250723    gcc-9.5.0
um                    randconfig-002-20250723    clang-22
um                    randconfig-002-20250723    gcc-9.5.0
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250723    gcc-11
x86_64      buildonly-randconfig-001-20250723    gcc-12
x86_64      buildonly-randconfig-002-20250723    gcc-11
x86_64      buildonly-randconfig-003-20250723    gcc-11
x86_64      buildonly-randconfig-004-20250723    clang-20
x86_64      buildonly-randconfig-004-20250723    gcc-11
x86_64      buildonly-randconfig-005-20250723    gcc-11
x86_64      buildonly-randconfig-005-20250723    gcc-12
x86_64      buildonly-randconfig-006-20250723    gcc-11
x86_64      buildonly-randconfig-006-20250723    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250723    gcc-12
x86_64                randconfig-002-20250723    gcc-12
x86_64                randconfig-003-20250723    gcc-12
x86_64                randconfig-004-20250723    gcc-12
x86_64                randconfig-005-20250723    gcc-12
x86_64                randconfig-006-20250723    gcc-12
x86_64                randconfig-007-20250723    gcc-12
x86_64                randconfig-008-20250723    gcc-12
x86_64                randconfig-071-20250723    clang-20
x86_64                randconfig-072-20250723    clang-20
x86_64                randconfig-073-20250723    clang-20
x86_64                randconfig-074-20250723    clang-20
x86_64                randconfig-075-20250723    clang-20
x86_64                randconfig-076-20250723    clang-20
x86_64                randconfig-077-20250723    clang-20
x86_64                randconfig-078-20250723    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                generic_kc705_defconfig    clang-22
xtensa                randconfig-001-20250723    gcc-13.4.0
xtensa                randconfig-001-20250723    gcc-9.5.0
xtensa                randconfig-002-20250723    gcc-10.5.0
xtensa                randconfig-002-20250723    gcc-9.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


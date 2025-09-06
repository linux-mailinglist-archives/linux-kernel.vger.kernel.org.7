Return-Path: <linux-kernel+bounces-804016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D99B468BF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 06:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0567D5827FD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 04:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF67212D83;
	Sat,  6 Sep 2025 04:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I47FtOf/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACAD29A2
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 04:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757131314; cv=none; b=UB5RYyg9pwiegbI3/t0aJWwlRyYOUuObB/VYJFNNG13IedYK+7u39sJLoKOuROmpULFPvizCnw/J1+w1WDZDnMPtx3AeqKvYBISfmrzKGT9+tFniTCVUroSexBx+GrhcCowa2+05Meb0Js9htredSywLmQ+SznctzMbbCOzE3p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757131314; c=relaxed/simple;
	bh=P4w1uvfs8m1hAegKzk3JfdNopcebaX5FEIUMd5WLm6o=;
	h=Date:From:To:Cc:Subject:Message-ID; b=liK5vmjSNB1jwZZVZ+kR5X7frbCg1jbsI/oSyMlm6LRFhjCj9Qy5WhUwUH6d3osNpM0fY+9SEDqrtEqYmO0djP0MHGh5HszkatymonQuIV2pyHjrXjnfLX+sRzaxIh0OpdHT5H2n6feFkN1YWyrdGQh7SCcP7W0WVIEsTauxhk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I47FtOf/; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757131312; x=1788667312;
  h=date:from:to:cc:subject:message-id;
  bh=P4w1uvfs8m1hAegKzk3JfdNopcebaX5FEIUMd5WLm6o=;
  b=I47FtOf/YiLRjB5ZrdIbYACwnZerV3Cov0dmCqyokrWIlf7JRPZ5n+0b
   swT2K6wgmGS5GnFNcZ4HLdiSPiA++vfx7phe2/d7kSs5+ehpOcxCVZhB6
   y0cP6IKUzMApZEU6IBG3XGUWNg1bf62zy367T8UdFRBb+xf7IIwgTrivp
   MwSQPmP4qwOTFj5HxtaVpEW0DN7Jt1KRDl+TLvJe1b2UgvcNRfXzwCcnU
   Ic8OqaK8vMxbn/ZN7jtMbhTuwaohNElVMTNHUudolhUE86kMY2RtN44E8
   wfEdXiEauLdhhcA9uBRm7Y1l0p4zLXG4T1G2OnA630NjzaRh474qfhW75
   g==;
X-CSE-ConnectionGUID: 3F/SA4YYSGCJlBjkd8/YNw==
X-CSE-MsgGUID: JeGbCi4bRvC5pFvmDGqTpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="77090542"
X-IronPort-AV: E=Sophos;i="6.18,243,1751266800"; 
   d="scan'208";a="77090542"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 21:01:51 -0700
X-CSE-ConnectionGUID: jJcHwGR2S6mhfyUIdHK4Qg==
X-CSE-MsgGUID: wN96xcK9RRixRZsYdd7r4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,243,1751266800"; 
   d="scan'208";a="176397871"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 05 Sep 2025 21:01:48 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uuk7X-0001BR-2s;
	Sat, 06 Sep 2025 04:01:47 +0000
Date: Sat, 06 Sep 2025 12:01:44 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/microcode] BUILD SUCCESS
 43181a47263dd9f2bee0afd688a841b09f9b7d12
Message-ID: <202509061238.GxXSAnYE-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/microcode
branch HEAD: 43181a47263dd9f2bee0afd688a841b09f9b7d12  x86/microcode: Add microcode loader debugging functionality

elapsed time: 1001m

configs tested: 222
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                            allyesconfig    clang-19
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-22
arc                              allyesconfig    clang-19
arc                                 defconfig    clang-19
arc                   randconfig-001-20250905    gcc-11.5.0
arc                   randconfig-001-20250906    gcc-8.5.0
arc                   randconfig-002-20250905    gcc-13.4.0
arc                   randconfig-002-20250906    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                         nhk8815_defconfig    clang-22
arm                   randconfig-001-20250905    clang-22
arm                   randconfig-001-20250906    gcc-8.5.0
arm                   randconfig-002-20250905    clang-22
arm                   randconfig-002-20250906    gcc-8.5.0
arm                   randconfig-003-20250905    clang-16
arm                   randconfig-003-20250906    gcc-8.5.0
arm                   randconfig-004-20250905    gcc-14.3.0
arm                   randconfig-004-20250906    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250905    clang-22
arm64                 randconfig-001-20250906    gcc-8.5.0
arm64                 randconfig-002-20250905    clang-17
arm64                 randconfig-002-20250906    gcc-8.5.0
arm64                 randconfig-003-20250905    clang-17
arm64                 randconfig-003-20250906    gcc-8.5.0
arm64                 randconfig-004-20250905    clang-22
arm64                 randconfig-004-20250906    gcc-8.5.0
csky                              allnoconfig    clang-22
csky                                defconfig    clang-19
csky                  randconfig-001-20250906    gcc-11.5.0
csky                  randconfig-001-20250906    gcc-15.1.0
csky                  randconfig-002-20250906    gcc-11.5.0
csky                  randconfig-002-20250906    gcc-15.1.0
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250906    clang-20
hexagon               randconfig-001-20250906    gcc-11.5.0
hexagon               randconfig-002-20250906    clang-22
hexagon               randconfig-002-20250906    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250905    clang-20
i386        buildonly-randconfig-001-20250906    clang-20
i386        buildonly-randconfig-002-20250905    clang-20
i386        buildonly-randconfig-002-20250906    clang-20
i386        buildonly-randconfig-003-20250905    clang-20
i386        buildonly-randconfig-003-20250906    clang-20
i386        buildonly-randconfig-004-20250905    gcc-13
i386        buildonly-randconfig-004-20250906    clang-20
i386        buildonly-randconfig-005-20250905    clang-20
i386        buildonly-randconfig-005-20250906    clang-20
i386        buildonly-randconfig-006-20250905    clang-20
i386        buildonly-randconfig-006-20250906    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250906    gcc-13
i386                  randconfig-002-20250906    gcc-13
i386                  randconfig-003-20250906    gcc-13
i386                  randconfig-004-20250906    gcc-13
i386                  randconfig-005-20250906    gcc-13
i386                  randconfig-006-20250906    gcc-13
i386                  randconfig-007-20250906    gcc-13
i386                  randconfig-011-20250906    clang-20
i386                  randconfig-012-20250906    clang-20
i386                  randconfig-013-20250906    clang-20
i386                  randconfig-014-20250906    clang-20
i386                  randconfig-015-20250906    clang-20
i386                  randconfig-016-20250906    clang-20
i386                  randconfig-017-20250906    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch                 loongson3_defconfig    clang-22
loongarch             randconfig-001-20250906    clang-22
loongarch             randconfig-001-20250906    gcc-11.5.0
loongarch             randconfig-002-20250906    gcc-11.5.0
loongarch             randconfig-002-20250906    gcc-15.1.0
m68k                             allmodconfig    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                                defconfig    clang-19
m68k                        mvme16x_defconfig    clang-22
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           jazz_defconfig    clang-22
mips                   sb1250_swarm_defconfig    clang-22
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250906    gcc-11.5.0
nios2                 randconfig-002-20250906    gcc-11.5.0
openrisc                          allnoconfig    clang-22
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-13
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250906    gcc-11.5.0
parisc                randconfig-002-20250906    gcc-11.5.0
parisc                randconfig-002-20250906    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                      cm5200_defconfig    clang-22
powerpc               randconfig-001-20250906    gcc-11.5.0
powerpc               randconfig-001-20250906    gcc-14.3.0
powerpc               randconfig-002-20250906    clang-20
powerpc               randconfig-002-20250906    gcc-11.5.0
powerpc               randconfig-003-20250906    clang-22
powerpc               randconfig-003-20250906    gcc-11.5.0
powerpc64             randconfig-001-20250906    gcc-11.5.0
powerpc64             randconfig-001-20250906    gcc-13.4.0
powerpc64             randconfig-002-20250906    gcc-10.5.0
powerpc64             randconfig-002-20250906    gcc-11.5.0
powerpc64             randconfig-003-20250906    clang-22
powerpc64             randconfig-003-20250906    gcc-11.5.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-13
riscv                 randconfig-001-20250905    gcc-14.3.0
riscv                 randconfig-001-20250906    gcc-15.1.0
riscv                 randconfig-002-20250905    clang-22
riscv                 randconfig-002-20250906    gcc-15.1.0
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-13
s390                  randconfig-001-20250905    gcc-9.5.0
s390                  randconfig-001-20250906    gcc-15.1.0
s390                  randconfig-002-20250905    clang-22
s390                  randconfig-002-20250906    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-13
sh                    randconfig-001-20250905    gcc-15.1.0
sh                    randconfig-001-20250906    gcc-15.1.0
sh                    randconfig-002-20250905    gcc-15.1.0
sh                    randconfig-002-20250906    gcc-15.1.0
sh                           se7712_defconfig    clang-22
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250905    gcc-8.5.0
sparc                 randconfig-001-20250906    gcc-15.1.0
sparc                 randconfig-002-20250905    gcc-15.1.0
sparc                 randconfig-002-20250906    gcc-15.1.0
sparc64                             defconfig    gcc-13
sparc64               randconfig-001-20250905    gcc-8.5.0
sparc64               randconfig-001-20250906    gcc-15.1.0
sparc64               randconfig-002-20250905    clang-22
sparc64               randconfig-002-20250906    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                                  defconfig    gcc-13
um                             i386_defconfig    gcc-13
um                    randconfig-001-20250905    clang-22
um                    randconfig-001-20250906    gcc-15.1.0
um                    randconfig-002-20250905    gcc-13
um                    randconfig-002-20250906    gcc-15.1.0
um                           x86_64_defconfig    gcc-13
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250905    clang-20
x86_64      buildonly-randconfig-001-20250906    gcc-13
x86_64      buildonly-randconfig-002-20250905    clang-20
x86_64      buildonly-randconfig-002-20250906    gcc-13
x86_64      buildonly-randconfig-003-20250905    gcc-13
x86_64      buildonly-randconfig-003-20250906    gcc-13
x86_64      buildonly-randconfig-004-20250905    clang-20
x86_64      buildonly-randconfig-004-20250906    gcc-13
x86_64      buildonly-randconfig-005-20250905    clang-20
x86_64      buildonly-randconfig-005-20250906    gcc-13
x86_64      buildonly-randconfig-006-20250905    gcc-13
x86_64      buildonly-randconfig-006-20250906    gcc-13
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250906    gcc-13
x86_64                randconfig-002-20250906    gcc-13
x86_64                randconfig-003-20250906    gcc-13
x86_64                randconfig-004-20250906    gcc-13
x86_64                randconfig-005-20250906    gcc-13
x86_64                randconfig-006-20250906    gcc-13
x86_64                randconfig-007-20250906    gcc-13
x86_64                randconfig-008-20250906    gcc-13
x86_64                randconfig-071-20250906    clang-20
x86_64                randconfig-072-20250906    clang-20
x86_64                randconfig-073-20250906    clang-20
x86_64                randconfig-074-20250906    clang-20
x86_64                randconfig-075-20250906    clang-20
x86_64                randconfig-076-20250906    clang-20
x86_64                randconfig-077-20250906    clang-20
x86_64                randconfig-078-20250906    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-13
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-13
x86_64                           rhel-9.4-ltp    gcc-13
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                  audio_kc705_defconfig    clang-22
xtensa                randconfig-001-20250905    gcc-8.5.0
xtensa                randconfig-001-20250906    gcc-15.1.0
xtensa                randconfig-002-20250905    gcc-8.5.0
xtensa                randconfig-002-20250906    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


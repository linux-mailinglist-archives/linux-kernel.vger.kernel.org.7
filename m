Return-Path: <linux-kernel+bounces-685684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71322AD8D29
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 15:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC0A53AD07B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 13:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2859155389;
	Fri, 13 Jun 2025 13:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q5w1pBAW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1604111BF
	for <linux-kernel@vger.kernel.org>; Fri, 13 Jun 2025 13:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749821742; cv=none; b=FwlK5DjBoHA22H9holvT/1KIR7z/FhxQ+zVHn5KcTIavkmfr1Mja1Alge2Dk3Eg0g4ulFHy9keOg8/1KzmNLdyetTR6LgsB/4zl0mjqEqzfzG0C88rMjTIXINc/ohjjBX7L/BAoYu8AVEy1Hubv5eu0qDz3WHRXvg2OrV77F7Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749821742; c=relaxed/simple;
	bh=qJJmVjS2iuSRlzXgXI1pGd82XAm+Iowj5+yOMwsCpJY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=APX6WXJOq+9zob4WgQ42KgD9PKYof9cQj2tAvbVVXXGu6Fu4lUQ0l6//gboVDK/ZXxdmO2VcOSruRvKqvjYbv/I7NyqgdxbelzkpGYlEccGTWwHZN8HnwuBic2IIGw+5UH0RX3DXFcGeWnsat4ccDBvIon3/lKLuLNUH+Z5wDqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q5w1pBAW; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749821740; x=1781357740;
  h=date:from:to:cc:subject:message-id;
  bh=qJJmVjS2iuSRlzXgXI1pGd82XAm+Iowj5+yOMwsCpJY=;
  b=Q5w1pBAWWdXSEgtoRiVKYitAsQ3XgyfkcUvVsB5LrLk15go2SrQwR7Xw
   l3A662ssuL8XvNZW6BHZAgee3O76csLzzaUkgFKAduVCsan6bMxdGRHGi
   LzdILpNHBZpykbCKML+5ChWSG6Q6XKTnnLgTQ+8l56lPLAUv1LYIVBnFm
   UCu5VJsRZvKWdFmNHAWXIE85E+O8e47anZZdnFR+hjuu/vO9lWzSt3y1h
   DATr7/J5tVfNi/leypqVfUp96CqwMpGxVtDwsvpbHQ1cr/HNDY6mcdJyX
   JjwQNwmepMGArvBs2Q3gxEgjr7ULRWnbOsfmA//rx5RTxvU6Q3nF1NaEu
   A==;
X-CSE-ConnectionGUID: s8vyqs4uQ9qQHhKdfeyBCA==
X-CSE-MsgGUID: LOyWgW4DQ/KzyTsWOqM91A==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="63073058"
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="63073058"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 06:35:40 -0700
X-CSE-ConnectionGUID: pwbOGTYCTjSmIiTv7nfJFQ==
X-CSE-MsgGUID: crWGVnOdTu+KhhTMdVisCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="147675028"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 13 Jun 2025 06:35:39 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uQ4ZE-000Cei-2Y;
	Fri, 13 Jun 2025 13:35:36 +0000
Date: Fri, 13 Jun 2025 21:34:56 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/drivers] BUILD SUCCESS
 93174c05dd2e9b02eb6b5c93dd9109087ae4ffcf
Message-ID: <202506132146.wNYo3Zlp-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/drivers
branch HEAD: 93174c05dd2e9b02eb6b5c93dd9109087ae4ffcf  irqchip: Use dev_fwnode()

elapsed time: 1455m

configs tested: 233
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250613    gcc-12.4.0
arc                   randconfig-002-20250613    gcc-12.4.0
arm                               allnoconfig    gcc-15.1.0
arm                         at91_dt_defconfig    clang-21
arm                        clps711x_defconfig    clang-21
arm                                 defconfig    gcc-15.1.0
arm                   randconfig-001-20250613    clang-21
arm                   randconfig-001-20250613    gcc-12.4.0
arm                   randconfig-002-20250613    clang-20
arm                   randconfig-002-20250613    gcc-12.4.0
arm                   randconfig-003-20250613    gcc-12.4.0
arm                   randconfig-003-20250613    gcc-8.5.0
arm                   randconfig-004-20250613    clang-21
arm                   randconfig-004-20250613    gcc-12.4.0
arm                           u8500_defconfig    clang-21
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250613    gcc-12.4.0
arm64                 randconfig-001-20250613    gcc-15.1.0
arm64                 randconfig-002-20250613    clang-21
arm64                 randconfig-002-20250613    gcc-12.4.0
arm64                 randconfig-003-20250613    clang-21
arm64                 randconfig-003-20250613    gcc-12.4.0
arm64                 randconfig-004-20250613    gcc-12.4.0
arm64                 randconfig-004-20250613    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250613    gcc-13.3.0
csky                  randconfig-001-20250613    gcc-15.1.0
csky                  randconfig-002-20250613    gcc-13.3.0
csky                  randconfig-002-20250613    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    gcc-15.1.0
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20250613    clang-21
hexagon               randconfig-001-20250613    gcc-13.3.0
hexagon               randconfig-002-20250613    clang-21
hexagon               randconfig-002-20250613    gcc-13.3.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250612    clang-20
i386        buildonly-randconfig-001-20250613    gcc-12
i386        buildonly-randconfig-002-20250612    gcc-12
i386        buildonly-randconfig-002-20250613    gcc-12
i386        buildonly-randconfig-003-20250612    clang-20
i386        buildonly-randconfig-003-20250613    gcc-12
i386        buildonly-randconfig-004-20250612    clang-20
i386        buildonly-randconfig-004-20250613    gcc-12
i386        buildonly-randconfig-005-20250612    clang-20
i386        buildonly-randconfig-005-20250613    gcc-12
i386        buildonly-randconfig-006-20250612    clang-20
i386        buildonly-randconfig-006-20250613    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250613    clang-20
i386                  randconfig-002-20250613    clang-20
i386                  randconfig-003-20250613    clang-20
i386                  randconfig-004-20250613    clang-20
i386                  randconfig-005-20250613    clang-20
i386                  randconfig-006-20250613    clang-20
i386                  randconfig-007-20250613    clang-20
i386                  randconfig-011-20250613    clang-20
i386                  randconfig-012-20250613    clang-20
i386                  randconfig-013-20250613    clang-20
i386                  randconfig-014-20250613    clang-20
i386                  randconfig-015-20250613    clang-20
i386                  randconfig-016-20250613    clang-20
i386                  randconfig-017-20250613    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    gcc-15.1.0
loongarch             randconfig-001-20250613    gcc-13.3.0
loongarch             randconfig-001-20250613    gcc-15.1.0
loongarch             randconfig-002-20250613    gcc-13.3.0
loongarch             randconfig-002-20250613    gcc-15.1.0
m68k                             alldefconfig    clang-21
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                          multi_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        maltaup_defconfig    gcc-15.1.0
mips                        omega2p_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250613    gcc-11.5.0
nios2                 randconfig-001-20250613    gcc-13.3.0
nios2                 randconfig-002-20250613    gcc-11.5.0
nios2                 randconfig-002-20250613    gcc-13.3.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250613    gcc-13.3.0
parisc                randconfig-001-20250613    gcc-8.5.0
parisc                randconfig-002-20250613    gcc-13.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                      arches_defconfig    gcc-15.1.0
powerpc                      chrp32_defconfig    gcc-15.1.0
powerpc                      pasemi_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250613    clang-21
powerpc               randconfig-001-20250613    gcc-13.3.0
powerpc               randconfig-002-20250613    gcc-13.3.0
powerpc               randconfig-002-20250613    gcc-8.5.0
powerpc               randconfig-003-20250613    gcc-13.3.0
powerpc               randconfig-003-20250613    gcc-9.3.0
powerpc64             randconfig-001-20250613    gcc-13.3.0
powerpc64             randconfig-001-20250613    gcc-8.5.0
powerpc64             randconfig-002-20250613    gcc-13.3.0
powerpc64             randconfig-002-20250613    gcc-8.5.0
powerpc64             randconfig-003-20250613    gcc-10.5.0
powerpc64             randconfig-003-20250613    gcc-13.3.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250612    clang-21
riscv                 randconfig-001-20250613    gcc-15.1.0
riscv                 randconfig-002-20250612    clang-21
riscv                 randconfig-002-20250613    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250612    clang-21
s390                  randconfig-001-20250613    gcc-15.1.0
s390                  randconfig-002-20250612    gcc-11.5.0
s390                  randconfig-002-20250613    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                        edosk7705_defconfig    gcc-15.1.0
sh                 kfr2r09-romimage_defconfig    clang-21
sh                    randconfig-001-20250612    gcc-12.4.0
sh                    randconfig-001-20250613    gcc-15.1.0
sh                    randconfig-002-20250612    gcc-15.1.0
sh                    randconfig-002-20250613    gcc-15.1.0
sh                          sdk7780_defconfig    clang-21
sh                          sdk7780_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250612    gcc-14.3.0
sparc                 randconfig-001-20250613    gcc-15.1.0
sparc                 randconfig-002-20250612    gcc-10.3.0
sparc                 randconfig-002-20250613    gcc-15.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250612    gcc-13.3.0
sparc64               randconfig-001-20250613    gcc-15.1.0
sparc64               randconfig-002-20250612    gcc-8.5.0
sparc64               randconfig-002-20250613    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250612    clang-17
um                    randconfig-001-20250613    gcc-15.1.0
um                    randconfig-002-20250612    clang-21
um                    randconfig-002-20250613    gcc-15.1.0
um                           x86_64_defconfig    clang-21
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250612    gcc-12
x86_64      buildonly-randconfig-001-20250613    gcc-12
x86_64      buildonly-randconfig-002-20250612    clang-20
x86_64      buildonly-randconfig-002-20250613    gcc-12
x86_64      buildonly-randconfig-003-20250612    gcc-12
x86_64      buildonly-randconfig-003-20250613    gcc-12
x86_64      buildonly-randconfig-004-20250612    gcc-12
x86_64      buildonly-randconfig-004-20250613    gcc-12
x86_64      buildonly-randconfig-005-20250612    clang-20
x86_64      buildonly-randconfig-005-20250613    gcc-12
x86_64      buildonly-randconfig-006-20250612    clang-20
x86_64      buildonly-randconfig-006-20250613    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250613    gcc-12
x86_64                randconfig-002-20250613    gcc-12
x86_64                randconfig-003-20250613    gcc-12
x86_64                randconfig-004-20250613    gcc-12
x86_64                randconfig-005-20250613    gcc-12
x86_64                randconfig-006-20250613    gcc-12
x86_64                randconfig-007-20250613    gcc-12
x86_64                randconfig-008-20250613    gcc-12
x86_64                randconfig-071-20250613    gcc-12
x86_64                randconfig-072-20250613    gcc-12
x86_64                randconfig-073-20250613    gcc-12
x86_64                randconfig-074-20250613    gcc-12
x86_64                randconfig-075-20250613    gcc-12
x86_64                randconfig-076-20250613    gcc-12
x86_64                randconfig-077-20250613    gcc-12
x86_64                randconfig-078-20250613    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250612    gcc-10.5.0
xtensa                randconfig-001-20250613    gcc-15.1.0
xtensa                randconfig-002-20250612    gcc-12.4.0
xtensa                randconfig-002-20250613    gcc-15.1.0
xtensa                    smp_lx200_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-kernel+bounces-792755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEB7B3C88B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 08:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 320C7A0693B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 06:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3712417E0;
	Sat, 30 Aug 2025 06:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eT9qk5dv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F063145A05
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 06:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756536121; cv=none; b=FB+97ijJlj0X3hEgp1cXNLt0J+hsGlmmoJD5jdGmWw5WU+sQbTYGHWlix9fPu0LzNHQHP2c/SW+lpxXhR+9A/yXgKTZ9qrEMsQ7ejo2GbtXkie7VMZq9BSPP9dQv/S9FEarXpiJtuo/cGUAwRsswxucFUMKTjC6zSsF1tzRfBX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756536121; c=relaxed/simple;
	bh=JWX8rKCcuSoPCGEJ7Gf7NMBtz78acklfpQvxJnO2eOw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=I7LaCsPsDoCAMOYah3WVNxPINgkQjbmvGrm+QMMqArrG/s/GvIrNoJECSz/UtmZrcuByepBbXY9MnPtYBp6kivfGt7DziFVR21cw8cLeieyHSdzQg3FWMRMPsKRJ199lyCUPXF9VWB0MdMpMUK5ZSHHjqXUuba9AoEge0JAPBEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eT9qk5dv; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756536119; x=1788072119;
  h=date:from:to:cc:subject:message-id;
  bh=JWX8rKCcuSoPCGEJ7Gf7NMBtz78acklfpQvxJnO2eOw=;
  b=eT9qk5dvE52oGfxSHz0id9OqGNaEMnXvg6fjOmDgJCAwSHH2mk7jZHGU
   HfygWqUna21FqTCw5Qq4XA5a7fCi/VijGa8+erFRGibSff0KHss1cMlld
   H41hE9JY9aYUZkvp8dFggHOuFdLcx+OaRT9oZF4h1l4BFyw74qGk1MTgC
   kHeUuiOn+Y5XAR7va/OKjU/HpybVXYZFMnyY4KzaxKICwSnduHC2evRt3
   i37jo2QUmaAVuS7XbQcCwbWU0wbtslq7Sjgjjw38uDMErsWlzdUzwzC4o
   ELrS1pM4vmk+5kHkE9LpWoeyvb4pZybG1zbEDmiuxo6f1iYX9FN1He057
   A==;
X-CSE-ConnectionGUID: 57P3U6nZQNSiGNxFwwVkjA==
X-CSE-MsgGUID: 4V2xQV+pROSiP5ynWdy0hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11537"; a="62635399"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="62635399"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 23:41:58 -0700
X-CSE-ConnectionGUID: 74kubQZkRxisW/c47xgGOA==
X-CSE-MsgGUID: cMLMUj9bRgiUm/Y1En0eVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="169797827"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 29 Aug 2025 23:41:57 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1usFHS-000VDf-2S;
	Sat, 30 Aug 2025 06:41:48 +0000
Date: Sat, 30 Aug 2025 14:41:17 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20250829] BUILD SUCCESS
 4c9334c4e307b42483618e62244b9f6e95be609a
Message-ID: <202508301407.H2zACJ13-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20250829
branch HEAD: 4c9334c4e307b42483618e62244b9f6e95be609a  iwlegacy: Remove unused structs and avoid -Wflex-array-member-not-at-end warnings

elapsed time: 1091m

configs tested: 223
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
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                                 defconfig    clang-19
arc                   randconfig-001-20250829    gcc-8.5.0
arc                   randconfig-001-20250830    clang-22
arc                   randconfig-002-20250829    gcc-10.5.0
arc                   randconfig-002-20250830    clang-22
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                         orion5x_defconfig    gcc-15.1.0
arm                   randconfig-001-20250829    gcc-10.5.0
arm                   randconfig-001-20250830    clang-22
arm                   randconfig-002-20250829    clang-22
arm                   randconfig-002-20250830    clang-22
arm                   randconfig-003-20250829    clang-22
arm                   randconfig-003-20250830    clang-22
arm                   randconfig-004-20250829    clang-22
arm                   randconfig-004-20250830    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250829    clang-22
arm64                 randconfig-001-20250830    clang-22
arm64                 randconfig-002-20250829    gcc-12.5.0
arm64                 randconfig-002-20250830    clang-22
arm64                 randconfig-003-20250829    clang-22
arm64                 randconfig-003-20250830    clang-22
arm64                 randconfig-004-20250829    gcc-9.5.0
arm64                 randconfig-004-20250830    clang-22
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250829    gcc-9.5.0
csky                  randconfig-001-20250830    clang-22
csky                  randconfig-002-20250829    gcc-10.5.0
csky                  randconfig-002-20250830    clang-22
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250829    clang-22
hexagon               randconfig-001-20250830    clang-22
hexagon               randconfig-002-20250829    clang-22
hexagon               randconfig-002-20250830    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250829    gcc-12
i386        buildonly-randconfig-001-20250830    gcc-12
i386        buildonly-randconfig-002-20250829    clang-20
i386        buildonly-randconfig-002-20250830    gcc-12
i386        buildonly-randconfig-003-20250829    clang-20
i386        buildonly-randconfig-003-20250830    gcc-12
i386        buildonly-randconfig-004-20250829    clang-20
i386        buildonly-randconfig-004-20250830    gcc-12
i386        buildonly-randconfig-005-20250829    gcc-12
i386        buildonly-randconfig-005-20250830    gcc-12
i386        buildonly-randconfig-006-20250829    clang-20
i386        buildonly-randconfig-006-20250830    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250830    clang-20
i386                  randconfig-002-20250830    clang-20
i386                  randconfig-003-20250830    clang-20
i386                  randconfig-004-20250830    clang-20
i386                  randconfig-005-20250830    clang-20
i386                  randconfig-006-20250830    clang-20
i386                  randconfig-007-20250830    clang-20
i386                  randconfig-011-20250830    gcc-12
i386                  randconfig-012-20250830    gcc-12
i386                  randconfig-013-20250830    gcc-12
i386                  randconfig-014-20250830    gcc-12
i386                  randconfig-015-20250830    gcc-12
i386                  randconfig-016-20250830    gcc-12
i386                  randconfig-017-20250830    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250829    clang-22
loongarch             randconfig-001-20250830    clang-22
loongarch             randconfig-002-20250829    clang-22
loongarch             randconfig-002-20250830    clang-22
m68k                             allmodconfig    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                                defconfig    clang-19
m68k                        m5272c3_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          ath25_defconfig    gcc-15.1.0
mips                       bmips_be_defconfig    gcc-15.1.0
mips                           ip28_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250829    gcc-11.5.0
nios2                 randconfig-001-20250830    clang-22
nios2                 randconfig-002-20250829    gcc-11.5.0
nios2                 randconfig-002-20250830    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250829    gcc-14.3.0
parisc                randconfig-001-20250830    clang-22
parisc                randconfig-002-20250829    gcc-8.5.0
parisc                randconfig-002-20250830    clang-22
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                      katmai_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250829    gcc-13.4.0
powerpc               randconfig-001-20250830    clang-22
powerpc               randconfig-002-20250829    clang-22
powerpc               randconfig-002-20250830    clang-22
powerpc               randconfig-003-20250829    gcc-12.5.0
powerpc               randconfig-003-20250830    clang-22
powerpc                     tqm8548_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250829    clang-22
powerpc64             randconfig-001-20250830    clang-22
powerpc64             randconfig-002-20250829    clang-22
powerpc64             randconfig-002-20250830    clang-22
powerpc64             randconfig-003-20250829    gcc-8.5.0
powerpc64             randconfig-003-20250830    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv             nommu_k210_sdcard_defconfig    gcc-15.1.0
riscv                 randconfig-001-20250830    gcc-11.5.0
riscv                 randconfig-002-20250830    gcc-11.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250830    gcc-11.5.0
s390                  randconfig-002-20250830    gcc-11.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250830    gcc-11.5.0
sh                    randconfig-002-20250830    gcc-11.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250830    gcc-11.5.0
sparc                 randconfig-002-20250830    gcc-11.5.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250830    gcc-11.5.0
sparc64               randconfig-002-20250830    gcc-11.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250830    gcc-11.5.0
um                    randconfig-002-20250830    gcc-11.5.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250829    gcc-11
x86_64      buildonly-randconfig-001-20250830    gcc-12
x86_64      buildonly-randconfig-002-20250829    gcc-11
x86_64      buildonly-randconfig-002-20250830    gcc-12
x86_64      buildonly-randconfig-003-20250829    gcc-12
x86_64      buildonly-randconfig-003-20250830    gcc-12
x86_64      buildonly-randconfig-004-20250829    clang-20
x86_64      buildonly-randconfig-004-20250830    gcc-12
x86_64      buildonly-randconfig-005-20250829    clang-20
x86_64      buildonly-randconfig-005-20250830    gcc-12
x86_64      buildonly-randconfig-006-20250829    clang-20
x86_64      buildonly-randconfig-006-20250830    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250830    gcc-11
x86_64                randconfig-002-20250830    gcc-11
x86_64                randconfig-003-20250830    gcc-11
x86_64                randconfig-004-20250830    gcc-11
x86_64                randconfig-005-20250830    gcc-11
x86_64                randconfig-006-20250830    gcc-11
x86_64                randconfig-007-20250830    gcc-11
x86_64                randconfig-008-20250830    gcc-11
x86_64                randconfig-071-20250830    gcc-12
x86_64                randconfig-072-20250830    gcc-12
x86_64                randconfig-073-20250830    gcc-12
x86_64                randconfig-074-20250830    gcc-12
x86_64                randconfig-075-20250830    gcc-12
x86_64                randconfig-076-20250830    gcc-12
x86_64                randconfig-077-20250830    gcc-12
x86_64                randconfig-078-20250830    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250830    gcc-11.5.0
xtensa                randconfig-002-20250830    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


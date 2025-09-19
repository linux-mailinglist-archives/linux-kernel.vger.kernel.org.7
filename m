Return-Path: <linux-kernel+bounces-824855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF701B8A4F4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B10D3B2027
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA01E306B3D;
	Fri, 19 Sep 2025 15:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jZajiHWV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E3072628
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758296033; cv=none; b=ilgeoL9SofRY7cg5UBXHw12XJQTK92ccYpN66O9Z1OFk1F5nc9ltZ6hg7DNrqUZbs0qduErb5xAZXS5caDQCn/abAyvnwmGbdOav8G94ZiRxQ1jPuuX7Ukua1hfWg43Cit87d+CKdOpz98+vCU8TASg+kNU8zMS43WaeK9a9KK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758296033; c=relaxed/simple;
	bh=DjRrA4QP/PVuwmqLALMOe9BYw81TAYVLFZc7xbwdUVI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=oRoEjaXH8mVSGwX2I7AeDEDVCSDjsWaZ7N7vfK45K762eFK26gS+fjumLU4o+Rfn/xo8vOZIzko3UzY0Uskuj2ucCOU7EukmshLwvkRaRJf1rSCpwjFGM7hPjYUPszcrpN7z9hQ8K7AkxOpxhqSeqAt/GTNc4Pzgy/RmQFi4xdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jZajiHWV; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758296031; x=1789832031;
  h=date:from:to:cc:subject:message-id;
  bh=DjRrA4QP/PVuwmqLALMOe9BYw81TAYVLFZc7xbwdUVI=;
  b=jZajiHWVNXa8v64L9AftDpRUl7JO/EIg4aGg/4T65UVQ/CADIECm482J
   lyuZkZGPdvKmJdKI025JlLt/2diUTQsrUzypj9JQWUOek2JX5U9OEyItH
   ki15k7vJvdLKSFB06XKDymNWPCXobYgbguuu5V1wx0A0OjzphjCkttkz/
   TyVScbsW9DLyxget81XIuRFosd9I5C2zD0e1c8k/CyjLR9TYvVdx1S6Wq
   iff/6QWp5MpwtmZjacx4C8yVfRNMzns7eMV6+LGa02KL04FUNQAkbjnY+
   WihIVe26bM45p4B13Rhjs5QSp50bwfD98A4IV7xeF3o16iu8RW2rfIEWb
   w==;
X-CSE-ConnectionGUID: BH+2WoBFS1SvgcXSi2eApQ==
X-CSE-MsgGUID: fAVFG3/lSF6LKI5hYbs/Lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="72072566"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="72072566"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 08:33:50 -0700
X-CSE-ConnectionGUID: GPCXuEqEQyu1dhC6hCoSpw==
X-CSE-MsgGUID: ZbU04Ki/TiaF9zMyELcKkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="175786801"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 19 Sep 2025 08:33:48 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uzd7K-0004Pz-1O;
	Fri, 19 Sep 2025 15:33:46 +0000
Date: Fri, 19 Sep 2025 23:32:47 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:smp/core] BUILD SUCCESS
 ccf09357ffef2ab472369ab9cdf470c9bc9b821a
Message-ID: <202509192341.YIzoCxql-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp/core
branch HEAD: ccf09357ffef2ab472369ab9cdf470c9bc9b821a  smp: Fix up and expand the smp_call_function_many() kerneldoc

elapsed time: 1081m

configs tested: 215
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-15.1.0
alpha                             allnoconfig    clang-22
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-22
arc                              allyesconfig    clang-19
arc                                 defconfig    clang-19
arc                         haps_hs_defconfig    gcc-15.1.0
arc                   randconfig-001-20250919    gcc-11.5.0
arc                   randconfig-001-20250919    gcc-15.1.0
arc                   randconfig-002-20250919    gcc-11.5.0
arc                   randconfig-002-20250919    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                   randconfig-001-20250919    gcc-11.5.0
arm                   randconfig-001-20250919    gcc-12.5.0
arm                   randconfig-002-20250919    gcc-10.5.0
arm                   randconfig-002-20250919    gcc-11.5.0
arm                   randconfig-003-20250919    gcc-11.5.0
arm                   randconfig-003-20250919    gcc-12.5.0
arm                   randconfig-004-20250919    clang-22
arm                   randconfig-004-20250919    gcc-11.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250919    gcc-11.5.0
arm64                 randconfig-001-20250919    gcc-15.1.0
arm64                 randconfig-002-20250919    gcc-11.5.0
arm64                 randconfig-002-20250919    gcc-8.5.0
arm64                 randconfig-003-20250919    gcc-11.5.0
arm64                 randconfig-003-20250919    gcc-12.5.0
arm64                 randconfig-004-20250919    gcc-11.5.0
csky                              allnoconfig    clang-22
csky                                defconfig    clang-19
csky                  randconfig-001-20250919    clang-22
csky                  randconfig-001-20250919    gcc-14.3.0
csky                  randconfig-002-20250919    clang-22
csky                  randconfig-002-20250919    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250919    clang-22
hexagon               randconfig-002-20250919    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250919    clang-20
i386        buildonly-randconfig-001-20250919    gcc-14
i386        buildonly-randconfig-002-20250919    gcc-14
i386        buildonly-randconfig-003-20250919    gcc-14
i386        buildonly-randconfig-004-20250919    gcc-14
i386        buildonly-randconfig-005-20250919    clang-20
i386        buildonly-randconfig-005-20250919    gcc-14
i386        buildonly-randconfig-006-20250919    clang-20
i386        buildonly-randconfig-006-20250919    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20250919    gcc-14
i386                  randconfig-002-20250919    gcc-14
i386                  randconfig-003-20250919    gcc-14
i386                  randconfig-004-20250919    gcc-14
i386                  randconfig-005-20250919    gcc-14
i386                  randconfig-006-20250919    gcc-14
i386                  randconfig-007-20250919    gcc-14
i386                  randconfig-011-20250919    clang-20
i386                  randconfig-012-20250919    clang-20
i386                  randconfig-013-20250919    clang-20
i386                  randconfig-014-20250919    clang-20
i386                  randconfig-015-20250919    clang-20
i386                  randconfig-016-20250919    clang-20
i386                  randconfig-017-20250919    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250919    clang-22
loongarch             randconfig-001-20250919    gcc-15.1.0
loongarch             randconfig-002-20250919    clang-22
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
mips                         db1xxx_defconfig    gcc-15.1.0
nios2                         3c120_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250919    clang-22
nios2                 randconfig-001-20250919    gcc-10.5.0
nios2                 randconfig-002-20250919    clang-22
nios2                 randconfig-002-20250919    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250919    clang-22
parisc                randconfig-001-20250919    gcc-15.1.0
parisc                randconfig-002-20250919    clang-22
parisc                randconfig-002-20250919    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                    ge_imp3a_defconfig    gcc-15.1.0
powerpc                 linkstation_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250919    clang-22
powerpc               randconfig-001-20250919    gcc-10.5.0
powerpc               randconfig-002-20250919    clang-22
powerpc               randconfig-002-20250919    gcc-8.5.0
powerpc               randconfig-003-20250919    clang-18
powerpc               randconfig-003-20250919    clang-22
powerpc64             randconfig-001-20250919    clang-22
powerpc64             randconfig-001-20250919    gcc-8.5.0
powerpc64             randconfig-002-20250919    clang-22
powerpc64             randconfig-002-20250919    gcc-13.4.0
powerpc64             randconfig-003-20250919    clang-18
powerpc64             randconfig-003-20250919    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20250919    gcc-10.5.0
riscv                 randconfig-002-20250919    gcc-10.5.0
riscv                 randconfig-002-20250919    gcc-13.4.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20250919    gcc-10.5.0
s390                  randconfig-001-20250919    gcc-8.5.0
s390                  randconfig-002-20250919    gcc-10.5.0
s390                  randconfig-002-20250919    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20250919    gcc-10.5.0
sh                    randconfig-001-20250919    gcc-12.5.0
sh                    randconfig-002-20250919    gcc-10.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250919    gcc-10.5.0
sparc                 randconfig-001-20250919    gcc-14.3.0
sparc                 randconfig-002-20250919    gcc-10.5.0
sparc                 randconfig-002-20250919    gcc-8.5.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20250919    clang-22
sparc64               randconfig-001-20250919    gcc-10.5.0
sparc64               randconfig-002-20250919    gcc-10.5.0
sparc64               randconfig-002-20250919    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250919    gcc-10.5.0
um                    randconfig-001-20250919    gcc-12
um                    randconfig-002-20250919    clang-22
um                    randconfig-002-20250919    gcc-10.5.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250919    clang-20
x86_64      buildonly-randconfig-002-20250919    clang-20
x86_64      buildonly-randconfig-002-20250919    gcc-14
x86_64      buildonly-randconfig-003-20250919    clang-20
x86_64      buildonly-randconfig-003-20250919    gcc-14
x86_64      buildonly-randconfig-004-20250919    clang-20
x86_64      buildonly-randconfig-005-20250919    clang-20
x86_64      buildonly-randconfig-006-20250919    clang-20
x86_64                              defconfig    clang-20
x86_64                randconfig-001-20250919    clang-20
x86_64                randconfig-002-20250919    clang-20
x86_64                randconfig-003-20250919    clang-20
x86_64                randconfig-004-20250919    clang-20
x86_64                randconfig-005-20250919    clang-20
x86_64                randconfig-006-20250919    clang-20
x86_64                randconfig-007-20250919    clang-20
x86_64                randconfig-008-20250919    clang-20
x86_64                randconfig-071-20250919    gcc-14
x86_64                randconfig-072-20250919    gcc-14
x86_64                randconfig-073-20250919    gcc-14
x86_64                randconfig-074-20250919    gcc-14
x86_64                randconfig-075-20250919    gcc-14
x86_64                randconfig-076-20250919    gcc-14
x86_64                randconfig-077-20250919    gcc-14
x86_64                randconfig-078-20250919    gcc-14
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250919    gcc-10.5.0
xtensa                randconfig-001-20250919    gcc-11.5.0
xtensa                randconfig-002-20250919    gcc-10.5.0
xtensa                randconfig-002-20250919    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-kernel+bounces-818459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1175B591FD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E069177316
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F87296BBC;
	Tue, 16 Sep 2025 09:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n1CrX92r"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D852868A6
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758014504; cv=none; b=HPZ6uoVA9t/3izKyNvn+r4JDeUXbFZKkm9D5snDeXSchxs/gJXdxs6Jcvu+qB6/33Tz8mbk7Kt3nlpE6RtHJmhkYvBGbpEVlJiW4LTLpQrmP9XWjo5r8hCiuMZGUiOU+nphX7+/mEjy9Y8qSDnrh0qQ7WCyqiCYALu4Im3Z2BDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758014504; c=relaxed/simple;
	bh=RGOb7BPOTwPjCF10FjENIBszTqrtBcIno6znrVy2x1A=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Vz2Cb9Xk1fVbRQITsbrDmc5eo5txUJrFs/J56z+uDXEJXwwOeQaTeHVZq1c/xlB0YV1Rhasf9G6Iebx0YjVRrzM5HJHF7jrOB6W/1u21HY9IWqQT/T3aYbQLmhTRODqWT7tvHj2EapiD7EzTvj8FeV8i9Y1z1FzD++67MO4P4IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n1CrX92r; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758014502; x=1789550502;
  h=date:from:to:cc:subject:message-id;
  bh=RGOb7BPOTwPjCF10FjENIBszTqrtBcIno6znrVy2x1A=;
  b=n1CrX92rO26fXNqHCIxfpWZCxWGqCC+BKfwEtsFaOIIICU3WROmtzryH
   uygkt9+6GblV5tphL8ZoHTZD5TTewmBl0IV4jltCt/WwQHWKpG1bsGA6E
   PGyyiugTnBNapT/MG5gmDqDCzmt0MftJk+KlwbVBOqsssRwbCE3Bah4Ky
   okzEQNtIxd1xixfuG8vXH8i+E1RytwqKE2bnY0dpTAx7gQOKndKoHYIb1
   +xHEyogN/mrrikpEBobZi6foIMjY3wJ7RU75wilwBIslYjmF54VKfFZ3Z
   NCYEn0bpCxsYJcWFWetfl4UeUXEdkFOsRn5nRBnjkwt3VL0iJ+8VTUuuz
   A==;
X-CSE-ConnectionGUID: SOzynS48T5exumxELMBXcQ==
X-CSE-MsgGUID: nAtCBFZRRYObbh3VRL4ifg==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="70968942"
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; 
   d="scan'208";a="70968942"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 02:21:42 -0700
X-CSE-ConnectionGUID: rgFJZz8KQb+SLvT55Ca/gQ==
X-CSE-MsgGUID: j17fdZGVQ+W5uYRRN95gMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; 
   d="scan'208";a="175305666"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 16 Sep 2025 02:21:41 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uyRsY-00009D-28;
	Tue, 16 Sep 2025 09:21:38 +0000
Date: Tue, 16 Sep 2025 17:21:26 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2025.09.11a] BUILD SUCCESS
 e30261b671ef740eef6a3501666a4e2104569de1
Message-ID: <202509161704.apmGeJPE-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2025.09.11a
branch HEAD: e30261b671ef740eef6a3501666a4e2104569de1  torture: Record compiler version in cc-version.txt

elapsed time: 1211m

configs tested: 241
configs skipped: 6

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
arc                   randconfig-001-20250916    clang-22
arc                   randconfig-001-20250916    gcc-8.5.0
arc                   randconfig-002-20250916    clang-22
arc                   randconfig-002-20250916    gcc-8.5.0
arc                           tb10x_defconfig    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                            mmp2_defconfig    gcc-15.1.0
arm                       netwinder_defconfig    gcc-15.1.0
arm                          pxa910_defconfig    gcc-15.1.0
arm                   randconfig-001-20250916    clang-22
arm                   randconfig-001-20250916    gcc-11.5.0
arm                   randconfig-002-20250916    clang-22
arm                   randconfig-003-20250916    clang-22
arm                   randconfig-003-20250916    gcc-12.5.0
arm                   randconfig-004-20250916    clang-22
arm                           sama7_defconfig    gcc-15.1.0
arm                        spear6xx_defconfig    gcc-15.1.0
arm                         wpcm450_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250916    clang-18
arm64                 randconfig-001-20250916    clang-22
arm64                 randconfig-002-20250916    clang-22
arm64                 randconfig-003-20250916    clang-22
arm64                 randconfig-004-20250916    clang-22
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250916    clang-22
csky                  randconfig-001-20250916    gcc-14.3.0
csky                  randconfig-002-20250916    clang-22
csky                  randconfig-002-20250916    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250916    clang-22
hexagon               randconfig-002-20250916    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20250916    clang-20
i386        buildonly-randconfig-001-20250916    gcc-14
i386        buildonly-randconfig-002-20250916    clang-20
i386        buildonly-randconfig-002-20250916    gcc-14
i386        buildonly-randconfig-003-20250916    clang-20
i386        buildonly-randconfig-004-20250916    clang-20
i386        buildonly-randconfig-004-20250916    gcc-14
i386        buildonly-randconfig-005-20250916    clang-20
i386        buildonly-randconfig-005-20250916    gcc-14
i386        buildonly-randconfig-006-20250916    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250916    clang-20
i386                  randconfig-002-20250916    clang-20
i386                  randconfig-003-20250916    clang-20
i386                  randconfig-004-20250916    clang-20
i386                  randconfig-005-20250916    clang-20
i386                  randconfig-006-20250916    clang-20
i386                  randconfig-007-20250916    clang-20
i386                  randconfig-011-20250916    gcc-14
i386                  randconfig-012-20250916    gcc-14
i386                  randconfig-013-20250916    gcc-14
i386                  randconfig-014-20250916    gcc-14
i386                  randconfig-015-20250916    gcc-14
i386                  randconfig-016-20250916    gcc-14
i386                  randconfig-017-20250916    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250916    clang-18
loongarch             randconfig-001-20250916    clang-22
loongarch             randconfig-002-20250916    clang-22
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                            q40_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          eyeq5_defconfig    gcc-15.1.0
mips                           ip32_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250916    clang-22
nios2                 randconfig-001-20250916    gcc-11.5.0
nios2                 randconfig-002-20250916    clang-22
nios2                 randconfig-002-20250916    gcc-8.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250916    clang-22
parisc                randconfig-001-20250916    gcc-9.5.0
parisc                randconfig-002-20250916    clang-22
parisc                randconfig-002-20250916    gcc-13.4.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc               randconfig-001-20250916    clang-16
powerpc               randconfig-001-20250916    clang-22
powerpc               randconfig-002-20250916    clang-22
powerpc               randconfig-003-20250916    clang-22
powerpc64             randconfig-001-20250916    clang-22
powerpc64             randconfig-002-20250916    clang-22
powerpc64             randconfig-002-20250916    gcc-8.5.0
powerpc64             randconfig-003-20250916    clang-22
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20250916    clang-22
riscv                 randconfig-001-20250916    gcc-15.1.0
riscv                 randconfig-002-20250916    gcc-10.5.0
riscv                 randconfig-002-20250916    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                          debug_defconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20250916    gcc-13.4.0
s390                  randconfig-001-20250916    gcc-15.1.0
s390                  randconfig-002-20250916    gcc-15.1.0
s390                  randconfig-002-20250916    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20250916    gcc-15.1.0
sh                    randconfig-002-20250916    gcc-15.1.0
sh                           se7619_defconfig    gcc-15.1.0
sh                           se7721_defconfig    gcc-15.1.0
sparc                            alldefconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250916    gcc-15.1.0
sparc                 randconfig-001-20250916    gcc-8.5.0
sparc                 randconfig-002-20250916    gcc-15.1.0
sparc                 randconfig-002-20250916    gcc-8.5.0
sparc                       sparc32_defconfig    gcc-15.1.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20250916    gcc-11.5.0
sparc64               randconfig-001-20250916    gcc-15.1.0
sparc64               randconfig-002-20250916    clang-22
sparc64               randconfig-002-20250916    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250916    gcc-14
um                    randconfig-001-20250916    gcc-15.1.0
um                    randconfig-002-20250916    clang-19
um                    randconfig-002-20250916    gcc-15.1.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250915    clang-20
x86_64      buildonly-randconfig-001-20250916    clang-20
x86_64      buildonly-randconfig-002-20250915    gcc-12
x86_64      buildonly-randconfig-002-20250916    clang-20
x86_64      buildonly-randconfig-003-20250915    gcc-14
x86_64      buildonly-randconfig-003-20250916    clang-20
x86_64      buildonly-randconfig-004-20250915    clang-20
x86_64      buildonly-randconfig-004-20250916    clang-20
x86_64      buildonly-randconfig-005-20250915    clang-20
x86_64      buildonly-randconfig-005-20250916    clang-20
x86_64      buildonly-randconfig-006-20250915    gcc-14
x86_64      buildonly-randconfig-006-20250916    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250916    clang-20
x86_64                randconfig-002-20250916    clang-20
x86_64                randconfig-003-20250916    clang-20
x86_64                randconfig-004-20250916    clang-20
x86_64                randconfig-005-20250916    clang-20
x86_64                randconfig-006-20250916    clang-20
x86_64                randconfig-007-20250916    clang-20
x86_64                randconfig-008-20250916    clang-20
x86_64                randconfig-071-20250916    gcc-14
x86_64                randconfig-072-20250916    gcc-14
x86_64                randconfig-073-20250916    gcc-14
x86_64                randconfig-074-20250916    gcc-14
x86_64                randconfig-075-20250916    gcc-14
x86_64                randconfig-076-20250916    gcc-14
x86_64                randconfig-077-20250916    gcc-14
x86_64                randconfig-078-20250916    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250916    gcc-15.1.0
xtensa                randconfig-001-20250916    gcc-8.5.0
xtensa                randconfig-002-20250916    gcc-15.1.0
xtensa                randconfig-002-20250916    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


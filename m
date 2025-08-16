Return-Path: <linux-kernel+bounces-771705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C49B1B28A8A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 06:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4A7AC669A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 04:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E491CAA65;
	Sat, 16 Aug 2025 04:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GTOmmidf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C069E1C5496
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 04:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755318401; cv=none; b=ZxZQabf0nd5ROhdWfByruQP9LL2AUCDoRVaIJbD6pw+WTYMVJVQYW6FTkIbGsT+Xlpt8HdJtzCsJogu2QwXjrJJBg+STp2WQ6XCNQ19YXWHUZ31rg+X3+C+xmGtERagYfRf6w94/qGC3Oi1s/T3ATHlcbZTGiiAXYhl/5GSLv2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755318401; c=relaxed/simple;
	bh=lPYzgHqneTPGpOmELfbMjIqXvFeAATbu/hvQiQvTepU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=en01LswA+khuwByAWqUBdqiCn2i+VEK7in3LOXSNfA+N14kF25m7ZE/DgbBOVer6k9t4qJkHEb01LpftF/lnVANtMLZ/0VDUBG1cf25at34RKAQ2oVrhd0dJYmCv8K52ZsK1Rsu80VyKSZOU38q861II+yIPIINFDBfqViM2nIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GTOmmidf; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755318400; x=1786854400;
  h=date:from:to:cc:subject:message-id;
  bh=lPYzgHqneTPGpOmELfbMjIqXvFeAATbu/hvQiQvTepU=;
  b=GTOmmidfKMZwu3eP4jT+oJmjjGnXBLqyoVJhSluuF1RAd2CrTXRZkN+S
   zHjybvQI8V/UXhwJFLKs4ag3TXatjgODw1FUtlHHAcJyhneNkMyf1MumE
   KJGPJd7btln08Z9DkkOQ53PysyP/xFfvWWWnBO0E4bmSNhkFXagZrXqlT
   jM1pkOV+mSdF5Xw5XA9mvwujmlSPjLaM+5RzJ6CsxWNt+ImaBOPcK+K13
   WfKDZo7+aaX9fiq8Cu5e9EydOfKnF/hFJKxab++KjZ9PGznNPPgTbhMHo
   N3tMyic2Oyr5+Y1U7s87okEkEXlT5tX048/qm+8CPhcq/0HMW+E36jrie
   A==;
X-CSE-ConnectionGUID: bJY3u6vCTk6oHD91qKm6IA==
X-CSE-MsgGUID: oZ8tAjfZTEaZZC4gJaewOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="45204675"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="45204675"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 21:26:39 -0700
X-CSE-ConnectionGUID: mSils05PTLSFRD4/0LTZtQ==
X-CSE-MsgGUID: 4kZSrzwfRsOSRy5l+gDF/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="171280124"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 15 Aug 2025 21:26:38 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1un8V2-000Cac-0K;
	Sat, 16 Aug 2025 04:26:36 +0000
Date: Sat, 16 Aug 2025 12:26:09 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 a1586c248c973b493ca682ae5d48e5d0acbce596
Message-ID: <202508161202.YdNdiOJi-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: a1586c248c973b493ca682ae5d48e5d0acbce596  Merge branch into tip/master: 'x86/entry'

elapsed time: 1269m

configs tested: 128
configs skipped: 6

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
arc                   randconfig-001-20250815    gcc-8.5.0
arc                   randconfig-002-20250815    gcc-9.5.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                      jornada720_defconfig    clang-22
arm                         lpc18xx_defconfig    clang-22
arm                            mmp2_defconfig    gcc-15.1.0
arm                          pxa168_defconfig    clang-19
arm                   randconfig-001-20250815    clang-16
arm                   randconfig-002-20250815    clang-18
arm                   randconfig-003-20250815    gcc-14.3.0
arm                   randconfig-004-20250815    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250815    gcc-8.5.0
arm64                 randconfig-002-20250815    gcc-8.5.0
arm64                 randconfig-003-20250815    clang-22
arm64                 randconfig-004-20250815    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250815    gcc-15.1.0
csky                  randconfig-002-20250815    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250815    clang-22
hexagon               randconfig-002-20250815    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250815    gcc-12
i386        buildonly-randconfig-002-20250815    clang-20
i386        buildonly-randconfig-003-20250815    clang-20
i386        buildonly-randconfig-004-20250815    clang-20
i386        buildonly-randconfig-005-20250815    clang-20
i386        buildonly-randconfig-006-20250815    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250815    clang-22
loongarch             randconfig-002-20250815    clang-20
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                        m5272c3_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250815    gcc-11.5.0
nios2                 randconfig-002-20250815    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250815    gcc-8.5.0
parisc                randconfig-002-20250815    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250815    gcc-11.5.0
powerpc               randconfig-002-20250815    clang-19
powerpc               randconfig-003-20250815    gcc-11.5.0
powerpc64             randconfig-001-20250815    gcc-14.3.0
powerpc64             randconfig-002-20250815    gcc-10.5.0
powerpc64             randconfig-003-20250815    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250815    gcc-12.5.0
riscv                 randconfig-002-20250815    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250815    gcc-8.5.0
s390                  randconfig-002-20250815    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250815    gcc-11.5.0
sh                    randconfig-002-20250815    gcc-12.5.0
sh                          rsk7203_defconfig    gcc-15.1.0
sh                  sh7785lcr_32bit_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250815    gcc-11.5.0
sparc                 randconfig-002-20250815    gcc-13.4.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250815    clang-22
sparc64               randconfig-002-20250815    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250815    gcc-12
um                    randconfig-002-20250815    clang-19
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250815    clang-20
x86_64      buildonly-randconfig-002-20250815    gcc-12
x86_64      buildonly-randconfig-003-20250815    gcc-12
x86_64      buildonly-randconfig-004-20250815    clang-20
x86_64      buildonly-randconfig-005-20250815    clang-20
x86_64      buildonly-randconfig-006-20250815    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250815    gcc-8.5.0
xtensa                randconfig-002-20250815    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


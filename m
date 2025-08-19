Return-Path: <linux-kernel+bounces-774629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 917E3B2B537
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 02:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 205B87ACA11
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 00:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0CAD515;
	Tue, 19 Aug 2025 00:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HZEx7mDH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F67FAD5A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 00:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755562494; cv=none; b=LZy3xANrJYVWHzwMDCOzaI/Ll2YJlhYFJZGYOu1iNQp1KJ3Gqg3h27rOAzzoehNoOxoWT0gaJZec14cSgQ/aTxlyV6gcUWCpIZzUNyygj6En+cxYCW/x5YylDLYe6NP99aWIlgWGEsq7BxT6StJCwOkjkTh06F91Takvqu5ZJhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755562494; c=relaxed/simple;
	bh=2FNOEqL24cUPIHxASfUEnyAp4xynPEGHycQ4mZYDTUE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fpkcVWLAKxc0UQ8ciJdprbmppw2Wk3nocj4/rT90iENZmrBMvZAj9DQh3X2Czn1n0GZsGnqx7QWrR0uYVODRQ3EDOXbjqccWwGHsAo0NKm/x6f9QLbQe9jSnSpM9QTe1233cDzp3cnO0Q48OMk9LKa6Y9g14sUtts/Wd7oM1D+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HZEx7mDH; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755562492; x=1787098492;
  h=date:from:to:cc:subject:message-id;
  bh=2FNOEqL24cUPIHxASfUEnyAp4xynPEGHycQ4mZYDTUE=;
  b=HZEx7mDHhi89oJBtfjmZOVSjKtf3wg9TNnsiHhd5BRc8qP4qDsnc0gxv
   yN9y7IzlYVy3wSt7ET/C1dhgLRUiuCfofSGAh+AULLcXM92DUsrLGDPuC
   eynYm5RxBQfrD7NWmA3h+Jbmf/sQSrLWhPBNJTKPegCAdqZ8fj26pBN5+
   TDgHMkzsTk/JQKSZ5qoWb7wSOX/SNi4J5IXWt0mlUAekmPATlFkNwPx/q
   nsXjmt3yqikRFmwNjKIYTsh5lO8Bva2szBQ+gmSYzl35h6rRDvFG/g+fh
   L6LWpqVtOYb44UIbvjLADZv7ce8FmYqaB/bMnJHcTcA9GncFLFWfS3bWg
   w==;
X-CSE-ConnectionGUID: 4YUGeMPBS+6uIrzS/Hmo/A==
X-CSE-MsgGUID: PpPaxToGR8KFLIs38L/SAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="68506099"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="68506099"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 17:14:51 -0700
X-CSE-ConnectionGUID: ZCyN1WrBQNSLSnGm+xqZsw==
X-CSE-MsgGUID: eviyAJXxSm2idSNdxYM0/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="198568699"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 18 Aug 2025 17:14:51 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uo9zW-000GKH-0N;
	Tue, 19 Aug 2025 00:14:24 +0000
Date: Tue, 19 Aug 2025 08:12:32 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 7386dda6936321d9118b8fe726aebdef2f339cd4
Message-ID: <202508190825.ntM0aVaf-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 7386dda6936321d9118b8fe726aebdef2f339cd4  Merge branch into tip/master: 'x86/entry'

elapsed time: 926m

configs tested: 105
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250818    gcc-13.4.0
arc                   randconfig-002-20250818    gcc-12.5.0
arm                              allmodconfig    gcc-15.1.0
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250818    gcc-12.5.0
arm                   randconfig-002-20250818    clang-22
arm                   randconfig-003-20250818    clang-18
arm                   randconfig-004-20250818    gcc-10.5.0
arm64                            allmodconfig    clang-19
arm64                 randconfig-001-20250818    gcc-11.5.0
arm64                 randconfig-002-20250818    gcc-12.5.0
arm64                 randconfig-003-20250818    gcc-8.5.0
arm64                 randconfig-004-20250818    clang-22
csky                  randconfig-001-20250818    gcc-15.1.0
csky                  randconfig-002-20250818    gcc-9.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250818    clang-22
hexagon               randconfig-002-20250818    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250818    clang-20
i386        buildonly-randconfig-002-20250818    clang-20
i386        buildonly-randconfig-003-20250818    gcc-12
i386        buildonly-randconfig-004-20250818    clang-20
i386        buildonly-randconfig-005-20250818    gcc-12
i386        buildonly-randconfig-006-20250818    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch             randconfig-001-20250818    gcc-15.1.0
loongarch             randconfig-002-20250818    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250818    gcc-9.5.0
nios2                 randconfig-002-20250818    gcc-9.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250818    gcc-10.5.0
parisc                randconfig-002-20250818    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250818    gcc-8.5.0
powerpc               randconfig-002-20250818    gcc-9.5.0
powerpc               randconfig-003-20250818    clang-22
powerpc64             randconfig-001-20250818    gcc-8.5.0
powerpc64             randconfig-002-20250818    clang-17
powerpc64             randconfig-003-20250818    gcc-10.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250818    gcc-10.5.0
riscv                 randconfig-002-20250818    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250818    clang-22
s390                  randconfig-002-20250818    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250818    gcc-12.5.0
sh                    randconfig-002-20250818    gcc-13.4.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250818    gcc-12.5.0
sparc                 randconfig-002-20250818    gcc-15.1.0
sparc64               randconfig-001-20250818    clang-22
sparc64               randconfig-002-20250818    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                    randconfig-001-20250818    gcc-11
um                    randconfig-002-20250818    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250818    gcc-12
x86_64      buildonly-randconfig-002-20250818    gcc-12
x86_64      buildonly-randconfig-003-20250818    gcc-12
x86_64      buildonly-randconfig-004-20250818    gcc-12
x86_64      buildonly-randconfig-005-20250818    gcc-12
x86_64      buildonly-randconfig-006-20250818    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250818    gcc-14.3.0
xtensa                randconfig-002-20250818    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


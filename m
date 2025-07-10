Return-Path: <linux-kernel+bounces-725969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AC4B0061A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75B26644587
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FC7274B36;
	Thu, 10 Jul 2025 15:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k9Ld0SY3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31C8277C88
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752160166; cv=none; b=UTHyEtzG9OWjN+q6T1yFMrxQX73JORjGXXB6CJaZ8R53ji3qiVnYr6nkh++RdpueRFeLMQGEziVqButACqN7K0eCiyqLR9YPo6ZVW28r2LO/CPUEjKfv9vdDMMAfrL11PwpeR2PymR1kR/UzYYW8WTuhE5h4xXCsZNUDs5LrO9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752160166; c=relaxed/simple;
	bh=iAoWwzpRyIwTZ+dvJmnm5hRe+R23bHIeRbPZXrMzuqY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=h9QRdkWs+zz3xT7fszVo+kelJfQKykmOHBO5V4W8A0MXUefcMzXOMmxJrj7/zFL7kYnt43A+kKLFQpyppun+qG2dnP3O0BDO0+X/z6AEKPGD5x8Qoqx6LwaKqL8ZJB7dpZ5BRGnKqaI1kqbFoXaVL5Gs8T3UMoKbzKoopdjcEb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k9Ld0SY3; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752160165; x=1783696165;
  h=date:from:to:cc:subject:message-id;
  bh=iAoWwzpRyIwTZ+dvJmnm5hRe+R23bHIeRbPZXrMzuqY=;
  b=k9Ld0SY3/z5rqhgnZ2Q4OEh+mDEBIIPR/M4X43Tyy7v/d963RgoBY074
   7pNq4JBK4Jf4vVvUfPaJGilKcu0BQbFkiGc/Qx0Fnrez87313C74v8C6/
   7JfT7hzxEtLRRWPxPLduQqGRZ6ClBB78Mtv6y7fAwXKi97uU22XEMI6e+
   +utIjBNzNLi1r6AEQnzjQY5MjIouoUlvew3trHBBD7/Yrhx+VgPOVWQz8
   RR9lsteEWil9d4kcLmE4w1RI1LSMMJL778KtrFufLDwYxdgDD8NPtH3+T
   J2566VKCTeW1SHYbxS+Ppein3jUIcs7qJcg2iNgjKYG5D6C6IHIleL2jt
   Q==;
X-CSE-ConnectionGUID: HORUuhLySjKcaY8f32WAPg==
X-CSE-MsgGUID: qsFX8wvES9qqEmAYhETQBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54296729"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="54296729"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 08:09:24 -0700
X-CSE-ConnectionGUID: QYCHx/ibRqGJ1Ug4jMldow==
X-CSE-MsgGUID: 8oikqzVkQUuHM1MMDOO8ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="156600348"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 10 Jul 2025 08:09:24 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uZstl-0005AP-0K;
	Thu, 10 Jul 2025 15:09:21 +0000
Date: Thu, 10 Jul 2025 23:09:19 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/tdx] BUILD SUCCESS
 98de0c686fe4041c57170478d865a482760cc7d9
Message-ID: <202507102307.NqZ1BUYV-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/tdx
branch HEAD: 98de0c686fe4041c57170478d865a482760cc7d9  MAINTAINERS: Add KVM mail list to the TDX entry

elapsed time: 1450m

configs tested: 94
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250710    gcc-15.1.0
arc                   randconfig-002-20250710    gcc-12.4.0
arm                   randconfig-001-20250710    gcc-8.5.0
arm                   randconfig-002-20250710    clang-21
arm                   randconfig-003-20250710    clang-21
arm                   randconfig-004-20250710    gcc-8.5.0
arm64                 randconfig-001-20250710    clang-21
arm64                 randconfig-002-20250710    clang-21
arm64                 randconfig-003-20250710    gcc-8.5.0
arm64                 randconfig-004-20250710    clang-21
csky                  randconfig-001-20250710    gcc-15.1.0
csky                  randconfig-002-20250710    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250710    clang-21
hexagon               randconfig-002-20250710    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386        buildonly-randconfig-001-20250710    gcc-12
i386        buildonly-randconfig-002-20250710    gcc-12
i386        buildonly-randconfig-003-20250710    clang-20
i386        buildonly-randconfig-004-20250710    gcc-11
i386        buildonly-randconfig-005-20250710    clang-20
i386        buildonly-randconfig-006-20250710    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch             randconfig-001-20250710    gcc-14.3.0
loongarch             randconfig-002-20250710    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250710    gcc-9.3.0
nios2                 randconfig-002-20250710    gcc-12.4.0
openrisc                          allnoconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250710    gcc-8.5.0
parisc                randconfig-002-20250710    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20250710    gcc-12.4.0
powerpc               randconfig-002-20250710    gcc-9.3.0
powerpc               randconfig-003-20250710    gcc-8.5.0
powerpc64             randconfig-001-20250710    gcc-11.5.0
powerpc64             randconfig-002-20250710    clang-17
powerpc64             randconfig-003-20250710    gcc-14.3.0
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250710    gcc-15.1.0
riscv                 randconfig-002-20250710    gcc-10.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250710    gcc-14.3.0
s390                  randconfig-002-20250710    clang-17
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250710    gcc-15.1.0
sh                    randconfig-002-20250710    gcc-13.4.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250710    gcc-13.4.0
sparc                 randconfig-002-20250710    gcc-14.3.0
sparc64               randconfig-001-20250710    gcc-8.5.0
sparc64               randconfig-002-20250710    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250710    gcc-11
um                    randconfig-002-20250710    clang-16
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250710    gcc-12
x86_64      buildonly-randconfig-002-20250710    gcc-12
x86_64      buildonly-randconfig-003-20250710    gcc-12
x86_64      buildonly-randconfig-004-20250710    clang-20
x86_64      buildonly-randconfig-005-20250710    clang-20
x86_64      buildonly-randconfig-006-20250710    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250710    gcc-12.4.0
xtensa                randconfig-002-20250710    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


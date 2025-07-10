Return-Path: <linux-kernel+bounces-725564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 162A1B000CE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E495F189939E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505A6248F77;
	Thu, 10 Jul 2025 11:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ek8djSYi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609652222AB
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 11:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752148203; cv=none; b=AoIMFT+0K9yWpKEy5Ga0WB39IK3PoO7TBpzmiynSyaiep8m+MEGBGCzAXffBw+tqY8qoaVF8wEMhUtWJq5KPsBvISix+Evnug43l23iOT1bJAtZ0tQgQ3S5QwoOf4Fqw6sY5g2L6Ejbvrl38juZY3BY0mks2xZzpaGzXUtM+ZVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752148203; c=relaxed/simple;
	bh=G1B/pAqUhAWD/fOOWAiTS6u4uI6MQwFwPhF11GKJt6E=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ihQTvcYmIfoDRDxt5HAJjm9knMxLqpetO7BOPzHfJliOI/LzKnK/sYn8bcsXw3TTex86DozAgHr0rZxrCZ5NhPNDjHJ4k0qz9HBgBROeqz7iyR4pcpAhxd/3rcPPtS0ypHuVhkQHWojiecdEenX3pLQscYlMZ0mDlarUk0WnuaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ek8djSYi; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752148201; x=1783684201;
  h=date:from:to:cc:subject:message-id;
  bh=G1B/pAqUhAWD/fOOWAiTS6u4uI6MQwFwPhF11GKJt6E=;
  b=Ek8djSYiZjRMJjqDfK3JNsueDSomeOuaRrK1NvUDd2eutx/oJUnjI/62
   1Wmo/zRsT67kaNP2ZtuV/xaeoI975rPeYrP1Z2PZQZKwE66synot1DF1H
   jhHGgG009aIJAqPvHGBXE/0kXw38xqLAcB2dHit9AaRnZQs54yz2n16uT
   cEwvNrafzbNppkenQNEEZI0qyozO6yuikTDpTLzG8h5B0jC6qfjmPNUbS
   8XewWgUkd4BbqrtZnzpM+AH2zrXtJb+ejono9XgHFyZTW6FsvLE5gvrci
   GDEShUPiaZ44ualFI0uf6dVAstGMn29aPemYIdqbf6eXQB2Yu+r4YAC7V
   Q==;
X-CSE-ConnectionGUID: aShEtoIcQDa1V76JFMyiMA==
X-CSE-MsgGUID: 2QMCNRluSkyJYTiVeDsQpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54399333"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="54399333"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 04:50:01 -0700
X-CSE-ConnectionGUID: k/zIS884TCumUYt1swisEA==
X-CSE-MsgGUID: zjvNXXtpT7qFpEdgZIXoIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="155825064"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 10 Jul 2025 04:50:00 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uZpmn-0004zD-1h;
	Thu, 10 Jul 2025 11:49:57 +0000
Date: Thu, 10 Jul 2025 19:49:40 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:tip/urgent] BUILD SUCCESS
 717b7f7d6bff5627dc5a261a1e6d4806cfe3dad5
Message-ID: <202507101928.f5TLzuvT-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tip/urgent
branch HEAD: 717b7f7d6bff5627dc5a261a1e6d4806cfe3dad5  Merge x86/urgent into tip/urgent

elapsed time: 1445m

configs tested: 92
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250709    gcc-8.5.0
arc                   randconfig-002-20250709    gcc-11.5.0
arm                   randconfig-001-20250709    gcc-12.4.0
arm                   randconfig-002-20250709    gcc-10.5.0
arm                   randconfig-003-20250709    clang-21
arm                   randconfig-004-20250709    clang-21
arm64                 randconfig-001-20250709    clang-21
arm64                 randconfig-002-20250709    gcc-15.1.0
arm64                 randconfig-003-20250709    clang-21
arm64                 randconfig-004-20250709    gcc-10.5.0
csky                  randconfig-001-20250709    gcc-15.1.0
csky                  randconfig-002-20250709    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250709    clang-19
hexagon               randconfig-002-20250709    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386        buildonly-randconfig-001-20250709    gcc-12
i386        buildonly-randconfig-002-20250709    clang-20
i386        buildonly-randconfig-003-20250709    clang-20
i386        buildonly-randconfig-004-20250709    clang-20
i386        buildonly-randconfig-005-20250709    gcc-12
i386        buildonly-randconfig-006-20250709    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch             randconfig-001-20250709    gcc-15.1.0
loongarch             randconfig-002-20250709    gcc-12.4.0
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
nios2                 randconfig-001-20250709    gcc-14.2.0
nios2                 randconfig-002-20250709    gcc-14.2.0
openrisc                          allnoconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250709    gcc-15.1.0
parisc                randconfig-002-20250709    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20250709    gcc-8.5.0
powerpc               randconfig-002-20250709    clang-21
powerpc               randconfig-003-20250709    clang-21
powerpc64             randconfig-001-20250709    gcc-10.5.0
powerpc64             randconfig-002-20250709    gcc-10.5.0
powerpc64             randconfig-003-20250709    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250709    gcc-10.5.0
riscv                 randconfig-002-20250709    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250709    clang-17
s390                  randconfig-002-20250709    clang-21
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250709    gcc-10.5.0
sh                    randconfig-002-20250709    gcc-14.3.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250709    gcc-15.1.0
sparc                 randconfig-002-20250709    gcc-10.3.0
sparc64               randconfig-001-20250709    clang-21
sparc64               randconfig-002-20250709    clang-21
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250709    clang-17
um                    randconfig-002-20250709    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250709    gcc-12
x86_64      buildonly-randconfig-002-20250709    clang-20
x86_64      buildonly-randconfig-003-20250709    gcc-12
x86_64      buildonly-randconfig-004-20250709    gcc-12
x86_64      buildonly-randconfig-005-20250709    clang-20
x86_64      buildonly-randconfig-006-20250709    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250709    gcc-8.5.0
xtensa                randconfig-002-20250709    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


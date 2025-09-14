Return-Path: <linux-kernel+bounces-815523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F079B567B5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 12:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B21B33A5D62
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 10:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB0E2153C1;
	Sun, 14 Sep 2025 10:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GDNowZ0a"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FBE3BB48
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 10:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757845039; cv=none; b=N1NAn11vfblAPbStxNHMiCGwpP7sIiU97dIuGL2lA2BoppY/Qma9AVtpCradsYCxb9bZyUmpl8CWEi2ESFHDPNORuAuPhBk6pSk4i8irN8FgF+VrtHn5cLOo61mbAJvhbq0VemuF6qvjTeqBizD5hF9qIGa95PwTarblixrdXfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757845039; c=relaxed/simple;
	bh=Q4n9k8QPbUUxkfeCMolOgYPKLlTzxWI8JIocK6auq+E=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kcYm7U54Iu76hoV3LKpquz7crsHMcCI2husv4NPODQ/E2+xvl2kZZDtKL7BnGKlydmcMqGbuxml8qovUBo8L9YuLWHKnETTM318SoCWVP3b9BTMlnWL0b5djanFL2GhYf6umX4ygYLI2LDC+BqClSjC1LuS50g204QHZRZ+srVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GDNowZ0a; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757845038; x=1789381038;
  h=date:from:to:cc:subject:message-id;
  bh=Q4n9k8QPbUUxkfeCMolOgYPKLlTzxWI8JIocK6auq+E=;
  b=GDNowZ0a1yWzVa2GAH5R8Oleq/nuW7bASdy9w2SvBErbDGd5+9IBIUoY
   XWgrtWzEpvW8H9euLvSOa9D18eh46CCrZfcJfKgE86toR3cDzO3estznD
   ZmXRRXhRrM6LSs4jKn7Wr4ULScdNg7NJdG+wqfWGoyw9nIxwjIuguNyTc
   FiIjN5o3DWg2ZNigJvPZGh3lvwjaoiC4ZsDBqbFUDUYh7/VIMjxzw9sJ7
   CtSFcu0Dqnu7cHRHrL0eATlUX0fQ4sjhV+y7VweswjC3pGIWCuGJS1ozF
   VepHIJvmsmNotfGyLxpeBxTisyhhJQw7nfA49/chcrHmNuguoK9Q2MH/D
   A==;
X-CSE-ConnectionGUID: aCe0zpIiQdq00d/MaageXg==
X-CSE-MsgGUID: fXggJSQuSuOchnKxzclMRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11552"; a="70377837"
X-IronPort-AV: E=Sophos;i="6.18,263,1751266800"; 
   d="scan'208";a="70377837"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2025 03:17:17 -0700
X-CSE-ConnectionGUID: 6a87UCSuQ66uRIOAgsgfVw==
X-CSE-MsgGUID: ObtJZEzLTnCAOyOrQH9jcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,263,1751266800"; 
   d="scan'208";a="205353740"
Received: from lkp-server02.sh.intel.com (HELO eb5fdfb2a9b7) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 14 Sep 2025 03:17:15 -0700
Received: from kbuild by eb5fdfb2a9b7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uxjnF-0002Ji-0m;
	Sun, 14 Sep 2025 10:17:13 +0000
Date: Sun, 14 Sep 2025 18:16:36 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/core] BUILD SUCCESS
 1e587a7af2266551d83ecf381b457321d56aaa4e
Message-ID: <202509141826.7Pqs65qV-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
branch HEAD: 1e587a7af2266551d83ecf381b457321d56aaa4e  Merge branch 'x86/bugs' into x86/core, to resolve conflict

elapsed time: 1445m

configs tested: 131
configs skipped: 3

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
arc                   randconfig-001-20250913    gcc-10.5.0
arc                   randconfig-002-20250913    gcc-11.5.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                        clps711x_defconfig    clang-22
arm                                 defconfig    clang-22
arm                   randconfig-001-20250913    clang-20
arm                   randconfig-002-20250913    clang-22
arm                   randconfig-003-20250913    clang-22
arm                   randconfig-004-20250913    gcc-14.3.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250913    clang-22
arm64                 randconfig-002-20250913    gcc-14.3.0
arm64                 randconfig-003-20250913    clang-22
arm64                 randconfig-004-20250913    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250913    gcc-11.5.0
csky                  randconfig-002-20250913    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20250913    clang-16
hexagon               randconfig-002-20250913    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20250913    gcc-14
i386        buildonly-randconfig-002-20250913    clang-20
i386        buildonly-randconfig-003-20250913    clang-20
i386        buildonly-randconfig-004-20250913    clang-20
i386        buildonly-randconfig-005-20250913    clang-20
i386        buildonly-randconfig-006-20250913    gcc-14
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250913    clang-18
loongarch             randconfig-002-20250913    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                         3c120_defconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250913    gcc-8.5.0
nios2                 randconfig-002-20250913    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           alldefconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250913    gcc-12.5.0
parisc                randconfig-002-20250913    gcc-9.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                       eiger_defconfig    clang-22
powerpc               randconfig-001-20250913    gcc-8.5.0
powerpc               randconfig-002-20250913    clang-22
powerpc               randconfig-003-20250913    gcc-10.5.0
powerpc                     skiroot_defconfig    clang-22
powerpc64             randconfig-001-20250913    gcc-10.5.0
powerpc64             randconfig-002-20250913    clang-22
powerpc64             randconfig-003-20250913    gcc-8.5.0
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250913    gcc-13.4.0
riscv                 randconfig-002-20250913    clang-20
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250913    clang-22
s390                  randconfig-002-20250913    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250913    gcc-9.5.0
sh                    randconfig-002-20250913    gcc-14.3.0
sh                           se7724_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250913    gcc-15.1.0
sparc                 randconfig-002-20250913    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250913    gcc-8.5.0
sparc64               randconfig-002-20250913    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250913    gcc-14
um                    randconfig-002-20250913    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250913    clang-20
x86_64      buildonly-randconfig-002-20250913    gcc-14
x86_64      buildonly-randconfig-003-20250913    gcc-12
x86_64      buildonly-randconfig-004-20250913    gcc-14
x86_64      buildonly-randconfig-005-20250913    clang-20
x86_64      buildonly-randconfig-006-20250913    clang-20
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250913    gcc-14.3.0
xtensa                randconfig-002-20250913    gcc-13.4.0
xtensa                    smp_lx200_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-kernel+bounces-725566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D400B000D3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 374DC7B2DDC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BABC248F7D;
	Thu, 10 Jul 2025 11:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HvEvHv5K"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236072222AB
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 11:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752148383; cv=none; b=ujEHObmPlqwFHWrSrXjMOBVsr5AnppfLB3k2VkgBNhOwvWB0ad/oonHQRv+dM0fQlC1YUmiwJeetqel//3UHhtmJXODR9qzsnbZfth1srO1J5ovGINP/3aCyAWS/TWgQbdDZY963Ryy6iRaWsbTurU2cso8bwgGGemsVy6J6jYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752148383; c=relaxed/simple;
	bh=Y+zwghUO23sH9tl/ZD/fV77YO7VwzPBtUCX/1IaWV6s=;
	h=Date:From:To:Cc:Subject:Message-ID; b=iGaEnQ9TpnGBQ/BPVHH9XQdQphE9xRbJ1vG/lbRRRuRD1sFNktLCgLT37eY9rHx74GIa1hSCex/6HLnDSaq2Gc1/C9rhAMa7wa4H3uA1LKGG6s4HdKrUDt0qwB8pG4mbunhhhrDVHUziAlBpQUu9Ft0+7Me1LtUd+JCgNonk/Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HvEvHv5K; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752148382; x=1783684382;
  h=date:from:to:cc:subject:message-id;
  bh=Y+zwghUO23sH9tl/ZD/fV77YO7VwzPBtUCX/1IaWV6s=;
  b=HvEvHv5KmE4Im3IdSaGdkY7xiDjjtVfd4Pekhg4ezZUwj47K+km1147D
   B1+KDgTg5OOr1SV2Z3kVrvHEiw9z+0relNDc0haTd2oj8JVd5CaFcBNpC
   UGyabpxKrevwsNEXTV1ZZKWPP/LtrRCv0aRM5Tea0vz6W7fcYPQZsy49d
   tJ9RSiLVBOj6b12/zrYLGZjuPduMd70+tmr4Gg6bAuBAQdxAQk6JJQ72u
   r+wJq5MjTAYVNRcNVICWVlfss0VwhpN82mxEETsenj9EZ7LLtRJwV1qEb
   RDkEdraDQsQ253iNqF6oIgyfVUrZRpR3FnuZ/tD+WK/P3t6jcA0R/qUt4
   Q==;
X-CSE-ConnectionGUID: YDgWuoyCRJm49sj/xh0ASw==
X-CSE-MsgGUID: BCy7P4KwTxOek8gAj5drog==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="53646861"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="53646861"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 04:53:01 -0700
X-CSE-ConnectionGUID: ShO/U/fzQBKKMIhZWphCTw==
X-CSE-MsgGUID: SvXlbZlQRbiQe7+yzvMcvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="156784158"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 10 Jul 2025 04:53:00 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uZppi-0004zj-0S;
	Thu, 10 Jul 2025 11:52:58 +0000
Date: Thu, 10 Jul 2025 19:52:45 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 b4ec95e3bc3f40a5620ac64a8e24bdd59719be6f
Message-ID: <202507101932.n9ECIW9y-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: b4ec95e3bc3f40a5620ac64a8e24bdd59719be6f  Merge x86/microcode into tip/master

elapsed time: 1448m

configs tested: 89
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


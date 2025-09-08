Return-Path: <linux-kernel+bounces-805356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AEBB4878A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6E5D189F19D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB6D23CB;
	Mon,  8 Sep 2025 08:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O0GLNI/M"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DD714AD2D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 08:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757321415; cv=none; b=ouY/RZ65Yc3KKfw2FMrJdVlWd7Pi/pzjcGa9YnoKdZ22Kc3t75rRlpsP7HO+0dS3nFQCJ9SYXSp1k/AcTNPN4CCLZaAEVor0qGK51aJXz19LjHbf0rMJRbU++0l6fojGi8lFzRni/2ruq++1UjQ+TzqHbxnSPaipIN/TaWpXlNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757321415; c=relaxed/simple;
	bh=3rPLwwfNq4JK1nVjXkpWJztoCoZ4tK3ggM3/Xp5Ss9s=;
	h=Date:From:To:Cc:Subject:Message-ID; b=rmMPGBNLQU+p+wTt+Tge9J1KzI4sF8kbKIf/6ELgV/xcg5z52lBu8HgtPfnmMSOuKJqnXRbN2FUJvhGXnqFSjMyZUtyk1+/9jqxpPqUo8QR4H/SjWVVHJE4C56A0W2tgNSLF0qH+FB6Uh+QyCLsGsd39coGVnBOIdzyyeqzaaLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O0GLNI/M; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757321414; x=1788857414;
  h=date:from:to:cc:subject:message-id;
  bh=3rPLwwfNq4JK1nVjXkpWJztoCoZ4tK3ggM3/Xp5Ss9s=;
  b=O0GLNI/MKqbyMW7NQck7VUq+ThfzXoz1cx3xr77fM/7V3oUfW3ZoTQBd
   ehbfqznjCtK0/Z6eccSbMs1vsTG0rhWMlOlm87OS/93FvROc+hM6N/WUz
   NzEsfsPWEzmw1A9pEiv7Oa3DItGUgGaJgTR65qvLTWtfM2keumniV4fv6
   BAMPEbn6fYKfJZl4HVU5wYaIOhvwj5ztj6fZJn6fippRjAzVI/EJ4jpvX
   PH2ZGD8jM0EBXOVBJwXkf/cvrxM1lBEnTIBVawaCMovNBxmiYKK3YVhAF
   cNoxaDIT1tm9ojzSTg6tYs7imZnmAxYsaknYys3Ex38GMA/CgtOSaOIrZ
   A==;
X-CSE-ConnectionGUID: lJ1FMjseQgy29TpVcWhCeQ==
X-CSE-MsgGUID: qt9RVezGSl+ijqGZu4ORHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="77027525"
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="77027525"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 01:50:14 -0700
X-CSE-ConnectionGUID: CC8puXaaQ6ScCqBQmk8xSA==
X-CSE-MsgGUID: 2QMJ4JCSQGil/Jjq2uOGZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="172304485"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 08 Sep 2025 01:50:12 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uvXZh-0003fn-39;
	Mon, 08 Sep 2025 08:50:09 +0000
Date: Mon, 08 Sep 2025 16:49:34 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 f9f6155375f6275f511572a5753c5e8a0dc1b3f5
Message-ID: <202509081620.1M6KOhcK-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: f9f6155375f6275f511572a5753c5e8a0dc1b3f5  Merge branch into tip/master: 'x86/tdx'

elapsed time: 1273m

configs tested: 122
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250907    gcc-8.5.0
arc                   randconfig-002-20250907    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250907    gcc-8.5.0
arm                   randconfig-002-20250907    clang-22
arm                   randconfig-003-20250907    clang-22
arm                   randconfig-004-20250907    gcc-10.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250907    clang-22
arm64                 randconfig-002-20250907    gcc-14.3.0
arm64                 randconfig-003-20250907    clang-22
arm64                 randconfig-004-20250907    gcc-9.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250908    gcc-14.3.0
csky                  randconfig-002-20250908    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250908    clang-17
hexagon               randconfig-002-20250908    clang-20
i386                             allmodconfig    gcc-13
i386                              allnoconfig    gcc-13
i386                             allyesconfig    gcc-13
i386        buildonly-randconfig-001-20250907    clang-20
i386        buildonly-randconfig-002-20250907    clang-20
i386        buildonly-randconfig-003-20250907    gcc-13
i386        buildonly-randconfig-004-20250907    clang-20
i386        buildonly-randconfig-005-20250907    clang-20
i386        buildonly-randconfig-006-20250907    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250908    gcc-15.1.0
loongarch             randconfig-002-20250908    clang-18
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                         apollo_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                      bmips_stb_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250908    gcc-8.5.0
nios2                 randconfig-002-20250908    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250908    gcc-13.4.0
parisc                randconfig-002-20250908    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                        cell_defconfig    gcc-15.1.0
powerpc                 mpc8313_rdb_defconfig    gcc-15.1.0
powerpc                     ppa8548_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250908    gcc-15.1.0
powerpc               randconfig-002-20250908    clang-19
powerpc               randconfig-003-20250908    gcc-9.5.0
powerpc64             randconfig-001-20250908    gcc-8.5.0
powerpc64             randconfig-002-20250908    gcc-10.5.0
powerpc64             randconfig-003-20250908    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250907    clang-22
riscv                 randconfig-002-20250907    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250907    gcc-8.5.0
s390                  randconfig-002-20250907    gcc-14.3.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250907    gcc-12.5.0
sh                    randconfig-002-20250907    gcc-15.1.0
sh                             sh03_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250907    gcc-13.4.0
sparc                 randconfig-002-20250907    gcc-15.1.0
sparc                       sparc64_defconfig    gcc-15.1.0
sparc64               randconfig-001-20250907    gcc-12.5.0
sparc64               randconfig-002-20250907    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-13
um                    randconfig-001-20250907    gcc-13
um                    randconfig-002-20250907    gcc-13
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250907    gcc-13
x86_64      buildonly-randconfig-002-20250907    clang-20
x86_64      buildonly-randconfig-003-20250907    gcc-13
x86_64      buildonly-randconfig-004-20250907    gcc-13
x86_64      buildonly-randconfig-005-20250907    gcc-13
x86_64      buildonly-randconfig-006-20250907    gcc-13
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250907    gcc-10.5.0
xtensa                randconfig-002-20250907    gcc-9.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


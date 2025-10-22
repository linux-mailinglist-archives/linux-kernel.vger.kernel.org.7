Return-Path: <linux-kernel+bounces-863941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 27847BF98E6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9888235103E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D05C1925BC;
	Wed, 22 Oct 2025 01:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n28yfIVB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BF017D2
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761094950; cv=none; b=gcR3KN3w2LVKJQm7OLJbGtyPoYbTJcPXJRvSpwiWDRb90dThfnGk/K8oScSRNjOi0MFi1BxErUiII43fcSt7aei4/+MjM+jywP4OnhnfZKZXuoeoJ8mVSqfjMW6BZCoyknLv11X7WGsZGlnVzunWGiGIhr+FDFk0SPfTFmmu8dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761094950; c=relaxed/simple;
	bh=EYjQ+/B7mokDGg7VydMCrM2Toj0dqe7yAb4XK5mcHBo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=crKFB6FuumTr51ZohUTjwXUQgMald+4oS5Ab0ogOkQO+1nJD9DqwenLYk+xK3TH6r3Gy4+Pf9fzEa9AAhTDUf7jHnV7f3Oi3DVv7FVbN+qUTIszYXLoDImPWksrFRqDNYZ8jJYJHCYRYQJhsSw2VHNPX84Dvcv0rTfP00TYyX/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n28yfIVB; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761094949; x=1792630949;
  h=date:from:to:cc:subject:message-id;
  bh=EYjQ+/B7mokDGg7VydMCrM2Toj0dqe7yAb4XK5mcHBo=;
  b=n28yfIVBbe0ukHFhqKMwT/74xzzhqUZPhVGIw1BTLYPw5GS43gdkyEnM
   /OoVtPdGLr5TIah197s5kc54h8Mibqc9rpLPRrenbGiCeV4uQ2GsZ2s8k
   k++rrJ2XjGUvBxa6V7mwJh9cUlZBeySucA0tawfA8NGdYYsw5FJ90LR89
   TPXHOQZEPfCdvwL7aFAgbypO4JP88rMvN1mOKp+xpl30HFOQelr6PFjL0
   zoX24YwHke5JTQhtyeiE90+cJS5PY5T8AjuV9J5jX1/4xUBNcrRxIKe18
   o2QY1LJgkCqs6knqb8Bs3opPbSCsYCtEXt8HYQnfc9RTAXrGeNHAyKzJc
   A==;
X-CSE-ConnectionGUID: wHx8C61aQauRV9XuoucuOA==
X-CSE-MsgGUID: dep+9A7LTf6qMGYKiPpVeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66874112"
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="66874112"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 18:02:28 -0700
X-CSE-ConnectionGUID: +0U3my6MTeanLpxBSZAl7w==
X-CSE-MsgGUID: 1XXkfaR0TBWv0Qw3Yjw+zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="207409804"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 21 Oct 2025 18:02:27 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vBNFB-000Bsh-1X;
	Wed, 22 Oct 2025 01:02:25 +0000
Date: Wed, 22 Oct 2025 09:01:55 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/apic] BUILD SUCCESS
 27d2afa3b4eab5fb2a03b6ad8b74a3a700e92dce
Message-ID: <202510220949.1s9EWGhQ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/apic
branch HEAD: 27d2afa3b4eab5fb2a03b6ad8b74a3a700e92dce  x86/ioapic: Simplify mp_irqdomain_alloc() slightly

elapsed time: 1049m

configs tested: 93
configs skipped: 122

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                   randconfig-001-20251022    clang-22
arc                   randconfig-002-20251022    clang-22
arm                   randconfig-001-20251022    clang-22
arm                   randconfig-002-20251022    clang-22
arm                   randconfig-003-20251022    clang-22
arm                   randconfig-004-20251022    clang-22
arm                        spear6xx_defconfig    gcc-15.1.0
arm64                 randconfig-001-20251022    clang-22
arm64                 randconfig-002-20251022    clang-22
arm64                 randconfig-003-20251022    clang-22
arm64                 randconfig-004-20251022    clang-22
csky                  randconfig-001-20251022    clang-22
csky                  randconfig-002-20251022    clang-22
hexagon               randconfig-001-20251022    clang-22
hexagon               randconfig-002-20251022    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251021    clang-20
i386        buildonly-randconfig-001-20251022    gcc-14
i386        buildonly-randconfig-002-20251021    clang-20
i386        buildonly-randconfig-002-20251022    gcc-14
i386        buildonly-randconfig-003-20251021    clang-20
i386        buildonly-randconfig-003-20251022    gcc-14
i386        buildonly-randconfig-004-20251021    gcc-14
i386        buildonly-randconfig-004-20251022    gcc-14
i386        buildonly-randconfig-005-20251021    gcc-14
i386        buildonly-randconfig-005-20251022    gcc-14
i386        buildonly-randconfig-006-20251021    clang-20
i386        buildonly-randconfig-006-20251022    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-011-20251022    gcc-13
i386                  randconfig-012-20251022    gcc-13
i386                  randconfig-013-20251022    gcc-13
i386                  randconfig-014-20251022    gcc-13
i386                  randconfig-015-20251022    gcc-13
i386                  randconfig-016-20251022    gcc-13
i386                  randconfig-017-20251022    gcc-13
loongarch             randconfig-001-20251022    clang-22
loongarch             randconfig-002-20251022    clang-22
m68k                              allnoconfig    gcc-15.1.0
m68k                          amiga_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        bcm47xx_defconfig    gcc-15.1.0
mips                       bmips_be_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-15.1.0
nios2                 randconfig-001-20251022    clang-22
nios2                 randconfig-002-20251022    clang-22
openrisc                          allnoconfig    clang-22
parisc                            allnoconfig    clang-22
parisc                randconfig-001-20251022    clang-22
parisc                randconfig-002-20251022    clang-22
powerpc                           allnoconfig    clang-22
powerpc               randconfig-001-20251022    clang-22
powerpc               randconfig-002-20251022    clang-22
powerpc               randconfig-003-20251022    clang-22
powerpc64             randconfig-001-20251022    clang-22
powerpc64             randconfig-002-20251022    clang-22
powerpc64             randconfig-003-20251022    clang-22
riscv                             allnoconfig    clang-22
s390                             alldefconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
sh                                allnoconfig    gcc-15.1.0
sh                            hp6xx_defconfig    gcc-15.1.0
sh                          lboxre2_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
um                                allnoconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251022    clang-20
x86_64      buildonly-randconfig-002-20251022    clang-20
x86_64      buildonly-randconfig-003-20251022    clang-20
x86_64      buildonly-randconfig-004-20251022    clang-20
x86_64      buildonly-randconfig-005-20251021    gcc-14
x86_64      buildonly-randconfig-005-20251022    clang-20
x86_64      buildonly-randconfig-006-20251021    clang-20
x86_64      buildonly-randconfig-006-20251022    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251022    clang-20
x86_64                randconfig-002-20251022    clang-20
x86_64                randconfig-003-20251022    clang-20
x86_64                randconfig-004-20251022    clang-20
x86_64                randconfig-005-20251022    clang-20
x86_64                randconfig-006-20251022    clang-20
x86_64                randconfig-007-20251022    clang-20
x86_64                randconfig-008-20251022    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


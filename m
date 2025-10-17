Return-Path: <linux-kernel+bounces-857410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA39CBE6B9F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C5584F8BBD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FC530F94E;
	Fri, 17 Oct 2025 06:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W94Frgiu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF0B30F818
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760683146; cv=none; b=LY9otlIVZ985dQzaq6jj56/E6x1NzO0zMjD1jjcO9ncPTv666FjoeWpNj6KoVHGAwO1kdyTZ7VLQn4xYYY1WAo76J0HYuiJW2Te/HkXmmRetmCYKR/czKbLJzRzYvAdHQReyyXY6+0Q1aCUQMElYmaHpsqR/QMbjCfHVkV8MvVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760683146; c=relaxed/simple;
	bh=UfrWt9yhUnv3ZVVM145PSm3xsm0Z1hqleyzWy94giN4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=e/DQ58WrmRxHVTWSfZTQydOhKTWVjUqwUxmn97ZWMmaVFzdWdVN68ResTZ00rPWltAFTOM+sQs4bvdD0qzY04KuNqhkOms1hiSZhRjPfnzX3Or3PbFnK4ZE6NQRMFVNp/D8C6qxykaUikZEVZupfT70iGKCcKV2gvLChtka43Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W94Frgiu; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760683144; x=1792219144;
  h=date:from:to:cc:subject:message-id;
  bh=UfrWt9yhUnv3ZVVM145PSm3xsm0Z1hqleyzWy94giN4=;
  b=W94Frgiu72Acaf2cZuhHOWzvPiKeJPljpBQzJ7/9FxP9zEqfXdm9IIuH
   yAfNFwNB3GGF/8gvMmELGCK/gf4qt0t/tnXgYocs8tNvrGBe2zNO+H785
   9SDBf4qIZA2w/aa0IYLdzDVFHhOFleA6dwVvdjiNWmD1XVDwrArHrgQWP
   Ck6tEAwCR1qYW7cgAM6DR2xzSzgWHvHJOmnr31MHJrRmAyo5ge6/nMwNZ
   s+8YdyvjpsNndemICV8/ruxAQqouc1NLaWwwD0z7z4Hs88U4nk7m2u5nX
   5X/4AIQ4BlweK1MP1yIS2IVV2GrzvgpjsITcfQCH3pCAGzx9Jxm2vPcTY
   w==;
X-CSE-ConnectionGUID: ZHfxU046TZ2PlQ+h/JSK1Q==
X-CSE-MsgGUID: dZAkufHPRIuYUlnRfhiI8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="62599386"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="62599386"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 23:39:04 -0700
X-CSE-ConnectionGUID: Mv8eQqFGRwK4ARfIqrrKYg==
X-CSE-MsgGUID: h6cch7H0TaSkGU+itN2g6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="213628142"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 16 Oct 2025 23:39:02 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9e7A-0005cr-0o;
	Fri, 17 Oct 2025 06:39:00 +0000
Date: Fri, 17 Oct 2025 14:37:50 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 45e1dccc0653c50e377dae57ef086a8d0f71061d
Message-ID: <202510171444.o1GOIHUr-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
branch HEAD: 45e1dccc0653c50e377dae57ef086a8d0f71061d  x86/insn: Simplify for_each_insn_prefix()

elapsed time: 1272m

configs tested: 195
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                   randconfig-001-20251016    gcc-13.4.0
arc                   randconfig-001-20251017    clang-22
arc                   randconfig-002-20251016    gcc-8.5.0
arc                   randconfig-002-20251017    clang-22
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                   randconfig-001-20251016    clang-22
arm                   randconfig-001-20251017    clang-22
arm                   randconfig-002-20251016    gcc-10.5.0
arm                   randconfig-002-20251017    clang-22
arm                   randconfig-003-20251016    clang-22
arm                   randconfig-003-20251017    clang-22
arm                   randconfig-004-20251016    gcc-14.3.0
arm                   randconfig-004-20251017    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251016    clang-22
arm64                 randconfig-001-20251017    clang-22
arm64                 randconfig-002-20251016    gcc-13.4.0
arm64                 randconfig-002-20251017    clang-22
arm64                 randconfig-003-20251016    gcc-10.5.0
arm64                 randconfig-003-20251017    clang-22
arm64                 randconfig-004-20251016    clang-22
arm64                 randconfig-004-20251017    clang-22
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251016    gcc-11.5.0
csky                  randconfig-001-20251017    gcc-15.1.0
csky                  randconfig-002-20251016    gcc-11.5.0
csky                  randconfig-002-20251017    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20251016    clang-22
hexagon               randconfig-001-20251017    gcc-15.1.0
hexagon               randconfig-002-20251016    clang-22
hexagon               randconfig-002-20251017    gcc-15.1.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20251016    clang-20
i386        buildonly-randconfig-001-20251017    clang-20
i386        buildonly-randconfig-002-20251016    gcc-14
i386        buildonly-randconfig-002-20251017    clang-20
i386        buildonly-randconfig-003-20251016    clang-20
i386        buildonly-randconfig-003-20251017    clang-20
i386        buildonly-randconfig-004-20251016    clang-20
i386        buildonly-randconfig-004-20251017    clang-20
i386        buildonly-randconfig-005-20251016    clang-20
i386        buildonly-randconfig-005-20251017    clang-20
i386        buildonly-randconfig-006-20251016    gcc-14
i386        buildonly-randconfig-006-20251017    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20251017    clang-20
i386                  randconfig-002-20251017    clang-20
i386                  randconfig-003-20251017    clang-20
i386                  randconfig-004-20251017    clang-20
i386                  randconfig-005-20251017    clang-20
i386                  randconfig-006-20251017    clang-20
i386                  randconfig-007-20251017    clang-20
i386                  randconfig-011-20251017    gcc-12
i386                  randconfig-012-20251017    gcc-12
i386                  randconfig-013-20251017    gcc-12
i386                  randconfig-014-20251017    gcc-12
i386                  randconfig-015-20251017    gcc-12
i386                  randconfig-016-20251017    gcc-12
i386                  randconfig-017-20251017    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20251016    gcc-15.1.0
loongarch             randconfig-001-20251017    gcc-15.1.0
loongarch             randconfig-002-20251016    gcc-13.4.0
loongarch             randconfig-002-20251017    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251016    gcc-8.5.0
nios2                 randconfig-001-20251017    gcc-15.1.0
nios2                 randconfig-002-20251016    gcc-8.5.0
nios2                 randconfig-002-20251017    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251016    gcc-9.5.0
parisc                randconfig-001-20251017    gcc-15.1.0
parisc                randconfig-002-20251016    gcc-8.5.0
parisc                randconfig-002-20251017    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                  mpc866_ads_defconfig    clang-22
powerpc                      ppc64e_defconfig    clang-22
powerpc               randconfig-001-20251016    clang-16
powerpc               randconfig-001-20251017    gcc-15.1.0
powerpc               randconfig-002-20251016    gcc-8.5.0
powerpc               randconfig-002-20251017    gcc-15.1.0
powerpc               randconfig-003-20251016    clang-22
powerpc               randconfig-003-20251017    gcc-15.1.0
powerpc                    socrates_defconfig    clang-22
powerpc64             randconfig-001-20251017    gcc-15.1.0
powerpc64             randconfig-002-20251016    clang-22
powerpc64             randconfig-002-20251017    gcc-15.1.0
powerpc64             randconfig-003-20251016    gcc-13.4.0
powerpc64             randconfig-003-20251017    gcc-15.1.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                    nommu_virt_defconfig    clang-22
riscv                 randconfig-001-20251016    gcc-9.5.0
riscv                 randconfig-002-20251016    gcc-10.5.0
s390                             alldefconfig    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20251016    clang-18
s390                  randconfig-002-20251016    gcc-13.4.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                 kfr2r09-romimage_defconfig    clang-22
sh                    randconfig-001-20251016    gcc-14.3.0
sh                    randconfig-002-20251016    gcc-14.3.0
sh                              ul2_defconfig    clang-22
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251016    gcc-15.1.0
sparc                 randconfig-002-20251016    gcc-8.5.0
sparc64               randconfig-001-20251016    gcc-13.4.0
sparc64               randconfig-002-20251016    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                    randconfig-001-20251016    gcc-12
um                    randconfig-002-20251016    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251016    clang-20
x86_64      buildonly-randconfig-001-20251017    clang-20
x86_64      buildonly-randconfig-002-20251016    gcc-14
x86_64      buildonly-randconfig-002-20251017    clang-20
x86_64      buildonly-randconfig-003-20251016    gcc-14
x86_64      buildonly-randconfig-003-20251017    clang-20
x86_64      buildonly-randconfig-004-20251016    gcc-12
x86_64      buildonly-randconfig-004-20251017    clang-20
x86_64      buildonly-randconfig-005-20251016    gcc-14
x86_64      buildonly-randconfig-005-20251017    clang-20
x86_64      buildonly-randconfig-006-20251016    gcc-12
x86_64      buildonly-randconfig-006-20251017    clang-20
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251017    gcc-14
x86_64                randconfig-002-20251017    gcc-14
x86_64                randconfig-003-20251017    gcc-14
x86_64                randconfig-004-20251017    gcc-14
x86_64                randconfig-005-20251017    gcc-14
x86_64                randconfig-006-20251017    gcc-14
x86_64                randconfig-007-20251017    gcc-14
x86_64                randconfig-008-20251017    gcc-14
x86_64                randconfig-071-20251017    clang-20
x86_64                randconfig-072-20251017    clang-20
x86_64                randconfig-073-20251017    clang-20
x86_64                randconfig-074-20251017    clang-20
x86_64                randconfig-075-20251017    clang-20
x86_64                randconfig-076-20251017    clang-20
x86_64                randconfig-077-20251017    clang-20
x86_64                randconfig-078-20251017    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251016    gcc-10.5.0
xtensa                randconfig-002-20251016    gcc-9.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-kernel+bounces-734839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F85BB086F2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50D827BAABE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 07:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355632550BA;
	Thu, 17 Jul 2025 07:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oe2w4yKM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95502571B9
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 07:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752737628; cv=none; b=abPuGXMfss5Z+jp/LxLOyo9bgqZbeVAnXkdwmobCDSIcITlEHNpmtCyk05Q9hm+hQsfDMEj7P8Eqah3U53Y4M/jSD0BuatZyEK8Qw0gU0DfNg5MNf6WNMWD/9QwwykH1cRUEFIc3e2sBa8HLJIrMih1T+C7yoVknXUa4aTP9S90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752737628; c=relaxed/simple;
	bh=HFWzHqdqqGc/9GA2+aYVs+PRLYnkygHlp2xuxprFae0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tbqGoucpe0zhNJQX+OC2LCjcj6ysZFF3XKY2C1yiU7jZuVoyaZxkg4auv/PsBuqehe1tQfLrkKPdm+yHMqjLeB/FGNPdLwBlSPGOXb3gpGKafSIZEo3wULZ8EjdNqRkS9I2c0bb5wEXzvR0S5+S3dqsxzdSYTHMUChymbwmBfc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oe2w4yKM; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752737626; x=1784273626;
  h=date:from:to:cc:subject:message-id;
  bh=HFWzHqdqqGc/9GA2+aYVs+PRLYnkygHlp2xuxprFae0=;
  b=Oe2w4yKMOeiYrwaLsNuixKSapKwouKEI3tg3T8LgW3dVp5mNMMOjBHuO
   6+yxdnvrV/zZT9CfaQZbmwwS4gdUHKtL/PNMVmbVwI7LFKzS5H78bYkyG
   EAMIc0Jb0FIZR/omT3txxFwiHNtluGSbYg7Hh/yrCEo0vTo+MaPsPnrda
   gK3uZki8TkzFA9+d67r83olKfxZHMo2LE6+grhsyEi2utrf7DpR1a0jRM
   rz3roV3e16ONIB3ITOs/LshJrt+5nQWZy8Lju3znltGl7K1mM8V7r+S3O
   HIaGAre1HAs/fsS4hW/IdxlSjLZiX/wongCL6uydJpf8OOPaXfz/FMlZm
   w==;
X-CSE-ConnectionGUID: AZjHuzbATr6alSXh81N5Ug==
X-CSE-MsgGUID: djjh+bq0TKaYayQUMzpSWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="80449522"
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; 
   d="scan'208";a="80449522"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 00:33:45 -0700
X-CSE-ConnectionGUID: yDBuYvqLRhOZAP/29Nv+cg==
X-CSE-MsgGUID: V1sigIuqRVGbUfrGQJJyGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; 
   d="scan'208";a="188722152"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 17 Jul 2025 00:33:45 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ucJ7f-000DJ9-0q;
	Thu, 17 Jul 2025 07:33:43 +0000
Date: Thu, 17 Jul 2025 15:33:19 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:tip/urgent] BUILD SUCCESS
 3ddab1783a8c4d5f30a996ede840e85c8981f957
Message-ID: <202507171507.50HYshNq-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tip/urgent
branch HEAD: 3ddab1783a8c4d5f30a996ede840e85c8981f957  Merge branch into tip/master: 'x86/urgent'

elapsed time: 1466m

configs tested: 123
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                         haps_hs_defconfig    gcc-15.1.0
arc                            hsdk_defconfig    gcc-15.1.0
arc                   randconfig-001-20250716    gcc-13.4.0
arc                   randconfig-002-20250716    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                           omap1_defconfig    gcc-15.1.0
arm                   randconfig-001-20250716    clang-20
arm                   randconfig-002-20250716    gcc-12.4.0
arm                   randconfig-003-20250716    gcc-8.5.0
arm                   randconfig-004-20250716    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250716    gcc-9.5.0
arm64                 randconfig-002-20250716    gcc-8.5.0
arm64                 randconfig-003-20250716    gcc-8.5.0
arm64                 randconfig-004-20250716    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250716    gcc-14.3.0
csky                  randconfig-002-20250716    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250716    clang-21
hexagon               randconfig-002-20250716    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250716    gcc-12
i386        buildonly-randconfig-002-20250716    clang-20
i386        buildonly-randconfig-003-20250716    gcc-12
i386        buildonly-randconfig-004-20250716    gcc-11
i386        buildonly-randconfig-005-20250716    gcc-12
i386        buildonly-randconfig-006-20250716    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch             randconfig-001-20250716    clang-18
loongarch             randconfig-002-20250716    clang-21
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
nios2                 randconfig-001-20250716    gcc-14.2.0
nios2                 randconfig-002-20250716    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
openrisc                    or1ksim_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250716    gcc-8.5.0
parisc                randconfig-002-20250716    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                      mgcoge_defconfig    clang-21
powerpc               randconfig-001-20250716    gcc-8.5.0
powerpc               randconfig-002-20250716    clang-21
powerpc               randconfig-003-20250716    gcc-14.3.0
powerpc64             randconfig-001-20250716    gcc-10.5.0
powerpc64             randconfig-003-20250716    gcc-13.4.0
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250716    gcc-8.5.0
riscv                 randconfig-002-20250716    gcc-11.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250716    gcc-11.5.0
s390                  randconfig-002-20250716    gcc-11.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                          r7780mp_defconfig    gcc-15.1.0
sh                    randconfig-001-20250716    gcc-15.1.0
sh                    randconfig-002-20250716    gcc-14.3.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250716    gcc-8.5.0
sparc                 randconfig-002-20250716    gcc-14.3.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250716    clang-20
sparc64               randconfig-002-20250716    clang-21
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250716    gcc-11
um                    randconfig-002-20250716    gcc-12
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250716    gcc-12
x86_64      buildonly-randconfig-002-20250716    clang-20
x86_64      buildonly-randconfig-003-20250716    clang-20
x86_64      buildonly-randconfig-004-20250716    clang-20
x86_64      buildonly-randconfig-005-20250716    clang-20
x86_64      buildonly-randconfig-006-20250716    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                  cadence_csp_defconfig    gcc-15.1.0
xtensa                randconfig-001-20250716    gcc-9.3.0
xtensa                randconfig-002-20250716    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


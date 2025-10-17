Return-Path: <linux-kernel+bounces-858126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEDFBE910E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E1F51AA3E45
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C879036999B;
	Fri, 17 Oct 2025 13:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cTtjRWWN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D17A3570CF
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760709110; cv=none; b=E12b16OJ9kGKpjVqUcC01e0HndyY6Xsq7s0fyuXX4c2cHKzltfucXTZFK5pHjTOFnUcSNcZC7LnJA/PJ7/nniHsdD+w0FKBLX/ufrFvxnKABb0+WaY/Kns0LSRWHuq09LOK6cXwuWALweO10qmhXbzbMiI82tPffI0/Z3H1X1GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760709110; c=relaxed/simple;
	bh=PdaBTXoPhrvHtMu9vRtuC8xkV3/tl4iob11u95BHtDg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=H4Tc/YD0vJiofY6yTsKzuso27BKYGEK/1T9aY4Ry3oYfmMmGXDZNy3ug1LX+xlBPUhDmD9Mq4JTI8lZ9BXrZl7BHWn2Jo6GmdRlbU8eukDBvdMO0V4G/29RV5o6hMarI+lQUvJUmDTT02exOcmTEdmWFOVhpcEuLapMXP0TL5/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cTtjRWWN; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760709108; x=1792245108;
  h=date:from:to:cc:subject:message-id;
  bh=PdaBTXoPhrvHtMu9vRtuC8xkV3/tl4iob11u95BHtDg=;
  b=cTtjRWWNQgYnpdXcn9WIDtJaCBTRhf2i0GUEMhmj1QWDpGD0OsEfxhHD
   2PRJ74cilVTSRSF3VXEX0gLGxIZsy1UunuQJ8/zNcqlmRl5RPu3sLstyq
   0630nBka4Ne9/8ulcT+0R1uPnzG1N7Y6QHwDb0FlqFuGZSgbhjKGFN7c6
   am4jzH/77Flq8OMm6eGyt/Lw8vOAJL6rUj6q18r1hwJ/+fzNqpICmdJR2
   yILFVF8Zfnvt2AJpghB87N3newTQZrmYk3S7dhXAkjeOe4OKZiVupcQC5
   L3y9/Z/0JE4JUqFin54+laMh9iCdGlIcPD+O9ij0pbYVrBU3mPtidKKCH
   Q==;
X-CSE-ConnectionGUID: ADN6wb/NRM+hpQZ3PUYNLg==
X-CSE-MsgGUID: xN96DKCRR0GWVyK7NGy6sQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="63008103"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="63008103"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 06:51:47 -0700
X-CSE-ConnectionGUID: OEV3rDTST/OrCwH8gu4MEg==
X-CSE-MsgGUID: EpcKLMesSzK1QOIkZwatjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="182686108"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 17 Oct 2025 06:51:46 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9krv-0005zy-36;
	Fri, 17 Oct 2025 13:51:44 +0000
Date: Fri, 17 Oct 2025 21:47:43 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:objtool/core] BUILD SUCCESS
 00a155c691befdb10bea52c91d4c8c930bdaf73a
Message-ID: <202510172138.A8o9oSzn-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool/core
branch HEAD: 00a155c691befdb10bea52c91d4c8c930bdaf73a  Merge branch 'objtool/core' of https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux

elapsed time: 1639m

configs tested: 104
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20251016    gcc-13.4.0
arc                   randconfig-002-20251016    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                      integrator_defconfig    clang-22
arm                   randconfig-001-20251016    clang-22
arm                   randconfig-002-20251016    gcc-10.5.0
arm                   randconfig-003-20251016    clang-22
arm                   randconfig-004-20251016    gcc-14.3.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251016    clang-22
arm64                 randconfig-002-20251016    gcc-13.4.0
arm64                 randconfig-003-20251016    gcc-10.5.0
arm64                 randconfig-004-20251016    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251016    gcc-11.5.0
csky                  randconfig-002-20251016    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20251016    clang-22
hexagon               randconfig-002-20251016    clang-22
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
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20251016    gcc-15.1.0
loongarch             randconfig-002-20251016    gcc-13.4.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        bcm63xx_defconfig    clang-22
mips                           jazz_defconfig    clang-17
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251016    gcc-8.5.0
nios2                 randconfig-002-20251016    gcc-8.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251016    gcc-9.5.0
parisc                randconfig-002-20251016    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20251016    clang-16
powerpc               randconfig-002-20251016    gcc-8.5.0
powerpc               randconfig-003-20251016    clang-22
powerpc64             randconfig-002-20251016    clang-22
powerpc64             randconfig-003-20251016    gcc-13.4.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20251016    gcc-9.5.0
riscv                 randconfig-002-20251016    gcc-10.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20251016    clang-18
s390                  randconfig-002-20251016    gcc-13.4.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20251016    gcc-14.3.0
sh                    randconfig-002-20251016    gcc-14.3.0
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
x86_64      buildonly-randconfig-001-20251016    clang-20
x86_64      buildonly-randconfig-002-20251016    gcc-14
x86_64      buildonly-randconfig-003-20251016    gcc-14
x86_64      buildonly-randconfig-004-20251016    gcc-12
x86_64      buildonly-randconfig-005-20251016    gcc-14
x86_64      buildonly-randconfig-006-20251016    gcc-12
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251016    gcc-10.5.0
xtensa                randconfig-002-20251016    gcc-9.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


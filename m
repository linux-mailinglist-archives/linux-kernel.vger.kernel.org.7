Return-Path: <linux-kernel+bounces-868361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A13CC0509E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DDD3503354
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED10B304BA0;
	Fri, 24 Oct 2025 08:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VBP0Bcj2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6852F25F7
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761294402; cv=none; b=YfFIOvDFjvGlzhyum/tzl6wXLVW0fed0jR+ijKrWhAELbbDTVOZoP8TEqPe7gt1petCQ1h8jYeFS6eK2ccl4QZQ3dg6mKxC9S1BXGQ5f5E3sTvAdpZyHI1x+3m+nv41aF+bXS3ejyNwTaxniXOgyXEGv3frZkfKUl2aOnO4F7FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761294402; c=relaxed/simple;
	bh=DBm91FGli5LLqzuCXI1JrMz3svmXKWPotfToLOcp/nA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=c24MQxJCRDUTR7UtKBKu49kKhp3k7j17G+CuIUkMKepHewGJoobhd5DJ1XZU+ZreAsMURV6cIAVIWPA979aKr6vXZF3zvC/IafP6VbXyW82YU90B7XiHyPnxfDC4EtSMzNzfMUaQi3FeLaEIaN6o3TjxyOsZqNec+gJ7ygIdBkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VBP0Bcj2; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761294401; x=1792830401;
  h=date:from:to:cc:subject:message-id;
  bh=DBm91FGli5LLqzuCXI1JrMz3svmXKWPotfToLOcp/nA=;
  b=VBP0Bcj2onKkJGM8z+80WAX0A+DCv2jP2QMkLdFvSIurqQQyp9C3vcT3
   KYssJxlpU6vN9VSudbBuBqeDbxc4tvM/TTbbqiQfcfzEQ+4AYOhY03VTX
   IUqF9U0P8jikZ0jvG7+LCNkzppP2hG8F1Xy81rY/l18Sjw0Maez8X5HVe
   q9I2/2VLdCjxCAgQOXTcEEFFrR6eGhbCah4RxSzyJpMFW3nKONM5KQ8un
   nxQ9OKjTaIQ1racoiFF03+eKl7R407nzbKUHM67D3yNapqx+GHnZ2t9+u
   dw2VFmmzjvSiQQlnHTNVkdwt7sMxZERcFh0kzB59vZcdtkdc7OTFQuYL8
   g==;
X-CSE-ConnectionGUID: EstmnDYuRoaH+0ZbUSJxfg==
X-CSE-MsgGUID: R0HD67XUQo6/z8Kze5pebw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63364919"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="63364919"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 01:26:40 -0700
X-CSE-ConnectionGUID: Dk68DEIiReCrXmVUvOVEpg==
X-CSE-MsgGUID: 0AiQzPu/Sn6DvQB9n3dR2A==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 24 Oct 2025 01:26:39 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vCD7t-000EKl-15;
	Fri, 24 Oct 2025 08:26:33 +0000
Date: Fri, 24 Oct 2025 16:25:32 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:tip/urgent] BUILD SUCCESS
 596b40e5e421bb00673e7517549bbbd0143ec275
Message-ID: <202510241627.WMqgBeAU-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tip/urgent
branch HEAD: 596b40e5e421bb00673e7517549bbbd0143ec275  Merge branch into tip/master: 'x86/urgent'

elapsed time: 1446m

configs tested: 127
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20251023    gcc-8.5.0
arc                   randconfig-002-20251023    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                        clps711x_defconfig    clang-22
arm                   randconfig-001-20251023    clang-22
arm                   randconfig-002-20251023    clang-19
arm                   randconfig-003-20251023    gcc-8.5.0
arm                   randconfig-004-20251023    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251023    clang-22
arm64                 randconfig-002-20251023    gcc-8.5.0
arm64                 randconfig-003-20251023    gcc-8.5.0
arm64                 randconfig-004-20251023    clang-17
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251023    gcc-11.5.0
csky                  randconfig-002-20251023    gcc-13.4.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20251023    clang-22
hexagon               randconfig-002-20251023    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251023    clang-20
i386        buildonly-randconfig-002-20251023    clang-20
i386        buildonly-randconfig-003-20251023    gcc-14
i386        buildonly-randconfig-004-20251023    clang-20
i386        buildonly-randconfig-005-20251023    clang-20
i386        buildonly-randconfig-006-20251023    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20251023    clang-22
loongarch             randconfig-002-20251023    clang-18
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                       m5208evb_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251023    gcc-8.5.0
nios2                 randconfig-002-20251023    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251023    gcc-9.5.0
parisc                randconfig-002-20251023    gcc-8.5.0
parisc64                         alldefconfig    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20251023    gcc-12.5.0
powerpc               randconfig-002-20251023    clang-22
powerpc               randconfig-003-20251023    clang-22
powerpc                     taishan_defconfig    clang-17
powerpc64             randconfig-001-20251023    clang-22
powerpc64             randconfig-002-20251023    gcc-10.5.0
powerpc64             randconfig-003-20251023    gcc-10.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251023    gcc-8.5.0
riscv                 randconfig-002-20251023    gcc-14.3.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251023    clang-19
s390                  randconfig-002-20251023    gcc-8.5.0
s390                       zfcpdump_defconfig    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                          polaris_defconfig    gcc-15.1.0
sh                    randconfig-001-20251023    gcc-15.1.0
sh                    randconfig-002-20251023    gcc-15.1.0
sh                          rsk7203_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251023    gcc-12.5.0
sparc                 randconfig-002-20251023    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251023    clang-22
sparc64               randconfig-002-20251023    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251023    gcc-13
um                    randconfig-002-20251023    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251023    clang-20
x86_64      buildonly-randconfig-002-20251023    gcc-13
x86_64      buildonly-randconfig-003-20251023    clang-20
x86_64      buildonly-randconfig-004-20251023    gcc-14
x86_64      buildonly-randconfig-005-20251023    clang-20
x86_64      buildonly-randconfig-006-20251023    gcc-14
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251023    gcc-8.5.0
xtensa                randconfig-002-20251023    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


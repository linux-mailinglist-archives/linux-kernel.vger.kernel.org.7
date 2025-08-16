Return-Path: <linux-kernel+bounces-771685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B64B28A4F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 05:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE00A1BC85CB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 03:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD9E1C84A8;
	Sat, 16 Aug 2025 03:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W/uU60Mj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0B379EA
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 03:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755315641; cv=none; b=qjSQ+m/Usm81vK4/oAxcsJOXU4xslvoeG2ZTyVPM5TLyHUnxVUMcUq4yK0IIUBcy621q1eHgw/FFfbZ0drQF/2DqcnENrxw4qo2yQG0NF3acu2jAQkqgszc1YuJZKaI+peBT6lc17wLRGTKCqydsoXNMQnZiArHMR2IlmSjLGSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755315641; c=relaxed/simple;
	bh=r2D7UAio2Gm8Hww2NAzkBX8TFfOmLoFMNdcmoKOzjJc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HUsaXcQiqI21xeyU2mCcLoRcg9b/PmH7W26erRGr7lKbx2DbQzdQW/ZuNrNVSlIXz4DAiu4Zr+CP1yXo1QeboupAku9zkBOwyhT8BXUj4th9mYqOuq2kYTFUF+/EbXv216cqPchLl9JB2ZikczOOAb/UNucc8u5PBiKjtOdaYl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W/uU60Mj; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755315641; x=1786851641;
  h=date:from:to:cc:subject:message-id;
  bh=r2D7UAio2Gm8Hww2NAzkBX8TFfOmLoFMNdcmoKOzjJc=;
  b=W/uU60Mjnw2IezVceLHw/KDOd49LZTTpbSqsiHhnLO7JC12JIJBFvHMn
   viRkvtw0B+78sacR8IHOiFUrMVb8BNaphaHic/rdQX0+XCciPS3L9Kjrp
   wUkn3h5iWm+hQHKyHX0UllxPJojtGM7nHRFSnn5kUb6mW4H5tZLqP7SYZ
   e8sauveXY904fKr9/4S6PEKOMalZYNK354/C+dRuU3DTwWOs/VAlH4yEw
   FH6Uc+AE37PwKn1M4Rhi7c6xuyFmiosTsXWFxK/jT2ejJWXeIjri4Zibw
   hMT+xnzGjEIjDLMUjCJ6JYUl8KnAOPeLlZh7WgDo7pVGOsozDIE4PVI4e
   g==;
X-CSE-ConnectionGUID: aE4593HiQ3Cheqd902xkFA==
X-CSE-MsgGUID: FJuDSP39TneNoG4ntZ8Ihw==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="57586317"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="57586317"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 20:40:39 -0700
X-CSE-ConnectionGUID: btNWjch4Qc+bSj24Qpgx2A==
X-CSE-MsgGUID: gfkTfjZfTNyoPYQ6ZLxd7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="166330688"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 15 Aug 2025 20:40:38 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1un7m9-000CYU-0X;
	Sat, 16 Aug 2025 03:40:23 +0000
Date: Sat, 16 Aug 2025 11:38:40 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/build] BUILD SUCCESS
 5d6d30eca4dd1c9e8515a8d4b13106205d5c0ec4
Message-ID: <202508161130.ho8RPtaT-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/build
branch HEAD: 5d6d30eca4dd1c9e8515a8d4b13106205d5c0ec4  x86/build: Remove cc-option for GCC retpoline flags

elapsed time: 1003m

configs tested: 123
configs skipped: 119

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    clang-22
arc                              allnoconfig    clang-22
arc                  randconfig-001-20250816    gcc-8.5.0
arc                  randconfig-002-20250816    gcc-8.5.0
arm                              allnoconfig    clang-22
arm                         moxart_defconfig    gcc-15.1.0
arm                  randconfig-001-20250816    gcc-8.5.0
arm                  randconfig-002-20250816    gcc-8.5.0
arm                  randconfig-003-20250816    gcc-8.5.0
arm                  randconfig-004-20250816    gcc-8.5.0
arm64                            allnoconfig    clang-22
arm64                randconfig-001-20250816    gcc-8.5.0
arm64                randconfig-002-20250816    gcc-8.5.0
arm64                randconfig-003-20250816    gcc-8.5.0
arm64                randconfig-004-20250816    gcc-8.5.0
csky                             allnoconfig    clang-22
csky                 randconfig-001-20250816    clang-22
csky                 randconfig-002-20250816    clang-22
hexagon                          allnoconfig    clang-22
hexagon              randconfig-001-20250816    clang-22
hexagon              randconfig-002-20250816    clang-22
i386                            allmodconfig    clang-20
i386                            allmodconfig    gcc-12
i386                             allnoconfig    clang-20
i386                             allnoconfig    gcc-12
i386                            allyesconfig    clang-20
i386                            allyesconfig    gcc-12
i386       buildonly-randconfig-001-20250815    gcc-12
i386       buildonly-randconfig-001-20250816    clang-20
i386       buildonly-randconfig-002-20250815    clang-20
i386       buildonly-randconfig-002-20250816    clang-20
i386       buildonly-randconfig-003-20250815    clang-20
i386       buildonly-randconfig-003-20250816    clang-20
i386       buildonly-randconfig-004-20250815    clang-20
i386       buildonly-randconfig-004-20250816    clang-20
i386       buildonly-randconfig-005-20250815    clang-20
i386       buildonly-randconfig-005-20250816    clang-20
i386       buildonly-randconfig-006-20250815    gcc-12
i386       buildonly-randconfig-006-20250816    clang-20
i386                               defconfig    clang-20
i386                 randconfig-001-20250816    clang-20
i386                 randconfig-002-20250816    clang-20
i386                 randconfig-003-20250816    clang-20
i386                 randconfig-004-20250816    clang-20
i386                 randconfig-005-20250816    clang-20
i386                 randconfig-006-20250816    clang-20
i386                 randconfig-007-20250816    clang-20
i386                 randconfig-011-20250816    clang-20
i386                 randconfig-012-20250816    clang-20
i386                 randconfig-013-20250816    clang-20
i386                 randconfig-014-20250816    clang-20
i386                 randconfig-015-20250816    clang-20
i386                 randconfig-016-20250816    clang-20
i386                 randconfig-017-20250816    clang-20
loongarch                        allnoconfig    clang-22
loongarch            randconfig-001-20250816    clang-22
loongarch            randconfig-002-20250816    clang-22
m68k                       m5307c3_defconfig    gcc-15.1.0
nios2                randconfig-001-20250816    clang-22
nios2                randconfig-002-20250816    clang-22
openrisc                         allnoconfig    clang-22
parisc                           allnoconfig    clang-22
parisc               randconfig-001-20250816    clang-22
parisc               randconfig-002-20250816    clang-22
powerpc                          allnoconfig    clang-22
powerpc                   amigaone_defconfig    gcc-15.1.0
powerpc                      ebony_defconfig    gcc-15.1.0
powerpc                    kmeter1_defconfig    gcc-15.1.0
powerpc                 mpc885_ads_defconfig    gcc-15.1.0
powerpc              randconfig-001-20250816    clang-22
powerpc              randconfig-002-20250816    clang-22
powerpc              randconfig-003-20250816    clang-22
powerpc64            randconfig-001-20250816    clang-22
powerpc64            randconfig-002-20250816    clang-22
powerpc64            randconfig-003-20250816    clang-22
riscv                            allnoconfig    clang-22
riscv                randconfig-001-20250816    clang-22
riscv                randconfig-002-20250816    clang-22
s390                             allnoconfig    clang-22
s390                 randconfig-001-20250816    clang-22
s390                 randconfig-002-20250816    clang-22
sh               ecovec24-romimage_defconfig    gcc-15.1.0
sh                       edosk7705_defconfig    gcc-15.1.0
sh                   randconfig-001-20250816    clang-22
sh                   randconfig-002-20250816    clang-22
sparc                randconfig-001-20250816    clang-22
sparc                randconfig-002-20250816    clang-22
sparc64              randconfig-001-20250816    clang-22
sparc64              randconfig-002-20250816    clang-22
um                               allnoconfig    clang-22
um                   randconfig-001-20250816    clang-22
um                   randconfig-002-20250816    clang-22
x86_64                           allnoconfig    clang-20
x86_64                          allyesconfig    clang-20
x86_64     buildonly-randconfig-001-20250815    clang-20
x86_64     buildonly-randconfig-001-20250816    gcc-12
x86_64     buildonly-randconfig-002-20250815    gcc-12
x86_64     buildonly-randconfig-002-20250816    gcc-12
x86_64     buildonly-randconfig-003-20250815    gcc-12
x86_64     buildonly-randconfig-003-20250816    gcc-12
x86_64     buildonly-randconfig-004-20250815    clang-20
x86_64     buildonly-randconfig-004-20250816    gcc-12
x86_64     buildonly-randconfig-005-20250815    clang-20
x86_64     buildonly-randconfig-005-20250816    gcc-12
x86_64     buildonly-randconfig-006-20250815    gcc-12
x86_64     buildonly-randconfig-006-20250816    gcc-12
x86_64                             defconfig    clang-20
x86_64                             defconfig    gcc-11
x86_64                                 kexec    clang-20
x86_64               randconfig-071-20250816    gcc-11
x86_64               randconfig-072-20250816    gcc-11
x86_64               randconfig-073-20250816    gcc-11
x86_64               randconfig-074-20250816    gcc-11
x86_64               randconfig-075-20250816    gcc-11
x86_64               randconfig-076-20250816    gcc-11
x86_64               randconfig-077-20250816    gcc-11
x86_64               randconfig-078-20250816    gcc-11
x86_64                              rhel-9.4    clang-20
x86_64                         rhel-9.4-func    clang-20
x86_64                   rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-rust    clang-20
xtensa               randconfig-001-20250816    clang-22
xtensa               randconfig-002-20250816    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


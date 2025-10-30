Return-Path: <linux-kernel+bounces-878149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A156CC1FE41
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D10C1A224EE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A9C340A43;
	Thu, 30 Oct 2025 11:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D/1tbkSz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6792E5429
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761825248; cv=none; b=uXYQ1aKbVRiQS7vmoYvD136Rk/2pzUqlY6meDSnZrQYRkVFAUWeJ64cHSg9bXzjlK4NPCyPM5vDJRiqk0o4I2lnBtcpgsWu3lpvI4YPa/fGfqyefu3JCmRgfzclsUYb67LmYRfLG/EFbOZq/GskPIzOgY7MTJSLOx66zyYHipzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761825248; c=relaxed/simple;
	bh=fQYa+2GSenlFjbukEQRQZlhAqnbtwjLeVKgoQBHNb/8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mxQQivkc7zKwCbn73pWXhvAw8OKhXBKQmG3a0pFcAYYRXXvZ1SkXteUEq5GWYNdLBOE/LrVWibEoaUi8OX+rGT4iNoIgoMrcg96psCHG2JYMqtpWVt/8h9ac/LmnhpfXWFsMDQgsP0fz6U6R8sZTHKjtkWpkaiX/2UdMHTLCFls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D/1tbkSz; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761825246; x=1793361246;
  h=date:from:to:cc:subject:message-id;
  bh=fQYa+2GSenlFjbukEQRQZlhAqnbtwjLeVKgoQBHNb/8=;
  b=D/1tbkSzJkICgVqlXNfY5tFZTysCdkNfOkHGl8jU2vjLclNHqZ2U0x5E
   Q+2fuVdYY1LRB6T07ZbGKLOIXKLYj+C4B6rwRr8W90wwl7ZEkMbQUBgba
   8sLdTzdmhdnGmn4XMn8Ln8QZZx+F6pMaeKnCSzV1dHA/zQPZ9Rbs0NsXL
   E3Ym6r/DTUKVq2oQBVEc989wIvRelNMDIgPUqGcNY8MX6uFvZ99xf7G1O
   27yxINePOVyn8oT9lnCDe9Oq0knFq78TvayJeb7xHUIo9fcfJAi+LlcsO
   gfMgUwkZHu8CLiA/MrpkE0N49xn6RLNGlmV0OxaU0PN8KHW8UBPK790WN
   g==;
X-CSE-ConnectionGUID: S1GFCQvBS1Om1VUebL5ohw==
X-CSE-MsgGUID: Yj3qzP23QC62+GhG8XToaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63892760"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63892760"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 04:54:06 -0700
X-CSE-ConnectionGUID: CuTjqQzcRKaj4XW0cOuoVw==
X-CSE-MsgGUID: FAnCyMKbSDKf0cLV6YL2Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="185593334"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 30 Oct 2025 04:54:05 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vEREA-000LwY-2Z;
	Thu, 30 Oct 2025 11:54:02 +0000
Date: Thu, 30 Oct 2025 19:49:10 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 f4c12e5cefc8ec2eda93bc17ea734407228449ab
Message-ID: <202510301905.oHSIk6E4-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/urgent
branch HEAD: f4c12e5cefc8ec2eda93bc17ea734407228449ab  perf/x86/intel/uncore: Add uncore PMU support for Wildcat Lake

elapsed time: 1466m

configs tested: 161
configs skipped: 121

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig    clang-19
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                              allyesconfig    clang-19
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251030    gcc-11.5.0
arc                   randconfig-002-20251030    gcc-11.5.0
arm                              allmodconfig    clang-19
arm                              allyesconfig    clang-19
arm                                 defconfig    gcc-15.1.0
arm                   randconfig-001-20251030    gcc-11.5.0
arm                   randconfig-002-20251030    gcc-11.5.0
arm                   randconfig-003-20251030    gcc-11.5.0
arm                   randconfig-004-20251030    gcc-11.5.0
arm                           sama5_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251030    clang-17
arm64                 randconfig-002-20251030    clang-17
arm64                 randconfig-003-20251030    clang-17
arm64                 randconfig-004-20251030    clang-17
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251030    clang-17
csky                  randconfig-002-20251030    clang-17
hexagon                          allmodconfig    clang-19
hexagon                          allyesconfig    clang-19
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20251030    clang-22
hexagon               randconfig-002-20251030    clang-22
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251030    gcc-14
i386        buildonly-randconfig-002-20251030    gcc-14
i386        buildonly-randconfig-003-20251030    gcc-14
i386        buildonly-randconfig-004-20251030    gcc-14
i386        buildonly-randconfig-005-20251030    gcc-14
i386        buildonly-randconfig-006-20251030    gcc-14
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20251030    clang-20
i386                  randconfig-002-20251030    clang-20
i386                  randconfig-003-20251030    clang-20
i386                  randconfig-004-20251030    clang-20
i386                  randconfig-005-20251030    clang-20
i386                  randconfig-006-20251030    clang-20
i386                  randconfig-007-20251030    clang-20
i386                  randconfig-011-20251030    gcc-14
i386                  randconfig-012-20251030    gcc-14
i386                  randconfig-013-20251030    gcc-14
i386                  randconfig-014-20251030    gcc-14
i386                  randconfig-015-20251030    gcc-14
i386                  randconfig-016-20251030    gcc-14
i386                  randconfig-017-20251030    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251030    clang-22
loongarch             randconfig-002-20251030    clang-22
m68k                             allmodconfig    clang-19
m68k                             allyesconfig    clang-19
m68k                                defconfig    clang-19
m68k                            mac_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allyesconfig    clang-19
microblaze                          defconfig    clang-19
nios2                            allmodconfig    clang-22
nios2                            allyesconfig    clang-22
nios2                               defconfig    clang-19
nios2                 randconfig-001-20251030    clang-22
nios2                 randconfig-002-20251030    clang-22
openrisc                         allmodconfig    clang-22
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251030    clang-22
parisc                randconfig-002-20251030    clang-22
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                    gamecube_defconfig    gcc-15.1.0
powerpc                        icon_defconfig    gcc-15.1.0
powerpc                     ksi8560_defconfig    gcc-15.1.0
powerpc                      mgcoge_defconfig    gcc-15.1.0
powerpc                      ppc44x_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251030    clang-22
powerpc               randconfig-002-20251030    clang-22
powerpc                     redwood_defconfig    gcc-15.1.0
powerpc                  storcenter_defconfig    gcc-15.1.0
powerpc                      tqm8xx_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251030    clang-22
powerpc64             randconfig-002-20251030    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-15.1.0
riscv                 randconfig-001-20251030    gcc-15.1.0
riscv                 randconfig-002-20251030    gcc-15.1.0
s390                             allmodconfig    gcc-15.1.0
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20251030    gcc-15.1.0
s390                  randconfig-002-20251030    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                          lboxre2_defconfig    gcc-15.1.0
sh                            migor_defconfig    gcc-15.1.0
sh                    randconfig-001-20251030    gcc-15.1.0
sh                    randconfig-002-20251030    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                            allyesconfig    clang-22
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251030    gcc-11.5.0
sparc                 randconfig-002-20251030    gcc-11.5.0
sparc64                          allmodconfig    clang-22
sparc64                          allyesconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251030    gcc-11.5.0
sparc64               randconfig-002-20251030    gcc-11.5.0
um                               allmodconfig    clang-19
um                               allyesconfig    clang-19
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251030    gcc-11.5.0
um                    randconfig-002-20251030    gcc-11.5.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251030    clang-20
x86_64      buildonly-randconfig-002-20251030    clang-20
x86_64      buildonly-randconfig-003-20251030    clang-20
x86_64      buildonly-randconfig-004-20251030    clang-20
x86_64      buildonly-randconfig-005-20251030    clang-20
x86_64      buildonly-randconfig-006-20251030    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251030    clang-20
x86_64                randconfig-002-20251030    clang-20
x86_64                randconfig-003-20251030    clang-20
x86_64                randconfig-004-20251030    clang-20
x86_64                randconfig-005-20251030    clang-20
x86_64                randconfig-006-20251030    clang-20
x86_64                randconfig-011-20251030    clang-20
x86_64                randconfig-012-20251030    clang-20
x86_64                randconfig-013-20251030    clang-20
x86_64                randconfig-014-20251030    clang-20
x86_64                randconfig-015-20251030    clang-20
x86_64                randconfig-016-20251030    clang-20
x86_64                randconfig-071-20251030    gcc-14
x86_64                randconfig-072-20251030    gcc-14
x86_64                randconfig-073-20251030    gcc-14
x86_64                randconfig-074-20251030    gcc-14
x86_64                randconfig-075-20251030    gcc-14
x86_64                randconfig-076-20251030    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
xtensa                           allyesconfig    clang-22
xtensa                          iss_defconfig    gcc-15.1.0
xtensa                randconfig-001-20251030    gcc-11.5.0
xtensa                randconfig-002-20251030    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


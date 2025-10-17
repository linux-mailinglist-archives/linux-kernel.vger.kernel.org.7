Return-Path: <linux-kernel+bounces-858025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEA1BE89AB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85B5E62077B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBAC32ABDB;
	Fri, 17 Oct 2025 12:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F0IX6/UM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563F52DC328
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 12:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760704511; cv=none; b=hyP2RPYbv+8gcWMah4unxUhjVJg5ZqLLpP2BS3RD/VUarwdnvZFKV01DJSeNEa4VP8Ij8b8je0/+rjfJuvn2KJve9EHrOKzWDm3Miafb9212dx2XPgfQcuK5pwTMdeJkBjERPLVgYwHpSS4gPYBHSAoeix5rKvcy2qWYlYCJrU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760704511; c=relaxed/simple;
	bh=iaw1jVnnLuJts76p7DSureSsQ4Z0cgkcTp8t5SENrMQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Pst5mnLRCDVdvwnjqmG1tQxpPlOsIRWmsmnoQBiTPO4XhDNQwthclg/PiWGLDbV4Jq+U+B/BaOvmGAeWY5ysYlxVLvi0T+TfGXW5AZob5K6FgrUc7TjYjVscXMVDuyOZhMFXoJLjXjQtpCM+3pXLuqcpV2WDyAv9gGc918hYUCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F0IX6/UM; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760704509; x=1792240509;
  h=date:from:to:cc:subject:message-id;
  bh=iaw1jVnnLuJts76p7DSureSsQ4Z0cgkcTp8t5SENrMQ=;
  b=F0IX6/UMKXZpmpms3tO11Gmij0+DRgUuW2HCn+YGs2UfDm8fpEb9v9Mt
   ep+dUqSJ+ISDu+Oimxtpelfp6ne5qtqGY4JPvsEL7TaHo9375VhctO987
   wkHshntN3nhIIXZ4UeeMN4ItFal3UG3lvS9yYro7U+pIwTm4EinUkajIO
   GvpNyfE+EKazLaRrLRr/KRHbnvyfoGhMRRrbQXoYdfHAd3GmPhhCvQQuk
   gcZr5qN3Wr8WhIlA6OxbxZadEyJPHLJyd6obQQn1sTG2Y7zLJ/dgN8TF6
   NoxTI/ZrM7HQvbCJCsZrpg/B1yOWdlPyyfZEBPMeNfMaF/gg5mknJ2qW4
   g==;
X-CSE-ConnectionGUID: HjdyEVTgSN6n61d3GTouew==
X-CSE-MsgGUID: f/fFejWeSSOWh1cI42QEdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="50481081"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="50481081"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 05:35:08 -0700
X-CSE-ConnectionGUID: 4QMp3L2HS22vOTdr9QJ9qw==
X-CSE-MsgGUID: 5RpQV9DJRtWOkf/j4FFuUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="182670102"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 17 Oct 2025 05:35:06 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9jfk-0005xf-21;
	Fri, 17 Oct 2025 12:35:04 +0000
Date: Fri, 17 Oct 2025 20:34:13 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/sgx] BUILD SUCCESS
 0f2753efc5baff2f0b2a921fe77990c7b12955dc
Message-ID: <202510172007.S9oNha9P-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sgx
branch HEAD: 0f2753efc5baff2f0b2a921fe77990c7b12955dc  x86/sgx: Enable automatic SVN updates for SGX enclaves

elapsed time: 826m

configs tested: 158
configs skipped: 125

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                               defconfig    clang-19
arc                               allnoconfig    clang-22
arc                                 defconfig    clang-19
arc                   randconfig-001-20251017    clang-22
arc                   randconfig-002-20251017    clang-22
arm                               allnoconfig    clang-22
arm                                 defconfig    clang-19
arm                      integrator_defconfig    gcc-15.1.0
arm                   randconfig-001-20251017    clang-22
arm                   randconfig-002-20251017    clang-22
arm                   randconfig-003-20251017    clang-22
arm                   randconfig-004-20251017    clang-22
arm64                             allnoconfig    clang-22
arm64                               defconfig    clang-19
arm64                 randconfig-001-20251017    clang-22
arm64                 randconfig-002-20251017    clang-22
arm64                 randconfig-003-20251017    clang-22
arm64                 randconfig-004-20251017    clang-22
csky                              allnoconfig    clang-22
csky                                defconfig    clang-19
csky                  randconfig-001-20251017    gcc-15.1.0
csky                  randconfig-002-20251017    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20251017    gcc-15.1.0
hexagon               randconfig-002-20251017    gcc-15.1.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20251017    clang-20
i386        buildonly-randconfig-002-20251017    clang-20
i386        buildonly-randconfig-003-20251017    clang-20
i386        buildonly-randconfig-004-20251017    clang-20
i386        buildonly-randconfig-005-20251017    clang-20
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
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251017    gcc-15.1.0
loongarch             randconfig-002-20251017    gcc-15.1.0
m68k                             allmodconfig    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        bcm63xx_defconfig    gcc-15.1.0
mips                           jazz_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20251017    gcc-15.1.0
nios2                 randconfig-002-20251017    gcc-15.1.0
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-14
parisc                            allnoconfig    clang-22
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251017    gcc-15.1.0
parisc                randconfig-002-20251017    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc               randconfig-001-20251017    gcc-15.1.0
powerpc               randconfig-002-20251017    gcc-15.1.0
powerpc               randconfig-003-20251017    gcc-15.1.0
powerpc64             randconfig-001-20251017    gcc-15.1.0
powerpc64             randconfig-002-20251017    gcc-15.1.0
powerpc64             randconfig-003-20251017    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20251017    clang-22
riscv                 randconfig-002-20251017    clang-22
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20251017    clang-22
s390                  randconfig-002-20251017    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                          kfr2r09_defconfig    gcc-15.1.0
sh                    randconfig-001-20251017    clang-22
sh                    randconfig-002-20251017    clang-22
sh                           se7712_defconfig    gcc-15.1.0
sh                           sh2007_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251017    clang-22
sparc                 randconfig-002-20251017    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251017    clang-22
sparc64               randconfig-002-20251017    clang-22
um                                allnoconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             i386_defconfig    gcc-15.1.0
um                    randconfig-001-20251017    clang-22
um                    randconfig-002-20251017    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251017    clang-20
x86_64      buildonly-randconfig-001-20251017    gcc-14
x86_64      buildonly-randconfig-002-20251017    clang-20
x86_64      buildonly-randconfig-002-20251017    gcc-14
x86_64      buildonly-randconfig-003-20251017    clang-20
x86_64      buildonly-randconfig-004-20251017    clang-20
x86_64      buildonly-randconfig-004-20251017    gcc-14
x86_64      buildonly-randconfig-005-20251017    clang-20
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
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251017    clang-22
xtensa                randconfig-002-20251017    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


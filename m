Return-Path: <linux-kernel+bounces-847897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 788C2BCBF80
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDA973B0EA6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 07:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463F323ED5B;
	Fri, 10 Oct 2025 07:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bDK2y65Y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451B91531C1
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760082430; cv=none; b=bf8yGdEEPXGJ49mHUa8GCUhJ20nzviVySDsMCpjTZggh2UBdr8nF2lFfySNwHyhgExq4yju5rCUW4HgIov6c90E3Qa8T31gJF1OZMN6aRaPueAYUail0xHmM2aTkksJBngOkb6/QVSV0OJ2lIoirDAsbiKWuTsu0txvsUbbeVog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760082430; c=relaxed/simple;
	bh=W3dOsgbtTI4mJEylSFndcpS+ycygr2/i8AMpxGspctE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=L1/zFd9VfFFzzNxVFtHlwe3FM8ypPqqQLWgoBWd5fd4Tpwh20P+aIKRVbTfvUssAx4KAAX2NOx3rdCeENqHlcKICP1LP21O6Tnws5ktSBS7pB7XdQnwUHqJaWgX33Jd+MdYEg7LNfjuN3e/fGHCFeGnG1j5g1cxhhRgQ6tRILHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bDK2y65Y; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760082428; x=1791618428;
  h=date:from:to:cc:subject:message-id;
  bh=W3dOsgbtTI4mJEylSFndcpS+ycygr2/i8AMpxGspctE=;
  b=bDK2y65YRKL9Lk1umdGc1MnbThrKC0WDlvoSwUp+XaqG+A2Tu+zZBEFs
   UHp8cr6lnoHViT3pxumZ9cWBV3Ue2xSfPM+ptlB5N7RM2TGBw3WXu7aV0
   3SP6dMoXYY7GZOmWIHKmqrxShOVudHqVm5QKpIJEUs8Y1Ej8ZGCwe2ToO
   pSSHUG/hFmSst6Zncdh0TOJKDGhI6XzEK2HX8YlDCFlI7UWIoTE2pMDWR
   +LeRedUkWFEpaCIZTh02hAV8RWGrlhEtmoplz+rtnUo3NJwhfVe3zhvlf
   3TlsqLAP/voeKPZKu6TelTWCeAtdDWKR/1GHELxRB52vDbA47UEEcn5Sd
   g==;
X-CSE-ConnectionGUID: Fgkqt8OfTh6YhkVQ1DuexA==
X-CSE-MsgGUID: NijNQQgQRsiEaAEreMB1Xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="79942751"
X-IronPort-AV: E=Sophos;i="6.19,218,1754982000"; 
   d="scan'208";a="79942751"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 00:47:07 -0700
X-CSE-ConnectionGUID: V0AvF/ERTGGRjy7whdDr3A==
X-CSE-MsgGUID: u96JIBz0RfWYWYqr0ML4Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,218,1754982000"; 
   d="scan'208";a="180503918"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 10 Oct 2025 00:47:05 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v77qA-0002QZ-2X;
	Fri, 10 Oct 2025 07:47:02 +0000
Date: Fri, 10 Oct 2025 15:46:28 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20251009] BUILD REGRESSION
 0a843be7c99be610223cafd649d9ab645ce4cd89
Message-ID: <202510101517.PeMduGni-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20251009
branch HEAD: 0a843be7c99be610223cafd649d9ab645ce4cd89  scsi: libsas/aci94xx: Avoid multiple -Wflex-array-member-not-at-end warnings

Error/Warning (recently discovered and may have been fixed):

    include/linux/stddef.h:16:33: error: expected declaration specifiers or '...' before '__builtin_offsetof'
    include/scsi/sas.h:365:14: error: a function declaration without a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
    include/scsi/sas.h:365:15: error: expected ')'
    include/scsi/sas.h:365:15: error: expected parameter declarator
    include/scsi/sas.h:365:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
    include/scsi/sas.h:366:15: error: expected declaration specifiers or '...' before string constant

Error/Warning ids grouped by kconfigs:

recent_errors
|-- i386-allmodconfig
|   |-- include-linux-stddef.h:error:expected-declaration-specifiers-or-...-before-__builtin_offsetof
|   `-- include-scsi-sas.h:error:expected-declaration-specifiers-or-...-before-string-constant
|-- i386-allyesconfig
|   |-- include-linux-stddef.h:error:expected-declaration-specifiers-or-...-before-__builtin_offsetof
|   `-- include-scsi-sas.h:error:expected-declaration-specifiers-or-...-before-string-constant
|-- x86_64-allyesconfig
|   |-- include-scsi-sas.h:error:a-function-declaration-without-a-prototype-is-deprecated-in-all-versions-of-C-Werror-Wstrict-prototypes
|   |-- include-scsi-sas.h:error:expected-)
|   |-- include-scsi-sas.h:error:expected-parameter-declarator
|   `-- include-scsi-sas.h:error:type-specifier-missing-defaults-to-int-ISO-C99-and-later-do-not-support-implicit-int
|-- x86_64-buildonly-randconfig-004-20251010
|   |-- include-scsi-sas.h:error:a-function-declaration-without-a-prototype-is-deprecated-in-all-versions-of-C-Werror-Wstrict-prototypes
|   |-- include-scsi-sas.h:error:expected-)
|   |-- include-scsi-sas.h:error:expected-parameter-declarator
|   `-- include-scsi-sas.h:error:type-specifier-missing-defaults-to-int-ISO-C99-and-later-do-not-support-implicit-int
|-- x86_64-kexec
|   |-- include-scsi-sas.h:error:a-function-declaration-without-a-prototype-is-deprecated-in-all-versions-of-C-Werror-Wstrict-prototypes
|   |-- include-scsi-sas.h:error:expected-)
|   |-- include-scsi-sas.h:error:expected-parameter-declarator
|   `-- include-scsi-sas.h:error:type-specifier-missing-defaults-to-int-ISO-C99-and-later-do-not-support-implicit-int
|-- x86_64-randconfig-001-20251010
|   |-- include-scsi-sas.h:error:a-function-declaration-without-a-prototype-is-deprecated-in-all-versions-of-C-Werror-Wstrict-prototypes
|   |-- include-scsi-sas.h:error:expected-)
|   |-- include-scsi-sas.h:error:expected-parameter-declarator
|   `-- include-scsi-sas.h:error:type-specifier-missing-defaults-to-int-ISO-C99-and-later-do-not-support-implicit-int
|-- x86_64-randconfig-005-20251010
|   |-- include-scsi-sas.h:error:a-function-declaration-without-a-prototype-is-deprecated-in-all-versions-of-C-Werror-Wstrict-prototypes
|   |-- include-scsi-sas.h:error:expected-)
|   |-- include-scsi-sas.h:error:expected-parameter-declarator
|   `-- include-scsi-sas.h:error:type-specifier-missing-defaults-to-int-ISO-C99-and-later-do-not-support-implicit-int
|-- x86_64-randconfig-071-20251010
|   |-- include-scsi-sas.h:error:a-function-declaration-without-a-prototype-is-deprecated-in-all-versions-of-C-Werror-Wstrict-prototypes
|   |-- include-scsi-sas.h:error:expected-)
|   |-- include-scsi-sas.h:error:expected-parameter-declarator
|   `-- include-scsi-sas.h:error:type-specifier-missing-defaults-to-int-ISO-C99-and-later-do-not-support-implicit-int
|-- x86_64-randconfig-075-20251010
|   |-- include-scsi-sas.h:error:a-function-declaration-without-a-prototype-is-deprecated-in-all-versions-of-C-Werror-Wstrict-prototypes
|   |-- include-scsi-sas.h:error:expected-)
|   |-- include-scsi-sas.h:error:expected-parameter-declarator
|   `-- include-scsi-sas.h:error:type-specifier-missing-defaults-to-int-ISO-C99-and-later-do-not-support-implicit-int
|-- x86_64-rhel-9.4
|   |-- include-linux-stddef.h:error:expected-declaration-specifiers-or-...-before-__builtin_offsetof
|   `-- include-scsi-sas.h:error:expected-declaration-specifiers-or-...-before-string-constant
|-- x86_64-rhel-9.4-bpf
|   |-- include-linux-stddef.h:error:expected-declaration-specifiers-or-...-before-__builtin_offsetof
|   `-- include-scsi-sas.h:error:expected-declaration-specifiers-or-...-before-string-constant
|-- x86_64-rhel-9.4-func
|   |-- include-linux-stddef.h:error:expected-declaration-specifiers-or-...-before-__builtin_offsetof
|   `-- include-scsi-sas.h:error:expected-declaration-specifiers-or-...-before-string-constant
|-- x86_64-rhel-9.4-kselftests
|   |-- include-linux-stddef.h:error:expected-declaration-specifiers-or-...-before-__builtin_offsetof
|   `-- include-scsi-sas.h:error:expected-declaration-specifiers-or-...-before-string-constant
|-- x86_64-rhel-9.4-kunit
|   |-- include-linux-stddef.h:error:expected-declaration-specifiers-or-...-before-__builtin_offsetof
|   `-- include-scsi-sas.h:error:expected-declaration-specifiers-or-...-before-string-constant
`-- x86_64-rhel-9.4-ltp
    |-- include-linux-stddef.h:error:expected-declaration-specifiers-or-...-before-__builtin_offsetof
    `-- include-scsi-sas.h:error:expected-declaration-specifiers-or-...-before-string-constant

elapsed time: 1115m

configs tested: 202
configs skipped: 3

tested configs:
alpha                             allnoconfig    clang-22
alpha                            allyesconfig    clang-19
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-22
arc                              allyesconfig    clang-19
arc                                 defconfig    clang-19
arc                   randconfig-001-20251010    gcc-12.5.0
arc                   randconfig-001-20251010    gcc-8.5.0
arc                   randconfig-002-20251010    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                         bcm2835_defconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                      integrator_defconfig    gcc-15.1.0
arm                   randconfig-001-20251010    gcc-8.5.0
arm                   randconfig-002-20251010    gcc-13.4.0
arm                   randconfig-002-20251010    gcc-8.5.0
arm                   randconfig-003-20251010    gcc-8.5.0
arm                   randconfig-004-20251010    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                               defconfig    clang-19
arm64                 randconfig-001-20251010    gcc-14.3.0
arm64                 randconfig-001-20251010    gcc-8.5.0
arm64                 randconfig-002-20251010    clang-19
arm64                 randconfig-002-20251010    gcc-8.5.0
arm64                 randconfig-003-20251010    clang-17
arm64                 randconfig-003-20251010    gcc-8.5.0
arm64                 randconfig-004-20251010    gcc-15.1.0
arm64                 randconfig-004-20251010    gcc-8.5.0
csky                              allnoconfig    clang-22
csky                                defconfig    clang-19
csky                  randconfig-001-20251010    gcc-14.3.0
csky                  randconfig-002-20251010    gcc-14.3.0
hexagon                          alldefconfig    clang-22
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20251010    gcc-14.3.0
hexagon               randconfig-002-20251010    gcc-14.3.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20251010    gcc-14
i386        buildonly-randconfig-002-20251010    gcc-14
i386        buildonly-randconfig-003-20251010    gcc-14
i386        buildonly-randconfig-004-20251010    gcc-14
i386        buildonly-randconfig-005-20251010    gcc-14
i386        buildonly-randconfig-006-20251010    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251010    clang-20
i386                  randconfig-002-20251010    clang-20
i386                  randconfig-003-20251010    clang-20
i386                  randconfig-004-20251010    clang-20
i386                  randconfig-005-20251010    clang-20
i386                  randconfig-006-20251010    clang-20
i386                  randconfig-007-20251010    clang-20
i386                  randconfig-011-20251010    gcc-14
i386                  randconfig-012-20251010    gcc-14
i386                  randconfig-013-20251010    gcc-14
i386                  randconfig-014-20251010    gcc-14
i386                  randconfig-015-20251010    gcc-14
i386                  randconfig-016-20251010    gcc-14
i386                  randconfig-017-20251010    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251010    gcc-14.3.0
loongarch             randconfig-002-20251010    gcc-14.3.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                          sun3x_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          eyeq5_defconfig    clang-22
mips                           gcw0_defconfig    gcc-15.1.0
mips                           ip22_defconfig    clang-22
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20251010    gcc-14.3.0
nios2                 randconfig-002-20251010    gcc-14.3.0
openrisc                          allnoconfig    clang-22
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
openrisc                  or1klitex_defconfig    clang-22
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251010    gcc-14.3.0
parisc                randconfig-002-20251010    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                      mgcoge_defconfig    clang-22
powerpc                      pasemi_defconfig    clang-22
powerpc               randconfig-001-20251010    gcc-14.3.0
powerpc               randconfig-002-20251010    gcc-14.3.0
powerpc               randconfig-003-20251010    gcc-14.3.0
powerpc64             randconfig-001-20251010    gcc-14.3.0
powerpc64             randconfig-002-20251010    gcc-14.3.0
powerpc64             randconfig-003-20251010    gcc-14.3.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                    nommu_k210_defconfig    gcc-15.1.0
riscv                 randconfig-001-20251010    clang-22
riscv                 randconfig-001-20251010    gcc-9.5.0
riscv                 randconfig-002-20251010    gcc-9.5.0
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20251010    gcc-14.3.0
s390                  randconfig-001-20251010    gcc-9.5.0
s390                  randconfig-002-20251010    clang-22
s390                  randconfig-002-20251010    gcc-9.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20251010    gcc-15.1.0
sh                    randconfig-001-20251010    gcc-9.5.0
sh                    randconfig-002-20251010    gcc-15.1.0
sh                    randconfig-002-20251010    gcc-9.5.0
sh                           se7721_defconfig    clang-22
sh                            shmin_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251010    gcc-11.5.0
sparc                 randconfig-001-20251010    gcc-9.5.0
sparc                 randconfig-002-20251010    gcc-8.5.0
sparc                 randconfig-002-20251010    gcc-9.5.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251010    clang-20
sparc64               randconfig-001-20251010    gcc-9.5.0
sparc64               randconfig-002-20251010    gcc-10.5.0
sparc64               randconfig-002-20251010    gcc-9.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251010    gcc-14
um                    randconfig-001-20251010    gcc-9.5.0
um                    randconfig-002-20251010    gcc-14
um                    randconfig-002-20251010    gcc-9.5.0
um                           x86_64_defconfig    gcc-14
um                           x86_64_defconfig    gcc-15.1.0
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251010    gcc-14
x86_64      buildonly-randconfig-002-20251010    gcc-14
x86_64      buildonly-randconfig-003-20251010    gcc-14
x86_64      buildonly-randconfig-004-20251010    gcc-14
x86_64      buildonly-randconfig-005-20251010    gcc-14
x86_64      buildonly-randconfig-006-20251010    gcc-14
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251010    clang-20
x86_64                randconfig-002-20251010    clang-20
x86_64                randconfig-003-20251010    clang-20
x86_64                randconfig-004-20251010    clang-20
x86_64                randconfig-005-20251010    clang-20
x86_64                randconfig-006-20251010    clang-20
x86_64                randconfig-007-20251010    clang-20
x86_64                randconfig-008-20251010    clang-20
x86_64                randconfig-071-20251010    clang-20
x86_64                randconfig-072-20251010    clang-20
x86_64                randconfig-073-20251010    clang-20
x86_64                randconfig-074-20251010    clang-20
x86_64                randconfig-075-20251010    clang-20
x86_64                randconfig-076-20251010    clang-20
x86_64                randconfig-077-20251010    clang-20
x86_64                randconfig-078-20251010    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                generic_kc705_defconfig    gcc-15.1.0
xtensa                randconfig-001-20251010    gcc-8.5.0
xtensa                randconfig-001-20251010    gcc-9.5.0
xtensa                randconfig-002-20251010    gcc-9.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


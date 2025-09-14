Return-Path: <linux-kernel+bounces-815543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C28B567F0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 13:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EFDB1743EB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 11:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC8E245032;
	Sun, 14 Sep 2025 11:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SYRKMfpe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FF62BD11
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 11:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757849775; cv=none; b=tFgs5nN5oYCxp4HBuEnezRmQpkVzFqQOA2+12VWMbFM3rGFxoPQyzrUhSXjBfl3O5uZLF8IN8Bj/q/+I/386AuNOpBcdIx6jA5+6VyoGJD2pzMUfjJDFbL/GzbSp1E0bFz8V/h8OQMzOxJsAt1NndXLnXOJ2j5pwcYjd3diVNjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757849775; c=relaxed/simple;
	bh=7TB5u42U7w1XGrMhSkYZStbIhNGRSQ2J4XdDzvqJx/E=;
	h=Date:From:To:Cc:Subject:Message-ID; b=gY5VTmgnSQtbut97wmAIsXXGxpA31KYA6h6CsuztDEkcyUhMgHXRfMtjyDE8XlFyesp1RQhI4Ede7clez/drTgXdgHhNmywo7FnFwOWy/HfLMQyPdlq+GnNw6iHdQSs0xc8e8DkUTen9vNWXsb7duE8MidXmT/QBe8o6/RI0aIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SYRKMfpe; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757849774; x=1789385774;
  h=date:from:to:cc:subject:message-id;
  bh=7TB5u42U7w1XGrMhSkYZStbIhNGRSQ2J4XdDzvqJx/E=;
  b=SYRKMfpebOycUhm9UQATYydobAESFRyuKNUFMwqitQXxPs4HAlZS/wgZ
   5nKEozw3DgyPhoAZlgAmq9I4upcKIy1ElvfQXV+RSA86UHOkQHbxGh1ld
   ylLCEvS1pv5ExEPk9FES3Kl7IDzyodTakSKeXnt5sXo1rU5nsbbX0auT5
   I79s52gjHJ1sEzD0jN8ZWU0NYhxRi+Js2DVqbm40EI2O5UgwqeiAEahKQ
   Pgy13oyBDQUHf2u7vWdfstYIiPM7+PQ0Ccezy2+SxZpcau8vzwX011D7r
   JvKCrsSOQKHoJG+WqQjbAra3OBoFYC587/N3uuTy/tWYOWP3ydwav63GF
   g==;
X-CSE-ConnectionGUID: FiRGgG+QTq+d+8qsFYX/SQ==
X-CSE-MsgGUID: uiTmnRTfSl+SetDEQvgp9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11552"; a="60270814"
X-IronPort-AV: E=Sophos;i="6.18,264,1751266800"; 
   d="scan'208";a="60270814"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2025 04:36:13 -0700
X-CSE-ConnectionGUID: 5tZDb8qLTDes4wmw487Wxw==
X-CSE-MsgGUID: 9nV8NHpsS9qElZoyx95PMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,264,1751266800"; 
   d="scan'208";a="175181846"
Received: from lkp-server02.sh.intel.com (HELO eb5fdfb2a9b7) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 14 Sep 2025 04:36:11 -0700
Received: from kbuild by eb5fdfb2a9b7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uxl1M-0002M0-22;
	Sun, 14 Sep 2025 11:36:07 +0000
Date: Sun, 14 Sep 2025 19:35:18 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD REGRESSION
 502ae97746ab6d7b7b48d54b6a85a11815f390d0
Message-ID: <202509141905.a30i7gF2-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
branch HEAD: 502ae97746ab6d7b7b48d54b6a85a11815f390d0  MAINTAINERS: update atomic infrastructure entry to include Rust

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202509141437.5iiM1sOF-lkp@intel.com

    error[E0425]: cannot find function `atomic64_add` in crate `bindings`
    error[E0425]: cannot find function `atomic64_fetch_add_acquire` in crate `bindings`
    error[E0425]: cannot find function `atomic64_fetch_add_relaxed` in crate `bindings`
    error[E0425]: cannot find function `atomic64_fetch_add_release` in crate `bindings`
    error[E0425]: cannot find function `atomic64_fetch_add` in crate `bindings`
    error[E0425]: cannot find function `atomic64_read_acquire` in crate `bindings`
    error[E0425]: cannot find function `atomic64_read` in crate `bindings`
    error[E0425]: cannot find function `atomic64_set_release` in crate `bindings`
    error[E0425]: cannot find function `atomic64_set` in crate `bindings`
    error[E0425]: cannot find function `atomic64_try_cmpxchg_acquire` in crate `bindings`
    error[E0425]: cannot find function `atomic64_try_cmpxchg_relaxed` in crate `bindings`
    error[E0425]: cannot find function `atomic64_try_cmpxchg_release` in crate `bindings`
    error[E0425]: cannot find function `atomic64_try_cmpxchg` in crate `bindings`
    error[E0425]: cannot find function `atomic64_xchg_acquire` in crate `bindings`
    error[E0425]: cannot find function `atomic64_xchg_relaxed` in crate `bindings`
    error[E0425]: cannot find function `atomic64_xchg_release` in crate `bindings`
    error[E0425]: cannot find function `atomic64_xchg` in crate `bindings`
    error[E0425]: cannot find function `atomic_add` in crate `bindings`
    error[E0425]: cannot find function `atomic_fetch_add_acquire` in crate `bindings`
    error[E0425]: cannot find function `atomic_fetch_add_relaxed` in crate `bindings`
    error[E0425]: cannot find function `atomic_fetch_add_release` in crate `bindings`
    error[E0425]: cannot find function `atomic_fetch_add` in crate `bindings`
    error[E0425]: cannot find function `atomic_read_acquire` in crate `bindings`
    error[E0425]: cannot find function `atomic_read` in crate `bindings`
    error[E0425]: cannot find function `atomic_set_release` in crate `bindings`
    error[E0425]: cannot find function `atomic_set` in crate `bindings`
    error[E0425]: cannot find function `atomic_try_cmpxchg_acquire` in crate `bindings`
    error[E0425]: cannot find function `atomic_try_cmpxchg_relaxed` in crate `bindings`
    error[E0425]: cannot find function `atomic_try_cmpxchg_release` in crate `bindings`
    error[E0425]: cannot find function `atomic_try_cmpxchg` in crate `bindings`
    error[E0425]: cannot find function `atomic_xchg_acquire` in crate `bindings`
    error[E0425]: cannot find function `atomic_xchg_relaxed` in crate `bindings`
    error[E0425]: cannot find function `atomic_xchg_release` in crate `bindings`
    error[E0425]: cannot find function `atomic_xchg` in crate `bindings`

Error/Warning ids grouped by kconfigs:

recent_errors
`-- x86_64-rhel-9.4-rust
    |-- error-E0425:cannot-find-function-atomic64_add-in-crate-bindings
    |-- error-E0425:cannot-find-function-atomic64_fetch_add-in-crate-bindings
    |-- error-E0425:cannot-find-function-atomic64_fetch_add_acquire-in-crate-bindings
    |-- error-E0425:cannot-find-function-atomic64_fetch_add_relaxed-in-crate-bindings
    |-- error-E0425:cannot-find-function-atomic64_fetch_add_release-in-crate-bindings
    |-- error-E0425:cannot-find-function-atomic64_read-in-crate-bindings
    |-- error-E0425:cannot-find-function-atomic64_read_acquire-in-crate-bindings
    |-- error-E0425:cannot-find-function-atomic64_set-in-crate-bindings
    |-- error-E0425:cannot-find-function-atomic64_set_release-in-crate-bindings
    |-- error-E0425:cannot-find-function-atomic64_try_cmpxchg-in-crate-bindings
    |-- error-E0425:cannot-find-function-atomic64_try_cmpxchg_acquire-in-crate-bindings
    |-- error-E0425:cannot-find-function-atomic64_try_cmpxchg_relaxed-in-crate-bindings
    |-- error-E0425:cannot-find-function-atomic64_try_cmpxchg_release-in-crate-bindings
    |-- error-E0425:cannot-find-function-atomic64_xchg-in-crate-bindings
    |-- error-E0425:cannot-find-function-atomic64_xchg_acquire-in-crate-bindings
    |-- error-E0425:cannot-find-function-atomic64_xchg_relaxed-in-crate-bindings
    |-- error-E0425:cannot-find-function-atomic64_xchg_release-in-crate-bindings
    |-- error-E0425:cannot-find-function-atomic_add-in-crate-bindings
    |-- error-E0425:cannot-find-function-atomic_fetch_add-in-crate-bindings
    |-- error-E0425:cannot-find-function-atomic_fetch_add_acquire-in-crate-bindings
    |-- error-E0425:cannot-find-function-atomic_fetch_add_relaxed-in-crate-bindings
    |-- error-E0425:cannot-find-function-atomic_fetch_add_release-in-crate-bindings
    |-- error-E0425:cannot-find-function-atomic_read-in-crate-bindings
    |-- error-E0425:cannot-find-function-atomic_read_acquire-in-crate-bindings
    |-- error-E0425:cannot-find-function-atomic_set-in-crate-bindings
    |-- error-E0425:cannot-find-function-atomic_set_release-in-crate-bindings
    |-- error-E0425:cannot-find-function-atomic_try_cmpxchg-in-crate-bindings
    |-- error-E0425:cannot-find-function-atomic_try_cmpxchg_acquire-in-crate-bindings
    |-- error-E0425:cannot-find-function-atomic_try_cmpxchg_relaxed-in-crate-bindings
    |-- error-E0425:cannot-find-function-atomic_try_cmpxchg_release-in-crate-bindings
    |-- error-E0425:cannot-find-function-atomic_xchg-in-crate-bindings
    |-- error-E0425:cannot-find-function-atomic_xchg_acquire-in-crate-bindings
    |-- error-E0425:cannot-find-function-atomic_xchg_relaxed-in-crate-bindings
    `-- error-E0425:cannot-find-function-atomic_xchg_release-in-crate-bindings

elapsed time: 1452m

configs tested: 192
configs skipped: 3

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                                 defconfig    clang-19
arc                   randconfig-001-20250913    gcc-10.5.0
arc                   randconfig-002-20250913    gcc-11.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                         assabet_defconfig    gcc-14
arm                                 defconfig    clang-19
arm                         orion5x_defconfig    clang-22
arm                   randconfig-001-20250913    clang-20
arm                   randconfig-002-20250913    clang-22
arm                   randconfig-003-20250913    clang-22
arm                   randconfig-004-20250913    gcc-14.3.0
arm                           sunxi_defconfig    gcc-14
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250913    clang-22
arm64                 randconfig-002-20250913    gcc-14.3.0
arm64                 randconfig-003-20250913    clang-22
arm64                 randconfig-004-20250913    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250913    gcc-11.5.0
csky                  randconfig-002-20250913    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250913    clang-16
hexagon               randconfig-002-20250913    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20250913    gcc-14
i386        buildonly-randconfig-002-20250913    clang-20
i386        buildonly-randconfig-003-20250913    clang-20
i386        buildonly-randconfig-004-20250913    clang-20
i386        buildonly-randconfig-005-20250913    clang-20
i386        buildonly-randconfig-006-20250913    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20250914    gcc-14
i386                  randconfig-002-20250914    gcc-14
i386                  randconfig-003-20250914    gcc-14
i386                  randconfig-004-20250914    gcc-14
i386                  randconfig-005-20250914    gcc-14
i386                  randconfig-006-20250914    gcc-14
i386                  randconfig-007-20250914    gcc-14
i386                  randconfig-011-20250914    clang-20
i386                  randconfig-012-20250914    clang-20
i386                  randconfig-013-20250914    clang-20
i386                  randconfig-014-20250914    clang-20
i386                  randconfig-015-20250914    clang-20
i386                  randconfig-016-20250914    clang-20
i386                  randconfig-017-20250914    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch                 loongson3_defconfig    clang-22
loongarch             randconfig-001-20250913    clang-18
loongarch             randconfig-002-20250913    clang-22
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                       m5249evb_defconfig    gcc-14
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          ath79_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250913    gcc-8.5.0
nios2                 randconfig-002-20250913    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
openrisc                 simple_smp_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250913    gcc-12.5.0
parisc                randconfig-002-20250913    gcc-9.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                    gamecube_defconfig    clang-22
powerpc                     mpc5200_defconfig    clang-22
powerpc               randconfig-001-20250913    gcc-8.5.0
powerpc               randconfig-002-20250913    clang-22
powerpc               randconfig-003-20250913    gcc-10.5.0
powerpc64             randconfig-001-20250913    gcc-10.5.0
powerpc64             randconfig-002-20250913    clang-22
powerpc64             randconfig-003-20250913    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20250913    gcc-13.4.0
riscv                 randconfig-002-20250913    clang-20
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20250913    clang-22
s390                  randconfig-002-20250913    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         ap325rxa_defconfig    gcc-14
sh                                  defconfig    gcc-14
sh                ecovec24-romimage_defconfig    gcc-15.1.0
sh                            hp6xx_defconfig    gcc-15.1.0
sh                    randconfig-001-20250913    gcc-9.5.0
sh                    randconfig-002-20250913    gcc-14.3.0
sh                          sdk7780_defconfig    gcc-14
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250913    gcc-15.1.0
sparc                 randconfig-002-20250913    gcc-8.5.0
sparc                       sparc64_defconfig    gcc-14
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20250913    gcc-8.5.0
sparc64               randconfig-002-20250913    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250913    gcc-14
um                    randconfig-002-20250913    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250913    clang-20
x86_64      buildonly-randconfig-002-20250913    gcc-14
x86_64      buildonly-randconfig-003-20250913    gcc-12
x86_64      buildonly-randconfig-004-20250913    gcc-14
x86_64      buildonly-randconfig-005-20250913    clang-20
x86_64      buildonly-randconfig-006-20250913    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250914    clang-20
x86_64                randconfig-002-20250914    clang-20
x86_64                randconfig-003-20250914    clang-20
x86_64                randconfig-004-20250914    clang-20
x86_64                randconfig-005-20250914    clang-20
x86_64                randconfig-006-20250914    clang-20
x86_64                randconfig-007-20250914    clang-20
x86_64                randconfig-008-20250914    clang-20
x86_64                randconfig-071-20250914    gcc-14
x86_64                randconfig-072-20250914    gcc-14
x86_64                randconfig-073-20250914    gcc-14
x86_64                randconfig-074-20250914    gcc-14
x86_64                randconfig-075-20250914    gcc-14
x86_64                randconfig-076-20250914    gcc-14
x86_64                randconfig-077-20250914    gcc-14
x86_64                randconfig-078-20250914    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250913    gcc-14.3.0
xtensa                randconfig-002-20250913    gcc-13.4.0
xtensa                         virt_defconfig    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


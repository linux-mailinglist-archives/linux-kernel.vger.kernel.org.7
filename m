Return-Path: <linux-kernel+bounces-874943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDDAC179A2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 01:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E70C4E8DE7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 00:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3A22D2494;
	Wed, 29 Oct 2025 00:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jVQFVZUp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39C52D2388
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698623; cv=none; b=eKhklxKQwm7ehTXN5PlvLPPLjVLoieZK8tGIUbYb3J6CGXI8khAUKZkQqhFpl6Qy+pmaXR9DXA8SvS3+sEGP3EaIEOz3rG1Yuq738i4t3PffsocD/Fi02JvGXvnExgXvi2NL5nCDJ33O1BOOQLf5uB/i1wZcSRNWlbKVqjoOVbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698623; c=relaxed/simple;
	bh=5H8SFGb33TatrO2IH2WCtDnIzXGFUYdn2GfnlpC9GZI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=umEGKv4saWefKBhIGBBFU6WUD5Nt+waPWgqwxzqzRXWH24ZnywCSK4hbao28xGwV350lno1q+wgjt9dVTmu4W68yA6yl66A4B3Qi7QBbvK7COjNbdnhwTAs/SSNQ7Lr/aDAqLiJCoRP9IQAFgDNuc+lZV+GkpAh4T9Jx6wJkEH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jVQFVZUp; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761698622; x=1793234622;
  h=date:from:to:cc:subject:message-id;
  bh=5H8SFGb33TatrO2IH2WCtDnIzXGFUYdn2GfnlpC9GZI=;
  b=jVQFVZUpQA3wm4UeDGM14Uiup+TjPkJ+mEmuiKnVEVPkT7xA5enU8il3
   0oyxIX+NPl1BxEDUQ23vmq6raqWCc74oYE5UPYRRPC97+blQjIR8Gyj8p
   iR2IF7lPhD9l++WRQxH9SX+2ofNYAwOxqZjMXx1gOKJZihZBb8F1rlwbP
   8CkOpu9aGagsD3DkkU0E8forpNHbYsvaAMBFAafJdtoytxzd6lPT7kMyK
   Qyrp7T1jRgQ4CRFjnjcBLnsARf8Qj5InoLBfyOACyUDnRWWZ+/kKA0W4f
   FSB0TCjjUhZPq+5LwrfGBepvAixp+Wm2wvbe/Nn0NbPsKLNyK+h8ohGfl
   g==;
X-CSE-ConnectionGUID: bAGSqAuUReeNtpPscw/rtw==
X-CSE-MsgGUID: dyCWx/6JQrGs7GStvffFPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63017143"
X-IronPort-AV: E=Sophos;i="6.19,262,1754982000"; 
   d="scan'208";a="63017143"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 17:43:41 -0700
X-CSE-ConnectionGUID: T65zMbSlTSWeEpamf4mfig==
X-CSE-MsgGUID: 4aWk/xVCQLujrbnlUKGbew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,262,1754982000"; 
   d="scan'208";a="185848110"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 28 Oct 2025 17:43:40 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vDuHp-000Jxn-28;
	Wed, 29 Oct 2025 00:43:37 +0000
Date: Wed, 29 Oct 2025 08:42:42 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:tip/urgent] BUILD SUCCESS
 2d8938f51c58f5d552183d3eddcffd1dca9ecbd3
Message-ID: <202510290836.qHyqKy5a-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tip/urgent
branch HEAD: 2d8938f51c58f5d552183d3eddcffd1dca9ecbd3  Merge branch into tip/master: 'x86/urgent'

elapsed time: 1049m

configs tested: 151
configs skipped: 132

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig    clang-19
alpha                               defconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251029    clang-22
arc                   randconfig-002-20251029    clang-22
arm                     am200epdkit_defconfig    gcc-15.1.0
arm                        clps711x_defconfig    gcc-15.1.0
arm                                 defconfig    gcc-15.1.0
arm                   randconfig-001-20251029    clang-22
arm                   randconfig-002-20251029    clang-22
arm                   randconfig-003-20251029    clang-22
arm                   randconfig-004-20251029    clang-22
arm64                            allyesconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251029    gcc-11.5.0
arm64                 randconfig-002-20251029    gcc-11.5.0
arm64                 randconfig-003-20251029    gcc-11.5.0
arm64                 randconfig-004-20251029    gcc-11.5.0
csky                             allmodconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251029    gcc-11.5.0
csky                  randconfig-002-20251029    gcc-11.5.0
hexagon                          allmodconfig    clang-19
hexagon                          allyesconfig    clang-19
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20251029    clang-22
hexagon               randconfig-002-20251029    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20251028    gcc-14
i386        buildonly-randconfig-001-20251029    gcc-14
i386        buildonly-randconfig-002-20251028    gcc-14
i386        buildonly-randconfig-002-20251029    gcc-14
i386        buildonly-randconfig-003-20251028    gcc-14
i386        buildonly-randconfig-003-20251029    gcc-14
i386        buildonly-randconfig-004-20251028    gcc-14
i386        buildonly-randconfig-004-20251029    gcc-14
i386        buildonly-randconfig-005-20251028    gcc-14
i386        buildonly-randconfig-005-20251029    gcc-14
i386        buildonly-randconfig-006-20251028    gcc-14
i386        buildonly-randconfig-006-20251029    gcc-14
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20251028    gcc-14
i386                  randconfig-002-20251028    clang-20
i386                  randconfig-003-20251028    clang-20
i386                  randconfig-004-20251028    clang-20
i386                  randconfig-005-20251028    clang-20
i386                  randconfig-011-20251028    gcc-14
i386                  randconfig-012-20251028    clang-20
i386                  randconfig-013-20251028    clang-20
i386                  randconfig-014-20251028    clang-20
i386                  randconfig-015-20251028    clang-20
loongarch                        allyesconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251029    clang-22
loongarch             randconfig-002-20251029    clang-22
m68k                                defconfig    clang-19
m68k                          hp300_defconfig    gcc-15.1.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20251029    clang-22
nios2                 randconfig-002-20251029    clang-22
openrisc                            defconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251029    gcc-8.5.0
parisc                randconfig-002-20251029    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                      katmai_defconfig    gcc-15.1.0
powerpc                     mpc83xx_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251029    gcc-8.5.0
powerpc               randconfig-002-20251029    gcc-8.5.0
powerpc64             randconfig-001-20251029    gcc-8.5.0
powerpc64             randconfig-002-20251029    gcc-8.5.0
riscv                               defconfig    gcc-15.1.0
s390                             allmodconfig    gcc-15.1.0
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                          landisk_defconfig    gcc-15.1.0
sh                     sh7710voipgw_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251029    clang-22
sparc                 randconfig-002-20251029    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251029    clang-22
sparc64               randconfig-002-20251029    clang-22
um                               allmodconfig    clang-19
um                               allyesconfig    clang-19
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251029    clang-22
um                    randconfig-002-20251029    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251028    gcc-14
x86_64      buildonly-randconfig-001-20251029    clang-20
x86_64      buildonly-randconfig-002-20251028    gcc-14
x86_64      buildonly-randconfig-002-20251029    clang-20
x86_64      buildonly-randconfig-003-20251028    clang-20
x86_64      buildonly-randconfig-003-20251029    clang-20
x86_64      buildonly-randconfig-004-20251028    clang-20
x86_64      buildonly-randconfig-004-20251029    clang-20
x86_64      buildonly-randconfig-005-20251028    clang-20
x86_64      buildonly-randconfig-005-20251029    clang-20
x86_64      buildonly-randconfig-006-20251028    clang-20
x86_64      buildonly-randconfig-006-20251029    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251028    clang-20
x86_64                randconfig-002-20251028    gcc-14
x86_64                randconfig-003-20251028    gcc-14
x86_64                randconfig-004-20251028    gcc-14
x86_64                randconfig-005-20251028    clang-20
x86_64                randconfig-006-20251028    clang-20
x86_64                randconfig-011-20251028    gcc-14
x86_64                randconfig-011-20251029    gcc-13
x86_64                randconfig-012-20251028    gcc-14
x86_64                randconfig-012-20251029    gcc-13
x86_64                randconfig-013-20251028    gcc-12
x86_64                randconfig-013-20251029    gcc-13
x86_64                randconfig-014-20251028    clang-20
x86_64                randconfig-014-20251029    gcc-13
x86_64                randconfig-015-20251028    clang-20
x86_64                randconfig-015-20251029    gcc-13
x86_64                randconfig-016-20251028    clang-20
x86_64                randconfig-016-20251029    gcc-13
x86_64                randconfig-071-20251028    gcc-14
x86_64                randconfig-072-20251028    clang-20
x86_64                randconfig-073-20251028    gcc-14
x86_64                randconfig-074-20251028    gcc-12
x86_64                randconfig-075-20251028    gcc-14
x86_64                randconfig-076-20251028    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                randconfig-001-20251029    clang-22
xtensa                randconfig-002-20251029    clang-22
xtensa                    smp_lx200_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


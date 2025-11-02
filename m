Return-Path: <linux-kernel+bounces-881907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F70FC29311
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 18:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E6FF4E878B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 17:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA59B2DA75C;
	Sun,  2 Nov 2025 17:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I+VI/Ion"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C9F2D978B
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 17:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762102990; cv=none; b=WvksCE862Fbt2qe2FVgoDfJxCvfXjwo3yap3JduoTFl+z4TG3SrPI2zVfgys/RTT3PdmETWTItSaLIa+Cq8fZ5ykT1CPLOX3oa5nLMddqAGEjSDW5cf6SVQ3CBM2VAOriI2kG89jMEWWn1KcKI4tDJ30yoYYy4tRIj68fvpRfv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762102990; c=relaxed/simple;
	bh=Epq/6lgNskjwzo9tq6pZuBsMvulzuNmfsMhTDNhPMo4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Ft/BNxCujOttcwMplshdJKPcCBlOFSJcFulG6Z9m/6D+LQZs8TEkyKp87hthv/EVlO+Uq5ijPP7oKQITquOI3l2u8dL1YLYnDqlXMIYMZCeXvKJ5RNOZQ3xbsJMrTas3384R31wtZNK9/1hc9oyEc7AmAU9CbQgSLlc3faRMxUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I+VI/Ion; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762102989; x=1793638989;
  h=date:from:to:cc:subject:message-id;
  bh=Epq/6lgNskjwzo9tq6pZuBsMvulzuNmfsMhTDNhPMo4=;
  b=I+VI/Ionmy3DTZ4mcX/xXlmHmAn96ejRqy4xBgBMHlvrOa92vS+LJJ9O
   yvRYSAbo9Pel075JBVlXsn78s57CAg/wnajaeAKXgtyo5NoXnjyKCxPOr
   VgUdmqnAAc4x5cMJ1N/kzjwfoDa+01gTCIIaRrBngvjCA+Qkk1bdyr9Ag
   Q4eQI9NN76Zc9C+6I8m6veMIT8NBti59oaJYCBsrFoYK9M64AvIt4UVZY
   8yJxknvy+1g2rf+ytf/eavm/XQDZorvrpvQsrovMfLf83xM/iuRTjQU3l
   3M3kiR7wIyqyf6u/qOiTNrMJrvx/PvF8ScuPgjhXEnZhAs3/TJciIaNIa
   w==;
X-CSE-ConnectionGUID: 4mmQ/xOHT5Co8vtO276kJg==
X-CSE-MsgGUID: X2jmnuxnQgm0/abaGIcsMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="64080275"
X-IronPort-AV: E=Sophos;i="6.19,274,1754982000"; 
   d="scan'208";a="64080275"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2025 09:03:08 -0800
X-CSE-ConnectionGUID: s/2TmiMyQdKOINo0CJDi5w==
X-CSE-MsgGUID: qWUDmAOqRhy67RG3wT2mdQ==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 02 Nov 2025 09:03:06 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vFbTj-000PRI-11;
	Sun, 02 Nov 2025 17:02:58 +0000
Date: Mon, 03 Nov 2025 01:02:04 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS WITH UNVERIFIED WARNING
 ba14500e4bfcab5e841fbf8d7fcbbc80e98d6b9e
Message-ID: <202511030158.182TNiVs-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: ba14500e4bfcab5e841fbf8d7fcbbc80e98d6b9e  timers/migration: Remove dead code handling idle CPU checking for remote timers

Unverified Warning (likely false positive, kindly check if interested):

    kernel/time/timer_migration.c:1729 tmigr_setup_groups() error: we previously assumed 'start' could be null (see line 1630)

Warning ids grouped by kconfigs:

recent_errors
`-- sparc64-randconfig-r072-20251102
    `-- kernel-time-timer_migration.c-tmigr_setup_groups()-error:we-previously-assumed-start-could-be-null-(see-line-)

elapsed time: 1269m

configs tested: 190
configs skipped: 4

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251102    gcc-14.3.0
arc                   randconfig-001-20251102    gcc-8.5.0
arc                   randconfig-002-20251102    gcc-14.3.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                                 defconfig    gcc-15.1.0
arm                         lpc18xx_defconfig    gcc-15.1.0
arm                          pxa910_defconfig    gcc-15.1.0
arm                   randconfig-001-20251102    gcc-14.3.0
arm                   randconfig-001-20251102    gcc-15.1.0
arm                   randconfig-002-20251102    gcc-10.5.0
arm                   randconfig-002-20251102    gcc-14.3.0
arm                   randconfig-003-20251102    gcc-14.3.0
arm                   randconfig-003-20251102    gcc-8.5.0
arm                   randconfig-004-20251102    gcc-14.3.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                            allyesconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251102    gcc-12.5.0
arm64                 randconfig-002-20251102    gcc-12.5.0
arm64                 randconfig-003-20251102    gcc-12.5.0
arm64                 randconfig-004-20251102    gcc-12.5.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251102    gcc-12.5.0
csky                  randconfig-002-20251102    gcc-12.5.0
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20251102    clang-22
hexagon               randconfig-001-20251102    gcc-15.1.0
hexagon               randconfig-002-20251102    clang-22
hexagon               randconfig-002-20251102    gcc-15.1.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20251102    gcc-14
i386        buildonly-randconfig-002-20251102    gcc-14
i386        buildonly-randconfig-003-20251102    gcc-14
i386        buildonly-randconfig-004-20251102    gcc-14
i386        buildonly-randconfig-005-20251102    gcc-14
i386        buildonly-randconfig-006-20251102    gcc-14
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20251102    clang-20
i386                  randconfig-002-20251102    clang-20
i386                  randconfig-003-20251102    clang-20
i386                  randconfig-004-20251102    clang-20
i386                  randconfig-005-20251102    clang-20
i386                  randconfig-006-20251102    clang-20
i386                  randconfig-007-20251102    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                        allyesconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251102    gcc-15.1.0
loongarch             randconfig-002-20251102    gcc-15.1.0
m68k                             allmodconfig    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                                defconfig    clang-19
m68k                       m5249evb_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                            allyesconfig    clang-22
nios2                               defconfig    clang-19
nios2                 randconfig-001-20251102    gcc-11.5.0
nios2                 randconfig-001-20251102    gcc-15.1.0
nios2                 randconfig-002-20251102    gcc-11.5.0
nios2                 randconfig-002-20251102    gcc-15.1.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251102    gcc-8.5.0
parisc                randconfig-002-20251102    gcc-14.3.0
parisc                randconfig-002-20251102    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                   lite5200b_defconfig    gcc-15.1.0
powerpc                  mpc885_ads_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251102    gcc-8.5.0
powerpc               randconfig-001-20251102    gcc-9.5.0
powerpc               randconfig-002-20251102    clang-18
powerpc               randconfig-002-20251102    gcc-8.5.0
powerpc64             randconfig-001-20251102    gcc-14.3.0
powerpc64             randconfig-001-20251102    gcc-8.5.0
powerpc64             randconfig-002-20251102    gcc-8.5.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-15.1.0
riscv                 randconfig-001-20251102    gcc-13.4.0
riscv                 randconfig-002-20251102    gcc-14.3.0
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-15.1.0
s390                  randconfig-002-20251102    gcc-11.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20251102    gcc-13.4.0
sh                    randconfig-002-20251102    gcc-15.1.0
sh                           se7721_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                            allyesconfig    clang-22
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251102    clang-22
sparc                 randconfig-002-20251102    clang-22
sparc64                          allmodconfig    clang-22
sparc64                          allyesconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251102    clang-22
sparc64               randconfig-002-20251102    clang-22
um                               alldefconfig    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251102    clang-22
um                    randconfig-002-20251102    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251102    clang-20
x86_64      buildonly-randconfig-002-20251102    clang-20
x86_64      buildonly-randconfig-003-20251102    clang-20
x86_64      buildonly-randconfig-004-20251102    clang-20
x86_64      buildonly-randconfig-005-20251102    clang-20
x86_64      buildonly-randconfig-006-20251102    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251102    gcc-14
x86_64                randconfig-002-20251102    gcc-14
x86_64                randconfig-003-20251102    gcc-14
x86_64                randconfig-004-20251102    gcc-14
x86_64                randconfig-005-20251102    gcc-14
x86_64                randconfig-006-20251102    gcc-14
x86_64                randconfig-011-20251102    gcc-14
x86_64                randconfig-012-20251102    gcc-14
x86_64                randconfig-013-20251102    gcc-14
x86_64                randconfig-014-20251102    gcc-14
x86_64                randconfig-015-20251102    gcc-14
x86_64                randconfig-016-20251102    gcc-14
x86_64                randconfig-071-20251102    gcc-14
x86_64                randconfig-072-20251102    gcc-14
x86_64                randconfig-073-20251102    gcc-14
x86_64                randconfig-074-20251102    gcc-14
x86_64                randconfig-075-20251102    gcc-14
x86_64                randconfig-076-20251102    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20251102    clang-22
xtensa                randconfig-002-20251102    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-kernel+bounces-808924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CFAB50698
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 21:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51A931C64366
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 19:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F78730506E;
	Tue,  9 Sep 2025 19:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WTfch+T0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B301FE44A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 19:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757447436; cv=none; b=kao9fobGXBbjBF32fFXfMVI3VYZ3YnhHvIqRSpna2q42g0foR1LCjJTarRfIZZa7JTRko/pOWMIrgruOGrOWB+LOioOtPdV+7wYrOUOn2xvwBmYpwGWRTCFlM4EBNR7DTX3x+NE8ABxIlEdADvUUDmXnkq6uRSW0Zp560p0zyZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757447436; c=relaxed/simple;
	bh=5e0D4+/yAxJwNuN4VmXd0Ut+aAfPmlHMHC3SZn2VIjU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=IgbDqhxVoTJNSjXiQAOq1AJOmv55QsiTxtdjlgTnvFK5IZGdmYQlhsjVgPmVMnq5HKsIViYM/UPfJUtJilAOCYhbJmLlk2bfJqrvV59xO0/oOrPjYAvbmTsum/acEQRqCVQIFN1e+rP7tO8YnchAjuaFGZx7I+yGm567A/4dC2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WTfch+T0; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757447435; x=1788983435;
  h=date:from:to:cc:subject:message-id;
  bh=5e0D4+/yAxJwNuN4VmXd0Ut+aAfPmlHMHC3SZn2VIjU=;
  b=WTfch+T0A3hFj7ZTKWFL3C4QETNiv3JpfC3qOJZQPNXwggjV4ApB2NrM
   rIGqweD3Snr8MBX34OrEIKOv5e1KiXS7l1hFw7DjgWp85D9TF34ANEHtS
   KBM62B7sDLtuY+1aY4G96kkChopH2i3tszJM3VIDEPzH8oAdPlJ656p2E
   bAesdyu8n21SecIe9eCRNiZ6bQVKFGojWYsmAvG5iJdAxDagOykhk6nzF
   uhe5JRI2C5TYaWQLlvtXBfx94D/iCKWMJDPBTIl172oqLdTxwyBeAGOsC
   siNtGzHfFsZ+alGRB+41mncJeSNhHod2/2SOhDwkQ9CEU/XfVwAT9V/Th
   A==;
X-CSE-ConnectionGUID: uQoA8uL2TuC70fse+3+sfQ==
X-CSE-MsgGUID: 6bHb38qUQ722uNEJvuuYOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="77198519"
X-IronPort-AV: E=Sophos;i="6.18,252,1751266800"; 
   d="scan'208";a="77198519"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 12:50:31 -0700
X-CSE-ConnectionGUID: iVS/mQ4ATRi6n9qOjGYTcA==
X-CSE-MsgGUID: dGK35osZQUmDY3pHcvHXlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,252,1751266800"; 
   d="scan'208";a="172461299"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 09 Sep 2025 12:50:30 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uw4MF-0005Dg-0M;
	Tue, 09 Sep 2025 19:50:27 +0000
Date: Wed, 10 Sep 2025 03:49:34 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:tip/urgent] BUILD SUCCESS
 e5772453af9bebabe4a44e746ef901c70de66df9
Message-ID: <202509100324.OcfwMlAb-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tip/urgent
branch HEAD: e5772453af9bebabe4a44e746ef901c70de66df9  Merge branch into tip/master: 'x86/urgent'

elapsed time: 782m

configs tested: 132
configs skipped: 119

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
arc                               allnoconfig    clang-22
arc                          axs101_defconfig    gcc-15.1.0
arc                   randconfig-001-20250909    clang-16
arc                   randconfig-002-20250909    clang-16
arm                               allnoconfig    clang-22
arm                   randconfig-001-20250909    clang-16
arm                   randconfig-002-20250909    clang-16
arm                   randconfig-003-20250909    clang-16
arm                   randconfig-004-20250909    clang-16
arm                           spitz_defconfig    gcc-15.1.0
arm64                             allnoconfig    clang-22
arm64                 randconfig-001-20250909    clang-16
arm64                 randconfig-002-20250909    clang-16
arm64                 randconfig-003-20250909    clang-16
arm64                 randconfig-004-20250909    clang-16
csky                              allnoconfig    clang-22
csky                  randconfig-001-20250910    clang-22
csky                  randconfig-002-20250910    clang-22
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20250910    clang-22
hexagon               randconfig-002-20250910    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250909    gcc-13
i386        buildonly-randconfig-001-20250910    clang-20
i386        buildonly-randconfig-002-20250909    clang-20
i386        buildonly-randconfig-002-20250910    clang-20
i386        buildonly-randconfig-003-20250909    clang-20
i386        buildonly-randconfig-003-20250910    clang-20
i386        buildonly-randconfig-004-20250909    clang-20
i386        buildonly-randconfig-004-20250910    clang-20
i386        buildonly-randconfig-005-20250909    clang-20
i386        buildonly-randconfig-005-20250910    clang-20
i386        buildonly-randconfig-006-20250909    clang-20
i386        buildonly-randconfig-006-20250910    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250909    clang-20
i386                  randconfig-002-20250909    clang-20
i386                  randconfig-003-20250909    clang-20
i386                  randconfig-004-20250909    clang-20
i386                  randconfig-005-20250909    clang-20
i386                  randconfig-006-20250909    clang-20
i386                  randconfig-007-20250909    clang-20
i386                  randconfig-011-20250909    gcc-14
i386                  randconfig-012-20250909    gcc-14
i386                  randconfig-013-20250909    gcc-14
i386                  randconfig-014-20250909    gcc-14
i386                  randconfig-015-20250909    gcc-14
i386                  randconfig-016-20250909    gcc-14
i386                  randconfig-017-20250909    gcc-14
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250910    clang-22
loongarch             randconfig-002-20250910    clang-22
m68k                              allnoconfig    gcc-15.1.0
m68k                        m5307c3_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250910    clang-22
nios2                 randconfig-002-20250910    clang-22
openrisc                          allnoconfig    clang-22
parisc                           alldefconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250910    clang-22
parisc                randconfig-002-20250910    clang-22
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                        cell_defconfig    gcc-15.1.0
powerpc                    ge_imp3a_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250910    clang-22
powerpc               randconfig-002-20250910    clang-22
powerpc               randconfig-003-20250910    clang-22
powerpc64             randconfig-002-20250910    clang-22
powerpc64             randconfig-003-20250910    clang-22
riscv                             allnoconfig    clang-22
riscv                 randconfig-001-20250910    gcc-12.5.0
riscv                 randconfig-002-20250910    gcc-12.5.0
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250910    gcc-12.5.0
s390                  randconfig-002-20250910    gcc-12.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250910    gcc-12.5.0
sh                    randconfig-002-20250910    gcc-12.5.0
sh                        sh7785lcr_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250910    gcc-12.5.0
sparc                 randconfig-002-20250910    gcc-12.5.0
sparc64               randconfig-001-20250910    gcc-12.5.0
sparc64               randconfig-002-20250910    gcc-12.5.0
um                                allnoconfig    clang-22
um                    randconfig-001-20250910    gcc-12.5.0
um                    randconfig-002-20250910    gcc-12.5.0
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250909    clang-20
x86_64      buildonly-randconfig-001-20250909    gcc-14
x86_64      buildonly-randconfig-002-20250909    clang-20
x86_64      buildonly-randconfig-002-20250909    gcc-14
x86_64      buildonly-randconfig-003-20250909    gcc-14
x86_64      buildonly-randconfig-004-20250909    clang-20
x86_64      buildonly-randconfig-004-20250909    gcc-14
x86_64      buildonly-randconfig-005-20250909    gcc-14
x86_64      buildonly-randconfig-006-20250909    clang-20
x86_64      buildonly-randconfig-006-20250909    gcc-14
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-071-20250909    gcc-14
x86_64                randconfig-072-20250909    gcc-14
x86_64                randconfig-073-20250909    gcc-14
x86_64                randconfig-074-20250909    gcc-14
x86_64                randconfig-075-20250909    gcc-14
x86_64                randconfig-076-20250909    gcc-14
x86_64                randconfig-077-20250909    gcc-14
x86_64                randconfig-078-20250909    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250910    gcc-12.5.0
xtensa                randconfig-002-20250910    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


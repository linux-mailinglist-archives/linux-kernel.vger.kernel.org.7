Return-Path: <linux-kernel+bounces-890508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF1DC40364
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 356AE189A151
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF861EB9FA;
	Fri,  7 Nov 2025 13:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jg9mB3H/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B343195EC
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762523769; cv=none; b=XXY9GUaGR38+xMwS3qLO+FgVfs0AnMuyTaCShRa7bkZ/whmXJJdFHAfIm7nO+7iBlP99AbqLq+CPyIicvY/bXinKwin3bUS6INNBpBCUGf+hnOpWi3XGLRzyx90zvPcFrC2KPwLF0MO//xLyA7iqoPLjQPsG+KLK8Qve1mVhd7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762523769; c=relaxed/simple;
	bh=1KlsyB1Qe1cWoEKYCmMfXW6jdatELCLj25BqETfGX9Y=;
	h=Date:From:To:Cc:Subject:Message-ID; b=rY9MtysJcdF/Ia+fTXD/RR/lq0TRtXEEUm1+M9mxGkc0kkc1GfmNyEdG2ju5h/I8kfMNc69zjUnXHO5rp91BUtsllzx5ckduvjOOcTyAlLnxZsZjHXdTqkbArRnfD1mXy8xfAW90e88MwB6e7weY6JdmrCu25wap3dfOGPUv8ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jg9mB3H/; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762523768; x=1794059768;
  h=date:from:to:cc:subject:message-id;
  bh=1KlsyB1Qe1cWoEKYCmMfXW6jdatELCLj25BqETfGX9Y=;
  b=Jg9mB3H/Xwxe37Z5KaKjL98Qr67Me1kJiq7mRkNm6ngE/ChesWQSejnT
   qJqWTyGDgCXDrb2XWciaplNpAL6bmOEAx23W4Yh+QAy8i0VHO2m8qrt7v
   uQlUMxLpRf5EVDk+tAEZhL03ohURpK/Aci5uBFq49L+mYfP2XGjFrjMBr
   jvgaK1luwicfWSUpMFtb3V1oonkAZUl7tJgb6eDC0nwbu/GB9Oe4+scf7
   VP9/4jVDb+tVc0FNeJU81+jlYa2AaoCS961pawuVo3vLoN4ajC/W3vHca
   xourY9os1tJHG3qrCVVqWILI/NbOtU5ZDhaBrtg+CiypANyLe+PS7t8/Z
   Q==;
X-CSE-ConnectionGUID: ylk+Yn9KTm2h64MY3+5dWw==
X-CSE-MsgGUID: Bsn2RSUsQAmaQdHAg6QJxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64598396"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64598396"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 05:56:06 -0800
X-CSE-ConnectionGUID: XxcPpihLTq+WMq+Ktwqvmw==
X-CSE-MsgGUID: yi6rqYNmSWur+s1OVLdxgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="192303399"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 07 Nov 2025 05:56:05 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vHMwd-000VAz-23;
	Fri, 07 Nov 2025 13:56:03 +0000
Date: Fri, 07 Nov 2025 21:55:38 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 956dfda6a70885f18c0f8236a461aa2bc4f556ad
Message-ID: <202511072132.OtvvRWPV-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/urgent
branch HEAD: 956dfda6a70885f18c0f8236a461aa2bc4f556ad  sched/fair: Prevent cfs_rq from being unthrottled with zero runtime_remaining

elapsed time: 1508m

configs tested: 104
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                 nsimosci_hs_smp_defconfig    gcc-15.1.0
arc                   randconfig-001-20251107    gcc-8.5.0
arc                   randconfig-002-20251107    gcc-9.5.0
arm                               allnoconfig    clang-22
arm                        neponset_defconfig    gcc-15.1.0
arm                   randconfig-001-20251107    clang-17
arm                   randconfig-002-20251107    gcc-13.4.0
arm                   randconfig-003-20251107    clang-22
arm                   randconfig-004-20251107    gcc-8.5.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251107    gcc-8.5.0
arm64                 randconfig-002-20251107    clang-22
arm64                 randconfig-003-20251107    gcc-8.5.0
arm64                 randconfig-004-20251107    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251107    gcc-12.5.0
csky                  randconfig-002-20251107    gcc-13.4.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20251107    clang-22
hexagon               randconfig-002-20251107    clang-22
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251107    clang-20
i386        buildonly-randconfig-002-20251107    clang-20
i386        buildonly-randconfig-003-20251107    gcc-13
i386        buildonly-randconfig-004-20251107    gcc-14
i386        buildonly-randconfig-005-20251107    clang-20
i386        buildonly-randconfig-006-20251107    clang-20
i386                  randconfig-011-20251107    gcc-14
i386                  randconfig-013-20251107    clang-20
i386                  randconfig-014-20251107    gcc-14
loongarch                        alldefconfig    clang-20
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251107    gcc-15.1.0
loongarch             randconfig-002-20251107    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251107    gcc-11.5.0
nios2                 randconfig-002-20251107    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251107    gcc-8.5.0
parisc                randconfig-002-20251107    gcc-12.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                 linkstation_defconfig    clang-20
powerpc               randconfig-001-20251107    clang-22
powerpc               randconfig-002-20251107    clang-22
powerpc                     tqm8548_defconfig    clang-22
powerpc64             randconfig-001-20251107    gcc-14.3.0
powerpc64             randconfig-002-20251107    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251106    clang-22
riscv                 randconfig-002-20251106    gcc-12.5.0
s390                              allnoconfig    clang-22
s390                                defconfig    clang-22
s390                  randconfig-001-20251106    gcc-8.5.0
s390                  randconfig-002-20251106    gcc-14.3.0
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251106    gcc-11.5.0
sh                    randconfig-002-20251106    gcc-13.4.0
sh                   sh7724_generic_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251107    gcc-11.5.0
sparc                 randconfig-002-20251107    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251107    gcc-8.5.0
sparc64               randconfig-002-20251107    gcc-9.5.0
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251107    clang-22
um                    randconfig-002-20251107    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251107    gcc-14
x86_64      buildonly-randconfig-003-20251107    gcc-14
x86_64      buildonly-randconfig-005-20251107    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251107    clang-20
x86_64                randconfig-004-20251107    clang-20
x86_64                randconfig-011-20251107    gcc-14
x86_64                randconfig-012-20251107    gcc-14
x86_64                randconfig-013-20251107    clang-20
x86_64                randconfig-014-20251107    clang-20
x86_64                randconfig-015-20251107    gcc-14
x86_64                randconfig-016-20251107    gcc-14
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251107    gcc-10.5.0
xtensa                randconfig-002-20251107    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


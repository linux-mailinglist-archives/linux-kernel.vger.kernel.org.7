Return-Path: <linux-kernel+bounces-897359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 978C4C52B6D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BBC224F9621
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09924283CB1;
	Wed, 12 Nov 2025 14:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a3z1kXNq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF97D2765F8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762956783; cv=none; b=ZSFaCRwpR5Kwbd5AqAMCQEpyOmXWXal6refi2eTWQJ/qDn0moXr7nGwRBy5XgFsIFL7WKsalT25fBfDdMF4AIHSIaS4qQtDkjV+esMWnq1Jwhk07J4T3oydrbnxOQujdnpzygyuv2GFTLbgQX9fDWqbfId7Gp1m9U/Pesvlf8YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762956783; c=relaxed/simple;
	bh=Ixbv4BGamCo33/1GEVBV1PEy7SjtNIjzoYC1a27dUmE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XJdDGNueqx1r2qb5a8ULl7xgJPRFGy2id9d4nU7bz/s/219etq2Qn+P/DsvZEbzTQR3WRtUgrF6KLZgKU09zRfzHGS/39d/QhxXnzgQrIw8zmw0mC6seIcSNwOp/xTCF9h48MD6EQgmlLnSAzOK8up6QC+VkwIuSnSf9L06r+K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a3z1kXNq; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762956781; x=1794492781;
  h=date:from:to:cc:subject:message-id;
  bh=Ixbv4BGamCo33/1GEVBV1PEy7SjtNIjzoYC1a27dUmE=;
  b=a3z1kXNq5ElVXZJd4TV8Y4/Zd8ZNXTDtD5mp1CSyoZDn/mhW8hwiRB7E
   Kvavb4t38pUf5xukJNVUX9robOaWFRsxkF6A16k2XyKCtm3oLKShiEUYc
   GO0yafTQYFMN3dTfIft3G535JumOGTg1M66iWDuBtLcI2kVfMLbmjMIXO
   yXiaSof8O6kIzkaKvO2y6EnFoL1dzlsnpP6ulf+jS6mXpkj6Y80SBV9Zt
   5EDmCVVtsJljgDoj2tKfD64AfxP/H9JdZBEBmCBUBTbqS2LVZ9rRE6r4k
   AEMwUcTKJ3ISzvHCJyV4Lrq2sJevmFlZOga9SGlSpJ7iBZVKN6/NMN68d
   A==;
X-CSE-ConnectionGUID: dSEJRso9SfmkelLjjYWtyw==
X-CSE-MsgGUID: eGqik7r8RMCfaDUJCjSyBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="64724897"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="64724897"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 06:13:01 -0800
X-CSE-ConnectionGUID: z0UV6wutR5myibXRcWWhfQ==
X-CSE-MsgGUID: ljR0OhMKRKSLJHC/KC1rfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="212622073"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 12 Nov 2025 06:13:00 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vJBak-0004Gv-0H;
	Wed, 12 Nov 2025 14:12:58 +0000
Date: Wed, 12 Nov 2025 22:12:57 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:non-rcu/next] BUILD SUCCESS
 7f8fcc6f09fb732745b3252f481def76b18fb99c
Message-ID: <202511122252.qLX91w3F-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git non-rcu/next
branch HEAD: 7f8fcc6f09fb732745b3252f481def76b18fb99c  memory-barriers.txt: Sort wait_event* and wait_on_bit* list alphabetically

elapsed time: 4941m

configs tested: 61
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-15.1.0
alpha                  allyesconfig    gcc-15.1.0
arc                     allnoconfig    gcc-15.1.0
arm                     allnoconfig    clang-22
arm64                   allnoconfig    gcc-15.1.0
csky                    allnoconfig    gcc-15.1.0
hexagon                allmodconfig    clang-17
hexagon                 allnoconfig    clang-22
hexagon                allyesconfig    clang-22
hexagon     randconfig-001-20251109    clang-22
hexagon     randconfig-002-20251109    clang-22
i386                   allmodconfig    gcc-14
i386                    allnoconfig    gcc-14
i386                   allyesconfig    gcc-14
loongarch              allmodconfig    clang-19
loongarch               allnoconfig    clang-22
loongarch   randconfig-001-20251109    clang-22
loongarch   randconfig-002-20251109    gcc-15.1.0
m68k                   allmodconfig    gcc-15.1.0
m68k                    allnoconfig    gcc-15.1.0
m68k                   allyesconfig    gcc-15.1.0
microblaze             allmodconfig    gcc-15.1.0
microblaze              allnoconfig    gcc-15.1.0
microblaze             allyesconfig    gcc-15.1.0
mips                    allnoconfig    gcc-15.1.0
nios2                   allnoconfig    gcc-11.5.0
nios2       randconfig-001-20251109    gcc-11.5.0
nios2       randconfig-002-20251109    gcc-8.5.0
openrisc                allnoconfig    gcc-15.1.0
parisc                  allnoconfig    gcc-15.1.0
powerpc                 allnoconfig    gcc-15.1.0
riscv                   allnoconfig    gcc-15.1.0
riscv       randconfig-001-20251109    gcc-9.5.0
riscv       randconfig-002-20251109    gcc-8.5.0
s390                   allmodconfig    clang-18
s390                    allnoconfig    clang-22
s390                   allyesconfig    gcc-15.1.0
s390        randconfig-001-20251109    gcc-14.3.0
s390        randconfig-002-20251109    gcc-8.5.0
sh                     allmodconfig    gcc-15.1.0
sh                      allnoconfig    gcc-15.1.0
sh                     allyesconfig    gcc-15.1.0
sh          randconfig-001-20251109    gcc-11.5.0
sh          randconfig-002-20251109    gcc-15.1.0
sparc                  allmodconfig    gcc-15.1.0
sparc                   allnoconfig    gcc-15.1.0
um                     allmodconfig    clang-19
um                      allnoconfig    clang-22
um                     allyesconfig    gcc-14
x86_64                 allmodconfig    clang-20
x86_64                  allnoconfig    clang-20
x86_64                 allyesconfig    clang-20
x86_64                        kexec    clang-20
x86_64                     rhel-9.4    clang-20
x86_64                 rhel-9.4-bpf    gcc-14
x86_64                rhel-9.4-func    clang-20
x86_64          rhel-9.4-kselftests    clang-20
x86_64               rhel-9.4-kunit    gcc-14
x86_64                 rhel-9.4-ltp    gcc-14
x86_64                rhel-9.4-rust    clang-20
xtensa                  allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


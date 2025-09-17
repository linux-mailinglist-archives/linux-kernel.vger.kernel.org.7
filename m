Return-Path: <linux-kernel+bounces-820704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 740A8B7E581
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E59C4A04D0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEE72C0263;
	Wed, 17 Sep 2025 12:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G9fcgKQT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08BA1E489
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113086; cv=none; b=j8DoP6w8P8PE78yM+JGP49GSETd50Fwgt0iP7LzvkLdS1aOxcCfQnpVKb8Aesj/b8rSuIUufI6x1lbOHg+enLmeOHWSBs+VnYhAKoVOZULNWnMD528TbkEx/AeDhMgYxBX9SLjQ5+4d1g8OZgrr3IVqgZAcsVnPvpZUbRSkg8r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113086; c=relaxed/simple;
	bh=yIndNJ1wCiKOanfAad9mIXYjxo5kfSZFS+AyNVeMffo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZGE5d+R7znNFFog9VX8f8nFQtnU0uzL0Bgzz3NL2utemgqJf9CnxqUWem4DZN/5o5QfBmR2TjeJUTkD75YpJ8XJNAwImLt/DV47FRJoGYuRoGe28yeOAhY1yAtRlcCj9k0BzWry9+UVCS2rDvtEvNoeGJRfvG5K3kkUxIDc1H3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G9fcgKQT; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758113085; x=1789649085;
  h=date:from:to:cc:subject:message-id;
  bh=yIndNJ1wCiKOanfAad9mIXYjxo5kfSZFS+AyNVeMffo=;
  b=G9fcgKQTusiWQ7XWPQDR2FqjVqm1qYSMCor8bFQJMGWuLMrXbkmy9Qjz
   mojeH4wwnA5HmHga71aw7jQJ55uBtykiEBLkrSTImTTRaA54/oOKpMNVA
   QmGr+X9h/DeZD+jFRFLAT18boY6yenpnHS9XPA+OSWM0mFsml+8xniifm
   fmhgaN2La40hg+oXh/UZMyOIXGsc0ULaf+jVL97SiOHM15Mso+GDoaaK1
   M7WYlY0eLRnND8u/5fkkKmE5pe5hhqED+0DKcMgT6kc6aqTGta2KSVNgA
   jY4qvUClG+WfmkdN0mdqPTDeE01vQoDgfOrDA1YxOGGBQ6q+fiZy59dDT
   Q==;
X-CSE-ConnectionGUID: EXlaDOnGRKq37ssUesWVOg==
X-CSE-MsgGUID: 0dxoe868SOKPL7msgJDONA==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="71783158"
X-IronPort-AV: E=Sophos;i="6.18,272,1751266800"; 
   d="scan'208";a="71783158"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 05:42:50 -0700
X-CSE-ConnectionGUID: SPObOcHOQxydwoa/sbrsRQ==
X-CSE-MsgGUID: 6K+Zqg7VQZmRiVxGWHxIcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,272,1751266800"; 
   d="scan'208";a="175031790"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 17 Sep 2025 05:42:48 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uyrUk-0001Yw-1r;
	Wed, 17 Sep 2025 12:42:46 +0000
Date: Wed, 17 Sep 2025 20:42:35 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 0d4eaf8caf8cd633b23e949e2996b420052c2d45
Message-ID: <202509172029.lZdXwNk5-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 0d4eaf8caf8cd633b23e949e2996b420052c2d45  sched/fair: Do not balance task to a throttled cfs_rq

elapsed time: 1478m

configs tested: 104
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20250916    gcc-8.5.0
arc                   randconfig-002-20250916    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                        mvebu_v5_defconfig    gcc-15.1.0
arm                   randconfig-001-20250916    gcc-11.5.0
arm                   randconfig-002-20250916    clang-22
arm                   randconfig-003-20250916    gcc-12.5.0
arm                   randconfig-004-20250916    clang-22
arm                           sunxi_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250916    clang-18
arm64                 randconfig-002-20250916    clang-22
arm64                 randconfig-003-20250916    clang-22
arm64                 randconfig-004-20250916    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250916    gcc-14.3.0
csky                  randconfig-002-20250916    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250916    clang-22
hexagon               randconfig-002-20250916    clang-22
i386                             alldefconfig    gcc-14
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20250916    gcc-14
i386        buildonly-randconfig-002-20250916    gcc-14
i386        buildonly-randconfig-003-20250916    clang-20
i386        buildonly-randconfig-004-20250916    gcc-14
i386        buildonly-randconfig-005-20250916    gcc-14
i386        buildonly-randconfig-006-20250916    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250916    clang-18
loongarch             randconfig-002-20250916    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                          multi_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250916    gcc-11.5.0
nios2                 randconfig-002-20250916    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250916    gcc-9.5.0
parisc                randconfig-002-20250916    gcc-13.4.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20250916    clang-16
powerpc               randconfig-002-20250916    clang-22
powerpc               randconfig-003-20250916    clang-22
powerpc64             randconfig-001-20250916    clang-22
powerpc64             randconfig-002-20250916    gcc-8.5.0
powerpc64             randconfig-003-20250916    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250916    clang-22
riscv                 randconfig-002-20250916    gcc-10.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250916    gcc-13.4.0
s390                  randconfig-002-20250916    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250916    gcc-15.1.0
sh                    randconfig-002-20250916    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250916    gcc-8.5.0
sparc                 randconfig-002-20250916    gcc-8.5.0
sparc64               randconfig-001-20250916    gcc-11.5.0
sparc64               randconfig-002-20250916    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                    randconfig-001-20250916    gcc-14
um                    randconfig-002-20250916    clang-19
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250916    gcc-14
x86_64      buildonly-randconfig-002-20250916    clang-20
x86_64      buildonly-randconfig-003-20250916    clang-20
x86_64      buildonly-randconfig-004-20250916    clang-20
x86_64      buildonly-randconfig-005-20250916    clang-20
x86_64      buildonly-randconfig-006-20250916    clang-20
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250916    gcc-8.5.0
xtensa                randconfig-002-20250916    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-kernel+bounces-890770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ED939C40E44
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 17:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3ED2C4F4CA4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 16:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A461428853A;
	Fri,  7 Nov 2025 16:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E7RW+IWp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0983B304BBD
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762532938; cv=none; b=K7S3LIRz72ygRcg+d9kl+RiLtgIpY/YxyJLhZPT35kezLG+wBuOsocd6I5kqnWQvh1tOEep7sZ3P27S2sWZUQl7PGFWqdJYTXZW5mjgOPPVb/Az2HXA7W4NliKCI/rsljPn7uZ6Tm6wQZnE/t9cV8N/HPo3TtoIwjC1XHTFxt5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762532938; c=relaxed/simple;
	bh=0/TSiHGhpKwTA84G4EkQuBQsCOiD8IV0dGgQgMPBFao=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Q3UfS6qCeQKLC+Aqrh3QPraVYk9M2L8Q5o9+UbyeRAvgMcdCSsidOb9ZvuEI09YGommVflY2RKAE8iGyAnxz2gMUWNcwVhJ/0VH3iXZgJ19vTkVSOiVIR8KFcpxS2X8Y0FBwxvWpG2pvqFqh0d6AzuYmljdVfleZgS1ef/4gcps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E7RW+IWp; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762532936; x=1794068936;
  h=date:from:to:cc:subject:message-id;
  bh=0/TSiHGhpKwTA84G4EkQuBQsCOiD8IV0dGgQgMPBFao=;
  b=E7RW+IWpVyxeMpxXkClKOvGtaTRbEN9Pq/HGhaElVxvOdkBXj8H5juk4
   SOxYlozlGTx85OmwLh/N1jJ1iXcpH7GVeyte+k19wRCwnwmrV5IPxjAQy
   drFF0fM3O3g/bahN4skyH4AvKtcGsDQNFpcrrpQIpljij0++UdGQ9mxYT
   pImsnD2Dutr5MWJkCAdtlO/d75bHhSCcMu0ytuNMVTKHBQSLoBXnsMjdb
   Mc1NBp2xEzjbdYvalasy+GkPSYmHfj3oQatNxHgnp9IwPa94aVi5FLwcI
   s1FMvs3Y64iwSR8bQIfRByoYA1nzMOh0W/jPjbiRK/2DM9+fR0rG1kIis
   Q==;
X-CSE-ConnectionGUID: 34zh38YSQ4OcOVPel3ntog==
X-CSE-MsgGUID: ip4IMkzOTaWOe/4HFhTJ8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="75295224"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="75295224"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 08:28:55 -0800
X-CSE-ConnectionGUID: nEjicwx4QASgYsnp7Fh1hw==
X-CSE-MsgGUID: RLzYCiRiT8+9pMCRljJF8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="192172907"
Received: from lkp-server01.sh.intel.com (HELO 6ef82f2de774) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 07 Nov 2025 08:28:53 -0800
Received: from kbuild by 6ef82f2de774 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vHPKU-00006f-2f;
	Fri, 07 Nov 2025 16:28:50 +0000
Date: Sat, 08 Nov 2025 00:28:48 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:locking/urgent] BUILD SUCCESS
 4cb5ac2626b5704ed712ac1d46b9d89fdfc12c5d
Message-ID: <202511080042.Sc68qcGs-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/urgent
branch HEAD: 4cb5ac2626b5704ed712ac1d46b9d89fdfc12c5d  futex: Optimize per-cpu reference counting

elapsed time: 1661m

configs tested: 108
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251107    gcc-8.5.0
arc                   randconfig-002-20251107    gcc-9.5.0
arm                               allnoconfig    clang-22
arm                     davinci_all_defconfig    clang-19
arm                         lpc32xx_defconfig    clang-17
arm                        multi_v7_defconfig    gcc-15.1.0
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
i386                                defconfig    clang-20
i386                  randconfig-001-20251107    clang-20
i386                  randconfig-002-20251107    gcc-13
i386                  randconfig-003-20251107    clang-20
i386                  randconfig-004-20251107    clang-20
i386                  randconfig-005-20251107    gcc-14
i386                  randconfig-006-20251107    clang-20
i386                  randconfig-007-20251107    clang-20
i386                  randconfig-011-20251107    gcc-14
i386                  randconfig-012-20251107    clang-20
i386                  randconfig-013-20251107    clang-20
i386                  randconfig-014-20251107    gcc-14
i386                  randconfig-015-20251107    clang-20
i386                  randconfig-016-20251107    clang-20
i386                  randconfig-017-20251107    clang-20
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20251107    gcc-15.1.0
loongarch             randconfig-002-20251107    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                          sun3x_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           ip22_defconfig    gcc-15.1.0
mips                   sb1250_swarm_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                 randconfig-001-20251107    gcc-11.5.0
nios2                 randconfig-002-20251107    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251107    gcc-8.5.0
parisc                randconfig-002-20251107    gcc-12.5.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20251107    clang-22
powerpc               randconfig-002-20251107    clang-22
powerpc64             randconfig-001-20251107    gcc-14.3.0
powerpc64             randconfig-002-20251107    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20251106    clang-22
riscv                 randconfig-002-20251106    gcc-12.5.0
s390                              allnoconfig    clang-22
s390                  randconfig-001-20251106    gcc-8.5.0
s390                  randconfig-002-20251106    gcc-14.3.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251106    gcc-11.5.0
sh                    randconfig-002-20251106    gcc-13.4.0
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
x86_64      buildonly-randconfig-003-20251107    gcc-14
x86_64      buildonly-randconfig-005-20251107    gcc-14
x86_64                              defconfig    gcc-14
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


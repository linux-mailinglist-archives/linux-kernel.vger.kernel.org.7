Return-Path: <linux-kernel+bounces-768674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5B6B263F7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D29F91726B0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341BE2E9EDB;
	Thu, 14 Aug 2025 11:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XOfZylKY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF9B2B9B7
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 11:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755170161; cv=none; b=ADmUmfdMTHADl36u1vjMNdQGpOQYy4UcbP4RbHUoMU1HK1D/QSamrBsYpSPujEmLB3hSbjcVogpVT0x3Peq9YsiwiNoOuS6vkgzG0/81P4z+t+RFV3/1laKedXvHcembnE6h6TfLxPUdJrLUpBHD/0HSL8+zXvBmwY97gofHIKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755170161; c=relaxed/simple;
	bh=Xl1w5/8UpwGvG4oUb8LLyaYfW7hljvy3VefVEHXGs/Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=eSWF6k5G2toUKEBSjY9x2H1XZGfD2XcXyD/QB+AgZeRpMNNFWxtoilm0DXcL/Ws0bxZDpg2sC06qIQnY9zI1aOLbtfPWPGrJRvpRjEl6exwKjxuxOidOVd2elA5I3F08WDz9JxMlOLsIDYRAU3taHoOtIHotYf1XQzgRWsobTJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XOfZylKY; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755170159; x=1786706159;
  h=date:from:to:cc:subject:message-id;
  bh=Xl1w5/8UpwGvG4oUb8LLyaYfW7hljvy3VefVEHXGs/Q=;
  b=XOfZylKYAZyA1hRyGuHKlE6OYAveJq02IR17wgR27XIyHqMDMSx8TlIk
   IO//RLzoqnCWbw1q8T1oF9Ei0MFgWwG7dLRPAQMuMc6VxBWEQJxLgEEqT
   17U+5iJqtvPCAKYrOQFlz6+yL19buiTobemrkz/syzHAcgg6RBAjKpqSb
   ZHEYO32Xc8+2MnOcDVD56QQL7hqB+JGG34JUQwRklaQ1shaq1VVNobI2r
   9hzl6gDC3H5YUh4BGI7Kw06qqGQrfXNcoHh1n1j1uL4HNINw50HDJAiVQ
   UAzTzVcMpj6fwnrZCX+tXwfXVi/nLMeoW9augYtqePvdiEMi2En9RFEiF
   Q==;
X-CSE-ConnectionGUID: eykXFW6iQxCNsjKQi5ZMfQ==
X-CSE-MsgGUID: lIYj3LGyTX6ObTEu7bOJQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57404696"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="57404696"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 04:15:59 -0700
X-CSE-ConnectionGUID: PZdSTtugQp6oq2CJd+xAaw==
X-CSE-MsgGUID: vmZMVH5KQy6bRinT/E12hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="165954350"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 14 Aug 2025 04:15:58 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umVw3-000AtG-1t;
	Thu, 14 Aug 2025 11:15:55 +0000
Date: Thu, 14 Aug 2025 19:15:49 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/entry] BUILD SUCCESS
 3da01ffe1aeaa0d427ab5235ba735226670a80d9
Message-ID: <202508141936.GhoxUJTB-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/entry
branch HEAD: 3da01ffe1aeaa0d427ab5235ba735226670a80d9  x86/fred: Remove ENDBR64 from FRED entry points

elapsed time: 723m

configs tested: 105
configs skipped: 119

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig    clang-19
arc                              allmodconfig    clang-19
arc                              allyesconfig    clang-19
arm                              allmodconfig    clang-19
arm                              allyesconfig    clang-19
arm64                            allmodconfig    clang-19
hexagon                          allmodconfig    clang-19
hexagon                          allyesconfig    clang-19
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250814    clang-20
i386        buildonly-randconfig-002-20250814    clang-20
i386        buildonly-randconfig-002-20250814    gcc-12
i386        buildonly-randconfig-003-20250814    clang-20
i386        buildonly-randconfig-003-20250814    gcc-12
i386        buildonly-randconfig-004-20250814    clang-20
i386        buildonly-randconfig-005-20250814    clang-20
i386        buildonly-randconfig-005-20250814    gcc-12
i386        buildonly-randconfig-006-20250814    clang-20
i386        buildonly-randconfig-006-20250814    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250814    clang-20
i386                  randconfig-002-20250814    clang-20
i386                  randconfig-003-20250814    clang-20
i386                  randconfig-004-20250814    clang-20
i386                  randconfig-005-20250814    clang-20
i386                  randconfig-006-20250814    clang-20
i386                  randconfig-007-20250814    clang-20
i386                  randconfig-011-20250814    gcc-12
i386                  randconfig-012-20250814    gcc-12
i386                  randconfig-013-20250814    gcc-12
i386                  randconfig-014-20250814    gcc-12
i386                  randconfig-015-20250814    gcc-12
i386                  randconfig-016-20250814    gcc-12
i386                  randconfig-017-20250814    gcc-12
loongarch                        allmodconfig    clang-19
m68k                             allmodconfig    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250814    clang-22
riscv                 randconfig-002-20250814    clang-22
s390                             allmodconfig    gcc-15.1.0
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250814    clang-22
s390                  randconfig-002-20250814    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250814    clang-22
sh                    randconfig-002-20250814    clang-22
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250814    clang-22
sparc                 randconfig-002-20250814    clang-22
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250814    clang-22
sparc64               randconfig-002-20250814    clang-22
um                               allmodconfig    clang-19
um                               allyesconfig    clang-19
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250814    clang-22
um                    randconfig-002-20250814    clang-22
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250814    clang-20
x86_64      buildonly-randconfig-002-20250814    clang-20
x86_64      buildonly-randconfig-003-20250814    clang-20
x86_64      buildonly-randconfig-003-20250814    gcc-12
x86_64      buildonly-randconfig-004-20250814    clang-20
x86_64      buildonly-randconfig-005-20250814    clang-20
x86_64      buildonly-randconfig-005-20250814    gcc-12
x86_64      buildonly-randconfig-006-20250814    clang-20
x86_64      buildonly-randconfig-006-20250814    gcc-12
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250814    clang-20
x86_64                randconfig-002-20250814    clang-20
x86_64                randconfig-003-20250814    clang-20
x86_64                randconfig-004-20250814    clang-20
x86_64                randconfig-005-20250814    clang-20
x86_64                randconfig-006-20250814    clang-20
x86_64                randconfig-007-20250814    clang-20
x86_64                randconfig-008-20250814    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250814    clang-22
xtensa                randconfig-002-20250814    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


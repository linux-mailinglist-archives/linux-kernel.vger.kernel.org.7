Return-Path: <linux-kernel+bounces-725775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72098B003BF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D31347B245D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059F02638B2;
	Thu, 10 Jul 2025 13:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OjqREqK8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A549925A620
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 13:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752154574; cv=none; b=hkKIL2plZG3SjnHbXN9xmQvmkBrDJiVKwPtZnSfBrhRA4RO7PrusxL8olnena4d3UHzYoq4Ypb+3bByne/5PN7sA29vx+2LnFWfHmcjf/RMWvOOozQwcF3SmHw+hurgIRgjbD3EQvFYqCMSEo+FRPd2zCYI+ktMzN1BP5PD+d44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752154574; c=relaxed/simple;
	bh=3Y1BnoTNppK6B9EoogU5VL32YydlPx16hNRa5tGHhKQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=bGXO3Arhn7IyQlhjp/KEI6nz0wFIBORaFJF8VXmsjfE+XGtweovVs6LVAbUhP+dINnIQvm6v/dPpBAgT3ybXdCbsIkEMkCF5U490Bni+IFuzPpvy2VCyh1fIwzjkEPV4Tdk6HMO7WV7BIIn3LsQKIXtg8RhYLpUgmWNmfqKyJd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OjqREqK8; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752154573; x=1783690573;
  h=date:from:to:cc:subject:message-id;
  bh=3Y1BnoTNppK6B9EoogU5VL32YydlPx16hNRa5tGHhKQ=;
  b=OjqREqK8qsLZpFmefJSERw4zI12IdQNbbMnl39HHeSNi307lLjdjFfZ2
   6R+SdSpHSPhy/HW6mGPJttDzmx/huJbPXLNkbXD9yjxzJcwmaq08XMhJ2
   LwIZjLzPkpYfb0BXCQi1Gd4nYxKpfTCKkWIt3xXvsYtbCwrpY6HIUwl40
   CnxcCd8v+kxaKu8GMSRuL9F9sGrRFgi/Mmk3OizcbEapvpZLm3TO7VC/1
   +Szxg7Pmx2giPIZcmH9aeIErp72x69AdycVczcZ4KRAIenu4UgCqwk1ak
   XuxBL4kEeaMBb7GnBySE45hPhJKkKJVzY66czYDtYx3QrvmHH6bcTgybZ
   g==;
X-CSE-ConnectionGUID: zUjozVYBSJqnzjfdxcjcAw==
X-CSE-MsgGUID: 36gLKpCKS/Gwz8nhvfv3FQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="65786775"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="65786775"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 06:36:11 -0700
X-CSE-ConnectionGUID: 9lVhklgPQxCIpABLCKiDqQ==
X-CSE-MsgGUID: 4CopYY+GT9C22SE/teKQOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="160412412"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 10 Jul 2025 06:36:10 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uZrRX-00054j-0U;
	Thu, 10 Jul 2025 13:36:07 +0000
Date: Thu, 10 Jul 2025 21:35:46 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 76303ee8d54bff6d9a6d55997acd88a6c2ba63cf
Message-ID: <202507102134.zctZzrh8-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 76303ee8d54bff6d9a6d55997acd88a6c2ba63cf  x86/mm: Disable hugetlb page table sharing on 32-bit

elapsed time: 1363m

configs tested: 172
configs skipped: 176

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-21
alpha                            allyesconfig    clang-19
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-21
arc                              allyesconfig    clang-19
arc                                 defconfig    clang-19
arc                   randconfig-001-20250710    clang-21
arc                   randconfig-002-20250710    clang-21
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-21
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                   randconfig-001-20250710    clang-21
arm                   randconfig-002-20250710    clang-21
arm                   randconfig-003-20250710    clang-21
arm                   randconfig-004-20250710    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-21
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250710    clang-21
arm64                 randconfig-002-20250710    clang-21
arm64                 randconfig-003-20250710    clang-21
arm64                 randconfig-004-20250710    clang-21
csky                              allnoconfig    clang-21
csky                                defconfig    clang-19
csky                  randconfig-001-20250710    gcc-15.1.0
csky                  randconfig-002-20250710    gcc-15.1.0
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-19
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250710    gcc-15.1.0
hexagon               randconfig-002-20250710    gcc-15.1.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250710    clang-20
i386        buildonly-randconfig-001-20250710    gcc-12
i386        buildonly-randconfig-002-20250710    clang-20
i386        buildonly-randconfig-002-20250710    gcc-12
i386        buildonly-randconfig-003-20250710    clang-20
i386        buildonly-randconfig-004-20250710    clang-20
i386        buildonly-randconfig-004-20250710    gcc-11
i386        buildonly-randconfig-005-20250710    clang-20
i386        buildonly-randconfig-006-20250710    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250710    gcc-12
i386                  randconfig-002-20250710    gcc-12
i386                  randconfig-003-20250710    gcc-12
i386                  randconfig-004-20250710    gcc-12
i386                  randconfig-005-20250710    gcc-12
i386                  randconfig-006-20250710    gcc-12
i386                  randconfig-007-20250710    gcc-12
i386                  randconfig-011-20250710    clang-20
i386                  randconfig-012-20250710    clang-20
i386                  randconfig-013-20250710    clang-20
i386                  randconfig-014-20250710    clang-20
i386                  randconfig-015-20250710    clang-20
i386                  randconfig-016-20250710    clang-20
i386                  randconfig-017-20250710    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250710    gcc-15.1.0
loongarch             randconfig-002-20250710    gcc-15.1.0
m68k                             allmodconfig    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                            allmodconfig    clang-21
nios2                             allnoconfig    gcc-15.1.0
nios2                            allyesconfig    clang-21
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250710    gcc-15.1.0
nios2                 randconfig-002-20250710    gcc-15.1.0
openrisc                         allmodconfig    clang-21
openrisc                          allnoconfig    clang-21
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250710    gcc-15.1.0
parisc                randconfig-002-20250710    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                          allyesconfig    gcc-15.1.0
powerpc               randconfig-001-20250710    gcc-15.1.0
powerpc               randconfig-002-20250710    gcc-15.1.0
powerpc               randconfig-003-20250710    gcc-15.1.0
powerpc64             randconfig-001-20250710    gcc-15.1.0
powerpc64             randconfig-002-20250710    gcc-15.1.0
powerpc64             randconfig-003-20250710    gcc-15.1.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                            allyesconfig    gcc-15.1.0
riscv                 randconfig-001-20250710    gcc-12.4.0
riscv                 randconfig-002-20250710    gcc-12.4.0
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250710    gcc-12.4.0
s390                  randconfig-002-20250710    gcc-12.4.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250710    gcc-12.4.0
sh                    randconfig-002-20250710    gcc-12.4.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                            allyesconfig    clang-21
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250710    gcc-12.4.0
sparc                 randconfig-002-20250710    gcc-12.4.0
sparc64                          allmodconfig    clang-21
sparc64                          allyesconfig    clang-21
sparc64               randconfig-001-20250710    gcc-12.4.0
sparc64               randconfig-002-20250710    gcc-12.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                    randconfig-001-20250710    gcc-12.4.0
um                    randconfig-002-20250710    gcc-12.4.0
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250710    clang-20
x86_64      buildonly-randconfig-001-20250710    gcc-12
x86_64      buildonly-randconfig-002-20250710    clang-20
x86_64      buildonly-randconfig-002-20250710    gcc-12
x86_64      buildonly-randconfig-003-20250710    clang-20
x86_64      buildonly-randconfig-003-20250710    gcc-12
x86_64      buildonly-randconfig-004-20250710    clang-20
x86_64      buildonly-randconfig-005-20250710    clang-20
x86_64      buildonly-randconfig-006-20250710    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250710    gcc-12
x86_64                randconfig-002-20250710    gcc-12
x86_64                randconfig-003-20250710    gcc-12
x86_64                randconfig-004-20250710    gcc-12
x86_64                randconfig-005-20250710    gcc-12
x86_64                randconfig-006-20250710    gcc-12
x86_64                randconfig-007-20250710    gcc-12
x86_64                randconfig-008-20250710    gcc-12
x86_64                randconfig-071-20250710    gcc-11
x86_64                randconfig-072-20250710    gcc-11
x86_64                randconfig-073-20250710    gcc-11
x86_64                randconfig-074-20250710    gcc-11
x86_64                randconfig-075-20250710    gcc-11
x86_64                randconfig-076-20250710    gcc-11
x86_64                randconfig-077-20250710    gcc-11
x86_64                randconfig-078-20250710    gcc-11
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    clang-21
xtensa                randconfig-001-20250710    gcc-12.4.0
xtensa                randconfig-002-20250710    gcc-12.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


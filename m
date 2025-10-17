Return-Path: <linux-kernel+bounces-858028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD7CBE89CC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB7D14E77E1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE0B328601;
	Fri, 17 Oct 2025 12:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lkMaQUOH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6E72D641D
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 12:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760704635; cv=none; b=NO4CdRNqz2sB3YJGp0kMZ8pLjvBfk+uzzKg5icEiWWxPd5vE1jxKMk1k3knInVNBRe5ALLExW/4o/ysVdrI8PpIePvJrx6xOsgC2dDi6uZDpfDp3qxTjE+BrY+2Cr4wW0/dQO2wO/ykVnwQzoyfYQzrEA/bOfFTm2ROBek8FkvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760704635; c=relaxed/simple;
	bh=TV9rrx6+YArpHsgzZ0e6ZizWPF77/XV3brY/O9bW5Bo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kyYrTi7yboLuXA9nbNz4Gb/wblmmRUp9mQszrhg41ezlvbxw/0NK+nWcbuaERSWHFR01eWi1VijvK/cTp5hOMJ6K9DcuOm7+G6xXAr2cRv9Fvkn20xIon6S38OypzsGbMLsSRxQKu0flY4tG4S7Z0pSubPds+BByFDeqIlhfBpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lkMaQUOH; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760704634; x=1792240634;
  h=date:from:to:cc:subject:message-id;
  bh=TV9rrx6+YArpHsgzZ0e6ZizWPF77/XV3brY/O9bW5Bo=;
  b=lkMaQUOHSVHVVzWB7AqM7RSxrkii4yZUfr1qXYk8clYrQiW9PURdY2F/
   MuB/AROIaDLfSLc5uCr9KL/92wb7grOrR4oASNrwgGovdNE8G8WBmJ8d+
   y+trQT/9IHTU0R6QYy4Cpk6fVQdzKdbGy9PVih+lWqxGhTG/nwpljknLs
   KElmaVAQTY4gnfhYJfoQMiQFHhclR8zHutvJ2cu1MHd/nUmE+F3ro9bBE
   y8BKpp8gTj/dugKPzCz1NP+ZOad0YJY6WTXhjq0Te483gkDfgTyPRyz33
   ixwgYjnT+WPbdchYKoAVXKN5aMbVdooemOiDH9vv4EHGb1YIVBCnNBDGF
   Q==;
X-CSE-ConnectionGUID: cPb3DcOXRHOLRV15yNIcDQ==
X-CSE-MsgGUID: OMXO6W5+Qq+f7kwDDNqyXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="50481252"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="50481252"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 05:37:13 -0700
X-CSE-ConnectionGUID: mBAKAu3nTdSLySPXGGMe9g==
X-CSE-MsgGUID: VK+ECOonQjeJHgs1hBN4nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="181859823"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 17 Oct 2025 05:37:12 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9jhg-0005xj-2n;
	Fri, 17 Oct 2025 12:37:09 +0000
Date: Fri, 17 Oct 2025 20:36:59 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 762a3d1ca2cfe9965417d784cd044c702fda4aca
Message-ID: <202510172053.QpaNUvjm-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: 762a3d1ca2cfe9965417d784cd044c702fda4aca  x86/idtentry: Add missing '*' to kernel-doc lines

elapsed time: 1193m

configs tested: 136
configs skipped: 120

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                               defconfig    clang-19
arc                               allnoconfig    clang-22
arc                                 defconfig    clang-19
arc                   randconfig-001-20251017    clang-22
arc                   randconfig-002-20251017    clang-22
arm                               allnoconfig    clang-22
arm                                 defconfig    clang-19
arm                      integrator_defconfig    gcc-15.1.0
arm                   randconfig-001-20251017    clang-22
arm                   randconfig-002-20251017    clang-22
arm                   randconfig-003-20251017    clang-22
arm                   randconfig-004-20251017    clang-22
arm64                             allnoconfig    clang-22
arm64                               defconfig    clang-19
arm64                 randconfig-001-20251017    clang-22
arm64                 randconfig-002-20251017    clang-22
arm64                 randconfig-003-20251017    clang-22
arm64                 randconfig-004-20251017    clang-22
csky                              allnoconfig    clang-22
csky                                defconfig    clang-19
csky                  randconfig-001-20251017    gcc-15.1.0
csky                  randconfig-002-20251017    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20251017    gcc-15.1.0
hexagon               randconfig-002-20251017    gcc-15.1.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20251017    clang-20
i386        buildonly-randconfig-002-20251017    clang-20
i386        buildonly-randconfig-003-20251017    clang-20
i386        buildonly-randconfig-004-20251017    clang-20
i386        buildonly-randconfig-005-20251017    clang-20
i386        buildonly-randconfig-006-20251017    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20251017    clang-20
i386                  randconfig-002-20251017    clang-20
i386                  randconfig-003-20251017    clang-20
i386                  randconfig-004-20251017    clang-20
i386                  randconfig-005-20251017    clang-20
i386                  randconfig-006-20251017    clang-20
i386                  randconfig-007-20251017    clang-20
i386                  randconfig-011-20251017    gcc-12
i386                  randconfig-012-20251017    gcc-12
i386                  randconfig-013-20251017    gcc-12
i386                  randconfig-014-20251017    gcc-12
i386                  randconfig-015-20251017    gcc-12
i386                  randconfig-016-20251017    gcc-12
i386                  randconfig-017-20251017    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251017    gcc-15.1.0
loongarch             randconfig-002-20251017    gcc-15.1.0
m68k                             allmodconfig    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        bcm63xx_defconfig    gcc-15.1.0
mips                           jazz_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20251017    gcc-15.1.0
nios2                 randconfig-002-20251017    gcc-15.1.0
openrisc                          allnoconfig    clang-22
parisc                            allnoconfig    clang-22
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251017    gcc-15.1.0
parisc                randconfig-002-20251017    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc               randconfig-001-20251017    gcc-15.1.0
powerpc               randconfig-002-20251017    gcc-15.1.0
powerpc               randconfig-003-20251017    gcc-15.1.0
powerpc64             randconfig-001-20251017    gcc-15.1.0
powerpc64             randconfig-002-20251017    gcc-15.1.0
powerpc64             randconfig-003-20251017    gcc-15.1.0
riscv                             allnoconfig    clang-22
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                          kfr2r09_defconfig    gcc-15.1.0
sh                           se7712_defconfig    gcc-15.1.0
sh                           sh2007_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
um                                allnoconfig    clang-22
um                             i386_defconfig    gcc-15.1.0
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251017    clang-20
x86_64      buildonly-randconfig-001-20251017    gcc-14
x86_64      buildonly-randconfig-002-20251017    clang-20
x86_64      buildonly-randconfig-002-20251017    gcc-14
x86_64      buildonly-randconfig-003-20251017    clang-20
x86_64      buildonly-randconfig-004-20251017    clang-20
x86_64      buildonly-randconfig-004-20251017    gcc-14
x86_64      buildonly-randconfig-005-20251017    clang-20
x86_64      buildonly-randconfig-006-20251017    clang-20
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251017    gcc-14
x86_64                randconfig-002-20251017    gcc-14
x86_64                randconfig-003-20251017    gcc-14
x86_64                randconfig-004-20251017    gcc-14
x86_64                randconfig-005-20251017    gcc-14
x86_64                randconfig-006-20251017    gcc-14
x86_64                randconfig-007-20251017    gcc-14
x86_64                randconfig-008-20251017    gcc-14
x86_64                randconfig-071-20251017    clang-20
x86_64                randconfig-072-20251017    clang-20
x86_64                randconfig-073-20251017    clang-20
x86_64                randconfig-074-20251017    clang-20
x86_64                randconfig-075-20251017    clang-20
x86_64                randconfig-076-20251017    clang-20
x86_64                randconfig-077-20251017    clang-20
x86_64                randconfig-078-20251017    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-kernel+bounces-870684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE99C0B729
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 00:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 524A64ECED2
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 23:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D873C3009EA;
	Sun, 26 Oct 2025 23:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cZfKK+td"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450AC2FFF85
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 23:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761520828; cv=none; b=b68QlshGkUaJzPjWKImgnP8HnHX3BA4QI0ri6Tk+ycO91VAh9gCh55qzNqo1l22hqig3VUhbCv8lzpIXumUR8VswleXzerDj0R9SA1UQSw7C9Nw+22TPQJanWtDhlMjKfwQyoIZ/Q923VkyQNz4NRbcVFOrkRViWeS1Q6f4KX/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761520828; c=relaxed/simple;
	bh=ICcmP7uY+Udb/EwnpBmNQvmhpJXCReQnHkSzOELZZX4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BDPtz55SuXWDC5Jokonn6pFrG0zS1D6dDMhlX4QJFZv1M7C/GeAcCy88drgucs+xma0XaN7eC4Uq72BEIPCY46RLpzv4lF0z3ERBkB2KMGRaNu/aLI6/80LCotdjA8UViPM01urj03m9VGWmqI5mAUT6rw08utz2wYM0GPMDC14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cZfKK+td; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761520827; x=1793056827;
  h=date:from:to:cc:subject:message-id;
  bh=ICcmP7uY+Udb/EwnpBmNQvmhpJXCReQnHkSzOELZZX4=;
  b=cZfKK+tdJUutd+lf6QQI3YpqAtVCl3sX46WfcLXFFEbxv7xe1/hZG8aO
   tDbWUIOWZON6AmEvMrdE3yoWTY0anIB34tg37jcejXd5mTUU/E8TtAOqD
   ScXPiqkhw2OSEwSgTTitUn+5Nv2lYJgTEIksUnabStV2s7M1/cIlLQyhv
   cdkkIUrIPtC69N4UmLllmpEgG9EfiEWNYaq+CZo+u+SF6PL/HDEh6fJrE
   UjmzkV+8+A2nhqdHzakjdXntyHwS2EtKY6GjN2nB8fr9+Pk94tI+TDqNx
   iiwbhNBn96iKW/3On/1CmnhilZsUHFTTL567+g3aQOlzrg/KMdlY0eNUK
   Q==;
X-CSE-ConnectionGUID: 2jLmvt5tRaywKZ+gZ7Zxcg==
X-CSE-MsgGUID: ZWlVwEPKQZuI1hz/w+oCvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63502800"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63502800"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2025 16:20:26 -0700
X-CSE-ConnectionGUID: hqr1vS39SI24S4dYRBGjrQ==
X-CSE-MsgGUID: uARQQPR5QiKob0KMtabyhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,257,1754982000"; 
   d="scan'208";a="184118258"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 26 Oct 2025 16:20:23 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vDA1t-000GNp-0B;
	Sun, 26 Oct 2025 23:20:12 +0000
Date: Mon, 27 Oct 2025 07:19:34 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 8d309ae354d6b5537f6c716ca5c411ece5bd78c0
Message-ID: <202510270728.XqEYQQkR-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 8d309ae354d6b5537f6c716ca5c411ece5bd78c0  Merge branch into tip/master: 'x86/sgx'

elapsed time: 959m

configs tested: 133
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251026    gcc-13.4.0
arc                   randconfig-002-20251026    gcc-9.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                         orion5x_defconfig    clang-22
arm                   randconfig-001-20251026    clang-22
arm                   randconfig-002-20251026    clang-20
arm                   randconfig-003-20251026    clang-17
arm                   randconfig-004-20251026    clang-20
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251026    gcc-15.1.0
arm64                 randconfig-002-20251026    clang-22
arm64                 randconfig-003-20251026    gcc-8.5.0
arm64                 randconfig-004-20251026    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251026    gcc-15.1.0
csky                  randconfig-002-20251026    gcc-9.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251026    clang-18
hexagon               randconfig-002-20251026    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251026    gcc-14
i386        buildonly-randconfig-002-20251026    clang-20
i386        buildonly-randconfig-003-20251026    gcc-14
i386        buildonly-randconfig-004-20251026    clang-20
i386        buildonly-randconfig-005-20251026    clang-20
i386        buildonly-randconfig-006-20251026    gcc-14
i386                                defconfig    clang-20
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251026    clang-22
loongarch             randconfig-002-20251026    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                         bigsur_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251026    gcc-8.5.0
nios2                 randconfig-002-20251026    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251026    gcc-12.5.0
parisc                randconfig-002-20251026    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                     mpc83xx_defconfig    clang-22
powerpc               randconfig-001-20251026    gcc-13.4.0
powerpc               randconfig-002-20251026    gcc-8.5.0
powerpc               randconfig-003-20251026    gcc-10.5.0
powerpc64             randconfig-001-20251026    gcc-10.5.0
powerpc64             randconfig-002-20251026    gcc-12.5.0
powerpc64             randconfig-003-20251026    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251027    gcc-13.4.0
riscv                 randconfig-002-20251027    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251027    clang-22
s390                  randconfig-002-20251027    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                        edosk7760_defconfig    gcc-15.1.0
sh                    randconfig-001-20251027    gcc-12.5.0
sh                    randconfig-002-20251027    gcc-15.1.0
sh                           se7343_defconfig    gcc-15.1.0
sh                           se7780_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251027    gcc-12.5.0
sparc                 randconfig-002-20251027    gcc-8.5.0
sparc                       sparc64_defconfig    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251027    gcc-14.3.0
sparc64               randconfig-002-20251027    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251027    clang-22
um                    randconfig-002-20251027    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251026    clang-20
x86_64      buildonly-randconfig-002-20251026    gcc-12
x86_64      buildonly-randconfig-003-20251026    gcc-14
x86_64      buildonly-randconfig-004-20251026    gcc-14
x86_64      buildonly-randconfig-005-20251026    clang-20
x86_64      buildonly-randconfig-006-20251026    gcc-14
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251027    gcc-12.5.0
xtensa                randconfig-002-20251027    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


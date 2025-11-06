Return-Path: <linux-kernel+bounces-889244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F990C3D0EA
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 19:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34A93420D28
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 18:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E0D33C50D;
	Thu,  6 Nov 2025 18:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J4oxJInJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EBB30E0F6
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 18:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762453260; cv=none; b=RnTQCq+WBa3KsNLaOi8rMjLcucvKoEahIMQdT+y6J4z+UVGz1QE3AAaBOot6YOB5K5TE1FVotQyabXa5VJD7xyI/lWCLsj4tI1f08x77JCJcQ4skrnvnZj+5ipMxjXkFUn20e9NMeYL8VZ427el/ley8w9WjxB6c4OnI+gkZYWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762453260; c=relaxed/simple;
	bh=+JTTwZLsNnLGqHxQhaLG/xmNHOwhfVyvUXRVhVH4WQ8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KnQMSAvqmdUk/gYqAMhKEL5szYXnuL+MVtDc2ZQfECFZMsu827/ucONxJaaML3hiTVK1maXIhrXpbJw+xom9DZP7QfU4PX7HDKs/306HXBS7GRraztdXB0tyG4snTU617jGm+IeoSB92HSTwFZUEAUVi3JLgSHZARJqxKCbnsq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J4oxJInJ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762453259; x=1793989259;
  h=date:from:to:cc:subject:message-id;
  bh=+JTTwZLsNnLGqHxQhaLG/xmNHOwhfVyvUXRVhVH4WQ8=;
  b=J4oxJInJF7stBrkYSHVUVr9vyBb/rAhwaqa8fVOCytNOfy1cMXYiIAB/
   qauIol3N93Pfu8Qb8GWNs4o4WLw15V9tYDT9443vjAWq28DDWFBT0G+eP
   RHrPaMY/xcOFaYilArFIqWICc5T+SJHboeLVTlLXtS0iKM31zoexitV0W
   lKTmYtdr2Y2yNVziPzfm7D3siGm97a9AWQdHRYWQvMGigsIL04tzd2mkf
   sN9pR4FXSLmJhxQR5Q9Szz4fzYdjmNaKT40Nbh4REUtQ1tw5c4CQsHCzt
   oBvmcS2e9gCKOWLk+zEhCafNWyNbEW6GuV2vqxlMtTRvBPmEJDeNr1tQR
   g==;
X-CSE-ConnectionGUID: BYUuycrkTAKCS4UqHUQCqw==
X-CSE-MsgGUID: JR5f6ZNkTiWaaxr8/VFVBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64637478"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="64637478"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 10:20:54 -0800
X-CSE-ConnectionGUID: 7sIZGiIrQ5S6OCxf+QfP9w==
X-CSE-MsgGUID: 0agj9sNIS9W+Jimq5hsjig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="218487345"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 06 Nov 2025 10:20:53 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vH4bK-000UFg-2a;
	Thu, 06 Nov 2025 18:20:50 +0000
Date: Fri, 07 Nov 2025 02:20:03 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD REGRESSION
 8411fdb92360d0b4d3337492a25ee2de7fb6c425
Message-ID: <202511070257.NvkOLRf4-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 8411fdb92360d0b4d3337492a25ee2de7fb6c425  Merge branch into tip/master: 'x86/sgx'

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202511061929.VZHgI3kd-lkp@intel.com

    vmlinux.o: warning: objtool: user_exc_vmm_communication+0x1ba: call to __kasan_check_read() leaves .noinstr.text section

Error/Warning ids grouped by kconfigs:

recent_errors
`-- x86_64-allmodconfig
    `-- vmlinux.o:warning:objtool:user_exc_vmm_communication:call-to-__kasan_check_read()-leaves-.noinstr.text-section

elapsed time: 1818m

configs tested: 99
configs skipped: 2

tested configs:
alpha                   allnoconfig    gcc-15.1.0
alpha                  allyesconfig    gcc-15.1.0
arc                     allnoconfig    gcc-15.1.0
arc         randconfig-001-20251106    gcc-12.5.0
arc         randconfig-002-20251106    gcc-8.5.0
arm                     allnoconfig    clang-22
arm         milbeaut_m10v_defconfig    clang-19
arm         randconfig-001-20251106    gcc-11.5.0
arm         randconfig-002-20251106    clang-22
arm         randconfig-003-20251106    gcc-10.5.0
arm         randconfig-004-20251106    gcc-8.5.0
arm64                   allnoconfig    gcc-15.1.0
arm64                  allyesconfig    clang-22
arm64       randconfig-001-20251106    gcc-11.5.0
arm64       randconfig-002-20251106    clang-19
arm64       randconfig-003-20251106    gcc-14.3.0
arm64       randconfig-004-20251106    gcc-15.1.0
csky                   allmodconfig    gcc-15.1.0
csky                    allnoconfig    gcc-15.1.0
csky                   allyesconfig    gcc-15.1.0
csky        randconfig-001-20251106    gcc-12.5.0
csky        randconfig-002-20251106    gcc-15.1.0
hexagon                 allnoconfig    clang-22
hexagon                allyesconfig    clang-22
hexagon     randconfig-001-20251105    clang-22
hexagon     randconfig-002-20251105    clang-20
i386                    allnoconfig    gcc-14
loongarch              allmodconfig    clang-19
loongarch               allnoconfig    clang-22
loongarch              allyesconfig    clang-22
loongarch   randconfig-001-20251105    clang-18
loongarch   randconfig-002-20251105    clang-20
m68k                   allmodconfig    gcc-15.1.0
m68k                    allnoconfig    gcc-15.1.0
m68k                   allyesconfig    gcc-15.1.0
m68k             m5249evb_defconfig    gcc-15.1.0
microblaze             allmodconfig    gcc-15.1.0
microblaze              allnoconfig    gcc-15.1.0
microblaze             allyesconfig    gcc-15.1.0
mips                   allmodconfig    gcc-15.1.0
mips                    allnoconfig    gcc-15.1.0
mips                   allyesconfig    gcc-15.1.0
nios2                   allnoconfig    gcc-11.5.0
nios2       randconfig-001-20251105    gcc-9.5.0
nios2       randconfig-002-20251105    gcc-8.5.0
openrisc                allnoconfig    gcc-15.1.0
parisc                  allnoconfig    gcc-15.1.0
parisc      randconfig-001-20251106    gcc-10.5.0
parisc      randconfig-002-20251106    gcc-10.5.0
powerpc                 allnoconfig    gcc-15.1.0
powerpc           asp8347_defconfig    clang-22
powerpc        mpc885_ads_defconfig    clang-22
powerpc     randconfig-001-20251106    gcc-14.3.0
powerpc     randconfig-002-20251106    clang-22
powerpc           taishan_defconfig    clang-17
powerpc64   randconfig-002-20251106    gcc-8.5.0
riscv                   allnoconfig    gcc-15.1.0
riscv       randconfig-001-20251105    gcc-8.5.0
riscv       randconfig-002-20251105    clang-18
s390                   allmodconfig    clang-18
s390                    allnoconfig    clang-22
s390                   allyesconfig    gcc-15.1.0
s390        randconfig-001-20251105    gcc-8.5.0
s390        randconfig-002-20251105    gcc-14.3.0
sh                     allmodconfig    gcc-15.1.0
sh                      allnoconfig    gcc-15.1.0
sh                     allyesconfig    gcc-15.1.0
sh                        defconfig    gcc-15.1.0
sh          randconfig-001-20251105    gcc-10.5.0
sh          randconfig-002-20251105    gcc-11.5.0
sh                  shmin_defconfig    gcc-15.1.0
sh                   shx3_defconfig    gcc-15.1.0
sparc                  allmodconfig    gcc-15.1.0
sparc                   allnoconfig    gcc-15.1.0
sparc       randconfig-001-20251106    gcc-15.1.0
sparc       randconfig-002-20251106    gcc-15.1.0
sparc             sparc64_defconfig    gcc-15.1.0
sparc64                   defconfig    clang-20
sparc64     randconfig-001-20251106    gcc-13.4.0
sparc64     randconfig-002-20251106    clang-20
um                     allmodconfig    clang-19
um                      allnoconfig    clang-22
um                     allyesconfig    gcc-14
um                        defconfig    clang-22
um                   i386_defconfig    gcc-14
um          randconfig-001-20251106    gcc-14
um          randconfig-002-20251106    clang-22
um                 x86_64_defconfig    clang-22
x86_64                  allnoconfig    clang-20
x86_64                    defconfig    gcc-14
x86_64      randconfig-011-20251106    clang-20
x86_64      randconfig-012-20251106    clang-20
x86_64      randconfig-013-20251106    clang-20
x86_64      randconfig-014-20251106    gcc-14
x86_64      randconfig-015-20251106    gcc-14
x86_64      randconfig-016-20251106    gcc-12
xtensa                  allnoconfig    gcc-15.1.0
xtensa      randconfig-001-20251106    gcc-9.5.0
xtensa      randconfig-002-20251106    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


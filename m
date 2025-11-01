Return-Path: <linux-kernel+bounces-881132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A2FC27885
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 06:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A9D91B22BE8
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 05:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFB7273803;
	Sat,  1 Nov 2025 05:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OtH8YDfG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025CC2264AB
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 05:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761974390; cv=none; b=pJXd0moKvA/xcfmEEM2JfsnI8wDbAiQNNqb3/ucqjkD/I/lbbQVCz9Y55mPCe1NbJAu66jQqXgQU2TMC84XIuNSo+jMdkCm6IOQ9T1LYlPQr3uRur5iCG+aiuOWqPGyqAukFfEYPgtu/RQwMB2o7Jyu6TaPexuVuFRBtz7BTMiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761974390; c=relaxed/simple;
	bh=S+1/sOx4HOal5S+EENw+iQMUWJALeh3YGWWybDdzmiU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MZls++ADUYyNs3IeRXedHptyOu0WwsVY/ar74mgMHtCqHQY6lXl92Eo4DUBiYBwiTnM/nO76gyO+68XqN0nA9KTfrE3D/Fqtbx+T/mYlUI8aVuIvzg3f0/73WDo2dpJ5OMpdMw1sVUzJCHWUgUmfp8Rc4vrFz/OQHniwI71jtac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OtH8YDfG; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761974389; x=1793510389;
  h=date:from:to:cc:subject:message-id;
  bh=S+1/sOx4HOal5S+EENw+iQMUWJALeh3YGWWybDdzmiU=;
  b=OtH8YDfGqIYDcg7ad3sSWDAPCwr1zLxkKToXoMGrQwyb7mTQT90nukEW
   UZsqDpPsZ+C3reHXhzdkZlnYGVYLNNSGmGd+D7+7nRPGlT+H2hflIivnL
   NXxHTb4SHECrX38FvLPHAcsS2oFagWqEa1USDsLFJH+kvw28tEhCluRJ9
   G8ypmySmm7gc+lDRBkY9+uauNFM/1jbjBB6/DKax1dPV1E9Hez57M62e3
   bXYobDyx3YYUJPF04HRz2tvYY4vx77kE+429Bd5DY4cScYyntkq2dJSX7
   Xg7TZn2MQB6+odX0g4l4qW/tJh5PtFd8SsRQ3gv9DiVyt/r2USJeo9F9h
   A==;
X-CSE-ConnectionGUID: d56dSXXRRzmtduYe2M8IiA==
X-CSE-MsgGUID: 75i+cw/OSyqlyrMRFwyLLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="74810619"
X-IronPort-AV: E=Sophos;i="6.19,271,1754982000"; 
   d="scan'208";a="74810619"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 22:19:47 -0700
X-CSE-ConnectionGUID: cW9eBN4KTD61GB8BcdETnQ==
X-CSE-MsgGUID: nl0ex36dS16eyeTgQ+uxqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,271,1754982000"; 
   d="scan'208";a="190746742"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 31 Oct 2025 22:19:46 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vF41g-000Nw8-0H;
	Sat, 01 Nov 2025 05:19:44 +0000
Date: Sat, 01 Nov 2025 13:18:56 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/sev] BUILD SUCCESS
 92ad6505a4b5e28afcc8cf5f4dd3fd137e58026b
Message-ID: <202511011350.t8fi8FJU-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sev
branch HEAD: 92ad6505a4b5e28afcc8cf5f4dd3fd137e58026b  x86/sev: Include XSS value in GHCB CPUID request

elapsed time: 945m

configs tested: 97
configs skipped: 119

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                  randconfig-001-20251101    gcc-8.5.0
arc                  randconfig-002-20251101    gcc-8.5.0
arc                       vdk_hs38_defconfig    gcc-15.1.0
arm                        mv78xx0_defconfig    gcc-15.1.0
arm                      netwinder_defconfig    gcc-15.1.0
arm                  randconfig-001-20251101    gcc-8.5.0
arm                  randconfig-002-20251101    gcc-8.5.0
arm                  randconfig-003-20251101    gcc-8.5.0
arm                  randconfig-004-20251101    gcc-8.5.0
hexagon              randconfig-001-20251101    clang-19
hexagon              randconfig-002-20251101    clang-19
i386                            allmodconfig    clang-20
i386                             allnoconfig    gcc-14
i386                            allyesconfig    clang-20
i386       buildonly-randconfig-001-20251101    clang-20
i386       buildonly-randconfig-002-20251101    clang-20
i386       buildonly-randconfig-003-20251101    clang-20
i386       buildonly-randconfig-004-20251101    clang-20
i386       buildonly-randconfig-005-20251101    clang-20
i386       buildonly-randconfig-006-20251101    clang-20
i386                 randconfig-001-20251101    gcc-14
i386                 randconfig-002-20251101    gcc-14
i386                 randconfig-003-20251101    gcc-14
i386                 randconfig-004-20251101    gcc-14
i386                 randconfig-005-20251101    gcc-14
i386                 randconfig-006-20251101    gcc-14
i386                 randconfig-007-20251101    gcc-14
i386                 randconfig-011-20251101    clang-20
i386                 randconfig-012-20251101    clang-20
i386                 randconfig-013-20251101    clang-20
i386                 randconfig-014-20251101    clang-20
i386                 randconfig-015-20251101    clang-20
i386                 randconfig-016-20251101    clang-20
i386                 randconfig-017-20251101    clang-20
loongarch            randconfig-001-20251101    clang-19
loongarch            randconfig-002-20251101    clang-19
mips                          ci20_defconfig    gcc-15.1.0
nios2                randconfig-001-20251101    clang-19
nios2                randconfig-002-20251101    clang-19
parisc               randconfig-001-20251101    clang-20
parisc               randconfig-002-20251101    clang-20
powerpc                     mgcoge_defconfig    gcc-15.1.0
powerpc              randconfig-001-20251101    clang-20
powerpc              randconfig-002-20251101    clang-20
powerpc                    tqm8540_defconfig    gcc-15.1.0
powerpc64            randconfig-001-20251101    clang-20
powerpc64            randconfig-002-20251101    clang-20
riscv                randconfig-001-20251101    clang-17
riscv                randconfig-002-20251101    clang-17
s390                            allmodconfig    gcc-15.1.0
s390                            allyesconfig    gcc-15.1.0
s390                 randconfig-001-20251101    clang-17
s390                 randconfig-002-20251101    clang-17
sh                              allmodconfig    gcc-15.1.0
sh                              allyesconfig    gcc-15.1.0
sh                                 defconfig    gcc-14
sh                        ecovec24_defconfig    gcc-15.1.0
sh                   randconfig-001-20251101    clang-17
sh                   randconfig-002-20251101    clang-17
sparc                           allmodconfig    gcc-15.1.0
sparc                randconfig-001-20251101    clang-16
sparc                randconfig-002-20251101    clang-16
sparc64                            defconfig    gcc-14
sparc64              randconfig-001-20251101    clang-16
sparc64              randconfig-002-20251101    clang-16
um                              alldefconfig    gcc-15.1.0
um                                 defconfig    gcc-14
um                            i386_defconfig    gcc-14
um                   randconfig-001-20251101    clang-16
um                   randconfig-002-20251101    clang-16
um                          x86_64_defconfig    gcc-14
x86_64                          allmodconfig    clang-20
x86_64                           allnoconfig    clang-20
x86_64                          allyesconfig    clang-20
x86_64     buildonly-randconfig-001-20251101    gcc-14
x86_64     buildonly-randconfig-002-20251101    gcc-14
x86_64     buildonly-randconfig-003-20251101    gcc-14
x86_64     buildonly-randconfig-004-20251101    gcc-14
x86_64     buildonly-randconfig-005-20251101    gcc-14
x86_64     buildonly-randconfig-006-20251101    gcc-14
x86_64                             defconfig    gcc-14
x86_64                                 kexec    clang-20
x86_64               randconfig-001-20251101    clang-20
x86_64               randconfig-002-20251101    clang-20
x86_64               randconfig-003-20251101    clang-20
x86_64               randconfig-004-20251101    clang-20
x86_64               randconfig-005-20251101    clang-20
x86_64               randconfig-006-20251101    clang-20
x86_64                              rhel-9.4    clang-20
x86_64                          rhel-9.4-bpf    gcc-14
x86_64                         rhel-9.4-func    clang-20
x86_64                   rhel-9.4-kselftests    clang-20
x86_64                        rhel-9.4-kunit    gcc-14
x86_64                          rhel-9.4-ltp    gcc-14
x86_64                         rhel-9.4-rust    clang-20
xtensa               randconfig-001-20251101    clang-16
xtensa               randconfig-002-20251101    clang-16

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


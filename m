Return-Path: <linux-kernel+bounces-807095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D87B4A027
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 05:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D48B443D78
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 03:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B8D27381E;
	Tue,  9 Sep 2025 03:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KntAGqO8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660BA27A906
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 03:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757389357; cv=none; b=TU3Xgdt27L/8MD4IKFt1dQmeyYXtp/29ARdhhR5PxRygJMR4PDn4VnAxXKpulMw7ekNMdImFvc8XsxKH8pM6fh/BhXmPpKnUp9gyMXR/rVEesUGtDywmKfQxLNS0ZI3RwFKbGvfapWzxdMPfdf1y69JlkssyCO8YlKgHCWXbyrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757389357; c=relaxed/simple;
	bh=ydePrUgY0XSYVEF1w+55eMjtUQOCU0ibdHqsGJwK4b0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=IHdmmZPsTLtKa9nXY1yFIHWvfjZ62RR0IXpi6oipZGKQEdYfO9Vwn2MjSy5TVDd8eA9eSzkUamYvJQ6n1TJMSQevljXKgrfmInxxOgYgrap7MxJ7f4LCXqYZ+Ip9c8EcUbA4x8rWyck0wzsXNFNEgekfzqTd2XQAiYOtrXOrmAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KntAGqO8; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757389355; x=1788925355;
  h=date:from:to:cc:subject:message-id;
  bh=ydePrUgY0XSYVEF1w+55eMjtUQOCU0ibdHqsGJwK4b0=;
  b=KntAGqO84TbivrRpBjXyZ42bqbIm+2BZXduMKADeNFDJguq7ajGKQo2A
   iKkBiI1tSvNsIMW3vlkhHvowfWjev0hEGSyFGcYJUTMRZUsnXLIcMSCLR
   1oRCGnqhRwMvo9cenj0NO4bNNeUE/MTYbXXW8QAnn8PA7GfjfQAHsCqIn
   pnAdpKD5xlc6HXnzNPYwUvgaV8sW1E+KkrAtbeM9JUVLFJgaPvpxIQzvv
   PsJa57J7mw5bpZb04FzzUHzu2ZM1zqVoYUQxHRGO46mwv9sZNJPxvjmVb
   UPWh85rgHqzB9zhcLljQp2Mx/nJFgpwI5JKW+q1usrs1P5CNY0krX+QPp
   A==;
X-CSE-ConnectionGUID: /2CA32wxQ7a0ggQVjVF0Jg==
X-CSE-MsgGUID: WfugU1+/RDaa5uvYM5pWKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="71034456"
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="71034456"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 20:42:35 -0700
X-CSE-ConnectionGUID: B30wTzzrTpmW9lNuNFo24A==
X-CSE-MsgGUID: 4Kd+HVJLT2euU29lCjBHlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="177315439"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 08 Sep 2025 20:42:34 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uvpFX-0004OS-2t;
	Tue, 09 Sep 2025 03:42:31 +0000
Date: Tue, 09 Sep 2025 11:42:18 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 cba4262a19afae21665ee242b3404bcede5a94d7
Message-ID: <202509091106.OOqhSd5X-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: cba4262a19afae21665ee242b3404bcede5a94d7  x86/cpu/topology: Always try cpu_parse_topology_ext() on AMD/Hygon

elapsed time: 790m

configs tested: 112
configs skipped: 121

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                   randconfig-001-20250909    clang-16
arc                   randconfig-002-20250909    clang-16
arm                        multi_v7_defconfig    clang-22
arm                             mxs_defconfig    clang-22
arm                       netwinder_defconfig    clang-22
arm                   randconfig-001-20250909    clang-16
arm                   randconfig-002-20250909    clang-16
arm                   randconfig-003-20250909    clang-16
arm                   randconfig-004-20250909    clang-16
arm                       versatile_defconfig    clang-22
arm64                 randconfig-001-20250909    clang-16
arm64                 randconfig-002-20250909    clang-16
arm64                 randconfig-003-20250909    clang-16
arm64                 randconfig-004-20250909    clang-16
csky                  randconfig-001-20250909    gcc-8.5.0
csky                  randconfig-002-20250909    gcc-8.5.0
hexagon               randconfig-001-20250909    gcc-8.5.0
hexagon               randconfig-002-20250909    gcc-8.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250908    gcc-14
i386        buildonly-randconfig-001-20250909    clang-20
i386        buildonly-randconfig-002-20250908    gcc-14
i386        buildonly-randconfig-002-20250909    clang-20
i386        buildonly-randconfig-003-20250908    gcc-12
i386        buildonly-randconfig-003-20250909    clang-20
i386        buildonly-randconfig-004-20250908    gcc-14
i386        buildonly-randconfig-004-20250909    clang-20
i386        buildonly-randconfig-005-20250908    clang-20
i386        buildonly-randconfig-005-20250909    clang-20
i386        buildonly-randconfig-006-20250908    clang-20
i386        buildonly-randconfig-006-20250909    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250909    clang-20
i386                  randconfig-002-20250909    clang-20
i386                  randconfig-003-20250909    clang-20
i386                  randconfig-004-20250909    clang-20
i386                  randconfig-005-20250909    clang-20
i386                  randconfig-006-20250909    clang-20
i386                  randconfig-007-20250909    clang-20
i386                  randconfig-011-20250909    gcc-14
i386                  randconfig-012-20250909    gcc-14
i386                  randconfig-013-20250909    gcc-14
i386                  randconfig-014-20250909    gcc-14
i386                  randconfig-015-20250909    gcc-14
i386                  randconfig-016-20250909    gcc-14
i386                  randconfig-017-20250909    gcc-14
loongarch             randconfig-001-20250909    gcc-8.5.0
loongarch             randconfig-002-20250909    gcc-8.5.0
m68k                              allnoconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250909    gcc-8.5.0
nios2                 randconfig-002-20250909    gcc-8.5.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250909    gcc-8.5.0
parisc                randconfig-002-20250909    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                  mpc885_ads_defconfig    clang-22
powerpc                      pasemi_defconfig    clang-22
powerpc               randconfig-001-20250909    gcc-8.5.0
powerpc               randconfig-002-20250909    gcc-8.5.0
powerpc               randconfig-003-20250909    gcc-8.5.0
powerpc64             randconfig-001-20250909    gcc-8.5.0
powerpc64             randconfig-002-20250909    gcc-8.5.0
powerpc64             randconfig-003-20250909    gcc-8.5.0
riscv                 randconfig-001-20250909    gcc-15.1.0
riscv                 randconfig-002-20250909    gcc-15.1.0
s390                  randconfig-001-20250909    gcc-15.1.0
s390                  randconfig-002-20250909    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                    randconfig-001-20250909    gcc-15.1.0
sh                    randconfig-002-20250909    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250909    gcc-15.1.0
sparc                 randconfig-002-20250909    gcc-15.1.0
sparc64               randconfig-001-20250909    gcc-15.1.0
sparc64               randconfig-002-20250909    gcc-15.1.0
um                    randconfig-001-20250909    gcc-15.1.0
um                    randconfig-002-20250909    gcc-15.1.0
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250908    clang-20
x86_64      buildonly-randconfig-001-20250909    gcc-14
x86_64      buildonly-randconfig-002-20250908    gcc-14
x86_64      buildonly-randconfig-002-20250909    gcc-14
x86_64      buildonly-randconfig-003-20250908    gcc-14
x86_64      buildonly-randconfig-003-20250909    gcc-14
x86_64      buildonly-randconfig-004-20250908    gcc-14
x86_64      buildonly-randconfig-004-20250909    gcc-14
x86_64      buildonly-randconfig-005-20250908    gcc-14
x86_64      buildonly-randconfig-005-20250909    gcc-14
x86_64      buildonly-randconfig-006-20250908    clang-20
x86_64      buildonly-randconfig-006-20250909    gcc-14
x86_64                              defconfig    clang-20
x86_64                randconfig-071-20250909    gcc-14
x86_64                randconfig-072-20250909    gcc-14
x86_64                randconfig-073-20250909    gcc-14
x86_64                randconfig-074-20250909    gcc-14
x86_64                randconfig-075-20250909    gcc-14
x86_64                randconfig-076-20250909    gcc-14
x86_64                randconfig-077-20250909    gcc-14
x86_64                randconfig-078-20250909    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250909    gcc-15.1.0
xtensa                randconfig-002-20250909    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


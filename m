Return-Path: <linux-kernel+bounces-812955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9728B53EC6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 00:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F5E44E0258
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 22:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B0C257AF0;
	Thu, 11 Sep 2025 22:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RpzmRfQm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456DC2DC778
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 22:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757630757; cv=none; b=AlYsL7hrjP9BuCas68uQnrdkW0IHx6Ja4XlP2aE/2cjJ4fE3K2jgSJ7QI9y4c9QsZf/lTsekRTQJ9tqOpjEo46JbqxMLNQrOG2zTsZiLkkKF6WbGlbHlSvhVXxPfha5UJskd3z2C+l4fWxuZo04JJYiuUVLWoCyVPhKvvXyrBCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757630757; c=relaxed/simple;
	bh=gOZH0oRFp5VJuaCUmxJZ3ft2p3D+n8aANU1VOiwkMcs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PHT8hklPhiDCFXZWmDst774YKitDtVq54DnjJW2dNtg0lfctZI0CBf/iRPBcHVGh7B49eapNVddNLeihwUi1kZ430qRL5QmfQiHOXw+1IwANJNI7DHxjYTACkX14J/zXlJdJnRLLjJbul7ueOPb7qHuqTQ4czrHDO/yV5y6v5UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RpzmRfQm; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757630755; x=1789166755;
  h=date:from:to:cc:subject:message-id;
  bh=gOZH0oRFp5VJuaCUmxJZ3ft2p3D+n8aANU1VOiwkMcs=;
  b=RpzmRfQmEl7NdJj94yynFuX9r1JTDYR2xoU3TKt3QXomgVcdJ5ULrzR+
   DDqDCXnfBH4vtyQR06wceiyiXucrt4opBcIpvEEED5FwcTW1iMzsySj6q
   80bEjd+qzFv9l8/AaNRBrNqMBB5VVchm01aeUbs8WaKQJsN/4yfI020NC
   Z7+akmKo8fM0sveBhcUu2rtse9FnFY97xNWKxj8ikqbJpa3qdARiPFcW9
   H19+EkAJkrXLRUMRL3UunNYdaIv1fI2QZaVYV//1zim4n3UxlBH4eB7EH
   TA23wyl4aKDkm7j5sUWTZa9InqfZ/k8urKT+Cfa5/jO6aLHWZA4Erb1qR
   w==;
X-CSE-ConnectionGUID: a9xVs+GhR+u9r769IfJ9Vw==
X-CSE-MsgGUID: htg6RT1bRFGhykMTp3cv9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="60050026"
X-IronPort-AV: E=Sophos;i="6.18,258,1751266800"; 
   d="scan'208";a="60050026"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 15:45:54 -0700
X-CSE-ConnectionGUID: 3153we3ERbewRG8W27wrTw==
X-CSE-MsgGUID: Cm/BlFLhRG65r44mx7JsJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,258,1751266800"; 
   d="scan'208";a="173642664"
Received: from lkp-server02.sh.intel.com (HELO eb5fdfb2a9b7) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 11 Sep 2025 15:45:53 -0700
Received: from kbuild by eb5fdfb2a9b7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uwq31-0000gK-0H;
	Thu, 11 Sep 2025 22:45:47 +0000
Date: Fri, 12 Sep 2025 06:45:39 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/core] BUILD SUCCESS
 8f67d072aeb1598427bb0a6d823e265bb78ba534
Message-ID: <202509120629.1Q0mToBB-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
branch HEAD: 8f67d072aeb1598427bb0a6d823e265bb78ba534  Merge branch 'x86/bugs' into x86/core, to resolve conflict

elapsed time: 872m

configs tested: 72
configs skipped: 117

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
arc                               allnoconfig    clang-22
arc                   randconfig-001-20250912    clang-19
arc                   randconfig-002-20250912    clang-19
arm                               allnoconfig    clang-22
arm                   randconfig-001-20250912    clang-19
arm                   randconfig-002-20250912    clang-19
arm                   randconfig-003-20250912    clang-19
arm                   randconfig-004-20250912    clang-19
arm64                             allnoconfig    clang-22
arm64                 randconfig-001-20250912    clang-19
arm64                 randconfig-002-20250912    clang-19
arm64                 randconfig-003-20250912    clang-19
arm64                 randconfig-004-20250912    clang-19
csky                              allnoconfig    clang-22
hexagon                           allnoconfig    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250911    clang-20
i386        buildonly-randconfig-001-20250912    gcc-13
i386        buildonly-randconfig-002-20250911    clang-20
i386        buildonly-randconfig-002-20250912    gcc-13
i386        buildonly-randconfig-003-20250911    clang-20
i386        buildonly-randconfig-003-20250912    gcc-13
i386        buildonly-randconfig-004-20250911    clang-20
i386        buildonly-randconfig-004-20250912    gcc-13
i386        buildonly-randconfig-005-20250911    clang-20
i386        buildonly-randconfig-005-20250912    gcc-13
i386        buildonly-randconfig-006-20250911    clang-20
i386        buildonly-randconfig-006-20250912    gcc-13
i386                                defconfig    clang-20
loongarch                         allnoconfig    clang-22
m68k                          amiga_defconfig    gcc-15.1.0
m68k                        mvme16x_defconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
openrisc                          allnoconfig    clang-22
parisc                            allnoconfig    clang-22
parisc                              defconfig    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                     ep8248e_defconfig    gcc-15.1.0
powerpc                    mvme5100_defconfig    gcc-15.1.0
powerpc                     stx_gp3_defconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
s390                              allnoconfig    clang-22
s390                       zfcpdump_defconfig    gcc-15.1.0
sh                         ap325rxa_defconfig    gcc-15.1.0
sh                           se7721_defconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
um                                allnoconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250911    gcc-14
x86_64      buildonly-randconfig-001-20250912    clang-20
x86_64      buildonly-randconfig-002-20250911    gcc-14
x86_64      buildonly-randconfig-002-20250912    clang-20
x86_64      buildonly-randconfig-003-20250911    clang-20
x86_64      buildonly-randconfig-003-20250912    clang-20
x86_64      buildonly-randconfig-004-20250911    clang-20
x86_64      buildonly-randconfig-004-20250912    clang-20
x86_64      buildonly-randconfig-005-20250911    clang-20
x86_64      buildonly-randconfig-005-20250912    clang-20
x86_64      buildonly-randconfig-006-20250911    gcc-14
x86_64      buildonly-randconfig-006-20250912    clang-20
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


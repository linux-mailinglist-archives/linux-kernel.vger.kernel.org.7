Return-Path: <linux-kernel+bounces-852385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99671BD8D3C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B08844F5071
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89C82FCBED;
	Tue, 14 Oct 2025 10:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KF+3Q3LS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862C72FB99A
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760439387; cv=none; b=PD75ummbvJ/E8Vj08+7CHQqskquheKNJz7b7bgamzZ8shQ0bnkKj9xslzVwrPRiLGoW3hb6L40z1tLPrZLdONJruOkL/AxVJNmBXqe07WvzIMXfYOnzaX8zYUZTGS11mJDNflWggrgPJccrMOzFvplc+eoxiELHUKl4FqihqeMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760439387; c=relaxed/simple;
	bh=51BmkPIFua1qYmhOko2LXrdbTTvz26PGdxLSjKB1ReU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=rWPxnPJdXYkCjpC1osuMeOaBd5Az9ghHHjS+6tdKCGZwMdvQwUuGt9LiuJjwYmBry8ZSVULjVfkU+Q042w0A+rFnHhl5OzvKAW8A+AmSvmhvvILQ1T328Kc/+0D+9Vt7UEUnYhlZkHfdOqgxyNt3gvSqmOrSdBP/eu53W8Pax5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KF+3Q3LS; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760439386; x=1791975386;
  h=date:from:to:cc:subject:message-id;
  bh=51BmkPIFua1qYmhOko2LXrdbTTvz26PGdxLSjKB1ReU=;
  b=KF+3Q3LSG/y8BQ0psY//D2ffgsqFa0lnQ18cnptSN0Sy7KTbFFI26SlR
   dM2irUNJ9McE3t1ioo09oNrYt4rlrHTSK4xB3GUUnXt73n5p1oguzEjRB
   0tvn+P41cpjnGyJQT5TjZxCuJjuLxxkyBZGUElY3Y1+iiq2x23cfYpgUA
   NzgouhOQmPA/zOFYMfmJnNsE2T3jia7GzOs5/tLjLjxB/DvR8m6b740gz
   hZLVkYJWTWbBlQcHmj4thd/zDjDcvhU6KlllM7qwjHoyX0mV9O8F2LsMF
   ocMIXBC3mbgJz5h2KRUztyVGPYD0U+Yi3dIwUMLcFnGdvR9ioYSa+9z4I
   A==;
X-CSE-ConnectionGUID: NxHbw4ENQ4ODZBeJVOhgKA==
X-CSE-MsgGUID: Bj+9WhXBQdCrNLOHKPcwEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="66252633"
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="66252633"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 03:56:24 -0700
X-CSE-ConnectionGUID: /q02BPWBTOKDak9sEDYSJQ==
X-CSE-MsgGUID: y3jng3/RQTyeygh02aXzpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="186272813"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 14 Oct 2025 03:56:22 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v8chX-0002fz-38;
	Tue, 14 Oct 2025 10:56:19 +0000
Date: Tue, 14 Oct 2025 18:56:18 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 83b0177a6c4889b3a6e865da5e21b2c9d97d0551
Message-ID: <202510141812.f8FK6DaX-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 83b0177a6c4889b3a6e865da5e21b2c9d97d0551  x86/mm: Fix SMP ordering in switch_mm_irqs_off()

elapsed time: 821m

configs tested: 65
configs skipped: 119

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                          allyesconfig    clang-19
arc                 randconfig-001-20251014    clang-16
arc                 randconfig-002-20251014    clang-16
arm                 randconfig-001-20251014    clang-16
arm                 randconfig-002-20251014    clang-16
arm                 randconfig-003-20251014    clang-16
arm                 randconfig-004-20251014    clang-16
arm64               randconfig-001-20251014    clang-16
arm64               randconfig-002-20251014    clang-16
arm64               randconfig-003-20251014    clang-16
arm64               randconfig-004-20251014    clang-16
hexagon                        allmodconfig    clang-19
hexagon                        allyesconfig    clang-19
i386                           allmodconfig    clang-20
i386                            allnoconfig    clang-20
i386                           allyesconfig    clang-20
i386      buildonly-randconfig-001-20251014    gcc-14
i386      buildonly-randconfig-002-20251014    clang-20
i386      buildonly-randconfig-002-20251014    gcc-14
i386      buildonly-randconfig-003-20251014    clang-20
i386      buildonly-randconfig-003-20251014    gcc-14
i386      buildonly-randconfig-004-20251014    gcc-14
i386      buildonly-randconfig-005-20251014    gcc-14
i386      buildonly-randconfig-006-20251014    clang-20
i386      buildonly-randconfig-006-20251014    gcc-14
i386                              defconfig    clang-20
i386                randconfig-001-20251014    clang-20
i386                randconfig-002-20251014    clang-20
i386                randconfig-003-20251014    clang-20
i386                randconfig-004-20251014    clang-20
i386                randconfig-005-20251014    clang-20
i386                randconfig-006-20251014    clang-20
i386                randconfig-007-20251014    clang-20
i386                randconfig-011-20251014    gcc-14
i386                randconfig-012-20251014    gcc-14
i386                randconfig-013-20251014    gcc-14
i386                randconfig-014-20251014    gcc-14
i386                randconfig-015-20251014    gcc-14
i386                randconfig-016-20251014    gcc-14
i386                randconfig-017-20251014    gcc-14
openrisc                        allnoconfig    clang-22
parisc                          allnoconfig    clang-22
powerpc                         allnoconfig    clang-22
riscv                           allnoconfig    clang-22
s390                            allnoconfig    clang-22
um                             allmodconfig    clang-19
um                              allnoconfig    clang-22
um                             allyesconfig    clang-19
x86_64                          allnoconfig    clang-20
x86_64                         allyesconfig    clang-20
x86_64    buildonly-randconfig-001-20251014    gcc-14
x86_64    buildonly-randconfig-002-20251014    clang-20
x86_64    buildonly-randconfig-003-20251014    gcc-14
x86_64    buildonly-randconfig-004-20251014    clang-20
x86_64    buildonly-randconfig-005-20251014    clang-20
x86_64    buildonly-randconfig-006-20251014    gcc-14
x86_64                            defconfig    clang-20
x86_64                                kexec    clang-20
x86_64                             rhel-9.4    clang-20
x86_64                         rhel-9.4-bpf    gcc-14
x86_64                        rhel-9.4-func    clang-20
x86_64                  rhel-9.4-kselftests    clang-20
x86_64                       rhel-9.4-kunit    gcc-14
x86_64                         rhel-9.4-ltp    gcc-14
x86_64                        rhel-9.4-rust    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


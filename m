Return-Path: <linux-kernel+bounces-791947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BC0B3BE8C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E155B62A4D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A923218BD;
	Fri, 29 Aug 2025 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NHX8f5Bv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B95831DD85
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756478933; cv=none; b=d2yBjKaT8bYwNBE7NF+sEc9Bf5TZtoAbm3kNPVarftPMRsouinyFLrlhCmkyyLHiWMMR6eMARhkAcGbNu6FccC1qNlPzfMD8ATNbWKMkd4w1hxHGrO7+obVQWVreHPs8cSJ+KJThYkiMbJIgDZgKqAuB8+GxOUQNLLRjx2qOLmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756478933; c=relaxed/simple;
	bh=d3uSaiP6o4ANAzPj6GeJaQFA9/M0WtnRjFS+hyEGh6Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Dqgwg24eotXCCUKObp4l5kkWTntQKdqU8fz6a6y4Yz5aam5gdfeg7SruDFj0fSlVxZDrmsk1sBauJbDvcqt2XWduD1ybArWDrCCh6U7i2w8ur01lM+ijlf5FJxT/Ss6S3EfJPn8ImaCFzWAn0T5EnGVB5qOg6YetN5rO3pem7nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NHX8f5Bv; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756478932; x=1788014932;
  h=date:from:to:cc:subject:message-id;
  bh=d3uSaiP6o4ANAzPj6GeJaQFA9/M0WtnRjFS+hyEGh6Q=;
  b=NHX8f5BvfnJsK6KIz3TQ8ubi50iiw4eGEl3ZORmV7/TwU8C3hCN/UftU
   x1cF9Mg6ILvM9hyjV3mcvcom9sUw/c2Rh8qoKb6WSdEICyYC+SK5QUoKi
   SEaczef6RotGqsqdw3CjAYzyxRs22HWTf5hUXU3BZOdk/UJ1ZrkSTy0Xi
   Y0sgix5V8VeVPQvozH9DClDhPzWI+DJ5FIGIRIntHP1W0/0r+n0AKBKrr
   jPewMZ9JE8j9+H5QC4xhO43mKE4hCnBgdPBRYGp5pzoUKsom/T9SSaLPn
   N13T1mNn3vvvlJoollXJFJBFfWZEhFWIuRq4MoAQwVpjrwr3rpIihuTd0
   Q==;
X-CSE-ConnectionGUID: M23mPJm2SKuwmUMtfQqW4Q==
X-CSE-MsgGUID: BfzQE/SuTvimF0GbSeIn6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11537"; a="58694745"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="58694745"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 07:48:51 -0700
X-CSE-ConnectionGUID: F+kEURNgQYakDdgyVK0Cnw==
X-CSE-MsgGUID: RpAsSxl2SNerCIXHt/KxZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="174751684"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 29 Aug 2025 07:48:51 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1us0OU-000UhD-1H;
	Fri, 29 Aug 2025 14:48:25 +0000
Date: Fri, 29 Aug 2025 22:47:31 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 8b3641dfb6f902407495c63b9b64482b32319b66
Message-ID: <202508292221.iFOGHAXk-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 8b3641dfb6f902407495c63b9b64482b32319b66  x86/bugs: Add attack vector controls for SSB

elapsed time: 1451m

configs tested: 105
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250829    gcc-8.5.0
arc                   randconfig-002-20250829    gcc-10.5.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250829    gcc-10.5.0
arm                   randconfig-002-20250829    clang-22
arm                   randconfig-003-20250829    clang-22
arm                   randconfig-004-20250829    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250829    clang-22
arm64                 randconfig-002-20250829    gcc-12.5.0
arm64                 randconfig-003-20250829    clang-22
arm64                 randconfig-004-20250829    gcc-9.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250829    gcc-9.5.0
csky                  randconfig-002-20250829    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250829    clang-22
hexagon               randconfig-002-20250829    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250829    gcc-12
i386        buildonly-randconfig-002-20250829    clang-20
i386        buildonly-randconfig-003-20250829    clang-20
i386        buildonly-randconfig-004-20250829    clang-20
i386        buildonly-randconfig-005-20250829    gcc-12
i386        buildonly-randconfig-006-20250829    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250829    clang-22
loongarch             randconfig-002-20250829    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250829    gcc-11.5.0
nios2                 randconfig-002-20250829    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250829    gcc-14.3.0
parisc                randconfig-002-20250829    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250829    gcc-13.4.0
powerpc               randconfig-002-20250829    clang-22
powerpc               randconfig-003-20250829    gcc-12.5.0
powerpc64             randconfig-001-20250829    clang-22
powerpc64             randconfig-002-20250829    clang-22
powerpc64             randconfig-003-20250829    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc64                             defconfig    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250829    gcc-11
x86_64      buildonly-randconfig-002-20250829    gcc-11
x86_64      buildonly-randconfig-003-20250829    gcc-12
x86_64      buildonly-randconfig-004-20250829    clang-20
x86_64      buildonly-randconfig-005-20250829    clang-20
x86_64      buildonly-randconfig-006-20250829    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


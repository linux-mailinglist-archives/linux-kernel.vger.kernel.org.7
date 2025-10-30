Return-Path: <linux-kernel+bounces-877869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEB7C1F3AD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3A55434D66F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D2A340D98;
	Thu, 30 Oct 2025 09:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WFV34O8J"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1C833F39D
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761815832; cv=none; b=pfhRVJIoWi7wmGMa5PawX4w9JP6f8N+M7aI55P05h3HBhcKMdnd7jisCIPkgmDY3hW0mb1v7UjgMhIXnaRD+EsC0izSWqgr26t10R4KV/QMxHimCIcjjOoy2tMpcMDeuxveX2JJxV6n6ti0CPyh6IAzZpeAI+5YM2hQaLBeO0sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761815832; c=relaxed/simple;
	bh=oHIxNOi93ZYx7RYjitpnvfzDoVUR9bCGogU/YQpRaAY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XjMxPfWTqcma1LikSXYbNQWt/UvWLlwSLhXqIA3RmUOxf7BwW7Zf68wA6NwTs0lyjo4vQCFU0dkBHGhUsPWH0ybenA7aN4lpG9oWY08MCqm+s6+PvcuCjI5MDzZwjYWLyFfJXSFxQ6IExWaASFeZjx2BvxVOsc1k2NxiX6NNw9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WFV34O8J; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761815830; x=1793351830;
  h=date:from:to:cc:subject:message-id;
  bh=oHIxNOi93ZYx7RYjitpnvfzDoVUR9bCGogU/YQpRaAY=;
  b=WFV34O8JFre3a6P/09v7yni9SSFze5Q4Lyf2LKxxW1msOAfCGuXR83QX
   VH1SwV/afYth+VJgo5IBTf37OrEb/xdJbBQzf2Sgww5/GqOoRYZYRRBqh
   mcVWzSl4zBiCqLi4pqAhjqCANY5j+9+NzMXgzZvJGaDt0WsONhpk6kfUM
   XlVQRlAp99pN5MzZVVIlbBiCCes+Q3x4f3uFEIpSmNZSppscyO6HyzfFL
   Ci+WTptHtxRVLiQ6HU+GAkGJro3hPjNFoaVZDjQa56wXAliZLObPly09+
   m6U3CDhnt3xvLSlGHhMqxG91Q+LXr4GHO6yqDKr6iQuxa1kpho9ADqucp
   g==;
X-CSE-ConnectionGUID: OBTyfYmvTjGhuvjGAvHnNQ==
X-CSE-MsgGUID: MrTfHbetTheVVd4xyesbJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="63156309"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="63156309"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 02:17:09 -0700
X-CSE-ConnectionGUID: Xu1M/FOLQFaiwPx241+BYw==
X-CSE-MsgGUID: ciJW2GO5RoKdAK2TRtICnQ==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 30 Oct 2025 02:17:09 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vEOmI-000LlV-2e;
	Thu, 30 Oct 2025 09:17:06 +0000
Date: Thu, 30 Oct 2025 17:16:02 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 1f7c44e84b9bb0cb4ea163515ca67b36cd06f44b
Message-ID: <202510301756.gQrNtTHz-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 1f7c44e84b9bb0cb4ea163515ca67b36cd06f44b  Merge branch into tip/master: 'x86/sgx'

elapsed time: 1458m

configs tested: 130
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20251029    gcc-15.1.0
arc                   randconfig-002-20251029    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                   randconfig-001-20251029    gcc-8.5.0
arm                   randconfig-002-20251029    clang-22
arm                   randconfig-003-20251029    clang-22
arm                   randconfig-004-20251029    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251030    gcc-12.5.0
arm64                 randconfig-002-20251030    gcc-8.5.0
arm64                 randconfig-003-20251030    clang-17
arm64                 randconfig-004-20251030    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251030    gcc-13.4.0
csky                  randconfig-002-20251030    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20251029    clang-20
hexagon               randconfig-002-20251029    clang-22
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251030    clang-20
i386        buildonly-randconfig-002-20251030    gcc-14
i386        buildonly-randconfig-003-20251030    clang-20
i386        buildonly-randconfig-004-20251030    clang-20
i386        buildonly-randconfig-005-20251030    gcc-14
i386        buildonly-randconfig-006-20251030    clang-20
i386                  randconfig-001-20251030    gcc-14
i386                  randconfig-002-20251030    gcc-14
i386                  randconfig-003-20251030    clang-20
i386                  randconfig-004-20251030    clang-20
i386                  randconfig-005-20251030    clang-20
i386                  randconfig-011-20251030    gcc-14
i386                  randconfig-012-20251030    gcc-14
i386                  randconfig-013-20251030    gcc-14
i386                  randconfig-014-20251030    clang-20
i386                  randconfig-015-20251030    gcc-14
i386                  randconfig-016-20251030    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251029    clang-22
loongarch             randconfig-002-20251029    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                            mac_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                            allyesconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251029    gcc-11.5.0
nios2                 randconfig-002-20251029    gcc-9.5.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251030    gcc-8.5.0
parisc                randconfig-002-20251030    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                    gamecube_defconfig    clang-22
powerpc                        icon_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251030    clang-22
powerpc               randconfig-002-20251030    clang-22
powerpc                      tqm8xx_defconfig    clang-19
powerpc64             randconfig-001-20251030    gcc-8.5.0
powerpc64             randconfig-002-20251030    gcc-8.5.0
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20251029    clang-20
riscv                 randconfig-002-20251029    clang-19
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20251029    gcc-11.5.0
s390                  randconfig-002-20251029    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                          lboxre2_defconfig    gcc-15.1.0
sh                            migor_defconfig    gcc-15.1.0
sh                    randconfig-001-20251029    gcc-11.5.0
sh                    randconfig-002-20251029    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                            allyesconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251030    gcc-8.5.0
sparc                 randconfig-002-20251030    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251030    gcc-11.5.0
sparc64               randconfig-002-20251030    clang-20
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251030    gcc-14
um                    randconfig-002-20251030    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251030    clang-20
x86_64      buildonly-randconfig-002-20251030    gcc-14
x86_64      buildonly-randconfig-003-20251030    gcc-13
x86_64      buildonly-randconfig-004-20251030    gcc-14
x86_64      buildonly-randconfig-005-20251030    clang-20
x86_64      buildonly-randconfig-006-20251030    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-011-20251030    clang-20
x86_64                randconfig-012-20251030    clang-20
x86_64                randconfig-013-20251030    gcc-13
x86_64                randconfig-014-20251030    gcc-14
x86_64                randconfig-015-20251030    clang-20
x86_64                randconfig-016-20251030    clang-20
x86_64                randconfig-071-20251030    gcc-14
x86_64                randconfig-072-20251030    gcc-14
x86_64                randconfig-073-20251030    clang-20
x86_64                randconfig-074-20251030    clang-20
x86_64                randconfig-075-20251030    gcc-13
x86_64                randconfig-076-20251030    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                          iss_defconfig    gcc-15.1.0
xtensa                randconfig-001-20251030    gcc-10.5.0
xtensa                randconfig-002-20251030    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


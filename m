Return-Path: <linux-kernel+bounces-583384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 102A8A77A19
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 13:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46DE118847BB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 11:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69061FBC92;
	Tue,  1 Apr 2025 11:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NrB9Iryp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA269476
	for <linux-kernel@vger.kernel.org>; Tue,  1 Apr 2025 11:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743508369; cv=none; b=VVNnl77BglcEtFRa2tHVWRt48iYQzJJWtTlbvl3dfxPqFZ3qYEQR4phEv8aCvHYg8NHZ1sTyWAR1Jw1DG0G11y+zuwbAYTX4Sdq5KfYejCBjE/ELrrAVkeDmDkPv3hHI+i5iXXG21SlX07SRpqSexCbr9tTpGoKjKu64ClRtIns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743508369; c=relaxed/simple;
	bh=4iHDFhAanLIqrqeZS3Q0EPECJ9WtAqc/s06dEwpwLzk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=l4yA3GGzsjQfFn2HhSbhKLAt73eKKLp+cO3uCj+wbYsPRpJMCy6VbRA2tEpNOQaxy7I8v8iSqyk0oXbTIGryGO3gRLTGF/+NpPt61W/NqshoWeC0vkX3QmwWvC2VZHsZ3R6nNotYivXTdUJAKbvu+zImjMKhJ5IVzmeVVA0Jo8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NrB9Iryp; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743508367; x=1775044367;
  h=date:from:to:cc:subject:message-id;
  bh=4iHDFhAanLIqrqeZS3Q0EPECJ9WtAqc/s06dEwpwLzk=;
  b=NrB9IrypZZUf1HpTyjFnr4YGTE+IpOK8JWXsr5j+HQWXKfn9cH2zkc8z
   i3sH7ZyHbEP2wmCyYXaV7MF845siGZ+ijJM8avKr15djH14RiMUoHGHwd
   Hz4A79bkB+XTbLc3FGb+50grZwj6TTDNTiHn8Um9LDzu5NqAs+qult3Tz
   Jdfb/cJVDz1gw35Lk1TcKhX1lZhdUHk06kt46rZR7tdoxgz3JAw25+YpK
   Rwf9Ya7cohfDAXRt1/QuceZgccwCqaaFZVN++R2D45sPp/FCcROU+tF1D
   uEE3HpT/7QhsdqySQLlTvcEgxdmSg9cuh0ZUQzb8bbMVYgmNOiOdBDcJT
   w==;
X-CSE-ConnectionGUID: xOuKrij0ScaQV1i6ehphLQ==
X-CSE-MsgGUID: 2J/WBh0rQkiG2oeZeoClEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="56194140"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="56194140"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 04:52:39 -0700
X-CSE-ConnectionGUID: W8PQi4+nRIWgzDC5JyHlMQ==
X-CSE-MsgGUID: YfhKAazKRrKh46bhAlB/6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="126196978"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 01 Apr 2025 04:52:37 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tzaAV-0009px-19;
	Tue, 01 Apr 2025 11:52:35 +0000
Date: Tue, 01 Apr 2025 19:52:31 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 328802738e1cd091d04076317f3c2174125c5916
Message-ID: <202504011921.4O5Ktk6l-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 328802738e1cd091d04076317f3c2174125c5916  rseq: Eliminate useless task_work on execve

elapsed time: 1443m

configs tested: 130
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250331    gcc-8.5.0
arc                   randconfig-002-20250331    gcc-8.5.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                          ixp4xx_defconfig    gcc-14.2.0
arm                        multi_v5_defconfig    gcc-14.2.0
arm                   randconfig-001-20250331    clang-21
arm                   randconfig-002-20250331    clang-21
arm                   randconfig-003-20250331    clang-21
arm                   randconfig-004-20250331    gcc-7.5.0
arm                           spitz_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250331    gcc-8.5.0
arm64                 randconfig-002-20250331    clang-21
arm64                 randconfig-003-20250331    clang-14
arm64                 randconfig-004-20250331    gcc-6.5.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250331    gcc-10.5.0
csky                  randconfig-002-20250331    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250331    clang-20
hexagon               randconfig-002-20250331    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250331    clang-20
i386        buildonly-randconfig-002-20250331    gcc-12
i386        buildonly-randconfig-003-20250331    clang-20
i386        buildonly-randconfig-004-20250331    clang-20
i386        buildonly-randconfig-005-20250331    clang-20
i386        buildonly-randconfig-006-20250331    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250331    gcc-14.2.0
loongarch             randconfig-002-20250331    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          atari_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        bcm47xx_defconfig    clang-18
mips                         bigsur_defconfig    gcc-14.2.0
mips                         db1xxx_defconfig    clang-15
mips                           gcw0_defconfig    clang-14
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250331    gcc-6.5.0
nios2                 randconfig-002-20250331    gcc-6.5.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
openrisc                    or1ksim_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250331    gcc-9.3.0
parisc                randconfig-002-20250331    gcc-11.5.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc               randconfig-001-20250331    clang-21
powerpc               randconfig-002-20250331    clang-16
powerpc               randconfig-003-20250331    clang-18
powerpc                     tqm8560_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250331    gcc-6.5.0
powerpc64             randconfig-002-20250331    gcc-8.5.0
powerpc64             randconfig-003-20250331    clang-19
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250331    clang-14
riscv                 randconfig-002-20250331    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250331    clang-15
s390                  randconfig-002-20250331    clang-15
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                               j2_defconfig    gcc-14.2.0
sh                 kfr2r09-romimage_defconfig    gcc-14.2.0
sh                    randconfig-001-20250331    gcc-10.5.0
sh                    randconfig-002-20250331    gcc-10.5.0
sh                           se7705_defconfig    gcc-14.2.0
sh                           se7722_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250331    gcc-11.5.0
sparc                 randconfig-002-20250331    gcc-7.5.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250331    gcc-7.5.0
sparc64               randconfig-002-20250331    gcc-7.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250331    gcc-12
um                    randconfig-002-20250331    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250331    clang-20
x86_64      buildonly-randconfig-002-20250331    gcc-12
x86_64      buildonly-randconfig-003-20250331    clang-20
x86_64      buildonly-randconfig-004-20250331    clang-20
x86_64      buildonly-randconfig-005-20250331    clang-20
x86_64      buildonly-randconfig-006-20250331    clang-20
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250331    gcc-11.5.0
xtensa                randconfig-002-20250331    gcc-9.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


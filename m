Return-Path: <linux-kernel+bounces-730929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA085B04C8A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 01:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 098DD3AA276
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 23:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D5C2797AF;
	Mon, 14 Jul 2025 23:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YD/gCSxY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615CA27603C
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 23:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752536985; cv=none; b=sHgWXmQ6gOLnLGILOpicYZ7ocxh5x1nhozjTva4TT4Dur1UxtkK9Gt+2UoMN3yDP2R0SZmRkTh0roYwOx7EoTUwE+43IoTMfUdaQC4JEX0qoPSNKBkbPcG7in7h8PwDcbD+x2EB6OCtaV6wrbvFcl7hpQcJAKUQ7Hb5xhHVZw+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752536985; c=relaxed/simple;
	bh=VKePgxy/VIx0hIaeuXDNz+xH7LNdWP1zLXKmABzeXNc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RIX+BghfKG1UGsmMrmLNPm6n7ewU6YMBVwOo0s78k9PR9dQz2XDOYE8yUCjI1/JHmAU03u77dBK/B+W39SHNjDB45UEMPAPu8u+zYZcNwqnKGJrP6ekM83mHgs3EFNQXSn7idLUB8skpOSxoiY6G2qkaA2o0UphmrH8YxNNDagg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YD/gCSxY; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752536983; x=1784072983;
  h=date:from:to:cc:subject:message-id;
  bh=VKePgxy/VIx0hIaeuXDNz+xH7LNdWP1zLXKmABzeXNc=;
  b=YD/gCSxYBNZTWqfyZJlr2BTkmge5JM6EPY7DFn5puzJc0By9gsT0St6a
   Cg3kz1ClwSEv7u9+uSvH4393v72fifeXWqvQX7PWtgCiRMCglN59PMsLL
   4ODc0LNw1vMQxmYL9vnPQTfxPuNl9an+2wZQNZYiokjPL9AWvOHL71d2T
   HReGTD/bsTn/PeNiMXAzWO2Ynehv4Vz7Ql0SsX0uIba0zK7PBlgKxd+1L
   tCAZ1qmEDnodiPYGvWAKVTdT+rcwKzFT3wBhobue2RbGAyC8/WMJd9TUa
   wzTm+KNvyYLyGBL9d7GD/Do2jHtt529WtmEGbVkdp3ew5Xq6rr/gt7UAX
   g==;
X-CSE-ConnectionGUID: /b9hrcgOQza2M/ZpKdAOXA==
X-CSE-MsgGUID: oKCTCDIPT2ewKmGbKvUCkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="53963820"
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="53963820"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 16:49:39 -0700
X-CSE-ConnectionGUID: D/Ie1P1VQgSBLFomHzOVtw==
X-CSE-MsgGUID: Vyp8GXBfTIq3JzLByTX2tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="156880006"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 14 Jul 2025 16:49:38 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ubSvP-0009S3-0s;
	Mon, 14 Jul 2025 23:49:35 +0000
Date: Tue, 15 Jul 2025 07:48:38 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 1eec89a671413ce38df9fe9e70f5130a9eb79a59
Message-ID: <202507150725.HOOkBXTD-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 1eec89a671413ce38df9fe9e70f5130a9eb79a59  sched/topology: Remove sched_domain_topology_level::flags

elapsed time: 866m

configs tested: 111
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250714    gcc-8.5.0
arc                   randconfig-002-20250714    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250714    clang-21
arm                   randconfig-002-20250714    gcc-8.5.0
arm                   randconfig-003-20250714    clang-21
arm                   randconfig-004-20250714    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250714    gcc-13.4.0
arm64                 randconfig-002-20250714    gcc-8.5.0
arm64                 randconfig-003-20250714    gcc-8.5.0
arm64                 randconfig-004-20250714    gcc-14.3.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250714    gcc-10.5.0
csky                  randconfig-002-20250714    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250714    clang-21
hexagon               randconfig-002-20250714    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250714    gcc-12
i386        buildonly-randconfig-002-20250714    clang-20
i386        buildonly-randconfig-003-20250714    gcc-12
i386        buildonly-randconfig-004-20250714    gcc-12
i386        buildonly-randconfig-005-20250714    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch             randconfig-001-20250714    gcc-15.1.0
loongarch             randconfig-002-20250714    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250714    gcc-12.4.0
nios2                 randconfig-002-20250714    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250714    gcc-8.5.0
parisc                randconfig-002-20250714    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc               randconfig-001-20250714    gcc-10.5.0
powerpc               randconfig-002-20250714    gcc-10.5.0
powerpc               randconfig-003-20250714    gcc-8.5.0
powerpc64             randconfig-001-20250714    clang-16
powerpc64             randconfig-002-20250714    gcc-8.5.0
powerpc64             randconfig-003-20250714    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250714    gcc-8.5.0
riscv                 randconfig-002-20250714    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250714    clang-21
s390                  randconfig-002-20250714    clang-18
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250714    gcc-12.4.0
sh                    randconfig-002-20250714    gcc-11.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250714    gcc-8.5.0
sparc                 randconfig-002-20250714    gcc-8.5.0
sparc64               randconfig-001-20250714    clang-21
sparc64               randconfig-002-20250714    clang-21
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250714    gcc-12
um                    randconfig-002-20250714    gcc-11
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250714    gcc-12
x86_64      buildonly-randconfig-002-20250714    clang-20
x86_64      buildonly-randconfig-003-20250714    gcc-12
x86_64      buildonly-randconfig-004-20250714    gcc-12
x86_64      buildonly-randconfig-005-20250714    clang-20
x86_64      buildonly-randconfig-006-20250714    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250714    gcc-8.5.0
xtensa                randconfig-002-20250714    gcc-12.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


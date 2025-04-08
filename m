Return-Path: <linux-kernel+bounces-593323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9CFA7F7F2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 10:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F7E4178EFD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 08:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BC1262802;
	Tue,  8 Apr 2025 08:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UoUngBXS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6BF2627EA
	for <linux-kernel@vger.kernel.org>; Tue,  8 Apr 2025 08:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744101183; cv=none; b=Unpdv6XWQdgnHGwxix94y8Ok7Mfy6EpH5RrUqOIreDvQOjR4Ui/OYaiwHWlyNkQhda1XnDXY/sSulRAClTQ90NcKYX6sjYewc/eUzVz5OjKI/MNdLaZvGd3D2E/eMlsl0i4iDsLIGv4uxmcoe48BDzTy/FpyfN4KmaMx3nF/c3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744101183; c=relaxed/simple;
	bh=VdJV37VT7UerhL+EBtKVFwL9QcdWX6bD7ahUYHEz5V0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KPswLXx5vi2Tcn4j4rStovaYDok+jfB2eDKejIkkTyVRHWo0/LlFZ/rzvNacmwAD+lafrcRyW709MgbUAIA8X20l4EI4jw6P1xkS9s7/kcDRK0XplBBkP3d+4yF3jQegWPgHhMmwYoqrU1r96pOrl0uxEgkRWeuI6xQVCWQUoxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UoUngBXS; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744101179; x=1775637179;
  h=date:from:to:cc:subject:message-id;
  bh=VdJV37VT7UerhL+EBtKVFwL9QcdWX6bD7ahUYHEz5V0=;
  b=UoUngBXS+wnb5a1VFj3hw3HvZmNtiEcGtJEwHWCiG/80Ts/3VnobY324
   YZ3XzaOAiFtyDAesP3BGk4oM+s10ISwUKwUivmQSo8kvcNDIpAWIukQwQ
   a10u88MqjNEjMX0K6tzLCcilQqXyQhgSf/3njgNneR/OTdaemqGC14YLj
   zvVvAPrKfF+xPs8UaNIjL7a7XHnntDT2AeCK/JYAct9v9zCB81/ytUak8
   Rs97LKopS/2QoNYDTfwzEF+awbfOwFCPL2svK3Lrbm9lCWF9D4larUYwS
   dWVY8bnE2kqCShuk4ATkjZcfandWXjy71nXgPV/NHY6HARe1ExfSQzXFA
   A==;
X-CSE-ConnectionGUID: ilFiXT67TX6leUAIZHw97w==
X-CSE-MsgGUID: iF8ethxhT7eorj5Hm/ay0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="67993878"
X-IronPort-AV: E=Sophos;i="6.15,197,1739865600"; 
   d="scan'208";a="67993878"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 01:32:59 -0700
X-CSE-ConnectionGUID: MN7Jmv3nS0mqYoLRwTaNtw==
X-CSE-MsgGUID: y9vhJIn2QmSTBQL1nsobXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,197,1739865600"; 
   d="scan'208";a="128532691"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 08 Apr 2025 01:32:57 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u24O7-0004Jq-1A;
	Tue, 08 Apr 2025 08:32:55 +0000
Date: Tue, 08 Apr 2025 16:32:31 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:irq/drivers] BUILD SUCCESS
 7ae844a6650c5c15ccfbf76ed767e7f2cc61ec1d
Message-ID: <202504081621.qDnheV1D-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/drivers
branch HEAD: 7ae844a6650c5c15ccfbf76ed767e7f2cc61ec1d  genirq/generic-chip: Remove unused lock wrappers

elapsed time: 1456m

configs tested: 125
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250407    gcc-12.4.0
arc                   randconfig-002-20250407    gcc-14.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                           h3600_defconfig    gcc-14.2.0
arm                   randconfig-001-20250407    gcc-8.5.0
arm                   randconfig-002-20250407    clang-21
arm                   randconfig-003-20250407    gcc-8.5.0
arm                   randconfig-004-20250407    gcc-8.5.0
arm                         s3c6400_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250407    clang-21
arm64                 randconfig-002-20250407    gcc-6.5.0
arm64                 randconfig-003-20250407    gcc-8.5.0
arm64                 randconfig-004-20250407    clang-15
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250407    gcc-14.2.0
csky                  randconfig-002-20250407    gcc-14.2.0
hexagon                          alldefconfig    clang-21
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250407    clang-21
hexagon               randconfig-002-20250407    clang-15
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250407    gcc-12
i386        buildonly-randconfig-002-20250407    gcc-12
i386        buildonly-randconfig-003-20250407    gcc-12
i386        buildonly-randconfig-004-20250407    clang-20
i386        buildonly-randconfig-005-20250407    gcc-12
i386        buildonly-randconfig-006-20250407    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250407    gcc-14.2.0
loongarch             randconfig-002-20250407    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       m5249evb_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        vocore2_defconfig    clang-15
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250407    gcc-6.5.0
nios2                 randconfig-002-20250407    gcc-8.5.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250407    gcc-7.5.0
parisc                randconfig-002-20250407    gcc-7.5.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                  mpc885_ads_defconfig    clang-21
powerpc               randconfig-001-20250407    clang-21
powerpc               randconfig-002-20250407    clang-21
powerpc               randconfig-003-20250407    gcc-6.5.0
powerpc                     tqm8540_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250407    clang-21
powerpc64             randconfig-002-20250407    clang-17
powerpc64             randconfig-003-20250407    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250407    gcc-8.5.0
riscv                 randconfig-002-20250407    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250407    gcc-9.3.0
s390                  randconfig-002-20250407    clang-15
s390                       zfcpdump_defconfig    clang-15
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                    randconfig-001-20250407    gcc-12.4.0
sh                    randconfig-002-20250407    gcc-10.5.0
sh                   rts7751r2dplus_defconfig    gcc-14.2.0
sh                           se7721_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250407    gcc-13.3.0
sparc                 randconfig-002-20250407    gcc-10.3.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250407    gcc-7.5.0
sparc64               randconfig-002-20250407    gcc-9.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250407    clang-18
um                    randconfig-002-20250407    clang-21
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250407    gcc-11
x86_64      buildonly-randconfig-002-20250407    clang-20
x86_64      buildonly-randconfig-003-20250407    clang-20
x86_64      buildonly-randconfig-004-20250407    clang-20
x86_64      buildonly-randconfig-005-20250407    clang-20
x86_64      buildonly-randconfig-006-20250407    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250407    gcc-9.3.0
xtensa                randconfig-002-20250407    gcc-7.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


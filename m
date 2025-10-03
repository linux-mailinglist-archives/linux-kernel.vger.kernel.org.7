Return-Path: <linux-kernel+bounces-841749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AB0BB81ED
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 22:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51B5419E4CC2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 20:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB6F23D7EA;
	Fri,  3 Oct 2025 20:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M4E8J43I"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CEB23ABA8
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 20:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759524001; cv=none; b=HmODU8kIzkhlrzqcmAgGZTImNQMWtA91oFmSkl8I6Q5ZC50OR5r7BeATSH6Up5sSFt36aOcc3+kK6eIt6JIjm6F/GRmTXKGeHFenjlX3PRqSG7CJZhIE/qEz99vqNVuBad8nKc8dfd7JUQkEdBVJbGbHuCEN6ec56p/gquzQHHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759524001; c=relaxed/simple;
	bh=Om/sl4rdQlzwxd9tFJ7Fh9H3j4dmhnGNe7u4sLFktJ8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=eeSp/AolVJ6CXY4HxhuMiYRRt6l4eoFoCjy/kIfKU5Aj7K2cMOWbLbSMx/bKOLSmFm7i4wj1daBfZrDdmNpiRg7xY1TbAhArwqLdZuOKM3/B90WoMLYZuIiuc1Zv83QUBbuCQrRNDgHDFg60Vd1Uxp88J/NsyzvlptXxdnhAaVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M4E8J43I; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759523999; x=1791059999;
  h=date:from:to:cc:subject:message-id;
  bh=Om/sl4rdQlzwxd9tFJ7Fh9H3j4dmhnGNe7u4sLFktJ8=;
  b=M4E8J43IGYjvKK3+nMNWdq4PyTPjtbb6ybNSR6msPj4WM+WKbVd4rqVJ
   T1bJl9d5RKZSJyh6+XfTArEu2NCE1R68jV85CL1TeNWrKKWpX8YAo2gPH
   0zOIfmLXoLnNy4d22bI+i+RTFQQvwAYRgNbigkJjn5CTqWHZeAoL25qs6
   OU4k69rib3OpcikeZc9fFYmGYfy6ShVT7hF0bhRuMcedNKOTsVNFrcc49
   kcjJeo1GtZg/Op2BnthPK8Q4L9Qsuna0zodrOx4JqXWga2yVhL/zqXy7X
   sGAMQckxbomSNHaz98lujpfmyUlWl2LSH7i+TnV6DwvA3ePId2WeR1UD5
   A==;
X-CSE-ConnectionGUID: F+trIs0TQrq33wbVhepopg==
X-CSE-MsgGUID: 1icMQdDjQVePD3KDu8F5zQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11571"; a="61909892"
X-IronPort-AV: E=Sophos;i="6.18,313,1751266800"; 
   d="scan'208";a="61909892"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 13:39:59 -0700
X-CSE-ConnectionGUID: ptNx6p46SBOk24w0hOgAAQ==
X-CSE-MsgGUID: 7BSURCD8RbS4KQpjN6Be/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,313,1751266800"; 
   d="scan'208";a="179168518"
Received: from lkp-server01.sh.intel.com (HELO 2f2a1232a4e4) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 03 Oct 2025 13:39:58 -0700
Received: from kbuild by 2f2a1232a4e4 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v4mZH-0004sZ-0y;
	Fri, 03 Oct 2025 20:39:55 +0000
Date: Sat, 04 Oct 2025 04:39:13 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20251002] BUILD SUCCESS
 6f57573beb8b7f3d4626e4cc2d726e035ee54608
Message-ID: <202510040404.CoURR0Cg-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20251002
branch HEAD: 6f57573beb8b7f3d4626e4cc2d726e035ee54608  net: spacemit: Avoid -Wflex-array-member-not-at-end warnings

elapsed time: 1449m

configs tested: 112
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                            hsdk_defconfig    gcc-15.1.0
arc                   randconfig-001-20251003    gcc-11.5.0
arc                   randconfig-002-20251003    gcc-13.4.0
arm                               allnoconfig    clang-22
arm                   randconfig-001-20251003    gcc-12.5.0
arm                   randconfig-002-20251003    clang-22
arm                   randconfig-003-20251003    gcc-13.4.0
arm                   randconfig-004-20251003    gcc-13.4.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251003    gcc-13.4.0
arm64                 randconfig-002-20251003    clang-22
arm64                 randconfig-003-20251003    gcc-10.5.0
arm64                 randconfig-004-20251003    gcc-13.4.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251003    gcc-15.1.0
csky                  randconfig-002-20251003    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20251003    clang-22
hexagon               randconfig-002-20251003    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251003    gcc-14
i386        buildonly-randconfig-002-20251003    gcc-12
i386        buildonly-randconfig-003-20251003    clang-20
i386        buildonly-randconfig-004-20251003    gcc-12
i386        buildonly-randconfig-005-20251003    clang-20
i386        buildonly-randconfig-006-20251003    gcc-14
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20251003    gcc-15.1.0
loongarch             randconfig-002-20251003    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                            gpr_defconfig    clang-18
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251003    gcc-8.5.0
nios2                 randconfig-002-20251003    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251003    gcc-9.5.0
parisc                randconfig-002-20251003    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                      katmai_defconfig    clang-22
powerpc               randconfig-001-20251003    clang-22
powerpc               randconfig-002-20251003    gcc-8.5.0
powerpc               randconfig-003-20251003    clang-22
powerpc                      tqm8xx_defconfig    clang-19
powerpc64                        alldefconfig    clang-22
powerpc64             randconfig-001-20251003    gcc-12.5.0
powerpc64             randconfig-002-20251003    gcc-10.5.0
powerpc64             randconfig-003-20251003    clang-18
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20251003    gcc-11.5.0
riscv                 randconfig-002-20251003    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20251003    clang-22
s390                  randconfig-002-20251003    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251003    gcc-10.5.0
sh                    randconfig-002-20251003    gcc-14.3.0
sh                          rsk7201_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251003    gcc-14.3.0
sparc                 randconfig-002-20251003    gcc-13.4.0
sparc64               randconfig-001-20251003    clang-20
sparc64               randconfig-002-20251003    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                    randconfig-001-20251003    clang-22
um                    randconfig-002-20251003    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251003    clang-20
x86_64      buildonly-randconfig-002-20251003    gcc-14
x86_64      buildonly-randconfig-003-20251003    gcc-14
x86_64      buildonly-randconfig-004-20251003    gcc-14
x86_64      buildonly-randconfig-005-20251003    clang-20
x86_64      buildonly-randconfig-006-20251003    gcc-14
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251003    gcc-13.4.0
xtensa                randconfig-002-20251003    gcc-11.5.0
xtensa                         virt_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


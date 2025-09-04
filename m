Return-Path: <linux-kernel+bounces-800503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B43B43878
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C1507B8E07
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE3B2FCC1F;
	Thu,  4 Sep 2025 10:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vg4OYCoJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA812FCBF9
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 10:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756981040; cv=none; b=loeqh5iaE1TM3EkrdlMNPuxfyatm0XJ/6iZVDJVWQiOaTDSCRYG9Hvp6MlK51ftJHpr3WwE9JfIKcBA2Pr8OJTnF5EEcT1+zLh0sjM6ioflwhJCbrwPmyWfg1VFpx0Rmug0VybyW0vYBb+CQkL/vO60wed3+AlakYqGQcjMAPMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756981040; c=relaxed/simple;
	bh=R7ilR455p5GXh4gYKbCapdInbBs0lWi/Vwwb7P58WFc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=IcyXjBtBEaRFxz6qAYxFSiXpvrCY2RazQ6KZu2qHY72eCgHvonKJWit0XB6TgZSmjdf+mW6DDqHNp49o04ug2YjtLUX+IY/6d/WQMAFslRvG/XeTYAf3MEAQJA7tOp+yUGsr4DbEoQYSlW5nAFyCRIUpmq6crEQHYL8PvD2NqKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vg4OYCoJ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756981039; x=1788517039;
  h=date:from:to:cc:subject:message-id;
  bh=R7ilR455p5GXh4gYKbCapdInbBs0lWi/Vwwb7P58WFc=;
  b=Vg4OYCoJxTlzL3YKOED276ew6Z2Jr/rpxvuSYG2lrt2yhuxLAG3YRnQG
   Z0znLqmu5pznjF+pX384KpATGNA0FGcnx1/6ROjVDl4krZAlK8gC+qAmI
   2HZQHAEUjO8WRwS6+35pTBu58/zveXf0YXgrCr96olIdt/pdwUVSMovYX
   bV1sonUg1e+puDoYu7wapPKKhfI+F0t92fX3jcy+bW8GMAutvSBmnXLtI
   AvXhHWodnZQUgJS2jUilBTV3Un7BpbuRRfhQoC6CKXcc8cWzBTJXZCB61
   Rf06gzEupOBlRCIklp0VNkjc+e0iSNRXL/GZ5aUJue4JKvNnipuY0vAx4
   g==;
X-CSE-ConnectionGUID: xVQIsJvVSNCqcdaWvxl/hA==
X-CSE-MsgGUID: /TcoEsL1QUO3n1TewAz0bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="70409009"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="70409009"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 03:17:18 -0700
X-CSE-ConnectionGUID: wHTBx/MHTyupGFs8AIFkYg==
X-CSE-MsgGUID: P3tVbeZFRtW0Cl5Ox774zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="209036711"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 04 Sep 2025 03:17:17 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uu71m-00055j-2f;
	Thu, 04 Sep 2025 10:17:14 +0000
Date: Thu, 04 Sep 2025 18:05:06 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 18dbcbfabfffc4a5d3ea10290c5ad27f22b0d240
Message-ID: <202509041800.OoCUozFJ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/urgent
branch HEAD: 18dbcbfabfffc4a5d3ea10290c5ad27f22b0d240  perf: Fix the POLL_HUP delivery breakage

elapsed time: 1520m

configs tested: 98
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250903    gcc-15.1.0
arc                   randconfig-002-20250903    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                   randconfig-001-20250903    clang-22
arm                   randconfig-002-20250903    clang-16
arm                   randconfig-003-20250903    clang-22
arm                   randconfig-004-20250903    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250903    gcc-8.5.0
arm64                 randconfig-002-20250903    gcc-11.5.0
arm64                 randconfig-003-20250903    clang-22
arm64                 randconfig-004-20250903    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250903    gcc-9.5.0
csky                  randconfig-002-20250903    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250903    clang-22
hexagon               randconfig-002-20250903    clang-18
i386                             allmodconfig    gcc-13
i386                              allnoconfig    gcc-13
i386                             allyesconfig    gcc-13
i386        buildonly-randconfig-001-20250903    gcc-13
i386        buildonly-randconfig-002-20250903    gcc-13
i386        buildonly-randconfig-003-20250903    clang-20
i386        buildonly-randconfig-004-20250903    clang-20
i386        buildonly-randconfig-005-20250903    clang-20
i386        buildonly-randconfig-006-20250903    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250903    gcc-15.1.0
loongarch             randconfig-002-20250903    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                 randconfig-001-20250903    gcc-10.5.0
nios2                 randconfig-002-20250903    gcc-10.5.0
openrisc                          allnoconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                randconfig-001-20250903    gcc-13.4.0
parisc                randconfig-002-20250903    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20250903    gcc-8.5.0
powerpc               randconfig-002-20250903    gcc-8.5.0
powerpc               randconfig-003-20250903    gcc-14.3.0
powerpc64             randconfig-001-20250903    clang-22
powerpc64             randconfig-002-20250903    clang-22
powerpc64             randconfig-003-20250903    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250903    gcc-8.5.0
riscv                 randconfig-002-20250903    gcc-9.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250903    gcc-8.5.0
s390                  randconfig-002-20250903    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250903    gcc-12.5.0
sh                    randconfig-002-20250903    gcc-10.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250903    gcc-11.5.0
sparc                 randconfig-002-20250903    gcc-15.1.0
sparc64               randconfig-001-20250903    gcc-8.5.0
sparc64               randconfig-002-20250903    gcc-11.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-13
um                    randconfig-001-20250903    gcc-13
um                    randconfig-002-20250903    clang-18
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250903    clang-20
x86_64      buildonly-randconfig-002-20250903    clang-20
x86_64      buildonly-randconfig-003-20250903    clang-20
x86_64      buildonly-randconfig-004-20250903    gcc-13
x86_64      buildonly-randconfig-005-20250903    clang-20
x86_64      buildonly-randconfig-006-20250903    gcc-13
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250903    gcc-11.5.0
xtensa                randconfig-002-20250903    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


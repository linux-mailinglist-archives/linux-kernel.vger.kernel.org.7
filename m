Return-Path: <linux-kernel+bounces-760702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3E5B1EF0E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 21:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57F0B7ABA43
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 19:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F84728853A;
	Fri,  8 Aug 2025 19:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JHcA/DS+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E20265CDD
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 19:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754682759; cv=none; b=t6t/fvXX+d7aFpNI1M1jjzqyxpT2eEbh5CFdQekUeqDb+j1c28uqlMOBx/qKgOo/LEfQesETCZoPg0DPG5WrLnygwHn/z3l7JKPO7Jh5co1KudU0GAkdUhLaR6GbxKS+II9rNrZUdabBpi/AbN4BPfEVSHOPJKXPWD+RnqqvKV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754682759; c=relaxed/simple;
	bh=eNpQ9XQotM4/bY+m4M/nkrtwGxqeVYSc4Tt+2xEZSIA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Qe3ONxWooUA0QHT1Yotic1x3DxQqfsldZpLLYznBl/dbT/EVp4gRlDC4RwNd/pcsf9YppugiqWu/k2U7KW5405iJD63B5OJvw5t4KCNpFN12ymsC599PPH4K1AL4fLKACm3zk/amf/FP4kNaBvx91dMgD/AjW0xgcmiCGU0qUNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JHcA/DS+; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754682758; x=1786218758;
  h=date:from:to:cc:subject:message-id;
  bh=eNpQ9XQotM4/bY+m4M/nkrtwGxqeVYSc4Tt+2xEZSIA=;
  b=JHcA/DS+AMP0ogASBxTe1JA7KFjHeB8DVnyQbOr+ukPgOxfGJUzDFiCj
   l2YXG8zpkOwdVboZH/UeV7YHLacpvub6+Sn9Anox3e/skdts7IQgff6mm
   gWgOomu1t/tLA6S3ERIwF0p6ReeOAz/zUknpiRVBSwNobWpgkc7leMAeh
   Z2DX4IZc9LhHGe6M738nla05agUR/CHFXwJen2rqt/i7TXjnrqhYPkqYg
   Cq1dip+QV2vb+IwcfayN35os6cCR4eQNM3Wp465JVylCokEQcQrvcX7DE
   75Dj9xJyoZxCyE8uIeZ2K0Fv+Y8n9k1uiTME/fHUuothSwWPYnTmWjCKo
   Q==;
X-CSE-ConnectionGUID: tIxZJZR9SvSlGDbzNH18Jw==
X-CSE-MsgGUID: 5YJNw2eSQ+2ohWiBCF9y9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="74618743"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="74618743"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 12:52:36 -0700
X-CSE-ConnectionGUID: Db679jqgSAup93evjHP+7Q==
X-CSE-MsgGUID: bEPR6lx3Sdqn+Rffqk+gTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="169858315"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 08 Aug 2025 12:52:36 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ukT8j-0004Fh-0T;
	Fri, 08 Aug 2025 19:52:33 +0000
Date: Sat, 09 Aug 2025 03:52:01 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 b2fc521b40b9e94f6fe2cc9820b14ae67d8fe891
Message-ID: <202508090355.6JpNEV8L-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: b2fc521b40b9e94f6fe2cc9820b14ae67d8fe891  Merge branch into tip/master: 'timers/clocksource'

elapsed time: 877m

configs tested: 125
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250808    gcc-14.3.0
arc                   randconfig-002-20250808    gcc-12.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                          pxa910_defconfig    gcc-15.1.0
arm                   randconfig-001-20250808    gcc-14.3.0
arm                   randconfig-002-20250808    gcc-10.5.0
arm                   randconfig-003-20250808    clang-22
arm                   randconfig-004-20250808    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250808    clang-20
arm64                 randconfig-002-20250808    gcc-10.5.0
arm64                 randconfig-003-20250808    clang-22
arm64                 randconfig-004-20250808    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250808    gcc-15.1.0
csky                  randconfig-002-20250808    gcc-12.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250808    clang-20
hexagon               randconfig-002-20250808    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250808    clang-20
i386        buildonly-randconfig-002-20250808    clang-20
i386        buildonly-randconfig-003-20250808    gcc-12
i386        buildonly-randconfig-004-20250808    clang-20
i386        buildonly-randconfig-005-20250808    gcc-12
i386        buildonly-randconfig-006-20250808    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250808    clang-22
loongarch             randconfig-002-20250808    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                           virt_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250808    gcc-9.5.0
nios2                 randconfig-002-20250808    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250808    gcc-8.5.0
parisc                randconfig-002-20250808    gcc-13.4.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                   lite5200b_defconfig    clang-22
powerpc               randconfig-001-20250808    clang-22
powerpc               randconfig-002-20250808    clang-18
powerpc               randconfig-003-20250808    clang-22
powerpc64             randconfig-001-20250808    clang-18
powerpc64             randconfig-002-20250808    clang-22
powerpc64             randconfig-003-20250808    clang-16
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250808    clang-22
riscv                 randconfig-002-20250808    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250808    gcc-10.5.0
s390                  randconfig-002-20250808    gcc-10.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250808    gcc-13.4.0
sh                    randconfig-002-20250808    gcc-10.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250808    gcc-12.5.0
sparc                 randconfig-002-20250808    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250808    clang-22
sparc64               randconfig-002-20250808    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250808    gcc-12
um                    randconfig-002-20250808    gcc-12
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250808    clang-20
x86_64      buildonly-randconfig-002-20250808    gcc-12
x86_64      buildonly-randconfig-003-20250808    clang-20
x86_64      buildonly-randconfig-004-20250808    clang-20
x86_64      buildonly-randconfig-005-20250808    gcc-12
x86_64      buildonly-randconfig-006-20250808    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250808    gcc-9.5.0
xtensa                randconfig-002-20250808    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


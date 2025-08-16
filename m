Return-Path: <linux-kernel+bounces-771572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B3DB28903
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 02:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A71A33A93E0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 00:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAA717E0;
	Sat, 16 Aug 2025 00:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dcdUkQYi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CD4189
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 00:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755302740; cv=none; b=LYO8y3qaerZ+YaC24jdaHw/KvBtWgawt2vLY+SI4f+Gkg1Og8ib0P1fD0a0GFKe6iyx8s/WfHbipnYZG2YqPlimJuYfc9EJ/jLBWpV1FbvZtQwEPom1Ka4trBzxzVzph5qbc1BIe/ljsafxBXdJL8o4s9lFF9yKRaAeZTxWfxNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755302740; c=relaxed/simple;
	bh=fp3ba3yh1PjKXwhGIQu9YreT6Qt7pwV5DNFMwkhYq+Q=;
	h=Date:From:To:Cc:Subject:Message-ID; b=om3n2ea3pGD/VrMC8AcCVT6EA0M9lDj3VAABBdAAe+HNg/5USJqfLi6Yja2+1MERB+SvfhL41ptMPN/OjKwOniEI18YjNJj9CM8ssuXHKHhQLIUAsnkJ7YG7h3xQqO2oQOzzWPSCeZZAAm+DHVpgfflsWsLQgGngMEUB8dFmDMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dcdUkQYi; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755302739; x=1786838739;
  h=date:from:to:cc:subject:message-id;
  bh=fp3ba3yh1PjKXwhGIQu9YreT6Qt7pwV5DNFMwkhYq+Q=;
  b=dcdUkQYi7pE4jSqOD+qAs4MpZ5y7WHm/A7nbO3nqyI5oawaqK6aUhedH
   QjKMjAex3vEAKC6dAFbwO9paa/CI9HWx2Fiy4W5gpb6OyZ5REODhNsUgn
   1EGdcWd2NQ8cL8pXx63toBsFfV/3+NptBZUXkP6M2AD+57gRBTOHA8067
   KvOCgLy9U7sqp+VzXS4pStRncYHXGvmKieDZlKx9YVN6Ejq4LeHdA0O4B
   KTfbVpfgFSsDbTae0+P4ulBaYXa3dXpuh9Kep9Ebb4AM81VSQwNhm15xf
   ZVlZfy9K+rnYN7HrfMqnhqOlr33UQ8UJ5HsgXtTlnbQo+Qm1J4EXeETPz
   A==;
X-CSE-ConnectionGUID: zwTEAn7qTAKP3hQH15zz4g==
X-CSE-MsgGUID: 6EMVqLu/StyPbNJ5VpSlEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="57551844"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="57551844"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 17:05:38 -0700
X-CSE-ConnectionGUID: rTbHQt0cTmu2w17q0nLINA==
X-CSE-MsgGUID: 7V9AJR3mSJiyfS8C8aqdOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="166614623"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 15 Aug 2025 17:05:37 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1un4QR-000CRW-1P;
	Sat, 16 Aug 2025 00:05:35 +0000
Date: Sat, 16 Aug 2025 08:04:48 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev] BUILD SUCCESS
 dca002f8b3cf0f60bf9255c775600e98e56080a6
Message-ID: <202508160842.OxkcUaSW-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
branch HEAD: dca002f8b3cf0f60bf9255c775600e98e56080a6  EXP arm64: enable PREEMPT_LAZY

elapsed time: 1449m

configs tested: 76
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20250815    gcc-8.5.0
arc                   randconfig-002-20250815    gcc-9.5.0
arm                               allnoconfig    clang-22
arm                   randconfig-001-20250815    clang-16
arm                   randconfig-002-20250815    clang-18
arm                   randconfig-003-20250815    gcc-14.3.0
arm                   randconfig-004-20250815    gcc-8.5.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250815    gcc-8.5.0
arm64                 randconfig-002-20250815    gcc-8.5.0
arm64                 randconfig-003-20250815    clang-22
arm64                 randconfig-004-20250815    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250815    gcc-15.1.0
csky                  randconfig-002-20250815    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20250815    clang-22
hexagon               randconfig-002-20250815    clang-22
i386        buildonly-randconfig-001-20250815    gcc-12
i386        buildonly-randconfig-002-20250815    clang-20
i386        buildonly-randconfig-003-20250815    clang-20
i386        buildonly-randconfig-004-20250815    clang-20
i386        buildonly-randconfig-005-20250815    clang-20
i386        buildonly-randconfig-006-20250815    gcc-12
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250815    clang-22
loongarch             randconfig-002-20250815    clang-20
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                 randconfig-001-20250815    gcc-11.5.0
nios2                 randconfig-002-20250815    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                randconfig-001-20250815    gcc-8.5.0
parisc                randconfig-002-20250815    gcc-14.3.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20250815    gcc-11.5.0
powerpc               randconfig-002-20250815    clang-19
powerpc               randconfig-003-20250815    gcc-11.5.0
powerpc64             randconfig-001-20250815    gcc-14.3.0
powerpc64             randconfig-002-20250815    gcc-10.5.0
powerpc64             randconfig-003-20250815    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250815    gcc-12.5.0
riscv                 randconfig-002-20250815    gcc-8.5.0
s390                              allnoconfig    clang-22
s390                  randconfig-001-20250815    gcc-8.5.0
s390                  randconfig-002-20250815    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250815    gcc-11.5.0
sh                    randconfig-002-20250815    gcc-12.5.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250815    gcc-11.5.0
sparc                 randconfig-002-20250815    gcc-13.4.0
sparc64               randconfig-001-20250815    clang-22
sparc64               randconfig-002-20250815    gcc-15.1.0
um                                allnoconfig    clang-22
um                    randconfig-001-20250815    gcc-12
um                    randconfig-002-20250815    clang-19
x86_64      buildonly-randconfig-001-20250815    clang-20
x86_64      buildonly-randconfig-002-20250815    gcc-12
x86_64      buildonly-randconfig-003-20250815    gcc-12
x86_64      buildonly-randconfig-004-20250815    clang-20
x86_64      buildonly-randconfig-005-20250815    clang-20
x86_64      buildonly-randconfig-006-20250815    gcc-12
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250815    gcc-8.5.0
xtensa                randconfig-002-20250815    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


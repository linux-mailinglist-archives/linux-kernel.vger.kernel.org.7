Return-Path: <linux-kernel+bounces-783316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 904E9B32B9A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 21:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54DAD5A7579
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 19:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E407225762;
	Sat, 23 Aug 2025 19:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HDXQHMQw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ACB1F181F
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 19:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755976530; cv=none; b=Yy9/+VWmD5GnEXPpxd2zvME5d7L05UOgtdcpS3vQvhWsdjw8f334TZRjj0eqq2QD36QvCNr3VufNy4NjE+sNocnLsgnw+Ay57nkdz5y+S3xp7kw7xrz622Qz6rgZpE0Y6oB43m2znT9VRJhwttwKHSotHEyyn9rxFyK1PszoEwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755976530; c=relaxed/simple;
	bh=ncaI6Szutqx7kBj3QIh2R6YsJWXX1lySF1MWEgYl5xY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MGy1gn8LSTxqY4z3i/wUA+5GoaLW5965td3cakJxP7p4ISVIp1sQzpYyqm6ZcxJ6SN5HwUZ1ufYChkMj/JWE27cPg883bCNK/E6J/HSrABwm8/GcPcgynwUeN9m+DTm+qyYBMzNcHfLDiS9olQ95+AgQCIhetLu/CKtjV873CKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HDXQHMQw; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755976528; x=1787512528;
  h=date:from:to:cc:subject:message-id;
  bh=ncaI6Szutqx7kBj3QIh2R6YsJWXX1lySF1MWEgYl5xY=;
  b=HDXQHMQwoFTBxl5O1Tr18/lMaI8zcjzf8L9o+esXWvg7HraHat2FiFJj
   oWyOxy1ub6v4OHE9fyI+Ne0BUlkimSQmJYU4uX52Jzi8e5J7nLAMoIvo8
   lTfw6UD2rrpjZUGb1B/0ZtGzGe401DEI6c5+11TtdHWmaHlZztWvd8551
   JwVlBsPjGUgyuMuNyn3xnS7YHXDAL03lzkZsor7P3QinU+zeeXtcPpwz7
   89ZBcgByIEBKW2+EcuE/vPWutQleIxrbE6IEyG5wn9FVxy5P1o0fDkF2f
   mh/M+/YP/h2e/zeoy3bKCT2fDHfGHjy5QfkYJ8dv6xU52JPBqCfyvTOBu
   g==;
X-CSE-ConnectionGUID: bzIt9QxLTBiyb4kC/vj8bw==
X-CSE-MsgGUID: En8thlFdQeO89LkXTVh9iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="75702013"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="75702013"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2025 12:15:28 -0700
X-CSE-ConnectionGUID: p04oI7yBR7i8JjoC284qRA==
X-CSE-MsgGUID: 4UZfFRnlQHuhO1HNQQlrug==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 23 Aug 2025 12:15:26 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upti0-000MWj-2V;
	Sat, 23 Aug 2025 19:15:24 +0000
Date: Sun, 24 Aug 2025 03:14:30 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev] BUILD SUCCESS
 4ad27d197503cbfd18e24a4c8fa8c3c933f200f0
Message-ID: <202508240324.NKMFeHzH-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
branch HEAD: 4ad27d197503cbfd18e24a4c8fa8c3c933f200f0  checkpatch: Deprecate rcu_read_{,un}lock_trace()

elapsed time: 1442m

configs tested: 72
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20250823    gcc-9.5.0
arc                   randconfig-002-20250823    gcc-12.5.0
arm                               allnoconfig    clang-22
arm                   randconfig-001-20250823    clang-17
arm                   randconfig-002-20250823    gcc-15.1.0
arm                   randconfig-003-20250823    clang-20
arm                   randconfig-004-20250823    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250823    gcc-11.5.0
arm64                 randconfig-002-20250823    clang-22
arm64                 randconfig-003-20250823    clang-22
arm64                 randconfig-004-20250823    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250823    gcc-15.1.0
csky                  randconfig-002-20250823    gcc-14.3.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20250823    clang-22
hexagon               randconfig-002-20250823    clang-22
i386        buildonly-randconfig-001-20250823    clang-20
i386        buildonly-randconfig-002-20250823    clang-20
i386        buildonly-randconfig-003-20250823    clang-20
i386        buildonly-randconfig-004-20250823    clang-20
i386        buildonly-randconfig-005-20250823    clang-20
i386        buildonly-randconfig-006-20250823    clang-20
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250823    clang-22
loongarch             randconfig-002-20250823    clang-22
m68k                              allnoconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                 randconfig-001-20250823    gcc-11.5.0
nios2                 randconfig-002-20250823    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                randconfig-001-20250823    gcc-8.5.0
parisc                randconfig-002-20250823    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20250823    clang-22
powerpc               randconfig-002-20250823    clang-22
powerpc               randconfig-003-20250823    clang-22
powerpc64             randconfig-001-20250823    gcc-11.5.0
powerpc64             randconfig-002-20250823    clang-22
powerpc64             randconfig-003-20250823    gcc-10.5.0
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250823    clang-22
riscv                 randconfig-002-20250823    gcc-8.5.0
s390                              allnoconfig    clang-22
s390                  randconfig-001-20250823    gcc-9.5.0
s390                  randconfig-002-20250823    clang-22
sh                                allnoconfig    gcc-15.1.0
sh                    randconfig-001-20250823    gcc-15.1.0
sh                    randconfig-002-20250823    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250823    gcc-8.5.0
sparc                 randconfig-002-20250823    gcc-8.5.0
sparc64               randconfig-001-20250823    gcc-8.5.0
sparc64               randconfig-002-20250823    clang-22
um                                allnoconfig    clang-22
um                    randconfig-001-20250823    clang-22
um                    randconfig-002-20250823    clang-22
x86_64      buildonly-randconfig-001-20250823    gcc-12
x86_64      buildonly-randconfig-002-20250823    gcc-12
x86_64      buildonly-randconfig-003-20250823    clang-20
x86_64      buildonly-randconfig-004-20250823    clang-20
x86_64      buildonly-randconfig-005-20250823    gcc-12
x86_64      buildonly-randconfig-006-20250823    gcc-12
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250823    gcc-15.1.0
xtensa                randconfig-002-20250823    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


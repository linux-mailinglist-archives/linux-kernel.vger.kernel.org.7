Return-Path: <linux-kernel+bounces-763531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E993DB2161D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 22:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB3AE7A506C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 20:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC662D877B;
	Mon, 11 Aug 2025 20:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QIjdSw7Z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEE5278E53
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 20:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754942535; cv=none; b=gsHEeU6pBLlWi7mGSJvd9ljXGrvSeO8PqPtjkTbLTlIY/k8RqkEV4G9hyXajOA/3RV6J+F5CWR3rD2f4M4tr0sb7fOJKPGIjY+RM6N0fV4VWcr6ELJNP5BysjxT/3P5ybME2UfGv6sHEUNozaaE6J3ILJ5yjF+GpiOzBGFJftF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754942535; c=relaxed/simple;
	bh=SvMSFpoQwgeNM5fuejXLPhaE4l9aNvNk09kMM0mcAtM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tw9xcncCKkQGJIUktTtbkHg7qqXmjrNGYdNhWXh8Rq7/6rEKNJcpBJKpffUYuK4gMBytu5Mu76GoUuQqSFerB+qcxffQ9N1Cy75CSZZBdVEVDmb9pP4hYceprBc+p7lAPeM8PvQEqUrNp0wDgTGvdzKqtKBzPxWLnQ6QQlEH2NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QIjdSw7Z; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754942534; x=1786478534;
  h=date:from:to:cc:subject:message-id;
  bh=SvMSFpoQwgeNM5fuejXLPhaE4l9aNvNk09kMM0mcAtM=;
  b=QIjdSw7Zw7kZ4ZiNDosuDe6WjR9azDiHx5Z5/py+ETkNgCR3V5Fu6ww3
   1YMXxqTiWRkDOTSxaIXgG76OFWWkxNYQzmK4YMSP/DEZD03BQCcEfmsA6
   RRSxoQtrWlAagp7UlE/vtLLLfrA5bpb5i0K3qYc2SMpFjHo8UeIsohG+O
   1djWSXAhakARah3D13nXEFnWm4gqBihMe/WSjdKuIRGO0M/xdXwP5UYsi
   ONfPugfWgd844Syj1S3XBS+MQS8zOimGbHFCH+ehgWqM4hw6L+ENbbEbZ
   TzSev7l+JNIBW/1hy6F6CpJsZ7hyL87K/8CYQfw1f3gZCs7ij40vFfMlC
   A==;
X-CSE-ConnectionGUID: D4HtzAuJTWSOBLGITWH2fQ==
X-CSE-MsgGUID: n5Lj/w35R8ux7DnGHwXBlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57351064"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="57351064"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 13:02:13 -0700
X-CSE-ConnectionGUID: CWJlHK6JT5GzqiPgG9biHg==
X-CSE-MsgGUID: 0RMsoN6gRYGgArGj5oXxGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="165893464"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 11 Aug 2025 13:02:12 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ulYic-0006Bx-32;
	Mon, 11 Aug 2025 20:02:07 +0000
Date: Tue, 12 Aug 2025 04:01:21 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 4b6b14d20bc04dcab6dd3ad0d5a50a0f473d1c18
Message-ID: <202508120415.PwDqDRuO-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 4b6b14d20bc04dcab6dd3ad0d5a50a0f473d1c18  Merge branch into tip/master: 'timers/clocksource'

elapsed time: 727m

configs tested: 120
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250811    gcc-8.5.0
arc                   randconfig-002-20250811    gcc-10.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250811    gcc-10.5.0
arm                   randconfig-002-20250811    gcc-13.4.0
arm                   randconfig-003-20250811    clang-22
arm                   randconfig-004-20250811    gcc-10.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250811    clang-22
arm64                 randconfig-002-20250811    clang-19
arm64                 randconfig-003-20250811    clang-20
arm64                 randconfig-004-20250811    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250811    gcc-15.1.0
csky                  randconfig-002-20250811    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250811    clang-17
hexagon               randconfig-002-20250811    clang-16
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250811    clang-20
i386        buildonly-randconfig-002-20250811    clang-20
i386        buildonly-randconfig-003-20250811    gcc-12
i386        buildonly-randconfig-004-20250811    gcc-12
i386        buildonly-randconfig-005-20250811    gcc-12
i386        buildonly-randconfig-006-20250811    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250811    gcc-15.1.0
loongarch             randconfig-002-20250811    gcc-12.5.0
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
nios2                 randconfig-001-20250811    gcc-10.5.0
nios2                 randconfig-002-20250811    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250811    gcc-9.5.0
parisc                randconfig-002-20250811    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250811    gcc-13.4.0
powerpc               randconfig-002-20250811    clang-22
powerpc               randconfig-003-20250811    gcc-13.4.0
powerpc64             randconfig-001-20250811    clang-22
powerpc64             randconfig-002-20250811    clang-22
powerpc64             randconfig-003-20250811    gcc-14.3.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250811    gcc-8.5.0
riscv                 randconfig-002-20250811    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250811    gcc-8.5.0
s390                  randconfig-002-20250811    clang-17
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250811    gcc-15.1.0
sh                    randconfig-002-20250811    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250811    gcc-8.5.0
sparc                 randconfig-002-20250811    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250811    clang-22
sparc64               randconfig-002-20250811    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250811    clang-18
um                    randconfig-002-20250811    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250811    gcc-12
x86_64      buildonly-randconfig-002-20250811    clang-20
x86_64      buildonly-randconfig-003-20250811    clang-20
x86_64      buildonly-randconfig-004-20250811    clang-20
x86_64      buildonly-randconfig-005-20250811    clang-20
x86_64      buildonly-randconfig-006-20250811    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250811    gcc-9.5.0
xtensa                randconfig-002-20250811    gcc-9.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


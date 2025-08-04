Return-Path: <linux-kernel+bounces-755021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7C5B1A022
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 13:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA0AC3A567F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 11:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB28F23183B;
	Mon,  4 Aug 2025 11:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hVe72l7H"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E981F4617
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 11:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754305379; cv=none; b=diX7wMUNHMoVNXe33ov9OlfVg7Ma1vt+fvQe0kBi0OsvRqEMnzNRIiGp2vOlGmyNHnDhI2JAc++li1P1hqBlgZtYYIp1fMizruEU9hpaZRIDzY8FhPtuSystGVN5ToWF8H0djs7BCIuN6AK+cHFxcYm+pU79bBZpOFrDAfdhIPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754305379; c=relaxed/simple;
	bh=Ej4QUJckZjRE0zgrXH3S5D+cUozTbi6k6dZcNV9mhCE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=c4ntayjqnZitXcIhzpVw2sPNp14ib+mnlqrG7z0Kd380LAR73IDrTQ20c3pxNFh5SBs36NYGnrZ500NG9Z7/Quh8VaVQBrCtkpL/GyYjQfTcwSJoFf+pGoAxlxkquwcl/KVq4zT1f1Lb1NPrn1b/rVWDQJt/+EBWfTCZnD6aFwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hVe72l7H; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754305377; x=1785841377;
  h=date:from:to:cc:subject:message-id;
  bh=Ej4QUJckZjRE0zgrXH3S5D+cUozTbi6k6dZcNV9mhCE=;
  b=hVe72l7HqilQWWSeB0gqcw/7xd5pKcHiJAkueruvZDHihpXx76S9nhgR
   eQR4bOa2/Q0LxLdndDCz6PhmcAHqCMTZBdXOgpIQtHnJb8VhZYoQVbd1S
   aHQs07X6DnWxdxfVew98S96GI+0dWMRokQSw4teLmsh67LwvFwVk2Pjy+
   z/6FwL6K8xnzPROsntXhHtg093B8S6Kx6aBoPk+yV/txqQyesRz8jMKkr
   3ARJIfiD0DBIq84JA17YtRgS04pYiyX/DuCMugNbv7EOLz+nk8Xgecj/N
   u2WYtVJwdfGGhaOT064djXgniO+Ir4AIOgjWlZnlXMz/CEkXcMthEA9Km
   Q==;
X-CSE-ConnectionGUID: g9ckdE7GQ6yirXZDRZO6KA==
X-CSE-MsgGUID: WxxYPQTCQKaaKH9KxhAyPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11511"; a="56643089"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="56643089"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 04:02:56 -0700
X-CSE-ConnectionGUID: 1Xio4jtWR7+PeFJ6as0rXw==
X-CSE-MsgGUID: QLCd7SZjRUKIv1EbKPgEtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="164582940"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 04 Aug 2025 04:02:55 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uisxx-0006zA-1P;
	Mon, 04 Aug 2025 11:02:53 +0000
Date: Mon, 04 Aug 2025 19:02:17 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 40d6e791ba3ac9f66eba33833710a2e2f1aa8a66
Message-ID: <202508041908.Wru0JnGk-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 40d6e791ba3ac9f66eba33833710a2e2f1aa8a66  Merge branch into tip/master: 'timers/clocksource'

elapsed time: 1416m

configs tested: 117
configs skipped: 16

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
arc                   randconfig-001-20250803    gcc-15.1.0
arc                   randconfig-002-20250803    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                       multi_v4t_defconfig    clang-16
arm                         nhk8815_defconfig    clang-22
arm                   randconfig-001-20250803    gcc-8.5.0
arm                   randconfig-002-20250803    gcc-8.5.0
arm                   randconfig-003-20250803    clang-22
arm                   randconfig-004-20250803    clang-22
arm                             rpc_defconfig    clang-18
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250803    gcc-8.5.0
arm64                 randconfig-002-20250803    gcc-11.5.0
arm64                 randconfig-003-20250803    clang-17
arm64                 randconfig-004-20250803    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250803    gcc-11.5.0
csky                  randconfig-002-20250803    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20250803    clang-22
hexagon               randconfig-002-20250803    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250803    gcc-12
i386        buildonly-randconfig-002-20250803    clang-20
i386        buildonly-randconfig-003-20250803    gcc-12
i386        buildonly-randconfig-004-20250803    gcc-12
i386        buildonly-randconfig-005-20250803    clang-20
i386        buildonly-randconfig-006-20250803    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250803    gcc-15.1.0
loongarch             randconfig-002-20250803    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           xway_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250803    gcc-8.5.0
nios2                 randconfig-002-20250803    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250803    gcc-13.4.0
parisc                randconfig-002-20250803    gcc-13.4.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                     asp8347_defconfig    clang-22
powerpc                       ppc64_defconfig    clang-22
powerpc               randconfig-001-20250803    gcc-8.5.0
powerpc               randconfig-002-20250803    gcc-8.5.0
powerpc               randconfig-003-20250803    gcc-13.4.0
powerpc                     tqm8540_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250803    clang-17
powerpc64             randconfig-002-20250803    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
s390                              allnoconfig    clang-22
s390                                defconfig    clang-22
s390                  randconfig-002-20250803    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-002-20250803    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250803    gcc-8.5.0
sparc64                             defconfig    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250803    gcc-12
x86_64      buildonly-randconfig-002-20250803    clang-20
x86_64      buildonly-randconfig-003-20250803    gcc-12
x86_64      buildonly-randconfig-004-20250803    gcc-12
x86_64      buildonly-randconfig-005-20250803    gcc-12
x86_64      buildonly-randconfig-006-20250803    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-kernel+bounces-755760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A179B1AB74
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 01:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E38AC3B9442
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 23:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826D9252286;
	Mon,  4 Aug 2025 23:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dWa4djHV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AC11DF269
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 23:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754350134; cv=none; b=YaVa1VdtKB6fD3l9HECAzMQpF2uqDaHkN/TbED8g7raJkQS3vX63CiYvdNnkA/wq6zm2hRFraFhVssOo1XZyfyMpyCiyMvxABsWxm+KMoV6NX6YlD9+uhJiVGP+2uh+b1+SHGTMImZ0jD46v1XnmqvWh9XJyFniGp92/kUy815Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754350134; c=relaxed/simple;
	bh=XMGAiyC2+sAK7vCzyAEC/oZVEE3WrFlhhOaKpOuHxEU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=TVKkDI+TdBdpbUxWtDT73lMEJa4jCmY1CFfelja3WyWduDf0IrRpNGibV2W1sizfy9xykUntkeTtDCdoBO0gMQ5vA81cKWD5Inu4sL/Ds96cIlbzrDSa8wOc8t8MWod3I+kr1WiaTnJXkswnv05N5+vNUAE4+wITCFlkDji1sW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dWa4djHV; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754350133; x=1785886133;
  h=date:from:to:cc:subject:message-id;
  bh=XMGAiyC2+sAK7vCzyAEC/oZVEE3WrFlhhOaKpOuHxEU=;
  b=dWa4djHVVvp/8nThmz+lfTpPXA9TtD5/zNJnu0fI9vA4blO+FR/92/gW
   kjbE6r+JXBZANJfeCFGVCHuKcxLEItjqi4ZccGeyEjeswbiLQgSPWXRHF
   yzjlvordOMwCKppxShVj5OCzMmaHepfkm5lS5AFNngXn3KXQeXNsbDlE+
   k8s/M3w4JMH/KmiewbfNsPI/Qhs2MX1CUEGi1/6fnwn/NZzVt/zGIwL/s
   nT8PMps1cAI3Cb8QGsJjXEpI/Nzqp08pg7EK0iPOymodHELcgFdhPrKEV
   My5Bi6ZXC7Ur0NcFvlqvcd8KN3g8TcA7a4LR7RlfdhjHW1NwEXYBxWCuU
   A==;
X-CSE-ConnectionGUID: DztoTyviT1KqHhhnqm2NsA==
X-CSE-MsgGUID: j9924xfKT5aHQapWcwM3hA==
X-IronPort-AV: E=McAfee;i="6800,10657,11512"; a="59243864"
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="59243864"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 16:28:53 -0700
X-CSE-ConnectionGUID: PG5x5FMjQsiOVz61kANItw==
X-CSE-MsgGUID: fzSn6INKTfqgCT3yOeDmuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="164733754"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 04 Aug 2025 16:28:52 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uj4bj-0000Id-24;
	Mon, 04 Aug 2025 23:28:45 +0000
Date: Tue, 05 Aug 2025 07:28:26 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20250804] BUILD SUCCESS
 77e4387959f9cf67aa8d2fa3cae21bdb5670245f
Message-ID: <202508050716.pTLiG6V8-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20250804
branch HEAD: 77e4387959f9cf67aa8d2fa3cae21bdb5670245f  wifi: iwlwifi: mei: Avoid multiple -Wflex-array-member-not-at-end warnings

elapsed time: 975m

configs tested: 134
configs skipped: 5

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
arc                            hsdk_defconfig    gcc-15.1.0
arc                        nsim_700_defconfig    gcc-15.1.0
arc                   randconfig-001-20250804    gcc-8.5.0
arc                   randconfig-002-20250804    gcc-13.4.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                   randconfig-001-20250804    clang-22
arm                   randconfig-002-20250804    clang-22
arm                   randconfig-003-20250804    clang-22
arm                   randconfig-004-20250804    gcc-15.1.0
arm                        shmobile_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250804    clang-22
arm64                 randconfig-002-20250804    clang-19
arm64                 randconfig-003-20250804    clang-22
arm64                 randconfig-004-20250804    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250804    gcc-12.5.0
csky                  randconfig-002-20250804    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20250804    clang-22
hexagon               randconfig-002-20250804    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250804    clang-20
i386        buildonly-randconfig-002-20250804    gcc-12
i386        buildonly-randconfig-003-20250804    clang-20
i386        buildonly-randconfig-004-20250804    gcc-12
i386        buildonly-randconfig-005-20250804    gcc-12
i386        buildonly-randconfig-006-20250804    clang-20
i386                                defconfig    clang-20
loongarch                        alldefconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250804    gcc-15.1.0
loongarch             randconfig-002-20250804    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                       m5475evb_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           ip27_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250804    gcc-10.5.0
nios2                 randconfig-002-20250804    gcc-10.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250804    gcc-12.5.0
parisc                randconfig-002-20250804    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                 mpc834x_itx_defconfig    clang-16
powerpc               randconfig-001-20250804    gcc-8.5.0
powerpc               randconfig-002-20250804    gcc-13.4.0
powerpc               randconfig-003-20250804    clang-22
powerpc64             randconfig-001-20250804    clang-22
powerpc64             randconfig-002-20250804    clang-19
powerpc64             randconfig-003-20250804    clang-16
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250804    gcc-8.5.0
riscv                 randconfig-002-20250804    gcc-13.4.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250804    clang-22
s390                  randconfig-002-20250804    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250804    gcc-14.3.0
sh                    randconfig-002-20250804    gcc-15.1.0
sh                        sh7757lcr_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250804    gcc-8.5.0
sparc                 randconfig-002-20250804    gcc-13.4.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250804    gcc-10.5.0
sparc64               randconfig-002-20250804    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250804    clang-22
um                    randconfig-002-20250804    gcc-12
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250804    clang-20
x86_64      buildonly-randconfig-002-20250804    gcc-12
x86_64      buildonly-randconfig-003-20250804    gcc-12
x86_64      buildonly-randconfig-004-20250804    gcc-12
x86_64      buildonly-randconfig-005-20250804    clang-20
x86_64      buildonly-randconfig-006-20250804    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250804    gcc-11.5.0
xtensa                randconfig-002-20250804    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


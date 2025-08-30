Return-Path: <linux-kernel+bounces-792839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8ECB3C99B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 11:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 345273AE9D7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 09:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9693725522B;
	Sat, 30 Aug 2025 09:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YDdm0RYz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABF5C2EF
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 09:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756544706; cv=none; b=IpjrMAwcV1EEoqU4QdeVfsqQxhwUVnpRwA/lLpTHPiFg4M/so7+fVW/Aymj0FI0sACwyf+QjOH6jTyNwfxAkUwKYV64MqS3MgtPml13iBfbCnlZFRzEQBJnkvDumxh9r0oYtzSczZCRN0QhwyldAVgCkGZEsl/4fzJWs6tlTZn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756544706; c=relaxed/simple;
	bh=LeMUDrVMYIkld7pbTp5FPXZMGxu8QTPldnShgDqr5Mk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WFtm5F6ClaGLRmU9EAhwpqcxsv4tcmAf7uUfUBc5sD1jAKOz8VOOZL7+sqE6M8HTBJJxWUjuFSOYwqFxobOMCZ/QNW+Dt+x/5pEHIsofdG97QAI7GKiAP8UvjatCRIO3DjjfFAIWOijljGiIRQMSrvAHJue7UDy0hi5wYimJ3Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YDdm0RYz; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756544704; x=1788080704;
  h=date:from:to:cc:subject:message-id;
  bh=LeMUDrVMYIkld7pbTp5FPXZMGxu8QTPldnShgDqr5Mk=;
  b=YDdm0RYzAVTtC/3U/cCzJMqKd2JCnkF9jBp1QBxgYyo6q5uNwSxGgCQh
   4BvDjiKu2/AQIIsKXz1YMtboL2SfiA5VXigTN0vO88RtCQulXEqZa3QOJ
   nl9ZXXBgcZnSKC/ThmxFhHvOriNmGHv/K0ir3FtMXEqk6bfbkcVGGrLUK
   g1opa2FcyMhkKFggAxe/3l+D32Ddj8EjDYW2lhGGh6Rkt0VhnKsJ0SMa6
   XPfsYWhPuTdRrGYIM3Bh6BAQQWi6Bmy59cvt55gbnuVE9AZzdWXE8Vhjn
   MCSGe+kzhKlim/Xg8ZWjQ1APEgpCQ/hoFhpJuCr+HkOmVyg4pAeMd6Z59
   w==;
X-CSE-ConnectionGUID: 4ZvFU466Qq+ozWmIU6lhfw==
X-CSE-MsgGUID: 8+X7Z1eVTj6AKjAPoqpi9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11537"; a="70251658"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="70251658"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2025 02:05:03 -0700
X-CSE-ConnectionGUID: b5ES65XiQLWvvqgp9gzWyg==
X-CSE-MsgGUID: 5lb/U5fbTw2zo6DBMwLEeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="169814984"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 30 Aug 2025 02:05:01 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1usHV0-000VH1-0H;
	Sat, 30 Aug 2025 09:03:57 +0000
Date: Sat, 30 Aug 2025 17:02:31 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:tip/urgent] BUILD SUCCESS
 94af495b370286c71f2ff647a0f556ad95a06f8a
Message-ID: <202508301721.iI5KoWol-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tip/urgent
branch HEAD: 94af495b370286c71f2ff647a0f556ad95a06f8a  Merge branch into tip/master: 'x86/urgent'

elapsed time: 1451m

configs tested: 199
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20250829    gcc-8.5.0
arc                   randconfig-001-20250830    clang-22
arc                   randconfig-002-20250829    gcc-10.5.0
arc                   randconfig-002-20250830    clang-22
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                         orion5x_defconfig    gcc-15.1.0
arm                   randconfig-001-20250829    gcc-10.5.0
arm                   randconfig-001-20250830    clang-22
arm                   randconfig-002-20250829    clang-22
arm                   randconfig-002-20250830    clang-22
arm                   randconfig-003-20250829    clang-22
arm                   randconfig-003-20250830    clang-22
arm                   randconfig-004-20250829    clang-22
arm                   randconfig-004-20250830    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250829    clang-22
arm64                 randconfig-001-20250830    clang-22
arm64                 randconfig-002-20250829    gcc-12.5.0
arm64                 randconfig-002-20250830    clang-22
arm64                 randconfig-003-20250829    clang-22
arm64                 randconfig-003-20250830    clang-22
arm64                 randconfig-004-20250829    gcc-9.5.0
arm64                 randconfig-004-20250830    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250829    gcc-9.5.0
csky                  randconfig-002-20250829    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250829    clang-22
hexagon               randconfig-002-20250829    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250829    gcc-12
i386        buildonly-randconfig-002-20250829    clang-20
i386        buildonly-randconfig-003-20250829    clang-20
i386        buildonly-randconfig-004-20250829    clang-20
i386        buildonly-randconfig-005-20250829    gcc-12
i386        buildonly-randconfig-006-20250829    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250830    clang-20
i386                  randconfig-002-20250830    clang-20
i386                  randconfig-003-20250830    clang-20
i386                  randconfig-004-20250830    clang-20
i386                  randconfig-005-20250830    clang-20
i386                  randconfig-006-20250830    clang-20
i386                  randconfig-007-20250830    clang-20
i386                  randconfig-011-20250830    gcc-12
i386                  randconfig-012-20250830    gcc-12
i386                  randconfig-013-20250830    gcc-12
i386                  randconfig-014-20250830    gcc-12
i386                  randconfig-015-20250830    gcc-12
i386                  randconfig-016-20250830    gcc-12
i386                  randconfig-017-20250830    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250829    clang-22
loongarch             randconfig-002-20250829    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                        m5272c3_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          ath25_defconfig    gcc-15.1.0
mips                       bmips_be_defconfig    gcc-15.1.0
mips                           ip28_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250829    gcc-11.5.0
nios2                 randconfig-002-20250829    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250829    gcc-14.3.0
parisc                randconfig-002-20250829    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                      katmai_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250829    gcc-13.4.0
powerpc               randconfig-002-20250829    clang-22
powerpc               randconfig-003-20250829    gcc-12.5.0
powerpc                     tqm8548_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250829    clang-22
powerpc64             randconfig-002-20250829    clang-22
powerpc64             randconfig-003-20250829    gcc-8.5.0
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv             nommu_k210_sdcard_defconfig    gcc-15.1.0
riscv                 randconfig-001-20250830    gcc-11.5.0
riscv                 randconfig-001-20250830    gcc-8.5.0
riscv                 randconfig-002-20250830    clang-22
riscv                 randconfig-002-20250830    gcc-11.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250830    clang-22
s390                  randconfig-001-20250830    gcc-11.5.0
s390                  randconfig-002-20250830    gcc-11.5.0
s390                  randconfig-002-20250830    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250830    gcc-11.5.0
sh                    randconfig-002-20250830    gcc-11.5.0
sh                    randconfig-002-20250830    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250830    gcc-11.5.0
sparc                 randconfig-001-20250830    gcc-13.4.0
sparc                 randconfig-002-20250830    gcc-11.5.0
sparc                 randconfig-002-20250830    gcc-8.5.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250830    gcc-11.5.0
sparc64               randconfig-002-20250830    clang-20
sparc64               randconfig-002-20250830    gcc-11.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250830    gcc-11.5.0
um                    randconfig-001-20250830    gcc-12
um                    randconfig-002-20250830    gcc-11.5.0
um                    randconfig-002-20250830    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250829    gcc-11
x86_64      buildonly-randconfig-002-20250829    gcc-11
x86_64      buildonly-randconfig-003-20250829    gcc-12
x86_64      buildonly-randconfig-004-20250829    clang-20
x86_64      buildonly-randconfig-005-20250829    clang-20
x86_64      buildonly-randconfig-006-20250829    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                randconfig-001-20250830    gcc-11
x86_64                randconfig-002-20250830    gcc-11
x86_64                randconfig-003-20250830    gcc-11
x86_64                randconfig-004-20250830    gcc-11
x86_64                randconfig-005-20250830    gcc-11
x86_64                randconfig-006-20250830    gcc-11
x86_64                randconfig-007-20250830    gcc-11
x86_64                randconfig-008-20250830    gcc-11
x86_64                randconfig-071-20250830    gcc-12
x86_64                randconfig-072-20250830    gcc-12
x86_64                randconfig-073-20250830    gcc-12
x86_64                randconfig-074-20250830    gcc-12
x86_64                randconfig-075-20250830    gcc-12
x86_64                randconfig-076-20250830    gcc-12
x86_64                randconfig-077-20250830    gcc-12
x86_64                randconfig-078-20250830    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250830    gcc-11.5.0
xtensa                randconfig-001-20250830    gcc-12.5.0
xtensa                randconfig-002-20250830    gcc-11.5.0
xtensa                randconfig-002-20250830    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


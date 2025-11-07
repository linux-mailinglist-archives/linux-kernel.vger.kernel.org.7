Return-Path: <linux-kernel+bounces-890568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 00445C405B4
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 15:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED5484F567C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 14:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA9D2BE7D7;
	Fri,  7 Nov 2025 14:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LCnC8xmA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32C8288D6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 14:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762525628; cv=none; b=EYkNo/Zv7eqEZzWXqG8PmXdYvs4czeBlqLdga/1hB8e5MZblvCBFAaJgeB4140GUy9VQHJTzfTJFQ8nAmQBPfqzrknf0NtJch4LZ2RKWDR/m+4YV7x467VIrmTcmnD+LDcl716LGE8B/EXr1ADb7e6It68fwJWneg3O0nz5lYYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762525628; c=relaxed/simple;
	bh=D1zXAHP4gtlSF4zwx1ptPGF7CU4cBnJ2+gGjEFBED80=;
	h=Date:From:To:Cc:Subject:Message-ID; b=bqociZZOUFvV7CXRSedQOx/V2oCeNrAzBui6BHkOnQhsNtH9QHTbVX1gX9MXxC2iMvEcOhSWnfdFUO61XnTh1da2NL6RVUHTO4qRSeouV+9rV2O257umBpEl4Vr6aV0ejM4KEg9rM3xY3TZlQJmps0I8hgRLhGk6c7hMaZ03wLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LCnC8xmA; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762525627; x=1794061627;
  h=date:from:to:cc:subject:message-id;
  bh=D1zXAHP4gtlSF4zwx1ptPGF7CU4cBnJ2+gGjEFBED80=;
  b=LCnC8xmAcy8fbI1eB1ohR4vm3zlT9QTJJ31t66z7giFIrXqSf74IsjLq
   bwD5CMd2cBe4NStv1jsKPzaDRKuP0bgU7X2Q+4ZqWpbfzPqOZX3YawkP6
   C3FKqoTAPgjrN9no6205w0E846RcDFuaFqVPUheYxiZdRmz0MkIVA2FMX
   /owZhwM8R/qeZxoUCiEVJUwpQtvXUVU1rHH1aK7KeTjx29i6YSq2lgIJz
   OojLxRU+5ub91N5byvxgyDvgW+/sY8ziNzW8LMHpEkiwrNniHJxG7S/Ls
   vF9Rc+h61vAJQK8z6W8cU7snR6nvRuXqWEg2tz3KnUm+PfYFvzbPsqPU7
   g==;
X-CSE-ConnectionGUID: 1/PjdhYjT+yY8KKjE8zyyA==
X-CSE-MsgGUID: GQtr6b5jRD2yGim/wSBsng==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="90144457"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="90144457"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 06:27:06 -0800
X-CSE-ConnectionGUID: LbrSMci0TwSxjMQ2Efharw==
X-CSE-MsgGUID: 2AZX5sl8QcyqWmWGsjrsVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="211493591"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 07 Nov 2025 06:27:05 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vHNQd-000VCf-0o;
	Fri, 07 Nov 2025 14:27:03 +0000
Date: Fri, 07 Nov 2025 22:26:16 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD SUCCESS
 84361123413efc84b06f3441c6c827b95d902732
Message-ID: <202511072210.i8XLZeRD-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
branch HEAD: 84361123413efc84b06f3441c6c827b95d902732  efi/libstub: Fix page table access in 5-level to 4-level paging transition

elapsed time: 1539m

configs tested: 106
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                         haps_hs_defconfig    gcc-15.1.0
arc                   randconfig-001-20251107    gcc-8.5.0
arc                   randconfig-002-20251107    gcc-9.5.0
arm                               allnoconfig    clang-22
arm                            qcom_defconfig    clang-22
arm                   randconfig-001-20251107    clang-17
arm                   randconfig-002-20251107    gcc-13.4.0
arm                   randconfig-003-20251107    clang-22
arm                   randconfig-004-20251107    gcc-8.5.0
arm                        realview_defconfig    clang-16
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251107    gcc-8.5.0
arm64                 randconfig-002-20251107    clang-22
arm64                 randconfig-003-20251107    gcc-8.5.0
arm64                 randconfig-004-20251107    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251107    gcc-12.5.0
csky                  randconfig-002-20251107    gcc-13.4.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20251107    clang-22
hexagon               randconfig-002-20251107    clang-22
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251107    clang-20
i386        buildonly-randconfig-002-20251107    clang-20
i386        buildonly-randconfig-003-20251107    gcc-13
i386        buildonly-randconfig-004-20251107    gcc-14
i386        buildonly-randconfig-005-20251107    clang-20
i386        buildonly-randconfig-006-20251107    clang-20
i386                                defconfig    clang-20
i386                  randconfig-011-20251107    gcc-14
i386                  randconfig-012-20251107    clang-20
i386                  randconfig-013-20251107    clang-20
i386                  randconfig-014-20251107    gcc-14
i386                  randconfig-015-20251107    clang-20
i386                  randconfig-016-20251107    clang-20
i386                  randconfig-017-20251107    clang-20
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251107    gcc-15.1.0
loongarch             randconfig-002-20251107    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                       m5208evb_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251107    gcc-11.5.0
nios2                 randconfig-002-20251107    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                generic-32bit_defconfig    gcc-15.1.0
parisc                randconfig-001-20251107    gcc-8.5.0
parisc                randconfig-002-20251107    gcc-12.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20251107    clang-22
powerpc               randconfig-002-20251107    clang-22
powerpc64             randconfig-001-20251107    gcc-14.3.0
powerpc64             randconfig-002-20251107    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251106    clang-22
riscv                 randconfig-002-20251106    gcc-12.5.0
s390                              allnoconfig    clang-22
s390                  randconfig-001-20251106    gcc-8.5.0
s390                  randconfig-002-20251106    gcc-14.3.0
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                          polaris_defconfig    gcc-15.1.0
sh                    randconfig-001-20251106    gcc-11.5.0
sh                    randconfig-002-20251106    gcc-13.4.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20251107    gcc-11.5.0
sparc                 randconfig-002-20251107    gcc-15.1.0
sparc64                          alldefconfig    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251107    gcc-8.5.0
sparc64               randconfig-002-20251107    gcc-9.5.0
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251107    clang-22
um                    randconfig-002-20251107    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251107    gcc-14
x86_64      buildonly-randconfig-002-20251107    clang-20
x86_64      buildonly-randconfig-003-20251107    gcc-14
x86_64      buildonly-randconfig-004-20251107    clang-20
x86_64      buildonly-randconfig-005-20251107    gcc-14
x86_64      buildonly-randconfig-006-20251107    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-071-20251107    clang-20
x86_64                randconfig-074-20251107    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251107    gcc-10.5.0
xtensa                randconfig-002-20251107    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


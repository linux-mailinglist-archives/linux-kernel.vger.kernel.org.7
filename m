Return-Path: <linux-kernel+bounces-855765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A11E7BE23C7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78B184EE829
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3181B30C62A;
	Thu, 16 Oct 2025 08:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gV1oXLfD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B082C214A79
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760604937; cv=none; b=fTphCXkCh8Ip8tIK0ONuFeRldo4JcO7pNHAJ4PFKitR13GEdpPBEvHs+K6KYmSP7carGO//oxHh0UKQ7vDhq9inw3Wn0J3zFhZyjCWkrtZU/W0+N6OC071DUJz2bDVTBdK+EdpxtW51Ld6jzu9a/2te5nmUsD1AY2wus2SJeT2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760604937; c=relaxed/simple;
	bh=U+Prz8ci8fZVzrX/k+B7Ha2ZM/+iWBfhIwnNapwnhL0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=JwReijUaqpz6g7jYprJua3himNr8mkUJVZhikmSR668IbvMdihTPrreCg+ChGzrRpj9ewjpKoRgovwGxcQ8/KFJe8y4HAoafpym+4AkcRNBWj0JHgIqo+qc2b4YZiPoZpjrvxTsb3rT48DA19N31Qo8MqjdFKkdzmTrkE0szIss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gV1oXLfD; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760604936; x=1792140936;
  h=date:from:to:cc:subject:message-id;
  bh=U+Prz8ci8fZVzrX/k+B7Ha2ZM/+iWBfhIwnNapwnhL0=;
  b=gV1oXLfDZJ81hSsIrE6UnVP1igOp7grVxtz2X2SVLhfL3XEbyhyVClWy
   WQlLXBV6w7k0CC41XrhDkgELIbhE9HBHH8MqTvwqErEtqfjDonv+6Q53A
   cD67LhGWqhW0++WCh8CW/a35pv+arUSUEMqqY7OpghbU7qaMk8ZD2pvtG
   S2j9hUnLNAq8dbfcqu6cmAFdz/xUqDX7tA2x9XSd6E49KnGgXTq8EALjZ
   4FaBlIuaOAj1eEpgg+Ju1bAe7s6t02uKzenAcVc0yQWL8eXJW56G3jAQP
   oXkbJYhkOJUjRS63N2WowLWbX22q8x4AVzdvDu+GkCy6IabQsDEoP59K4
   Q==;
X-CSE-ConnectionGUID: 7DQ6keKoQIyyz1y8cHrRqQ==
X-CSE-MsgGUID: 2iXQ+Zm/TsOkA1E3AeqUjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="62831754"
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="62831754"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 01:55:35 -0700
X-CSE-ConnectionGUID: gp97pYSzRN6+SDwvrEYg1A==
X-CSE-MsgGUID: YXcbG1JSRfmGjCw15sFUDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="186670413"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 16 Oct 2025 01:55:34 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9Jlj-0004c7-21;
	Thu, 16 Oct 2025 08:55:31 +0000
Date: Thu, 16 Oct 2025 16:54:59 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 0292ef418ce08aad597fc0bba65b6dbb841808ba
Message-ID: <202510161653.lOqaxwQH-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 0292ef418ce08aad597fc0bba65b6dbb841808ba  Merge branch into tip/master: 'x86/entry'

elapsed time: 1323m

configs tested: 129
configs skipped: 4

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
arc                        nsimosci_defconfig    gcc-15.1.0
arc                   randconfig-001-20251015    gcc-8.5.0
arc                   randconfig-002-20251015    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20251015    clang-22
arm                   randconfig-002-20251015    clang-22
arm                   randconfig-003-20251015    gcc-8.5.0
arm                   randconfig-004-20251015    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251015    clang-22
arm64                 randconfig-002-20251015    gcc-13.4.0
arm64                 randconfig-003-20251015    clang-22
arm64                 randconfig-004-20251015    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251015    gcc-15.1.0
csky                  randconfig-002-20251015    gcc-9.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20251015    clang-22
hexagon               randconfig-002-20251015    clang-19
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251015    gcc-13
i386        buildonly-randconfig-002-20251015    gcc-14
i386        buildonly-randconfig-003-20251015    clang-20
i386        buildonly-randconfig-004-20251015    clang-20
i386        buildonly-randconfig-005-20251015    clang-20
i386        buildonly-randconfig-006-20251015    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20251015    gcc-15.1.0
loongarch             randconfig-002-20251015    gcc-15.1.0
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
nios2                 randconfig-001-20251015    gcc-8.5.0
nios2                 randconfig-002-20251015    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251015    gcc-9.5.0
parisc                randconfig-002-20251015    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                   bluestone_defconfig    clang-22
powerpc                        cell_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251015    gcc-15.1.0
powerpc               randconfig-002-20251015    gcc-12.5.0
powerpc               randconfig-003-20251015    clang-22
powerpc                    sam440ep_defconfig    gcc-15.1.0
powerpc                     tqm8560_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251015    clang-22
powerpc64             randconfig-002-20251015    clang-22
powerpc64             randconfig-003-20251015    gcc-13.4.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251015    gcc-10.5.0
riscv                 randconfig-002-20251015    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251015    gcc-12.5.0
s390                  randconfig-002-20251015    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                            migor_defconfig    gcc-15.1.0
sh                    randconfig-001-20251015    gcc-11.5.0
sh                    randconfig-002-20251015    gcc-11.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251015    gcc-8.5.0
sparc                 randconfig-002-20251015    gcc-13.4.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251015    clang-22
sparc64               randconfig-002-20251015    gcc-11.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251015    clang-22
um                    randconfig-002-20251015    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251015    clang-20
x86_64      buildonly-randconfig-002-20251015    gcc-14
x86_64      buildonly-randconfig-003-20251015    clang-20
x86_64      buildonly-randconfig-004-20251015    clang-20
x86_64      buildonly-randconfig-005-20251015    gcc-14
x86_64      buildonly-randconfig-006-20251015    gcc-13
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251015    gcc-9.5.0
xtensa                randconfig-002-20251015    gcc-15.1.0
xtensa                    xip_kc705_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-kernel+bounces-788090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AB6B37F94
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39CC93AA226
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5209346A1D;
	Wed, 27 Aug 2025 10:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lmv/BHMq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767A728312E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756289675; cv=none; b=f82A8YpsoD0gyiWDNPRGzGemHR8ezKNByhiJF10vu6CzIsUtxx/1nf5pH+AAmlIRY3U5CoxVB2Dk7bwqXM68VYwTzVrcNZ8UZ+5AGwdMIte1yZcdDM7beQNyvL0LxpgzhM9CKiLybzJQ7zaMK2ez7nv1/Ii7TCThJBZdJgkCfcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756289675; c=relaxed/simple;
	bh=tzFOwNwr0snYPZ9heeocBWU+MEJ4iTAIlNqCq7DUpQk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=bLgDrJbxxFcj0lFNulfGru2+tViozACzCgU/9dHtTUcewMFSWCHaMRWhH8/qYOmfOm6KDDKODyc9YqoyRmuAGmrxaXqpNlXQWQZxtUjb//H574QnI8K2DgYX6xSRGurlAR719vLOKL7jsg3tp5Eth5VKvxlWYcqKYuV4IKP9jpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lmv/BHMq; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756289673; x=1787825673;
  h=date:from:to:cc:subject:message-id;
  bh=tzFOwNwr0snYPZ9heeocBWU+MEJ4iTAIlNqCq7DUpQk=;
  b=Lmv/BHMqLBBLcZsqnSAScKg3I6XI/BnzJeV2o4Sc+UF0whAOY6yh8VKR
   1dFNQT/B2deWGHLAO8rMjcwjZn878TeL0senqtbiI0jrMd3yqXWCkTCSE
   9i/rqz1PtGHu7ZewCKIRfRJAPpk5AzVjwiYd5j0peEuoVB1OizIAHzlAK
   zSiTA1ppxRCNmdqhoyHG0NbfnTKt15HfLEic5gX4gDLAMCollrNwPdBIR
   JQfldY7KoAa3TF3fpIoODZtPTHOM11Iaa/RDn7rbWDN/it6erOs2TSdX/
   tm4y6emliv2qggDLZBW9AuTHBPcn+iBd7C1871k35vV0qiWf4m/66Cz4T
   A==;
X-CSE-ConnectionGUID: FpokwhGlTAWSr10YRxfahw==
X-CSE-MsgGUID: A5fp53F2QBudW45O6zVX8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="69130503"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="69130503"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 03:14:30 -0700
X-CSE-ConnectionGUID: 7Ir+y3czQP65v2Of4lvjfA==
X-CSE-MsgGUID: KfnWhHZ5QyakOLsX44epbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169746876"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 27 Aug 2025 03:14:28 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1urDAg-000SrJ-1m;
	Wed, 27 Aug 2025 10:14:26 +0000
Date: Wed, 27 Aug 2025 18:13:40 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/asm] BUILD SUCCESS
 ac9c408ed19d535289ca59200dd6a44a6a2d6036
Message-ID: <202508271833.XGp5DFf2-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/asm
branch HEAD: ac9c408ed19d535289ca59200dd6a44a6a2d6036  x86/vdso: Fix output operand size of RDPID

elapsed time: 984m

configs tested: 33
configs skipped: 119

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250827    clang-20
i386        buildonly-randconfig-002-20250827    clang-20
i386        buildonly-randconfig-003-20250827    clang-20
i386        buildonly-randconfig-004-20250827    clang-20
i386        buildonly-randconfig-005-20250827    clang-20
i386        buildonly-randconfig-006-20250827    gcc-12
i386                                defconfig    clang-20
m68k                              allnoconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-15.1.0
openrisc                          allnoconfig    clang-22
parisc                            allnoconfig    clang-22
powerpc                           allnoconfig    clang-22
riscv                             allnoconfig    clang-22
s390                              allnoconfig    clang-22
sh                                allnoconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
um                                allnoconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250827    clang-20
x86_64      buildonly-randconfig-002-20250827    clang-20
x86_64      buildonly-randconfig-003-20250827    gcc-12
x86_64      buildonly-randconfig-004-20250827    gcc-12
x86_64      buildonly-randconfig-005-20250827    clang-20
x86_64      buildonly-randconfig-006-20250827    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


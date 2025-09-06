Return-Path: <linux-kernel+bounces-804213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE93B46CED
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 14:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A75DA7AD769
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 12:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D230284684;
	Sat,  6 Sep 2025 12:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YjPZWNQ2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911BF260586
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 12:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757162200; cv=none; b=BoGdp/mtaM1HyVripe3p54a9xSsa234leeT+/DpVwdpiT4JMk8xoJKxq62jxCiW7AJhydWnk9BDcQxTLNMpFu1VPGIqvm2GQ3CB0YqIuB6gj7Kpzo1iOqfjvxQn26bkk8YEdouKKzFTKqU6Y8UrNNG9MOP28hXIIdvilxe63dvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757162200; c=relaxed/simple;
	bh=25ZvFT4Moom+hj2yyZcKKqF4hUebNYa+BZr0/hwv/Zw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=i3Aq+yCP7KguhNnH7fP8QLHtljkf66nLQzj7IkS+7G3DIb0n/YaBvHRjtn4z/FCsJWAQM6HmV63iUErH27YURuqjmtVoAPDvyT8XNh2iY/s3OvEmUz2d+6MQg8aR0MTfo/D74e1CP6LXXNRofzYmIxgePdj3ymfYc7ibRkyZv6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YjPZWNQ2; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757162199; x=1788698199;
  h=date:from:to:cc:subject:message-id;
  bh=25ZvFT4Moom+hj2yyZcKKqF4hUebNYa+BZr0/hwv/Zw=;
  b=YjPZWNQ2S50j1WhlyfuRhdcxY6ArQH3fZLG6JmG+/N2HuC5RApy1v86Q
   eGHODYuaUhhT9x1f/a6yvRAcXjh8JDdBcqqwvsh/Wf+snlRzoHg/mWH6X
   foSztlVQH6T6Jm78/GZ5RRUQjhzp+I3JFzK52E+RcsIdkrdaqF3LD2PnM
   8X+YNgtBqbF4Vfo8Y1Wc4XOyHBVyhG01xlwMhOx4L7TaKgOLxug6W1nZ+
   4Oq5rOZes1+xp619FGKiwgv9HlhDsrZB7Z6Rzus9E3l1blgoL/h4fKjEc
   cV4f9i8OwRGZ/bmRR8G/Oq64k7zzi+dd51qdPvw6fVaZOc6p3qBTB77zs
   g==;
X-CSE-ConnectionGUID: t9snmqjCRyCRHoVoYlNDZw==
X-CSE-MsgGUID: 9NVECfWXSq66/vmTAk0V5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="59637016"
X-IronPort-AV: E=Sophos;i="6.18,244,1751266800"; 
   d="scan'208";a="59637016"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 05:36:39 -0700
X-CSE-ConnectionGUID: F1BOJz6OQVGwCEQvS1gQFA==
X-CSE-MsgGUID: fEhDuVLqQyWxqOTkMgIfkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,244,1751266800"; 
   d="scan'208";a="196040257"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 06 Sep 2025 05:36:37 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uus9j-0001Rn-0C;
	Sat, 06 Sep 2025 12:36:35 +0000
Date: Sat, 06 Sep 2025 20:36:05 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:ras/core] BUILD SUCCESS
 9f34032ec0deef58bd0eb7475f1981adfa998648
Message-ID: <202509062059.1PPR9Q86-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras/core
branch HEAD: 9f34032ec0deef58bd0eb7475f1981adfa998648  x86/mce: Remove __mcheck_cpu_init_early()

elapsed time: 1452m

configs tested: 94
configs skipped: 127

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                       axs101_defconfig    clang-22
arc                randconfig-001-20250906    gcc-8.5.0
arc                randconfig-002-20250906    gcc-8.5.0
arm                randconfig-001-20250906    gcc-8.5.0
arm                randconfig-002-20250906    gcc-8.5.0
arm                randconfig-003-20250906    gcc-8.5.0
arm                randconfig-004-20250906    gcc-8.5.0
arm                     spear6xx_defconfig    clang-22
arm64              randconfig-001-20250906    gcc-8.5.0
arm64              randconfig-002-20250906    gcc-8.5.0
arm64              randconfig-003-20250906    gcc-8.5.0
arm64              randconfig-004-20250906    gcc-8.5.0
i386     buildonly-randconfig-001-20250905    clang-20
i386     buildonly-randconfig-001-20250906    clang-20
i386     buildonly-randconfig-002-20250905    clang-20
i386     buildonly-randconfig-002-20250906    clang-20
i386     buildonly-randconfig-003-20250905    clang-20
i386     buildonly-randconfig-003-20250906    clang-20
i386     buildonly-randconfig-004-20250905    gcc-13
i386     buildonly-randconfig-004-20250906    clang-20
i386     buildonly-randconfig-005-20250905    clang-20
i386     buildonly-randconfig-005-20250906    clang-20
i386     buildonly-randconfig-006-20250905    clang-20
i386     buildonly-randconfig-006-20250906    clang-20
i386               randconfig-001-20250906    gcc-13
i386               randconfig-002-20250906    gcc-13
i386               randconfig-003-20250906    gcc-13
i386               randconfig-004-20250906    gcc-13
i386               randconfig-005-20250906    gcc-13
i386               randconfig-006-20250906    gcc-13
i386               randconfig-007-20250906    gcc-13
i386               randconfig-011-20250906    clang-20
i386               randconfig-012-20250906    clang-20
i386               randconfig-013-20250906    clang-20
i386               randconfig-014-20250906    clang-20
i386               randconfig-015-20250906    clang-20
i386               randconfig-016-20250906    clang-20
i386               randconfig-017-20250906    clang-20
powerpc                 mvme5100_defconfig    clang-22
powerpc                  tqm5200_defconfig    clang-22
powerpc                  tqm8541_defconfig    clang-22
powerpc                  tqm8548_defconfig    clang-22
riscv              randconfig-001-20250906    gcc-15.1.0
riscv              randconfig-002-20250906    gcc-15.1.0
s390                          allmodconfig    gcc-15.1.0
s390                          allyesconfig    gcc-15.1.0
s390               randconfig-001-20250906    gcc-15.1.0
s390               randconfig-002-20250906    gcc-15.1.0
sh                            allmodconfig    gcc-15.1.0
sh                            allyesconfig    gcc-15.1.0
sh                 randconfig-001-20250906    gcc-15.1.0
sh                 randconfig-002-20250906    gcc-15.1.0
sh                       rsk7203_defconfig    clang-22
sparc                         allmodconfig    gcc-15.1.0
sparc              randconfig-001-20250906    gcc-15.1.0
sparc              randconfig-002-20250906    gcc-15.1.0
sparc64            randconfig-001-20250906    gcc-15.1.0
sparc64            randconfig-002-20250906    gcc-15.1.0
um                 randconfig-001-20250906    gcc-15.1.0
um                 randconfig-002-20250906    gcc-15.1.0
x86_64   buildonly-randconfig-001-20250905    clang-20
x86_64   buildonly-randconfig-001-20250906    gcc-13
x86_64   buildonly-randconfig-002-20250905    clang-20
x86_64   buildonly-randconfig-002-20250906    gcc-13
x86_64   buildonly-randconfig-003-20250905    gcc-13
x86_64   buildonly-randconfig-003-20250906    gcc-13
x86_64   buildonly-randconfig-004-20250905    clang-20
x86_64   buildonly-randconfig-004-20250906    gcc-13
x86_64   buildonly-randconfig-005-20250905    clang-20
x86_64   buildonly-randconfig-005-20250906    gcc-13
x86_64   buildonly-randconfig-006-20250905    gcc-13
x86_64   buildonly-randconfig-006-20250906    gcc-13
x86_64                               kexec    clang-20
x86_64             randconfig-001-20250906    gcc-13
x86_64             randconfig-002-20250906    gcc-13
x86_64             randconfig-003-20250906    gcc-13
x86_64             randconfig-004-20250906    gcc-13
x86_64             randconfig-005-20250906    gcc-13
x86_64             randconfig-006-20250906    gcc-13
x86_64             randconfig-007-20250906    gcc-13
x86_64             randconfig-008-20250906    gcc-13
x86_64             randconfig-071-20250906    clang-20
x86_64             randconfig-072-20250906    clang-20
x86_64             randconfig-073-20250906    clang-20
x86_64             randconfig-074-20250906    clang-20
x86_64             randconfig-075-20250906    clang-20
x86_64             randconfig-076-20250906    clang-20
x86_64             randconfig-077-20250906    clang-20
x86_64             randconfig-078-20250906    clang-20
x86_64                            rhel-9.4    clang-20
x86_64                       rhel-9.4-func    clang-20
x86_64                 rhel-9.4-kselftests    clang-20
xtensa             randconfig-001-20250906    gcc-15.1.0
xtensa             randconfig-002-20250906    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


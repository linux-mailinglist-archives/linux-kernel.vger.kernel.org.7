Return-Path: <linux-kernel+bounces-756838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C3CB1BA0C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 20:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 639443AF7C1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1AC298994;
	Tue,  5 Aug 2025 18:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fczy6pRH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C59200127
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 18:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754418484; cv=none; b=RTUDhwhfibV6scnhTSCGtDKwD+bpSMiDsB493WVwu1U218X9LNKxcIo+aZSJ/RyKDgHdy7fOlrQ6L/IEI018PdN1E67qiDtHWTTk0/tau84PyB7yai45B4bMuYjaouMr5MuVy4YkQHUvqkvBeGgMmaJ/50VWRCdB6A7Rg91oAmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754418484; c=relaxed/simple;
	bh=HQUu+kU0E5pktYlD3xGIpGG/btb9Gd8OIU5vTwwEfKI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nl6UmBzeogjzd6USZ8U56NRbNBheu0AlkozEtPbfKH3mAJHjyOsXk/uaT3GzG+8fRKNbxuRp2jYIcW3aMgltfT5Su2bdCZKLldSBdFAfKW4C1VI92/V+Q0fe+/rT33r+YA9ceWIQBG/K4FNPGjVrzsaQCiM2YO1wvng/t+Ipz9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fczy6pRH; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754418483; x=1785954483;
  h=date:from:to:cc:subject:message-id;
  bh=HQUu+kU0E5pktYlD3xGIpGG/btb9Gd8OIU5vTwwEfKI=;
  b=Fczy6pRHkMsyzRjICsA1oFdc5ERCEHyx7OBT6jl1vR0dm0TDrvykNi7J
   nATdYnb/iDV7jTDOIRxv3pJbfOd8aDv7a2gknuG5mZgl7AXckqNllF0Se
   RDpOoBqh9OpQn4pHqg9SmVUYLevW0XnxRXGV3dKFNt2nkFBt57eWvKHMD
   rMEIjpTkTQu/xY3+gqC1jYOKB6rVdvlrZvQwqCMSVgu2MwXh+uRiK5PRA
   jeSz98GXFZx9jCLacIMdQCEcAvAxBv/YTOjELILlrsXkn/h05f4g/j3qE
   xMcF6TBTkGDQfkEYFSErPeptwipcEzlSZneDHyAyIxMqFxPFoa1p0pzG9
   A==;
X-CSE-ConnectionGUID: kAIOzZpCTBONaocLovTqGw==
X-CSE-MsgGUID: ce6h74unRIuyKiVsRClhKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="66992602"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="66992602"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 11:28:03 -0700
X-CSE-ConnectionGUID: 5HQxZUUURruJ1sGIH9a50A==
X-CSE-MsgGUID: d3xG2ysCRnSUc+YXZADX9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="164929325"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 05 Aug 2025 11:28:02 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ujMOF-0000kM-2q;
	Tue, 05 Aug 2025 18:27:59 +0000
Date: Wed, 06 Aug 2025 02:27:48 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev] BUILD SUCCESS
 f2872f05e49b923545d7a5e092914bc4dfc0ea06
Message-ID: <202508060238.trXzVI6V-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
branch HEAD: f2872f05e49b923545d7a5e092914bc4dfc0ea06  EXP Revert "rcu/exp: Warn on CPU lagging for too long within hotplug IPI's blindspot"

elapsed time: 1442m

configs tested: 52
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                  randconfig-001-20250805    gcc-8.5.0
arc                  randconfig-002-20250805    gcc-10.5.0
arm                  randconfig-001-20250805    gcc-11.5.0
arm                  randconfig-002-20250805    clang-22
arm                  randconfig-003-20250805    gcc-12.5.0
arm                  randconfig-004-20250805    clang-18
arm64                randconfig-001-20250805    gcc-12.5.0
arm64                randconfig-002-20250805    clang-20
arm64                randconfig-003-20250805    gcc-11.5.0
arm64                randconfig-004-20250805    gcc-13.4.0
csky                 randconfig-001-20250805    gcc-12.5.0
csky                 randconfig-002-20250805    gcc-10.5.0
hexagon              randconfig-001-20250805    clang-20
hexagon              randconfig-002-20250805    clang-22
i386       buildonly-randconfig-001-20250805    clang-20
i386       buildonly-randconfig-002-20250805    gcc-12
i386       buildonly-randconfig-003-20250805    gcc-12
i386       buildonly-randconfig-004-20250805    gcc-12
i386       buildonly-randconfig-005-20250805    gcc-12
i386       buildonly-randconfig-006-20250805    gcc-12
loongarch            randconfig-001-20250805    gcc-15.1.0
loongarch            randconfig-002-20250805    gcc-12.5.0
nios2                randconfig-001-20250805    gcc-11.5.0
nios2                randconfig-002-20250805    gcc-8.5.0
parisc               randconfig-001-20250805    gcc-10.5.0
parisc               randconfig-002-20250805    gcc-15.1.0
powerpc              randconfig-001-20250805    clang-22
powerpc              randconfig-002-20250805    clang-22
powerpc              randconfig-003-20250805    gcc-9.5.0
powerpc64            randconfig-001-20250805    clang-22
powerpc64            randconfig-002-20250805    clang-19
powerpc64            randconfig-003-20250805    clang-22
riscv                randconfig-001-20250805    clang-18
riscv                randconfig-002-20250805    gcc-9.5.0
s390                 randconfig-001-20250805    clang-22
s390                 randconfig-002-20250805    clang-22
sh                   randconfig-001-20250805    gcc-9.5.0
sh                   randconfig-002-20250805    gcc-14.3.0
sparc                randconfig-001-20250805    gcc-8.5.0
sparc                randconfig-002-20250805    gcc-15.1.0
sparc64              randconfig-001-20250805    gcc-9.5.0
sparc64              randconfig-002-20250805    clang-22
um                   randconfig-001-20250805    gcc-12
um                   randconfig-002-20250805    gcc-12
x86_64     buildonly-randconfig-001-20250805    gcc-12
x86_64     buildonly-randconfig-002-20250805    gcc-12
x86_64     buildonly-randconfig-003-20250805    clang-20
x86_64     buildonly-randconfig-004-20250805    gcc-12
x86_64     buildonly-randconfig-005-20250805    clang-20
x86_64     buildonly-randconfig-006-20250805    gcc-12
xtensa               randconfig-001-20250805    gcc-14.3.0
xtensa               randconfig-002-20250805    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


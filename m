Return-Path: <linux-kernel+bounces-887082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1222FC3739F
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A81C3A5C4C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF6C33B963;
	Wed,  5 Nov 2025 17:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ixlRQkv2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2751D231C91
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 17:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762365241; cv=none; b=gtNEXOk52KEWs56L3WIiudsEjBXDbZeX6P2yHehN6D0tAI6b+KJjTpS4AsLOle8cHJ70kSIqMDg8ACGZaKRbgg/uTOP4r0PtQoFgGO6+mWX5DHTotS6xFpCGUgQ4TnPcHd3xQCGARK5ZYWmRmpiaPOVHFaVaOBS2bJTN6W0ychM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762365241; c=relaxed/simple;
	bh=QmFDpS6djB6wOgB5EJhOWsdARxfuFsIFNgte9Q7Oyio=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jkbMOj2FbhvFa4b66uAMntqqSDrQF236yeTm6OI85/vS+DscVlMo/OlqZJ0BvuEG5DaEYwV+qEf8RmJIw0MnVsPG4BmCPP8M2Fdgo7iJ5jLt+aqF1Kz0RSDA8wBxaaxk64mixLEY1wRHgmsZXLDyq/HWwzfVNlr34U/meH9jUO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ixlRQkv2; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762365239; x=1793901239;
  h=date:from:to:cc:subject:message-id;
  bh=QmFDpS6djB6wOgB5EJhOWsdARxfuFsIFNgte9Q7Oyio=;
  b=ixlRQkv26kFPFuFhcrM+axpQqQXXJ1feC2cbzfCvLz5g80pyQ+v33uaB
   XHx+BNxiXwQ316xuHKDHT//SF3mmPfAifEBbhXDSBC+4ax8iU4jEZoXI7
   gKLxvCm8ihyHvR+O0pPf5DZOzvVbQHisW8MsKYJM2LynD9BZEVK6Jh+tc
   5j0FHPHsP1QLg2oxRMQ9H7ozZZ7LBEys+ycetRD7x7hkfVsoaWKc7RDRJ
   hkZiL3ECi2VtyyrCe/OKbRRionwSFTl1Q/9erOeA5WR08lhnpVMBPq/5l
   6mHFoEVEAsrNeNNMzOPq2wpiiV6HUJG0OIuFNx2+Ftq9VW3SRfaJK+BM/
   Q==;
X-CSE-ConnectionGUID: tbJGmPqbQXee7atZIADK/Q==
X-CSE-MsgGUID: WOeDBpYgQYqA8eWzfav2BQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64587698"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="64587698"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 09:53:58 -0800
X-CSE-ConnectionGUID: pydUKzoGTmKB7n5bJcNDYw==
X-CSE-MsgGUID: dj8M1Y/2Qvm4nK3kWIjO0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="187365771"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 05 Nov 2025 09:53:57 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGhhU-000Sx4-1n;
	Wed, 05 Nov 2025 17:53:43 +0000
Date: Thu, 06 Nov 2025 01:50:00 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 f1fdffe0afea02ba783acfe815b6a60e7180df40
Message-ID: <202511060154.FX7hoMvx-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: f1fdffe0afea02ba783acfe815b6a60e7180df40  x86/CPU/AMD: Add missing terminator for zen5_rdseed_microcode

elapsed time: 1459m

configs tested: 30
configs skipped: 130

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                          allnoconfig    gcc-14
i386    buildonly-randconfig-001-20251105    gcc-14
i386    buildonly-randconfig-002-20251105    gcc-14
i386    buildonly-randconfig-003-20251105    clang-20
i386    buildonly-randconfig-004-20251105    gcc-14
i386    buildonly-randconfig-005-20251105    gcc-14
i386    buildonly-randconfig-006-20251105    clang-20
i386                            defconfig    clang-20
i386              randconfig-001-20251105    clang-20
i386              randconfig-002-20251105    gcc-14
i386              randconfig-003-20251105    clang-20
i386              randconfig-005-20251105    clang-20
i386              randconfig-011-20251105    clang-20
i386              randconfig-012-20251105    clang-20
i386              randconfig-013-20251105    clang-20
i386              randconfig-014-20251105    clang-20
x86_64                        allnoconfig    clang-20
x86_64  buildonly-randconfig-001-20251105    clang-20
x86_64  buildonly-randconfig-002-20251105    gcc-13
x86_64  buildonly-randconfig-003-20251105    gcc-14
x86_64  buildonly-randconfig-004-20251105    gcc-13
x86_64  buildonly-randconfig-005-20251105    gcc-14
x86_64  buildonly-randconfig-006-20251105    gcc-13
x86_64                          defconfig    gcc-14
x86_64            randconfig-011-20251105    clang-20
x86_64            randconfig-012-20251105    clang-20
x86_64            randconfig-013-20251105    clang-20
x86_64            randconfig-014-20251105    gcc-14
x86_64            randconfig-015-20251105    clang-20
x86_64            randconfig-016-20251105    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


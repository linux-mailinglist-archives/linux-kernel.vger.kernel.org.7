Return-Path: <linux-kernel+bounces-856893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 561B2BE55A9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15D093AF353
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339C328CF49;
	Thu, 16 Oct 2025 20:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T13aU9SA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB926469D
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760645899; cv=none; b=hgUD69NBY4UUcQQq4Da1RL9CR1e88KRhvHPgaXxkKqQXLP876UB1EWZahZ63iB9wYRQVXl9JngLiwASGpJlJOpSDvURDMArWlMgLOEB9SWUcMPXTx2qMH5k0iM7oIVBLCH72Dokq3AUCqFl1QmQ2axMD1goq7gcUAbnFoaXvsa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760645899; c=relaxed/simple;
	bh=j55kpS4MAhEcPT2lcRO+b1eYhLM9AQKscFtBTAUEMV0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nZLqZyYY9t/GLNSdwiCU6fNmQyIJyWkTXMXhVE/4P520SoGkyOmWsLAtxOZfRgNYfwVVm8PKfSCSAl7esiV8eT2qSatAHrDPe4DQ7GiPOB2TZil+nreUd1Km7YFLOPPXlt1XM9gCiZS7fWf8d0VZJGaeskZbylXnsLymQL413PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T13aU9SA; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760645897; x=1792181897;
  h=date:from:to:cc:subject:message-id;
  bh=j55kpS4MAhEcPT2lcRO+b1eYhLM9AQKscFtBTAUEMV0=;
  b=T13aU9SA2G/1Cf7G5T6BgNTVLmYkNAAZ991VD3bKoX8Jqv8w5xqgDmwc
   tYE2R+CJ1lqzCxAWHUHXtx4E6AbRfoi0zW0AAGsjqqjQOT/5CnSm1+ZXN
   rxHc0idNjrJmA5fDkIo1xKk9u8FvQGsE3nGZfGugyc7IzPZcy/ugHdZ2y
   UfJUsD7UD1oFP0vGWnrZvPNaVS2H8jlDM/+19gz9WyovJYH5+58ubsD9y
   7xHmItlFg9lBxgzcEhWu3tgP0IUhbM1O2heTBj1LwLWeK/vRs0PMjS6q4
   6PkVFLl6P4tbPMcBWBiuWZl4k1yoFpvFlvlLUjrdw+bu7g67XkcR7Mf9G
   g==;
X-CSE-ConnectionGUID: XxhV/lu/RUGmw4v3LmxBDw==
X-CSE-MsgGUID: jCARrK2dTi60vuNfFiYYog==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="66685624"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="66685624"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 13:18:17 -0700
X-CSE-ConnectionGUID: quuWxzUaTWuhCuFfkbazbA==
X-CSE-MsgGUID: muIb7yDMQVSDiunm6Yxtqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="186814321"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 16 Oct 2025 13:18:16 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9UQK-0005D9-00;
	Thu, 16 Oct 2025 20:18:13 +0000
Date: Fri, 17 Oct 2025 04:17:23 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 e6416c2dfe23c9a6fec881fda22ebb9ae486cfc5
Message-ID: <202510170418.B6duS87D-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: e6416c2dfe23c9a6fec881fda22ebb9ae486cfc5  x86/CPU/AMD: Prevent reset reasons from being retained across reboot

elapsed time: 1413m

configs tested: 20
configs skipped: 119

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                         allmodconfig    gcc-14
i386                          allnoconfig    gcc-14
i386                         allyesconfig    gcc-14
i386    buildonly-randconfig-001-20251016    clang-20
i386    buildonly-randconfig-002-20251016    gcc-14
i386    buildonly-randconfig-003-20251016    clang-20
i386    buildonly-randconfig-004-20251016    clang-20
i386    buildonly-randconfig-005-20251016    clang-20
i386    buildonly-randconfig-006-20251016    gcc-14
i386                            defconfig    clang-20
x86_64                        allnoconfig    clang-20
x86_64                       allyesconfig    clang-20
x86_64  buildonly-randconfig-001-20251016    clang-20
x86_64  buildonly-randconfig-002-20251016    gcc-14
x86_64  buildonly-randconfig-003-20251016    gcc-14
x86_64  buildonly-randconfig-004-20251016    gcc-12
x86_64  buildonly-randconfig-005-20251016    gcc-14
x86_64  buildonly-randconfig-006-20251016    gcc-12
x86_64                          defconfig    gcc-14
x86_64                      rhel-9.4-rust    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


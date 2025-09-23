Return-Path: <linux-kernel+bounces-829630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B59B97805
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6B241AE08B6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 20:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522D42DE719;
	Tue, 23 Sep 2025 20:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aIU+MGzI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4142749C1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 20:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758659590; cv=none; b=GFj1Pmr3DpoXHXmIcfUaxX07paeI7tF3GYBcSoLLN6ISQLmwrXqAkiVHcf1xj0WgUkTjfoafymrYuXkhwMAoguiPs7PHHfrhJgzFJY+z5ZNZavooKxnmaMNkySmA98oH5NA32WPpAfKLVjXso+6h8PHYRZkLiqezvMTjp0euC1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758659590; c=relaxed/simple;
	bh=i6q6np61sv1RUNFJRUH6rMRoTSFl6Q8EVwDI0MXzaec=;
	h=Date:From:To:Cc:Subject:Message-ID; b=I849CSd8a/4xdD1nLDdo5bXLKc2N5/t4rPkglNmggW21NpZd3VHr9iog8B+zz0TxNHRpBcDCw47xTDgYAcFwfGwZowypFEq+6tP9B6Mbh8UgKNmr1blybfn6TliiucukGajaz2Wo/seZ3eCq/UQu8VeuuVZ91mQZu0kAZyYTQoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aIU+MGzI; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758659589; x=1790195589;
  h=date:from:to:cc:subject:message-id;
  bh=i6q6np61sv1RUNFJRUH6rMRoTSFl6Q8EVwDI0MXzaec=;
  b=aIU+MGzIMO+qOROvlvmaa7gp2azb1NBIrpB0X/FRmg7W0FwOUgHljAtW
   LbwtKZ77RFiQzTJIvz2JJWcsddzrtKDiYUWKZAf/AUtoWjUHfLkG1kSrS
   lrL6Ts54USCNEWVIhbcM49Do3X+JzP55gfjj1GbdcQZ4DrFzooJB3tOHj
   6VPpqJG2a2sxb85N6GTe+61ROIeJJfA3eUPCtqtEkCU4papGbHTtqP1pY
   uyv1dXas14xAyZ9AkTR1PKnpOEMPfz1cHIds+YuGJyuIyVC5yx600tLJt
   TrG2TsfP44ojmKXphw3fT3PFas6mDZc9Ff7/UKhezZ0SDT71vWhOk99EE
   A==;
X-CSE-ConnectionGUID: 9rGlf1A9SvaBY0vEapGYQw==
X-CSE-MsgGUID: K4kBA7MhTAOrDQQglJDSKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="61061441"
X-IronPort-AV: E=Sophos;i="6.18,289,1751266800"; 
   d="scan'208";a="61061441"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 13:33:08 -0700
X-CSE-ConnectionGUID: 6LwXRz7ARCi0xrLwYjxSiQ==
X-CSE-MsgGUID: 0TKVGkTkQ2ypQIpQwS0zvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,289,1751266800"; 
   d="scan'208";a="180854685"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 23 Sep 2025 13:33:07 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v19hA-0003WX-3B;
	Tue, 23 Sep 2025 20:33:04 +0000
Date: Wed, 24 Sep 2025 04:32:39 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 2066f00e5b2dc061fb6d8c88fadaebc97f11feaa
Message-ID: <202509240433.LzdCm5Bs-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 2066f00e5b2dc061fb6d8c88fadaebc97f11feaa  x86/topology: Implement topology_is_core_online() to address SMT regression

elapsed time: 1451m

configs tested: 19
configs skipped: 119

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                          allnoconfig    gcc-14
i386                         allyesconfig    gcc-14
i386    buildonly-randconfig-001-20250923    gcc-14
i386    buildonly-randconfig-002-20250923    clang-20
i386    buildonly-randconfig-003-20250923    clang-20
i386    buildonly-randconfig-004-20250923    gcc-14
i386    buildonly-randconfig-005-20250923    clang-20
i386    buildonly-randconfig-006-20250923    clang-20
i386                            defconfig    clang-20
x86_64                        allnoconfig    clang-20
x86_64                       allyesconfig    clang-20
x86_64  buildonly-randconfig-001-20250923    gcc-14
x86_64  buildonly-randconfig-002-20250923    gcc-14
x86_64  buildonly-randconfig-003-20250923    gcc-14
x86_64  buildonly-randconfig-004-20250923    clang-20
x86_64  buildonly-randconfig-005-20250923    clang-20
x86_64  buildonly-randconfig-006-20250923    clang-20
x86_64                          defconfig    gcc-14
x86_64                      rhel-9.4-rust    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


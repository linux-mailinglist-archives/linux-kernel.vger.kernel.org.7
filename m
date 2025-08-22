Return-Path: <linux-kernel+bounces-781176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E473EB30E84
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C14E5E45AB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 06:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD92284B25;
	Fri, 22 Aug 2025 06:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wia/L7v+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC9A22A1E6
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755842859; cv=none; b=dmHkLkxEEjB1E3btWQCDiSiWn6VrbukzzoeoD+MjG7bJm8tmrOOQxScE5Y8ZfXqK+ec0IcsYm15PaJq3+uQNhiw//X9Jz+xHw1xnXNCBoshHZhCp1hgZ8rM3AHYc2+3YAsYux7avBAGn5a5yIEm0xfP3i9odJM5eq0dIsKlLyrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755842859; c=relaxed/simple;
	bh=OUXXmmgqG5Wwt17L3AC/I97EGspESE5KKszkbcAsYW4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hANkggXBkL2vCm9+I2j5packdymkPkZ2XD7gwegFa3n4UkEIc9S7dMh0EMNwNhCI7JrNLivv8jWyAAS7g+7vvBv6SBS45OG1gqP48rMBs25x8eFZU7ZRC02GKLvBLWiZo4VMn0ZCrUUilKntr8Fk5jSCavg22iJzSkyF/3S9eQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wia/L7v+; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755842858; x=1787378858;
  h=date:from:to:cc:subject:message-id;
  bh=OUXXmmgqG5Wwt17L3AC/I97EGspESE5KKszkbcAsYW4=;
  b=Wia/L7v+bnD+momYfR4C9bQPamI9mQobx44Fj/TvasczYT0+kf09oPuT
   N2u9IaIRDHtaurf04tVw927yd/55lJhnopqkGfufEu9SplFPfrU/Ml7pd
   FGguDeAe1+MQQhHms+MAXediz5nShcPb8MGnZf7PMDctvO7SwQfYc7EiE
   G0Tw37LrBAjrNx+OWHGeYGWK87RPcW9zSTmCbp0dzNnXGoFLfS+gc+Btm
   CettBUw0+Y4ENLGaO0l068pBzOoXxZmIap2DhTCb8uQdRi28gsUkDBMD+
   OKiJgTjkbb6bF2qZKDIjrY/wH+wEyJ++yOhYUcKI2HjI39ddS6GvfWr+h
   g==;
X-CSE-ConnectionGUID: rfaG6ZeHR5OkqtYf91slUQ==
X-CSE-MsgGUID: zMcDFQ3GTRGtTJBU0cZ8iA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="80745448"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="80745448"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 23:03:46 -0700
X-CSE-ConnectionGUID: s8zWW03RT9S3upKrKM5SnA==
X-CSE-MsgGUID: 5VIp+QuPSwye545o2n8NLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="169031418"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 21 Aug 2025 23:03:44 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upKrw-000KxW-2p;
	Fri, 22 Aug 2025 06:03:27 +0000
Date: Fri, 22 Aug 2025 14:02:22 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 ae7c0996c0e0f7d3bd3665020e1fbb4d99b7373e
Message-ID: <202508221414.WAhxvvg6-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: ae7c0996c0e0f7d3bd3665020e1fbb4d99b7373e  x86/kconfig: Remove CONFIG_AS_AVX512

elapsed time: 962m

configs tested: 20
configs skipped: 119

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                         allmodconfig    gcc-12
i386                          allnoconfig    gcc-12
i386                         allyesconfig    gcc-12
i386    buildonly-randconfig-001-20250821    gcc-12
i386    buildonly-randconfig-002-20250821    gcc-12
i386    buildonly-randconfig-003-20250821    clang-20
i386    buildonly-randconfig-004-20250821    gcc-12
i386    buildonly-randconfig-005-20250821    gcc-12
i386    buildonly-randconfig-006-20250821    clang-20
i386                            defconfig    clang-20
x86_64                        allnoconfig    clang-20
x86_64                       allyesconfig    clang-20
x86_64  buildonly-randconfig-001-20250821    clang-20
x86_64  buildonly-randconfig-002-20250821    clang-20
x86_64  buildonly-randconfig-003-20250821    clang-20
x86_64  buildonly-randconfig-004-20250821    gcc-12
x86_64  buildonly-randconfig-005-20250821    clang-20
x86_64  buildonly-randconfig-006-20250821    clang-20
x86_64                          defconfig    gcc-11
x86_64                      rhel-9.4-rust    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-kernel+bounces-753963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDD7B18AD7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 07:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C88A7627576
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 05:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C2A199934;
	Sat,  2 Aug 2025 05:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nylvcQYR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654A6A59
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 05:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754113836; cv=none; b=ew9M4ONPSq3TCJhGvpLFIQqdmdcim077T7e+eGJ4J5wxSoo3IEld5hhkVDM6HqxJdPM1EChDZgdnAz+IkAvD/qdFw+DIGuWgnVMG4IlmPvAZR6ZKUp7egS/HpO18DDGe9QYO8N9ZR5mLjpRnl0ZsFs26XxA7S48TJ4FLpFM2bEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754113836; c=relaxed/simple;
	bh=m9A4Vk1+IeAbEDE97k9QsTx7vr9hoJkkE7asjlvcQ/U=;
	h=Date:From:To:Cc:Subject:Message-ID; b=JCNe9RCVd5LtWn8jbtSb5/5tga7wxbkvcirEascw5ju2enxBWmWTeo/2b4sU90SwiLKzJqIfBzhJj/rKPIglFpvYtGRIlWGKn2H/leJWo0MSebgast7UUcHT/1K/AMa8u7MqUUkH1T8ZZHJ3f/Fokdmpb0swJ63N2TSInNzPtLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nylvcQYR; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754113834; x=1785649834;
  h=date:from:to:cc:subject:message-id;
  bh=m9A4Vk1+IeAbEDE97k9QsTx7vr9hoJkkE7asjlvcQ/U=;
  b=nylvcQYR6M3lWt6Py2wVTj2dDr9lbB9HOduHhFcW0lA6pBl4cNCHZbLQ
   NMS2QM18tBU8o3zL7lp/r4RLkStF4gyrhS21CVPMGW36Asw0rfwgY8kea
   x+T+zVAGRfvzISpfIYyLUBPbSh6aVEgJFsvzsyk9Odo6WhV3LvxfSKnTp
   6rE3/DeHZA0E6YpUOsa5yeFWpbHtEa5XL5hKOERdBri3fYqVKin6xE5Lu
   hlo+M1Aq4Vs6gP6ce3yLLEvtklXffTzndD1CBT+KnQjveH/l3OJPsL8Bb
   7YHk/7wbaCHNnViJHNwBytxEC/FMDnPy2VvCPewkMf2uWumU6VwjhYr6d
   A==;
X-CSE-ConnectionGUID: uWc77p3mStGEcJcfCRUtqA==
X-CSE-MsgGUID: 1hccOxTwRASX8BgTVPoiXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="67029027"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="67029027"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 22:50:34 -0700
X-CSE-ConnectionGUID: pSsiIfHfTfG0+p60ljElpQ==
X-CSE-MsgGUID: 0Ud1eyP8Q2+3mBLr+cwiUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="168197973"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 01 Aug 2025 22:50:33 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ui58Y-0005Ce-2T;
	Sat, 02 Aug 2025 05:50:30 +0000
Date: Sat, 02 Aug 2025 13:49:37 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 49f848788a4d157bb6648a57963cb060fed3d56e
Message-ID: <202508021327.2Fctb2Yi-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 49f848788a4d157bb6648a57963cb060fed3d56e  x86/cpu: Add new Intel CPU model numbers for Wildcatlake and Novalake

elapsed time: 732m

configs tested: 20
configs skipped: 127

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                         allmodconfig    gcc-12
i386                          allnoconfig    gcc-12
i386                         allyesconfig    gcc-12
i386    buildonly-randconfig-001-20250802    gcc-12
i386    buildonly-randconfig-002-20250802    gcc-12
i386    buildonly-randconfig-003-20250802    clang-20
i386    buildonly-randconfig-004-20250802    gcc-12
i386    buildonly-randconfig-005-20250802    clang-20
i386    buildonly-randconfig-006-20250802    clang-20
i386                            defconfig    clang-20
x86_64                        allnoconfig    clang-20
x86_64                       allyesconfig    clang-20
x86_64  buildonly-randconfig-001-20250802    gcc-12
x86_64  buildonly-randconfig-002-20250802    clang-20
x86_64  buildonly-randconfig-003-20250802    clang-20
x86_64  buildonly-randconfig-004-20250802    clang-20
x86_64  buildonly-randconfig-005-20250802    clang-20
x86_64  buildonly-randconfig-006-20250802    clang-20
x86_64                          defconfig    gcc-11
x86_64                      rhel-9.4-rust    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


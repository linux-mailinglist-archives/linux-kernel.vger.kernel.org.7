Return-Path: <linux-kernel+bounces-772856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B37B2987D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 024027AF95D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 04:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060D62652AF;
	Mon, 18 Aug 2025 04:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XjTftrV8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69E5265296
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755492059; cv=none; b=tbSnFvtlA/i94T46Enrsph9gXwvvUW0DMquU6Jtg4iNUIWByHrHB0Eq78mQmVAwzPCxqSx/QuT1tntOuhOEtcZbrREmkuVx/60580xAzdyHtoS5s4Hvld+gSv5JvH4EDIEOmLrhA4fL2nUSS+9s+QGHB2fQvC6FhKOijxbpEVP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755492059; c=relaxed/simple;
	bh=0nqVQ3VRZy3N5CkhluMlGz3INT6q30IqHRSssg23f3o=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Eq3tL2NEXNyIWq/dqKyEhh+W+pFzTN6DEG5sGo2rBWVdXi4kfBpySMLYQP4oe1bjREEmLSs0tjjlbcejdOFx7kPYyxEZuI5CmMxkkp8oBlfR2wXwbjRKM4Qlwrpn8tG58nUNGTPX8BTWxerkqQ9hgUEutF0sAOuU3Y6ORm83B+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XjTftrV8; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755492058; x=1787028058;
  h=date:from:to:cc:subject:message-id;
  bh=0nqVQ3VRZy3N5CkhluMlGz3INT6q30IqHRSssg23f3o=;
  b=XjTftrV8iV6LJnACtkG9KxHS+q5XzLhoPEEKLKUGC88aTCyaMZmZaMQx
   gpDWMzfo6Tl9TL/SG9WOKT7VOD92OrzV2076kANdzC3eq8xapi0Ee/NCg
   6R+jDUZudV+6wvUTMn4enbdDNQyNDaW3u2l/I/cs85lEga6/XkJ3i9/lL
   S+VYXqdXyhlT858u7lVE8TOMNQu1MNl4o0ket7l7CQjIc5G/XTz4b82qT
   AVatreodaDofMyqW5W6flrN0C8U2ftn5hwnVPhcEAOgx43zcVNH0J6iBw
   bW5wovvExOFpI3x26XEPFrTXzDv3rdz1fVQRasqtNU+YUGYze9ywOxoVJ
   Q==;
X-CSE-ConnectionGUID: 5ZxLZ+zPSA2SIDSZrEvWBA==
X-CSE-MsgGUID: DzQ9d3dkT0uLdv2Zz1sDfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="57780550"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="57780550"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2025 21:40:57 -0700
X-CSE-ConnectionGUID: yzw9jH6cTM6zU+ghJcPVCQ==
X-CSE-MsgGUID: 2bIcZkEzT2+aeiv7m4F7LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="198333081"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 17 Aug 2025 21:40:56 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1unrfe-000Dv4-35;
	Mon, 18 Aug 2025 04:40:41 +0000
Date: Mon, 18 Aug 2025 12:39:27 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/build] BUILD SUCCESS
 2c6a28f3ef729ed2d5b174b4e0f33172fb286bab
Message-ID: <202508181219.wku7fCDH-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/build
branch HEAD: 2c6a28f3ef729ed2d5b174b4e0f33172fb286bab  x86/Kconfig: Clean up LLVM version checks in IBT configurations

elapsed time: 727m

configs tested: 20
configs skipped: 118

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                         allmodconfig    gcc-12
i386                          allnoconfig    gcc-12
i386                         allyesconfig    gcc-12
i386    buildonly-randconfig-001-20250818    clang-20
i386    buildonly-randconfig-002-20250818    clang-20
i386    buildonly-randconfig-003-20250818    gcc-12
i386    buildonly-randconfig-004-20250818    clang-20
i386    buildonly-randconfig-005-20250818    gcc-12
i386    buildonly-randconfig-006-20250818    gcc-12
i386                            defconfig    clang-20
x86_64                        allnoconfig    clang-20
x86_64                       allyesconfig    clang-20
x86_64  buildonly-randconfig-001-20250818    gcc-12
x86_64  buildonly-randconfig-002-20250818    gcc-12
x86_64  buildonly-randconfig-003-20250818    gcc-12
x86_64  buildonly-randconfig-004-20250818    gcc-12
x86_64  buildonly-randconfig-005-20250818    gcc-12
x86_64  buildonly-randconfig-006-20250818    clang-20
x86_64                          defconfig    gcc-11
x86_64                      rhel-9.4-rust    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


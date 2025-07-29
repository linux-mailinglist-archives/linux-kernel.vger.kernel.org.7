Return-Path: <linux-kernel+bounces-749872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DED8B153FF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 21:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A82315610AF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 19:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D2029B8CC;
	Tue, 29 Jul 2025 19:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gteGIVBt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0336D29B793
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 19:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753819143; cv=none; b=REPIO6I2n/LI+H2fbgzETu8vL/7IQkMskXaIJ2psg5ymUNmuHVtTGvY/99PGZURyEMVDutDbcBiExTnOmWnStk2wPoReT7LKtGb/t+sTqGJGvJs345uv21fF5ImHUOMwjExcTeBYZ6Lx4BEX6hRdMvwyKgLYZjSUjJ3ulNnvb6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753819143; c=relaxed/simple;
	bh=KcMYApQWSNTL8tJxFGTrhz17sLTevb7X75VzGArm0Ks=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=stKBzy+vsCcoDm9x5BZQ1hl9ZQlAP1OCmyb/4dSSPjAhJeyM/FFTM3PURilXGZFKoPnZynD0erMCn58pq+lpEDHYpZF/YGApM0TF0+cq6/upcPRgw7u65CKTwfQE3nsr0TeV8ikbcOlt/Y89LB9MC4tcPMaKI1N/eUCLCgF3XvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gteGIVBt; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753819142; x=1785355142;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KcMYApQWSNTL8tJxFGTrhz17sLTevb7X75VzGArm0Ks=;
  b=gteGIVBtontIw7DILicDV9h4lRRZrYCdTF2H0FOGMWunFB2M9b9xPXKa
   +Qeh+qIza0kxi43TkgN9Nxxak0eseT1HMCQch6kQvMTyY+AIdF2OHHmRz
   Sl3uSuv/P5q606LoSgfOI4E7VWVB6SugAa3vFIU3TSixPiIuaPrg4wBA7
   wAM2bDTrxYvezn8fhHNWCcgBbXTBROh1+Bnw14QveVbsEEZRTP9kZiJyP
   MewRqjA4IucWO4ke7QiU/4aeGcLerYzyM975b35JldSK3MuMHRVmhPwCk
   Giz9wN8+NNV1ld7FMerI6HDkSq0eD58y3AsvILmwOxTeVq6og+FDCHAAM
   Q==;
X-CSE-ConnectionGUID: csjBxGUyQz+30oAW2FtIxg==
X-CSE-MsgGUID: RBYg1sdvRRmUcUsgw5nB9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="56196749"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="56196749"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 12:59:01 -0700
X-CSE-ConnectionGUID: l9tWxMKdSveXoNgoJw6wPQ==
X-CSE-MsgGUID: r+TFy2E6SP2VYKp3EVcRGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="193788499"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 29 Jul 2025 12:59:00 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ugqTR-0001dI-3B;
	Tue, 29 Jul 2025 19:58:57 +0000
Date: Wed, 30 Jul 2025 03:58:54 +0800
From: kernel test robot <lkp@intel.com>
To: Mel Gorman <mgorman@suse.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: fs/fat/dir.o: warning: objtool: fat_ioctl_filldir+0x869: stack state
 mismatch: cfa1=4+176 cfa2=4+72
Message-ID: <202507300334.WKKs5Yfe-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0919a5b3b11c699d23bc528df5709f2e3213f6a9
commit: 496d2d23886436f7c651bf4c14950eb002815c61 mm: security: Check early if HARDENED_USERCOPY is enabled
date:   5 months ago
config: x86_64-buildonly-randconfig-002-20250730 (https://download.01.org/0day-ci/archive/20250730/202507300334.WKKs5Yfe-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250730/202507300334.WKKs5Yfe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507300334.WKKs5Yfe-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/fat/dir.o: warning: objtool: fat_ioctl_filldir+0x869: stack state mismatch: cfa1=4+176 cfa2=4+72

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


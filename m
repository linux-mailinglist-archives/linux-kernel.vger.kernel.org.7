Return-Path: <linux-kernel+bounces-786056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E276B35475
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 08:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECA65189D551
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 06:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4828122D9F7;
	Tue, 26 Aug 2025 06:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dXcEwi3M"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB37A2D3A85
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 06:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756189330; cv=none; b=Qd84V89oD61WeakOlu86VmjNhO1XxGgUg5E9AWtDp0Q1RyzPTx0dscqzuajANwQGQvatRSl8rpsqCTJIQMhQ/nc8BtBKtVlgjhwQsyyd0WxwgQEuC1buJ4xaS5m/7Hzy2dNIyT0qYDZADbK1Fv1Y1bTScdHYgkrAPSn5wImEE/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756189330; c=relaxed/simple;
	bh=WIkrtdS1ePL5EjIsVFkHuIECav+eA7qet9EbbGLjH+k=;
	h=Date:From:To:Cc:Subject:Message-ID; b=TaVhczIAz/w+G8q5lfGYvoOr7Ic2mnWtxMZcrF9t5nQiS+HtCn7MSivXV0okRSevALvqvxt3BqIJZIYN2RbnatgxXkE99BmosXhqJqJiETeSKP1Yc7O55Gk3HorRnQl5ZgQO5/3PRYjArnxlpu7vHulF0QTgTmE4mSSFlIROgdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dXcEwi3M; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756189329; x=1787725329;
  h=date:from:to:cc:subject:message-id;
  bh=WIkrtdS1ePL5EjIsVFkHuIECav+eA7qet9EbbGLjH+k=;
  b=dXcEwi3MXS6ceEMbRLexLlSJJbVCZT5V8UVJC7B5IHPoj+Cno+nGGNhV
   1ZMbTfI57qDkg5iR11TQSc8CJsEltCBxtWFiKzTvwLGjFiVqDOGpYyWf+
   PvlvlqKh5fM86sIzF1Ancf7aod/XRM7h92KJ8I6Ym17OjaIC5aUU5DhZy
   nm11cLoIBlXzcK/kwja6ITEdOJjHQ+OfOZ4/9qywAXrsHNqEorHtRhAc+
   5F3ZL1cj05WXSzjdpHZ1TLxKIZsPEKy/43ZfAvgr/QkOAdSqTl1qN/c93
   OXrph5HA1Nv4qF2FahavKpAB51uXfa4CpGSy2NWIUvlomm8lzFn+dlMxO
   Q==;
X-CSE-ConnectionGUID: pjONnbLIQdOMt2rhprZ2kA==
X-CSE-MsgGUID: V45E5U1yQXCS6IAtVMC1YA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62244214"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62244214"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 23:22:09 -0700
X-CSE-ConnectionGUID: h5fEwZLSRXKwgueqqe3Org==
X-CSE-MsgGUID: Z7TyeA9yT2asQ/tP7IHurg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169422068"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 25 Aug 2025 23:22:07 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uqn4H-000OGd-1X;
	Tue, 26 Aug 2025 06:22:05 +0000
Date: Tue, 26 Aug 2025 14:21:58 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 24963ae1b0b6596dc36e352c18593800056251d8
Message-ID: <202508261444.k73xZX2l-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 24963ae1b0b6596dc36e352c18593800056251d8  x86/cpu/intel: Fix the constant_tsc model check for Pentium 4

elapsed time: 847m

configs tested: 20
configs skipped: 119

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                         allmodconfig    gcc-12
i386                          allnoconfig    gcc-12
i386                         allyesconfig    gcc-12
i386    buildonly-randconfig-001-20250826    gcc-12
i386    buildonly-randconfig-002-20250826    gcc-12
i386    buildonly-randconfig-003-20250826    clang-20
i386    buildonly-randconfig-004-20250826    gcc-12
i386    buildonly-randconfig-005-20250826    clang-20
i386    buildonly-randconfig-006-20250826    gcc-12
i386                            defconfig    clang-20
x86_64                        allnoconfig    clang-20
x86_64                       allyesconfig    clang-20
x86_64  buildonly-randconfig-001-20250826    clang-20
x86_64  buildonly-randconfig-002-20250826    clang-20
x86_64  buildonly-randconfig-003-20250826    gcc-12
x86_64  buildonly-randconfig-004-20250826    clang-20
x86_64  buildonly-randconfig-005-20250826    gcc-12
x86_64  buildonly-randconfig-006-20250826    gcc-12
x86_64                          defconfig    gcc-11
x86_64                      rhel-9.4-rust    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


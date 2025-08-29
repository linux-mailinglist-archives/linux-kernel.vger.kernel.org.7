Return-Path: <linux-kernel+bounces-792462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC28CB3C440
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 23:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F77DA083DE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 21:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03502BEC4A;
	Fri, 29 Aug 2025 21:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ca9GnM8M"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF33E29D291
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 21:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756502864; cv=none; b=iOqScvCLLgkPGNzol3snLNEMBL0gM6jd9Jl4gKb1NZPVbqO0/1GhRq4rg0YSl3OTTScr81OGQoyWIwRyteBWnuMXtc0o+ucLbRtlRWBb5JRj0UCp9LHDrQccF8BseTnwZk3RQOWu252eQJJLOpG+pg2Bq7ufT7/AYljsWtbkROo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756502864; c=relaxed/simple;
	bh=YyLsD8tbVmmQl8rOSyIGlld3kXynHmyMNUAcUWKg2+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=m+ETusD9GwTsxK+fn+BFdFxLRonGMPv847zKm22E/gFcWoNlNJkwQa4y7OUA6ih8tr454N9dOAIS8aMkM9kBy9AYgkb/iACdifwJWnpr+RXStq9kQxGjwf8zKWhmPMorcUMYLhka3gV2DMPY5PdAQ5Jtx/dD9ecbaaZicD15/K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ca9GnM8M; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756502863; x=1788038863;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YyLsD8tbVmmQl8rOSyIGlld3kXynHmyMNUAcUWKg2+Q=;
  b=Ca9GnM8M8LlhLZXKR1CSWKxJ1bLg7IP3ml4t0FoEAVpQL7cFkdiU9LsS
   ldete7w8p2IhjEh4MdFcCRv/5m7CDWA5HGOyMKqt4r5FBg3zChTBTrei8
   bwFB7FIy10n6bRcHjgFyuhpBEI8I/FAKkb5jxncVVqqYTZWDJrpjvCNB8
   nLyjupE9SVMad9NZxRKq/PR27+4cc1i6rLshRrBzPQbohGv12lReOPtTg
   fr5YiIggCheGFHK74VVHOi0KsZvymfAS5wKPIuA/1FQI1CtG6J1R5MSRC
   038jw5zngctLCE1DSwgADYqlxsWjPjBgmtcHsf3Ozot86LAzdHW9wZG2T
   A==;
X-CSE-ConnectionGUID: 4FKLInCNSZ+FT8gYu6aURA==
X-CSE-MsgGUID: Vy5K74qRQmKHpt4ubS2v4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11537"; a="58945964"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="58945964"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 14:27:43 -0700
X-CSE-ConnectionGUID: w7+YqGwTQ/SXLTbA/wvX+Q==
X-CSE-MsgGUID: EVcalZyGQxKw/1zCx84YxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="194143290"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 29 Aug 2025 14:27:41 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1us6dB-000UzT-1o;
	Fri, 29 Aug 2025 21:27:36 +0000
Date: Sat, 30 Aug 2025 05:26:51 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>
Subject: kismet: WARNING: unmet direct dependencies detected for
 DRM_DISPLAY_DSC_HELPER when selected by DRM_PANEL_SAMSUNG_S6E3HA8
Message-ID: <202508300556.9Mu5ETXB-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fb679c832b6497f19fffb8274c419783909c0912
commit: fd3b2c5f40a1e028bc813284260d430257444334 drm/panel: s6e3ha8: select CONFIG_DRM_DISPLAY_DSC_HELPER
date:   11 months ago
config: x86_64-kismet-CONFIG_DRM_DISPLAY_DSC_HELPER-CONFIG_DRM_PANEL_SAMSUNG_S6E3HA8-0-0 (https://download.01.org/0day-ci/archive/20250830/202508300556.9Mu5ETXB-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250830/202508300556.9Mu5ETXB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508300556.9Mu5ETXB-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for DRM_DISPLAY_DSC_HELPER when selected by DRM_PANEL_SAMSUNG_S6E3HA8
   WARNING: unmet direct dependencies detected for DRM_DISPLAY_DSC_HELPER
     Depends on [n]: HAS_IOMEM [=y] && DRM [=y] && DRM_DISPLAY_HELPER [=n]
     Selected by [y]:
     - DRM_PANEL_SAMSUNG_S6E3HA8 [=y] && HAS_IOMEM [=y] && DRM [=y] && DRM_PANEL [=y] && OF [=y] && DRM_MIPI_DSI [=y] && BACKLIGHT_CLASS_DEVICE [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-kernel+bounces-810893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC9FB5212F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 21:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FEFB3B1F03
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 19:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3932D949E;
	Wed, 10 Sep 2025 19:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BojGLvm8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE382D8379
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 19:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757532959; cv=none; b=Gxgpnwc7ZT4D0TCWzQMvJFYcWTGrqgQnByKMZGM0v3PTsbQWP5lML7ULw0r5fc/1q/lneQW3S2MnbcYPepn85Si+0sXMIPXaH6Atfj96ur+mWnUDmtTOCx6TJnqxlVsOJ/oYmpOjng1m/d6aUPGTIK4O+cU5a03/MXAl9HHsmRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757532959; c=relaxed/simple;
	bh=glGPFG+CIZ1HcAUwv3tEcuY/Pc94TIJeXpFprv7xWPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UP/qg8j5C/yUxO0o7tmEJWRKE1LDL9ejoPMT+HWxsSg4YS/1XSJEDV9oYG9VAXX5zR/a2oXehdVbWtWey8M/zrnoPhpJPopAVUidly52Girdm735acQ0wfzj+5WBUdRZyUoBgf8EnSiY4PPaMTyubB0XVbCjo9KE9RZxrQ81grE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BojGLvm8; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757532958; x=1789068958;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=glGPFG+CIZ1HcAUwv3tEcuY/Pc94TIJeXpFprv7xWPY=;
  b=BojGLvm8etME5usnLszaH3bsVMjg0pvAzB5NMHZYpJTaNvXA3rOKjyCq
   9GNG73G3rt0wSjyF+CJwohgy5k8JX06aWQoMkAukJQO4YJvP0BwmgFfmF
   SU+t4nJ9siHISSZS/zN/DFT/paDbaoOnYXY4xaiKgO3sXQnquw9+FAX60
   KRTfLS0XrBLA13MXL1zS7bNG9zh3l/puiQAISpYyr5ekirNekYXUXsa63
   b5WKGQ0x5cGMYbLD/wg+WS4beHWV38Np1YMlFgG071QBTB1/Zi18KgEZA
   hUfLhWOEJE9/LOlStcpVGLmLaw5O0CFuTXJcyAjyUst+cvC+guI5jT7Xv
   w==;
X-CSE-ConnectionGUID: DsinPOcyS4yI+2vWa5RVOw==
X-CSE-MsgGUID: VONqqXkYTpi74mCSoXaNUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="47428390"
X-IronPort-AV: E=Sophos;i="6.18,255,1751266800"; 
   d="scan'208";a="47428390"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 12:35:58 -0700
X-CSE-ConnectionGUID: Gotx55P7RVmJn72DnzWJFg==
X-CSE-MsgGUID: QAIlmXqkSd+dhIdGihFtug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,255,1751266800"; 
   d="scan'208";a="177783300"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 10 Sep 2025 12:35:54 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uwQbf-0006Eh-10;
	Wed, 10 Sep 2025 19:35:51 +0000
Date: Thu, 11 Sep 2025 03:35:19 +0800
From: kernel test robot <lkp@intel.com>
To: Mike Looijmans <mike.looijmans@topic.nl>,
	dri-devel@lists.freedesktop.org
Cc: oe-kbuild-all@lists.linux.dev, Mike Looijmans <mike.looijmans@topic.nl>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	David Airlie <airlied@gmail.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] drm: bridge: Add TI tmds181 and sn65dp159 driver
Message-ID: <202509110339.t9spKBAI-lkp@intel.com>
References: <20250908061605.76787-3-mike.looijmans@topic.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908061605.76787-3-mike.looijmans@topic.nl>

Hi Mike,

kernel test robot noticed the following build errors:

[auto build test ERROR on 53e760d8949895390e256e723e7ee46618310361]

url:    https://github.com/intel-lab-lkp/linux/commits/Mike-Looijmans/dt-bindings-drm-bridge-ti-tmds181-Add-TI-TMDS181-and-SN65DP159-bindings/20250908-141752
base:   53e760d8949895390e256e723e7ee46618310361
patch link:    https://lore.kernel.org/r/20250908061605.76787-3-mike.looijmans%40topic.nl
patch subject: [PATCH v5 2/2] drm: bridge: Add TI tmds181 and sn65dp159 driver
config: i386-randconfig-013-20250910 (https://download.01.org/0day-ci/archive/20250911/202509110339.t9spKBAI-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250911/202509110339.t9spKBAI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509110339.t9spKBAI-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/gpu/drm/bridge/ti-tmds181.o: in function `tmds181_mode_valid':
>> drivers/gpu/drm/bridge/ti-tmds181.c:118:(.text+0x2e): undefined reference to `drm_hdmi_compute_mode_clock'


vim +118 drivers/gpu/drm/bridge/ti-tmds181.c

   111	
   112	static enum drm_mode_status
   113	tmds181_mode_valid(struct drm_bridge *bridge, const struct drm_display_info *info,
   114			   const struct drm_display_mode *mode)
   115	{
   116		unsigned long long rate;
   117	
 > 118		rate = drm_hdmi_compute_mode_clock(mode, 8, HDMI_COLORSPACE_RGB);
   119	
   120		/* Minimum clock rate is 25MHz */
   121		if (rate < 25000000)
   122			return MODE_CLOCK_LOW;
   123	
   124		/*
   125		 * When in HDMI 2 mode, the clock is 1/40th of the bitrate. The limit is
   126		 * then the data rate of 6Gbps, which would use a 600MHz pixel clock.
   127		 */
   128		if (rate > 600000000)
   129			return MODE_CLOCK_HIGH;
   130	
   131		return MODE_OK;
   132	}
   133	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-kernel+bounces-731235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70592B0517D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 683EF1AA82D5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 06:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D612D375A;
	Tue, 15 Jul 2025 06:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Smgrtolw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1259C2D29B7;
	Tue, 15 Jul 2025 06:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752559527; cv=none; b=QhX8JctJTVehzvKMnlNqfIdb9J10EicgtCYZlxIMoP3213Q8YyrZex48tD54gmetjgCToiedxyzkNDS3ywMY76sV2ffejGUGBFAm4YV2VXtWzkOPTjE9Rfs5rRCdTGikMig4kwt/lf6CW6HaO78AcTwvwXuSR1SOfsiAKMC9UnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752559527; c=relaxed/simple;
	bh=4s0NpdOUBcdw8nBgpKG7viU5jz793opptwLWmA1YS38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iURRSvr1cQuqHWvY5zd+fAmn+URPmfroA8GizG1J6+h3KVZCnxW+4+kVOatg8wJ8qtJMWBcF/BpL24Go4C20Pm3QKy+Up5XpOMUHLUU8ZOR/XhX2MFeVg6m4EuDxG1WMEiusfVchj1lG+8tXypaYHQXsbvkTO5FK0pswoeuB8+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Smgrtolw; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752559523; x=1784095523;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4s0NpdOUBcdw8nBgpKG7viU5jz793opptwLWmA1YS38=;
  b=Smgrtolw37SLtSTYCv/O9AOa7wezUFzrwRVpj1YWZy5MfaRe4Lw4oWS6
   EULJaabl4rIpWqwsOeuOmGiY+nvHuCQqxI83ZUa4X/dU5K1V++VdTmU2x
   m2vg0INK05BrxYNGaJWGKy+fuNcXT16EDCscKiZ02GbFPeQxe7OUUkF8s
   7pX7yDGl01Rl7UnrPY9DrNzeirwcXOtUqK9bn0gJg++d4OdUpRxwCj42c
   17VVXCkTlngQ+10byfNmvltplXC5kq4bj8vp2T8e7ZUAIIGZvGrICVu3U
   blFX/bQpPvboXszd01SeY5WtORMXYpfKeMGy7P8DXs3jPtARAMF8psTXB
   Q==;
X-CSE-ConnectionGUID: /Y/27tk6RxmneBHS5AAONA==
X-CSE-MsgGUID: Av96FZHuQgO+Ew3oxKr3cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54473567"
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="54473567"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 23:05:22 -0700
X-CSE-ConnectionGUID: PSlCRGZIQQmcUVw1SqSz1w==
X-CSE-MsgGUID: zTaZorvJTBGg1ZWmckAnoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="156778778"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 14 Jul 2025 23:05:19 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ubYmy-0009iV-2o;
	Tue, 15 Jul 2025 06:05:16 +0000
Date: Tue, 15 Jul 2025 14:04:52 +0800
From: kernel test robot <lkp@intel.com>
To: Richard Yao <richard@scandent.com>, dri-devel@lists.freedesktop.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Akshay Athalye <akshay@scandent.com>,
	Richard Yao <richard@scandent.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH 3/3] drm/panel: ilitek-ili9881c: Add Tianxinwei
 TWX700100S0 support
Message-ID: <202507151301.sFo3NzXA-lkp@intel.com>
References: <20250714191729.2416-4-richard@scandent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714191729.2416-4-richard@scandent.com>

Hi Richard,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.16-rc6]
[cannot apply to drm-exynos/exynos-drm-next next-20250714]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Richard-Yao/dt-bindings-vendor-prefixes-Add-Tianxinwei-name/20250715-031929
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250714191729.2416-4-richard%40scandent.com
patch subject: [PATCH 3/3] drm/panel: ilitek-ili9881c: Add Tianxinwei TWX700100S0 support
config: arm-randconfig-001-20250715 (https://download.01.org/0day-ci/archive/20250715/202507151301.sFo3NzXA-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 16534d19bf50bde879a83f0ae62875e2c5120e64)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250715/202507151301.sFo3NzXA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507151301.sFo3NzXA-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/panel/panel-ilitek-ili9881c.c:1850:3: error: field designator 'lanes' does not refer to any field in type 'const struct ili9881c_desc'
    1850 |         .lanes = 4,
         |         ~^~~~~~~~~
   1 error generated.


vim +1850 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c

  1844	
  1845	static const struct ili9881c_desc txw700100s0_desc = {
  1846		.init = txw700100s0_init,
  1847		.init_length = ARRAY_SIZE(txw700100s0_init),
  1848		.mode = &txw700100s0_default_mode,
  1849		.mode_flags = MIPI_DSI_MODE_VIDEO_SYNC_PULSE | MIPI_DSI_MODE_VIDEO,
> 1850		.lanes = 4,
  1851	};
  1852	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


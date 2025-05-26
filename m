Return-Path: <linux-kernel+bounces-663192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0880AC44CA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 May 2025 23:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7808C7AC9D5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 May 2025 21:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D431EDA0F;
	Mon, 26 May 2025 21:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pb2ZPlrv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90B5A32
	for <linux-kernel@vger.kernel.org>; Mon, 26 May 2025 21:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748294812; cv=none; b=beeb5DjILgFq/fZUEgSuvWOuXc+s2a3fP6qFiTK3MpK+vwY+gG1vDQ+pMFm2GJ7wWFQqJsRlEkddZlOwQBerx/6Ba4oX3xQsXDvc294YgZlHrfP5mvdTYClMyYFOP/aTNL8OmlfrWFJlAEVFVm3D/L1bYrzYdVGlTgUdsVCAQBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748294812; c=relaxed/simple;
	bh=izTJpRLc1S6KxFHAdKVD5qbNu8KNoNUHX2UeBgqMpqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnRujhipXnrv5fQgGydRrMZoAdVzcSZ9OxKjtCwOHSLsG6bxgxxpEDAPRZQB5xBpDaCwM01bgauEYVwv204DEJlLS+S3VoUWqrJMSz10XZ35WtWgIu+gzbYMUtLmap5RGDhi3mGJ8cO2zL4tZCH4dyV+cedhXkdCqmSz3lqEDqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pb2ZPlrv; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748294809; x=1779830809;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=izTJpRLc1S6KxFHAdKVD5qbNu8KNoNUHX2UeBgqMpqE=;
  b=Pb2ZPlrvdOTn5F10w78ThVLkItBtIUQsWJtwYLtF30klef7Myk6D2dfN
   3G61xiCldxNwphE2luRtEgoGpfvKoLc5t/fJbU3t31+S6XqwhdYaCFya7
   bEfOLer2wGa7z7WhN24m1uE55uW3Y/y7LzdA6SA391NnxnSP7CZNsr0aR
   S/OiMKALF0vS/irhdj+Pr5Yv6cC+j9oKWXIOXI0tJOJOb9/88ZXYsFxyK
   BM4l9qkZpaX5SQBaQlETlhHbIjKanR723F8qjTkKoOebAmziSL3Ht9mnU
   3v5SVJPyKqh//YEjaf9AiZsk4suBvxavI2RVjuikOdlKMbHtAGlsgjksX
   w==;
X-CSE-ConnectionGUID: rfjmN+WYQruOSsBTcvhMIQ==
X-CSE-MsgGUID: NbCkc/TFQ6ej6vtZwYlEUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="50431280"
X-IronPort-AV: E=Sophos;i="6.15,316,1739865600"; 
   d="scan'208";a="50431280"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 14:26:48 -0700
X-CSE-ConnectionGUID: XPXKgrLUSKS6R22GBHy8aw==
X-CSE-MsgGUID: R5/MVKnTTqKNENq8UMRTPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,316,1739865600"; 
   d="scan'208";a="142526922"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 26 May 2025 14:26:44 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uJfLF-000SiO-2P;
	Mon, 26 May 2025 21:26:41 +0000
Date: Tue, 27 May 2025 05:26:22 +0800
From: kernel test robot <lkp@intel.com>
To: Damon Ding <damon.ding@rock-chips.com>, andrzej.hajda@intel.com,
	neil.armstrong@linaro.org, rfoss@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andy.yan@rock-chips.com,
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	simona@ffwll.ch, dmitry.baryshkov@oss.qualcomm.com,
	l.stach@pengutronix.de, dianders@chromium.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Damon Ding <damon.ding@rock-chips.com>
Subject: Re: [PATCH v1 3/3] drm/bridge: analogix_dp: Apply
 drm_bridge_connector helper
Message-ID: <202505270453.H3muv5WW-lkp@intel.com>
References: <20250526120742.3195812-4-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526120742.3195812-4-damon.ding@rock-chips.com>

Hi Damon,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on next-20250526]
[cannot apply to linus/master v6.15]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Damon-Ding/drm-bridge-analogix_dp-Formalize-the-struct-analogid_dp_device/20250526-201358
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20250526120742.3195812-4-damon.ding%40rock-chips.com
patch subject: [PATCH v1 3/3] drm/bridge: analogix_dp: Apply drm_bridge_connector helper
config: arm64-randconfig-001-20250527 (https://download.01.org/0day-ci/archive/20250527/202505270453.H3muv5WW-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250527/202505270453.H3muv5WW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505270453.H3muv5WW-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/exynos/exynos_dp.c: In function 'exynos_dp_probe':
>> drivers/gpu/drm/exynos/exynos_dp.c:240:16: error: 'struct analogix_dp_plat_data' has no member named 'skip_connector'; did you mean 'connector'?
     dp->plat_data.skip_connector = !!bridge;
                   ^~~~~~~~~~~~~~
                   connector


vim +240 drivers/gpu/drm/exynos/exynos_dp.c

f37cd5e8098441a drivers/gpu/drm/exynos/exynos_dp_core.c Inki Dae                 2014-05-09  194  
f37cd5e8098441a drivers/gpu/drm/exynos/exynos_dp_core.c Inki Dae                 2014-05-09  195  static int exynos_dp_probe(struct platform_device *pdev)
f37cd5e8098441a drivers/gpu/drm/exynos/exynos_dp_core.c Inki Dae                 2014-05-09  196  {
5f1dcd8b7ec8189 drivers/gpu/drm/exynos/exynos_dp_core.c Ajay Kumar               2014-07-31  197  	struct device *dev = &pdev->dev;
ebc9446135671b8 drivers/gpu/drm/exynos/exynos_dp.c      Rob Herring              2017-03-29  198  	struct device_node *np;
5f1dcd8b7ec8189 drivers/gpu/drm/exynos/exynos_dp_core.c Ajay Kumar               2014-07-31  199  	struct exynos_dp_device *dp;
ebc9446135671b8 drivers/gpu/drm/exynos/exynos_dp.c      Rob Herring              2017-03-29  200  	struct drm_panel *panel;
ebc9446135671b8 drivers/gpu/drm/exynos/exynos_dp.c      Rob Herring              2017-03-29  201  	struct drm_bridge *bridge;
ebc9446135671b8 drivers/gpu/drm/exynos/exynos_dp.c      Rob Herring              2017-03-29  202  	int ret;
df5225bc9a87f15 drivers/gpu/drm/exynos/exynos_dp_core.c Inki Dae                 2014-05-29  203  
5f1dcd8b7ec8189 drivers/gpu/drm/exynos/exynos_dp_core.c Ajay Kumar               2014-07-31  204  	dp = devm_kzalloc(&pdev->dev, sizeof(struct exynos_dp_device),
5f1dcd8b7ec8189 drivers/gpu/drm/exynos/exynos_dp_core.c Ajay Kumar               2014-07-31  205  			  GFP_KERNEL);
5f1dcd8b7ec8189 drivers/gpu/drm/exynos/exynos_dp_core.c Ajay Kumar               2014-07-31  206  	if (!dp)
5f1dcd8b7ec8189 drivers/gpu/drm/exynos/exynos_dp_core.c Ajay Kumar               2014-07-31  207  		return -ENOMEM;
5f1dcd8b7ec8189 drivers/gpu/drm/exynos/exynos_dp_core.c Ajay Kumar               2014-07-31  208  
152cce0006abf7e drivers/gpu/drm/exynos/exynos_dp.c      Marek Szyprowski         2020-03-10  209  	dp->dev = dev;
3424e3a4f844c0a drivers/gpu/drm/exynos/exynos_dp_core.c Yakir Yang               2016-03-29  210  	/*
3424e3a4f844c0a drivers/gpu/drm/exynos/exynos_dp_core.c Yakir Yang               2016-03-29  211  	 * We just use the drvdata until driver run into component
3424e3a4f844c0a drivers/gpu/drm/exynos/exynos_dp_core.c Yakir Yang               2016-03-29  212  	 * add function, and then we would set drvdata to null, so
3424e3a4f844c0a drivers/gpu/drm/exynos/exynos_dp_core.c Yakir Yang               2016-03-29  213  	 * that analogix dp driver would take charge of the drvdata.
3424e3a4f844c0a drivers/gpu/drm/exynos/exynos_dp_core.c Yakir Yang               2016-03-29  214  	 */
1df6e5fb79f6141 drivers/gpu/drm/exynos/exynos_dp_core.c Andrzej Hajda            2014-11-17  215  	platform_set_drvdata(pdev, dp);
1df6e5fb79f6141 drivers/gpu/drm/exynos/exynos_dp_core.c Andrzej Hajda            2014-11-17  216  
a9fa852886fd5a7 drivers/gpu/drm/exynos/exynos_dp_core.c Inki Dae                 2015-11-26  217  	/* This is for the backward compatibility. */
37e110625eeeaba drivers/gpu/drm/exynos/exynos_dp_core.c Javier Martinez Canillas 2016-01-29  218  	np = of_parse_phandle(dev->of_node, "panel", 0);
37e110625eeeaba drivers/gpu/drm/exynos/exynos_dp_core.c Javier Martinez Canillas 2016-01-29  219  	if (np) {
3424e3a4f844c0a drivers/gpu/drm/exynos/exynos_dp_core.c Yakir Yang               2016-03-29  220  		dp->plat_data.panel = of_drm_find_panel(np);
5fa8e4a22182df8 drivers/gpu/drm/exynos/exynos_dp.c      Boris Brezillon          2018-05-09  221  
37e110625eeeaba drivers/gpu/drm/exynos/exynos_dp_core.c Javier Martinez Canillas 2016-01-29  222  		of_node_put(np);
5fa8e4a22182df8 drivers/gpu/drm/exynos/exynos_dp.c      Boris Brezillon          2018-05-09  223  		if (IS_ERR(dp->plat_data.panel))
5fa8e4a22182df8 drivers/gpu/drm/exynos/exynos_dp.c      Boris Brezillon          2018-05-09  224  			return PTR_ERR(dp->plat_data.panel);
5fa8e4a22182df8 drivers/gpu/drm/exynos/exynos_dp.c      Boris Brezillon          2018-05-09  225  
37e110625eeeaba drivers/gpu/drm/exynos/exynos_dp_core.c Javier Martinez Canillas 2016-01-29  226  		goto out;
37e110625eeeaba drivers/gpu/drm/exynos/exynos_dp_core.c Javier Martinez Canillas 2016-01-29  227  	}
37e110625eeeaba drivers/gpu/drm/exynos/exynos_dp_core.c Javier Martinez Canillas 2016-01-29  228  
ebc9446135671b8 drivers/gpu/drm/exynos/exynos_dp.c      Rob Herring              2017-03-29  229  	ret = drm_of_find_panel_or_bridge(dev->of_node, 0, 0, &panel, &bridge);
ebc9446135671b8 drivers/gpu/drm/exynos/exynos_dp.c      Rob Herring              2017-03-29  230  	if (ret)
ebc9446135671b8 drivers/gpu/drm/exynos/exynos_dp.c      Rob Herring              2017-03-29  231  		return ret;
ebc9446135671b8 drivers/gpu/drm/exynos/exynos_dp.c      Rob Herring              2017-03-29  232  
37e110625eeeaba drivers/gpu/drm/exynos/exynos_dp_core.c Javier Martinez Canillas 2016-01-29  233  	/* The remote port can be either a panel or a bridge */
ebc9446135671b8 drivers/gpu/drm/exynos/exynos_dp.c      Rob Herring              2017-03-29  234  	dp->plat_data.panel = panel;
152cce0006abf7e drivers/gpu/drm/exynos/exynos_dp.c      Marek Szyprowski         2020-03-10  235  	dp->plat_data.dev_type = EXYNOS_DP;
6d4618ad04e1a14 drivers/gpu/drm/exynos/exynos_dp.c      Lucas Stach              2024-06-19  236  	dp->plat_data.power_on = exynos_dp_poweron;
152cce0006abf7e drivers/gpu/drm/exynos/exynos_dp.c      Marek Szyprowski         2020-03-10  237  	dp->plat_data.power_off = exynos_dp_poweroff;
152cce0006abf7e drivers/gpu/drm/exynos/exynos_dp.c      Marek Szyprowski         2020-03-10  238  	dp->plat_data.attach = exynos_dp_bridge_attach;
152cce0006abf7e drivers/gpu/drm/exynos/exynos_dp.c      Marek Szyprowski         2020-03-10  239  	dp->plat_data.get_modes = exynos_dp_get_modes;
2e9b3e74b4a184f drivers/gpu/drm/exynos/exynos_dp.c      Marek Szyprowski         2018-03-05 @240  	dp->plat_data.skip_connector = !!bridge;
152cce0006abf7e drivers/gpu/drm/exynos/exynos_dp.c      Marek Szyprowski         2020-03-10  241  
ebc9446135671b8 drivers/gpu/drm/exynos/exynos_dp.c      Rob Herring              2017-03-29  242  	dp->ptn_bridge = bridge;
801855671ad1dc7 drivers/gpu/drm/exynos/exynos_dp_core.c Ajay Kumar               2015-01-20  243  
a9fa852886fd5a7 drivers/gpu/drm/exynos/exynos_dp_core.c Inki Dae                 2015-11-26  244  out:
152cce0006abf7e drivers/gpu/drm/exynos/exynos_dp.c      Marek Szyprowski         2020-03-10  245  	dp->adp = analogix_dp_probe(dev, &dp->plat_data);
152cce0006abf7e drivers/gpu/drm/exynos/exynos_dp.c      Marek Szyprowski         2020-03-10  246  	if (IS_ERR(dp->adp))
152cce0006abf7e drivers/gpu/drm/exynos/exynos_dp.c      Marek Szyprowski         2020-03-10  247  		return PTR_ERR(dp->adp);
152cce0006abf7e drivers/gpu/drm/exynos/exynos_dp.c      Marek Szyprowski         2020-03-10  248  
3424e3a4f844c0a drivers/gpu/drm/exynos/exynos_dp_core.c Yakir Yang               2016-03-29  249  	return component_add(&pdev->dev, &exynos_dp_ops);
f37cd5e8098441a drivers/gpu/drm/exynos/exynos_dp_core.c Inki Dae                 2014-05-09  250  }
f37cd5e8098441a drivers/gpu/drm/exynos/exynos_dp_core.c Inki Dae                 2014-05-09  251  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-kernel+bounces-728726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFE0B02C4B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 19:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FCB07AB7D4
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 17:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585F328CF40;
	Sat, 12 Jul 2025 17:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ny+D2KPS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5E028A1CA;
	Sat, 12 Jul 2025 17:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752343032; cv=none; b=SYL3al8YWWXh0auWWKBu4pYrzsAWrsJ8OGRBhnqS0eiEsIXLSlpSraKjpPYl3oPOvGOn+WDALX5ACUVVcB2Ob5xJEpfoUWLCNWmceNI035yuMbeGzYJmL7StPHEheK+kZkofuwz5lgI4OEf7a8JzjeE5amvOV0xmZeU0aTrh8Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752343032; c=relaxed/simple;
	bh=ZqFuhsGBU+wJcNeFRHN2M3/rUmGdy3TQzFSP8z9fkRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IN955rzbgL6NZHklK5o5PX3j5iVG5A1Uh2n79bbQ64LV/lCcxb6tXXeCwdB6ITbS8gFuKNp8Z0/HF1yA1ABcGwMLKZ19HpadcY0PG67NvqeBIXfXyPe2LJq5osdbDVfKK9loC1V9URAb+uR/U1UqTJSKf/M9cffXajd4GpQQvt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ny+D2KPS; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752343031; x=1783879031;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZqFuhsGBU+wJcNeFRHN2M3/rUmGdy3TQzFSP8z9fkRE=;
  b=Ny+D2KPSulgHAFNTsm4bSCqOjVhWY2dvDl2fQq1mCPtJdzOPCYM/wowM
   OhJ/qHbKf1JY+W+pzw2jmcTidApDC4wwAYJpf3s3wm2s7epREx+hqlqd/
   3JqhvOYhZFx5qik/Wr8VHKLcAP7wwsaUunsr5COGCEO3iglq/wZnlV32D
   0X2bmCuIn2KWs1M15KHmsqE1BJcqLlhuukerqsOj8ma6/q7rbNgevSN7w
   xWf/VpZPe3LI7lR07BgJ9rZSZ/6ogKHNFk77sDzdvcuh1fnC8nDhDHinP
   qCvhdvfaofL6WzgxlvOGb8ezvWFRAgwvwyjVd+NRpymg2E51dc0orV6eJ
   w==;
X-CSE-ConnectionGUID: 6T0JOUKmQYmBbnOPcYL9+A==
X-CSE-MsgGUID: MRzfJtuKRuiY6/PR3LM2gA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54570793"
X-IronPort-AV: E=Sophos;i="6.16,306,1744095600"; 
   d="scan'208";a="54570793"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2025 10:57:10 -0700
X-CSE-ConnectionGUID: 9jkPxG5WSLiUICQXlrvIjA==
X-CSE-MsgGUID: dApIRtUfTKCNLasfM3x7ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,306,1744095600"; 
   d="scan'208";a="160938198"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 12 Jul 2025 10:57:07 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uaeTB-0007ZR-0h;
	Sat, 12 Jul 2025 17:57:05 +0000
Date: Sun, 13 Jul 2025 01:56:13 +0800
From: kernel test robot <lkp@intel.com>
To: Troy Mitchell <troy.mitchell@linux.dev>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Heiko Stuebner <heiko@sntech.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Troy Mitchell <troy.mitchell@linux.dev>
Subject: Re: [PATCH] ASoC: rockchip: i2s: simplify clock handling and error
 cleanup in probe
Message-ID: <202507130140.HxI37WQ3-lkp@intel.com>
References: <20250712-rockchip-i2s-simplify-clk-v1-1-3b23fd1b3e26@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250712-rockchip-i2s-simplify-clk-v1-1-3b23fd1b3e26@linux.dev>

Hi Troy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 733923397fd95405a48f165c9b1fbc8c4b0a4681]

url:    https://github.com/intel-lab-lkp/linux/commits/Troy-Mitchell/ASoC-rockchip-i2s-simplify-clock-handling-and-error-cleanup-in-probe/20250712-215647
base:   733923397fd95405a48f165c9b1fbc8c4b0a4681
patch link:    https://lore.kernel.org/r/20250712-rockchip-i2s-simplify-clk-v1-1-3b23fd1b3e26%40linux.dev
patch subject: [PATCH] ASoC: rockchip: i2s: simplify clock handling and error cleanup in probe
config: x86_64-buildonly-randconfig-003-20250712 (https://download.01.org/0day-ci/archive/20250713/202507130140.HxI37WQ3-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250713/202507130140.HxI37WQ3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507130140.HxI37WQ3-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> sound/soc/rockchip/rockchip_i2s.c:776:36: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
     776 |                 return dev_err_probe(&pdev->dev, ret, "Failed to initialise managed register map");
         |                                                  ^~~
   sound/soc/rockchip/rockchip_i2s.c:742:9: note: initialize the variable 'ret' to silence this warning
     742 |         int ret;
         |                ^
         |                 = 0
   1 warning generated.


vim +/ret +776 sound/soc/rockchip/rockchip_i2s.c

   733	
   734	static int rockchip_i2s_probe(struct platform_device *pdev)
   735	{
   736		struct device_node *node = pdev->dev.of_node;
   737		struct rk_i2s_dev *i2s;
   738		struct snd_soc_dai_driver *dai;
   739		struct resource *res;
   740		void __iomem *regs;
   741		struct clk *clk;
   742		int ret;
   743	
   744		i2s = devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
   745		if (!i2s)
   746			return -ENOMEM;
   747	
   748		spin_lock_init(&i2s->lock);
   749		i2s->dev = &pdev->dev;
   750	
   751		i2s->grf = syscon_regmap_lookup_by_phandle(node, "rockchip,grf");
   752		if (!IS_ERR(i2s->grf)) {
   753			i2s->pins = device_get_match_data(&pdev->dev);
   754			if (!i2s->pins)
   755				return -EINVAL;
   756	
   757		}
   758	
   759		/* try to prepare related clocks */
   760		clk = devm_clk_get_enabled(&pdev->dev, "i2s_hclk");
   761		if (IS_ERR(clk))
   762			return dev_err_probe(&pdev->dev, PTR_ERR(clk), "hclock enable failed");
   763	
   764		i2s->mclk = devm_clk_get(&pdev->dev, "i2s_clk");
   765		if (IS_ERR(i2s->mclk))
   766			return dev_err_probe(&pdev->dev, PTR_ERR(i2s->mclk),
   767					     "Can't retrieve i2s master clock");
   768	
   769		regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
   770		if (IS_ERR(regs))
   771			dev_err_probe(&pdev->dev, PTR_ERR(regs), "Can't ioremap registers");
   772	
   773		i2s->regmap = devm_regmap_init_mmio(&pdev->dev, regs,
   774						    &rockchip_i2s_regmap_config);
   775		if (IS_ERR(i2s->regmap))
 > 776			return dev_err_probe(&pdev->dev, ret, "Failed to initialise managed register map");
   777	
   778		i2s->bclk_ratio = 64;
   779		i2s->pinctrl = devm_pinctrl_get(&pdev->dev);
   780		if (!IS_ERR(i2s->pinctrl)) {
   781			i2s->bclk_on = pinctrl_lookup_state(i2s->pinctrl, "bclk_on");
   782			if (!IS_ERR_OR_NULL(i2s->bclk_on)) {
   783				i2s->bclk_off = pinctrl_lookup_state(i2s->pinctrl, "bclk_off");
   784				if (IS_ERR_OR_NULL(i2s->bclk_off))
   785					return dev_err_probe(&pdev->dev, -EINVAL,
   786							     "failed to find i2s bclk_off");
   787			}
   788		} else {
   789			dev_dbg(&pdev->dev, "failed to find i2s pinctrl\n");
   790		}
   791	
   792		i2s_pinctrl_select_bclk_off(i2s);
   793	
   794		dev_set_drvdata(&pdev->dev, i2s);
   795	
   796		pm_runtime_enable(&pdev->dev);
   797		if (!pm_runtime_enabled(&pdev->dev)) {
   798			ret = i2s_runtime_resume(&pdev->dev);
   799			if (ret)
   800				goto err_pm_disable;
   801		}
   802	
   803		ret = rockchip_i2s_init_dai(i2s, res, &dai);
   804		if (ret)
   805			goto err_pm_disable;
   806	
   807		ret = devm_snd_soc_register_component(&pdev->dev,
   808						      &rockchip_i2s_component,
   809						      dai, 1);
   810	
   811		if (ret) {
   812			dev_err(&pdev->dev, "Could not register DAI\n");
   813			goto err_suspend;
   814		}
   815	
   816		ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
   817		if (ret) {
   818			dev_err(&pdev->dev, "Could not register PCM\n");
   819			goto err_suspend;
   820		}
   821	
   822		return 0;
   823	
   824	err_suspend:
   825		if (!pm_runtime_status_suspended(&pdev->dev))
   826			i2s_runtime_suspend(&pdev->dev);
   827	err_pm_disable:
   828		pm_runtime_disable(&pdev->dev);
   829		return ret;
   830	}
   831	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


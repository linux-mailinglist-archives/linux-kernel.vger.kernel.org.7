Return-Path: <linux-kernel+bounces-859274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C481BED325
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 17:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A2933BCD8A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 15:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC8523D7EB;
	Sat, 18 Oct 2025 15:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lSmz/FPs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283BB23CEF9;
	Sat, 18 Oct 2025 15:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760802966; cv=none; b=rwB7BA9+HBMUx3gRUMRlEtJASNVCVLTAOes0OHg+tZcWdTHG/E3ch979qEMCFGm8zcd2XK+oA2oyTgXzsT5prvH8yszfPzlDqdgZ5M5ktioRi8TflZHuOOp3OmC12J/HQpdAjobiduKfIxoTzUjKyaS52UeJQhloywAF85+6cIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760802966; c=relaxed/simple;
	bh=1gVJ8CjsGwA0FTk/Tm3gXx44AUXg3U1s1eJGlpVlkHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/hpauvaNIJ0yJofL6DSPLcZoCKsCR+gZyee2f+8W7k/haKJgb+6WPFWPLYSnO4nHae3bz/GgIVM92X1iWoMXvX0S8rrEIqcz+jJmgsxaX+XgJusxihIZZ7EDvGjtsD8NUkIbON2bFyR3cb/z5uow6jjXLkWmw/NQdnLmSTuj3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lSmz/FPs; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760802961; x=1792338961;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1gVJ8CjsGwA0FTk/Tm3gXx44AUXg3U1s1eJGlpVlkHM=;
  b=lSmz/FPs3OkFsVXcTcvRi3K4Nc5Szi2yGYe8RxvAHCdfIb36+hGUdr5c
   +enJsDQ/7lFqjl0ac9QVfeRUkOrCY/EfmSEUXgJhFszwVjJlDOamF9HCv
   tH9LTN1dzES/IXOF7mRwrKiNtK1WArg4kHTH6OQZv0SpWStDxlZKO+gNx
   QbtxGZnpXbGw8ermIG6fAal6WWcxadpD5rqVvF56lXzAxtF8D1EoRjZCP
   KH+IFmp9Q/3WPjNJBDXStQ1FOaI+O60O+f0rPxkZXLpTMFgBYxf3YaUJ8
   y1+LriXVr0HUAbFp1GuL9y2pdclTTAkZZi7gF/s4FmUlyLY3JIktByjVi
   Q==;
X-CSE-ConnectionGUID: BdqSWhomRXqAUjLWvfbc5Q==
X-CSE-MsgGUID: HwWy5QTgTqWP3R664kslEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="65611004"
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="65611004"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 08:56:01 -0700
X-CSE-ConnectionGUID: I4TNBVbjTM+FEQOJ8MGs+Q==
X-CSE-MsgGUID: IsFoQzfXSWehBMmDnrDCzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="182985402"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 18 Oct 2025 08:55:56 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vA9Hd-0008Nl-1H;
	Sat, 18 Oct 2025 15:55:53 +0000
Date: Sat, 18 Oct 2025 23:55:42 +0800
From: kernel test robot <lkp@intel.com>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>,
	Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v2 3/8] clk: imx: add driver for imx8ulp's sim lpav
Message-ID: <202510182350.57sb54Rm-lkp@intel.com>
References: <20251017112025.11997-4-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017112025.11997-4-laurentiumihalcea111@gmail.com>

Hi Laurentiu,

kernel test robot noticed the following build errors:

[auto build test ERROR on pza/reset/next]
[also build test ERROR on abelvesa/clk/imx abelvesa/for-next linus/master v6.18-rc1 next-20251017]
[cannot apply to pza/imx-drm/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Laurentiu-Mihalcea/reset-imx8mp-audiomix-Fix-bad-mask-values/20251017-192620
base:   https://git.pengutronix.de/git/pza/linux reset/next
patch link:    https://lore.kernel.org/r/20251017112025.11997-4-laurentiumihalcea111%40gmail.com
patch subject: [PATCH v2 3/8] clk: imx: add driver for imx8ulp's sim lpav
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20251018/202510182350.57sb54Rm-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251018/202510182350.57sb54Rm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510182350.57sb54Rm-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/clk/imx/clk-imx8ulp-sim-lpav.c: In function 'clk_imx8ulp_sim_lpav_aux_reset_release':
>> drivers/clk/imx/clk-imx8ulp-sim-lpav.c:52:9: error: implicit declaration of function 'kfree' [-Wimplicit-function-declaration]
      52 |         kfree(adev);
         |         ^~~~~
   drivers/clk/imx/clk-imx8ulp-sim-lpav.c: In function 'clk_imx8ulp_sim_lpav_register_aux_reset':
>> drivers/clk/imx/clk-imx8ulp-sim-lpav.c:65:16: error: cleanup argument not a function
      65 |         struct auxiliary_device *adev __free(kfree) = NULL;
         |                ^~~~~~~~~~~~~~~~
>> drivers/clk/imx/clk-imx8ulp-sim-lpav.c:68:16: error: implicit declaration of function 'kzalloc' [-Wimplicit-function-declaration]
      68 |         adev = kzalloc(sizeof(*adev), GFP_KERNEL);
         |                ^~~~~~~
>> drivers/clk/imx/clk-imx8ulp-sim-lpav.c:68:14: error: assignment to 'struct auxiliary_device *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      68 |         adev = kzalloc(sizeof(*adev), GFP_KERNEL);
         |              ^


vim +/kfree +52 drivers/clk/imx/clk-imx8ulp-sim-lpav.c

    46	
    47	#ifdef CONFIG_RESET_CONTROLLER
    48	static void clk_imx8ulp_sim_lpav_aux_reset_release(struct device *dev)
    49	{
    50		struct auxiliary_device *adev = to_auxiliary_dev(dev);
    51	
  > 52		kfree(adev);
    53	}
    54	
    55	static void clk_imx8ulp_sim_lpav_unregister_aux_reset(void *data)
    56	{
    57		struct auxiliary_device *adev = data;
    58	
    59		auxiliary_device_delete(adev);
    60		auxiliary_device_uninit(adev);
    61	}
    62	
    63	static int clk_imx8ulp_sim_lpav_register_aux_reset(struct platform_device *pdev)
    64	{
  > 65		struct auxiliary_device *adev __free(kfree) = NULL;
    66		int ret;
    67	
  > 68		adev = kzalloc(sizeof(*adev), GFP_KERNEL);
    69		if (!adev)
    70			return -ENOMEM;
    71	
    72		adev->name = "reset";
    73		adev->dev.parent = &pdev->dev;
    74		adev->dev.release = clk_imx8ulp_sim_lpav_aux_reset_release;
    75	
    76		ret = auxiliary_device_init(adev);
    77		if (ret) {
    78			dev_err(&pdev->dev, "failed to initialize aux dev\n");
    79			return ret;
    80		}
    81	
    82		ret = auxiliary_device_add(adev);
    83		if (ret) {
    84			auxiliary_device_uninit(adev);
    85			dev_err(&pdev->dev, "failed to add aux dev\n");
    86			return ret;
    87		}
    88	
    89		return devm_add_action_or_reset(&pdev->dev,
    90						clk_imx8ulp_sim_lpav_unregister_aux_reset,
    91						no_free_ptr(adev));
    92	}
    93	#else
    94	static int clk_imx8ulp_sim_lpav_register_aux_reset(struct platform_device *pdev)
    95	{
    96		return 0;
    97	}
    98	#endif /* CONFIG_RESET_CONTROLLER */
    99	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


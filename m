Return-Path: <linux-kernel+bounces-859161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3326FBECEB1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 13:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E7221A61AC3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 11:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC98224DD00;
	Sat, 18 Oct 2025 11:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cXD+BNUK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9589D354ADF;
	Sat, 18 Oct 2025 11:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760787267; cv=none; b=TGbiYz1lTeNqLbCCpEIq6LPvCATIwcvHfp0IOGyJvMPNZi2skeBx7y0vNHdxVY0NF7yEI1nWlaf+VTlvufWtEaNpVaz6sAeuucO1LJCQLRYx1pjIWOqnu8xKVOsTiiG8ySy0r0huwYOtqJaBN85XWFL574TttoYWG5wiNeFvrSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760787267; c=relaxed/simple;
	bh=lxmXxI9NVNvUFbJkHjVwI4PAcvRKTU8tPXimX86qghE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1dhfoYc2J2VjnfnMWZZaL1YJZfP18k8AFPyTCv8b2SK96vz2jztWKBA3gDS2zXStBnfxBmveMnR6/2ADAKE6KYAkvBt49kzinpZfOwjQmYK8izWbbKLabtE17hbnlJ491faCfAGL6nM8JIVNYiI8y8lsMPUaM7AbLgXNaToJbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cXD+BNUK; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760787266; x=1792323266;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lxmXxI9NVNvUFbJkHjVwI4PAcvRKTU8tPXimX86qghE=;
  b=cXD+BNUK15x2DaVHETizGjZvPMTkYntmBc6Kx7r5yOBVZtqvudKCRrD+
   ZeGcG/SS/EssfXQjB8hYjBmEDDxQHubNhPhz3BP+nrel6YJIRa9q0AwLA
   YuPwg+JheXBkzbkqB9PQZicI/slRoY5iYBOGnE13XOlWj2kIvz1cJDFDl
   cZl/KyAEY70qyTLak3SOVPJqmmDf4QUbNeN0voBku1UKOPEuYUabafMeF
   7yZwWS4XTTr5MxnUjIKNiCkoYGjkqVCNKeo67aWVUkMGJd2LOEtWB8Dlc
   oRwSpPIbQ5pcQtOGZsR7sCSLrX7jHpB5M+l6KYabGdLAmAyCQtxj0BVJd
   Q==;
X-CSE-ConnectionGUID: imIc4URUTK2Nw4UKeVd23A==
X-CSE-MsgGUID: 8HJQArxoT5+YpoH0jt46rA==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="74331305"
X-IronPort-AV: E=Sophos;i="6.19,238,1754982000"; 
   d="scan'208";a="74331305"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 04:34:25 -0700
X-CSE-ConnectionGUID: hItXz9+CR9+morbJD6EyVA==
X-CSE-MsgGUID: MR5JyuycRausU/z8Jyg5Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,238,1754982000"; 
   d="scan'208";a="182491676"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 18 Oct 2025 04:34:20 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vA5CU-0008G9-0M;
	Sat, 18 Oct 2025 11:34:18 +0000
Date: Sat, 18 Oct 2025 19:33:56 +0800
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
Message-ID: <202510181949.IazLEB6V-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on pza/reset/next]
[also build test WARNING on abelvesa/clk/imx abelvesa/for-next linus/master v6.18-rc1 next-20251017]
[cannot apply to pza/imx-drm/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Laurentiu-Mihalcea/reset-imx8mp-audiomix-Fix-bad-mask-values/20251017-192620
base:   https://git.pengutronix.de/git/pza/linux reset/next
patch link:    https://lore.kernel.org/r/20251017112025.11997-4-laurentiumihalcea111%40gmail.com
patch subject: [PATCH v2 3/8] clk: imx: add driver for imx8ulp's sim lpav
config: xtensa-randconfig-r132-20251018 (https://download.01.org/0day-ci/archive/20251018/202510181949.IazLEB6V-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251018/202510181949.IazLEB6V-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510181949.IazLEB6V-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/clk/imx/clk-imx8ulp-sim-lpav.c: In function 'clk_imx8ulp_sim_lpav_aux_reset_release':
   drivers/clk/imx/clk-imx8ulp-sim-lpav.c:52:9: error: implicit declaration of function 'kfree' [-Werror=implicit-function-declaration]
      52 |         kfree(adev);
         |         ^~~~~
   drivers/clk/imx/clk-imx8ulp-sim-lpav.c: In function 'clk_imx8ulp_sim_lpav_register_aux_reset':
   drivers/clk/imx/clk-imx8ulp-sim-lpav.c:65:16: error: cleanup argument not a function
      65 |         struct auxiliary_device *adev __free(kfree) = NULL;
         |                ^~~~~~~~~~~~~~~~
   drivers/clk/imx/clk-imx8ulp-sim-lpav.c:68:16: error: implicit declaration of function 'kzalloc' [-Werror=implicit-function-declaration]
      68 |         adev = kzalloc(sizeof(*adev), GFP_KERNEL);
         |                ^~~~~~~
>> drivers/clk/imx/clk-imx8ulp-sim-lpav.c:68:14: warning: assignment to 'struct auxiliary_device *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      68 |         adev = kzalloc(sizeof(*adev), GFP_KERNEL);
         |              ^
   cc1: some warnings being treated as errors


vim +68 drivers/clk/imx/clk-imx8ulp-sim-lpav.c

    62	
    63	static int clk_imx8ulp_sim_lpav_register_aux_reset(struct platform_device *pdev)
    64	{
    65		struct auxiliary_device *adev __free(kfree) = NULL;
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


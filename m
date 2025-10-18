Return-Path: <linux-kernel+bounces-858998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AF506BEC70F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 06:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3423E352F61
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 04:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C54F28724D;
	Sat, 18 Oct 2025 04:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g3FIrFGk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80E98F6F;
	Sat, 18 Oct 2025 04:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760760938; cv=none; b=InBRFnV0qiNqyil0cXWrfZ+R/0N+IcdSw645P178cqhHRXFjFm8yBuleTpPt+I1aGVm0UoOvQ2rajvu5ZL/kdAwmzyK+b93odlolRr4vpd0OkvUMZK7C3BsecPJ5BMgC74gyn2MgvH1FDfpWHoiDIhAr2CnMDGO//2eebIQROcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760760938; c=relaxed/simple;
	bh=xJ+JsUz4XbcP1v+4FsWXjV6AIbsUH9+FEb2iGeNwyHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9MCgctbDbNUrGKoyWu+EnyZtj5uxR7UF1fA40ybEku0RLjZR0uxaWsFztHlRbaXogqAZ4X0rWqVdpNb/8JlYWhnjZlScmXueNjQvK4lK6Ts67/IDWDdO/V7RpADvaALaWW1pLjSSmqrdySlshUUTSVcXaYVn+htqJnvhIj7IwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g3FIrFGk; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760760937; x=1792296937;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xJ+JsUz4XbcP1v+4FsWXjV6AIbsUH9+FEb2iGeNwyHU=;
  b=g3FIrFGk98QcATYpI8cwSUmIe9plA6sLC3wn4pNX5crEXdi/kqMK9Fxb
   bgq0i9HAMz667uFgvblObzYlruBIpgAEkuruRHbY+YEj64rSWTgAHBTte
   k7bAZu39LzVkdpMbK8r8UMNyZQL92xytaZ8dT5sAL/sB7dEUN+4NJjdi9
   aVEElEDoiBIBowQUvA7s7nqWY6moJD5IO2bnhOP4704OZeI7cHf0wIvTt
   OkpgzRYr59iornyusa9Etjf2l03x5rkTr33DYEAwEjhaLWZHdmuy3clKg
   nAQ/oxGv0LO9ekqvYlgjcKvGVWVSq1hqzVMX5tsIDX1bE39f2HmdkSTTi
   A==;
X-CSE-ConnectionGUID: flR1fEKLShqPXUH8+ak5Mw==
X-CSE-MsgGUID: 8z9AqGCZQiOrRBecBy3/QQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="63122079"
X-IronPort-AV: E=Sophos;i="6.19,238,1754982000"; 
   d="scan'208";a="63122079"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 21:15:36 -0700
X-CSE-ConnectionGUID: vdSs8jYZR0+Zx8hwJkk8DQ==
X-CSE-MsgGUID: AOaCem9pThybXB/LUZKBSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,238,1754982000"; 
   d="scan'208";a="188197059"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 17 Oct 2025 21:15:31 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9yLg-00083H-2m;
	Sat, 18 Oct 2025 04:15:25 +0000
Date: Sat, 18 Oct 2025 12:15:08 +0800
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
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-clk@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v2 3/8] clk: imx: add driver for imx8ulp's sim lpav
Message-ID: <202510181121.D3XVfMFh-lkp@intel.com>
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
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20251018/202510181121.D3XVfMFh-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251018/202510181121.D3XVfMFh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510181121.D3XVfMFh-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/clk/imx/clk-imx8ulp-sim-lpav.c:52:2: error: call to undeclared function 'kfree'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      52 |         kfree(adev);
         |         ^
>> drivers/clk/imx/clk-imx8ulp-sim-lpav.c:65:32: error: use of undeclared identifier '__free_kfree'; did you mean '__free_pages'?
      65 |         struct auxiliary_device *adev __free(kfree) = NULL;
         |                                       ^
   include/linux/cleanup.h:213:33: note: expanded from macro '__free'
     213 | #define __free(_name)   __cleanup(__free_##_name)
         |                                   ^
   <scratch space>:30:1: note: expanded from here
      30 | __free_kfree
         | ^
   include/linux/gfp.h:381:13: note: '__free_pages' declared here
     381 | extern void __free_pages(struct page *page, unsigned int order);
         |             ^
>> drivers/clk/imx/clk-imx8ulp-sim-lpav.c:65:32: error: 'cleanup' function '__free_pages' must take 1 parameter
      65 |         struct auxiliary_device *adev __free(kfree) = NULL;
         |                                       ^
   include/linux/cleanup.h:213:33: note: expanded from macro '__free'
     213 | #define __free(_name)   __cleanup(__free_##_name)
         |                                   ^
   <scratch space>:30:1: note: expanded from here
      30 | __free_kfree
         | ^
>> drivers/clk/imx/clk-imx8ulp-sim-lpav.c:68:9: error: call to undeclared function 'kzalloc'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      68 |         adev = kzalloc(sizeof(*adev), GFP_KERNEL);
         |                ^
>> drivers/clk/imx/clk-imx8ulp-sim-lpav.c:68:7: error: incompatible integer to pointer conversion assigning to 'struct auxiliary_device *' from 'int' [-Wint-conversion]
      68 |         adev = kzalloc(sizeof(*adev), GFP_KERNEL);
         |              ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   5 errors generated.


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


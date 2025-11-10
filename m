Return-Path: <linux-kernel+bounces-894183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7011AC496DF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4CA684ED9F7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 21:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A7133437F;
	Mon, 10 Nov 2025 21:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZiNd8UTX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E0C23BCE4;
	Mon, 10 Nov 2025 21:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762810608; cv=none; b=gA5C0s2vMdGIFnaAnDghs0dYul9dgGbRRhhBmBRUeHMXRJ0uOg8YiiLyRtWfKMmc3rNFZYjB9AJe67Skdt8y8+iqqcNUfmQzC65zY+OpaFMq5kmfUjfMhVT3i78BNyJnD9P79XoEdS4oJXE3mXba5Y3mOpyCHFgQ2muHY8fFc44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762810608; c=relaxed/simple;
	bh=j3UaS4z5achFCd1TKFwVa5PjZGFIfLaLy4y+1hRDMbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGvggiEWp357yrOQgEZjAjQHZ4nTT8alO+f7uKiZj+l4IT8hhr2AK/iyl08mVHzWNb6uVWLq1ymWrMVPIQ4U22z6Zqiq1IN8e1vICeTuriki6O3N3zoKS/nq/Qm0vmcNlVjGGXxngCAxI3G0VorZ7J4Tmk/3XRqLMYQZfjJ77EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZiNd8UTX; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762810607; x=1794346607;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j3UaS4z5achFCd1TKFwVa5PjZGFIfLaLy4y+1hRDMbk=;
  b=ZiNd8UTXOyptlZjkQl2uqEs5Q3aLvnFO8OEi119uWad9m/3VYi3jJ93W
   Qzb/xpIRULoPn0BCTpWnokmxG0YQTYuFK4LMIIsZtqWdrevxMxbswHOhY
   j7JzzViSxe7XIAhEMAZwKNEzGDu+zbHtZZHltHJolKjJBf8XBxIG3OvNM
   rmb5d9JdccyFZ0WE+HoBAEF/GM+ZOw+weplefkZs/aq9exUirIFR3hazJ
   dP5RWtMzzCTdjQTf2qk9p4Cmw8oDSg4mmwpPptkHfQMFlUdut5XTJPVCp
   YF5oNFpT5Ky2Y0rXyf+XJzg3ftzBamyfLSvtFRR8Lf4d/8gMO4EgPjtmB
   g==;
X-CSE-ConnectionGUID: YDzw3sQ7QeWbze4fgDKywQ==
X-CSE-MsgGUID: /jE4LoR0SGOroJhMNcZgxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64781084"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64781084"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 13:36:46 -0800
X-CSE-ConnectionGUID: 6ibS5wYqRdCWoUEPO25vwQ==
X-CSE-MsgGUID: QLfywHYeQhKPTRbzgEs1pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="219494766"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 10 Nov 2025 13:36:42 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vIZZ1-00013B-29;
	Mon, 10 Nov 2025 21:36:39 +0000
Date: Tue, 11 Nov 2025 05:35:58 +0800
From: kernel test robot <lkp@intel.com>
To: caohang@eswincomputing.com, gregkh@linuxfoundation.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, Thinh.Nguyen@synopsys.com,
	p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	Hang Cao <caohang@eswincomputing.com>,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>
Subject: Re: [PATCH v7 2/2] usb: dwc3: eic7700: Add EIC7700 USB driver
Message-ID: <202511110504.qfGuRVHY-lkp@intel.com>
References: <20251110024500.104-1-caohang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110024500.104-1-caohang@eswincomputing.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on usb/usb-next next-20251110]
[cannot apply to usb/usb-linus robh/for-next pza/reset/next pza/imx-drm/next linus/master v6.18-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/caohang-eswincomputing-com/dt-bindings-usb-Add-ESWIN-EIC7700-USB-controller/20251110-104957
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20251110024500.104-1-caohang%40eswincomputing.com
patch subject: [PATCH v7 2/2] usb: dwc3: eic7700: Add EIC7700 USB driver
config: arm-defconfig (https://download.01.org/0day-ci/archive/20251111/202511110504.qfGuRVHY-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 996639d6ebb86ff15a8c99b67f1c2e2117636ae7)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251111/202511110504.qfGuRVHY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511110504.qfGuRVHY-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/usb/dwc3/dwc3-generic-plat.c:132:35: warning: missing terminating '"' character [-Winvalid-pp-token]
     132 |                         return dev_err_probe(dev, ret, "failed to init
         |                                                        ^
>> drivers/usb/dwc3/dwc3-generic-plat.c:132:35: error: expected expression
   drivers/usb/dwc3/dwc3-generic-plat.c:133:21: warning: missing terminating '"' character [-Winvalid-pp-token]
     133 |                                              platform\n");
         |                                                        ^
>> drivers/usb/dwc3/dwc3-generic-plat.c:145:1: error: function definition is not allowed here
     145 | {
         | ^
   drivers/usb/dwc3/dwc3-generic-plat.c:152:1: error: function definition is not allowed here
     152 | {
         | ^
   drivers/usb/dwc3/dwc3-generic-plat.c:167:1: error: function definition is not allowed here
     167 | {
         | ^
   drivers/usb/dwc3/dwc3-generic-plat.c:184:1: error: function definition is not allowed here
     184 | {
         | ^
   drivers/usb/dwc3/dwc3-generic-plat.c:189:1: error: function definition is not allowed here
     189 | {
         | ^
   drivers/usb/dwc3/dwc3-generic-plat.c:194:1: error: function definition is not allowed here
     194 | {
         | ^
>> drivers/usb/dwc3/dwc3-generic-plat.c:199:22: error: use of undeclared identifier 'dwc3_generic_suspend'; did you mean 'pm_generic_suspend'?
     199 |         SYSTEM_SLEEP_PM_OPS(dwc3_generic_suspend, dwc3_generic_resume)
         |                             ^~~~~~~~~~~~~~~~~~~~
         |                             pm_generic_suspend
   include/linux/pm.h:314:26: note: expanded from macro 'SYSTEM_SLEEP_PM_OPS'
     314 |         .suspend = pm_sleep_ptr(suspend_fn), \
         |                                 ^~~~~~~~~~
   include/linux/pm.h:473:65: note: expanded from macro 'pm_sleep_ptr'
     473 | #define pm_sleep_ptr(_ptr) PTR_IF(IS_ENABLED(CONFIG_PM_SLEEP), (_ptr))
         |                                                                 ^~~~
   include/linux/util_macros.h:136:38: note: expanded from macro 'PTR_IF'
     136 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   include/linux/pm.h:840:12: note: 'pm_generic_suspend' declared here
     840 | extern int pm_generic_suspend(struct device *dev);
         |            ^
>> drivers/usb/dwc3/dwc3-generic-plat.c:199:44: error: use of undeclared identifier 'dwc3_generic_resume'; did you mean 'pm_generic_resume'?
     199 |         SYSTEM_SLEEP_PM_OPS(dwc3_generic_suspend, dwc3_generic_resume)
         |                                                   ^~~~~~~~~~~~~~~~~~~
         |                                                   pm_generic_resume
   include/linux/pm.h:315:25: note: expanded from macro 'SYSTEM_SLEEP_PM_OPS'
     315 |         .resume = pm_sleep_ptr(resume_fn), \
         |                                ^~~~~~~~~
   include/linux/pm.h:473:65: note: expanded from macro 'pm_sleep_ptr'
     473 | #define pm_sleep_ptr(_ptr) PTR_IF(IS_ENABLED(CONFIG_PM_SLEEP), (_ptr))
         |                                                                 ^~~~
   include/linux/util_macros.h:136:38: note: expanded from macro 'PTR_IF'
     136 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   include/linux/pm.h:843:12: note: 'pm_generic_resume' declared here
     843 | extern int pm_generic_resume(struct device *dev);
         |            ^
>> drivers/usb/dwc3/dwc3-generic-plat.c:199:22: error: use of undeclared identifier 'dwc3_generic_suspend'; did you mean 'pm_generic_suspend'?
     199 |         SYSTEM_SLEEP_PM_OPS(dwc3_generic_suspend, dwc3_generic_resume)
         |                             ^~~~~~~~~~~~~~~~~~~~
         |                             pm_generic_suspend
   include/linux/pm.h:316:25: note: expanded from macro 'SYSTEM_SLEEP_PM_OPS'
     316 |         .freeze = pm_sleep_ptr(suspend_fn), \
         |                                ^~~~~~~~~~
   include/linux/pm.h:473:65: note: expanded from macro 'pm_sleep_ptr'
     473 | #define pm_sleep_ptr(_ptr) PTR_IF(IS_ENABLED(CONFIG_PM_SLEEP), (_ptr))
         |                                                                 ^~~~
   include/linux/util_macros.h:136:38: note: expanded from macro 'PTR_IF'
     136 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   include/linux/pm.h:840:12: note: 'pm_generic_suspend' declared here
     840 | extern int pm_generic_suspend(struct device *dev);
         |            ^
>> drivers/usb/dwc3/dwc3-generic-plat.c:199:44: error: use of undeclared identifier 'dwc3_generic_resume'; did you mean 'pm_generic_resume'?
     199 |         SYSTEM_SLEEP_PM_OPS(dwc3_generic_suspend, dwc3_generic_resume)
         |                                                   ^~~~~~~~~~~~~~~~~~~
         |                                                   pm_generic_resume
   include/linux/pm.h:317:23: note: expanded from macro 'SYSTEM_SLEEP_PM_OPS'
     317 |         .thaw = pm_sleep_ptr(resume_fn), \
         |                              ^~~~~~~~~
   include/linux/pm.h:473:65: note: expanded from macro 'pm_sleep_ptr'
     473 | #define pm_sleep_ptr(_ptr) PTR_IF(IS_ENABLED(CONFIG_PM_SLEEP), (_ptr))
         |                                                                 ^~~~
   include/linux/util_macros.h:136:38: note: expanded from macro 'PTR_IF'
     136 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   include/linux/pm.h:843:12: note: 'pm_generic_resume' declared here
     843 | extern int pm_generic_resume(struct device *dev);
         |            ^
>> drivers/usb/dwc3/dwc3-generic-plat.c:199:22: error: use of undeclared identifier 'dwc3_generic_suspend'; did you mean 'pm_generic_suspend'?
     199 |         SYSTEM_SLEEP_PM_OPS(dwc3_generic_suspend, dwc3_generic_resume)
         |                             ^~~~~~~~~~~~~~~~~~~~
         |                             pm_generic_suspend
   include/linux/pm.h:318:27: note: expanded from macro 'SYSTEM_SLEEP_PM_OPS'
     318 |         .poweroff = pm_sleep_ptr(suspend_fn), \
         |                                  ^~~~~~~~~~
   include/linux/pm.h:473:65: note: expanded from macro 'pm_sleep_ptr'
     473 | #define pm_sleep_ptr(_ptr) PTR_IF(IS_ENABLED(CONFIG_PM_SLEEP), (_ptr))
         |                                                                 ^~~~
   include/linux/util_macros.h:136:38: note: expanded from macro 'PTR_IF'
     136 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   include/linux/pm.h:840:12: note: 'pm_generic_suspend' declared here
     840 | extern int pm_generic_suspend(struct device *dev);
         |            ^
>> drivers/usb/dwc3/dwc3-generic-plat.c:199:44: error: use of undeclared identifier 'dwc3_generic_resume'; did you mean 'pm_generic_resume'?
     199 |         SYSTEM_SLEEP_PM_OPS(dwc3_generic_suspend, dwc3_generic_resume)
         |                                                   ^~~~~~~~~~~~~~~~~~~
         |                                                   pm_generic_resume
   include/linux/pm.h:319:26: note: expanded from macro 'SYSTEM_SLEEP_PM_OPS'
     319 |         .restore = pm_sleep_ptr(resume_fn),
         |                                 ^~~~~~~~~
   include/linux/pm.h:473:65: note: expanded from macro 'pm_sleep_ptr'
     473 | #define pm_sleep_ptr(_ptr) PTR_IF(IS_ENABLED(CONFIG_PM_SLEEP), (_ptr))
         |                                                                 ^~~~
   include/linux/util_macros.h:136:38: note: expanded from macro 'PTR_IF'
     136 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   include/linux/pm.h:843:12: note: 'pm_generic_resume' declared here
     843 | extern int pm_generic_resume(struct device *dev);
         |            ^
>> drivers/usb/dwc3/dwc3-generic-plat.c:200:17: error: use of undeclared identifier 'dwc3_generic_runtime_suspend'; did you mean 'pm_generic_runtime_suspend'?
     200 |         RUNTIME_PM_OPS(dwc3_generic_runtime_suspend, dwc3_generic_runtime_resume,
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                        pm_generic_runtime_suspend
   include/linux/pm.h:338:21: note: expanded from macro 'RUNTIME_PM_OPS'
     338 |         .runtime_suspend = suspend_fn, \
         |                            ^~~~~~~~~~
   include/linux/pm_runtime.h:68:12: note: 'pm_generic_runtime_suspend' declared here
      68 | extern int pm_generic_runtime_suspend(struct device *dev);
         |            ^
>> drivers/usb/dwc3/dwc3-generic-plat.c:200:47: error: use of undeclared identifier 'dwc3_generic_runtime_resume'; did you mean 'pm_generic_runtime_resume'?
     200 |         RUNTIME_PM_OPS(dwc3_generic_runtime_suspend, dwc3_generic_runtime_resume,
         |                                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                                      pm_generic_runtime_resume
   include/linux/pm.h:339:20: note: expanded from macro 'RUNTIME_PM_OPS'
     339 |         .runtime_resume = resume_fn, \
         |                           ^~~~~~~~~
   include/linux/pm_runtime.h:69:12: note: 'pm_generic_runtime_resume' declared here
      69 | extern int pm_generic_runtime_resume(struct device *dev);
         |            ^
>> drivers/usb/dwc3/dwc3-generic-plat.c:201:10: error: use of undeclared identifier 'dwc3_generic_runtime_idle'; did you mean 'dwc3_runtime_idle'?
     201 |                        dwc3_generic_runtime_idle)
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~~
         |                        dwc3_runtime_idle
   include/linux/pm.h:340:18: note: expanded from macro 'RUNTIME_PM_OPS'
     340 |         .runtime_idle = idle_fn,
         |                         ^~~~~~~
   drivers/usb/dwc3/glue.h:74:5: note: 'dwc3_runtime_idle' declared here
      74 | int dwc3_runtime_idle(struct dwc3 *dwc);
         |     ^
>> drivers/usb/dwc3/dwc3-generic-plat.c:201:10: error: incompatible function pointer types initializing 'int (*)(struct device *)' with an expression of type 'int (struct dwc3 *)' [-Wincompatible-function-pointer-types]
     201 |                        dwc3_generic_runtime_idle)
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/usb/dwc3/dwc3-generic-plat.c:223:13: error: use of undeclared identifier 'dwc3_generic_remove'; did you mean 'dwc3_generic_probe'?
     223 |         .remove         = dwc3_generic_remove,
         |                           ^~~~~~~~~~~~~~~~~~~
         |                           dwc3_generic_probe
   drivers/usb/dwc3/dwc3-generic-plat.c:72:12: note: 'dwc3_generic_probe' declared here
      72 | static int dwc3_generic_probe(struct platform_device *pdev)
         |            ^
>> drivers/usb/dwc3/dwc3-generic-plat.c:223:13: error: incompatible function pointer types initializing 'void (*)(struct platform_device *)' with an expression of type 'int (struct platform_device *)' [-Wincompatible-function-pointer-types]
     223 |         .remove         = dwc3_generic_remove,
         |                           ^~~~~~~~~~~~~~~~~~~
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   2 warnings and 20 errors generated.


vim +132 drivers/usb/dwc3/dwc3-generic-plat.c

    71	
    72	static int dwc3_generic_probe(struct platform_device *pdev)
    73	{
    74		const struct dwc3_generic_config *plat_config;
    75		struct dwc3_probe_data probe_data = {};
    76		struct device *dev = &pdev->dev;
    77		struct dwc3_generic *dwc3g;
    78		struct resource *res;
    79		int ret;
    80	
    81		dwc3g = devm_kzalloc(dev, sizeof(*dwc3g), GFP_KERNEL);
    82		if (!dwc3g)
    83			return -ENOMEM;
    84	
    85		dwc3g->dev = dev;
    86	
    87		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
    88		if (!res) {
    89			dev_err(&pdev->dev, "missing memory resource\n");
    90			return -ENODEV;
    91		}
    92	
    93		dwc3g->resets = devm_reset_control_array_get_optional_exclusive(dev);
    94		if (IS_ERR(dwc3g->resets))
    95			return dev_err_probe(dev, PTR_ERR(dwc3g->resets), "failed to get resets\n");
    96	
    97		ret = reset_control_assert(dwc3g->resets);
    98		if (ret)
    99			return dev_err_probe(dev, ret, "failed to assert resets\n");
   100	
   101		/* Not strict timing, just for safety */
   102		udelay(2);
   103	
   104		ret = reset_control_deassert(dwc3g->resets);
   105		if (ret)
   106			return dev_err_probe(dev, ret, "failed to deassert resets\n");
   107	
   108		ret = devm_add_action_or_reset(dev, dwc3_generic_reset_control_assert, dwc3g->resets);
   109		if (ret)
   110			return ret;
   111	
   112		ret = devm_clk_bulk_get_all_enabled(dwc3g->dev, &dwc3g->clks);
   113		if (ret < 0)
   114			return dev_err_probe(dev, ret, "failed to get clocks\n");
   115	
   116		dwc3g->num_clocks = ret;
   117		dwc3g->dwc.dev = dev;
   118		probe_data.dwc = &dwc3g->dwc;
   119		probe_data.res = res;
   120		probe_data.ignore_clocks_and_resets = true;
   121	
   122		plat_config = of_device_get_match_data(dev);
   123		if (!plat_config) {
   124			probe_data.properties = DWC3_DEFAULT_PROPERTIES;
   125			goto core_probe;
   126		}
   127	
   128		probe_data.properties = plat_config->properties;
   129		if (plat_config->init) {
   130			ret = plat_config->init(dwc3g);
   131			if (ret)
 > 132				return dev_err_probe(dev, ret, "failed to init
   133						     platform\n");
   134		}
   135	
   136	core_probe:
   137		ret = dwc3_core_probe(&probe_data);
   138		if (ret)
   139			return dev_err_probe(dev, ret, "failed to register DWC3 Core\n");
   140	
   141		return 0;
   142	}
   143	
   144	static void dwc3_generic_remove(struct platform_device *pdev)
 > 145	{
   146		struct dwc3 *dwc = platform_get_drvdata(pdev);
   147	
   148		dwc3_core_remove(dwc);
   149	}
   150	
   151	static int dwc3_generic_suspend(struct device *dev)
   152	{
   153		struct dwc3 *dwc = dev_get_drvdata(dev);
   154		struct dwc3_generic *dwc3g = to_dwc3_generic(dwc);
   155		int ret;
   156	
   157		ret = dwc3_pm_suspend(dwc);
   158		if (ret)
   159			return ret;
   160	
   161		clk_bulk_disable_unprepare(dwc3g->num_clocks, dwc3g->clks);
   162	
   163		return 0;
   164	}
   165	
   166	static int dwc3_generic_resume(struct device *dev)
   167	{
   168		struct dwc3 *dwc = dev_get_drvdata(dev);
   169		struct dwc3_generic *dwc3g = to_dwc3_generic(dwc);
   170		int ret;
   171	
   172		ret = clk_bulk_prepare_enable(dwc3g->num_clocks, dwc3g->clks);
   173		if (ret)
   174			return ret;
   175	
   176		ret = dwc3_pm_resume(dwc);
   177		if (ret)
   178			return ret;
   179	
   180		return 0;
   181	}
   182	
   183	static int dwc3_generic_runtime_suspend(struct device *dev)
   184	{
   185		return dwc3_runtime_suspend(dev_get_drvdata(dev));
   186	}
   187	
   188	static int dwc3_generic_runtime_resume(struct device *dev)
   189	{
   190		return dwc3_runtime_resume(dev_get_drvdata(dev));
   191	}
   192	
   193	static int dwc3_generic_runtime_idle(struct device *dev)
   194	{
   195		return dwc3_runtime_idle(dev_get_drvdata(dev));
   196	}
   197	
   198	static const struct dev_pm_ops dwc3_generic_dev_pm_ops = {
 > 199		SYSTEM_SLEEP_PM_OPS(dwc3_generic_suspend, dwc3_generic_resume)
 > 200		RUNTIME_PM_OPS(dwc3_generic_runtime_suspend, dwc3_generic_runtime_resume,
 > 201			       dwc3_generic_runtime_idle)
   202	};
   203	
   204	static const struct dwc3_generic_config fsl_ls1028_dwc3 = {
   205		.properties.gsbuscfg0_reqinfo = 0x2222,
   206	};
   207	
   208	static const struct dwc3_generic_config eic7700_dwc3 =  {
   209		.init = dwc3_eic7700_init,
   210		.properties = DWC3_DEFAULT_PROPERTIES,
   211	};
   212	
   213	static const struct of_device_id dwc3_generic_of_match[] = {
   214		{ .compatible = "spacemit,k1-dwc3", },
   215		{ .compatible = "fsl,ls1028a-dwc3", &fsl_ls1028_dwc3},
   216		{ .compatible = "eswin,eic7700-dwc3", &eic7700_dwc3},
   217		{ /* sentinel */ }
   218	};
   219	MODULE_DEVICE_TABLE(of, dwc3_generic_of_match);
   220	
   221	static struct platform_driver dwc3_generic_driver = {
   222		.probe		= dwc3_generic_probe,
 > 223		.remove		= dwc3_generic_remove,
   224		.driver		= {
   225			.name	= "dwc3-generic-plat",
   226			.of_match_table = dwc3_generic_of_match,
   227			.pm	= pm_ptr(&dwc3_generic_dev_pm_ops),
   228		},
   229	};
   230	module_platform_driver(dwc3_generic_driver);
   231	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


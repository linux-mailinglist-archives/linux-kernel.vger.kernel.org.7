Return-Path: <linux-kernel+bounces-893810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BF5C486B7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F31444E7EEF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165A52E6CD2;
	Mon, 10 Nov 2025 17:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bPmV3FTS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDAA2E427C;
	Mon, 10 Nov 2025 17:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762796903; cv=none; b=DZvOAYgVJrpSV8TMGFgfRTxF/Q3aEyJBqQI0767gWz7dsk/Re7yit6cffDIC6GqqmuFvi8okkpdNhMFmy4vvJ82Z07HPgUG4h4QYvK5ztxstcJTcgY9PKW2nRlXhTu/0atoo+CW89gj3NcXoWmRh7QSge+45ESBZcynijhOlYiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762796903; c=relaxed/simple;
	bh=bys+Rr/XBUQgHXVigHrpttbPULpUxjaJM+HyZMnG/gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ua6PTEPFZFvmqh1LOkEoYrCptovhcMB3MsAUzf1aYpMy0tWmrXNJP5TgOhNV3jOoBve/UNS2PsmhUJdnVme2ijFCQ8RkIiLZhs5s31Jip2jknNC6yO/YTqt92tGuqpoavWLbPgtDHDU+3tzZVFmHUHxeTe1RTvkHnY2UnV7hj/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bPmV3FTS; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762796902; x=1794332902;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bys+Rr/XBUQgHXVigHrpttbPULpUxjaJM+HyZMnG/gQ=;
  b=bPmV3FTSEW0CoJqjMMvuTXSKQDBaiuikDHcdzXAr5WehJuwP020Qc31a
   W6E8nXUkF4AHDYq5KcmdXkWPtTZuRjZdqCgBmQC5RNfEUTsUh3J6al7sd
   o7dTNi7BqnQiU3LXJ4i2LT3WJUHe8kCSPQW/gJLTr//VRpD1+ObJugX8A
   vkDy2HwgqaMwFgEC0VQiAcCu0ZKmjhybeg2t+NmKSGbgBvxDYwqeNZSAe
   pbmZNRHvMSvh6xRp4fS+g64ukaCq4uCxjZkc4/JGLTWc5F01GXLb73jbz
   wk90fGxmAtg1kkAs4aIKd4MlHl4ytIIKGMPq5nCNjSz/pSleLsi7WDJkl
   A==;
X-CSE-ConnectionGUID: W1IupyCCSKmFaCKIJ8y6TQ==
X-CSE-MsgGUID: ZGvAecDEQAKNSiGHu0SIIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="75538378"
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="75538378"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 09:48:21 -0800
X-CSE-ConnectionGUID: /O8GlZwMSK2BgJzo7Rdmrw==
X-CSE-MsgGUID: xzvJOyPpTGC3nzaB+FSESw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="225990433"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 10 Nov 2025 09:48:17 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vIVzz-0000mb-0T;
	Mon, 10 Nov 2025 17:48:15 +0000
Date: Tue, 11 Nov 2025 01:47:18 +0800
From: kernel test robot <lkp@intel.com>
To: caohang@eswincomputing.com, gregkh@linuxfoundation.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, Thinh.Nguyen@synopsys.com,
	p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com,
	Hang Cao <caohang@eswincomputing.com>,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>
Subject: Re: [PATCH v7 2/2] usb: dwc3: eic7700: Add EIC7700 USB driver
Message-ID: <202511110121.BwTv4Fex-lkp@intel.com>
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
config: xtensa-randconfig-r073-20251110 (https://download.01.org/0day-ci/archive/20251111/202511110121.BwTv4Fex-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 13.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251111/202511110121.BwTv4Fex-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511110121.BwTv4Fex-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/usb/dwc3/dwc3-generic-plat.c: In function 'dwc3_generic_probe':
>> drivers/usb/dwc3/dwc3-generic-plat.c:132:56: warning: missing terminating " character
     132 |                         return dev_err_probe(dev, ret, "failed to init
         |                                                        ^
>> drivers/usb/dwc3/dwc3-generic-plat.c:132:56: error: missing terminating " character
     132 |                         return dev_err_probe(dev, ret, "failed to init
         |                                                        ^~~~~~~~~~~~~~~
>> drivers/usb/dwc3/dwc3-generic-plat.c:133:54: error: stray '\' in program
     133 |                                              platform\n");
         |                                                      ^
>> drivers/usb/dwc3/dwc3-generic-plat.c:133:46: error: 'platform' undeclared (first use in this function)
     133 |                                              platform\n");
         |                                              ^~~~~~~~
   drivers/usb/dwc3/dwc3-generic-plat.c:133:46: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/usb/dwc3/dwc3-generic-plat.c:133:54: error: expected ')' before 'n'
     133 |                                              platform\n");
         |                                                      ^~
         |                                                      )
   drivers/usb/dwc3/dwc3-generic-plat.c:132:45: note: to match this '('
     132 |                         return dev_err_probe(dev, ret, "failed to init
         |                                             ^
   drivers/usb/dwc3/dwc3-generic-plat.c:133:56: warning: missing terminating " character
     133 |                                              platform\n");
         |                                                        ^
   drivers/usb/dwc3/dwc3-generic-plat.c:133:56: error: missing terminating " character
     133 |                                              platform\n");
         |                                                        ^~~
>> drivers/usb/dwc3/dwc3-generic-plat.c:133:56: error: expected ';' before '}' token
     133 |                                              platform\n");
         |                                                        ^
         |                                                        ;
     134 |         }
         |         ~                                               


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
 > 133						     platform\n");
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

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


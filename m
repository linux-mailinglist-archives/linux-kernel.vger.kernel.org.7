Return-Path: <linux-kernel+bounces-589715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09649A7C956
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Apr 2025 15:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 040A87A887A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Apr 2025 13:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDED1EF096;
	Sat,  5 Apr 2025 13:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fCCxifuW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729AE1D47A2
	for <linux-kernel@vger.kernel.org>; Sat,  5 Apr 2025 13:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743859646; cv=none; b=a7Sit9fqQxUOqZtmg4+K58v4sOHCh7N2aTBypUzClZp1CV3l3CZ89UVINOsJsqW5vVUu8pkFGXRNbtnDHGfuxYkYeE1VgxQ5ttAS1ALXqFzf7xMT6TuttV6SmFmyOqqo5J5WgoqtOqFFtozRNxhBncGnj4+6pXpYQ/QGyIMWUao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743859646; c=relaxed/simple;
	bh=PhxZXSsULPsD4mO8+edV5H0C2P/rskNqBj+w/eJH1Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VstiI4O+PzZ7ohZcVYVZF9kLJuPdzpXXv2vuDaT8KVYq0psLEEslbSgqYEHWRMlype59/vgEtBfnLQB/YVVYU5EBrww3MnSy1ep1EEI3IpIDhbnUE7QbVZ7YI7yS6Jkh8ae5xwfIfZH6MPK3dJQFSdC2swdrcg0R9Vp1lOsJ9W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fCCxifuW; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743859645; x=1775395645;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PhxZXSsULPsD4mO8+edV5H0C2P/rskNqBj+w/eJH1Ss=;
  b=fCCxifuWKWdahvZ4qotPPCQL2lpUgks98t0yHNYvG6mfsB5teOeks0wz
   trwuCTXUGFe0WrId5KpDYJZKx6DH3N1nxkKJy1iSDpAfrYI1vD7fhoc0G
   xbNcEE5woXnjgmhiFTHoaHanD2EPIBD6zSGwBWjhWr3idoHavoaUu8OFi
   DMO/eyD7/JYcajC4pOpXid/Aqi89Aa9F5Wz/YWzT6F1t9v40REzoG0dDb
   arvQRX6W3lUGucoCSWUm40IsfHrDC3U/8bPSciP0keq6UQBF2xTa//nRn
   5v0Gm57vvhW6iqV2/JDAGzIJ1WK/SOoVDOlSrjqjRVe0g9qO/47XlwVZl
   w==;
X-CSE-ConnectionGUID: CuAW89T1T8+wEYQtOesEUw==
X-CSE-MsgGUID: mADZQEccTmW/MHLJukVLbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11395"; a="45428670"
X-IronPort-AV: E=Sophos;i="6.15,191,1739865600"; 
   d="scan'208";a="45428670"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2025 06:27:24 -0700
X-CSE-ConnectionGUID: 6q9IScSFQve322yI6xyTFg==
X-CSE-MsgGUID: uTkR2OvDRHezxOJrTbFY7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,191,1739865600"; 
   d="scan'208";a="127853495"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 05 Apr 2025 06:27:22 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u13YO-00022q-0Q;
	Sat, 05 Apr 2025 13:27:20 +0000
Date: Sat, 5 Apr 2025 21:26:45 +0800
From: kernel test robot <lkp@intel.com>
To: Jani Nikula <jani.nikula@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: drivers/gpu/drm/imx/ipuv3/imx-ldb.c:658:57: warning: '_sel'
 directive output may be truncated writing 4 bytes into a region of size
 between 3 and 13
Message-ID: <202504052118.HCpNF13P-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jani,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a8662bcd2ff152bfbc751cab20f33053d74d0963
commit: 03ee752f00fd0daa082b43774cfd03a7f9a17385 drm/imx: prefer snprintf over sprintf
date:   1 year, 2 months ago
config: csky-randconfig-r053-20231127 (https://download.01.org/0day-ci/archive/20250405/202504052118.HCpNF13P-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250405/202504052118.HCpNF13P-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504052118.HCpNF13P-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/imx/ipuv3/imx-ldb.c: In function 'imx_ldb_probe':
>> drivers/gpu/drm/imx/ipuv3/imx-ldb.c:658:57: warning: '_sel' directive output may be truncated writing 4 bytes into a region of size between 3 and 13 [-Wformat-truncation=]
     658 |                 snprintf(clkname, sizeof(clkname), "di%d_sel", i);
         |                                                         ^~~~
   drivers/gpu/drm/imx/ipuv3/imx-ldb.c:658:17: note: 'snprintf' output between 8 and 18 bytes into a destination of size 16
     658 |                 snprintf(clkname, sizeof(clkname), "di%d_sel", i);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/_sel +658 drivers/gpu/drm/imx/ipuv3/imx-ldb.c

   617	
   618	static int imx_ldb_probe(struct platform_device *pdev)
   619	{
   620		struct device *dev = &pdev->dev;
   621		struct device_node *np = dev->of_node;
   622		struct device_node *child;
   623		struct imx_ldb *imx_ldb;
   624		int dual;
   625		int ret;
   626		int i;
   627	
   628		imx_ldb = devm_kzalloc(dev, sizeof(*imx_ldb), GFP_KERNEL);
   629		if (!imx_ldb)
   630			return -ENOMEM;
   631	
   632		imx_ldb->regmap = syscon_regmap_lookup_by_phandle(np, "gpr");
   633		if (IS_ERR(imx_ldb->regmap)) {
   634			dev_err(dev, "failed to get parent regmap\n");
   635			return PTR_ERR(imx_ldb->regmap);
   636		}
   637	
   638		/* disable LDB by resetting the control register to POR default */
   639		regmap_write(imx_ldb->regmap, IOMUXC_GPR2, 0);
   640	
   641		imx_ldb->dev = dev;
   642		imx_ldb->lvds_mux = device_get_match_data(dev);
   643	
   644		dual = of_property_read_bool(np, "fsl,dual-channel");
   645		if (dual)
   646			imx_ldb->ldb_ctrl |= LDB_SPLIT_MODE_EN;
   647	
   648		/*
   649		 * There are three different possible clock mux configurations:
   650		 * i.MX53:  ipu1_di0_sel, ipu1_di1_sel
   651		 * i.MX6q:  ipu1_di0_sel, ipu1_di1_sel, ipu2_di0_sel, ipu2_di1_sel
   652		 * i.MX6dl: ipu1_di0_sel, ipu1_di1_sel, lcdif_sel
   653		 * Map them all to di0_sel...di3_sel.
   654		 */
   655		for (i = 0; i < 4; i++) {
   656			char clkname[16];
   657	
 > 658			snprintf(clkname, sizeof(clkname), "di%d_sel", i);
   659			imx_ldb->clk_sel[i] = devm_clk_get(imx_ldb->dev, clkname);
   660			if (IS_ERR(imx_ldb->clk_sel[i])) {
   661				ret = PTR_ERR(imx_ldb->clk_sel[i]);
   662				imx_ldb->clk_sel[i] = NULL;
   663				break;
   664			}
   665	
   666			imx_ldb->clk_parent[i] = clk_get_parent(imx_ldb->clk_sel[i]);
   667		}
   668		if (i == 0)
   669			return ret;
   670	
   671		for_each_child_of_node(np, child) {
   672			struct imx_ldb_channel *channel;
   673			int bus_format;
   674	
   675			ret = of_property_read_u32(child, "reg", &i);
   676			if (ret || i < 0 || i > 1) {
   677				ret = -EINVAL;
   678				goto free_child;
   679			}
   680	
   681			if (!of_device_is_available(child))
   682				continue;
   683	
   684			if (dual && i > 0) {
   685				dev_warn(dev, "dual-channel mode, ignoring second output\n");
   686				continue;
   687			}
   688	
   689			channel = &imx_ldb->channel[i];
   690			channel->ldb = imx_ldb;
   691			channel->chno = i;
   692	
   693			/*
   694			 * The output port is port@4 with an external 4-port mux or
   695			 * port@2 with the internal 2-port mux.
   696			 */
   697			ret = drm_of_find_panel_or_bridge(child,
   698							  imx_ldb->lvds_mux ? 4 : 2, 0,
   699							  &channel->panel, &channel->bridge);
   700			if (ret && ret != -ENODEV)
   701				goto free_child;
   702	
   703			/* panel ddc only if there is no bridge */
   704			if (!channel->bridge) {
   705				ret = imx_ldb_panel_ddc(dev, channel, child);
   706				if (ret)
   707					goto free_child;
   708			}
   709	
   710			bus_format = of_get_bus_format(dev, child);
   711			if (bus_format == -EINVAL) {
   712				/*
   713				 * If no bus format was specified in the device tree,
   714				 * we can still get it from the connected panel later.
   715				 */
   716				if (channel->panel && channel->panel->funcs &&
   717				    channel->panel->funcs->get_modes)
   718					bus_format = 0;
   719			}
   720			if (bus_format < 0) {
   721				dev_err(dev, "could not determine data mapping: %d\n",
   722					bus_format);
   723				ret = bus_format;
   724				goto free_child;
   725			}
   726			channel->bus_format = bus_format;
   727			channel->child = child;
   728		}
   729	
   730		platform_set_drvdata(pdev, imx_ldb);
   731	
   732		return component_add(&pdev->dev, &imx_ldb_ops);
   733	
   734	free_child:
   735		of_node_put(child);
   736		return ret;
   737	}
   738	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


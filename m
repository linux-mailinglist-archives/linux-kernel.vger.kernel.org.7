Return-Path: <linux-kernel+bounces-874180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B10AC15B29
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D689A3A1B67
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EFB340DAD;
	Tue, 28 Oct 2025 16:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="TEko+peQ"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC6C2D5924
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667371; cv=none; b=Dnkb7Xl4z+Chx1ymLdZhBCAqABz/lNOfqcS/7ZWiEM3m3Y8grpadwnYfYLnrPwbQHqynli4HFL5cP7hi2NdQb063YISy2UIgWqnuODE9hAZHAVTdY4UigzVfPsqxNVHM3t1MBv4996Zk1JMXXeQev/MeyEGybyCV7r4K/JILNWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667371; c=relaxed/simple;
	bh=J5RUNexDPZCq42sCBBDVFiFC2JerAad5FdfFrnqItA8=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=hKgYr/s0WXJe9e2U1VyiFFAudoeuXQHuIvvosU/sFKmvMZ0mHq/wGqhn6ezHRnnO/KM5LUTPbZjs5UPRt3TSdEWclbAIikdyvS7SVV6JnWcVFdI18duCaRpy6H3uoRFwi7Bc+kARmc1qEC8fJubon7Nu0hgl1VsBHqfZFVqi+F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=TEko+peQ; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TG/Q2CAKIy9l1Tyc93k2IYAWPO79ssopXnA8eEZgTCY=;
  b=TEko+peQhXmGizVlO28xyU8Npk4hw7sj+8+2loqWa6w4ZDzav3luafK3
   HYmWX4ii3xm713KUrANmFvvf7bXhZVC3J+ZVltxIKIp0Yu2Q9UHTv+B2W
   PIBZEUo9B9R6PgkX8ttMYIcsFcMG0WRZDJQmyGRVuq7aGj1NU5MDLZZHw
   s=;
X-CSE-ConnectionGUID: mAvFePiwRxa7krnE923p3Q==
X-CSE-MsgGUID: 6zI8eq5SRnC5jx/yOjtiSQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.19,261,1754949600"; 
   d="scan'208";a="246552161"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 17:02:40 +0100
Date: Tue, 28 Oct 2025 17:02:40 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Johan Hovold <johan@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
    Neil Armstrong <neil.armstrong@linaro.org>
cc: linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: drivers/phy/ti/phy-omap-usb2.c:442:4-11: WARNING: Consider using
 %pe to print PTR_ERR() (fwd)
Message-ID: <5f43ff47-70d4-8c53-efd3-6effb2e9afcb@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



---------- Forwarded message ----------
Date: Tue, 28 Oct 2025 22:32:58 +0800
From: kernel test robot <lkp@intel.com>
To: oe-kbuild@lists.linux.dev
Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
Subject: drivers/phy/ti/phy-omap-usb2.c:442:4-11: WARNING: Consider using %pe to
     print PTR_ERR()

BCC: lkp@intel.com
CC: oe-kbuild-all@lists.linux.dev
CC: linux-kernel@vger.kernel.org
TO: Johan Hovold <johan@kernel.org>
CC: Vinod Koul <vkoul@kernel.org>
CC: Neil Armstrong <neil.armstrong@linaro.org>

Hi Johan,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fd57572253bc356330dbe5b233c2e1d8426c66fd
commit: 8209b3f79703b8ff09f84a79c46ead0df7260d9f phy: ti: omap-usb2: enable compile testing
date:   3 months ago
:::::: branch date: 21 hours ago
:::::: commit date: 3 months ago
config: sparc64-randconfig-r064-20251028 (https://download.01.org/0day-ci/archive/20251028/202510282255.6lFijMzE-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Julia Lawall <julia.lawall@inria.fr>
| Closes: https://lore.kernel.org/r/202510282255.6lFijMzE-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/phy/ti/phy-omap-usb2.c:442:4-11: WARNING: Consider using %pe to print PTR_ERR()

vim +442 drivers/phy/ti/phy-omap-usb2.c

ad7a7acaedcf45 drivers/phy/ti/phy-omap-usb2.c Roger Quadros          2020-08-24  365
41ac7b3ab7fe1d drivers/usb/phy/omap-usb2.c    Bill Pemberton         2012-11-19  366  static int omap_usb2_probe(struct platform_device *pdev)
657b306a7bdfca drivers/usb/phy/omap-usb2.c    Kishon Vijay Abraham I 2012-09-06  367  {
657b306a7bdfca drivers/usb/phy/omap-usb2.c    Kishon Vijay Abraham I 2012-09-06  368  	struct omap_usb	*phy;
5d93d1e76afbe6 drivers/phy/phy-omap-usb2.c    Kishon Vijay Abraham I 2013-09-27  369  	struct phy *generic_phy;
5d93d1e76afbe6 drivers/phy/phy-omap-usb2.c    Kishon Vijay Abraham I 2013-09-27  370  	struct phy_provider *phy_provider;
478b6c7436c233 drivers/phy/phy-omap-usb2.c    Roger Quadros          2013-10-03  371  	struct usb_otg *otg;
478b6c7436c233 drivers/phy/phy-omap-usb2.c    Roger Quadros          2013-10-03  372  	struct device_node *node = pdev->dev.of_node;
478b6c7436c233 drivers/phy/phy-omap-usb2.c    Roger Quadros          2013-10-03  373  	struct device_node *control_node;
478b6c7436c233 drivers/phy/phy-omap-usb2.c    Roger Quadros          2013-10-03  374  	struct platform_device *control_pdev;
21bf6fc47a1e45 drivers/phy/ti/phy-omap-usb2.c Rob Herring            2023-10-09  375  	const struct usb_phy_data *phy_data;
478b6c7436c233 drivers/phy/phy-omap-usb2.c    Roger Quadros          2013-10-03  376
21bf6fc47a1e45 drivers/phy/ti/phy-omap-usb2.c Rob Herring            2023-10-09  377  	phy_data = device_get_match_data(&pdev->dev);
21bf6fc47a1e45 drivers/phy/ti/phy-omap-usb2.c Rob Herring            2023-10-09  378  	if (!phy_data)
478b6c7436c233 drivers/phy/phy-omap-usb2.c    Roger Quadros          2013-10-03  379  		return -EINVAL;
657b306a7bdfca drivers/usb/phy/omap-usb2.c    Kishon Vijay Abraham I 2012-09-06  380
657b306a7bdfca drivers/usb/phy/omap-usb2.c    Kishon Vijay Abraham I 2012-09-06  381  	phy = devm_kzalloc(&pdev->dev, sizeof(*phy), GFP_KERNEL);
0b68253d9f8d25 drivers/phy/phy-omap-usb2.c    Peter Griffin          2014-08-15  382  	if (!phy)
657b306a7bdfca drivers/usb/phy/omap-usb2.c    Kishon Vijay Abraham I 2012-09-06  383  		return -ENOMEM;
657b306a7bdfca drivers/usb/phy/omap-usb2.c    Kishon Vijay Abraham I 2012-09-06  384
657b306a7bdfca drivers/usb/phy/omap-usb2.c    Kishon Vijay Abraham I 2012-09-06  385  	otg = devm_kzalloc(&pdev->dev, sizeof(*otg), GFP_KERNEL);
0b68253d9f8d25 drivers/phy/phy-omap-usb2.c    Peter Griffin          2014-08-15  386  	if (!otg)
657b306a7bdfca drivers/usb/phy/omap-usb2.c    Kishon Vijay Abraham I 2012-09-06  387  		return -ENOMEM;
657b306a7bdfca drivers/usb/phy/omap-usb2.c    Kishon Vijay Abraham I 2012-09-06  388
657b306a7bdfca drivers/usb/phy/omap-usb2.c    Kishon Vijay Abraham I 2012-09-06  389  	phy->dev		= &pdev->dev;
657b306a7bdfca drivers/usb/phy/omap-usb2.c    Kishon Vijay Abraham I 2012-09-06  390
657b306a7bdfca drivers/usb/phy/omap-usb2.c    Kishon Vijay Abraham I 2012-09-06  391  	phy->phy.dev		= phy->dev;
09a0168de11a4a drivers/phy/phy-omap-usb2.c    George Cherian         2014-03-06  392  	phy->phy.label		= phy_data->label;
657b306a7bdfca drivers/usb/phy/omap-usb2.c    Kishon Vijay Abraham I 2012-09-06  393  	phy->phy.otg		= otg;
c11747f6ce7025 drivers/usb/phy/omap-usb2.c    Kishon Vijay Abraham I 2013-01-25  394  	phy->phy.type		= USB_PHY_TYPE_USB2;
9955a7835bf376 drivers/phy/phy-omap-usb2.c    Kishon Vijay Abraham I 2015-12-21  395  	phy->mask		= phy_data->mask;
9955a7835bf376 drivers/phy/phy-omap-usb2.c    Kishon Vijay Abraham I 2015-12-21  396  	phy->power_on		= phy_data->power_on;
9955a7835bf376 drivers/phy/phy-omap-usb2.c    Kishon Vijay Abraham I 2015-12-21  397  	phy->power_off		= phy_data->power_off;
ad7a7acaedcf45 drivers/phy/ti/phy-omap-usb2.c Roger Quadros          2020-08-24  398  	phy->flags		= phy_data->flags;
ad7a7acaedcf45 drivers/phy/ti/phy-omap-usb2.c Roger Quadros          2020-08-24  399
ad7a7acaedcf45 drivers/phy/ti/phy-omap-usb2.c Roger Quadros          2020-08-24  400  	omap_usb2_init_errata(phy);
657b306a7bdfca drivers/usb/phy/omap-usb2.c    Kishon Vijay Abraham I 2012-09-06  401
79caf207d66994 drivers/phy/ti/phy-omap-usb2.c Chunfeng Yun           2020-11-06  402  	phy->phy_base = devm_platform_ioremap_resource(pdev, 0);
3df9fcd59fd829 drivers/phy/phy-omap-usb2.c    Himangi Saraogi        2014-07-10  403  	if (IS_ERR(phy->phy_base))
3df9fcd59fd829 drivers/phy/phy-omap-usb2.c    Himangi Saraogi        2014-07-10  404  		return PTR_ERR(phy->phy_base);
7e472402ca3082 drivers/phy/phy-omap-usb2.c    Austin Beam            2014-03-06  405
9955a7835bf376 drivers/phy/phy-omap-usb2.c    Kishon Vijay Abraham I 2015-12-21  406  	phy->syscon_phy_power = syscon_regmap_lookup_by_phandle(node,
9955a7835bf376 drivers/phy/phy-omap-usb2.c    Kishon Vijay Abraham I 2015-12-21  407  								"syscon-phy-power");
9955a7835bf376 drivers/phy/phy-omap-usb2.c    Kishon Vijay Abraham I 2015-12-21  408  	if (IS_ERR(phy->syscon_phy_power)) {
9955a7835bf376 drivers/phy/phy-omap-usb2.c    Kishon Vijay Abraham I 2015-12-21  409  		dev_dbg(&pdev->dev,
9955a7835bf376 drivers/phy/phy-omap-usb2.c    Kishon Vijay Abraham I 2015-12-21  410  			"can't get syscon-phy-power, using control device\n");
9955a7835bf376 drivers/phy/phy-omap-usb2.c    Kishon Vijay Abraham I 2015-12-21  411  		phy->syscon_phy_power = NULL;
9955a7835bf376 drivers/phy/phy-omap-usb2.c    Kishon Vijay Abraham I 2015-12-21  412
478b6c7436c233 drivers/phy/phy-omap-usb2.c    Roger Quadros          2013-10-03  413  		control_node = of_parse_phandle(node, "ctrl-module", 0);
478b6c7436c233 drivers/phy/phy-omap-usb2.c    Roger Quadros          2013-10-03  414  		if (!control_node) {
9955a7835bf376 drivers/phy/phy-omap-usb2.c    Kishon Vijay Abraham I 2015-12-21  415  			dev_err(&pdev->dev,
9955a7835bf376 drivers/phy/phy-omap-usb2.c    Kishon Vijay Abraham I 2015-12-21  416  				"Failed to get control device phandle\n");
478b6c7436c233 drivers/phy/phy-omap-usb2.c    Roger Quadros          2013-10-03  417  			return -EINVAL;
657b306a7bdfca drivers/usb/phy/omap-usb2.c    Kishon Vijay Abraham I 2012-09-06  418  		}
657b306a7bdfca drivers/usb/phy/omap-usb2.c    Kishon Vijay Abraham I 2012-09-06  419
478b6c7436c233 drivers/phy/phy-omap-usb2.c    Roger Quadros          2013-10-03  420  		control_pdev = of_find_device_by_node(control_node);
478b6c7436c233 drivers/phy/phy-omap-usb2.c    Roger Quadros          2013-10-03  421  		if (!control_pdev) {
478b6c7436c233 drivers/phy/phy-omap-usb2.c    Roger Quadros          2013-10-03  422  			dev_err(&pdev->dev, "Failed to get control device\n");
478b6c7436c233 drivers/phy/phy-omap-usb2.c    Roger Quadros          2013-10-03  423  			return -EINVAL;
478b6c7436c233 drivers/phy/phy-omap-usb2.c    Roger Quadros          2013-10-03  424  		}
478b6c7436c233 drivers/phy/phy-omap-usb2.c    Roger Quadros          2013-10-03  425  		phy->control_dev = &control_pdev->dev;
9955a7835bf376 drivers/phy/phy-omap-usb2.c    Kishon Vijay Abraham I 2015-12-21  426  	} else {
9955a7835bf376 drivers/phy/phy-omap-usb2.c    Kishon Vijay Abraham I 2015-12-21  427  		if (of_property_read_u32_index(node,
9955a7835bf376 drivers/phy/phy-omap-usb2.c    Kishon Vijay Abraham I 2015-12-21  428  					       "syscon-phy-power", 1,
9955a7835bf376 drivers/phy/phy-omap-usb2.c    Kishon Vijay Abraham I 2015-12-21  429  					       &phy->power_reg)) {
9955a7835bf376 drivers/phy/phy-omap-usb2.c    Kishon Vijay Abraham I 2015-12-21  430  			dev_err(&pdev->dev,
9955a7835bf376 drivers/phy/phy-omap-usb2.c    Kishon Vijay Abraham I 2015-12-21  431  				"couldn't get power reg. offset\n");
9955a7835bf376 drivers/phy/phy-omap-usb2.c    Kishon Vijay Abraham I 2015-12-21  432  			return -EINVAL;
9955a7835bf376 drivers/phy/phy-omap-usb2.c    Kishon Vijay Abraham I 2015-12-21  433  		}
9955a7835bf376 drivers/phy/phy-omap-usb2.c    Kishon Vijay Abraham I 2015-12-21  434  	}
657b306a7bdfca drivers/usb/phy/omap-usb2.c    Kishon Vijay Abraham I 2012-09-06  435
ed31ee7cf1fea2 drivers/phy/ti/phy-omap-usb2.c Roger Quadros          2018-12-05  436  	phy->wkupclk = devm_clk_get(phy->dev, "wkupclk");
ed31ee7cf1fea2 drivers/phy/ti/phy-omap-usb2.c Roger Quadros          2018-12-05  437  	if (IS_ERR(phy->wkupclk)) {
ed31ee7cf1fea2 drivers/phy/ti/phy-omap-usb2.c Roger Quadros          2018-12-05  438  		if (PTR_ERR(phy->wkupclk) == -EPROBE_DEFER)
ed31ee7cf1fea2 drivers/phy/ti/phy-omap-usb2.c Roger Quadros          2018-12-05  439  			return -EPROBE_DEFER;
ed31ee7cf1fea2 drivers/phy/ti/phy-omap-usb2.c Roger Quadros          2018-12-05  440
ed31ee7cf1fea2 drivers/phy/ti/phy-omap-usb2.c Roger Quadros          2018-12-05  441  		dev_warn(&pdev->dev, "unable to get wkupclk %ld, trying old name\n",
ed31ee7cf1fea2 drivers/phy/ti/phy-omap-usb2.c Roger Quadros          2018-12-05 @442  			 PTR_ERR(phy->wkupclk));
ed31ee7cf1fea2 drivers/phy/ti/phy-omap-usb2.c Roger Quadros          2018-12-05  443  		phy->wkupclk = devm_clk_get(phy->dev, "usb_phy_cm_clk32k");
ed31ee7cf1fea2 drivers/phy/ti/phy-omap-usb2.c Roger Quadros          2018-12-05  444
623cb3e22c9d7e drivers/phy/ti/phy-omap-usb2.c Ye Xingchen            2023-03-23  445  		if (IS_ERR(phy->wkupclk))
623cb3e22c9d7e drivers/phy/ti/phy-omap-usb2.c Ye Xingchen            2023-03-23  446  			return dev_err_probe(&pdev->dev, PTR_ERR(phy->wkupclk),
623cb3e22c9d7e drivers/phy/ti/phy-omap-usb2.c Ye Xingchen            2023-03-23  447  					     "unable to get usb_phy_cm_clk32k\n");
8836e29bad3498 drivers/phy/ti/phy-omap-usb2.c Roger Quadros          2020-08-24  448
ed31ee7cf1fea2 drivers/phy/ti/phy-omap-usb2.c Roger Quadros          2018-12-05  449  		dev_warn(&pdev->dev,
ed31ee7cf1fea2 drivers/phy/ti/phy-omap-usb2.c Roger Quadros          2018-12-05  450  			 "found usb_phy_cm_clk32k, please fix DTS\n");
ed31ee7cf1fea2 drivers/phy/ti/phy-omap-usb2.c Roger Quadros          2018-12-05  451  	}
ed31ee7cf1fea2 drivers/phy/ti/phy-omap-usb2.c Roger Quadros          2018-12-05  452
ed31ee7cf1fea2 drivers/phy/ti/phy-omap-usb2.c Roger Quadros          2018-12-05  453  	phy->optclk = devm_clk_get(phy->dev, "refclk");
ed31ee7cf1fea2 drivers/phy/ti/phy-omap-usb2.c Roger Quadros          2018-12-05  454  	if (IS_ERR(phy->optclk)) {
ed31ee7cf1fea2 drivers/phy/ti/phy-omap-usb2.c Roger Quadros          2018-12-05  455  		if (PTR_ERR(phy->optclk) == -EPROBE_DEFER)
ed31ee7cf1fea2 drivers/phy/ti/phy-omap-usb2.c Roger Quadros          2018-12-05  456  			return -EPROBE_DEFER;
ed31ee7cf1fea2 drivers/phy/ti/phy-omap-usb2.c Roger Quadros          2018-12-05  457
ed31ee7cf1fea2 drivers/phy/ti/phy-omap-usb2.c Roger Quadros          2018-12-05  458  		dev_dbg(&pdev->dev, "unable to get refclk, trying old name\n");
ed31ee7cf1fea2 drivers/phy/ti/phy-omap-usb2.c Roger Quadros          2018-12-05  459  		phy->optclk = devm_clk_get(phy->dev, "usb_otg_ss_refclk960m");
ed31ee7cf1fea2 drivers/phy/ti/phy-omap-usb2.c Roger Quadros          2018-12-05  460
ed31ee7cf1fea2 drivers/phy/ti/phy-omap-usb2.c Roger Quadros          2018-12-05  461  		if (IS_ERR(phy->optclk)) {
ed31ee7cf1fea2 drivers/phy/ti/phy-omap-usb2.c Roger Quadros          2018-12-05  462  			if (PTR_ERR(phy->optclk) != -EPROBE_DEFER) {
ed31ee7cf1fea2 drivers/phy/ti/phy-omap-usb2.c Roger Quadros          2018-12-05  463  				dev_dbg(&pdev->dev,
ed31ee7cf1fea2 drivers/phy/ti/phy-omap-usb2.c Roger Quadros          2018-12-05  464  					"unable to get usb_otg_ss_refclk960m\n");
ed31ee7cf1fea2 drivers/phy/ti/phy-omap-usb2.c Roger Quadros          2018-12-05  465  			}
ed31ee7cf1fea2 drivers/phy/ti/phy-omap-usb2.c Roger Quadros          2018-12-05  466  		} else {
ed31ee7cf1fea2 drivers/phy/ti/phy-omap-usb2.c Roger Quadros          2018-12-05  467  			dev_warn(&pdev->dev,
ed31ee7cf1fea2 drivers/phy/ti/phy-omap-usb2.c Roger Quadros          2018-12-05  468  				 "found usb_otg_ss_refclk960m, please fix DTS\n");
ed31ee7cf1fea2 drivers/phy/ti/phy-omap-usb2.c Roger Quadros          2018-12-05  469  		}
ed31ee7cf1fea2 drivers/phy/ti/phy-omap-usb2.c Roger Quadros          2018-12-05  470  	}
ed31ee7cf1fea2 drivers/phy/ti/phy-omap-usb2.c Roger Quadros          2018-12-05  471
657b306a7bdfca drivers/usb/phy/omap-usb2.c    Kishon Vijay Abraham I 2012-09-06  472  	otg->set_host = omap_usb_set_host;
657b306a7bdfca drivers/usb/phy/omap-usb2.c    Kishon Vijay Abraham I 2012-09-06  473  	otg->set_peripheral = omap_usb_set_peripheral;
09a0168de11a4a drivers/phy/phy-omap-usb2.c    George Cherian         2014-03-06  474  	if (phy_data->flags & OMAP_USB2_HAS_SET_VBUS)
657b306a7bdfca drivers/usb/phy/omap-usb2.c    Kishon Vijay Abraham I 2012-09-06  475  		otg->set_vbus = omap_usb_set_vbus;
09a0168de11a4a drivers/phy/phy-omap-usb2.c    George Cherian         2014-03-06  476  	if (phy_data->flags & OMAP_USB2_HAS_START_SRP)
657b306a7bdfca drivers/usb/phy/omap-usb2.c    Kishon Vijay Abraham I 2012-09-06  477  		otg->start_srp = omap_usb_start_srp;
19c1eac2685b62 drivers/phy/phy-omap-usb2.c    Antoine Tenart         2014-10-30  478  	otg->usb_phy = &phy->phy;
657b306a7bdfca drivers/usb/phy/omap-usb2.c    Kishon Vijay Abraham I 2012-09-06  479
5d93d1e76afbe6 drivers/phy/phy-omap-usb2.c    Kishon Vijay Abraham I 2013-09-27  480  	platform_set_drvdata(pdev, phy);
f20531a9aae0c7 drivers/phy/phy-omap-usb2.c    Oussama Ghorbel        2014-11-04  481  	pm_runtime_enable(phy->dev);
5d93d1e76afbe6 drivers/phy/phy-omap-usb2.c    Kishon Vijay Abraham I 2013-09-27  482
dbc98635e0d42f drivers/phy/phy-omap-usb2.c    Heikki Krogerus        2014-11-19  483  	generic_phy = devm_phy_create(phy->dev, NULL, &ops);
f20531a9aae0c7 drivers/phy/phy-omap-usb2.c    Oussama Ghorbel        2014-11-04  484  	if (IS_ERR(generic_phy)) {
f20531a9aae0c7 drivers/phy/phy-omap-usb2.c    Oussama Ghorbel        2014-11-04  485  		pm_runtime_disable(phy->dev);
5d93d1e76afbe6 drivers/phy/phy-omap-usb2.c    Kishon Vijay Abraham I 2013-09-27  486  		return PTR_ERR(generic_phy);
f20531a9aae0c7 drivers/phy/phy-omap-usb2.c    Oussama Ghorbel        2014-11-04  487  	}
5d93d1e76afbe6 drivers/phy/phy-omap-usb2.c    Kishon Vijay Abraham I 2013-09-27  488
5d93d1e76afbe6 drivers/phy/phy-omap-usb2.c    Kishon Vijay Abraham I 2013-09-27  489  	phy_set_drvdata(generic_phy, phy);
86c574e4bc9d84 drivers/phy/phy-omap-usb2.c    Kishon Vijay Abraham I 2015-12-21  490  	omap_usb_power_off(generic_phy);
5d93d1e76afbe6 drivers/phy/phy-omap-usb2.c    Kishon Vijay Abraham I 2013-09-27  491
64fe1891696cde drivers/phy/phy-omap-usb2.c    Kishon Vijay Abraham I 2014-02-17  492  	phy_provider = devm_of_phy_provider_register(phy->dev,
64fe1891696cde drivers/phy/phy-omap-usb2.c    Kishon Vijay Abraham I 2014-02-17  493  						     of_phy_simple_xlate);
eb82a3d846fab0 drivers/phy/phy-omap-usb2.c    Roger Quadros          2014-07-10  494  	if (IS_ERR(phy_provider)) {
eb82a3d846fab0 drivers/phy/phy-omap-usb2.c    Roger Quadros          2014-07-10  495  		pm_runtime_disable(phy->dev);
64fe1891696cde drivers/phy/phy-omap-usb2.c    Kishon Vijay Abraham I 2014-02-17  496  		return PTR_ERR(phy_provider);
eb82a3d846fab0 drivers/phy/phy-omap-usb2.c    Roger Quadros          2014-07-10  497  	}
64fe1891696cde drivers/phy/phy-omap-usb2.c    Kishon Vijay Abraham I 2014-02-17  498
c11747f6ce7025 drivers/usb/phy/omap-usb2.c    Kishon Vijay Abraham I 2013-01-25  499  	usb_add_phy_dev(&phy->phy);
657b306a7bdfca drivers/usb/phy/omap-usb2.c    Kishon Vijay Abraham I 2012-09-06  500
657b306a7bdfca drivers/usb/phy/omap-usb2.c    Kishon Vijay Abraham I 2012-09-06  501  	return 0;
657b306a7bdfca drivers/usb/phy/omap-usb2.c    Kishon Vijay Abraham I 2012-09-06  502  }
657b306a7bdfca drivers/usb/phy/omap-usb2.c    Kishon Vijay Abraham I 2012-09-06  503

:::::: The code at line 442 was first introduced by commit
:::::: ed31ee7cf1fea2463d9600ac91ed74691b88131f phy: ti: usb2: Fix logic on -EPROBE_DEFER

:::::: TO: Roger Quadros <rogerq@ti.com>
:::::: CC: Kishon Vijay Abraham I <kishon@ti.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


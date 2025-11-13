Return-Path: <linux-kernel+bounces-898670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8216DC55B3C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 05:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A4304E29A1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAA2302148;
	Thu, 13 Nov 2025 04:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eTHB3NeI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F8D25D208
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 04:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763009485; cv=none; b=kXEbvE2BDcc4ZnWiGw68G2CzOeOz0EIc1yMZE1yhlxXxOVV57S8ZbE7Nz45ra3+l5smFa/vzeigzeDqnQd3XLEprvbQ0f1mVNID+tuZXkcBoYlp+3TnH4ipbbqlgRPL/slVuMTcFlV/0MCzpYPTH29WWEPiQMkivEZy1K5KEImU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763009485; c=relaxed/simple;
	bh=tOH/iWFjVDnRGMjWinR2Rk8p2CaTHQaMxLjh7tNkjP4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dnGVe67YCo5atfVgXmsWfbWanjWLCo883YpyVkrdtTf2oAeMWdC4NxATV+Jr/r8rV1Bv+PJQ0M74fu5+ulIpzmu07+G3tSKXzpbUWeNUCqG2sYXYRvWaA4gjviK7xqKoZeAfIW/ozOoPIXEnATNVkFRbif8aTA+GuRBDURZRHfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eTHB3NeI; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763009483; x=1794545483;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tOH/iWFjVDnRGMjWinR2Rk8p2CaTHQaMxLjh7tNkjP4=;
  b=eTHB3NeIQaq4eE8YCQeMJyjqIpqIp0w7JzIWJe5uSthiooKcf5I+x5+F
   338P+FzXy0WMfld3C7+oU8V4BYf1phdOD9lp5DtQhj5D/tIPFBp/ZBbUY
   gsWKjk3v/WhkL0iOH8BhjQJ9fAi5c7kGu9bRZLlpEkXhpl5GkBhDLGiil
   w1ESSw5L1zRl5dJ/6LtijfVrFNKOF8uTB29bxfT9FYV5lhYmrxQ2r3KRL
   Kd6J9HZqhakyneCTp/IDm7guKt23RrqiMCKzUAzMuN9zvzzpnNypGf6Ld
   wK1zKGP9hLku1Pr3ivgmzRQRZ9A5uwKGV90Ooz3ZIcSlv4tkyiRqNK/TH
   Q==;
X-CSE-ConnectionGUID: bPe/rclaRByIBELQdrHzvw==
X-CSE-MsgGUID: HNQI2dUiRwiGLQPcAub4Ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65008603"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="65008603"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 20:51:23 -0800
X-CSE-ConnectionGUID: jLvpPSk9TjGR3+Zma8mmag==
X-CSE-MsgGUID: Em1RhRYjTTSdPFNKYgLJuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="194586218"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 12 Nov 2025 20:51:22 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vJPIl-0004tZ-0V;
	Thu, 13 Nov 2025 04:51:19 +0000
Date: Thu, 13 Nov 2025 12:51:03 +0800
From: kernel test robot <lkp@intel.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: drivers/ufs/host/ufs-rockchip.c:168:19: error: implicit declaration
 of function 'devm_gpiod_get'; did you mean 'em_pd_get'?
Message-ID: <202511130238.LlA0MKxW-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   24172e0d79900908cf5ebf366600616d29c9b417
commit: d3cbe455d6eb600dee27bf5294f6fe8c2bb06b5f scsi: ufs: rockchip: Initial support for UFS
date:   9 months ago
config: sparc-randconfig-001-20251113 (https://download.01.org/0day-ci/archive/20251113/202511130238.LlA0MKxW-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251113/202511130238.LlA0MKxW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511130238.LlA0MKxW-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/ufs/host/ufs-rockchip.c: In function 'ufs_rockchip_common_init':
>> drivers/ufs/host/ufs-rockchip.c:168:19: error: implicit declaration of function 'devm_gpiod_get'; did you mean 'em_pd_get'? [-Werror=implicit-function-declaration]
     host->rst_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
                      ^~~~~~~~~~~~~~
                      em_pd_get
>> drivers/ufs/host/ufs-rockchip.c:168:48: error: 'GPIOD_OUT_LOW' undeclared (first use in this function); did you mean 'GPIOF_OUT_INIT_LOW'?
     host->rst_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
                                                   ^~~~~~~~~~~~~
                                                   GPIOF_OUT_INIT_LOW
   drivers/ufs/host/ufs-rockchip.c:168:48: note: each undeclared identifier is reported only once for each function it appears in
   drivers/ufs/host/ufs-rockchip.c: In function 'ufs_rockchip_device_reset':
>> drivers/ufs/host/ufs-rockchip.c:214:2: error: implicit declaration of function 'gpiod_set_value_cansleep'; did you mean 'gpio_set_value_cansleep'? [-Werror=implicit-function-declaration]
     gpiod_set_value_cansleep(host->rst_gpio, 1);
     ^~~~~~~~~~~~~~~~~~~~~~~~
     gpio_set_value_cansleep
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for LEDS_EXPRESSWIRE
   Depends on [n]: GPIOLIB [=n] || NEW_LEDS [=n] && GPIOLIB [=n]
   Selected by [y]:
   - BACKLIGHT_KTD2801 [=y] && HAS_IOMEM [=y] && BACKLIGHT_CLASS_DEVICE [=y]


vim +168 drivers/ufs/host/ufs-rockchip.c

   127	
   128	static int ufs_rockchip_common_init(struct ufs_hba *hba)
   129	{
   130		struct device *dev = hba->dev;
   131		struct platform_device *pdev = to_platform_device(dev);
   132		struct ufs_rockchip_host *host;
   133		int err;
   134	
   135		host = devm_kzalloc(dev, sizeof(*host), GFP_KERNEL);
   136		if (!host)
   137			return -ENOMEM;
   138	
   139		host->ufs_sys_ctrl = devm_platform_ioremap_resource_byname(pdev, "hci_grf");
   140		if (IS_ERR(host->ufs_sys_ctrl))
   141			return dev_err_probe(dev, PTR_ERR(host->ufs_sys_ctrl),
   142					"Failed to map HCI system control registers\n");
   143	
   144		host->ufs_phy_ctrl = devm_platform_ioremap_resource_byname(pdev, "mphy_grf");
   145		if (IS_ERR(host->ufs_phy_ctrl))
   146			return dev_err_probe(dev, PTR_ERR(host->ufs_phy_ctrl),
   147					"Failed to map mphy system control registers\n");
   148	
   149		host->mphy_base = devm_platform_ioremap_resource_byname(pdev, "mphy");
   150		if (IS_ERR(host->mphy_base))
   151			return dev_err_probe(dev, PTR_ERR(host->mphy_base),
   152					"Failed to map mphy base registers\n");
   153	
   154		host->rst = devm_reset_control_array_get_exclusive(dev);
   155		if (IS_ERR(host->rst))
   156			return dev_err_probe(dev, PTR_ERR(host->rst),
   157					"failed to get reset control\n");
   158	
   159		reset_control_assert(host->rst);
   160		udelay(1);
   161		reset_control_deassert(host->rst);
   162	
   163		host->ref_out_clk = devm_clk_get_enabled(dev, "ref_out");
   164		if (IS_ERR(host->ref_out_clk))
   165			return dev_err_probe(dev, PTR_ERR(host->ref_out_clk),
   166					"ref_out clock unavailable\n");
   167	
 > 168		host->rst_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
   169		if (IS_ERR(host->rst_gpio))
   170			return dev_err_probe(dev, PTR_ERR(host->rst_gpio),
   171					"failed to get reset gpio\n");
   172	
   173		err = devm_clk_bulk_get_all_enabled(dev, &host->clks);
   174		if (err)
   175			return dev_err_probe(dev, err, "failed to enable clocks\n");
   176	
   177		host->hba = hba;
   178	
   179		ufshcd_set_variant(hba, host);
   180	
   181		return 0;
   182	}
   183	
   184	static int ufs_rockchip_rk3576_init(struct ufs_hba *hba)
   185	{
   186		struct device *dev = hba->dev;
   187		int ret;
   188	
   189		hba->quirks = UFSHCD_QUIRK_SKIP_DEF_UNIPRO_TIMEOUT_SETTING;
   190	
   191		/* Enable BKOPS when suspend */
   192		hba->caps |= UFSHCD_CAP_AUTO_BKOPS_SUSPEND;
   193		/* Enable putting device into deep sleep */
   194		hba->caps |= UFSHCD_CAP_DEEPSLEEP;
   195		/* Enable devfreq of UFS */
   196		hba->caps |= UFSHCD_CAP_CLK_SCALING;
   197		/* Enable WriteBooster */
   198		hba->caps |= UFSHCD_CAP_WB_EN;
   199	
   200		/* Set the default desired pm level in case no users set via sysfs */
   201		ufs_rockchip_set_pm_lvl(hba);
   202	
   203		ret = ufs_rockchip_common_init(hba);
   204		if (ret)
   205			return dev_err_probe(dev, ret, "ufs common init fail\n");
   206	
   207		return 0;
   208	}
   209	
   210	static int ufs_rockchip_device_reset(struct ufs_hba *hba)
   211	{
   212		struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
   213	
 > 214		gpiod_set_value_cansleep(host->rst_gpio, 1);
   215		usleep_range(20, 25);
   216	
   217		gpiod_set_value_cansleep(host->rst_gpio, 0);
   218		usleep_range(20, 25);
   219	
   220		return 0;
   221	}
   222	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


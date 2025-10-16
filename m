Return-Path: <linux-kernel+bounces-856380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D46D1BE406F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF21548918
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9743451B4;
	Thu, 16 Oct 2025 14:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OZWclaO/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4F8346A01
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626147; cv=none; b=iCCMPgL9WRcWmp97qfawRvzcc/KurF5LNlITaORZP6azZ35XRUyD6PFa2f7VFbcDr2i0NXNbUUocxrEGOTCPXbB2v9WKaYp9QYF9rhPHhHjpTXfGssI+kxrfMX7qu3euP7E2j2Wtq4pXdR+6rpx02EM9TYU/e5QDMtMy0+8qR+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626147; c=relaxed/simple;
	bh=8ITsHesfnulo81f9e85ky5kKv8SNn64+QZIPERSk16M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=siFCHji0HjBUwLkNmQr437wnJsmWdVVr9VJfCpD/dzru/EpVURfNO3U1NZ9d8hmu6Azu5h/dG4hbPXrEE3NmBBic7ekqrhuynJPJlOEdUx2Wi+HG00IrO11Mg7VUfxppx0hdZz3yL8HL++sBXmVPHZ2qUKUYooAyqsaknarP1iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OZWclaO/; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760626135; x=1792162135;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8ITsHesfnulo81f9e85ky5kKv8SNn64+QZIPERSk16M=;
  b=OZWclaO/Jhq5/HWr/D48M6CEx6Al+TrLHUd2I1igEf64tISxGY7HhS/x
   6i6jcCTQFZVrWTAS15xCO2NqdnKSNe/hZxkTaz08ZO89x4SprRawUZeCg
   gT+4DgbBeNStQ/CCh0BY6Iivbuto2I1Tbv3VFMmOohnI8RyBfPAAp5kzK
   BygPGZ1cKtBETMWyDMG1wkwnE8eFL57yzNRwa1BpkNaI6X3UsxrbAerrC
   B9SoJ2qWdNIFqpqFajNWP8ME68QP14YiL5ALeheB2lrFAqvVzLQMx/J2j
   Zjjcc8Bmo+XxO94mIfuDC0tpdinHmioA203c8xsVpS4uu7qfFEyzZIITv
   w==;
X-CSE-ConnectionGUID: Jjoc/G+0SRqj2tAPYkjy7Q==
X-CSE-MsgGUID: Rksoq50/TR+iUL95zLLRIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62730934"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62730934"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 07:48:50 -0700
X-CSE-ConnectionGUID: tkv9OBKCSeuHKHYuwBSBlQ==
X-CSE-MsgGUID: QTg8NjIMSHu84IdW7lMExw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="182883351"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 16 Oct 2025 07:48:47 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9PHZ-0004vH-1q;
	Thu, 16 Oct 2025 14:48:45 +0000
Date: Thu, 16 Oct 2025 22:47:56 +0800
From: kernel test robot <lkp@intel.com>
To: Johan Hovold <johan@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [tip:irq/drivers 11/18] drivers/irqchip/irq-imx-mu-msi.c:419:16:
 error: implicit declaration of function 'imx_mu_probe'; did you mean
 'imx_mu_write'?
Message-ID: <202510162257.g1RUy0bT-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/drivers
head:   45f8fdcfbf4e49075172cf1a3fd812b90160e903
commit: 4265aed28d7de2a643b8e441bc25344f421f2f78 [11/18] irqchip: Pass platform device to platform drivers
config: arm-randconfig-004-20251016 (https://download.01.org/0day-ci/archive/20251016/202510162257.g1RUy0bT-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251016/202510162257.g1RUy0bT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510162257.g1RUy0bT-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/irqchip/irq-imx-mu-msi.c: In function 'imx_mu_imx7ulp_probe':
>> drivers/irqchip/irq-imx-mu-msi.c:419:16: error: implicit declaration of function 'imx_mu_probe'; did you mean 'imx_mu_write'? [-Wimplicit-function-declaration]
     419 |         return imx_mu_probe(pdev, parent, &imx_mu_cfg_imx7ulp);
         |                ^~~~~~~~~~~~
         |                imx_mu_write
   drivers/irqchip/irq-imx-mu-msi.c: At top level:
>> drivers/irqchip/irq-imx-mu-msi.c:299:12: warning: 'imx_mu_of_init' defined but not used [-Wunused-function]
     299 | static int imx_mu_of_init(struct platform_device *pdev, struct device_node *parent,
         |            ^~~~~~~~~~~~~~


vim +419 drivers/irqchip/irq-imx-mu-msi.c

   298	
 > 299	static int imx_mu_of_init(struct platform_device *pdev, struct device_node *parent,
   300				  const struct imx_mu_dcfg *cfg)
   301	{
   302		struct device_link *pd_link_a;
   303		struct device_link *pd_link_b;
   304		struct imx_mu_msi *msi_data;
   305		struct resource *res;
   306		struct device *pd_a;
   307		struct device *pd_b;
   308		struct device *dev;
   309		int ret;
   310		int irq;
   311	
   312		dev = &pdev->dev;
   313	
   314		msi_data = devm_kzalloc(&pdev->dev, sizeof(*msi_data), GFP_KERNEL);
   315		if (!msi_data)
   316			return -ENOMEM;
   317	
   318		msi_data->cfg = cfg;
   319	
   320		msi_data->regs = devm_platform_ioremap_resource_byname(pdev, "processor-a-side");
   321		if (IS_ERR(msi_data->regs)) {
   322			dev_err(&pdev->dev, "failed to initialize 'regs'\n");
   323			return PTR_ERR(msi_data->regs);
   324		}
   325	
   326		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "processor-b-side");
   327		if (!res)
   328			return -EIO;
   329	
   330		msi_data->msiir_addr = res->start + msi_data->cfg->xTR;
   331	
   332		irq = platform_get_irq(pdev, 0);
   333		if (irq < 0)
   334			return irq;
   335	
   336		platform_set_drvdata(pdev, msi_data);
   337	
   338		msi_data->clk = devm_clk_get(dev, NULL);
   339		if (IS_ERR(msi_data->clk))
   340			return PTR_ERR(msi_data->clk);
   341	
   342		pd_a = dev_pm_domain_attach_by_name(dev, "processor-a-side");
   343		if (IS_ERR(pd_a))
   344			return PTR_ERR(pd_a);
   345	
   346		pd_b = dev_pm_domain_attach_by_name(dev, "processor-b-side");
   347		if (IS_ERR(pd_b))
   348			return PTR_ERR(pd_b);
   349	
   350		pd_link_a = device_link_add(dev, pd_a,
   351				DL_FLAG_STATELESS |
   352				DL_FLAG_PM_RUNTIME |
   353				DL_FLAG_RPM_ACTIVE);
   354	
   355		if (!pd_link_a) {
   356			dev_err(dev, "Failed to add device_link to mu a.\n");
   357			goto err_pd_a;
   358		}
   359	
   360		pd_link_b = device_link_add(dev, pd_b,
   361				DL_FLAG_STATELESS |
   362				DL_FLAG_PM_RUNTIME |
   363				DL_FLAG_RPM_ACTIVE);
   364	
   365	
   366		if (!pd_link_b) {
   367			dev_err(dev, "Failed to add device_link to mu a.\n");
   368			goto err_pd_b;
   369		}
   370	
   371		ret = imx_mu_msi_domains_init(msi_data, dev);
   372		if (ret)
   373			goto err_dm_init;
   374	
   375		pm_runtime_enable(dev);
   376	
   377		irq_set_chained_handler_and_data(irq,
   378						 imx_mu_msi_irq_handler,
   379						 msi_data);
   380	
   381		return 0;
   382	
   383	err_dm_init:
   384		device_link_remove(dev,	pd_b);
   385	err_pd_b:
   386		device_link_remove(dev, pd_a);
   387	err_pd_a:
   388		return -EINVAL;
   389	}
   390	
   391	static int __maybe_unused imx_mu_runtime_suspend(struct device *dev)
   392	{
   393		struct imx_mu_msi *priv = dev_get_drvdata(dev);
   394	
   395		clk_disable_unprepare(priv->clk);
   396	
   397		return 0;
   398	}
   399	
   400	static int __maybe_unused imx_mu_runtime_resume(struct device *dev)
   401	{
   402		struct imx_mu_msi *priv = dev_get_drvdata(dev);
   403		int ret;
   404	
   405		ret = clk_prepare_enable(priv->clk);
   406		if (ret)
   407			dev_err(dev, "failed to enable clock\n");
   408	
   409		return ret;
   410	}
   411	
   412	static const struct dev_pm_ops imx_mu_pm_ops = {
   413		SET_RUNTIME_PM_OPS(imx_mu_runtime_suspend,
   414				   imx_mu_runtime_resume, NULL)
   415	};
   416	
   417	static int imx_mu_imx7ulp_probe(struct platform_device *pdev, struct device_node *parent)
   418	{
 > 419		return imx_mu_probe(pdev, parent, &imx_mu_cfg_imx7ulp);
   420	}
   421	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


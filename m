Return-Path: <linux-kernel+bounces-889743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D82C3E619
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 04:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2ECD34EAB5B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 03:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7C82E7BDE;
	Fri,  7 Nov 2025 03:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PlkDKbrD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5941016132F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 03:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762486812; cv=none; b=fSHNzmwUdRKMQdGq1+UMGyK69DL7yxE7akUyhmkOVKPOR5O2WT1vi0OK771KjKkX9uYblZTlff5CIPbW9XXGLh2F8i6jtuqK7WZEWK6T3ZuHiFo0sInYH0tQHkiUxz4biz/u37iJAAuNKMZ+3I0wFf/v93HineQdOtv7DGo+Hn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762486812; c=relaxed/simple;
	bh=VVQPqWHJT+IhU/quSD4PubuPAGzXLdwZDO/jSKslTeY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o6Ge9ssS9A7FFsAV3v4KiXHQsY28uI+J0z/ELbobMh7ID9vW9F6LsSqXuj8SMzNcWlP3Knu1fYNByBeexyXMvz9NnLqDsNopSYJthedho57NPREXlX5Ba9+00/9UWW1DlIzK5N5ajpVVMX+W9NxLUtUu1qwD3pjp6GWZvFtze5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PlkDKbrD; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762486810; x=1794022810;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VVQPqWHJT+IhU/quSD4PubuPAGzXLdwZDO/jSKslTeY=;
  b=PlkDKbrDS6KDPiG/DOoMP1YqxxuXjQh8/y5g9KUfIuHZKx+s34UHmlBz
   8rQ1plQktmNAi6jhRJuw9ybDTTofTLWy2S19tMSj6c+9r4Eg/EVjv9Lbw
   J6qgGA9APWdIdtSgDA0GqWQWIsUVscxXn8DJUIcycYXZPfsYwbr1nEKL4
   /k5MYyrlh5Jr6TOJRpqVTBMQ0fQJkGHkIcG+Us9Vx7PWkSc93USKr5ZJq
   +aKIR3gD6WE2S9zin4lXTtBDoFfSD1DzlGpRma5xuDQRlUQYSRWDWC6BS
   xFtgTEO/nXuU7mAI2l+E900+/G3BgijLzcHuIXr2uA0Rs2GT6RxXutt6G
   g==;
X-CSE-ConnectionGUID: YdzdG/j9Rdav73lOm+zaqA==
X-CSE-MsgGUID: AWjwpoJ7QJud+i/4hYEQrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="75326467"
X-IronPort-AV: E=Sophos;i="6.19,285,1754982000"; 
   d="scan'208";a="75326467"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 19:40:10 -0800
X-CSE-ConnectionGUID: m8rqnDgBTHWGdQ0LO9AhhQ==
X-CSE-MsgGUID: 5GweQyUQRbSlecnd8D2Zbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,285,1754982000"; 
   d="scan'208";a="218592385"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 06 Nov 2025 19:40:08 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vHDKX-000Ufa-2u;
	Fri, 07 Nov 2025 03:40:05 +0000
Date: Fri, 7 Nov 2025 11:39:11 +0800
From: kernel test robot <lkp@intel.com>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: drivers/mtd/nand/ecc-realtek.c:443:undefined reference to
 `dma_free_pages'
Message-ID: <202511071114.8WeW2GZK-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4a0c9b3391999818e2c5b93719699b255be1f682
commit: 3148d0e5b1c5733d69ec51b70c8280e46488750a mtd: nand: realtek-ecc: Add Realtek external ECC engine support
date:   6 weeks ago
config: sh-randconfig-r121-20251107 (https://download.01.org/0day-ci/archive/20251107/202511071114.8WeW2GZK-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251107/202511071114.8WeW2GZK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511071114.8WeW2GZK-lkp@intel.com/

All errors (new ones prefixed by >>):

   sh4-linux-ld: drivers/mtd/nand/ecc-realtek.o: in function `rtl_ecc_remove':
>> drivers/mtd/nand/ecc-realtek.c:443:(.text+0x1f8): undefined reference to `dma_free_pages'
   sh4-linux-ld: drivers/mtd/nand/ecc-realtek.o: in function `rtl_ecc_probe':
>> drivers/mtd/nand/ecc-realtek.c:434:(.text+0x2e8): undefined reference to `dma_alloc_pages'
   sh4-linux-ld: drivers/media/i2c/tc358746.o: in function `tc358746_probe':
   drivers/media/i2c/tc358746.c:1585:(.text+0x15cc): undefined reference to `devm_clk_hw_register'
   sh4-linux-ld: drivers/media/i2c/tc358746.c:1610:(.text+0x163c): undefined reference to `devm_of_clk_add_hw_provider'
   sh4-linux-ld: drivers/media/i2c/tc358746.c:1610:(.text+0x1640): undefined reference to `of_clk_hw_simple_get'


vim +443 drivers/mtd/nand/ecc-realtek.c

   389	
   390	static int rtl_ecc_probe(struct platform_device *pdev)
   391	{
   392		struct device *dev = &pdev->dev;
   393		struct rtl_ecc_engine *rtlc;
   394		void __iomem *base;
   395		int ret;
   396	
   397		rtlc = devm_kzalloc(dev, sizeof(*rtlc), GFP_KERNEL);
   398		if (!rtlc)
   399			return -ENOMEM;
   400	
   401		base = devm_platform_ioremap_resource(pdev, 0);
   402		if (IS_ERR(base))
   403			return PTR_ERR(base);
   404	
   405		ret = devm_mutex_init(dev, &rtlc->lock);
   406		if (ret)
   407			return ret;
   408	
   409		rtlc->regmap = devm_regmap_init_mmio(dev, base, &rtl_ecc_regmap_config);
   410		if (IS_ERR(rtlc->regmap))
   411			return PTR_ERR(rtlc->regmap);
   412	
   413		/*
   414		 * Focus on simplicity and use a preallocated DMA buffer for data exchange with the
   415		 * engine. For now make it a noncoherent memory model as invalidating/flushing caches
   416		 * is faster than reading/writing uncached memory on the known architectures.
   417		 */
   418	
   419		rtlc->buf = dma_alloc_noncoherent(dev, RTL_ECC_DMA_SIZE, &rtlc->buf_dma,
   420						  DMA_BIDIRECTIONAL, GFP_KERNEL);
   421		if (IS_ERR(rtlc->buf))
   422			return PTR_ERR(rtlc->buf);
   423	
   424		rtlc->dev = dev;
   425		rtlc->engine.dev = dev;
   426		rtlc->engine.ops = &rtl_ecc_engine_ops;
   427		rtlc->engine.integration = NAND_ECC_ENGINE_INTEGRATION_EXTERNAL;
   428	
   429		nand_ecc_register_on_host_hw_engine(&rtlc->engine);
   430	
   431		platform_set_drvdata(pdev, rtlc);
   432	
   433		return 0;
 > 434	}
   435	
   436	static void rtl_ecc_remove(struct platform_device *pdev)
   437	{
   438		struct rtl_ecc_engine *rtlc = platform_get_drvdata(pdev);
   439	
   440		nand_ecc_unregister_on_host_hw_engine(&rtlc->engine);
   441		dma_free_noncoherent(rtlc->dev, RTL_ECC_DMA_SIZE, rtlc->buf, rtlc->buf_dma,
   442				     DMA_BIDIRECTIONAL);
 > 443	}
   444	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


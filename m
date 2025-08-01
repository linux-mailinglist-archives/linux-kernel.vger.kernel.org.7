Return-Path: <linux-kernel+bounces-753773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE39B187AE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 21:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B602D625CC6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 19:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0DD28D85F;
	Fri,  1 Aug 2025 19:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BTVRByHX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270E34A04
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 19:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754076283; cv=none; b=foMxJeH1jKuU5bshqhEHbF9PwfJgg5TQbbvFPxmfgYRU6nBKLXH7sUFDLxXHvae3Flj9ihbG9R2Psf4sJouHySP7NSOM/hy76uMhzODTA/ezKkv5wya96aWAIv1EIA/AykvVQFBpLIwCmAG5RKb7B5LX74hu+u3e5imIhvUQWbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754076283; c=relaxed/simple;
	bh=i/fyHcetJmCp/uczEAhSDdOrxyFpmYb6C9jTAeOJor0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JEk2A1O19Ji9e3mqSpeNRqJFNoQTM0+ysR8gAA1z9Idh5JYa1wOFOvWLJ9DV/gZO+myLDEwZ+/MIGjN7P7rFFEWH9JOicK8Ko6oAyUEkl6ddsCY9YegU+r2ek54bxMME+XZ69Hd0nxyLOcVqNMt9Q8nkpxQTW0RgNdhIRuprXHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BTVRByHX; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754076281; x=1785612281;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=i/fyHcetJmCp/uczEAhSDdOrxyFpmYb6C9jTAeOJor0=;
  b=BTVRByHXj6HzsVlnSI3hSQ2Hg9ClnWOtW2VpCB1U7zk+wJVGl4K7fu8L
   gfnI7EkOPo8Zkx9b1yu1wtmkD6nyWveht2ig5AP88f8x7PU8/3tdzSlqr
   geUTqxzdhmt3CTnQu0yoXAzn6zOQJwYKigI75rH7byzOfWIQJ0QaWugNx
   d6fg03VlANnKKJYyWQYFh46TP5HNWDZ+CD97GOz6kCzORJQz4GdYlpF6y
   cqiQeL2RE+PYZMijwS6BHrH2phERxQsi6keoCziW2Y6I4uNlmoRGgvV2l
   gHFLegTFkcEcw20I/P03P7ZIkZhjiACgQeFCimIZxlHFVBRhA4uFFXQ9T
   A==;
X-CSE-ConnectionGUID: oOR0l9bXTnyDQvoolcD7iA==
X-CSE-MsgGUID: ZRNooJkKRuWRjcCaxXPyHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="78984119"
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="78984119"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 12:24:41 -0700
X-CSE-ConnectionGUID: GJGVgbdKRyihFoF2FsEPlg==
X-CSE-MsgGUID: 00w7xOyETDKqPwRxj/qVfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="169024515"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 01 Aug 2025 12:24:39 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uhvMq-0004ry-2h;
	Fri, 01 Aug 2025 19:24:36 +0000
Date: Sat, 2 Aug 2025 03:24:10 +0800
From: kernel test robot <lkp@intel.com>
To: Tiwei Bie <tiwei.btw@antgroup.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: drivers/ufs/host/ufs-rockchip.c:168:19: error: call to undeclared
 function 'devm_gpiod_get'; ISO C99 and later do not support implicit
 function declarations
Message-ID: <202508020328.0TqbPXJY-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d6f38c12396397e48092ad9e8a4d7be4de51b942
commit: a0e2cb6a90634f3dc80f16e882a683ee5761b0b0 um: Add VFIO-based virtual PCI driver
date:   3 months ago
config: um-randconfig-r063-20250801 (https://download.01.org/0day-ci/archive/20250802/202508020328.0TqbPXJY-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 8f09b03aebb71c154f3bbe725c29e3f47d37c26e)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250802/202508020328.0TqbPXJY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508020328.0TqbPXJY-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/ufs/host/ufs-rockchip.c:15:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:12:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:549:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     549 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:567:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     567 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/ufs/host/ufs-rockchip.c:15:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:12:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:585:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/ufs/host/ufs-rockchip.c:15:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:12:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:601:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     601 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:616:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     616 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:631:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     631 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:724:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     724 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:737:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     737 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:750:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     750 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:764:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     764 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:778:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     778 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:792:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     792 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> drivers/ufs/host/ufs-rockchip.c:168:19: error: call to undeclared function 'devm_gpiod_get'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     168 |         host->rst_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
         |                          ^
>> drivers/ufs/host/ufs-rockchip.c:168:48: error: use of undeclared identifier 'GPIOD_OUT_LOW'
     168 |         host->rst_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
         |                                                       ^~~~~~~~~~~~~
>> drivers/ufs/host/ufs-rockchip.c:214:2: error: call to undeclared function 'gpiod_set_value_cansleep'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     214 |         gpiod_set_value_cansleep(host->rst_gpio, 1);
         |         ^
   drivers/ufs/host/ufs-rockchip.c:214:2: note: did you mean 'gpio_set_value_cansleep'?
   include/linux/gpio.h:178:20: note: 'gpio_set_value_cansleep' declared here
     178 | static inline void gpio_set_value_cansleep(unsigned gpio, int value)
         |                    ^
   12 warnings and 3 errors generated.


vim +/devm_gpiod_get +168 drivers/ufs/host/ufs-rockchip.c

d3cbe455d6eb60 Shawn Lin 2025-02-05  127  
d3cbe455d6eb60 Shawn Lin 2025-02-05  128  static int ufs_rockchip_common_init(struct ufs_hba *hba)
d3cbe455d6eb60 Shawn Lin 2025-02-05  129  {
d3cbe455d6eb60 Shawn Lin 2025-02-05  130  	struct device *dev = hba->dev;
d3cbe455d6eb60 Shawn Lin 2025-02-05  131  	struct platform_device *pdev = to_platform_device(dev);
d3cbe455d6eb60 Shawn Lin 2025-02-05  132  	struct ufs_rockchip_host *host;
d3cbe455d6eb60 Shawn Lin 2025-02-05  133  	int err;
d3cbe455d6eb60 Shawn Lin 2025-02-05  134  
d3cbe455d6eb60 Shawn Lin 2025-02-05  135  	host = devm_kzalloc(dev, sizeof(*host), GFP_KERNEL);
d3cbe455d6eb60 Shawn Lin 2025-02-05  136  	if (!host)
d3cbe455d6eb60 Shawn Lin 2025-02-05  137  		return -ENOMEM;
d3cbe455d6eb60 Shawn Lin 2025-02-05  138  
d3cbe455d6eb60 Shawn Lin 2025-02-05  139  	host->ufs_sys_ctrl = devm_platform_ioremap_resource_byname(pdev, "hci_grf");
d3cbe455d6eb60 Shawn Lin 2025-02-05  140  	if (IS_ERR(host->ufs_sys_ctrl))
d3cbe455d6eb60 Shawn Lin 2025-02-05  141  		return dev_err_probe(dev, PTR_ERR(host->ufs_sys_ctrl),
d3cbe455d6eb60 Shawn Lin 2025-02-05  142  				"Failed to map HCI system control registers\n");
d3cbe455d6eb60 Shawn Lin 2025-02-05  143  
d3cbe455d6eb60 Shawn Lin 2025-02-05  144  	host->ufs_phy_ctrl = devm_platform_ioremap_resource_byname(pdev, "mphy_grf");
d3cbe455d6eb60 Shawn Lin 2025-02-05  145  	if (IS_ERR(host->ufs_phy_ctrl))
d3cbe455d6eb60 Shawn Lin 2025-02-05  146  		return dev_err_probe(dev, PTR_ERR(host->ufs_phy_ctrl),
d3cbe455d6eb60 Shawn Lin 2025-02-05  147  				"Failed to map mphy system control registers\n");
d3cbe455d6eb60 Shawn Lin 2025-02-05  148  
d3cbe455d6eb60 Shawn Lin 2025-02-05  149  	host->mphy_base = devm_platform_ioremap_resource_byname(pdev, "mphy");
d3cbe455d6eb60 Shawn Lin 2025-02-05  150  	if (IS_ERR(host->mphy_base))
d3cbe455d6eb60 Shawn Lin 2025-02-05  151  		return dev_err_probe(dev, PTR_ERR(host->mphy_base),
d3cbe455d6eb60 Shawn Lin 2025-02-05  152  				"Failed to map mphy base registers\n");
d3cbe455d6eb60 Shawn Lin 2025-02-05  153  
d3cbe455d6eb60 Shawn Lin 2025-02-05  154  	host->rst = devm_reset_control_array_get_exclusive(dev);
d3cbe455d6eb60 Shawn Lin 2025-02-05  155  	if (IS_ERR(host->rst))
d3cbe455d6eb60 Shawn Lin 2025-02-05  156  		return dev_err_probe(dev, PTR_ERR(host->rst),
d3cbe455d6eb60 Shawn Lin 2025-02-05  157  				"failed to get reset control\n");
d3cbe455d6eb60 Shawn Lin 2025-02-05  158  
d3cbe455d6eb60 Shawn Lin 2025-02-05  159  	reset_control_assert(host->rst);
d3cbe455d6eb60 Shawn Lin 2025-02-05  160  	udelay(1);
d3cbe455d6eb60 Shawn Lin 2025-02-05  161  	reset_control_deassert(host->rst);
d3cbe455d6eb60 Shawn Lin 2025-02-05  162  
d3cbe455d6eb60 Shawn Lin 2025-02-05  163  	host->ref_out_clk = devm_clk_get_enabled(dev, "ref_out");
d3cbe455d6eb60 Shawn Lin 2025-02-05  164  	if (IS_ERR(host->ref_out_clk))
d3cbe455d6eb60 Shawn Lin 2025-02-05  165  		return dev_err_probe(dev, PTR_ERR(host->ref_out_clk),
d3cbe455d6eb60 Shawn Lin 2025-02-05  166  				"ref_out clock unavailable\n");
d3cbe455d6eb60 Shawn Lin 2025-02-05  167  
d3cbe455d6eb60 Shawn Lin 2025-02-05 @168  	host->rst_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
d3cbe455d6eb60 Shawn Lin 2025-02-05  169  	if (IS_ERR(host->rst_gpio))
d3cbe455d6eb60 Shawn Lin 2025-02-05  170  		return dev_err_probe(dev, PTR_ERR(host->rst_gpio),
d3cbe455d6eb60 Shawn Lin 2025-02-05  171  				"failed to get reset gpio\n");
d3cbe455d6eb60 Shawn Lin 2025-02-05  172  
d3cbe455d6eb60 Shawn Lin 2025-02-05  173  	err = devm_clk_bulk_get_all_enabled(dev, &host->clks);
4fffffd3b13439 Shawn Lin 2025-02-26  174  	if (err < 0)
d3cbe455d6eb60 Shawn Lin 2025-02-05  175  		return dev_err_probe(dev, err, "failed to enable clocks\n");
d3cbe455d6eb60 Shawn Lin 2025-02-05  176  
d3cbe455d6eb60 Shawn Lin 2025-02-05  177  	host->hba = hba;
d3cbe455d6eb60 Shawn Lin 2025-02-05  178  
d3cbe455d6eb60 Shawn Lin 2025-02-05  179  	ufshcd_set_variant(hba, host);
d3cbe455d6eb60 Shawn Lin 2025-02-05  180  
d3cbe455d6eb60 Shawn Lin 2025-02-05  181  	return 0;
d3cbe455d6eb60 Shawn Lin 2025-02-05  182  }
d3cbe455d6eb60 Shawn Lin 2025-02-05  183  
d3cbe455d6eb60 Shawn Lin 2025-02-05  184  static int ufs_rockchip_rk3576_init(struct ufs_hba *hba)
d3cbe455d6eb60 Shawn Lin 2025-02-05  185  {
d3cbe455d6eb60 Shawn Lin 2025-02-05  186  	struct device *dev = hba->dev;
d3cbe455d6eb60 Shawn Lin 2025-02-05  187  	int ret;
d3cbe455d6eb60 Shawn Lin 2025-02-05  188  
d3cbe455d6eb60 Shawn Lin 2025-02-05  189  	hba->quirks = UFSHCD_QUIRK_SKIP_DEF_UNIPRO_TIMEOUT_SETTING;
d3cbe455d6eb60 Shawn Lin 2025-02-05  190  
d3cbe455d6eb60 Shawn Lin 2025-02-05  191  	/* Enable BKOPS when suspend */
d3cbe455d6eb60 Shawn Lin 2025-02-05  192  	hba->caps |= UFSHCD_CAP_AUTO_BKOPS_SUSPEND;
d3cbe455d6eb60 Shawn Lin 2025-02-05  193  	/* Enable putting device into deep sleep */
d3cbe455d6eb60 Shawn Lin 2025-02-05  194  	hba->caps |= UFSHCD_CAP_DEEPSLEEP;
d3cbe455d6eb60 Shawn Lin 2025-02-05  195  	/* Enable devfreq of UFS */
d3cbe455d6eb60 Shawn Lin 2025-02-05  196  	hba->caps |= UFSHCD_CAP_CLK_SCALING;
d3cbe455d6eb60 Shawn Lin 2025-02-05  197  	/* Enable WriteBooster */
d3cbe455d6eb60 Shawn Lin 2025-02-05  198  	hba->caps |= UFSHCD_CAP_WB_EN;
d3cbe455d6eb60 Shawn Lin 2025-02-05  199  
d3cbe455d6eb60 Shawn Lin 2025-02-05  200  	/* Set the default desired pm level in case no users set via sysfs */
d3cbe455d6eb60 Shawn Lin 2025-02-05  201  	ufs_rockchip_set_pm_lvl(hba);
d3cbe455d6eb60 Shawn Lin 2025-02-05  202  
d3cbe455d6eb60 Shawn Lin 2025-02-05  203  	ret = ufs_rockchip_common_init(hba);
d3cbe455d6eb60 Shawn Lin 2025-02-05  204  	if (ret)
d3cbe455d6eb60 Shawn Lin 2025-02-05  205  		return dev_err_probe(dev, ret, "ufs common init fail\n");
d3cbe455d6eb60 Shawn Lin 2025-02-05  206  
d3cbe455d6eb60 Shawn Lin 2025-02-05  207  	return 0;
d3cbe455d6eb60 Shawn Lin 2025-02-05  208  }
d3cbe455d6eb60 Shawn Lin 2025-02-05  209  
d3cbe455d6eb60 Shawn Lin 2025-02-05  210  static int ufs_rockchip_device_reset(struct ufs_hba *hba)
d3cbe455d6eb60 Shawn Lin 2025-02-05  211  {
d3cbe455d6eb60 Shawn Lin 2025-02-05  212  	struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
d3cbe455d6eb60 Shawn Lin 2025-02-05  213  
d3cbe455d6eb60 Shawn Lin 2025-02-05 @214  	gpiod_set_value_cansleep(host->rst_gpio, 1);
d3cbe455d6eb60 Shawn Lin 2025-02-05  215  	usleep_range(20, 25);
d3cbe455d6eb60 Shawn Lin 2025-02-05  216  
d3cbe455d6eb60 Shawn Lin 2025-02-05  217  	gpiod_set_value_cansleep(host->rst_gpio, 0);
d3cbe455d6eb60 Shawn Lin 2025-02-05  218  	usleep_range(20, 25);
d3cbe455d6eb60 Shawn Lin 2025-02-05  219  
d3cbe455d6eb60 Shawn Lin 2025-02-05  220  	return 0;
d3cbe455d6eb60 Shawn Lin 2025-02-05  221  }
d3cbe455d6eb60 Shawn Lin 2025-02-05  222  

:::::: The code at line 168 was first introduced by commit
:::::: d3cbe455d6eb600dee27bf5294f6fe8c2bb06b5f scsi: ufs: rockchip: Initial support for UFS

:::::: TO: Shawn Lin <shawn.lin@rock-chips.com>
:::::: CC: Martin K. Petersen <martin.petersen@oracle.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


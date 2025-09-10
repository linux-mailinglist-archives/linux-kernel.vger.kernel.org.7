Return-Path: <linux-kernel+bounces-809428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A53B50D99
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 07:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 415201C21818
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 05:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57F72E091C;
	Wed, 10 Sep 2025 05:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hl2Hz52d"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D139F2DE1FE;
	Wed, 10 Sep 2025 05:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757483862; cv=none; b=cB9naLgliXTGUXwxNWyZ7xk3DXr7PyWeVyGGl9OBoezwiwpZvzRH09YHO1UFwaoFFPKxTKNRyxzZjo3cJSsY//DNnhx8TrqgyX6qr8Kj+woRAclTfklf93WrYLlC2vhl1axtJFA6H8fsHrFVSHFqCEEIl2mScOVfM4yAUjWKO0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757483862; c=relaxed/simple;
	bh=mkYJqjsiORjHJd7c74oXowKFTaD/mx69o2VDb+oyXvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WqUrprVvbjirT2F9L6n2qfa09A4QnzWNwDiPPyhNYx7CxUDJ5t8xSAAn3Nc+/+vf/WB+CaBYmy7cgyg2kuc3udLIWQV5SUNs5WI4I13RMvXU52BuurCjUxHOpu4UnVbP+lFu1fSINKLryx1vFZGACG4W2mJ66ijSglYHQEE4vI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hl2Hz52d; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757483859; x=1789019859;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mkYJqjsiORjHJd7c74oXowKFTaD/mx69o2VDb+oyXvU=;
  b=hl2Hz52dJfjLymb6gtEbhcAjo3TU1bHaxz+3dR34MrW2D4DRRWCv4j9r
   KXCYWIJronfASMX2O7pJV1OhKc57kuaotlm/zF2X4RUr4ljQfPhYxij6a
   hO/oM7ttkby2bQjaKtA/NgM4spGKJdlBXeuNDRTreKrTSTJpUyvSdUn8B
   DiyQsSKxKx37G117ItPjOUUxd6E/GlLQHSR2WjpDk8vEpQc/5YZSIvUJA
   iV3UFcMTGotROt1yralMFAZsYhflQGCrYdxnawamzI0mRrHKDRT431wL8
   blGAmiR5eUU1MBQku4PS/rwhxtedBGyprfG4BdsIdilGU8H6Wz49sFWit
   Q==;
X-CSE-ConnectionGUID: kQCsbuSISF6ZUUkw19pGUQ==
X-CSE-MsgGUID: pmDabdZRSuCopar0+LLugA==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="71163855"
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="71163855"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 22:57:38 -0700
X-CSE-ConnectionGUID: AHxEKrFcSV6kBnRbvkgHrg==
X-CSE-MsgGUID: eYmD5IWQT8SCw4aoFXB6oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="172457612"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 09 Sep 2025 22:57:35 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uwDpk-0005Zf-1e;
	Wed, 10 Sep 2025 05:57:32 +0000
Date: Wed, 10 Sep 2025 13:57:15 +0800
From: kernel test robot <lkp@intel.com>
To: Durai Manickam KR <durai.manickamkr@microchip.com>,
	linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, alexandre.belloni@bootlin.com,
	Frank.Li@nxp.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, balamanikandan.gunasundar@microchip.com,
	nicolas.ferre@microchip.com
Cc: oe-kbuild-all@lists.linux.dev,
	Durai Manickam KR <durai.manickamkr@microchip.com>
Subject: Re: [PATCH 2/4] i3c: master: add Microchip SAMA7D65 I3C HCI master
 driver
Message-ID: <202509101550.Bpclx47x-lkp@intel.com>
References: <20250909111333.170016-3-durai.manickamkr@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909111333.170016-3-durai.manickamkr@microchip.com>

Hi Durai,

kernel test robot noticed the following build errors:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on robh/for-next linus/master v6.17-rc5 next-20250909]
[cannot apply to abelloni/rtc-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Durai-Manickam-KR/clk-at91-sama7d65-add-peripheral-clock-for-I3C/20250909-192231
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20250909111333.170016-3-durai.manickamkr%40microchip.com
patch subject: [PATCH 2/4] i3c: master: add Microchip SAMA7D65 I3C HCI master driver
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20250910/202509101550.Bpclx47x-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250910/202509101550.Bpclx47x-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509101550.Bpclx47x-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/i3c/master/sama7d65-i3c-hci-master.c:2478:35: error: initialization of 'int (*)(struct i2c_dev_desc *, struct i2c_msg *, int)' from incompatible pointer type 'int (*)(struct i2c_dev_desc *, const struct i2c_msg *, int)' [-Wincompatible-pointer-types]
    2478 |         .i2c_xfers              = mchp_i3c_hci_i2c_xfers,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~
   drivers/i3c/master/sama7d65-i3c-hci-master.c:2478:35: note: (near initialization for 'mchp_i3c_hci_ops.i2c_xfers')
   drivers/i3c/master/sama7d65-i3c-hci-master.c:2283:12: note: 'mchp_i3c_hci_i2c_xfers' declared here
    2283 | static int mchp_i3c_hci_i2c_xfers(struct i2c_dev_desc *dev,
         |            ^~~~~~~~~~~~~~~~~~~~~~
   drivers/i3c/master/sama7d65-i3c-hci-master.c: In function 'mchp_i3c_hci_init':
>> drivers/i3c/master/sama7d65-i3c-hci-master.c:2517:30: warning: variable 'mode_selector' set but not used [-Wunused-but-set-variable]
    2517 |         bool size_in_dwords, mode_selector;
         |                              ^~~~~~~~~~~~~
   drivers/i3c/master/sama7d65-i3c-hci-master.c: At top level:
>> drivers/i3c/master/sama7d65-i3c-hci-master.c:2695:10: error: 'struct platform_driver' has no member named 'remove_new'; did you mean 'remove'?
    2695 |         .remove_new = mchp_i3c_hci_remove,
         |          ^~~~~~~~~~
         |          remove


vim +2478 drivers/i3c/master/sama7d65-i3c-hci-master.c

  2471	
  2472	static const struct i3c_master_controller_ops mchp_i3c_hci_ops = {
  2473		.bus_init		= mchp_i3c_hci_bus_init,
  2474		.bus_cleanup		= mchp_i3c_hci_bus_cleanup,
  2475		.do_daa			= mchp_i3c_hci_daa,
  2476		.send_ccc_cmd		= mchp_i3c_hci_send_ccc_cmd,
  2477		.priv_xfers		= mchp_i3c_hci_priv_xfers,
> 2478		.i2c_xfers		= mchp_i3c_hci_i2c_xfers,
  2479		.attach_i3c_dev		= mchp_i3c_hci_attach_i3c_dev,
  2480		.reattach_i3c_dev	= mchp_i3c_hci_reattach_i3c_dev,
  2481		.detach_i3c_dev		= mchp_i3c_hci_detach_i3c_dev,
  2482		.attach_i2c_dev		= mchp_i3c_hci_attach_i2c_dev,
  2483		.detach_i2c_dev		= mchp_i3c_hci_detach_i2c_dev,
  2484		.request_ibi		= mchp_i3c_hci_request_ibi,
  2485		.free_ibi		= mchp_i3c_hci_free_ibi,
  2486		.enable_ibi		= mchp_i3c_hci_enable_ibi,
  2487		.disable_ibi		= mchp_i3c_hci_disable_ibi,
  2488		.recycle_ibi_slot	= mchp_i3c_hci_recycle_ibi_slot,
  2489	};
  2490	
  2491	static irqreturn_t mchp_i3c_hci_irq_handler(int irq, void *dev_id)
  2492	{
  2493		struct mchp_i3c_hci *hci = dev_id;
  2494		irqreturn_t result = IRQ_NONE;
  2495		u32 val;
  2496	
  2497		val = reg_read(MCHP_INTR_STATUS);
  2498		dev_dbg(&hci->master.dev,"INTR_STATUS = %#x", val);
  2499	
  2500		if (val & MCHP_INTR_HC_INTERNAL_ERR) {
  2501			dev_err(&hci->master.dev, "Host Controller Internal Error\n");
  2502			val &= ~MCHP_INTR_HC_INTERNAL_ERR;
  2503		}
  2504			
  2505		hci->io->irq_handler(hci, 0);
  2506		
  2507		if (val)
  2508			dev_err(&hci->master.dev, "unexpected INTR_STATUS %#x\n", val);
  2509		else
  2510			result = IRQ_HANDLED;
  2511	
  2512		return result;
  2513	}
  2514	
  2515	static int mchp_i3c_hci_init(struct mchp_i3c_hci *hci)
  2516	{
> 2517		bool size_in_dwords, mode_selector;
  2518		u32 regval, offset;
  2519		int ret;
  2520	
  2521		/* Validate HCI hardware version */
  2522		regval = reg_read(MCHP_HCI_VERSION);
  2523		hci->version_major = (regval >> 8) & 0xf;
  2524		hci->version_minor = (regval >> 4) & 0xf;
  2525		hci->revision = regval & 0xf;
  2526		dev_notice(&hci->master.dev, "MIPI I3C HCI v%u.%u r%02u\n",
  2527			   hci->version_major, hci->version_minor, hci->revision);
  2528		/* known versions */
  2529		switch (regval & ~0xf) {
  2530		case 0x100:	/* version 1.0 */
  2531		case 0x110:	/* version 1.1 */
  2532		case 0x200:	/* version 2.0 */
  2533			break;
  2534		default:
  2535			dev_err(&hci->master.dev, "unsupported HCI version\n");
  2536			return -EPROTONOSUPPORT;
  2537		}
  2538	
  2539		hci->caps = reg_read(MCHP_HC_CAPABILITIES);
  2540		dev_dbg(&hci->master.dev,"caps = %#x", hci->caps);
  2541	
  2542		size_in_dwords = hci->version_major < 1 ||
  2543				 (hci->version_major == 1 && hci->version_minor < 1);
  2544	
  2545		regval = reg_read(MCHP_DAT_SECTION);
  2546		offset = FIELD_GET(MCHP_DAT_TABLE_OFFSET, regval);
  2547		hci->DAT_regs = offset ? hci->base_regs + offset : NULL;
  2548		hci->DAT_entries = FIELD_GET(MCHP_DAT_TABLE_SIZE, regval);
  2549		hci->DAT_entry_size = 8;
  2550		if (size_in_dwords)
  2551			hci->DAT_entries = 4 * hci->DAT_entries / hci->DAT_entry_size;
  2552		dev_info(&hci->master.dev, "DAT: %u %u-bytes entries at offset %#x\n",
  2553			 hci->DAT_entries, hci->DAT_entry_size, offset);
  2554	
  2555		regval = reg_read(MCHP_DCT_SECTION);
  2556		offset = FIELD_GET(MCHP_DCT_TABLE_OFFSET, regval);
  2557		hci->DCT_regs = offset ? hci->base_regs + offset : NULL;
  2558		hci->DCT_entries = FIELD_GET(MCHP_DCT_TABLE_SIZE, regval);
  2559		hci->DCT_entry_size = 16;
  2560		if (size_in_dwords)
  2561			hci->DCT_entries = 4 * hci->DCT_entries / hci->DCT_entry_size;
  2562		dev_info(&hci->master.dev, "DCT: %u %u-bytes entries at offset %#x\n",
  2563			 hci->DCT_entries, hci->DCT_entry_size, offset);
  2564	
  2565		regval = reg_read(MCHP_RING_HEADERS_SECTION);
  2566		offset = FIELD_GET(MCHP_RING_HEADERS_OFFSET, regval);
  2567		hci->RHS_regs = offset ? hci->base_regs + offset : NULL;
  2568		dev_info(&hci->master.dev, "Ring Headers at offset %#x\n", offset);
  2569	
  2570		regval = reg_read(MCHP_PIO_SECTION);
  2571		offset = FIELD_GET(MCHP_PIO_REGS_OFFSET, regval);
  2572		hci->PIO_regs = offset ? hci->base_regs + offset : NULL;
  2573		dev_info(&hci->master.dev, "PIO section at offset %#x\n", offset);
  2574	
  2575		regval = reg_read(MCHP_EXT_CAPS_SECTION);
  2576		offset = FIELD_GET(MCHP_EXT_CAPS_OFFSET, regval);
  2577		hci->EXTCAPS_regs = offset ? hci->base_regs + offset : NULL;
  2578		dev_info(&hci->master.dev, "Extended Caps at offset %#x\n", offset);
  2579	
  2580		ret = i3c_hci_parse_ext_caps(hci);
  2581		if (ret)
  2582			return ret;
  2583	
  2584		/*
  2585		 * Now let's reset the hardware.
  2586		 * SOFT_RST must be clear before we write to it.
  2587		 * Then we must wait until it clears again.
  2588		 */
  2589		ret = readx_poll_timeout(reg_read, MCHP_RESET_CONTROL, regval,
  2590					 !(regval & MCHP_SOFT_RST), 1, 10000);
  2591		if (ret)
  2592			return -ENXIO;
  2593		reg_write(MCHP_RESET_CONTROL, MCHP_SOFT_RST);
  2594		ret = readx_poll_timeout(reg_read, MCHP_RESET_CONTROL, regval,
  2595					 !(regval & MCHP_SOFT_RST), 1, 10000);
  2596		if (ret)
  2597			return -ENXIO;
  2598	
  2599		/* Disable all interrupts and allow all signal updates */
  2600		reg_write(MCHP_INTR_SIGNAL_ENABLE, 0x0);
  2601		reg_write(MCHP_INTR_STATUS_ENABLE, 0xffffffff);
  2602		
  2603		hci->cmd = &mchp_mipi_i3c_hci_cmd_v1;
  2604		mode_selector = hci->version_major > 1 ||
  2605					(hci->version_major == 1 && hci->version_minor > 0);
  2606	
  2607		/* Quirk for HCI_QUIRK_PIO_MODE on MICROCHIP platforms */
  2608		if (hci->quirks & MCHP_HCI_QUIRK_PIO_MODE) {
  2609				hci->RHS_regs = NULL;
  2610		}
  2611	
  2612		hci->io = &mchp_mipi_i3c_hci_pio;
  2613		dev_info(&hci->master.dev, "Using PIO\n");
  2614		
  2615		microchip_set_od_pp_timing(hci);
  2616	
  2617		return 0;
  2618	}
  2619	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


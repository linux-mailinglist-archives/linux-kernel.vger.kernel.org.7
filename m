Return-Path: <linux-kernel+bounces-769839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D6AB2744F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 228927A9185
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 00:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0AA13DDAE;
	Fri, 15 Aug 2025 00:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X9AG4pvr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B0B2D052
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 00:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755219396; cv=none; b=c1i8N3+WZZkvR8LwvSH9RwmLY5e71O4GSO0WcrDgQu3EmIPU+b1TjHibewUy2QVi1snizJVcvlm4+pVInolyzCLn0A+6hrC1UuCvBUsUeBw2O/lCdVQbUGprpqXB3F0UGqJTg7DThz+ejYLOGldkSslvigjdIbg1EYRBSnOQNXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755219396; c=relaxed/simple;
	bh=xoDKpjg/cdNxNdfq2QnkW28yt214Y5Nb4kpr6qiRtXk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=I2bvhb1Xp7ImJ7s08MqqmXRj/Uyacrkcn7lzZlpSxr3OQs13Z0DrFrnIQ3Ik4d1wmD/OvSXPbq4kfp2ae5wuLMaid3mxOPhezcaW1ZwdFzeZaX7dWFC26d3rPbvfnDfRRmH/6RffvJhUFxPIjVTxXmJe8JJSrc3hKVYG1mpoEHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X9AG4pvr; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755219395; x=1786755395;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xoDKpjg/cdNxNdfq2QnkW28yt214Y5Nb4kpr6qiRtXk=;
  b=X9AG4pvrtWE+pnZZk6k/CqpDTU1L7tqIxIYd4flW8Q9RtujNJv88Cxy5
   8rqU+nHQgrggm2lYfXjJL2sG9MUieP6uBXT0akmEzt6qvdTwj+9bn8SAc
   Kt8qwAIPOja7Ynw3jmtoWd/BK9ZE7S9wxW12+085AY2R0JT8qvnBEnaRw
   F8wk5MgPD6j0Mh3edmDlfzlm1ggp35sQQw9RYMEohocAXKbJWR+OBiQmD
   2ZukgUcbPdKtThN+XqngPtR8DqFfaCaascq91zOHVyMkU/TjWuSQ47KTY
   P7z2T+qdDooUgx3E89R9VHOMDCoFT6cPSm0kZk5Q16g5Rijr/8uvF37de
   w==;
X-CSE-ConnectionGUID: jK0qVlEQRHStBjx0iwPcpw==
X-CSE-MsgGUID: +uOZwkX4TwS3oBpmB4coZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="57618342"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="57618342"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 17:56:34 -0700
X-CSE-ConnectionGUID: Xf/+rf1VTK+q2qFw0xhMVA==
X-CSE-MsgGUID: +MKboVB2Q0ah2YEUBdrl7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="167247912"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 14 Aug 2025 17:56:32 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umik9-000BPW-2t;
	Fri, 15 Aug 2025 00:56:29 +0000
Date: Fri, 15 Aug 2025 08:55:50 +0800
From: kernel test robot <lkp@intel.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Sergio Paracuellos <sergio.paracuellos@gmail.com>
Subject: drivers/net/wireless/ralink/rt2x00/rt2800soc.c:247:undefined
 reference to `rt2x00lib_resume'
Message-ID: <202508150853.IfS01nJn-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   24ea63ea387714634813359e2c8e0e6c36952f73
commit: 7f6109086c9e7bbc78ff936dac45626870455c76 wifi: rt2800: move 2x00soc to 2800soc
date:   3 weeks ago
config: sparc64-randconfig-r121-20250814 (https://download.01.org/0day-ci/archive/20250815/202508150853.IfS01nJn-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.4.0
reproduce: (https://download.01.org/0day-ci/archive/20250815/202508150853.IfS01nJn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508150853.IfS01nJn-lkp@intel.com/

All errors (new ones prefixed by >>):

   sparc64-linux-ld: drivers/net/wireless/ralink/rt2x00/rt2x00mmio.o: in function `rt2x00mmio_rxdone':
>> drivers/net/wireless/ralink/rt2x00/rt2x00mmio.c:58:(.text+0x1ac): undefined reference to `rt2x00queue_get_entry'
>> sparc64-linux-ld: drivers/net/wireless/ralink/rt2x00/rt2x00mmio.c:75:(.text+0x220): undefined reference to `rt2x00lib_dmastart'
>> sparc64-linux-ld: drivers/net/wireless/ralink/rt2x00/rt2x00mmio.c:76:(.text+0x228): undefined reference to `rt2x00lib_dmadone'
>> sparc64-linux-ld: drivers/net/wireless/ralink/rt2x00/rt2x00mmio.c:81:(.text+0x234): undefined reference to `rt2x00lib_rxdone'
   sparc64-linux-ld: drivers/net/wireless/ralink/rt2x00/rt2800lib.o: in function `rt2800_txstatus_pending':
>> drivers/net/wireless/ralink/rt2x00/rt2800lib.c:1203:(.text+0x5dac): undefined reference to `rt2x00queue_get_entry'
>> sparc64-linux-ld: drivers/net/wireless/ralink/rt2x00/rt2800lib.c:1203:(.text+0x5dbc): undefined reference to `rt2x00queue_get_entry'
   sparc64-linux-ld: drivers/net/wireless/ralink/rt2x00/rt2800lib.o: in function `rt2800_sta_add':
>> drivers/net/wireless/ralink/rt2x00/rt2800lib.c:1914:(.text+0x6dc0): undefined reference to `rt2x00lib_get_bssidx'
   sparc64-linux-ld: drivers/net/wireless/ralink/rt2x00/rt2800lib.o: in function `rt2800_conf_tx':
>> drivers/net/wireless/ralink/rt2x00/rt2800lib.c:12159:(.text+0xbaf8): undefined reference to `rt2x00mac_conf_tx'
   sparc64-linux-ld: drivers/net/wireless/ralink/rt2x00/rt2800lib.o: in function `rt2800_txstatus_timeout':
   drivers/net/wireless/ralink/rt2x00/rt2800lib.c:1185:(.text+0xc00c): undefined reference to `rt2x00queue_get_entry'
   sparc64-linux-ld: drivers/net/wireless/ralink/rt2x00/rt2800lib.o: in function `rt2800_txdone_nostatus':
>> drivers/net/wireless/ralink/rt2x00/rt2800lib.c:1233:(.text+0xc0f0): undefined reference to `rt2x00lib_txdone_noinfo'
   sparc64-linux-ld: drivers/net/wireless/ralink/rt2x00/rt2800lib.c:1225:(.text+0xc108): undefined reference to `rt2x00queue_get_entry'
   sparc64-linux-ld: drivers/net/wireless/ralink/rt2x00/rt2800lib.o: in function `rt2800_txdone_entry':
>> drivers/net/wireless/ralink/rt2x00/rt2800lib.c:1112:(.text+0xe64c): undefined reference to `rt2x00lib_txdone_nomatch'
>> sparc64-linux-ld: drivers/net/wireless/ralink/rt2x00/rt2800lib.c:1115:(.text+0xe72c): undefined reference to `rt2x00lib_txdone'
   sparc64-linux-ld: drivers/net/wireless/ralink/rt2x00/rt2800lib.o: in function `rt2800_txdone':
   drivers/net/wireless/ralink/rt2x00/rt2800lib.c:1142:(.text+0xe890): undefined reference to `rt2x00queue_get_entry'
   sparc64-linux-ld: drivers/net/wireless/ralink/rt2x00/rt2800lib.o: in function `rt2800_validate_eeprom':
>> drivers/net/wireless/ralink/rt2x00/rt2800lib.c:11014:(.text+0x189b4): undefined reference to `rt2x00lib_set_mac_address'
   sparc64-linux-ld: drivers/net/wireless/ralink/rt2x00/rt2800mmio.o: in function `rt2800mmio_get_dma_done':
>> drivers/net/wireless/ralink/rt2x00/rt2800mmio.c:45:(.text+0x654): undefined reference to `rt2x00queue_get_entry'
   sparc64-linux-ld: drivers/net/wireless/ralink/rt2x00/rt2800mmio.o: in function `rt2800mmio_pretbtt_tasklet':
>> drivers/net/wireless/ralink/rt2x00/rt2800mmio.c:217:(.text+0x83c): undefined reference to `rt2x00lib_pretbtt'
   sparc64-linux-ld: drivers/net/wireless/ralink/rt2x00/rt2800mmio.o: in function `rt2800mmio_tbtt_tasklet':
>> drivers/net/wireless/ralink/rt2x00/rt2800mmio.c:229:(.text+0x8c8): undefined reference to `rt2x00lib_beacondone'
   sparc64-linux-ld: drivers/net/wireless/ralink/rt2x00/rt2800mmio.o: in function `rt2800mmio_kick_queue':
   drivers/net/wireless/ralink/rt2x00/rt2800mmio.c:466:(.text+0x1b7c): undefined reference to `rt2x00queue_get_entry'
>> sparc64-linux-ld: drivers/net/wireless/ralink/rt2x00/rt2800mmio.c:473:(.text+0x1be0): undefined reference to `rt2x00queue_get_entry'
   sparc64-linux-ld: drivers/net/wireless/ralink/rt2x00/rt2800soc.o: in function `rt2x00soc_resume':
>> drivers/net/wireless/ralink/rt2x00/rt2800soc.c:247:(.text+0x98): undefined reference to `rt2x00lib_resume'
   sparc64-linux-ld: drivers/net/wireless/ralink/rt2x00/rt2800soc.o: in function `rt2x00soc_suspend':
>> drivers/net/wireless/ralink/rt2x00/rt2800soc.c:239:(.text+0xc4): undefined reference to `rt2x00lib_suspend'
   sparc64-linux-ld: drivers/net/wireless/ralink/rt2x00/rt2800soc.o: in function `rt2x00soc_remove':
>> drivers/net/wireless/ralink/rt2x00/rt2800soc.c:228:(.text+0x128): undefined reference to `rt2x00lib_remove_dev'
   sparc64-linux-ld: drivers/net/wireless/ralink/rt2x00/rt2800soc.o: in function `rt2x00soc_probe':
>> drivers/net/wireless/ralink/rt2x00/rt2800soc.c:205:(.text+0x758): undefined reference to `rt2x00lib_probe_dev'
   sparc64-linux-ld: drivers/net/wireless/ralink/rt2x00/rt2800soc.o:drivers/net/wireless/ralink/rt2x00/rt2800soc.c:251:(.rodata+0x480): undefined reference to `rt2x00mac_tx'
   sparc64-linux-ld: drivers/net/wireless/ralink/rt2x00/rt2800soc.o:(.rodata+0x488): undefined reference to `rt2x00mac_start'
   sparc64-linux-ld: drivers/net/wireless/ralink/rt2x00/rt2800soc.o:(.rodata+0x490): undefined reference to `rt2x00mac_stop'
   sparc64-linux-ld: drivers/net/wireless/ralink/rt2x00/rt2800soc.o:(.rodata+0x4b0): undefined reference to `rt2x00mac_add_interface'
   sparc64-linux-ld: drivers/net/wireless/ralink/rt2x00/rt2800soc.o:(.rodata+0x4c0): undefined reference to `rt2x00mac_remove_interface'
   sparc64-linux-ld: drivers/net/wireless/ralink/rt2x00/rt2800soc.o:(.rodata+0x4c8): undefined reference to `rt2x00mac_config'
   sparc64-linux-ld: drivers/net/wireless/ralink/rt2x00/rt2800soc.o:(.rodata+0x4d0): undefined reference to `rt2x00mac_bss_info_changed'
   sparc64-linux-ld: drivers/net/wireless/ralink/rt2x00/rt2800soc.o:(.rodata+0x500): undefined reference to `rt2x00mac_configure_filter'
   sparc64-linux-ld: drivers/net/wireless/ralink/rt2x00/rt2800soc.o:(.rodata+0x518): undefined reference to `rt2x00mac_set_key'
   sparc64-linux-ld: drivers/net/wireless/ralink/rt2x00/rt2800soc.o:(.rodata+0x558): undefined reference to `rt2x00mac_sw_scan_start'
   sparc64-linux-ld: drivers/net/wireless/ralink/rt2x00/rt2800soc.o:(.rodata+0x560): undefined reference to `rt2x00mac_sw_scan_complete'
   sparc64-linux-ld: drivers/net/wireless/ralink/rt2x00/rt2800soc.o:(.rodata+0x568): undefined reference to `rt2x00mac_get_stats'
   sparc64-linux-ld: drivers/net/wireless/ralink/rt2x00/rt2800soc.o:(.rodata+0x618): undefined reference to `rt2x00mac_rfkill_poll'
   sparc64-linux-ld: drivers/net/wireless/ralink/rt2x00/rt2800soc.o:(.rodata+0x628): undefined reference to `rt2x00mac_flush'
   sparc64-linux-ld: drivers/net/wireless/ralink/rt2x00/rt2800soc.o:(.rodata+0x668): undefined reference to `rt2x00mac_get_ringparam'
   sparc64-linux-ld: drivers/net/wireless/ralink/rt2x00/rt2800soc.o:(.rodata+0x670): undefined reference to `rt2x00mac_tx_frames_pending'
   sparc64-linux-ld: drivers/net/wireless/ralink/rt2x00/rt2800soc.o:(.rodata+0x6f8): undefined reference to `rt2x00mac_reconfig_complete'


vim +247 drivers/net/wireless/ralink/rt2x00/rt2800soc.c

   173	
   174	static int rt2x00soc_probe(struct platform_device *pdev, const struct rt2x00_ops *ops)
   175	{
   176		struct ieee80211_hw *hw;
   177		struct rt2x00_dev *rt2x00dev;
   178		int retval;
   179	
   180		hw = ieee80211_alloc_hw(sizeof(struct rt2x00_dev), ops->hw);
   181		if (!hw) {
   182			rt2x00_probe_err("Failed to allocate hardware\n");
   183			return -ENOMEM;
   184		}
   185	
   186		platform_set_drvdata(pdev, hw);
   187	
   188		rt2x00dev = hw->priv;
   189		rt2x00dev->dev = &pdev->dev;
   190		rt2x00dev->ops = ops;
   191		rt2x00dev->hw = hw;
   192		rt2x00dev->irq = platform_get_irq(pdev, 0);
   193		rt2x00dev->name = pdev->dev.driver->name;
   194	
   195		rt2x00dev->clk = clk_get(&pdev->dev, NULL);
   196		if (IS_ERR(rt2x00dev->clk))
   197			rt2x00dev->clk = NULL;
   198	
   199		rt2x00_set_chip_intf(rt2x00dev, RT2X00_CHIP_INTF_SOC);
   200	
   201		retval = rt2x00soc_alloc_reg(rt2x00dev);
   202		if (retval)
   203			goto exit_free_device;
   204	
 > 205		retval = rt2x00lib_probe_dev(rt2x00dev);
   206		if (retval)
   207			goto exit_free_reg;
   208	
   209		return 0;
   210	
   211	exit_free_reg:
   212		rt2x00soc_free_reg(rt2x00dev);
   213	
   214	exit_free_device:
   215		ieee80211_free_hw(hw);
   216	
   217		return retval;
   218	}
   219	
   220	static void rt2x00soc_remove(struct platform_device *pdev)
   221	{
   222		struct ieee80211_hw *hw = platform_get_drvdata(pdev);
   223		struct rt2x00_dev *rt2x00dev = hw->priv;
   224	
   225		/*
   226		 * Free all allocated data.
   227		 */
 > 228		rt2x00lib_remove_dev(rt2x00dev);
   229		rt2x00soc_free_reg(rt2x00dev);
   230		ieee80211_free_hw(hw);
   231	}
   232	
   233	#ifdef CONFIG_PM
   234	static int rt2x00soc_suspend(struct platform_device *pdev, pm_message_t state)
   235	{
   236		struct ieee80211_hw *hw = platform_get_drvdata(pdev);
   237		struct rt2x00_dev *rt2x00dev = hw->priv;
   238	
 > 239		return rt2x00lib_suspend(rt2x00dev);
   240	}
   241	
   242	static int rt2x00soc_resume(struct platform_device *pdev)
   243	{
   244		struct ieee80211_hw *hw = platform_get_drvdata(pdev);
   245		struct rt2x00_dev *rt2x00dev = hw->priv;
   246	
 > 247		return rt2x00lib_resume(rt2x00dev);
   248	}
   249	#endif /* CONFIG_PM */
   250	
 > 251	static const struct ieee80211_ops rt2800soc_mac80211_ops = {
   252		.add_chanctx = ieee80211_emulate_add_chanctx,
   253		.remove_chanctx = ieee80211_emulate_remove_chanctx,
   254		.change_chanctx = ieee80211_emulate_change_chanctx,
   255		.switch_vif_chanctx = ieee80211_emulate_switch_vif_chanctx,
   256		.tx			= rt2x00mac_tx,
   257		.wake_tx_queue		= ieee80211_handle_wake_tx_queue,
   258		.start			= rt2x00mac_start,
   259		.stop			= rt2x00mac_stop,
   260		.add_interface		= rt2x00mac_add_interface,
   261		.remove_interface	= rt2x00mac_remove_interface,
   262		.config			= rt2x00mac_config,
   263		.configure_filter	= rt2x00mac_configure_filter,
   264		.set_key		= rt2x00mac_set_key,
   265		.sw_scan_start		= rt2x00mac_sw_scan_start,
   266		.sw_scan_complete	= rt2x00mac_sw_scan_complete,
   267		.get_stats		= rt2x00mac_get_stats,
   268		.get_key_seq		= rt2800_get_key_seq,
   269		.set_rts_threshold	= rt2800_set_rts_threshold,
   270		.sta_add		= rt2800_sta_add,
   271		.sta_remove		= rt2800_sta_remove,
   272		.bss_info_changed	= rt2x00mac_bss_info_changed,
   273		.conf_tx		= rt2800_conf_tx,
   274		.get_tsf		= rt2800_get_tsf,
   275		.rfkill_poll		= rt2x00mac_rfkill_poll,
   276		.ampdu_action		= rt2800_ampdu_action,
   277		.flush			= rt2x00mac_flush,
   278		.get_survey		= rt2800_get_survey,
   279		.get_ringparam		= rt2x00mac_get_ringparam,
   280		.tx_frames_pending	= rt2x00mac_tx_frames_pending,
   281		.reconfig_complete	= rt2x00mac_reconfig_complete,
   282	};
   283	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


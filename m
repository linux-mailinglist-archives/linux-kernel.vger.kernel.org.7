Return-Path: <linux-kernel+bounces-870722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DBDC0B879
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 01:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8040F4E9E9F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 00:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFA9225788;
	Mon, 27 Oct 2025 00:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JKubzN5Z"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B75224AF7
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 00:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761524711; cv=none; b=OcnXkfxe6ZN140AC3qdp0VmgMhAhNgIbYj/DW0U1wYDe5zjTXWiUp8Icv1RzRuhZ65ilaa9FU+4f67W9E1MzNnm1sBXioBNPiTyAf+mUYP2Xeo+uwGr1ZaFTNk1Ijeb9CppqpCnZ9EQeDrhk9KNXXU6GZScH/h99VoRV1b3qtow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761524711; c=relaxed/simple;
	bh=EZBx/QSKA+L0ZjxjlNK2T3HBfnc6rlShDQIJF6AQaQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Za1lBL4pSqhFb8/Z2ExQAC4XQwO/OhPjj2TrAzYA6GF3BV5VeR4Cuyw/IKI9aXXGnoiUQNVsDJ+8qN/ZHbz0rjfXawvtynodURe4G6TVfchd8qC1KLR6mKcj/qrEptlsIv3Bbd76rvQ59BizZSzTxAYyQwkdB/Hk1KXPyDHmwqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JKubzN5Z; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761524709; x=1793060709;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EZBx/QSKA+L0ZjxjlNK2T3HBfnc6rlShDQIJF6AQaQ0=;
  b=JKubzN5ZLqHAaSg63zi56J3KT8zLbRTTXY7NnoF2xXqUAQofFbk0/tNO
   Jq4nBynUe8DMtXSvjQWnA9MV89XMnPf1i37/VeRu1+3XjiGMQpvDQy2RW
   K10HuyxYL+e1y87uWAeQaNr0oh3ck1fyNq3+czh+8my/5Eq6wQngzRADn
   jM95jp+svb1p0hlEo3+MpAOUV+OhO0oXxmvSKuxRW6bvmB7/WVZn+Pf8u
   KcULcho5hEbVKJmZvlHRniPZSZQ1kE8p0tDOBDG+jJQHtkYsRZE5yt0Ai
   p1pVDdht+NxY7T61A0PFWPmUVXvEIa6WiB/YmRRK8aIA4FMeumMC2I0f8
   g==;
X-CSE-ConnectionGUID: Tts75UcQSMOw9R5rodNnmw==
X-CSE-MsgGUID: uhTMpkAWRHW4XOpZeUcxvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74948964"
X-IronPort-AV: E=Sophos;i="6.19,257,1754982000"; 
   d="scan'208";a="74948964"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2025 17:25:06 -0700
X-CSE-ConnectionGUID: ySgcXEVDSbW8178E1HI2Xw==
X-CSE-MsgGUID: VmBD7t02QW+VBK4HGu5vCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,257,1754982000"; 
   d="scan'208";a="184806324"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 26 Oct 2025 17:25:05 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vDB2k-000GPp-22;
	Mon, 27 Oct 2025 00:25:02 +0000
Date: Mon, 27 Oct 2025 08:24:18 +0800
From: kernel test robot <lkp@intel.com>
To: LiangCheng Wang <zaq14760@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: drivers/gpu/drm/tiny/pixpaper.c:579:12: warning: stack frame size
 (20024) exceeds limit (8192) in 'pixpaper_panel_hw_init'
Message-ID: <202510270858.1GzE6iQg-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4bb1f7e19c4a1d6eeb52b80acff5ac63edd1b91d
commit: c9e70639f5915f2d084a0126e62fe53a52c29cea drm: tiny: Add support for Mayqueen Pixpaper e-ink panel
date:   7 weeks ago
config: x86_64-randconfig-123-20251027 (https://download.01.org/0day-ci/archive/20251027/202510270858.1GzE6iQg-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251027/202510270858.1GzE6iQg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510270858.1GzE6iQg-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/tiny/pixpaper.c:579:12: warning: stack frame size (20024) exceeds limit (8192) in 'pixpaper_panel_hw_init' [-Wframe-larger-than]
     579 | static int pixpaper_panel_hw_init(struct pixpaper_panel *panel)
         |            ^
   1 warning generated.


vim +/pixpaper_panel_hw_init +579 drivers/gpu/drm/tiny/pixpaper.c

   578	
 > 579	static int pixpaper_panel_hw_init(struct pixpaper_panel *panel)
   580	{
   581		struct pixpaper_error_ctx err = { .errno_code = 0 };
   582	
   583		gpiod_set_value_cansleep(panel->reset, 0);
   584		msleep(50);
   585		gpiod_set_value_cansleep(panel->reset, 1);
   586		msleep(50);
   587	
   588		pixpaper_wait_for_panel(panel);
   589	
   590		pixpaper_send_cmd(panel, PIXPAPER_CMD_UNKNOWN_4D, &err);
   591		pixpaper_send_data(panel, PIXPAPER_UNKNOWN_4D_CONFIG, &err);
   592		if (err.errno_code)
   593			goto init_fail;
   594		pixpaper_wait_for_panel(panel);
   595	
   596		pixpaper_send_cmd(panel, PIXPAPER_CMD_PANEL_SETTING, &err);
   597		pixpaper_send_data(panel, PIXPAPER_PSR_CONFIG, &err);
   598		pixpaper_send_data(panel, PIXPAPER_PSR_CONFIG2, &err);
   599		if (err.errno_code)
   600			goto init_fail;
   601		pixpaper_wait_for_panel(panel);
   602	
   603		pixpaper_send_cmd(panel, PIXPAPER_CMD_POWER_SETTING, &err);
   604		pixpaper_send_data(panel, PIXPAPER_PWR_CONFIG1, &err);
   605		pixpaper_send_data(panel, PIXPAPER_PWR_CONFIG2, &err);
   606		pixpaper_send_data(panel, PIXPAPER_PWR_VSP_8_2V, &err);
   607		pixpaper_send_data(panel, PIXPAPER_PWR_VSPL_15V, &err);
   608		pixpaper_send_data(panel, PIXPAPER_PWR_VSN_4V, &err);
   609		pixpaper_send_data(panel, PIXPAPER_PWR_VSP_8_2V, &err);
   610		if (err.errno_code)
   611			goto init_fail;
   612		pixpaper_wait_for_panel(panel);
   613	
   614		pixpaper_send_cmd(panel, PIXPAPER_CMD_POWER_OFF_SEQUENCE, &err);
   615		pixpaper_send_data(panel, PIXPAPER_PFS_CONFIG1, &err);
   616		pixpaper_send_data(panel, PIXPAPER_PFS_CONFIG2, &err);
   617		pixpaper_send_data(panel, PIXPAPER_PFS_CONFIG3, &err);
   618		if (err.errno_code)
   619			goto init_fail;
   620		pixpaper_wait_for_panel(panel);
   621	
   622		pixpaper_send_cmd(panel, PIXPAPER_CMD_BOOSTER_SOFT_START, &err);
   623		pixpaper_send_data(panel, PIXPAPER_BTST_CONFIG1, &err);
   624		pixpaper_send_data(panel, PIXPAPER_BTST_CONFIG2, &err);
   625		pixpaper_send_data(panel, PIXPAPER_BTST_CONFIG3, &err);
   626		pixpaper_send_data(panel, PIXPAPER_BTST_CONFIG4, &err);
   627		pixpaper_send_data(panel, PIXPAPER_BTST_CONFIG5, &err);
   628		pixpaper_send_data(panel, PIXPAPER_BTST_CONFIG6, &err);
   629		pixpaper_send_data(panel, PIXPAPER_BTST_CONFIG7, &err);
   630		if (err.errno_code)
   631			goto init_fail;
   632		pixpaper_wait_for_panel(panel);
   633	
   634		pixpaper_send_cmd(panel, PIXPAPER_CMD_PLL_CONTROL, &err);
   635		pixpaper_send_data(panel, PIXPAPER_PLL_CONFIG, &err);
   636		if (err.errno_code)
   637			goto init_fail;
   638		pixpaper_wait_for_panel(panel);
   639	
   640		pixpaper_send_cmd(panel, PIXPAPER_CMD_TEMP_SENSOR_CALIB, &err);
   641		pixpaper_send_data(panel, PIXPAPER_TSE_CONFIG, &err);
   642		if (err.errno_code)
   643			goto init_fail;
   644		pixpaper_wait_for_panel(panel);
   645	
   646		pixpaper_send_cmd(panel, PIXPAPER_CMD_VCOM_INTERVAL, &err);
   647		pixpaper_send_data(panel, PIXPAPER_CDI_CONFIG, &err);
   648		if (err.errno_code)
   649			goto init_fail;
   650		pixpaper_wait_for_panel(panel);
   651	
   652		pixpaper_send_cmd(panel, PIXPAPER_CMD_UNKNOWN_60, &err);
   653		pixpaper_send_data(panel, PIXPAPER_UNKNOWN_60_CONFIG1, &err);
   654		pixpaper_send_data(panel, PIXPAPER_UNKNOWN_60_CONFIG2, &err);
   655		if (err.errno_code)
   656			goto init_fail;
   657		pixpaper_wait_for_panel(panel);
   658	
   659		pixpaper_send_cmd(panel, PIXPAPER_CMD_RESOLUTION_SETTING, &err);
   660		pixpaper_send_data(panel, PIXPAPER_TRES_HRES_H, &err);
   661		pixpaper_send_data(panel, PIXPAPER_TRES_HRES_L, &err);
   662		pixpaper_send_data(panel, PIXPAPER_TRES_VRES_H, &err);
   663		pixpaper_send_data(panel, PIXPAPER_TRES_VRES_L, &err);
   664		if (err.errno_code)
   665			goto init_fail;
   666		pixpaper_wait_for_panel(panel);
   667	
   668		pixpaper_send_cmd(panel, PIXPAPER_CMD_GATE_SOURCE_START, &err);
   669		pixpaper_send_data(panel, PIXPAPER_GSST_S_START, &err);
   670		pixpaper_send_data(panel, PIXPAPER_GSST_RESERVED, &err);
   671		pixpaper_send_data(panel, PIXPAPER_GSST_G_START_H, &err);
   672		pixpaper_send_data(panel, PIXPAPER_GSST_G_START_L, &err);
   673		if (err.errno_code)
   674			goto init_fail;
   675		pixpaper_wait_for_panel(panel);
   676	
   677		pixpaper_send_cmd(panel, PIXPAPER_CMD_UNKNOWN_E7, &err);
   678		pixpaper_send_data(panel, PIXPAPER_UNKNOWN_E7_CONFIG, &err);
   679		if (err.errno_code)
   680			goto init_fail;
   681		pixpaper_wait_for_panel(panel);
   682	
   683		pixpaper_send_cmd(panel, PIXPAPER_CMD_POWER_SAVING, &err);
   684		pixpaper_send_data(panel, PIXPAPER_PWS_CONFIG, &err);
   685		if (err.errno_code)
   686			goto init_fail;
   687		pixpaper_wait_for_panel(panel);
   688	
   689		pixpaper_send_cmd(panel, PIXPAPER_CMD_UNKNOWN_E0, &err);
   690		pixpaper_send_data(panel, PIXPAPER_UNKNOWN_E0_CONFIG, &err);
   691		if (err.errno_code)
   692			goto init_fail;
   693		pixpaper_wait_for_panel(panel);
   694	
   695		pixpaper_send_cmd(panel, PIXPAPER_CMD_UNKNOWN_B4, &err);
   696		pixpaper_send_data(panel, PIXPAPER_UNKNOWN_B4_CONFIG, &err);
   697		if (err.errno_code)
   698			goto init_fail;
   699		pixpaper_wait_for_panel(panel);
   700	
   701		pixpaper_send_cmd(panel, PIXPAPER_CMD_UNKNOWN_B5, &err);
   702		pixpaper_send_data(panel, PIXPAPER_UNKNOWN_B5_CONFIG, &err);
   703		if (err.errno_code)
   704			goto init_fail;
   705		pixpaper_wait_for_panel(panel);
   706	
   707		pixpaper_send_cmd(panel, PIXPAPER_CMD_UNKNOWN_E9, &err);
   708		pixpaper_send_data(panel, PIXPAPER_UNKNOWN_E9_CONFIG, &err);
   709		if (err.errno_code)
   710			goto init_fail;
   711		pixpaper_wait_for_panel(panel);
   712	
   713		return 0;
   714	
   715	init_fail:
   716		drm_err(&panel->drm, "Hardware initialization failed (err=%d)\n",
   717			err.errno_code);
   718		return err.errno_code;
   719	}
   720	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


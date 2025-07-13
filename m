Return-Path: <linux-kernel+bounces-729107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E62F7B031E2
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 17:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6A031899DF1
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 15:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7574E27E045;
	Sun, 13 Jul 2025 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UhEYS8a/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45F41F03DE
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 15:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752421918; cv=none; b=un3EX88xFMERHa+zf9t6bW0bfflZHqMxZRCg//v8Wxebb/vp4Wya0QOnbzqPXpf/I+CUY7LUeTdR/GKctmhQ7CkMANVoRIJUcJVrERzs83FvCa8MfNgyqnjdX0MzGc5Xo2VVhO1NyX+4JN/T1YulOUop2MMr6kJE58NbK4pDa0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752421918; c=relaxed/simple;
	bh=3UpAE3/uUui7Url7V3AweJhoOTChHdBR1c98anlmbGY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Y1KHDCxNQKX8wnVqddDV4NOqQRK1Pr03NLGSeiB96C7mLv/01NmMeaPqQ4brbVcoo5snTJjTf/zLYezDrlI4Q0fM1jzY0/Qvd4S/iV5ktPUZ/AH0CbyLHB/KTwsgFlA2BVFq8W4t6QlNGrgJH5dfstgkh9bYpbTWqbMYbJGciXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UhEYS8a/; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752421917; x=1783957917;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3UpAE3/uUui7Url7V3AweJhoOTChHdBR1c98anlmbGY=;
  b=UhEYS8a/oP3KhOhTAtRSS9U8KF83oUeoUJFkPGgi/tlfjAv96NYecopD
   qRBYCiYRbsMQVWJylVkGQdaiEyj8Zc6uNbD9R6UFsT82DpyPCWe08DAqT
   JvWYgGBgPpQk8pq8SQUIrOn80i4A1DOtrQF4EmBTdsbYW2uayPci961PO
   RJmjZcHuTEJWqsVUbvdHB98KgNhWOddI/ws6qViJKZ1XNgkbeFuz8mGcJ
   0/Ad8fd1RRsL+tEoy8Sv0LAy7HI30FjqHXlFvR6Cg60ZJfsP5H9fCPJqe
   uP5hYz2Axr25I/QWD/JTVK4P2NxgUwhpwtRmUQ5LojMZAxnMw5DvBwm53
   w==;
X-CSE-ConnectionGUID: Y1bDHkepQDeAzOrihDpp4Q==
X-CSE-MsgGUID: EKic8qn8Rm2hVJ6cIuXNlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="42267298"
X-IronPort-AV: E=Sophos;i="6.16,308,1744095600"; 
   d="scan'208";a="42267298"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 08:51:56 -0700
X-CSE-ConnectionGUID: J14evWjuSN2iE83M3qZnWQ==
X-CSE-MsgGUID: MVL/Vp8rSjuxKuNN0dIuSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,308,1744095600"; 
   d="scan'208";a="156168636"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 13 Jul 2025 08:51:55 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uayzY-00089x-0B;
	Sun, 13 Jul 2025 15:51:52 +0000
Date: Sun, 13 Jul 2025 23:50:56 +0800
From: kernel test robot <lkp@intel.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Subject: drivers/net/wireless/ath/ath12k/mac.c:9785:2-3: Unneeded semicolon
Message-ID: <202507132355.ljWuxxjd-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3f31a806a62e44f7498e2d17719c03f816553f11
commit: cccbb9d0dd6ab9e3353066217e9ab5b44bd761d3 wifi: ath12k: add parse of transmit power envelope element
date:   8 weeks ago
config: riscv-randconfig-r063-20250713 (https://download.01.org/0day-ci/archive/20250713/202507132355.ljWuxxjd-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 13.4.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507132355.ljWuxxjd-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/net/wireless/ath/ath12k/mac.c:9785:2-3: Unneeded semicolon

vim +9785 drivers/net/wireless/ath/ath12k/mac.c

  9754	
  9755	static void ath12k_mac_parse_tx_pwr_env(struct ath12k *ar,
  9756						struct ath12k_link_vif *arvif)
  9757	{
  9758		struct ieee80211_bss_conf *bss_conf = ath12k_mac_get_link_bss_conf(arvif);
  9759		struct ath12k_reg_tpc_power_info *tpc_info = &arvif->reg_tpc_info;
  9760		struct ieee80211_parsed_tpe_eirp *local_non_psd, *reg_non_psd;
  9761		struct ieee80211_parsed_tpe_psd *local_psd, *reg_psd;
  9762		struct ieee80211_parsed_tpe *tpe = &bss_conf->tpe;
  9763		enum wmi_reg_6g_client_type client_type;
  9764		struct ath12k_reg_info *reg_info;
  9765		struct ath12k_base *ab = ar->ab;
  9766		bool psd_valid, non_psd_valid;
  9767		int i;
  9768	
  9769		reg_info = ab->reg_info[ar->pdev_idx];
  9770		client_type = reg_info->client_type;
  9771	
  9772		local_psd = &tpe->psd_local[client_type];
  9773		reg_psd = &tpe->psd_reg_client[client_type];
  9774		local_non_psd = &tpe->max_local[client_type];
  9775		reg_non_psd = &tpe->max_reg_client[client_type];
  9776	
  9777		psd_valid = local_psd->valid | reg_psd->valid;
  9778		non_psd_valid = local_non_psd->valid | reg_non_psd->valid;
  9779	
  9780		if (!psd_valid && !non_psd_valid) {
  9781			ath12k_warn(ab,
  9782				    "no transmit power envelope match client power type %d\n",
  9783				    client_type);
  9784			return;
> 9785		};
  9786	
  9787		if (psd_valid) {
  9788			tpc_info->is_psd_power = true;
  9789	
  9790			tpc_info->num_pwr_levels = max(local_psd->count,
  9791						       reg_psd->count);
  9792			if (tpc_info->num_pwr_levels > ATH12K_NUM_PWR_LEVELS)
  9793				tpc_info->num_pwr_levels = ATH12K_NUM_PWR_LEVELS;
  9794	
  9795			for (i = 0; i < tpc_info->num_pwr_levels; i++) {
  9796				tpc_info->tpe[i] = min(local_psd->power[i],
  9797						       reg_psd->power[i]) / 2;
  9798				ath12k_dbg(ab, ATH12K_DBG_MAC,
  9799					   "TPE PSD power[%d] : %d\n",
  9800					   i, tpc_info->tpe[i]);
  9801			}
  9802		} else {
  9803			tpc_info->is_psd_power = false;
  9804			tpc_info->eirp_power = 0;
  9805	
  9806			tpc_info->num_pwr_levels = max(local_non_psd->count,
  9807						       reg_non_psd->count);
  9808			if (tpc_info->num_pwr_levels > ATH12K_NUM_PWR_LEVELS)
  9809				tpc_info->num_pwr_levels = ATH12K_NUM_PWR_LEVELS;
  9810	
  9811			for (i = 0; i < tpc_info->num_pwr_levels; i++) {
  9812				tpc_info->tpe[i] = min(local_non_psd->power[i],
  9813						       reg_non_psd->power[i]) / 2;
  9814				ath12k_dbg(ab, ATH12K_DBG_MAC,
  9815					   "non PSD power[%d] : %d\n",
  9816					   i, tpc_info->tpe[i]);
  9817			}
  9818		}
  9819	}
  9820	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


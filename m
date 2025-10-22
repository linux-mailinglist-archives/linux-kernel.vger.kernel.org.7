Return-Path: <linux-kernel+bounces-864063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DED55BF9D39
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 05:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7867C19C68AA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DFB27815B;
	Wed, 22 Oct 2025 03:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DlDELDtd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A944278E41
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761103549; cv=none; b=bzWFyLxbA+hDBjXARXtCNArcQ+m1Xsux8Bfkuh33N+2WxORxKI4PZBo8RjufKxk6oC6tiezDTeimTwbV/x6NPrW0QN1Dqq6ZoG5v0Agm9L/ESNgbiFfhMYTMqD5FpwxdeetHk5joczj9nNhVlc3AeD1ki3htlR7otNpTvZMsyjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761103549; c=relaxed/simple;
	bh=SFFOKMRcTpJPMC01RBcOP0ECWNtMV07kJukJoZ4HMJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Du+Y63T3JpCS7pYsGGtMkYBFyeO6Sq78PWdt3Ejl3eMFKA6y+a7NfsuOR7bc91EG7PY+StSQKjVf9PO6shynVTcexggJyxLjY+yDf4/7YjdAs4qvPYF1CV3ezTteUGuTbHllKz0iou1yNz+v55xq5U6IoZTCCRHrBquC6lMW9nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DlDELDtd; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761103546; x=1792639546;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SFFOKMRcTpJPMC01RBcOP0ECWNtMV07kJukJoZ4HMJ0=;
  b=DlDELDtdvJ9pOOJA2Aa/sZTHy9p39lFxpuz/MGOlP1J1Vv6VANgxZzW7
   Qp2VWz3yFZwy+7ijDOXDV8DmE4wn5WcjphGYaK+JHzhUi+mralVuN7rMG
   xEHw3W/mqqlHVW5yI367ERske/uN8/lDyUlqVBnuotoLypqUZYYP6JBHy
   RHE7DvyXcFIvcYYiOtO/28HPulAa5q//FjjS/VGCM3bxdBJOsn0Dru/24
   /uM0dt2GGrCOeD6m61JvJfnRnKEo1VNIIXDly/V6P9jMovkc3hIcpHTtz
   ReR9UGFHWdJ1tOCZxB+iqthYDsYv6VytlJjngWipAuNUqh81oZ1Xw72a/
   g==;
X-CSE-ConnectionGUID: iD5jnhTCSpSKw7YXlyT6fQ==
X-CSE-MsgGUID: Fceti+VsTn2UIsID/f/CpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="50816328"
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="50816328"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 20:25:46 -0700
X-CSE-ConnectionGUID: t880w9U3TjagKsL9E7m8KA==
X-CSE-MsgGUID: P63tbpi1RB23bDVZxJYTfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="182962299"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 21 Oct 2025 20:25:44 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vBPTD-000BxZ-35;
	Wed, 22 Oct 2025 03:25:12 +0000
Date: Wed, 22 Oct 2025 11:24:45 +0800
From: kernel test robot <lkp@intel.com>
To: Biancaa Ramesh <biancaa2210329@ssn.edu.in>,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Biancaa Ramesh <biancaa2210329@ssn.edu.in>
Subject: Re: [PATCH] ath9k_htc: fix WMI command handling and improve message
 sending
Message-ID: <202510221108.3obrzqLL-lkp@intel.com>
References: <20251021141337.33268-1-biancaa2210329@ssn.edu.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021141337.33268-1-biancaa2210329@ssn.edu.in>

Hi Biancaa,

kernel test robot noticed the following build errors:

[auto build test ERROR on ath/ath-next]
[also build test ERROR on linus/master v6.18-rc2 next-20251021]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Biancaa-Ramesh/ath9k_htc-fix-WMI-command-handling-and-improve-message-sending/20251021-221643
base:   https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git ath-next
patch link:    https://lore.kernel.org/r/20251021141337.33268-1-biancaa2210329%40ssn.edu.in
patch subject: [PATCH] ath9k_htc: fix WMI command handling and improve message sending
config: i386-randconfig-141-20251022 (https://download.01.org/0day-ci/archive/20251022/202510221108.3obrzqLL-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251022/202510221108.3obrzqLL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510221108.3obrzqLL-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/net/wireless/ath/ath9k/htc.h:33,
                    from drivers/net/wireless/ath/ath9k/htc_drv_main.c:17:
   drivers/net/wireless/ath/ath9k/htc_drv_main.c: In function 'ath9k_htc_add_monitor_interface':
>> drivers/net/wireless/ath/ath9k/wmi.h:202:9: error: expected expression before 'do'
     202 |         do {                                                            \
         |         ^~
   drivers/net/wireless/ath/ath9k/htc_drv_main.c:371:11: note: in expansion of macro 'WMI_CMD_BUF'
     371 |     ret = WMI_CMD_BUF(WMI_VAP_CREATE_CMDID, &hvif);
         |           ^~~~~~~~~~~
>> drivers/net/wireless/ath/ath9k/wmi.h:202:9: error: expected expression before 'do'
     202 |         do {                                                            \
         |         ^~
   drivers/net/wireless/ath/ath9k/htc_drv_main.c:389:11: note: in expansion of macro 'WMI_CMD_BUF'
     389 |     ret = WMI_CMD_BUF(WMI_NODE_CREATE_CMDID, &tsta);
         |           ^~~~~~~~~~~
>> drivers/net/wireless/ath/ath9k/htc_drv_main.c:356:8: warning: unused variable 'cmd_rsp' [-Wunused-variable]
     356 |     u8 cmd_rsp;
         |        ^~~~~~~


vim +/cmd_rsp +356 drivers/net/wireless/ath/ath9k/htc_drv_main.c

cc72128750700d0 Sujith Manoharan   2011-01-03  349  
81fc2a332045dc1 Rajkumar Manoharan 2010-11-26  350  static int ath9k_htc_add_monitor_interface(struct ath9k_htc_priv *priv)
81fc2a332045dc1 Rajkumar Manoharan 2010-11-26  351  {
81fc2a332045dc1 Rajkumar Manoharan 2010-11-26  352      struct ath_common *common = ath9k_hw_common(priv->ah);
81fc2a332045dc1 Rajkumar Manoharan 2010-11-26  353      struct ath9k_htc_target_vif hvif;
cc72128750700d0 Sujith Manoharan   2011-01-03  354      struct ath9k_htc_target_sta tsta;
a97b478c92c1425 Sujith Manoharan   2011-02-21  355      int ret = 0, sta_idx;
81fc2a332045dc1 Rajkumar Manoharan 2010-11-26 @356      u8 cmd_rsp;
81fc2a332045dc1 Rajkumar Manoharan 2010-11-26  357  
a97b478c92c1425 Sujith Manoharan   2011-02-21  358      if ((priv->nvifs >= ATH9K_HTC_MAX_VIF) ||
34af6f1f3df95cb Biancaa Ramesh     2025-10-21  359          (priv->nstations >= ATH9K_HTC_MAX_STA))
34af6f1f3df95cb Biancaa Ramesh     2025-10-21  360          return -ENOBUFS;
81fc2a332045dc1 Rajkumar Manoharan 2010-11-26  361  
a97b478c92c1425 Sujith Manoharan   2011-02-21  362      sta_idx = ffz(priv->sta_slot);
34af6f1f3df95cb Biancaa Ramesh     2025-10-21  363      if (sta_idx < 0 || sta_idx >= ATH9K_HTC_MAX_STA)
34af6f1f3df95cb Biancaa Ramesh     2025-10-21  364          return -ENOBUFS;
cc72128750700d0 Sujith Manoharan   2011-01-03  365  
34af6f1f3df95cb Biancaa Ramesh     2025-10-21  366      memset(&hvif, 0, sizeof(hvif));
81fc2a332045dc1 Rajkumar Manoharan 2010-11-26  367      memcpy(&hvif.myaddr, common->macaddr, ETH_ALEN);
e4c62506fcfa7c1 Sujith Manoharan   2011-04-13  368      hvif.opmode = HTC_M_MONITOR;
a97b478c92c1425 Sujith Manoharan   2011-02-21  369      hvif.index = ffz(priv->vif_slot);
81fc2a332045dc1 Rajkumar Manoharan 2010-11-26  370  
34af6f1f3df95cb Biancaa Ramesh     2025-10-21 @371      ret = WMI_CMD_BUF(WMI_VAP_CREATE_CMDID, &hvif);
81fc2a332045dc1 Rajkumar Manoharan 2010-11-26  372      if (ret)
a97b478c92c1425 Sujith Manoharan   2011-02-21  373          goto err_vif;
a97b478c92c1425 Sujith Manoharan   2011-02-21  374  
a97b478c92c1425 Sujith Manoharan   2011-02-21  375      priv->mon_vif_idx = hvif.index;
a97b478c92c1425 Sujith Manoharan   2011-02-21  376      priv->vif_slot |= (1 << hvif.index);
a97b478c92c1425 Sujith Manoharan   2011-02-21  377  
a97b478c92c1425 Sujith Manoharan   2011-02-21  378      if (!priv->nvifs)
a97b478c92c1425 Sujith Manoharan   2011-02-21  379          priv->ah->opmode = NL80211_IFTYPE_MONITOR;
81fc2a332045dc1 Rajkumar Manoharan 2010-11-26  380      priv->nvifs++;
cc72128750700d0 Sujith Manoharan   2011-01-03  381  
34af6f1f3df95cb Biancaa Ramesh     2025-10-21  382      memset(&tsta, 0, sizeof(tsta));
cc72128750700d0 Sujith Manoharan   2011-01-03  383      memcpy(&tsta.macaddr, common->macaddr, ETH_ALEN);
cc72128750700d0 Sujith Manoharan   2011-01-03  384      tsta.is_vif_sta = 1;
a97b478c92c1425 Sujith Manoharan   2011-02-21  385      tsta.sta_index = sta_idx;
cc72128750700d0 Sujith Manoharan   2011-01-03  386      tsta.vif_index = hvif.index;
b97c57ff3f568b3 Sujith Manoharan   2011-04-13  387      tsta.maxampdu = cpu_to_be16(0xffff);
cc72128750700d0 Sujith Manoharan   2011-01-03  388  
34af6f1f3df95cb Biancaa Ramesh     2025-10-21  389      ret = WMI_CMD_BUF(WMI_NODE_CREATE_CMDID, &tsta);
cc72128750700d0 Sujith Manoharan   2011-01-03  390      if (ret) {
cc72128750700d0 Sujith Manoharan   2011-01-03  391          ath_err(common, "Unable to add station entry for monitor mode\n");
34af6f1f3df95cb Biancaa Ramesh     2025-10-21  392          __ath9k_htc_remove_monitor_interface(priv);
34af6f1f3df95cb Biancaa Ramesh     2025-10-21  393          return ret;
cc72128750700d0 Sujith Manoharan   2011-01-03  394      }
cc72128750700d0 Sujith Manoharan   2011-01-03  395  
a97b478c92c1425 Sujith Manoharan   2011-02-21  396      priv->sta_slot |= (1 << sta_idx);
cc72128750700d0 Sujith Manoharan   2011-01-03  397      priv->nstations++;
a97b478c92c1425 Sujith Manoharan   2011-02-21  398      priv->vif_sta_pos[priv->mon_vif_idx] = sta_idx;
55de80d64545e5c Sujith Manoharan   2011-01-05  399      priv->ah->is_monitoring = true;
55de80d64545e5c Sujith Manoharan   2011-01-05  400  
34af6f1f3df95cb Biancaa Ramesh     2025-10-21  401      ath_dbg(common, CONFIG, "Monitor interface added at idx %d, sta idx %d\n",
a97b478c92c1425 Sujith Manoharan   2011-02-21  402              priv->mon_vif_idx, sta_idx);
a97b478c92c1425 Sujith Manoharan   2011-02-21  403  
81fc2a332045dc1 Rajkumar Manoharan 2010-11-26  404      return 0;
cc72128750700d0 Sujith Manoharan   2011-01-03  405  
a97b478c92c1425 Sujith Manoharan   2011-02-21  406  err_vif:
34af6f1f3df95cb Biancaa Ramesh     2025-10-21  407      ath_dbg(common, FATAL, "Unable to attach monitor interface\n");
cc72128750700d0 Sujith Manoharan   2011-01-03  408      return ret;
81fc2a332045dc1 Rajkumar Manoharan 2010-11-26  409  }
81fc2a332045dc1 Rajkumar Manoharan 2010-11-26  410  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


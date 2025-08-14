Return-Path: <linux-kernel+bounces-767761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AACB258C6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 03:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DCA61B64639
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 01:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E3018CC1D;
	Thu, 14 Aug 2025 01:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gWOO/qE/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5502FF653
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 01:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755133920; cv=none; b=SIWaLOk0OwZvbTvoaAlUHaTjimgT5u2G8RFq4Yu9Bf3xDWs5eI+lZenyHONNBsv2nIRyn5JtZysJnb83lg5pQL5q4iYHMd987Ye7QeAFnszzRmRqHx+WZ1eXzpsqkTYv2t+bfD0Iq783DMTmIwaruUljZW3AjWx/6T98MCoYIP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755133920; c=relaxed/simple;
	bh=2rc7wuzHPJCfENd7v3BrtX9JE7TWC5vlo7EYgP7vtiU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=C7Ft1H8taXsiOcUaGlMxMEhqKW3QuLo2MJF/O5x0L4UYH2VzyIzJT3Uedv0yJ76kFxI+93B2YpF9KM52AyXb7Ru1X/NZ0RIez4Hehnc05W+tWo2Q1flG8+071tXv4t+gyELXaLY9Dp7nqXQeOjVxThpMlQYDaBq6VD4eurujPd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gWOO/qE/; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755133919; x=1786669919;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2rc7wuzHPJCfENd7v3BrtX9JE7TWC5vlo7EYgP7vtiU=;
  b=gWOO/qE/vaHHHauPSHUIl+f0ruczQQ4BeiieFYzDfcszzrF0ZJlgDj4y
   UJUaCYb8hLijz2B9YK5yVkT5YTAKl8XBLuLXb4B2OvNUOunnVJUbpJ+CJ
   M+3VCeZoQjxQXV7fCMiZBuvuiwPhVxu5VXkrJrgCHNnqojlqaHpFKuXmy
   WRqit6lgx7u2G9QDl5naSH1uOpznnsJp2aRPUFh7h5B7gCyymyl+X1Llm
   MkT+DTuKdU87N5UyA4goaiNAOQuRtnCcd2AcdHrApb2cjzeTUrjbnL5s9
   CKbwUsITUGK83b2boBRv4tz2QlMFJTpM7F7IxPSpIRmukLNbOf1wXPDzR
   A==;
X-CSE-ConnectionGUID: 0Nk3QIG/RgOmP0DELx06QQ==
X-CSE-MsgGUID: R5PQTU6aRlCGrXfdLOqaFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="82876759"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="82876759"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 18:11:58 -0700
X-CSE-ConnectionGUID: s+qjmyDhTZaxrVuE3PVecw==
X-CSE-MsgGUID: qmH3Jh6XS5+zTVYZrll27A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="197475861"
Received: from igk-lkp-server01.igk.intel.com (HELO ca260db0ef79) ([10.91.175.65])
  by fmviesa001.fm.intel.com with ESMTP; 13 Aug 2025 18:11:56 -0700
Received: from kbuild by ca260db0ef79 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umMVW-00009v-05;
	Thu, 14 Aug 2025 01:11:54 +0000
Date: Thu, 14 Aug 2025 03:11:47 +0200
From: kernel test robot <lkp@intel.com>
To: Justin Lai <justinlai0215@realtek.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, Joe Damato <jdamato@fastly.com>
Subject: drivers/net/ethernet/realtek/rtase/rtase_main.c:1117:52: warning:
 '%u' directive output may be truncated writing between 1 and 10 bytes into a
 region of size between 7 and 22
Message-ID: <202508140329.jDo2ASlz-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Justin,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dfc0f6373094dd88e1eaf76c44f2ff01b65db851
commit: ef7d33e174564d6294edd00ca797e2b0aac76259 rtase: Modify the format specifier in snprintf to %u
date:   4 months ago
config: sparc-randconfig-2006-20250814 (https://download.01.org/0day-ci/archive/20250814/202508140329.jDo2ASlz-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250814/202508140329.jDo2ASlz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508140329.jDo2ASlz-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/realtek/rtase/rtase_main.c: In function 'rtase_open':
>> drivers/net/ethernet/realtek/rtase/rtase_main.c:1117:52: warning: '%u' directive output may be truncated writing between 1 and 10 bytes into a region of size between 7 and 22 [-Wformat-truncation=]
       snprintf(ivec->name, sizeof(ivec->name), "%s_int%u",
                                                       ^~
   drivers/net/ethernet/realtek/rtase/rtase_main.c:1117:45: note: directive argument in the range [0, 2147483647]
       snprintf(ivec->name, sizeof(ivec->name), "%s_int%u",
                                                ^~~~~~~~~~
   drivers/net/ethernet/realtek/rtase/rtase_main.c:1117:4: note: 'snprintf' output between 6 and 30 bytes into a destination of size 26
       snprintf(ivec->name, sizeof(ivec->name), "%s_int%u",
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         tp->dev->name, i);
         ~~~~~~~~~~~~~~~~~


vim +1117 drivers/net/ethernet/realtek/rtase/rtase_main.c

  1086	
  1087	static int rtase_open(struct net_device *dev)
  1088	{
  1089		struct rtase_private *tp = netdev_priv(dev);
  1090		const struct pci_dev *pdev = tp->pdev;
  1091		struct rtase_int_vector *ivec;
  1092		u16 i = 0, j;
  1093		int ret;
  1094	
  1095		ivec = &tp->int_vector[0];
  1096		tp->rx_buf_sz = RTASE_RX_BUF_SIZE;
  1097	
  1098		ret = rtase_alloc_desc(tp);
  1099		if (ret)
  1100			return ret;
  1101	
  1102		ret = rtase_init_ring(dev);
  1103		if (ret)
  1104			goto err_free_all_allocated_mem;
  1105	
  1106		rtase_hw_config(dev);
  1107	
  1108		if (tp->sw_flag & RTASE_SWF_MSIX_ENABLED) {
  1109			ret = request_irq(ivec->irq, rtase_interrupt, 0,
  1110					  dev->name, ivec);
  1111			if (ret)
  1112				goto err_free_all_allocated_irq;
  1113	
  1114			/* request other interrupts to handle multiqueue */
  1115			for (i = 1; i < tp->int_nums; i++) {
  1116				ivec = &tp->int_vector[i];
> 1117				snprintf(ivec->name, sizeof(ivec->name), "%s_int%u",
  1118					 tp->dev->name, i);
  1119				ret = request_irq(ivec->irq, rtase_q_interrupt, 0,
  1120						  ivec->name, ivec);
  1121				if (ret)
  1122					goto err_free_all_allocated_irq;
  1123			}
  1124		} else {
  1125			ret = request_irq(pdev->irq, rtase_interrupt, 0, dev->name,
  1126					  ivec);
  1127			if (ret)
  1128				goto err_free_all_allocated_mem;
  1129		}
  1130	
  1131		rtase_hw_start(dev);
  1132	
  1133		for (i = 0; i < tp->int_nums; i++) {
  1134			ivec = &tp->int_vector[i];
  1135			napi_enable(&ivec->napi);
  1136		}
  1137	
  1138		netif_carrier_on(dev);
  1139		netif_wake_queue(dev);
  1140	
  1141		return 0;
  1142	
  1143	err_free_all_allocated_irq:
  1144		for (j = 0; j < i; j++)
  1145			free_irq(tp->int_vector[j].irq, &tp->int_vector[j]);
  1146	
  1147	err_free_all_allocated_mem:
  1148		rtase_free_desc(tp);
  1149	
  1150		return ret;
  1151	}
  1152	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


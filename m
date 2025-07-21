Return-Path: <linux-kernel+bounces-739366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFD7B0C566
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49F5D1AA0533
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFA82D94AD;
	Mon, 21 Jul 2025 13:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J/lNYyV8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D17143AB7
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 13:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753105295; cv=none; b=dfz3OVX4B5Y6xgeOaMG3GNR9ldVevXJvceA9/UOMCxTHMRJau0JK4Gzy/QUTaW0Rny1MRIerWjXJuuUF70iNBWfjeRfzANkihfqlVb3OUYzY5ryW8tdM1B+Y/YaCDZfnIwypZBniiaLskiYj/jFat1RggYrcrS5Boj7+X0H+dfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753105295; c=relaxed/simple;
	bh=7oVq+MK9lRmCL3TddUMmYR5l2pCKQF8CFbKZ+6J4Cmw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=S2qlT1oTg4uKKVn82wO57nUfdprmixONVbstowVd8/5dcyH4+YDQtLuPn9jhxV8SBXCozXCz6v8ESckFc+ptTqmJ16aHgiyPxM0dtXHdStQuIj8Z0CpvQrl2+ghy6munDIRNILeurOoBjOHE8vt9Exii+U/0hj71X/hD9ECkM/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J/lNYyV8; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753105293; x=1784641293;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7oVq+MK9lRmCL3TddUMmYR5l2pCKQF8CFbKZ+6J4Cmw=;
  b=J/lNYyV87ALPwNl28wbGbek6LzkpyIKydSq+Ix8r4RaRgFFRVlLOzA+v
   ez9F6Vv2shnLXJPsYhurxJhx6s1pzoJUe7WdZ10qDDrA/TmBRBrOS1m6u
   Lv5QsscRNGgxF8YzOktI0YtAGPtMvos8IOt7PHyMJM0SlnIXqi4+mVois
   GFNBM5pkUmoTBvHWWOxyc0D0bco9PevbgNJj7rWHeVY6At8BjVsnQ3kEl
   B5dVCrTEkbiUBYLrRLqDLSs7U3/6fpLaUF2lDgQv+uZ5MKO91HTR+VsOI
   JFdCtFOG7q7zDNsKfis4xIhWBd4g+fJdAj8gRomidMkxu69vjMxiBAh0R
   w==;
X-CSE-ConnectionGUID: CD7zp7ZsSuayy2Ddy5ab4w==
X-CSE-MsgGUID: WzI6yeKsRRSz+T/FHYlOUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="65887693"
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="65887693"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 06:41:32 -0700
X-CSE-ConnectionGUID: XHnIg039TomTYds5J+8Y5A==
X-CSE-MsgGUID: RNvW4nORSbKeCC07OEdOcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="164502260"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 21 Jul 2025 06:41:31 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1udqll-000Gqe-0f;
	Mon, 21 Jul 2025 13:41:29 +0000
Date: Mon, 21 Jul 2025 21:40:55 +0800
From: kernel test robot <lkp@intel.com>
To: Pawel Laszczak <pawell@cadence.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/usb/cdns3/cdnsp-gadget.c:159:16: sparse: sparse: incorrect
 type in argument 1 (different base types)
Message-ID: <202507212142.fd0KSp5g-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   89be9a83ccf1f88522317ce02f854f30d6115c41
commit: 241e2ce88e5a494be7a5d44c0697592f1632fbee usb: cdnsp: Fix issue with resuming from L1
date:   3 months ago
config: loongarch-randconfig-r123-20250721 (https://download.01.org/0day-ci/archive/20250721/202507212142.fd0KSp5g-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce: (https://download.01.org/0day-ci/archive/20250721/202507212142.fd0KSp5g-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507212142.fd0KSp5g-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/usb/cdns3/cdnsp-gadget.c:157:16: sparse: sparse: cast to restricted __le32
>> drivers/usb/cdns3/cdnsp-gadget.c:159:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/usb/cdns3/cdnsp-gadget.c:159:16: sparse:     expected unsigned int [usertype] value
   drivers/usb/cdns3/cdnsp-gadget.c:159:16: sparse:     got restricted __le32 [usertype]

vim +159 drivers/usb/cdns3/cdnsp-gadget.c

   141	
   142	static void cdnsp_set_apb_timeout_value(struct cdnsp_device *pdev)
   143	{
   144		struct cdns *cdns = dev_get_drvdata(pdev->dev);
   145		__le32 __iomem *reg;
   146		void __iomem *base;
   147		u32 offset = 0;
   148		u32 val;
   149	
   150		if (!cdns->override_apb_timeout)
   151			return;
   152	
   153		base = &pdev->cap_regs->hc_capbase;
   154		offset = cdnsp_find_next_ext_cap(base, offset, D_XEC_PRE_REGS_CAP);
   155		reg = base + offset + REG_CHICKEN_BITS_3_OFFSET;
   156	
   157		val  = le32_to_cpu(readl(reg));
   158		val = CHICKEN_APB_TIMEOUT_SET(val, cdns->override_apb_timeout);
 > 159		writel(cpu_to_le32(val), reg);
   160	}
   161	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


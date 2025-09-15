Return-Path: <linux-kernel+bounces-817556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E66B583B7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A3941AA4015
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A451F285C91;
	Mon, 15 Sep 2025 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D6yF07HM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CD2284684;
	Mon, 15 Sep 2025 17:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757957613; cv=none; b=i7B7/dz9oS1GmsnNPxlkn4chdQLCAt0grPSHBdVjcyGyuXBs/PKnaKivjLRBo+9qModUExR8PTbdCQQh32CJOZambCfk8TLyrEmZnTctZRPL/l9gAoeGd1wYNn8lrFwTGvPvHDldNTD3OI0EOgcw6JFvRFgEwRzXKEms+e7CBvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757957613; c=relaxed/simple;
	bh=tcA5ilNGhf5LDCGb0wQj3jRtCt/yW5+rVMlOSjIZFag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7nPPW2magHnW6OEWP0qQjl/4supxMqcEyCJLHeo9+9o4gtKMtusswTCX4pv0L5coaSBFGQtwRN9QCpXY4U50L1n/OANXJumVZQkHGGiLBkHlVu3edPVbBgFtm1GHQ+/MBed3WnoS4k8Abo7q8XZh1N79bhStrhgh9hWmHC1on0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D6yF07HM; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757957612; x=1789493612;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tcA5ilNGhf5LDCGb0wQj3jRtCt/yW5+rVMlOSjIZFag=;
  b=D6yF07HM/D0U+a8ozdaSkHPilY/Cu5LjC558iFFRpRsLztXG8Ax6Fek8
   HFNF7ZOR84DB1ojNk/6sDyu5jvAgxZtosRjOAwgTw9c3IyQGvWwxLrYLo
   KYPCtj0jrFsXN09jhlWiDzrQE3zv03bXUSwmfOb32Dcw6pxqY3hr3ph5S
   3zg+fVHX6pL1zkejE4Kga/pT2OZjlUmj6TE13cmviAJsPlWE9YA19QCHh
   KhgV+nZuWVUv8QcpMYq+fj6FQcvNJnOB9VGY1QkHvkyV4KFC3L0VN8q6J
   3FxadTVfqSCTL/ec0+EievdARoc62neL+G8vO+jymV6U5a895JCZHvoxj
   w==;
X-CSE-ConnectionGUID: XiV2NU09Tk6JMZGEJinrJQ==
X-CSE-MsgGUID: 3WrYf+fRQou2wS5WxYeb9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="77832487"
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="77832487"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 10:33:23 -0700
X-CSE-ConnectionGUID: PZ65g/EDS1KR6VeXQ2N8UA==
X-CSE-MsgGUID: AdkmSubKSW6orL1pB1KVFA==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 5b01dd97f97c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 15 Sep 2025 10:32:01 -0700
Received: from kbuild by 5b01dd97f97c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uyD3X-0000Ux-01;
	Mon, 15 Sep 2025 17:31:59 +0000
Date: Tue, 16 Sep 2025 01:31:11 +0800
From: kernel test robot <lkp@intel.com>
To: caohang@eswincomputing.com, gregkh@linuxfoundation.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, Thinh.Nguyen@synopsys.com,
	p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com,
	Hang Cao <caohang@eswincomputing.com>,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>
Subject: Re: [PATCH v3 2/2] usb: dwc3: eic7700: Add EIC7700 USB driver
Message-ID: <202509160138.P7gRM9Bt-lkp@intel.com>
References: <20250915091051.2148-1-caohang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915091051.2148-1-caohang@eswincomputing.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on usb/usb-next usb/usb-linus robh/for-next pza/reset/next linus/master v6.17-rc6 next-20250912]
[cannot apply to pza/imx-drm/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/caohang-eswincomputing-com/dt-bindings-usb-Add-ESWIN-EIC7700-USB-controller/20250915-171407
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20250915091051.2148-1-caohang%40eswincomputing.com
patch subject: [PATCH v3 2/2] usb: dwc3: eic7700: Add EIC7700 USB driver
config: i386-buildonly-randconfig-003-20250915 (https://download.01.org/0day-ci/archive/20250916/202509160138.P7gRM9Bt-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250916/202509160138.P7gRM9Bt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509160138.P7gRM9Bt-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/usb/dwc3/dwc3-eic7700.c:225:12: warning: 'dwc3_eswin_runtime_idle' defined but not used [-Wunused-function]
     225 | static int dwc3_eswin_runtime_idle(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/usb/dwc3/dwc3-eic7700.c:210:12: warning: 'dwc3_eswin_runtime_resume' defined but not used [-Wunused-function]
     210 | static int dwc3_eswin_runtime_resume(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/usb/dwc3/dwc3-eic7700.c:196:12: warning: 'dwc3_eswin_runtime_suspend' defined but not used [-Wunused-function]
     196 | static int dwc3_eswin_runtime_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/usb/dwc3/dwc3-eic7700.c:181:12: warning: 'dwc3_eswin_pm_resume' defined but not used [-Wunused-function]
     181 | static int dwc3_eswin_pm_resume(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~
>> drivers/usb/dwc3/dwc3-eic7700.c:166:12: warning: 'dwc3_eswin_pm_suspend' defined but not used [-Wunused-function]
     166 | static int dwc3_eswin_pm_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~


vim +/dwc3_eswin_runtime_idle +225 drivers/usb/dwc3/dwc3-eic7700.c

   165	
 > 166	static int dwc3_eswin_pm_suspend(struct device *dev)
   167	{
   168		struct dwc3 *dwc = dev_get_drvdata(dev);
   169		struct dwc3_eswin *eswin = to_dwc3_eswin(dwc);
   170		int ret;
   171	
   172		ret = dwc3_pm_suspend(&eswin->dwc);
   173		if (ret)
   174			return ret;
   175	
   176		clk_bulk_disable_unprepare(eswin->num_clks, eswin->clks);
   177	
   178		return 0;
   179	}
   180	
 > 181	static int dwc3_eswin_pm_resume(struct device *dev)
   182	{
   183		struct dwc3 *dwc = dev_get_drvdata(dev);
   184		struct dwc3_eswin *eswin = to_dwc3_eswin(dwc);
   185		int ret;
   186	
   187		ret = clk_bulk_prepare_enable(eswin->num_clks, eswin->clks);
   188		if (ret) {
   189			dev_err(dev, "Failed to enable clocks: %d\n", ret);
   190			return ret;
   191		}
   192	
   193		return dwc3_pm_resume(&eswin->dwc);
   194	}
   195	
 > 196	static int dwc3_eswin_runtime_suspend(struct device *dev)
   197	{
   198		struct dwc3 *dwc = dev_get_drvdata(dev);
   199		struct dwc3_eswin *eswin = to_dwc3_eswin(dwc);
   200		int ret;
   201	
   202		ret = dwc3_runtime_suspend(&eswin->dwc);
   203		if (ret)
   204			return ret;
   205	
   206		clk_bulk_disable_unprepare(eswin->num_clks, eswin->clks);
   207		return 0;
   208	}
   209	
 > 210	static int dwc3_eswin_runtime_resume(struct device *dev)
   211	{
   212		struct dwc3 *dwc = dev_get_drvdata(dev);
   213		struct dwc3_eswin *eswin = to_dwc3_eswin(dwc);
   214		int ret;
   215	
   216		ret = clk_bulk_prepare_enable(eswin->num_clks, eswin->clks);
   217		if (ret) {
   218			dev_err(dev, "Failed to enable clocks: %d\n", ret);
   219			return ret;
   220		}
   221	
   222		return dwc3_runtime_resume(&eswin->dwc);
   223	}
   224	
 > 225	static int dwc3_eswin_runtime_idle(struct device *dev)
   226	{
   227		return dwc3_runtime_idle(dev_get_drvdata(dev));
   228	}
   229	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


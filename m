Return-Path: <linux-kernel+bounces-804731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DC7B47C35
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 18:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1F6D189C5B5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 16:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6318284883;
	Sun,  7 Sep 2025 16:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QsVSKyLx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7069D28369A;
	Sun,  7 Sep 2025 16:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757261419; cv=none; b=dngLVRLechgGpdCe5XT00IwvLt2r5ihlUwxLz+uvkD0CkSebmtBJ8d60GZ2xLjrWubRqv+ADDBKsWbfoM6Wc5UFyCQg7Wce9u0maGL0+AGITeKLkKy3O1E9AFGOJ51xgWRQ1iFyt79o9gK8bgL8w1ps+31Fe8LehmPPmSs425bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757261419; c=relaxed/simple;
	bh=3Zl6AVEGt9WisPqSWtg4X6buSc0QYXVLZOjy94tByxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6Sl+d3JEOcZ9JwZhMth70zmPFc/u/C+DHWtF9+gQPW+3OwtscFGp/GGKFy+Jj9bFV6e8XM4MY3l0IyfJaPfoDNYJq+HwiUEX8cjsq2zCtzeWLx9gCR0sndVwMD1+BAUMwxQLsOjqwR7uu7EMxhEEPNnU5OcrXQNuCxnI3PpRlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QsVSKyLx; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757261417; x=1788797417;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3Zl6AVEGt9WisPqSWtg4X6buSc0QYXVLZOjy94tByxw=;
  b=QsVSKyLx08ueWRsZbp7gDvoIZbd+1HAvACtH0HgFjtFo16K4ktDdnFSt
   e/VFYTMUbK3xTcrYpP2+l7NXp8o1Fc4YLjXSHkTvh1HqdISlwxekQbWEV
   a2XqckEtP0IWTiuAYRA63Uvv0du1bj02LXAHEpqOkduDG5JT2URGLpwuS
   6lgCBbrpU3SDUwMIoPDKSEhRfeJppLW+916M3WxKZujsIB17KYRdZanR7
   BoaopXk2EuKcShQhpxBRkPbLo/GEIs9XiJUV4EPu8JM9IuqLQJFGsTNAn
   B8CR0sDBnNs3R4r8xwfGRg5m9/t6ONH/wxmrxu1rApI/QrAdVj11xyqwd
   A==;
X-CSE-ConnectionGUID: ilIRnER5S22RLwLDxiJx5Q==
X-CSE-MsgGUID: emta0kKRR+aRn/ODIh8Uyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59462260"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59462260"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 09:10:17 -0700
X-CSE-ConnectionGUID: Wh9M8o7RQ9iMYMUnx7+mHg==
X-CSE-MsgGUID: SztYKZBBSQ+peDyIbxLBCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="172951477"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 07 Sep 2025 09:10:14 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uvHy0-0002MN-0C;
	Sun, 07 Sep 2025 16:10:12 +0000
Date: Mon, 8 Sep 2025 00:09:25 +0800
From: kernel test robot <lkp@intel.com>
To: WeiHao Li <cn.liweihao@gmail.com>, heiko@sntech.de, robh@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	WeiHao Li <cn.liweihao@gmail.com>
Subject: Re: [PATCH v1 1/4] phy: rockchip: inno-usb2: Add usb2 phy support
 for RK3368
Message-ID: <202509072227.wBI6dBl4-lkp@intel.com>
References: <20250905125318.7956-2-cn.liweihao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905125318.7956-2-cn.liweihao@gmail.com>

Hi WeiHao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rockchip/for-next]
[also build test WARNING on robh/for-next arm/for-next arm/fixes arm64/for-next/core clk/clk-next kvmarm/next shawnguo/for-next soc/for-next linus/master v6.17-rc4 next-20250905]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/WeiHao-Li/phy-rockchip-inno-usb2-Add-usb2-phy-support-for-RK3368/20250905-205804
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
patch link:    https://lore.kernel.org/r/20250905125318.7956-2-cn.liweihao%40gmail.com
patch subject: [PATCH v1 1/4] phy: rockchip: inno-usb2: Add usb2 phy support for RK3368
config: arc-randconfig-r132-20250907 (https://download.01.org/0day-ci/archive/20250907/202509072227.wBI6dBl4-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 15.1.0
reproduce: (https://download.01.org/0day-ci/archive/20250907/202509072227.wBI6dBl4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509072227.wBI6dBl4-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/phy/rockchip/phy-rockchip-inno-usb2.c:1867:34: sparse: sparse: Initializer entry defined twice
   drivers/phy/rockchip/phy-rockchip-inno-usb2.c:1873:34: sparse:   also defined here

vim +1867 drivers/phy/rockchip/phy-rockchip-inno-usb2.c

  1849	
  1850	static const struct rockchip_usb2phy_cfg rk3368_phy_cfgs[] = {
  1851		{
  1852			.reg = 0x700,
  1853			.num_ports	= 2,
  1854			.clkout_ctl	= { 0x0724, 15, 15, 1, 0 },
  1855			.port_cfgs	= {
  1856				[USB2PHY_PORT_OTG] = {
  1857					.phy_sus	= { 0x0700, 8, 0, 0, 0x1d1 },
  1858					.bvalid_det_en	= { 0x0680, 3, 3, 0, 1 },
  1859					.bvalid_det_st	= { 0x0690, 3, 3, 0, 1 },
  1860					.bvalid_det_clr = { 0x06a0, 3, 3, 0, 1 },
  1861					.idfall_det_en	= { 0x0680, 6, 6, 0, 1 },
  1862					.idfall_det_st	= { 0x0690, 6, 6, 0, 1 },
  1863					.idfall_det_clr	= { 0x06a0, 6, 6, 0, 1 },
  1864					.idrise_det_en	= { 0x0680, 5, 5, 0, 1 },
  1865					.idrise_det_st	= { 0x0690, 5, 5, 0, 1 },
  1866					.idrise_det_clr	= { 0x06a0, 5, 5, 0, 1 },
> 1867					.ls_det_en	= { 0x0680, 2, 2, 0, 1 },
  1868					.ls_det_st	= { 0x0690, 2, 2, 0, 1 },
  1869					.ls_det_clr	= { 0x06a0, 2, 2, 0, 1 },
  1870					.utmi_bvalid	= { 0x04bc, 23, 23, 0, 1 },
  1871					.utmi_id	= { 0x04bc, 26, 26, 0, 1 },
  1872					.utmi_ls	= { 0x04bc, 25, 24, 0, 1 },
  1873					.ls_det_en	= { 0x079c, 15, 15, 1, 0 },
  1874				},
  1875				[USB2PHY_PORT_HOST] = {
  1876					.phy_sus	= { 0x0728, 8, 0, 0, 0x1d1 },
  1877					.ls_det_en	= { 0x0680, 4, 4, 0, 1 },
  1878					.ls_det_st	= { 0x0690, 4, 4, 0, 1 },
  1879					.ls_det_clr	= { 0x06a0, 4, 4, 0, 1 }
  1880				}
  1881			},
  1882			.chg_det = {
  1883				.opmode		= { 0x0700, 8, 0, 0, 0x1d7 },
  1884				.cp_det		= { 0x04b8, 30, 30, 0, 1 },
  1885				.dcp_det	= { 0x04b8, 29, 29, 0, 1 },
  1886				.dp_det		= { 0x04b8, 31, 31, 0, 1 },
  1887				.idm_sink_en	= { 0x0718, 8, 8, 0, 1 },
  1888				.idp_sink_en	= { 0x0718, 7, 7, 0, 1 },
  1889				.idp_src_en	= { 0x0718, 9, 9, 0, 1 },
  1890				.rdm_pdwn_en	= { 0x0718, 10, 10, 0, 1 },
  1891				.vdm_src_en	= { 0x0718, 12, 12, 0, 1 },
  1892				.vdp_src_en	= { 0x0718, 11, 11, 0, 1 },
  1893			},
  1894		},
  1895		{ /* sentinel */ }
  1896	};
  1897	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


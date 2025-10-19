Return-Path: <linux-kernel+bounces-859531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC9DBEDE7C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 07:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A20C234AAB7
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 05:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABBD21D3DF;
	Sun, 19 Oct 2025 05:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dnxPFkQe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E1F10A1E;
	Sun, 19 Oct 2025 05:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760851923; cv=none; b=hleb9Y0D11DyZX1i3tq7SYch1/6tpfrHmoYH5PgEvmkYDzkzJw3N9QUYTOxXp2Wbxpv5bMkc1e/77DLDor4weeMxmkUvCvMMHSPWbc5Oj4Pu6TEXxBsZ7IKpagkjr9GEiNaLgho6VYi7iAGtVYujcqCrm08ReGlSQcy5ofeeIE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760851923; c=relaxed/simple;
	bh=bWGsBC58nVw/sxl2Hx9QNQsauG04QZleHom4h2dfg0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=am5uZw2LlsI8bnKypnZQXNa0FPtrv8wWqj7URTVWGY0+7MJVuj3HAb95i+bBuGt363TPFUysrSYGfs7hw5bEkM/yXf3AHvGwvOf5svxuCMmZ5eIAHGqxVIAMWxSqYC2jPKK+pgsRNsMEDgt1O1x/sdjmKoure6UhhRSrt8Nik6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dnxPFkQe; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760851921; x=1792387921;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bWGsBC58nVw/sxl2Hx9QNQsauG04QZleHom4h2dfg0U=;
  b=dnxPFkQeKZfos0LNkiNDzbhWDj7cUAVKNeE6WTwL9Y3K+6ktDaiqU51T
   mSVt73TJ6Teds8yomYX8IkREFoAg0HRi2hYq/t/UnPe7ZNiPzrbkglFpQ
   TNZBP5jZfDHAUX4w7alTqy6oa/1z/8qzzAhDYiqa9CFpDBn0bkilK6zrx
   UtaNTDVzBneOSfTDDnDBZFejWZEVU87Y/Cl7mrCvU+r2KBrnZzULZ3xO2
   zThXwqaCAGpQAmh5yN2NWQCkcBWFKlp8iHBp5pdCihgv4sKUiWlHUkSwp
   bc+Zw5RZ9NegF1mZnLF8BqvvpgOJH0alVI90b7jACgvUQI2AWm3MqDdbO
   w==;
X-CSE-ConnectionGUID: 04F/9wcrRR6XWaZOmJpHzA==
X-CSE-MsgGUID: ljyPhI3USpWcUOerfRNT0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="65629434"
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="65629434"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 22:32:00 -0700
X-CSE-ConnectionGUID: XocagptQREO66ibi0urNnA==
X-CSE-MsgGUID: FCeZMkrnTHOQr5UUKBE7mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="220213467"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 18 Oct 2025 22:31:57 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vAM1F-0008s9-3C;
	Sun, 19 Oct 2025 05:31:51 +0000
Date: Sun, 19 Oct 2025 13:30:56 +0800
From: kernel test robot <lkp@intel.com>
To: Elaine Zhang <zhangqing@rock-chips.com>, mturquette@baylibre.com,
	sboyd@kernel.org, sugar.zhang@rock-chips.com, heiko@sntech.de,
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	huangtao@rock-chips.com
Subject: Re: [PATCH v2 3/5] clk: rockchip: Add clock controller for the
 RV1126B
Message-ID: <202510191337.86OcUAWo-lkp@intel.com>
References: <20251017063107.1606965-4-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017063107.1606965-4-zhangqing@rock-chips.com>

Hi Elaine,

kernel test robot noticed the following build errors:

[auto build test ERROR on rockchip/for-next]
[also build test ERROR on clk/clk-next pza/reset/next linus/master v6.18-rc1 next-20251017]
[cannot apply to pza/imx-drm/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Elaine-Zhang/clk-rockchip-Implement-rockchip_clk_register_armclk_multi_pll/20251017-180259
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
patch link:    https://lore.kernel.org/r/20251017063107.1606965-4-zhangqing%40rock-chips.com
patch subject: [PATCH v2 3/5] clk: rockchip: Add clock controller for the RV1126B
config: arm-multi_v7_defconfig (https://download.01.org/0day-ci/archive/20251019/202510191337.86OcUAWo-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251019/202510191337.86OcUAWo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510191337.86OcUAWo-lkp@intel.com/

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: drivers/clk/rockchip/clk-rv1126b.o: in function `rv1126b_clk_init':
>> drivers/clk/rockchip/clk-rv1126b.c:1050:(.init.text+0xc8): undefined reference to `rk3576_rst_init'


vim +1050 drivers/clk/rockchip/clk-rv1126b.c

  1012	
  1013	static struct rockchip_clk_branch rv1126b_armclk __initdata =
  1014		MUX(ARMCLK, "armclk", mux_armclk_p, CLK_IS_CRITICAL | CLK_SET_RATE_PARENT,
  1015				RV1126B_CORECLKSEL_CON(0), 1, 1, MFLAGS);
  1016	
  1017	static void __init rv1126b_clk_init(struct device_node *np)
  1018	{
  1019		struct rockchip_clk_provider *ctx;
  1020		void __iomem *reg_base;
  1021		unsigned long clk_nr_clks;
  1022	
  1023		clk_nr_clks = rockchip_clk_find_max_clk_id(rv1126b_clk_branches,
  1024							   ARRAY_SIZE(rv1126b_clk_branches)) + 1;
  1025	
  1026		reg_base = of_iomap(np, 0);
  1027		if (!reg_base) {
  1028			pr_err("%s: could not map cru region\n", __func__);
  1029			return;
  1030		}
  1031	
  1032		ctx = rockchip_clk_init(np, reg_base, clk_nr_clks);
  1033		if (IS_ERR(ctx)) {
  1034			pr_err("%s: rockchip clk init failed\n", __func__);
  1035			iounmap(reg_base);
  1036			return;
  1037		}
  1038	
  1039		rockchip_clk_register_plls(ctx, rv1126b_pll_clks,
  1040					   ARRAY_SIZE(rv1126b_pll_clks),
  1041					   RV1126B_GRF_SOC_STATUS0);
  1042	
  1043		rockchip_clk_register_branches(ctx, rv1126b_clk_branches,
  1044					       ARRAY_SIZE(rv1126b_clk_branches));
  1045	
  1046		rockchip_clk_register_armclk_multi_pll(ctx, &rv1126b_armclk,
  1047						       rv1126b_cpuclk_rates,
  1048						       ARRAY_SIZE(rv1126b_cpuclk_rates));
  1049	
> 1050		rk3576_rst_init(np, reg_base);
  1051	
  1052		rockchip_register_restart_notifier(ctx, RV1126B_GLB_SRST_FST, NULL);
  1053	
  1054		rockchip_clk_of_add_provider(np, ctx);
  1055	
  1056		/* pvtpll src init */
  1057		writel_relaxed(PVTPLL_SRC_SEL_PVTPLL, reg_base + RV1126B_CORECLKSEL_CON(0));
  1058		writel_relaxed(PVTPLL_SRC_SEL_PVTPLL, reg_base + RV1126B_NPUCLKSEL_CON(0));
  1059		writel_relaxed(PVTPLL_SRC_SEL_PVTPLL, reg_base + RV1126B_VICLKSEL_CON(0));
  1060		writel_relaxed(PVTPLL_SRC_SEL_PVTPLL, reg_base + RV1126B_VEPUCLKSEL_CON(0));
  1061		writel_relaxed(PVTPLL_SRC_SEL_PVTPLL, reg_base + RV1126B_VCPCLKSEL_CON(0));
  1062	}
  1063	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


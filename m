Return-Path: <linux-kernel+bounces-855473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CC1BE15B9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 05:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 572514E8749
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 03:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D295207A0B;
	Thu, 16 Oct 2025 03:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZIyykUIR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA40418D656;
	Thu, 16 Oct 2025 03:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760585298; cv=none; b=WMa28mTuQ33tzYuSNhF5b4ecorseI3J0C/HcIzgQd36fiHi8IqSEE43hhD8vrj/qGtYMh27UiSBm9GKh+koKYzaQOJBYUWRMAlDFITECyG8v4YVgCAukhotBoOL1SBhp4Cf7X1bvrxz/q1jZm4nsF0/39eeBUe4RP9pEOfUfA+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760585298; c=relaxed/simple;
	bh=YuhMJ7IURSN/c0WscS4LqfJVABe59UgRlw5ETqTHE4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nky7Q43zkRgfwI6jQdIbVhG8r1kkrJhpvffP5ymt4beCP6c/12wpTv56Dv3mermQHWrop52J8mvVUdJSPMCgw0DY+9m5fO9peHhOkLGFl2PyGyzro/UzzDME5rQDgdJqK3FST1nHeQtY73yxOX4yiNSNgP/fuadw8l/Knd6Ne2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZIyykUIR; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760585297; x=1792121297;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YuhMJ7IURSN/c0WscS4LqfJVABe59UgRlw5ETqTHE4w=;
  b=ZIyykUIRPKZ6rnzMzHG+69oZCYeoRgsLdv/Ux4LsetyP2K5/BcfMakGu
   a4jRiCnrPWYfuYNr0NiiG1GFmJ9nXXPnDfQY7g9oazyBQHnR7XPYeMyJJ
   mEsxH5P6uN8ts6wGHh4zGcU1vKt7ha3BFsaZ2YIISsc5j3VIRukqtVVuD
   IKB6+jNRSUgwrVThEnfGSnJnuVZ54knAlOXXSTJ0H0FnX+/l6TroxLWDs
   74cJsPiNGGaS58vizNe/q5QYnto10YhMvS8qLbHDOpLho9Isx8zgglPWD
   V9psKlcvbIcjTn7J7YAM8wCksHF+cEYi/bGvExjZu9KH/EUB7TWFVoV5B
   Q==;
X-CSE-ConnectionGUID: w3oV1vUdSLeOoDXXm+jqhQ==
X-CSE-MsgGUID: /vDtIPPFQpaQnuF4Z7vy/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="80211155"
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="80211155"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 20:28:16 -0700
X-CSE-ConnectionGUID: h4zjBHpbS4WOJ1jCF0CC1w==
X-CSE-MsgGUID: a2/yikpcSgKQK1Ay7/R7Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="187431115"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 15 Oct 2025 20:28:12 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9Eew-0004Q9-0R;
	Thu, 16 Oct 2025 03:28:10 +0000
Date: Thu, 16 Oct 2025 11:25:36 +0800
From: kernel test robot <lkp@intel.com>
To: Elaine Zhang <zhangqing@rock-chips.com>, mturquette@baylibre.com,
	sboyd@kernel.org, sugar.zhang@rock-chips.com, heiko@sntech.de,
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	huangtao@rock-chips.com
Subject: Re: [PATCH v1 3/5] clk: rockchip: Add clock controller for the
 RV1126B
Message-ID: <202510161113.KpOm5Unm-lkp@intel.com>
References: <20251015091325.71333-4-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015091325.71333-4-zhangqing@rock-chips.com>

Hi Elaine,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rockchip/for-next]
[also build test WARNING on clk/clk-next pza/reset/next linus/master v6.18-rc1 next-20251015]
[cannot apply to pza/imx-drm/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Elaine-Zhang/clk-rockchip-Implement-rockchip_clk_register_armclk_v2/20251015-175108
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
patch link:    https://lore.kernel.org/r/20251015091325.71333-4-zhangqing%40rock-chips.com
patch subject: [PATCH v1 3/5] clk: rockchip: Add clock controller for the RV1126B
config: arm64-randconfig-003-20251016 (https://download.01.org/0day-ci/archive/20251016/202510161113.KpOm5Unm-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251016/202510161113.KpOm5Unm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510161113.KpOm5Unm-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/clk/rockchip/clk-rv1126b.c:17:
>> drivers/clk/rockchip/clk-rv1126b.c:146:7: warning: 'mux_ddrphy_p' defined but not used [-Wunused-const-variable=]
     146 | PNAME(mux_ddrphy_p)   = { "dpll", "aclk_sysmem" };
         |       ^~~~~~~~~~~~
   drivers/clk/rockchip/clk.h:740:43: note: in definition of macro 'PNAME'
     740 | #define PNAME(x) static const char *const x[] __initconst
         |                                           ^


vim +/mux_ddrphy_p +146 drivers/clk/rockchip/clk-rv1126b.c

    86	
    87	PNAME(mux_pll_p)			= { "xin24m" };
    88	PNAME(mux_gpll_cpll_p)			= { "gpll", "cpll" };
    89	PNAME(mux_gpll_aupll_p)			= { "gpll", "aupll" };
    90	PNAME(mux_gpll_aupll_cpll_p)		= { "gpll", "aupll", "cpll" };
    91	PNAME(mux_gpll_cpll_24m_p)		= { "gpll", "cpll", "xin24m" };
    92	PNAME(mux_cpll_24m_p)			= { "cpll", "xin24m" };
    93	PNAME(mux_24m_gpll_aupll_cpll_p)	= { "xin24m", "gpll", "aupll", "cpll" };
    94	PNAME(mux_24m_gpll_cpll_p)		= { "xin24m", "gpll", "cpll" };
    95	PNAME(mux_24m_gpll_aupll_p)		= { "xin24m", "gpll", "aupll" };
    96	PNAME(mux_sclk_uart_src_p)		= { "xin24m", "clk_cm_frac0", "clk_cm_frac1", "clk_cm_frac2",
    97						    "clk_uart_frac0", "clk_uart_frac1" };
    98	PNAME(mclk_sai0_src_p)			= { "xin24m", "clk_cm_frac0", "clk_cm_frac1", "clk_cm_frac2",
    99						    "clk_audio_frac0", "clk_audio_frac1", "clk_audio_int0", "clk_audio_int1", "mclk_sai0_from_io" };
   100	PNAME(mclk_sai1_src_p)			= { "xin24m", "clk_cm_frac0", "clk_cm_frac1", "clk_cm_frac2", "clk_audio_frac0",
   101						    "clk_audio_frac1", "clk_audio_int0", "clk_audio_int1", "mclk_sai1_from_io" };
   102	PNAME(mclk_sai2_src_p)			= { "xin24m", "clk_cm_frac0", "clk_cm_frac1", "clk_cm_frac2", "clk_audio_frac0",
   103						    "clk_audio_frac1", "clk_audio_int0", "clk_audio_int1", "mclk_sai2_from_io" };
   104	PNAME(mux_sai_src_p)			= { "xin24m", "clk_cm_frac0", "clk_cm_frac1", "clk_cm_frac2", "clk_audio_frac0",
   105						    "clk_audio_frac1", "clk_audio_int0", "clk_audio_int1", "mclk_sai0_from_io",
   106						    "mclk_sai1_from_io", "mclk_sai2_from_io"};
   107	PNAME(mux_100m_24m_p)			= { "clk_cpll_div10", "xin24m" };
   108	PNAME(mux_200m_24m_p)			= { "clk_gpll_div6", "xin24m" };
   109	PNAME(mux_500m_400m_200m_p)		= { "clk_cpll_div2", "clk_gpll_div3", "clk_gpll_div6" };
   110	PNAME(mux_300m_200m_p)			= { "clk_gpll_div4", "clk_gpll_div6" };
   111	PNAME(mux_500m_400m_300m_p)		= { "clk_cpll_div2", "clk_gpll_div3", "clk_gpll_div4" };
   112	PNAME(mux_333m_200m_p)			= { "clk_cpll_div3", "clk_gpll_div6" };
   113	PNAME(mux_600m_400m_200m_p)		= { "clk_gpll_div2", "clk_gpll_div3", "clk_gpll_div6" };
   114	PNAME(mux_400m_300m_200m_p)		= { "clk_gpll_div3", "clk_gpll_div4", "clk_gpll_div6" };
   115	PNAME(mux_200m_100m_p)			= { "clk_gpll_div6", "clk_cpll_div10" };
   116	PNAME(mux_200m_100m_50m_24m_p)		= { "clk_gpll_div6", "clk_cpll_div10", "clk_cpll_div20", "xin24m" };
   117	PNAME(mux_600m_24m_p)			= { "clk_gpll_div2", "xin24m" };
   118	PNAME(mux_armclk_p)			= { "clk_core_pll", "clk_core_pvtpll" };
   119	PNAME(aclk_npu_root_p)			= { "clk_npu_pll", "clk_npu_pvtpll" };
   120	PNAME(clk_saradc0_p)			= { "clk_saradc0_src", "clk_saradc0_rcosc_io" };
   121	PNAME(clk_core_vepu_p)			= { "clk_vepu_pll", "clk_vepu_pvtpll" };
   122	PNAME(clk_core_fec_p)			= { "clk_core_fec_src", "clk_vcp_pvtpll" };
   123	PNAME(clk_core_aisp_p)			= { "clk_aisp_pll", "clk_vcp_pvtpll" };
   124	PNAME(clk_core_isp_root_p)		= { "clk_isp_pll", "clk_isp_pvtpll" };
   125	PNAME(clk_gmac_ptp_ref_p)		= { "clk_gmac_ptp_ref_src", "clk_gmac_ptp_from_io" };
   126	PNAME(clk_saradc1_p)			= { "clk_saradc1_src", "clk_saradc1_rcosc_io" };
   127	PNAME(clk_saradc2_p)			= { "clk_saradc2_src", "clk_saradc2_rcosc_io" };
   128	PNAME(clk_rcosc_src_p)			= { "xin24m", "clk_rcosc", "clk_rcosc_div2", "clk_rcosc_div3", "clk_rcosc_div4" };
   129	PNAME(busclk_pmu_mux_p)			= { "clk_cpll_div10", "clk_rcosc_src" };
   130	PNAME(clk_xin_rc_div_p)			= { "xin24m", "clk_rcosc_src" };
   131	PNAME(clk_32k_p)			= { "clk_xin_rc_div", "clk_32k_rtc", "clk_32k_io" };
   132	PNAME(mux_24m_32k_p)			= { "xin24m", "clk_32k" };
   133	PNAME(mux_24m_rcosc_buspmu_p)		= { "xin24m", "clk_rcosc_src", "busclk_pmu_src" };
   134	PNAME(mux_24m_rcosc_buspmu_32k_p)	= { "xin24m", "clk_rcosc_src", "busclk_pmu_src", "clk_32k" };
   135	PNAME(sclk_uart0_p)			= { "sclk_uart0_src", "xin24m", "clk_rcosc_src" };
   136	PNAME(clk_osc_rcosc_ctrl_p)		= { "clk_rcosc_src", "clk_testout_out" };
   137	PNAME(lrck_src_asrc_p)			= { "mclk_asrc0", "mclk_asrc1", "mclk_asrc2", "mclk_asrc3",
   138						    "fs_inter_from_sai0", "fs_inter_from_sai1", "fs_inter_from_sai2", "clkout_pdm"};
   139	PNAME(clk_ref_pipephy_p)		= { "clk_ref_pipephy_cpll_src", "xin24m" };
   140	PNAME(clk_timer0_parents_p)		= { "clk_timer_root", "mclk_sai0_from_io", "sclk_sai0_from_io" };
   141	PNAME(clk_timer1_parents_p)		= { "clk_timer_root", "mclk_sai1_from_io", "sclk_sai1_from_io" };
   142	PNAME(clk_timer2_parents_p)		= { "clk_timer_root", "mclk_sai2_from_io", "sclk_sai2_from_io" };
   143	PNAME(clk_timer3_parents_p)		= { "clk_timer_root", "mclk_asrc0", "mclk_asrc1" };
   144	PNAME(clk_timer4_parents_p)		= { "clk_timer_root", "mclk_asrc2", "mclk_asrc3" };
   145	PNAME(clk_macphy_p)			= { "xin24m", "clk_cpll_div20" };
 > 146	PNAME(mux_ddrphy_p)			= { "dpll", "aclk_sysmem" };
   147	PNAME(clk_cpll_div10_p)			= { "gpll", "clk_aisp_pll_src" };
   148	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


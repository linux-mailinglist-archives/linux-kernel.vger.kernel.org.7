Return-Path: <linux-kernel+bounces-733591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38360B076AD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 109C53A1C2E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D0319DFB4;
	Wed, 16 Jul 2025 13:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nIwWcKz4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705AB35972;
	Wed, 16 Jul 2025 13:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752671788; cv=none; b=ZF5kk7P0JTkag2EBEjUuLfCDEave04oUfCa/t4teeu/5iL4Z7O91CSVl1RozdFmhBemVnm6gYXpsS9Ltcs+HV67y+tGezubaag5piNfRns8EEomEU+2tA7rYaIGGRoF/hP1lSX8axam08H5g09JrniNGR2BwdAY4yaDMbMhwmLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752671788; c=relaxed/simple;
	bh=T2m/oiuwjR2kBEt3SpOmzte4WJb1A9iDMDoZGf9vy1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMogLK7yKT6QtDPPsX8EAZQKZMRHIPykG4XcGiJXYI/qIPZDkAAbnF1LdsjPZnRhMwiI9jxYvPiovpsw6usL6PWHwrklPo0sCCC2LOZSxRGfiTrgAiZk9eQqgb/XeEljgyR4ET7VE0aREzQjZ7Zb9zcG4vg6LrsDMSwXK3THk0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nIwWcKz4; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752671787; x=1784207787;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T2m/oiuwjR2kBEt3SpOmzte4WJb1A9iDMDoZGf9vy1I=;
  b=nIwWcKz49ieoEkD3iadhM1JVQl81JgV+CsIxZmgnNG120eDoHBl7nzA5
   ughALHmlq91kUwkfCos3bi+URaC4r+VrxYrs3GasAmONqCYTqXMRJfEdV
   Ue1TBMozu9PVmgEQlnbatCm1Hsva7GWy4UgzB3AgUk6sri8+AFj/FTWXc
   srjahTDfLMGtDpqklH7UXsKAv9kB32BqhwIPg6ZZ0XgV75ITvl3uHSIUr
   wMGT3Hv1dDWOyJ8Z2biWszcbpjrRadN4eeiIZlg3LUFgESdBdTf1BpPr3
   jYw/TjINzv++FW6Y10Idat4wfMyJ1ezhVR8ugt8eYRyi3Trc9VRajDByD
   A==;
X-CSE-ConnectionGUID: X+HVhc4YQCuv4+FjkeB13w==
X-CSE-MsgGUID: 5VuYdrqwSNShoqQiURwRCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="58685701"
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="58685701"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 06:16:26 -0700
X-CSE-ConnectionGUID: e8YbxVzmQ7uhXb6J+nSkqQ==
X-CSE-MsgGUID: g9WY1BjiTLuoz6pD7l1wYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="156894575"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 16 Jul 2025 06:16:22 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uc1zf-000CQl-1x;
	Wed, 16 Jul 2025 13:16:19 +0000
Date: Wed, 16 Jul 2025 21:15:43 +0800
From: kernel test robot <lkp@intel.com>
To: Arseniy Velikanov <me@adomerle.pw>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Arseniy Velikanov <me@adomerle.pw>
Subject: Re: [PATCH v1 2/2] clk: mediatek: Add MT6789 clock controllers
Message-ID: <202507162133.0p74u7j1-lkp@intel.com>
References: <20250715222221.29406-2-me@adomerle.pw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715222221.29406-2-me@adomerle.pw>

Hi Arseniy,

kernel test robot noticed the following build errors:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on robh/for-next pza/reset/next linus/master v6.16-rc6 next-20250715]
[cannot apply to pza/imx-drm/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Arseniy-Velikanov/clk-mediatek-Add-MT6789-clock-controllers/20250716-062512
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20250715222221.29406-2-me%40adomerle.pw
patch subject: [PATCH v1 2/2] clk: mediatek: Add MT6789 clock controllers
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20250716/202507162133.0p74u7j1-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250716/202507162133.0p74u7j1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507162133.0p74u7j1-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/clk/mediatek/clk-mt6789-imp_iic_wrap.c:13:
>> drivers/clk/mediatek/clk-mt6789-imp_iic_wrap.c:33:27: error: 'CLK_IMP_IIC_WRAP_W_I2C0' undeclared here (not in a function); did you mean 'CLK_IMP_IIC_WRAP_W_I2C1'?
      33 |         GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_W_I2C0, "imp_iic_wrap_w_i2c0", "top_i2c", 0),
         |                           ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/mediatek/clk-gate.h:41:23: note: in definition of macro 'GATE_MTK_FLAGS'
      41 |                 .id = _id,                                      \
         |                       ^~~
   drivers/clk/mediatek/clk-mt6789-imp_iic_wrap.c:33:9: note: in expansion of macro 'GATE_IMP_IIC_WRAP'
      33 |         GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_W_I2C0, "imp_iic_wrap_w_i2c0", "top_i2c", 0),
         |         ^~~~~~~~~~~~~~~~~


vim +33 drivers/clk/mediatek/clk-mt6789-imp_iic_wrap.c

    31	
    32	static const struct mtk_gate imp_iic_wrap_w_clks[] = {
  > 33		GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_W_I2C0, "imp_iic_wrap_w_i2c0", "top_i2c", 0),
    34		GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_W_I2C1, "imp_iic_wrap_w_i2c1", "top_i2c", 1),
    35	};
    36	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


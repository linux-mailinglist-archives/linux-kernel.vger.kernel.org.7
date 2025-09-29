Return-Path: <linux-kernel+bounces-836103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 575BEBA8BB5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6184189F6B2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C9F2E2DE6;
	Mon, 29 Sep 2025 09:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MsDdjWYd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C532E173E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759139311; cv=none; b=p4k3zslOKJxUQLd4UgQX3lpuWsEizY3K5vCTqP8egl3UKIWS0sXJlqp25AjCfpFaHc1QNtlE0Vp5OIg6CKKXR8GC1+1BMUcJZYh1N37hzHAnNvXclImPz+AASfrsVcD3XnOJBbKmPy0VF8bBafxlsegPL9iRWKimkKrKatCLHxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759139311; c=relaxed/simple;
	bh=KHG16Xw+5eWJbib027Wh0wiUKjgw1T/ctp6Day8cStw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TAwCuBHLLqpgT0GdhNQk6LKQBpdcP8wvQJ/HsBVe+rLfMTxqKmVRzSI7eoRPgW0vrutTg+N/IjmGSVqTT4w7pN5SQcg8fIMD5zHm64jZ5CDnET8r73brvWUoHPMiDhh3vcthiR5FyQdr+JbLSazM2aqJjoQZFRxMtyXgH/6G1mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MsDdjWYd; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759139309; x=1790675309;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KHG16Xw+5eWJbib027Wh0wiUKjgw1T/ctp6Day8cStw=;
  b=MsDdjWYd0dHWEsBd95EiQiexjcW1lgyIXH2hzWFG78CCPItnyLem661u
   /4bHmD9jJBOwlXt2fbKbRznM97cHL0pbh4IZafHEdkVPV0rGu6yW1PMSb
   OrRHSL1ZqLuArZoeWJ1NqcONhWdgZOY/g9ectKJuxvYSecIkvQkBjIS9q
   UKhF1+26S3j1CUCLsYObCCR+iS1SngX2cdcrYbiJjdz75VZykMTxCDbb0
   YlRlpceSrCPx6ATwERlp/9bEZaemXxKuzMMJNJtI023zSwzxH/hLVDch+
   Qqp0V6NB7/ilGO4myRPV6y9KKR4icM/YouiExakaw6ly6dKXc2VSkBL1T
   A==;
X-CSE-ConnectionGUID: RC3tRJwMSBKCeERDhf6sTQ==
X-CSE-MsgGUID: u+fRPz7HRu6qHDMtd83Rew==
X-IronPort-AV: E=McAfee;i="6800,10657,11567"; a="64003374"
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="64003374"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 02:48:28 -0700
X-CSE-ConnectionGUID: Bzw6+n8KSViQzx+VavmAmA==
X-CSE-MsgGUID: XE3RqHw8RoGH0CYN8GabXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="209139612"
Received: from lkp-server01.sh.intel.com (HELO 2f2a1232a4e4) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 29 Sep 2025 02:48:26 -0700
Received: from kbuild by 2f2a1232a4e4 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v3AUZ-00007v-2m;
	Mon, 29 Sep 2025 09:48:23 +0000
Date: Mon, 29 Sep 2025 17:48:10 +0800
From: kernel test robot <lkp@intel.com>
To: Haotian Zhang <vulab@iscas.ac.cn>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: Re: [PATCH] clk: mediatek: Use devm_alloc for clk_data allocation to
 fix memory leak on probe error
Message-ID: <202509291736.rboPY1Uj-lkp@intel.com>
References: <20250929023621.1968-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929023621.1968-1-vulab@iscas.ac.cn>

Hi Haotian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on linus/master v6.17 next-20250926]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Haotian-Zhang/clk-mediatek-Use-devm_alloc-for-clk_data-allocation-to-fix-memory-leak-on-probe-error/20250929-103835
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20250929023621.1968-1-vulab%40iscas.ac.cn
patch subject: [PATCH] clk: mediatek: Use devm_alloc for clk_data allocation to fix memory leak on probe error
config: arc-randconfig-002-20250929 (https://download.01.org/0day-ci/archive/20250929/202509291736.rboPY1Uj-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250929/202509291736.rboPY1Uj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509291736.rboPY1Uj-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/clk/mediatek/clk-mt6765.c:20:
   drivers/clk/mediatek/clk-mt6765.c: In function 'clk_mt6765_apmixed_probe':
>> include/dt-bindings/clock/mt6765-clk.h:32:29: warning: passing argument 1 of 'mtk_devm_alloc_clk_data' makes pointer from integer without a cast [-Wint-conversion]
    #define CLK_APMIXED_NR_CLK  22
                                ^~
   drivers/clk/mediatek/clk-mt6765.c:739:37: note: in expansion of macro 'CLK_APMIXED_NR_CLK'
     clk_data = mtk_devm_alloc_clk_data(CLK_APMIXED_NR_CLK);
                                        ^~~~~~~~~~~~~~~~~~
   In file included from drivers/clk/mediatek/clk-mt6765.c:16:
   drivers/clk/mediatek/clk-mtk.h:234:29: note: expected 'struct device *' but argument is of type 'int'
    struct clk_hw_onecell_data *mtk_devm_alloc_clk_data(struct device *dev,
                                ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/mediatek/clk-mt6765.c:739:13: error: too few arguments to function 'mtk_devm_alloc_clk_data'
     clk_data = mtk_devm_alloc_clk_data(CLK_APMIXED_NR_CLK);
                ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/clk/mediatek/clk-mt6765.c:16:
   drivers/clk/mediatek/clk-mtk.h:234:29: note: declared here
    struct clk_hw_onecell_data *mtk_devm_alloc_clk_data(struct device *dev,
                                ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/clk/mediatek/clk-mt6765.c:20:
   drivers/clk/mediatek/clk-mt6765.c: In function 'clk_mt6765_top_probe':
   include/dt-bindings/clock/mt6765-clk.h:161:26: warning: passing argument 1 of 'mtk_devm_alloc_clk_data' makes pointer from integer without a cast [-Wint-conversion]
    #define CLK_TOP_NR_CLK   126
                             ^~~
   drivers/clk/mediatek/clk-mt6765.c:773:37: note: in expansion of macro 'CLK_TOP_NR_CLK'
     clk_data = mtk_devm_alloc_clk_data(CLK_TOP_NR_CLK);
                                        ^~~~~~~~~~~~~~
   In file included from drivers/clk/mediatek/clk-mt6765.c:16:
   drivers/clk/mediatek/clk-mtk.h:234:29: note: expected 'struct device *' but argument is of type 'int'
    struct clk_hw_onecell_data *mtk_devm_alloc_clk_data(struct device *dev,
                                ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/mediatek/clk-mt6765.c:773:13: error: too few arguments to function 'mtk_devm_alloc_clk_data'
     clk_data = mtk_devm_alloc_clk_data(CLK_TOP_NR_CLK);
                ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/clk/mediatek/clk-mt6765.c:16:
   drivers/clk/mediatek/clk-mtk.h:234:29: note: declared here
    struct clk_hw_onecell_data *mtk_devm_alloc_clk_data(struct device *dev,
                                ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/clk/mediatek/clk-mt6765.c:20:
   drivers/clk/mediatek/clk-mt6765.c: In function 'clk_mt6765_ifr_probe':
   include/dt-bindings/clock/mt6765-clk.h:228:26: warning: passing argument 1 of 'mtk_devm_alloc_clk_data' makes pointer from integer without a cast [-Wint-conversion]
    #define CLK_IFR_NR_CLK   64
                             ^~
   drivers/clk/mediatek/clk-mt6765.c:813:37: note: in expansion of macro 'CLK_IFR_NR_CLK'
     clk_data = mtk_devm_alloc_clk_data(CLK_IFR_NR_CLK);
                                        ^~~~~~~~~~~~~~
   In file included from drivers/clk/mediatek/clk-mt6765.c:16:
   drivers/clk/mediatek/clk-mtk.h:234:29: note: expected 'struct device *' but argument is of type 'int'
    struct clk_hw_onecell_data *mtk_devm_alloc_clk_data(struct device *dev,
                                ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/mediatek/clk-mt6765.c:813:13: error: too few arguments to function 'mtk_devm_alloc_clk_data'
     clk_data = mtk_devm_alloc_clk_data(CLK_IFR_NR_CLK);
                ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/clk/mediatek/clk-mt6765.c:16:
   drivers/clk/mediatek/clk-mtk.h:234:29: note: declared here
    struct clk_hw_onecell_data *mtk_devm_alloc_clk_data(struct device *dev,
                                ^~~~~~~~~~~~~~~~~~~~~~~


vim +/mtk_devm_alloc_clk_data +32 include/dt-bindings/clock/mt6765-clk.h

eb7beb65ac30afb Mars Cheng 2020-02-21   8  
eb7beb65ac30afb Mars Cheng 2020-02-21   9  /* APMIXEDSYS */
eb7beb65ac30afb Mars Cheng 2020-02-21  10  #define CLK_APMIXED_ARMPLL_L		0
eb7beb65ac30afb Mars Cheng 2020-02-21  11  #define CLK_APMIXED_ARMPLL		1
eb7beb65ac30afb Mars Cheng 2020-02-21  12  #define CLK_APMIXED_CCIPLL		2
eb7beb65ac30afb Mars Cheng 2020-02-21  13  #define CLK_APMIXED_MAINPLL		3
eb7beb65ac30afb Mars Cheng 2020-02-21  14  #define CLK_APMIXED_MFGPLL		4
eb7beb65ac30afb Mars Cheng 2020-02-21  15  #define CLK_APMIXED_MMPLL		5
eb7beb65ac30afb Mars Cheng 2020-02-21  16  #define CLK_APMIXED_UNIV2PLL		6
eb7beb65ac30afb Mars Cheng 2020-02-21  17  #define CLK_APMIXED_MSDCPLL		7
eb7beb65ac30afb Mars Cheng 2020-02-21  18  #define CLK_APMIXED_APLL1		8
eb7beb65ac30afb Mars Cheng 2020-02-21  19  #define CLK_APMIXED_MPLL		9
eb7beb65ac30afb Mars Cheng 2020-02-21  20  #define CLK_APMIXED_ULPOSC1		10
eb7beb65ac30afb Mars Cheng 2020-02-21  21  #define CLK_APMIXED_ULPOSC2		11
eb7beb65ac30afb Mars Cheng 2020-02-21  22  #define CLK_APMIXED_SSUSB26M		12
eb7beb65ac30afb Mars Cheng 2020-02-21  23  #define CLK_APMIXED_APPLL26M		13
eb7beb65ac30afb Mars Cheng 2020-02-21  24  #define CLK_APMIXED_MIPIC0_26M		14
eb7beb65ac30afb Mars Cheng 2020-02-21  25  #define CLK_APMIXED_MDPLLGP26M		15
eb7beb65ac30afb Mars Cheng 2020-02-21  26  #define CLK_APMIXED_MMSYS_F26M		16
eb7beb65ac30afb Mars Cheng 2020-02-21  27  #define CLK_APMIXED_UFS26M		17
eb7beb65ac30afb Mars Cheng 2020-02-21  28  #define CLK_APMIXED_MIPIC1_26M		18
eb7beb65ac30afb Mars Cheng 2020-02-21  29  #define CLK_APMIXED_MEMPLL26M		19
eb7beb65ac30afb Mars Cheng 2020-02-21  30  #define CLK_APMIXED_CLKSQ_LVPLL_26M	20
eb7beb65ac30afb Mars Cheng 2020-02-21  31  #define CLK_APMIXED_MIPID0_26M		21
eb7beb65ac30afb Mars Cheng 2020-02-21 @32  #define CLK_APMIXED_NR_CLK		22
eb7beb65ac30afb Mars Cheng 2020-02-21  33  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


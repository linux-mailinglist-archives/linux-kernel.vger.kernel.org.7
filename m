Return-Path: <linux-kernel+bounces-835852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E35BA832F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 778841C0870
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 06:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFD32BEFF0;
	Mon, 29 Sep 2025 06:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IbDgpB3i"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B8A1AE844
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759128990; cv=none; b=D/S6yDnbVd7s/H5pzlJlH44TC94ifYjJSGqRB6wuNGJwvchAqAeEndXtvjFrOiQdJkXKKxNNKzB9KnmEJ1KZvsOBLgzPdDXIHdX9P5AF5S6MQuVv+uPkKFaKLv3r96BJOl0PFizQoTwLEVscXtUp8uALRr1hhOiYztqRJlPCpkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759128990; c=relaxed/simple;
	bh=CPNJ0DoJOWsjWqUu7JhZ8h2za7aZcaHA/CMWvZn/9W8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffBVCcpX4737vX+eWzk9a09pG5/VTDAUGnd+2R7+xoWHTiHTGlHWWynUAhJGAZ2/8mUk6+eK3SVg6yIzul7MgtzLKxRRQPWo1Ewq7hR5Bk+uezqCD0MTKfI2Fa2DB6KbyIrj4c/cA/1xJ89V2TQNDoQ7gQvMW9m65VLgCaJ7sfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IbDgpB3i; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759128989; x=1790664989;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CPNJ0DoJOWsjWqUu7JhZ8h2za7aZcaHA/CMWvZn/9W8=;
  b=IbDgpB3ipHBf5Junhd7KC0xVCkWpW2YcQN39wL6kEFPVrCLLbNxsKbe9
   EtAr/byxzPzHVEDlNMrtpw4Q15Xao9NUT+pozMBo5jScIGV/+yxX0fpvC
   hRNUimaokhUYxeEgEDk7j8hbOkcyfEx/HjR3Gz+JH3RRzLILTzpQI8Lig
   zNmyoHK++ksyHh6mhbEhyuU46RYJe9TigbdV1Cg0G7iHx1bNwIHwaMbEY
   aREEAUi1VnbjyalUq7PbeJUeZJb01ptsecU/gbiv2EPc6k2J8xaisl8TR
   Y4NjMuulhrvaaQoW4AZ8FKHFFH1FgKS1JJ68GrLsqMMfINqsKMUevrDwB
   A==;
X-CSE-ConnectionGUID: E/B/2oaxSpyF8Qa/mMCT4w==
X-CSE-MsgGUID: 3oYeWTcURVywzK9foy+/PQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61411864"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61411864"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2025 23:56:28 -0700
X-CSE-ConnectionGUID: 9E5dO3GkRtadc1zjR3AKTQ==
X-CSE-MsgGUID: ENISX4HsQnWcDb+ywlSk9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="178584086"
Received: from lkp-server02.sh.intel.com (HELO 62862f778ede) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 28 Sep 2025 23:56:26 -0700
Received: from kbuild by 62862f778ede with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v37o3-00003P-22;
	Mon, 29 Sep 2025 06:56:20 +0000
Date: Mon, 29 Sep 2025 14:54:39 +0800
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
Message-ID: <202509291432.RfHOsLVY-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on linus/master v6.17 next-20250926]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Haotian-Zhang/clk-mediatek-Use-devm_alloc-for-clk_data-allocation-to-fix-memory-leak-on-probe-error/20250929-103835
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20250929023621.1968-1-vulab%40iscas.ac.cn
patch subject: [PATCH] clk: mediatek: Use devm_alloc for clk_data allocation to fix memory leak on probe error
config: i386-buildonly-randconfig-001-20250929 (https://download.01.org/0day-ci/archive/20250929/202509291432.RfHOsLVY-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250929/202509291432.RfHOsLVY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509291432.RfHOsLVY-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/clk/mediatek/clk-mt6765.c:20:
   drivers/clk/mediatek/clk-mt6765.c: In function 'clk_mt6765_apmixed_probe':
>> include/dt-bindings/clock/mt6765-clk.h:32:41: error: passing argument 1 of 'mtk_devm_alloc_clk_data' makes pointer from integer without a cast [-Wint-conversion]
      32 | #define CLK_APMIXED_NR_CLK              22
         |                                         ^~
         |                                         |
         |                                         int
   drivers/clk/mediatek/clk-mt6765.c:739:44: note: in expansion of macro 'CLK_APMIXED_NR_CLK'
     739 |         clk_data = mtk_devm_alloc_clk_data(CLK_APMIXED_NR_CLK);
         |                                            ^~~~~~~~~~~~~~~~~~
   In file included from drivers/clk/mediatek/clk-mt6765.c:16:
   drivers/clk/mediatek/clk-mtk.h:234:68: note: expected 'struct device *' but argument is of type 'int'
     234 | struct clk_hw_onecell_data *mtk_devm_alloc_clk_data(struct device *dev,
         |                                                     ~~~~~~~~~~~~~~~^~~
>> drivers/clk/mediatek/clk-mt6765.c:739:20: error: too few arguments to function 'mtk_devm_alloc_clk_data'
     739 |         clk_data = mtk_devm_alloc_clk_data(CLK_APMIXED_NR_CLK);
         |                    ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/mediatek/clk-mtk.h:234:29: note: declared here
     234 | struct clk_hw_onecell_data *mtk_devm_alloc_clk_data(struct device *dev,
         |                             ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/mediatek/clk-mt6765.c: In function 'clk_mt6765_top_probe':
   include/dt-bindings/clock/mt6765-clk.h:161:41: error: passing argument 1 of 'mtk_devm_alloc_clk_data' makes pointer from integer without a cast [-Wint-conversion]
     161 | #define CLK_TOP_NR_CLK                  126
         |                                         ^~~
         |                                         |
         |                                         int
   drivers/clk/mediatek/clk-mt6765.c:773:44: note: in expansion of macro 'CLK_TOP_NR_CLK'
     773 |         clk_data = mtk_devm_alloc_clk_data(CLK_TOP_NR_CLK);
         |                                            ^~~~~~~~~~~~~~
   drivers/clk/mediatek/clk-mtk.h:234:68: note: expected 'struct device *' but argument is of type 'int'
     234 | struct clk_hw_onecell_data *mtk_devm_alloc_clk_data(struct device *dev,
         |                                                     ~~~~~~~~~~~~~~~^~~
   drivers/clk/mediatek/clk-mt6765.c:773:20: error: too few arguments to function 'mtk_devm_alloc_clk_data'
     773 |         clk_data = mtk_devm_alloc_clk_data(CLK_TOP_NR_CLK);
         |                    ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/mediatek/clk-mtk.h:234:29: note: declared here
     234 | struct clk_hw_onecell_data *mtk_devm_alloc_clk_data(struct device *dev,
         |                             ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/mediatek/clk-mt6765.c: In function 'clk_mt6765_ifr_probe':
   include/dt-bindings/clock/mt6765-clk.h:228:41: error: passing argument 1 of 'mtk_devm_alloc_clk_data' makes pointer from integer without a cast [-Wint-conversion]
     228 | #define CLK_IFR_NR_CLK                  64
         |                                         ^~
         |                                         |
         |                                         int
   drivers/clk/mediatek/clk-mt6765.c:813:44: note: in expansion of macro 'CLK_IFR_NR_CLK'
     813 |         clk_data = mtk_devm_alloc_clk_data(CLK_IFR_NR_CLK);
         |                                            ^~~~~~~~~~~~~~
   drivers/clk/mediatek/clk-mtk.h:234:68: note: expected 'struct device *' but argument is of type 'int'
     234 | struct clk_hw_onecell_data *mtk_devm_alloc_clk_data(struct device *dev,
         |                                                     ~~~~~~~~~~~~~~~^~~
   drivers/clk/mediatek/clk-mt6765.c:813:20: error: too few arguments to function 'mtk_devm_alloc_clk_data'
     813 |         clk_data = mtk_devm_alloc_clk_data(CLK_IFR_NR_CLK);
         |                    ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/mediatek/clk-mtk.h:234:29: note: declared here
     234 | struct clk_hw_onecell_data *mtk_devm_alloc_clk_data(struct device *dev,
         |                             ^~~~~~~~~~~~~~~~~~~~~~~


vim +/mtk_devm_alloc_clk_data +32 include/dt-bindings/clock/mt6765-clk.h

eb7beb65ac30af Mars Cheng 2020-02-21   8  
eb7beb65ac30af Mars Cheng 2020-02-21   9  /* APMIXEDSYS */
eb7beb65ac30af Mars Cheng 2020-02-21  10  #define CLK_APMIXED_ARMPLL_L		0
eb7beb65ac30af Mars Cheng 2020-02-21  11  #define CLK_APMIXED_ARMPLL		1
eb7beb65ac30af Mars Cheng 2020-02-21  12  #define CLK_APMIXED_CCIPLL		2
eb7beb65ac30af Mars Cheng 2020-02-21  13  #define CLK_APMIXED_MAINPLL		3
eb7beb65ac30af Mars Cheng 2020-02-21  14  #define CLK_APMIXED_MFGPLL		4
eb7beb65ac30af Mars Cheng 2020-02-21  15  #define CLK_APMIXED_MMPLL		5
eb7beb65ac30af Mars Cheng 2020-02-21  16  #define CLK_APMIXED_UNIV2PLL		6
eb7beb65ac30af Mars Cheng 2020-02-21  17  #define CLK_APMIXED_MSDCPLL		7
eb7beb65ac30af Mars Cheng 2020-02-21  18  #define CLK_APMIXED_APLL1		8
eb7beb65ac30af Mars Cheng 2020-02-21  19  #define CLK_APMIXED_MPLL		9
eb7beb65ac30af Mars Cheng 2020-02-21  20  #define CLK_APMIXED_ULPOSC1		10
eb7beb65ac30af Mars Cheng 2020-02-21  21  #define CLK_APMIXED_ULPOSC2		11
eb7beb65ac30af Mars Cheng 2020-02-21  22  #define CLK_APMIXED_SSUSB26M		12
eb7beb65ac30af Mars Cheng 2020-02-21  23  #define CLK_APMIXED_APPLL26M		13
eb7beb65ac30af Mars Cheng 2020-02-21  24  #define CLK_APMIXED_MIPIC0_26M		14
eb7beb65ac30af Mars Cheng 2020-02-21  25  #define CLK_APMIXED_MDPLLGP26M		15
eb7beb65ac30af Mars Cheng 2020-02-21  26  #define CLK_APMIXED_MMSYS_F26M		16
eb7beb65ac30af Mars Cheng 2020-02-21  27  #define CLK_APMIXED_UFS26M		17
eb7beb65ac30af Mars Cheng 2020-02-21  28  #define CLK_APMIXED_MIPIC1_26M		18
eb7beb65ac30af Mars Cheng 2020-02-21  29  #define CLK_APMIXED_MEMPLL26M		19
eb7beb65ac30af Mars Cheng 2020-02-21  30  #define CLK_APMIXED_CLKSQ_LVPLL_26M	20
eb7beb65ac30af Mars Cheng 2020-02-21  31  #define CLK_APMIXED_MIPID0_26M		21
eb7beb65ac30af Mars Cheng 2020-02-21 @32  #define CLK_APMIXED_NR_CLK		22
eb7beb65ac30af Mars Cheng 2020-02-21  33  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


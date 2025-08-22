Return-Path: <linux-kernel+bounces-782696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2307CB323C8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 22:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 048001CE76EB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 20:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E4F2FB632;
	Fri, 22 Aug 2025 20:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D6ITf2XT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AF32EB861;
	Fri, 22 Aug 2025 20:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755895774; cv=none; b=m9fFgFzZr7gqfnEA5Aq876vIb+vc+Y3vqleSoJ7VA/S8n5tIGPu5aT59sRi9tBmxWmfwAbvfbvk9tcbZET0bIbKp36KGePeqbHC5id2w5s7xiMunneH5x15JtYEJlvRB5v9k8wjyjRLQ1Es5lPwFiKRk1yNWSQaFSx9ct372Rjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755895774; c=relaxed/simple;
	bh=T6qRJEDHnq+mnjsWtsK8R7/Xtst4O7SL4dK318Mo5qM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTfsrSIiccR8VMW5V8soTZrQ7jiuUdZkJZwF8RGWR/Xvv9walY/R6thVoI0rydJjgvmCNbjhAH/YOVcSj8PgaPm1Db4O6l1ka959VwaetDv7RwbH2jzPH0CwLgEoaeFvv3wqJWg+POWBr6emcvZwNiHEzZcoZU3FIK8uBwBiipY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D6ITf2XT; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755895771; x=1787431771;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T6qRJEDHnq+mnjsWtsK8R7/Xtst4O7SL4dK318Mo5qM=;
  b=D6ITf2XTVFDv10Y1q6lQvn4tTyTkKJ/WBOqlr6pk0275CJqb9ndGckli
   QZqI3EfBU78w7Moh72ki7r8RslL1eDZY/Yv4hSE6Kmf4Pkgz2aAqgyAgN
   EUrn4dtR7941AoJo54zpZECsKJdwUbUBUxl0ENUNox26lS5cQyw43xZQI
   15I/HCAisuGNrgB0g7bHZbd7kWdyipig/m1BtjktcQyz3ybVpe7N3Z09O
   wb2DrpCoYMYYNedj/ADf2fAMuWJ4ZBpmXTHxhUI8T4d16BsMM9SgQmT0g
   Zc73xI+c33E2zKOh0TpCAKQ8C1np4YECZUk5HSa5gRnP7jDsqgD/OXNF/
   A==;
X-CSE-ConnectionGUID: Ip7h6ZrpQXyU/NvlvUc3Iw==
X-CSE-MsgGUID: do0eAljOSKOHvlswFB33Bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="58356631"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58356631"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 13:49:30 -0700
X-CSE-ConnectionGUID: n/+zYlt0RPqPyOa2rQ36qA==
X-CSE-MsgGUID: m+IUK9QUTnelV4MFBQJK3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="168399112"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 22 Aug 2025 13:49:28 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upYhR-000Lp5-2X;
	Fri, 22 Aug 2025 20:49:25 +0000
Date: Sat, 23 Aug 2025 04:48:32 +0800
From: kernel test robot <lkp@intel.com>
To: Chen-Yu Tsai <wenst@chromium.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Chen-Yu Tsai <wenst@chromium.org>,
	linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: mediatek: clk-mux: Do not pass flags to
 clk_mux_determine_rate_flags()
Message-ID: <202508230416.OIwROhOT-lkp@intel.com>
References: <20250822062854.2633133-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822062854.2633133-1-wenst@chromium.org>

Hi Chen-Yu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on linus/master v6.17-rc2 next-20250822]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chen-Yu-Tsai/clk-mediatek-clk-mux-Do-not-pass-flags-to-clk_mux_determine_rate_flags/20250822-143106
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20250822062854.2633133-1-wenst%40chromium.org
patch subject: [PATCH] clk: mediatek: clk-mux: Do not pass flags to clk_mux_determine_rate_flags()
config: x86_64-buildonly-randconfig-004-20250823 (https://download.01.org/0day-ci/archive/20250823/202508230416.OIwROhOT-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250823/202508230416.OIwROhOT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508230416.OIwROhOT-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/clk/mediatek/clk-mux.c:149:22: warning: unused variable 'mux' [-Wunused-variable]
     149 |         struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
         |                             ^~~
   1 warning generated.


vim +/mux +149 drivers/clk/mediatek/clk-mux.c

a3ae549917f163 Owen Chen                  2019-03-05  145  
b05ea3314390e9 AngeloGioacchino Del Regno 2022-10-11  146  static int mtk_clk_mux_determine_rate(struct clk_hw *hw,
b05ea3314390e9 AngeloGioacchino Del Regno 2022-10-11  147  				      struct clk_rate_request *req)
b05ea3314390e9 AngeloGioacchino Del Regno 2022-10-11  148  {
b05ea3314390e9 AngeloGioacchino Del Regno 2022-10-11 @149  	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
b05ea3314390e9 AngeloGioacchino Del Regno 2022-10-11  150  
6c66f834fd3bf9 Chen-Yu Tsai               2025-08-22  151  	return clk_mux_determine_rate_flags(hw, req, 0);
b05ea3314390e9 AngeloGioacchino Del Regno 2022-10-11  152  }
b05ea3314390e9 AngeloGioacchino Del Regno 2022-10-11  153  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


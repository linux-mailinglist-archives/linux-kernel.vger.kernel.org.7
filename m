Return-Path: <linux-kernel+bounces-848654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FFDBCE44E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B68DC4E946A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 18:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CD7301483;
	Fri, 10 Oct 2025 18:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hY6xOg/m"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E7D2FD1C2;
	Fri, 10 Oct 2025 18:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760121740; cv=none; b=DAc8gNgaPFgxRR5/ZPW2YEbcUhNHuF6Hz0e+FgLkgXz73zH4ycs7OnfE7/+jJK+PRdItlxwZJsM/ddofYlxHgON+oOTHaSZgYA2WLtTCNS7CIN7DmGtQ0OCrnkV3MHp6S7y0UlCOTgmhEtICTfuK5hFBB2S5N6hRnyELLUrfqII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760121740; c=relaxed/simple;
	bh=yr5O1vBEL2Wcyj75rjICSFJodCn8Ot3ie+4ynX8Yldk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5fO9WxGzR6dvVeoSHs+GhLGmyGjfuVfZi5vsNtxFCF75PVrBObKHfjrj4/Z7ZeMp079muCxSAudSb9YXRja8WfyS5UPYtAiivFfyxTHB7zhTy88JiRIYvDDOTD+WKFJMoL3oOW2aJqE/fZ7AZkTmWkGHLiqjU6pUTvi+I0MgKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hY6xOg/m; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760121739; x=1791657739;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yr5O1vBEL2Wcyj75rjICSFJodCn8Ot3ie+4ynX8Yldk=;
  b=hY6xOg/mxPP8kJtu+ReunRCg/q2cUbaWPg//Q4V1f3BFr8elyz/IKDTK
   Q/0ffPTdLtCOkNwIorajcEclvwCvyFfeV0CvkaOQqQS/TfSKrS4IzZTq8
   IVN3yL7pJE9OOoFb6ovO1a4z4/CwlWFVBZRQw81NrWj3Q2+jubwlasJM1
   u03Sfsdo1DED+zKL1BsyZglwxj15ddSrrZtr/dhzcziuiJgK0B9zqdaBv
   TDOt6Re35HxfpqTAxaAneMJvCG6TEpkvY9EnrKtch5spk76Z4XHSbGJLs
   IFblwBqeuFetbjhHWzVicuk3D7VBWQnZU1uqj4Gqcv0ktfuzto9cfwvBn
   w==;
X-CSE-ConnectionGUID: 5TCRL1xeTIufAvs+8wrsgg==
X-CSE-MsgGUID: pl7xvq+ZTvSLFUIb/+GTJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62288507"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62288507"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 11:42:18 -0700
X-CSE-ConnectionGUID: udKB6OpJROCUFgb3Kiq00g==
X-CSE-MsgGUID: 9kUA5bX/QIC8UPbCsBCYfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="180158850"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 10 Oct 2025 11:42:12 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v7I49-000345-2q;
	Fri, 10 Oct 2025 18:42:09 +0000
Date: Sat, 11 Oct 2025 02:41:35 +0800
From: kernel test robot <lkp@intel.com>
To: Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Sebin Francis <sebin.francis@ti.com>,
	Brian Masney <bmasney@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, Dan Carpenter <error27@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v5 4/6] clk: Add KUnit tests for assigned-clock-sscs
Message-ID: <202510110212.VLPx3MCC-lkp@intel.com>
References: <20251009-clk-ssc-v5-1-v5-4-d6447d76171e@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009-clk-ssc-v5-1-v5-4-d6447d76171e@nxp.com>

Hi Peng,

kernel test robot noticed the following build errors:

[auto build test ERROR on 7c3ba4249a3604477ea9c077e10089ba7ddcaa03]

url:    https://github.com/intel-lab-lkp/linux/commits/Peng-Fan/dt-bindings-clock-Add-spread-spectrum-definition/20251010-085803
base:   7c3ba4249a3604477ea9c077e10089ba7ddcaa03
patch link:    https://lore.kernel.org/r/20251009-clk-ssc-v5-1-v5-4-d6447d76171e%40nxp.com
patch subject: [PATCH v5 4/6] clk: Add KUnit tests for assigned-clock-sscs
config: s390-randconfig-002-20251011 (https://download.01.org/0day-ci/archive/20251011/202510110212.VLPx3MCC-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251011/202510110212.VLPx3MCC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510110212.VLPx3MCC-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/clk/clk_test.c:115:32: error: initialization of 'int (*)(struct clk_hw *, const struct clk_spread_spectrum *)' from incompatible pointer type 'int (*)(struct clk_hw *, struct clk_spread_spectrum *)' [-Wincompatible-pointer-types]
     115 |         .set_spread_spectrum = clk_dummy_set_spread_spectrum,
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/clk_test.c:115:32: note: (near initialization for 'clk_dummy_rate_ops.set_spread_spectrum')
   drivers/clk/clk_test.c:87:12: note: 'clk_dummy_set_spread_spectrum' declared here
      87 | static int clk_dummy_set_spread_spectrum(struct clk_hw *hw,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/clk_test.c:122:32: error: initialization of 'int (*)(struct clk_hw *, const struct clk_spread_spectrum *)' from incompatible pointer type 'int (*)(struct clk_hw *, struct clk_spread_spectrum *)' [-Wincompatible-pointer-types]
     122 |         .set_spread_spectrum = clk_dummy_set_spread_spectrum,
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/clk_test.c:122:32: note: (near initialization for 'clk_dummy_maximize_rate_ops.set_spread_spectrum')
   drivers/clk/clk_test.c:87:12: note: 'clk_dummy_set_spread_spectrum' declared here
      87 | static int clk_dummy_set_spread_spectrum(struct clk_hw *hw,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/clk_test.c:129:32: error: initialization of 'int (*)(struct clk_hw *, const struct clk_spread_spectrum *)' from incompatible pointer type 'int (*)(struct clk_hw *, struct clk_spread_spectrum *)' [-Wincompatible-pointer-types]
     129 |         .set_spread_spectrum = clk_dummy_set_spread_spectrum,
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/clk_test.c:129:32: note: (near initialization for 'clk_dummy_minimize_rate_ops.set_spread_spectrum')
   drivers/clk/clk_test.c:87:12: note: 'clk_dummy_set_spread_spectrum' declared here
      87 | static int clk_dummy_set_spread_spectrum(struct clk_hw *hw,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +115 drivers/clk/clk_test.c

   110	
   111	static const struct clk_ops clk_dummy_rate_ops = {
   112		.recalc_rate = clk_dummy_recalc_rate,
   113		.determine_rate = clk_dummy_determine_rate,
   114		.set_rate = clk_dummy_set_rate,
 > 115		.set_spread_spectrum = clk_dummy_set_spread_spectrum,
   116	};
   117	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


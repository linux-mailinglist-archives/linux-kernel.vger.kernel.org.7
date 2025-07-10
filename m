Return-Path: <linux-kernel+bounces-726604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE06B00F28
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 00:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3E6B7BD9EE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C342C08C8;
	Thu, 10 Jul 2025 22:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l+bH0MD1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC872C0323
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 22:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752188175; cv=none; b=pBoh54sAWCF243XdQ9JPrHHHJjdtQUJMjBEIxLO3J0K6kWJSS3xFDdJT9BsYbVyr2wLWicbYhNmLRtX9jmhGiln9TYaWV1e535Nfce/KNYfoGcp7H42EeB893G5q5UpWP307Mf1cl94BuIAd1+8+jiM98oTkzrSeQGabzoNkAIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752188175; c=relaxed/simple;
	bh=DtBCnSmhIL5QlVvXed3zGCyfHWHT1jsOpnFz7W+i8ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b24YQwgE4eZcSmt14PXbwCjw4YXDSfESzxje4Ep57kkxWAEYfGUoO8RnuKwGyv06uqtRLeBDK7bFWuoztF2u+NVDzT64jhIlAx+jpmwonQnkQExRYpcAGHFjJvlsxCaRT/QfzHC1LqpFaRdgGu3wzIhIdEKb9m/t2eSHnj0dLnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l+bH0MD1; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752188175; x=1783724175;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DtBCnSmhIL5QlVvXed3zGCyfHWHT1jsOpnFz7W+i8ZU=;
  b=l+bH0MD1RrnqKwbOOeJy9nc7LnMRrSzBG3p5rI91nfl0hJ4M3DHWPm4Q
   GDvogTCPv3BYuIsPBUeGjbMquIXFy9UbdD8vTMDvaeca3RiL7xNd5c+s5
   +AKfJCDKpzCDRu+/5lQsYRpN+fCkbvqRhKzNLeo9IXZDr4AAyKyfB1ku/
   ktqVvQ+Xn1Bd49IPY18grEfHIGXvzNl0hDb9uUClKNrDpyW3tAdpgBn1E
   0TFlkPeOkVHN30fTyzpwA6Ql+CDF48QM02UVMuHlILa3Hu7xmYAri3NeK
   uKntmUIeaFJIKLhbdhuzXa3l3GfQ2ZriGLBmGhISTxP/LTGLwUbKuB4OS
   A==;
X-CSE-ConnectionGUID: avUjMve8QbOV/Wgr7D+v4w==
X-CSE-MsgGUID: 2oy1FmjgQzqMNeRsu67nFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="71930990"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="71930990"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 15:56:14 -0700
X-CSE-ConnectionGUID: 5cB1inXeQUu1peA9zbTvNw==
X-CSE-MsgGUID: 3jPQiPwBQWq/5zJ1RdER0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="156702190"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 10 Jul 2025 15:56:07 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ua0BQ-0005Yt-1l;
	Thu, 10 Jul 2025 22:56:04 +0000
Date: Fri, 11 Jul 2025 06:55:17 +0800
From: kernel test robot <lkp@intel.com>
To: ksk4725@coasia.com, Jesper Nilsson <jesper.nilsson@axis.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Ravi Patel <ravi.patel@samsung.com>,
	SungMin Park <smn1196@coasia.com>
Cc: oe-kbuild-all@lists.linux.dev, kenkim <kenkim@coasia.com>,
	Jongshin Park <pjsin865@coasia.com>,
	GunWoo Kim <gwk1013@coasia.com>, HaGyeong Kim <hgkim05@coasia.com>,
	GyoungBo Min <mingyoungbo@coasia.com>,
	Pankaj Dubey <pankaj.dubey@samsung.com>,
	Shradha Todi <shradha.t@samsung.com>,
	Inbaraj E <inbaraj.e@samsung.com>,
	Swathi K S <swathi.ks@samsung.com>,
	Hrishikesh <hrishikesh.d@samsung.com>,
	Dongjin Yang <dj76.yang@samsung.com>,
	Sang Min Kim <hypmean.kim@samsung.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/16] clk: samsung: artpec-8: Add clock support for
 CMU_CMU block
Message-ID: <202507110637.uCFXqy3U-lkp@intel.com>
References: <20250710002047.1573841-6-ksk4725@coasia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710002047.1573841-6-ksk4725@coasia.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on krzk/for-next]
[also build test WARNING on robh/for-next pinctrl-samsung/for-next linus/master v6.16-rc5 next-20250710]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/ksk4725-coasia-com/dt-bindings-clock-Add-CMU-bindings-definitions-for-ARTPEC-8-platform/20250710-082940
base:   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git for-next
patch link:    https://lore.kernel.org/r/20250710002047.1573841-6-ksk4725%40coasia.com
patch subject: [PATCH 05/16] clk: samsung: artpec-8: Add clock support for CMU_CMU block
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20250711/202507110637.uCFXqy3U-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 01c97b4953e87ae455bd4c41e3de3f0f0f29c61c)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250711/202507110637.uCFXqy3U-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507110637.uCFXqy3U-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/clk/samsung/clk-artpec8.c:201:7: warning: unused variable 'mout_clkcmu_fsys_sfmc_p' [-Wunused-const-variable]
     201 | PNAME(mout_clkcmu_fsys_sfmc_p) = {
         |       ^~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +/mout_clkcmu_fsys_sfmc_p +201 drivers/clk/samsung/clk-artpec8.c

   179	
   180	PNAME(mout_clkcmu_bus_bus_p) = {
   181		"dout_pll_shared1_div2", "dout_pll_shared0_div3",
   182		"dout_pll_shared1_div3", "dout_pll_shared1_div4" };
   183	PNAME(mout_clkcmu_bus_dlp_p) = {
   184		"dout_pll_shared0_div2", "dout_pll_shared0_div4",
   185		"dout_pll_shared1_div2", "dout_pll_shared1_div4" };
   186	PNAME(mout_clkcmu_core_bus_p) = {
   187		"dout_pll_shared1_div2", "dout_pll_shared0_div3",
   188		"dout_pll_shared0_div4", "dout_pll_shared1_div3" };
   189	PNAME(mout_clkcmu_core_dlp_p) = {
   190		"dout_pll_shared0_div2", "dout_pll_sahred1_div2",
   191		"dout_pll_shared0_div3", "dout_pll_shared1_div3" };
   192	PNAME(mout_clkcmu_cpucl_switch_p) = {
   193		"dout_pll_shared0_div2", "dout_pll_shared1_div2",
   194		"dout_pll_shared0_div3", "dout_pll_shared1_div3" };
   195	PNAME(mout_clkcmu_fsys_bus_p) = {
   196		"dout_pll_shared1_div2", "dout_pll_shared0_div2",
   197		"dout_pll_shared1_div4", "dout_pll_shared1_div3" };
   198	PNAME(mout_clkcmu_fsys_ip_p) = {
   199		"dout_pll_shared0_div2", "dout_pll_shared1_div3",
   200		"dout_pll_shared1_div2", "dout_pll_shared0_div3" };
 > 201	PNAME(mout_clkcmu_fsys_sfmc_p) = {
   202		"dout_pll_shared1_div3", "dout_pll_shared0_div2",
   203		"dout_pll_shared1_div2", "dout_pll_shared0_div3" };
   204	PNAME(mout_clkcmu_fsys_scan0_p) = {
   205		"dout_pll_shared0_div4", "dout_pll_shared1_div4" };
   206	PNAME(mout_clkcmu_fsys_scan1_p) = {
   207		"dout_pll_shared0_div4", "dout_pll_shared1_div4" };
   208	PNAME(mout_clkcmu_imem_imem_p) = {
   209		"dout_pll_shared1_div4", "dout_pll_shared0_div3",
   210		"dout_pll_shared1_div3", "dout_pll_shared1_div2" };
   211	PNAME(mout_clkcmu_imem_jpeg_p) = {
   212		"dout_pll_shared0_div2", "dout_pll_shared0_div3",
   213		"dout_pll_shared1_div2", "dout_pll_shared1_div3" };
   214	PNAME(mout_clkcmu_cdc_core_p) = {
   215		"dout_pll_shared1_div2", "dout_pll_shared0_div3",
   216		"dout_pll_shared1_div3", "dout_pll_shared1_div4" };
   217	PNAME(mout_clkcmu_dlp_core_p) = {
   218		"dout_pll_shared0_div2", "dout_pll_shared1_div2",
   219		"dout_pll_shared0_div3", "dout_pll_shared1_div3" };
   220	PNAME(mout_clkcmu_3d_p) = {
   221		"dout_pll_shared0_div2", "dout_pll_shared1_div2",
   222		"dout_pll_shared0_div3", "dout_pll_shared1_div3" };
   223	PNAME(mout_clkcmu_2d_p) = {
   224		"dout_pll_shared0_div2", "dout_pll_shared1_div2",
   225		"dout_pll_shared0_div3", "dout_pll_shared1_div3" };
   226	PNAME(mout_clkcmu_mif_switch_p) = {
   227		"dout_pll_shared0", "dout_pll_shared1",
   228		"dout_pll_shared0_div2", "dout_pll_shared0_div3" };
   229	PNAME(mout_clkcmu_mif_busp_p) = {
   230		"dout_pll_shared0_div3", "dout_pll_shared1_div4",
   231		"dout_pll_shared0_div4", "dout_pll_shared0_div2" };
   232	PNAME(mout_clkcmu_peri_disp_p) = {
   233		"dout_pll_shared1_div2", "dout_pll_shared0_div2",
   234		"dout_pll_shared1_div4", "dout_pll_shared1_div3" };
   235	PNAME(mout_clkcmu_peri_ip_p) = {
   236		"dout_pll_shared1_div2", "dout_pll_shared0_div4",
   237		"dout_pll_shared1_div4", "dout_pll_shared0_div2" };
   238	PNAME(mout_clkcmu_rsp_core_p) = {
   239		"dout_pll_shared1_div2", "dout_pll_shared0_div3",
   240		"dout_pll_shared1_div3", "dout_pll_shared1_div4" };
   241	PNAME(mout_clkcmu_trfm_core_p) = {
   242		"dout_pll_shared1_div2", "dout_pll_shared0_div3",
   243		"dout_pll_shared1_div3", "dout_pll_shared1_div4" };
   244	PNAME(mout_clkcmu_vca_ace_p) = {
   245		"dout_pll_shared1_div2", "dout_pll_shared0_div3",
   246		"dout_pll_shared1_div3", "dout_pll_shared1_div4" };
   247	PNAME(mout_clkcmu_vca_od_p) = {
   248		"dout_pll_shared1_div2", "dout_pll_shared0_div3",
   249		"dout_pll_shared1_div3", "dout_pll_shared1_div4" };
   250	PNAME(mout_clkcmu_vio_core_p) = {
   251		"dout_pll_shared0_div3", "dout_pll_shared0_div2",
   252		"dout_pll_shared1_div2", "dout_pll_shared1_div3" };
   253	PNAME(mout_clkcmu_vip0_core_p) = {
   254		"dout_pll_shared1_div2", "dout_pll_shared0_div3",
   255		"dout_pll_shared1_div3", "dout_pll_shared1_div4" };
   256	PNAME(mout_clkcmu_vip1_core_p) = {
   257		"dout_pll_shared1_div2", "dout_pll_shared0_div3",
   258		"dout_pll_shared1_div3", "dout_pll_shared1_div4" };
   259	PNAME(mout_clkcmu_vpp_core_p) = {
   260		"dout_pll_shared1_div2", "dout_pll_shared0_div3",
   261		"dout_pll_shared1_div3", "dout_pll_shared1_div4" };
   262	PNAME(mout_clkcmu_pll_shared0_p) = { "fin_pll", "fout_pll_shared0" };
   263	PNAME(mout_clkcmu_pll_shared1_p) = { "fin_pll", "fout_pll_shared1" };
   264	PNAME(mout_clkcmu_pll_audio_p) = { "fin_pll", "fout_pll_audio" };
   265	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-kernel+bounces-844691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C581BC2838
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 21:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ED73B34E8B2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 19:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1802B2DA76C;
	Tue,  7 Oct 2025 19:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Btmyp3T6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1853229B1F;
	Tue,  7 Oct 2025 19:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759865624; cv=none; b=F66/40vTR6k2tXqRxD15qOm81jXp7rZ79frlRJf406Kw4ncsHeqNOJYMJq18DCO0ZXkDQBXtW6dxwpGW6uh0uGcPcpd8LTDYJrvTM7g6epAVQnHK1tlxtsoAx8NFbv2YFGkJGKXEKuxY75Hc59/YAiUxSd7pduPOP6NtUoJbkOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759865624; c=relaxed/simple;
	bh=1ABVdOdS45tzlNhfhjOVPvsY/QQgFK6EkT8seexuK4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWTI6a2TwiiBmuSNXek7xbMKa/QIXEiSTLtFpCy10oTpRN5WZgINNU7NLhjwx/VpQh8kXxeUY+1/m+IeLOHHeg0+yLIfKFUktuZC+zRp9PE2c1tmEpzvnxBXPGaVQFZ9XSHT89me+vFukFwj6cdeyWIbJyahyzTKZPdzAPidSK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Btmyp3T6; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759865622; x=1791401622;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1ABVdOdS45tzlNhfhjOVPvsY/QQgFK6EkT8seexuK4M=;
  b=Btmyp3T61abJWwaYN5SE1uabS+AmJM9pBSpvjqm727L60K/DjbNxBIJj
   iammekrxpBSu1uhUxZe4Hl2fUUY3yAfcDmbh+oS7df7qS01AlE3gRv3Gg
   i5HRAGsesb9aAC0IL/n6z8eoMpWVsa2PERPLWY7jxu67teyGg1M2v63Bb
   zdV9bqpNgyFVSfEFZr062QOlcyTAhPR9PvA7Nd4Gha8DeFxyP06pze7Ke
   EKBfUeywskksr0ZjGCExWKu7SnrSKPUWa2qIqhCH/xjkrS2tkSRZh5iBZ
   fP1DIx4Tj2wsiDqg49rQ0Iie1//8YzaYp5GbqLda6a8TMwZjG4X02zydP
   g==;
X-CSE-ConnectionGUID: eiFXfXPcR2yAkPhS2VEK+Q==
X-CSE-MsgGUID: RMbyS2LQQ9q+50GIdQ9kyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61974145"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61974145"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 12:33:41 -0700
X-CSE-ConnectionGUID: xPssVK6ERI6TqiI6LcTAGg==
X-CSE-MsgGUID: ia3cnOsoTy6733I3bchwyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="203958184"
Received: from igk-lkp-server01.igk.intel.com (HELO 0e586ad5e7f7) ([10.91.175.65])
  by fmviesa002.fm.intel.com with ESMTP; 07 Oct 2025 12:33:38 -0700
Received: from kbuild by 0e586ad5e7f7 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1v6DRH-000000007wv-2ZFu;
	Tue, 07 Oct 2025 19:33:35 +0000
Date: Tue, 7 Oct 2025 21:33:05 +0200
From: kernel test robot <lkp@intel.com>
To: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Chuan Liu <chuan.liu@amlogic.com>
Subject: Re: [PATCH 11/19] arm64: dts: amlogic: A4: Add peripherals clock
 controller node
Message-ID: <202510072131.VRSrXJh7-lkp@intel.com>
References: <20250930-a4_a5_add_clock_driver-v1-11-a9acf7951589@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930-a4_a5_add_clock_driver-v1-11-a9acf7951589@amlogic.com>

Hi Chuan,

kernel test robot noticed the following build errors:

[auto build test ERROR on 01f3a6d1d59b8e25a6de243b0d73075cf0415eaf]

url:    https://github.com/intel-lab-lkp/linux/commits/Chuan-Liu-via-B4-Relay/dt-bindings-clock-Add-Amlogic-A4-SCMI-clock-controller/20250930-174011
base:   01f3a6d1d59b8e25a6de243b0d73075cf0415eaf
patch link:    https://lore.kernel.org/r/20250930-a4_a5_add_clock_driver-v1-11-a9acf7951589%40amlogic.com
patch subject: [PATCH 11/19] arm64: dts: amlogic: A4: Add peripherals clock controller node
config: arm64-randconfig-2051-20251007 (https://download.01.org/0day-ci/archive/20251007/202510072131.VRSrXJh7-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project c410e88f0f8c0654d7744d6d029009f9cb736143)
dtschema version: 2025.8
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251007/202510072131.VRSrXJh7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510072131.VRSrXJh7-lkp@intel.com/

All errors (new ones prefixed by >>):

   Error: arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi:119.19-20 syntax error
>> FATAL ERROR: Unable to parse input tree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


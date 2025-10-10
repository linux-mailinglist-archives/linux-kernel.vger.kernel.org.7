Return-Path: <linux-kernel+bounces-847765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A23BCBA27
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 06:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FCBA19E4AEE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 04:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9721FDE31;
	Fri, 10 Oct 2025 04:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DyAy+Jo4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5D136B;
	Fri, 10 Oct 2025 04:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760070122; cv=none; b=JkqQuyjef9KwjnJ+Gsm5Ng2x9xWutpbvxrBxIdljCuajadhBR8QTii5WLBREv58iR63jz9D0ZvgEzyBwEZC4gvvm9VP4uaE1UTYvTtKJ7JWe7gfk3tMXEuteWmhSKoprKCtR0AhcFrclduIpiLsQ0Qe0RSzOjqJykxWWtb7zXLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760070122; c=relaxed/simple;
	bh=V8lVhg40i6i3dzj7FEuSEzfEDeikzBVx4RlBJVsKO+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tP1AuWvq/r7vfZDagGbfi6HRvM3Agp+1wgmk29Y47y/2ITIL5cuM64VIpcyN5+z51J1MGOhN2VMpYAcysC6LFRLtG1SSOyj+saTXNKCMJmi+3A5eS5VjTyJ7mmSBz349/VmM6ZkW5BWi7oT43hr2Mhf+pkEegJiL/Cn8KfbTeEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DyAy+Jo4; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760070120; x=1791606120;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V8lVhg40i6i3dzj7FEuSEzfEDeikzBVx4RlBJVsKO+g=;
  b=DyAy+Jo4mSgYOR5KmbPibrOkd2rPrfTgo324XWTlKgGM39bhTU1t9Xgf
   wDAGaFJzzQ8/0ew4Dl5T72D7Gk2vDneAJylkNYu4Tp6uiHm8PrQLP1e0l
   +c1O8zZSpAqoBaFC0nkSv7Z42XG9xcyyHBHaNKpslXaffL43/CtzaXz3m
   /5jtg+Aaysg8YJF7HDnG13dxbKDQtygcSE35yG42/9mlDxNePnp6K1YzC
   YXxLBlrIbFxzMHGg/3NbOwZQ+Wrf6DGJO0QLIwMf0jGBDj6H3O1cC58G0
   3rPrH5oyvJZR+C70ms06LqCEy6tWrJlW99sHqvGln30AAMvlKhEnAYez3
   w==;
X-CSE-ConnectionGUID: j3IirToxQp2zN138eR+cqg==
X-CSE-MsgGUID: 69Cj8YqdTzqg0jyxSxA7uQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="79931635"
X-IronPort-AV: E=Sophos;i="6.19,218,1754982000"; 
   d="scan'208";a="79931635"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 21:22:00 -0700
X-CSE-ConnectionGUID: 7bOHdkV+SSOVseicgkDGvw==
X-CSE-MsgGUID: Ilpw6yfLTLq+oUU9z57IIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,218,1754982000"; 
   d="scan'208";a="180572606"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 09 Oct 2025 21:21:56 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v74dd-00028h-2m;
	Fri, 10 Oct 2025 04:21:53 +0000
Date: Fri, 10 Oct 2025 12:21:07 +0800
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
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Chuan Liu <chuan.liu@amlogic.com>
Subject: Re: [PATCH 11/19] arm64: dts: amlogic: A4: Add peripherals clock
 controller node
Message-ID: <202510101124.3xwn3STp-lkp@intel.com>
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
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20251010/202510101124.3xwn3STp-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251010/202510101124.3xwn3STp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510101124.3xwn3STp-lkp@intel.com/

All errors (new ones prefixed by >>):

   Error: arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi:119.19-20 syntax error
>> FATAL ERROR: Unable to parse input tree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-kernel+bounces-882064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C24C29883
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 23:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30314188ADF1
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 22:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0141E248F4F;
	Sun,  2 Nov 2025 22:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SOuBc4uc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F017923E229
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 22:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762122334; cv=none; b=J/xHEVy8lDdGXi5RDHrkhmCiT1J7Gq9+eVQNaug7rTCv0GMo1gG8rFYjO8MR9didcPU6/awk+4NAvKTjqVZQ0e9t+b2nNHSBTpgmsdhFgM0S06Ts+NG6yU0NU3vtpXlfQjbv6k4tgEDTEQfbqw+fOMzP2tUfZhRDDVj2Qcx9id4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762122334; c=relaxed/simple;
	bh=xAaDVXcvzXMuT6b41jvj67zRq9dUreGowV9Fgs0NF0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hpw66GUYDN/kIUf6amek27OdF4Nte5cKoy7W7FYJi0UhdCmAIGxdZLvF0+Jr8nL0IcJxpZDa4m2XuGsQispuw9MNylZxFTJ4uoef9YbKznl3DleBbw/Iu66puyUFDlibl1L4BgPJeggS3a4oI67627+glDCSqnUR+R8g+JJix8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SOuBc4uc; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762122333; x=1793658333;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xAaDVXcvzXMuT6b41jvj67zRq9dUreGowV9Fgs0NF0Y=;
  b=SOuBc4ucsoUxnBmeBtlGPr1noFrKnpHheoSaYpWSI87wR2wrZYFmAgrL
   91ULfB5FPQx30QqvIx/6cCANa8+8Tp/T+Gw27iJrlS7BBSQqZD9AHHC0G
   Au0HbtHlMcQo+DJdRW2tlUEpetMLPlleWDHuwo5rxG5QVGajt39xdZ4Nm
   tB7foia1wUdD1dmF8QU3Ny9qiLL+oVZiIwetofWqNandpHxmxmjj0LcGm
   kbKI3YLUNmUjuKgo9ci6BqfhNvk1okgqVhwnCsMUJQrInNTDjz+PnEk3Y
   pxqnp+ksA3w6MryT6gUkbglePEPB5j4mbdMn7aewOsG6a72CSi37C3DP8
   w==;
X-CSE-ConnectionGUID: O2GdNp1DQkKthzfCO+eLeQ==
X-CSE-MsgGUID: mSyfEuIaTqKHlkRL/SjlwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64104031"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64104031"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2025 14:25:31 -0800
X-CSE-ConnectionGUID: vXJAcFdIRR2J+3k8618sjw==
X-CSE-MsgGUID: gfzfgI3ESyqPmcXpTmfFfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,274,1754982000"; 
   d="scan'208";a="186593785"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 02 Nov 2025 14:25:28 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vFgVq-000PcC-1p;
	Sun, 02 Nov 2025 22:25:26 +0000
Date: Mon, 3 Nov 2025 06:25:00 +0800
From: kernel test robot <lkp@intel.com>
To: Alex Elder <elder@riscstar.com>, vkoul@kernel.org, kishon@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, p.zabel@pengutronix.de, dlan@gentoo.org,
	aurelien@aurel32.net, guodong@riscstar.com,
	linux-phy@lists.infradead.org, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Junzhong Pan <panjunzhong@linux.spacemit.com>
Subject: Re: [PATCH v4 4/7] phy: spacemit: introduce PCIe/combo PHY
Message-ID: <202511030652.3CVPb2v3-lkp@intel.com>
References: <20251030220259.1063792-5-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030220259.1063792-5-elder@riscstar.com>

Hi Alex,

kernel test robot noticed the following build errors:

[auto build test ERROR on 131f3d9446a6075192cdd91f197989d98302faa6]

url:    https://github.com/intel-lab-lkp/linux/commits/Alex-Elder/dt-bindings-phy-spacemit-add-SpacemiT-PCIe-combo-PHY/20251031-060541
base:   131f3d9446a6075192cdd91f197989d98302faa6
patch link:    https://lore.kernel.org/r/20251030220259.1063792-5-elder%40riscstar.com
patch subject: [PATCH v4 4/7] phy: spacemit: introduce PCIe/combo PHY
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20251103/202511030652.3CVPb2v3-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251103/202511030652.3CVPb2v3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511030652.3CVPb2v3-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "devm_clk_hw_register" [drivers/phy/phy-spacemit-k1-pcie.ko] undefined!
>> ERROR: modpost: "devm_clk_hw_get_clk" [drivers/phy/phy-spacemit-k1-pcie.ko] undefined!
ERROR: modpost: "clk_save_context" [drivers/net/phy/air_en8811h.ko] undefined!
ERROR: modpost: "clk_restore_context" [drivers/net/phy/air_en8811h.ko] undefined!
ERROR: modpost: "__delay" [drivers/net/mdio/mdio-cavium.ko] undefined!
ERROR: modpost: "devm_of_clk_add_hw_provider" [drivers/media/i2c/tc358746.ko] undefined!
ERROR: modpost: "devm_clk_hw_register" [drivers/media/i2c/tc358746.ko] undefined!
ERROR: modpost: "of_clk_hw_simple_get" [drivers/media/i2c/tc358746.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-kernel+bounces-767759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 538D2B258C1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 03:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B368D2A2445
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 01:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B819E165F13;
	Thu, 14 Aug 2025 01:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aElfw9Pu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE762FF653;
	Thu, 14 Aug 2025 01:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755133559; cv=none; b=Wrk5OLuXWVIPME1lxe/nXzR2xCS52KizN8l3H2drJhZFSqI/O4mOFhKGQKjaDKvV2PMq/u3AxCcozjr0/e4IrVg8yLCpbusn2T3g92/sFmNp+Td67bpIeDbv/wYynDHg2hFHhJkgAEZz61WqKfkT3vaeK3q1oC1bZy43usSbWTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755133559; c=relaxed/simple;
	bh=GHq+UdFILVZZcTmyOuJYpLnjJl4RNHxMErvsBexshnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4zW1JZ/wojDSpzDnvmZ6P7RZSj3cCjI5NmsKXlzlNZ5Jvl1QguoEgWjufGfZfHp+FiB4k3Obza2StXyGi1tSjKWWUYOKyv8GVWsyZOCOIBhMNAlRgHh+3FPlkQwPeWC3mc7nVVyHWlVtFOFFhwWg7iXK2EVpIQHHJTpmYCco18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aElfw9Pu; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755133558; x=1786669558;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GHq+UdFILVZZcTmyOuJYpLnjJl4RNHxMErvsBexshnY=;
  b=aElfw9PugSRRSNtTahKi3+HvFQUMRuTnoJ9rTUczDl+o149MGaoxahHK
   I61UwOph4raZFaLrQNcvRr+ZE6SHTE6lZFladu8vFggtLBmVJ9/rnF3wF
   3aWap22ACwbQNGydUPVx11izsAO5SP9kVZOcZki9KcjLh15eBNzpp/Wug
   ATRMmO9RbjW6IB6BKZ1BH/4Kuns60d/Vf+IOxFjFrnBHC0/jVtRBWGkyN
   ZMb1WO5q5OBAZ7l1xivZnGO/UAcWL32CGyz84bbnF5vFX4OVeCY7ejcuR
   /qaQVcRswX9cr7m2UcMGont3wNNV+ZqAo+ZVSDdcoe0ZXmfq6yp7lDNCr
   w==;
X-CSE-ConnectionGUID: zU/+TjczSNevZRb4Ys/9cQ==
X-CSE-MsgGUID: 1v7uULTJQHGl3QVMHj/hKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="68522886"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="68522886"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 18:05:57 -0700
X-CSE-ConnectionGUID: GyU04fsaR2OYGBt93Y2/8w==
X-CSE-MsgGUID: ewk1E047T+a1xTM9ypDf9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="166997295"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 13 Aug 2025 18:05:53 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umMPc-000ATw-07;
	Thu, 14 Aug 2025 01:05:48 +0000
Date: Thu, 14 Aug 2025 09:05:35 +0800
From: kernel test robot <lkp@intel.com>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Alex Elder <elder@riscstar.com>, Haylen Chu <heylenay@4d2.org>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jinmei Wei <weijinmei@linux.spacemit.com>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH v2 4/4] clk: spacemit: fix i2s clock
Message-ID: <202508140828.p7rvt41N-lkp@intel.com>
References: <20250811-k1-clk-i2s-generation-v2-4-e4d3ec268b7a@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811-k1-clk-i2s-generation-v2-4-e4d3ec268b7a@linux.spacemit.com>

Hi Troy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 8f5ae30d69d7543eee0d70083daf4de8fe15d585]

url:    https://github.com/intel-lab-lkp/linux/commits/Troy-Mitchell/dt-bindings-clock-spacemit-introduce-i2s-pre-clock-to-fix-i2s-clock/20250811-221114
base:   8f5ae30d69d7543eee0d70083daf4de8fe15d585
patch link:    https://lore.kernel.org/r/20250811-k1-clk-i2s-generation-v2-4-e4d3ec268b7a%40linux.spacemit.com
patch subject: [PATCH v2 4/4] clk: spacemit: fix i2s clock
config: riscv-randconfig-r112-20250813 (https://download.01.org/0day-ci/archive/20250814/202508140828.p7rvt41N-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce: (https://download.01.org/0day-ci/archive/20250814/202508140828.p7rvt41N-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508140828.p7rvt41N-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/clk/spacemit/ccu-k1.c:160:1: sparse: sparse: Initializer entry defined twice
   drivers/clk/spacemit/ccu-k1.c:160:1: sparse:   also defined here
   drivers/clk/spacemit/ccu-k1.c:656:1: sparse: sparse: Initializer entry defined twice
   drivers/clk/spacemit/ccu-k1.c:656:1: sparse:   also defined here

vim +160 drivers/clk/spacemit/ccu-k1.c

   159	
 > 160	CCU_DIV_GATE_DEFINE(i2s_bclk, CCU_PARENT_HW(i2s_sysclk), MPMU_ISCCR, 27, 2, BIT(29), 2, 0);
   161	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


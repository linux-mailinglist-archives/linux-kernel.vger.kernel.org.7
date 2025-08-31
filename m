Return-Path: <linux-kernel+bounces-793200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6373FB3D047
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 02:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 399972057D3
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 00:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F0B4C6E;
	Sun, 31 Aug 2025 00:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gNMObcSI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06B628EB
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 00:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756598601; cv=none; b=KkZBgLg2K7A30mQZGw2TxaUxRrgD83uNfbgGsNIq3rBrkkaVhYO7zic0fikf8fsVBUGZyTDo53Ou2AeVvPLtO1aDDytsDI02DK5k+S8UlIiAO+wJm5CbfmjXNtxhpL32YF7iuwvlFCpCC6FIhCdRNk83U31hRuP5mBez20zKFos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756598601; c=relaxed/simple;
	bh=2BrtOcf57CNuvwDSSNXh0IHPVsyE5b1IIP0ktB5bFGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4j6s4XhL1k8BnHXQJjJ3cZP1xP9Caf9hKAVmoUDQXF27YU5nYIcTJIemILvEwuhKyQVF9DPsUFNvIZ8Z8Dbd9qSaRwZbozH89NoJgeq3PJfJnqtpwZUf4O6LAUd0a9p9leuFACVYSvyPu6mizmspkKEBDZObA8u35b0GDfm/p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gNMObcSI; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756598600; x=1788134600;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2BrtOcf57CNuvwDSSNXh0IHPVsyE5b1IIP0ktB5bFGY=;
  b=gNMObcSIfygMflqgUhVXNKK4w6M+TvV03R3TshPlKbDNqGXyzbu1Jw/i
   SpfSi6NYKcFPp7x4hS2nMbLND7xgpjH+wk7l2PbmIZSipt1M+TGE4xzvU
   eKyhiWf7N1Hvl40BVf1g5UwHdXmPTRKxekaUdpOAJ1KgfJ5Sj3LugGboq
   5bDSbGF48MHt+HKP6pMyW8BLd7VReNbCpLjOOxkGjAk87BM+HyQdci7Dm
   P/QCCW+X4nLd/LpOt6abihWeKoRAOB+edIIpaDmIeH81WaC1iJ92iiuaU
   8GgIvd2qoIsnNjBPTtoAuu4InMeJPPdXAvFbb5E1HKt7GXRLNPT5w88xP
   A==;
X-CSE-ConnectionGUID: xNOxI2fRQoecefO2uwFGnA==
X-CSE-MsgGUID: FZYyMVRLQneBzn/j7JZKlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11537"; a="62483083"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="62483083"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2025 17:03:19 -0700
X-CSE-ConnectionGUID: G1aVsjfxSaeV3Hw0YOtS8A==
X-CSE-MsgGUID: XEJPcX4ORb+wvMIcIDjafQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="170577587"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 30 Aug 2025 17:03:17 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1usVXP-000VmJ-00;
	Sun, 31 Aug 2025 00:03:15 +0000
Date: Sun, 31 Aug 2025 08:02:34 +0800
From: kernel test robot <lkp@intel.com>
To: Dzmitry Sankouski <dsankouski@gmail.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Dzmitry Sankouski <dsankouski@gmail.com>
Subject: Re: [PATCH] mfd: max77705: rework interrupts
Message-ID: <202508310735.f7Evkqz7-lkp@intel.com>
References: <20250831-max77705-fix_interrupt_handling-v1-1-73e078012e51@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250831-max77705-fix_interrupt_handling-v1-1-73e078012e51@gmail.com>

Hi Dzmitry,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 3cace99d63192a7250461b058279a42d91075d0c]

url:    https://github.com/intel-lab-lkp/linux/commits/Dzmitry-Sankouski/mfd-max77705-rework-interrupts/20250831-061657
base:   3cace99d63192a7250461b058279a42d91075d0c
patch link:    https://lore.kernel.org/r/20250831-max77705-fix_interrupt_handling-v1-1-73e078012e51%40gmail.com
patch subject: [PATCH] mfd: max77705: rework interrupts
config: hexagon-randconfig-002-20250831 (https://download.01.org/0day-ci/archive/20250831/202508310735.f7Evkqz7-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250831/202508310735.f7Evkqz7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508310735.f7Evkqz7-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mfd/max77705.c:89:37: warning: unused variable 'max77705_topsys_irq_chip' [-Wunused-const-variable]
      89 | static const struct regmap_irq_chip max77705_topsys_irq_chip = {
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +/max77705_topsys_irq_chip +89 drivers/mfd/max77705.c

c8d50f029748b7 Dzmitry Sankouski 2025-01-23  88  
c8d50f029748b7 Dzmitry Sankouski 2025-01-23 @89  static const struct regmap_irq_chip max77705_topsys_irq_chip = {
c8d50f029748b7 Dzmitry Sankouski 2025-01-23  90  	.name		= "max77705-topsys",
c8d50f029748b7 Dzmitry Sankouski 2025-01-23  91  	.status_base	= MAX77705_PMIC_REG_SYSTEM_INT,
c8d50f029748b7 Dzmitry Sankouski 2025-01-23  92  	.mask_base	= MAX77705_PMIC_REG_SYSTEM_INT_MASK,
c8d50f029748b7 Dzmitry Sankouski 2025-01-23  93  	.num_regs	= 1,
c8d50f029748b7 Dzmitry Sankouski 2025-01-23  94  	.irqs		= max77705_topsys_irqs,
c8d50f029748b7 Dzmitry Sankouski 2025-01-23  95  	.num_irqs	= ARRAY_SIZE(max77705_topsys_irqs),
c8d50f029748b7 Dzmitry Sankouski 2025-01-23  96  };
c8d50f029748b7 Dzmitry Sankouski 2025-01-23  97  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


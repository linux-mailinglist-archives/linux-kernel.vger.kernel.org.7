Return-Path: <linux-kernel+bounces-848931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0991ABCED87
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 03:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B279734F6D5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 01:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E4661FFE;
	Sat, 11 Oct 2025 01:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QMXWZgIW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B94525776;
	Sat, 11 Oct 2025 01:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760144516; cv=none; b=RTEKmhSTGhH5bxcqXlvJv9VPo27QH/GP8bfYeWL+lP81EM0PHhcMraxkr1vf9t1QDTW6/dWWTUwV4EmUn9mUj0l3lnYUxfoN3ZXHo+6nCTEAhBz8iMySOWsIBl/DzLH0GPkyudtC/vrlWjZWpIL3jZZCbtVutIudPKS4dPKkrMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760144516; c=relaxed/simple;
	bh=p7fX/+rgWeulRXhHhTpwOa6jJqqMEZgpg+PPc1ne51Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVwEm3eebmiaZJHvneTHor+YPSW9h07FuvravCt1v6S5er5vyEWKtv1SE4pRNg7yqwIWCzstB1hl3NrACFBBkolWVO8UiyQIfDeFVFBqazSzx3X1xMttAG7ceuoS1pjj0aZsYeSiI+I2qQBDCAFjSjWTcYu81nJPD8TxvPapyT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QMXWZgIW; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760144515; x=1791680515;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p7fX/+rgWeulRXhHhTpwOa6jJqqMEZgpg+PPc1ne51Y=;
  b=QMXWZgIWWcIQD2kX0dHpw3MC7/Ln6pM8/qI39FHOt7VCcq8XrCYXg0fm
   siVPHNWljb1haXq90BdhMCk8SvqfxdeAIPe3Xw6AmzmFqcbjhuSauyCOc
   gP+iUhMe20UoBc5EFsVge8K4aSht7VcFS9bULG2eKxS8ZuiMNvdgjaxOr
   CNS8bxLiswvbvAy2t8ABpo+NbYk2G81FbQuvKW0km+cYGx6Y36S21T3BC
   /qaFcmx5FEL8/xo3G8fbxLGcwAWmTzh/SZ1yT1QgAGArLPNh4QBZDF8L0
   IMx3Rpr0KZ++gAi+/x0wDhUElloTlme3oYAEX9e1DuL6aa55tjY/Ko4zI
   w==;
X-CSE-ConnectionGUID: gn2Q/L2xQoqP9gyLvmnY4w==
X-CSE-MsgGUID: FWda91xZRbSVkzYz70VcUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="66195391"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="66195391"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 18:01:54 -0700
X-CSE-ConnectionGUID: YYXD5VaDQ4OSv0yvz6dJvg==
X-CSE-MsgGUID: HyLT0645TUShK87mEYH45g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="186222886"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 10 Oct 2025 18:01:49 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v7NzW-0003M3-13;
	Sat, 11 Oct 2025 01:01:46 +0000
Date: Sat, 11 Oct 2025 09:00:59 +0800
From: kernel test robot <lkp@intel.com>
To: Richard Genoud <richard.genoud@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Wentao Liang <vulab@iscas.ac.cn>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Genoud <richard.genoud@bootlin.com>
Subject: Re: [PATCH 15/15] mtd: rawnand: sunxi: Add support for H616 nand
 controller
Message-ID: <202510110828.Xb6hqQvx-lkp@intel.com>
References: <20251010084042.341224-16-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010084042.341224-16-richard.genoud@bootlin.com>

Hi Richard,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mtd/nand/next]
[also build test WARNING on mtd/mtd/next mtd/mtd/fixes sunxi/sunxi/for-next robh/for-next linus/master v6.17 next-20251010]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Richard-Genoud/mtd-rawnand-sunxi-Remove-superfluous-register-readings/20251010-164637
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next
patch link:    https://lore.kernel.org/r/20251010084042.341224-16-richard.genoud%40bootlin.com
patch subject: [PATCH 15/15] mtd: rawnand: sunxi: Add support for H616 nand controller
config: riscv-randconfig-002-20251011 (https://download.01.org/0day-ci/archive/20251011/202510110828.Xb6hqQvx-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 39f292ffa13d7ca0d1edff27ac8fd55024bb4d19)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251011/202510110828.Xb6hqQvx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510110828.Xb6hqQvx-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/mtd/nand/raw/sunxi_nand.c:351 struct member 'mbus_clk' not described in 'sunxi_nfc'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


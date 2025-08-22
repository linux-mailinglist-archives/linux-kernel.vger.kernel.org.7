Return-Path: <linux-kernel+bounces-781915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C51B318B0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CF4F3AEFC7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0106A30498E;
	Fri, 22 Aug 2025 12:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cON6UGpj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3793043B2
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755867320; cv=none; b=CpckeU5EqHgt2DIpGSmBmMWjlvYOnpCuFaVSVFHUlaSwJGkSd7tkr7wfIHx2g9MYToQTlwMYrjBdJC4wEJjPf3k2G1D340VTSB3vvDUZM43q03hYDH98mc8Kq2JTLW43Vr5oCaBam2hJqCoTVCwZqMjp8HYMNUL8vJtjO9kbOF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755867320; c=relaxed/simple;
	bh=D0Y8ClmFtbC92N5dy5LowiIeylAzezGQNFrxr/qJCB8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=P/qHQ6F4fdRtR4cLfP8LlaPDjV2eAzNdACJxnK2uYBX7hZmAiTvlQngKji+O5wuq3Z0Cr6HeU4C0Sts4d/ENSYO9P6UYQ1dl5zF07IIdjJfOJ3T6dLjZ2H/PwAiQ59WANrvp2ZwVCkwVES0Fze01qRO+HUR48KyOHG3NfKhwQt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cON6UGpj; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755867318; x=1787403318;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=D0Y8ClmFtbC92N5dy5LowiIeylAzezGQNFrxr/qJCB8=;
  b=cON6UGpjykTarrvt+zLu5cgvWJ1ULxa4Fasoaq7SAE4KA2m7qHBlVH5J
   +sOhkJkxV3iuzim6v/45g4oC/sMmrZF+HC1Mke3fa6xb9ustExz3FqMJW
   U0k9XRUtObZ/ewIi8mYdVGlu5ANO5XjH32Mkv8/c15lJ9cfZfIGbaaGv5
   ybdYgqqQHyoMWjKE2/OD2sOFY6xBIpqS9BNoTy4IuZhVaijPE8lBojg6S
   UdKEcaeIte5k6Ly+5+J31bwQlsnX/MoKy1WuWM7m1JEGAI+JyOmuk2BIZ
   AvZ2wH+MmStcTb/mDewtRNQ07uZAG9N+YVtPTPcV4A71Xq0/3GlTpyLkN
   w==;
X-CSE-ConnectionGUID: nJs4l++5Rp2vprvd88udKQ==
X-CSE-MsgGUID: uJvHMM5lRQalNQ87Qu9GjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="45744621"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="45744621"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 05:55:18 -0700
X-CSE-ConnectionGUID: 21kgHvcnQ6mrBHpJYuFfbA==
X-CSE-MsgGUID: lqx03yzaQ72kc64pnTB5Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168208087"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 22 Aug 2025 05:55:16 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upRIY-000LI5-1B;
	Fri, 22 Aug 2025 12:55:14 +0000
Date: Fri, 22 Aug 2025 20:51:05 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Marc Zyngier <maz@kernel.org>
Subject: drivers/irqchip/irq-gic-v5-irs.c:571 gicv5_irs_init_bases() warn:
 inconsistent indenting
Message-ID: <202508222051.ebaxHZ4Z-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3957a5720157264dcc41415fbec7c51c4000fc2d
commit: 53bb952a625fd3247647c7a28366ce990a579415 arm64: Kconfig: Enable GICv5
date:   6 weeks ago
config: arm64-randconfig-r071-20250822 (https://download.01.org/0day-ci/archive/20250822/202508222051.ebaxHZ4Z-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508222051.ebaxHZ4Z-lkp@intel.com/

smatch warnings:
drivers/irqchip/irq-gic-v5-irs.c:571 gicv5_irs_init_bases() warn: inconsistent indenting
drivers/irqchip/irq-gic-v5-its.c:267 gicv5_its_create_itt_two_level() warn: always true condition '(i >= 0) => (0-u32max >= 0)'
drivers/irqchip/irq-gic-v5-its.c:267 gicv5_its_create_itt_two_level() warn: always true condition '(i >= 0) => (0-u32max >= 0)'

vim +571 drivers/irqchip/irq-gic-v5-irs.c

5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  542  
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  543  static void __init gicv5_irs_init_bases(struct gicv5_irs_chip_data *irs_data,
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  544  					void __iomem *irs_base,
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  545  					struct fwnode_handle *handle)
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  546  {
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  547  	struct device_node *np = to_of_node(handle);
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  548  	u32 cr0, cr1;
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  549  
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  550  	irs_data->fwnode = handle;
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  551  	irs_data->irs_base = irs_base;
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  552  
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  553  	if (of_property_read_bool(np, "dma-noncoherent")) {
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  554  		/*
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  555  		 * A non-coherent IRS implies that some cache levels cannot be
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  556  		 * used coherently by the cores and GIC. Our only option is to mark
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  557  		 * memory attributes for the GIC as non-cacheable; by default,
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  558  		 * non-cacheable memory attributes imply outer-shareable
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  559  		 * shareability, the value written into IRS_CR1_SH is ignored.
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  560  		 */
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  561  		cr1 = FIELD_PREP(GICV5_IRS_CR1_VPED_WA, GICV5_NO_WRITE_ALLOC)	|
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  562  			FIELD_PREP(GICV5_IRS_CR1_VPED_RA, GICV5_NO_READ_ALLOC)	|
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  563  			FIELD_PREP(GICV5_IRS_CR1_VMD_WA, GICV5_NO_WRITE_ALLOC)	|
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  564  			FIELD_PREP(GICV5_IRS_CR1_VMD_RA, GICV5_NO_READ_ALLOC)	|
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  565  			FIELD_PREP(GICV5_IRS_CR1_VPET_RA, GICV5_NO_READ_ALLOC)	|
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  566  			FIELD_PREP(GICV5_IRS_CR1_VMT_RA, GICV5_NO_READ_ALLOC)	|
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  567  			FIELD_PREP(GICV5_IRS_CR1_IST_WA, GICV5_NO_WRITE_ALLOC)	|
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  568  			FIELD_PREP(GICV5_IRS_CR1_IST_RA, GICV5_NO_READ_ALLOC)	|
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  569  			FIELD_PREP(GICV5_IRS_CR1_IC, GICV5_NON_CACHE)		|
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  570  			FIELD_PREP(GICV5_IRS_CR1_OC, GICV5_NON_CACHE);
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03 @571  			irs_data->flags |= IRS_FLAGS_NON_COHERENT;
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  572  	} else {
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  573  		cr1 = FIELD_PREP(GICV5_IRS_CR1_VPED_WA, GICV5_WRITE_ALLOC)	|
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  574  			FIELD_PREP(GICV5_IRS_CR1_VPED_RA, GICV5_READ_ALLOC)	|
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  575  			FIELD_PREP(GICV5_IRS_CR1_VMD_WA, GICV5_WRITE_ALLOC)	|
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  576  			FIELD_PREP(GICV5_IRS_CR1_VMD_RA, GICV5_READ_ALLOC)	|
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  577  			FIELD_PREP(GICV5_IRS_CR1_VPET_RA, GICV5_READ_ALLOC)	|
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  578  			FIELD_PREP(GICV5_IRS_CR1_VMT_RA, GICV5_READ_ALLOC)	|
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  579  			FIELD_PREP(GICV5_IRS_CR1_IST_WA, GICV5_WRITE_ALLOC)	|
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  580  			FIELD_PREP(GICV5_IRS_CR1_IST_RA, GICV5_READ_ALLOC)	|
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  581  			FIELD_PREP(GICV5_IRS_CR1_IC, GICV5_WB_CACHE)		|
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  582  			FIELD_PREP(GICV5_IRS_CR1_OC, GICV5_WB_CACHE)		|
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  583  			FIELD_PREP(GICV5_IRS_CR1_SH, GICV5_INNER_SHARE);
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  584  	}
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  585  
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  586  	irs_writel_relaxed(irs_data, cr1, GICV5_IRS_CR1);
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  587  
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  588  	cr0 = FIELD_PREP(GICV5_IRS_CR0_IRSEN, 0x1);
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  589  	irs_writel_relaxed(irs_data, cr0, GICV5_IRS_CR0);
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  590  	gicv5_irs_wait_for_idle(irs_data);
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  591  }
5cb1b6dab2def3 Lorenzo Pieralisi 2025-07-03  592  

:::::: The code at line 571 was first introduced by commit
:::::: 5cb1b6dab2def316671ea2565291a86ad58b884c irqchip/gic-v5: Add GICv5 IRS/SPI support

:::::: TO: Lorenzo Pieralisi <lpieralisi@kernel.org>
:::::: CC: Marc Zyngier <maz@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


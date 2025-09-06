Return-Path: <linux-kernel+bounces-804379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D710B47562
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 19:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4CCD7C68C0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 17:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307EA25B1C5;
	Sat,  6 Sep 2025 17:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c64HC7VF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D9424A049;
	Sat,  6 Sep 2025 17:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757178792; cv=none; b=d19t6E5xwVL8PC8aKNZB7E2dX2wGZstM4is8jeaSckWIS8cjhg9ZRbwfPpJPNgU3gYcsYbof59n1v2Ai8u9CJctnP22b/rbEq7Buy7Zuwj4BrJVMOOnlE172qiE2QfRF3T5cSdcTmA/+rrobkoXg6ILQBcfq4jiMOhLGS1td7E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757178792; c=relaxed/simple;
	bh=Mv/Y3kvQFgparfIlQNQwNiMV1wrcDKs1S8/YH+Ac6po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2Art1nl4/XSDrilwf09ZXA30S81ci4oQqnini/JIuCdEt0gwDGcqL+EqiAbAIXf1AHs3C6FnQqL61FrU8+grOqGFfcMD7oTQkK5symEDwcgbnBk9YgmJehsBAcYxn8K9l1whbF4sVqAUzqSh7BwSqGDdNYDPBvJFHs03NdVj+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c64HC7VF; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757178792; x=1788714792;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Mv/Y3kvQFgparfIlQNQwNiMV1wrcDKs1S8/YH+Ac6po=;
  b=c64HC7VFkbMs19xmWFl3DQrWYw4FDvHGdDXKeciRltL2Q8KyxV0x7feb
   ghGzA3git1lE1WH9lGsDuYJ6LjfdXeM39KoHoz0W4xK3kLLgSKLhQgmMf
   rlgjgjDGBTwuujYwpNYr5cUOdHScbT6vdK8z6VI1U21+OoSCir1SeIQis
   GaUsDoAqovVWthNHNgCLFQHuXy5EZwb+eoG0HU+frYbqtu91M5bl2fpdk
   787YCJ6SYetncylGPjy6ZaGJDDKbsbKpcihEkU7PCfxiSCIDywLX8rLKJ
   fIaEgXyyJxe+FI3SOEgRLgoi3hfxQ0acjM0nDaP5dLDPzjApIKxTXv0Ua
   g==;
X-CSE-ConnectionGUID: rX6/3BmfTGSPRTr+6gZwcg==
X-CSE-MsgGUID: hCKiweDoQ6K7Qet/KI07Mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11545"; a="70926740"
X-IronPort-AV: E=Sophos;i="6.18,244,1751266800"; 
   d="scan'208";a="70926740"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 10:13:11 -0700
X-CSE-ConnectionGUID: 3WS+ZCjMTFaHD/3JOA6TTw==
X-CSE-MsgGUID: 0iif958RTK6QdgJj0vJWIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,244,1751266800"; 
   d="scan'208";a="172298134"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 06 Sep 2025 10:13:07 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uuwTI-0001g7-1o;
	Sat, 06 Sep 2025 17:13:04 +0000
Date: Sun, 7 Sep 2025 01:12:31 +0800
From: kernel test robot <lkp@intel.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>,
	Eddie James <eajames@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Lee Jones <lee@kernel.org>, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3 1/4] irqchip/aspeed-scu-ic: Refactor driver to support
 variant-based initialization
Message-ID: <202509070058.3Z4AtICl-lkp@intel.com>
References: <20250906014846.861368-2-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906014846.861368-2-ryan_chen@aspeedtech.com>

Hi Ryan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/irq/core]
[also build test WARNING on robh/for-next lee-mfd/for-mfd-next lee-mfd/for-mfd-fixes linus/master v6.17-rc4 next-20250905]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Chen/irqchip-aspeed-scu-ic-Refactor-driver-to-support-variant-based-initialization/20250906-095043
base:   tip/irq/core
patch link:    https://lore.kernel.org/r/20250906014846.861368-2-ryan_chen%40aspeedtech.com
patch subject: [PATCH v3 1/4] irqchip/aspeed-scu-ic: Refactor driver to support variant-based initialization
config: arm-randconfig-001-20250906 (https://download.01.org/0day-ci/archive/20250907/202509070058.3Z4AtICl-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 7fb1dc08d2f025aad5777bb779dfac1197e9ef87)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250907/202509070058.3Z4AtICl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509070058.3Z4AtICl-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/irqchip/irq-aspeed-scu-ic.c:79:34: warning: variable 'mask' is uninitialized when used here [-Wuninitialized]
      79 |                 writel((readl(scu_ic->base) & ~mask) |
         |                                                ^~~~
   drivers/irqchip/irq-aspeed-scu-ic.c:55:24: note: initialize the variable 'mask' to silence this warning
      55 |         unsigned int sts, mask;
         |                               ^
         |                                = 0
   1 warning generated.


vim +/mask +79 drivers/irqchip/irq-aspeed-scu-ic.c

    49	
    50	static void aspeed_scu_ic_irq_handler(struct irq_desc *desc)
    51	{
    52		struct aspeed_scu_ic *scu_ic = irq_desc_get_handler_data(desc);
    53		struct irq_chip *chip = irq_desc_get_chip(desc);
    54		unsigned long bit, enabled, max, status;
    55		unsigned int sts, mask;
    56	
    57		chained_irq_enter(chip, desc);
    58	
    59		/*
    60		 * The SCU IC has just one register to control its operation and read
    61		 * status. The interrupt enable bits occupy the lower 16 bits of the
    62		 * register, while the interrupt status bits occupy the upper 16 bits.
    63		 * The status bit for a given interrupt is always 16 bits shifted from
    64		 * the enable bit for the same interrupt.
    65		 * Therefore, perform the IRQ operations in the enable bit space by
    66		 * shifting the status down to get the mapping and then back up to
    67		 * clear the bit.
    68		 */
    69		sts = readl(scu_ic->base);
    70		enabled = sts & scu_ic->irq_enable;
    71		status = (sts >> ASPEED_SCU_IC_STATUS_SHIFT) & enabled;
    72	
    73		bit = scu_ic->irq_shift;
    74		max = scu_ic->num_irqs + bit;
    75	
    76		for_each_set_bit_from(bit, &status, max) {
    77			generic_handle_domain_irq(scu_ic->irq_domain,
    78						  bit - scu_ic->irq_shift);
  > 79			writel((readl(scu_ic->base) & ~mask) |
    80			       BIT(bit + ASPEED_SCU_IC_STATUS_SHIFT),
    81			       scu_ic->base);
    82		}
    83	
    84		chained_irq_exit(chip, desc);
    85	}
    86	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


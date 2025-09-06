Return-Path: <linux-kernel+bounces-804463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F831B47771
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 23:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606D67C390F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 21:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7593D29E0F6;
	Sat,  6 Sep 2025 21:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FHHLlguO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321B4279DB2;
	Sat,  6 Sep 2025 21:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757193993; cv=none; b=B3Jogy5Gz4SK68zu9WLd8fZu08gx1FSsvokBGr3b5lDo94ZO4yARd0ZmFzFq3jqh7xv2MM6b8Y5rWVslOLQod8ejn4FvXcHqYFBBBJOMjeXz5ZJeOMgdnW65E1woPFMeesQJDtEbR7Bd1HLTjpB2CVl0NdR994XaXESEnFolEQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757193993; c=relaxed/simple;
	bh=CMGs8i3Y8nSpfA6lMpvHldw8w4ip7mYjXqWISfeH/PM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IW7e5oQDwGxFMmULPtpXxjY9lnBShrYEe+b/c8jbIAHO40ZolXbrGHQX0DCgcOS9yKrRQIfShVw3vAdnkW6NmX04IEdqnt3kIx+DlYsQY+EZnxJYY2u1mZi814d43Pn0SNZu0t/d7CeBrtBp5H665ieHlcnzfd11F9zfmtOK5bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FHHLlguO; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757193992; x=1788729992;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CMGs8i3Y8nSpfA6lMpvHldw8w4ip7mYjXqWISfeH/PM=;
  b=FHHLlguOvTUFaFEFxHHGj6zrRc9v7uDyNSvZRDDv3sPWNE3ua4cocI/2
   VaNoPqSMw1xdVmP3d6Zs2t9Zj0UBIcx+EWeaxKkAFHDlsGgn7xXYhg5zY
   EwMoE4lwixPVx5w33GojPVp+jSoZMMnzHK0uhCapv3Ul8bzNSF7ZeTUWz
   htLfv8oy2m/6oEcdPHY4TMEpjGO4+3DOG3kViZsJCzQPFQXl5ZdjcGGUr
   4OpcukyZgxjXGn0gHVq1PybbtM8DeofCn7eQPBO8lJUZyYnUpMtm3BZNG
   MiizuJ8f2cISeP9RGqnTKVdNnIRvkMSB6BzdTqqD6ykAEX2qThy5tHRRP
   A==;
X-CSE-ConnectionGUID: zrORHN8sTo2EPmldWSOGtQ==
X-CSE-MsgGUID: 7zj8z33HRT+2H3ddFzIkmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11545"; a="58715851"
X-IronPort-AV: E=Sophos;i="6.18,245,1751266800"; 
   d="scan'208";a="58715851"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 14:26:31 -0700
X-CSE-ConnectionGUID: VbX9FkwRSrCKGheZZSUk1w==
X-CSE-MsgGUID: XHIZwNXBQuyDKp8oVdJh6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,245,1751266800"; 
   d="scan'208";a="172009225"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 06 Sep 2025 14:26:27 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uv0QT-0001np-1W;
	Sat, 06 Sep 2025 21:26:25 +0000
Date: Sun, 7 Sep 2025 05:26:13 +0800
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
Subject: Re: [PATCH v3 4/4] irqchip/aspeed-scu-ic: Add support AST2700 SCU
 interrupt controllers
Message-ID: <202509070538.5HcCJf2T-lkp@intel.com>
References: <20250906014846.861368-5-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906014846.861368-5-ryan_chen@aspeedtech.com>

Hi Ryan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/irq/core]
[also build test WARNING on robh/for-next lee-mfd/for-mfd-next lee-mfd/for-mfd-fixes linus/master v6.17-rc4 next-20250905]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Chen/irqchip-aspeed-scu-ic-Refactor-driver-to-support-variant-based-initialization/20250906-095043
base:   tip/irq/core
patch link:    https://lore.kernel.org/r/20250906014846.861368-5-ryan_chen%40aspeedtech.com
patch subject: [PATCH v3 4/4] irqchip/aspeed-scu-ic: Add support AST2700 SCU interrupt controllers
config: arm-randconfig-001-20250906 (https://download.01.org/0day-ci/archive/20250907/202509070538.5HcCJf2T-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 7fb1dc08d2f025aad5777bb779dfac1197e9ef87)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250907/202509070538.5HcCJf2T-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509070538.5HcCJf2T-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/irqchip/irq-aspeed-scu-ic.c:93:34: warning: variable 'mask' is uninitialized when used here [-Wuninitialized]
      93 |                 writel((readl(scu_ic->base) & ~mask) |
         |                                                ^~~~
   drivers/irqchip/irq-aspeed-scu-ic.c:69:24: note: initialize the variable 'mask' to silence this warning
      69 |         unsigned int sts, mask;
         |                               ^
         |                                = 0
>> drivers/irqchip/irq-aspeed-scu-ic.c:106:20: warning: variable 'mask' set but not used [-Wunused-but-set-variable]
     106 |         unsigned int sts, mask;
         |                           ^
   2 warnings generated.


vim +/mask +106 drivers/irqchip/irq-aspeed-scu-ic.c

   100	
   101	static void aspeed_scu_ic_irq_handler_split(struct irq_desc *desc)
   102	{
   103		struct aspeed_scu_ic *scu_ic = irq_desc_get_handler_data(desc);
   104		struct irq_chip *chip = irq_desc_get_chip(desc);
   105		unsigned long bit, enabled, max, status;
 > 106		unsigned int sts, mask;
   107	
   108		chained_irq_enter(chip, desc);
   109	
   110		mask = scu_ic->irq_enable;
   111		sts = readl(scu_ic->base + scu_ic->isr);
   112		enabled = sts & scu_ic->irq_enable;
   113		sts = readl(scu_ic->base + scu_ic->isr);
   114		status = sts & enabled;
   115	
   116		bit = scu_ic->irq_shift;
   117		max = scu_ic->num_irqs + bit;
   118	
   119		for_each_set_bit_from(bit, &status, max) {
   120			generic_handle_domain_irq(scu_ic->irq_domain, bit - scu_ic->irq_shift);
   121			writel(BIT(bit), scu_ic->base + scu_ic->isr); // clear interrupt
   122		}
   123	
   124		chained_irq_exit(chip, desc);
   125	}
   126	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


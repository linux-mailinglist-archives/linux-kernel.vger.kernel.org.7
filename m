Return-Path: <linux-kernel+bounces-726264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 048CAB00A56
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 19:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1A6B1C432A4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFA32EE993;
	Thu, 10 Jul 2025 17:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HBPJalUO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6141199BC
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 17:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752169664; cv=none; b=IVv5xwy7YHXSIoASsxv39eJD7W4BBRbHVn66vZk2b55YQwQzgJtj2JZrQMnB0/OGISji+vefVVFDs3I79T8GpOK0075gH0ABtPN2tD+ieWeBKEsj3FpCa3I4pIDJCmPVEV/x9PP79t8VKocxGVyFjDj3yJPoZq4tLqP4yiL1heg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752169664; c=relaxed/simple;
	bh=fYsLiKestMpek0qN0cEg0MwyFp4HDvg6ZGLxP22SxYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FL8cmhBDMJq70Nayc1ChN2aT3KdsmUdZOofRA+hckbuRcICLvFFy+dZ6tzi2s7my8koiL9gwzNKpC8Uo+XIzQgZ42T/HS6JxEa/iXBD7t7N1WsXjdQMqDjLc7X/cxgPlAKcYMkJjXpASrwMuedP7QN82kjVmOFjliQJpziN6580=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HBPJalUO; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752169663; x=1783705663;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fYsLiKestMpek0qN0cEg0MwyFp4HDvg6ZGLxP22SxYs=;
  b=HBPJalUOoCoZUfp7A76eHhXevYEJXgXGsNj84VySUvE0R4Piu2eDHkOu
   bAtZBJXgtomBkcED9dZ/PKAscM0fxt7BZnhbRmc9eJmtGLT74QhjaCJ9e
   HuuQjBOz4XFsyBjxtV8FoCKcZlpLxW4+tO+gzGRmnsI7pm+0d44HHfdPS
   Dunhh6pnryPc3ye4wkoZ0OG3tUPajvjzlXaDT3SSIm6/9rKsImKV0rocH
   EmiOWW01jw5kF79I+pC+3NMrenR+efeY58cRvG+nWrXvpPpx23thoC1TN
   JxKz+Tzl5CXEZtxOo8Hx+ycANBb75sFvubfGlniauz1O3cRRzLVq75VWs
   A==;
X-CSE-ConnectionGUID: qtDkOpwpTOWMjg4rZcY2lw==
X-CSE-MsgGUID: oIYuXZ3tQlCxWGsQp3rjRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="58226647"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="58226647"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 10:47:42 -0700
X-CSE-ConnectionGUID: vAa6fRD7S8aIzxZuFlntBA==
X-CSE-MsgGUID: qOPVOyJASByw8/vBIia/Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="193369281"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 10 Jul 2025 10:47:40 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uZvMu-0005It-1P;
	Thu, 10 Jul 2025 17:47:36 +0000
Date: Fri, 11 Jul 2025 01:47:17 +0800
From: kernel test robot <lkp@intel.com>
To: Nick Hu <nick.hu@sifive.com>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Nick Hu <nick.hu@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH 2/2] irqchip/riscv-aplic: Save and restore APLIC registers
Message-ID: <202507110131.OzZXquiC-lkp@intel.com>
References: <20250709025516.28051-3-nick.hu@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709025516.28051-3-nick.hu@sifive.com>

Hi Nick,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/irq/core]
[also build test ERROR on linus/master v6.16-rc5 next-20250710]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nick-Hu/irqchip-riscv-aplic-Save-and-restore-APLIC-registers/20250709-115608
base:   tip/irq/core
patch link:    https://lore.kernel.org/r/20250709025516.28051-3-nick.hu%40sifive.com
patch subject: [PATCH 2/2] irqchip/riscv-aplic: Save and restore APLIC registers
config: riscv-randconfig-r132-20250710 (https://download.01.org/0day-ci/archive/20250711/202507110131.OzZXquiC-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 01c97b4953e87ae455bd4c41e3de3f0f0f29c61c)
reproduce: (https://download.01.org/0day-ci/archive/20250711/202507110131.OzZXquiC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507110131.OzZXquiC-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/irqchip/irq-riscv-aplic-main.c:13:
   In file included from include/linux/of_irq.h:7:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:804:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     804 |         insb(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:104:53: note: expanded from macro 'insb'
     104 | #define insb(addr, buffer, count) __insb(PCI_IOBASE + (addr), buffer, count)
         |                                          ~~~~~~~~~~ ^
   In file included from drivers/irqchip/irq-riscv-aplic-main.c:13:
   In file included from include/linux/of_irq.h:7:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:812:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     812 |         insw(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:105:53: note: expanded from macro 'insw'
     105 | #define insw(addr, buffer, count) __insw(PCI_IOBASE + (addr), buffer, count)
         |                                          ~~~~~~~~~~ ^
   In file included from drivers/irqchip/irq-riscv-aplic-main.c:13:
   In file included from include/linux/of_irq.h:7:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:820:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     820 |         insl(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:106:53: note: expanded from macro 'insl'
     106 | #define insl(addr, buffer, count) __insl(PCI_IOBASE + (addr), buffer, count)
         |                                          ~~~~~~~~~~ ^
   In file included from drivers/irqchip/irq-riscv-aplic-main.c:13:
   In file included from include/linux/of_irq.h:7:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:829:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     829 |         outsb(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:118:55: note: expanded from macro 'outsb'
     118 | #define outsb(addr, buffer, count) __outsb(PCI_IOBASE + (addr), buffer, count)
         |                                            ~~~~~~~~~~ ^
   In file included from drivers/irqchip/irq-riscv-aplic-main.c:13:
   In file included from include/linux/of_irq.h:7:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:838:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     838 |         outsw(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:119:55: note: expanded from macro 'outsw'
     119 | #define outsw(addr, buffer, count) __outsw(PCI_IOBASE + (addr), buffer, count)
         |                                            ~~~~~~~~~~ ^
   In file included from drivers/irqchip/irq-riscv-aplic-main.c:13:
   In file included from include/linux/of_irq.h:7:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:847:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     847 |         outsl(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:120:55: note: expanded from macro 'outsl'
     120 | #define outsl(addr, buffer, count) __outsl(PCI_IOBASE + (addr), buffer, count)
         |                                            ~~~~~~~~~~ ^
   In file included from drivers/irqchip/irq-riscv-aplic-main.c:13:
   In file included from include/linux/of_irq.h:7:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:1175:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
    1175 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
         |                                                   ~~~~~~~~~~ ^
>> drivers/irqchip/irq-riscv-aplic-main.c:220:26: error: use of undeclared identifier 'valH'
     220 |                 priv->saved_msiaddrh = valH;
         |                                        ^~~~
   7 warnings and 1 error generated.


vim +/valH +220 drivers/irqchip/irq-riscv-aplic-main.c

   203	
   204	void aplic_init_hw_global(struct aplic_priv *priv, bool msi_mode)
   205	{
   206		u32 val;
   207	#ifdef CONFIG_RISCV_M_MODE
   208		u32 valh;
   209	
   210		if (msi_mode) {
   211			val = lower_32_bits(priv->msicfg.base_ppn);
   212			valh = FIELD_PREP(APLIC_xMSICFGADDRH_BAPPN, upper_32_bits(priv->msicfg.base_ppn));
   213			valh |= FIELD_PREP(APLIC_xMSICFGADDRH_LHXW, priv->msicfg.lhxw);
   214			valh |= FIELD_PREP(APLIC_xMSICFGADDRH_HHXW, priv->msicfg.hhxw);
   215			valh |= FIELD_PREP(APLIC_xMSICFGADDRH_LHXS, priv->msicfg.lhxs);
   216			valh |= FIELD_PREP(APLIC_xMSICFGADDRH_HHXS, priv->msicfg.hhxs);
   217			writel(val, priv->regs + APLIC_xMSICFGADDR);
   218			writel(valh, priv->regs + APLIC_xMSICFGADDRH);
   219			priv->saved_msiaddr = val;
 > 220			priv->saved_msiaddrh = valH;
   221		}
   222	#endif
   223	
   224		/* Setup APLIC domaincfg register */
   225		val = readl(priv->regs + APLIC_DOMAINCFG);
   226		val |= APLIC_DOMAINCFG_IE;
   227		if (msi_mode)
   228			val |= APLIC_DOMAINCFG_DM;
   229		writel(val, priv->regs + APLIC_DOMAINCFG);
   230		if (readl(priv->regs + APLIC_DOMAINCFG) != val)
   231			dev_warn(priv->dev, "unable to write 0x%x in domaincfg\n", val);
   232		priv->saved_domaincfg = val;
   233	}
   234	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


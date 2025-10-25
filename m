Return-Path: <linux-kernel+bounces-869646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E94C08641
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 02:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E97D44EF840
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 00:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575AA78F36;
	Sat, 25 Oct 2025 00:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PB7iI4Nj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26393249E5
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 00:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761351688; cv=none; b=jQJz+cs+yp2FjmMvFHHKOT4eoFpLxVsGN5lQWnOi2vHnggfKr1ohBD90jfMIn9TmCn8K/RRhZvELeLyZzUZbOqqNyaopOwhdsPr8IZu7LxtdaCm9Yc1gAD5BTvM1UTJVxaE4oq3+pgOogrAJ2FqOpZGvrGI4YMV+zGXdz0yxaeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761351688; c=relaxed/simple;
	bh=It2In47AKGq20T9gVbO2USTvSDh2utL9rO9AZbv13Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YIgd10DtCb1UGJ41/a5RSElbLV48qR7rK5UGr+SEk0rmGQerjo6bCAAy7MLHZuUQB2YI4H+ARBOMVVDpKjVOiCnXG5SEo8KzfDg2wZTmHIiRYHa0yPJnwBFLp/q5ReX7srLR/pIu8Vt1AMqPWDM6lvwIhzxx4tgNePH8RVNHcBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PB7iI4Nj; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761351687; x=1792887687;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=It2In47AKGq20T9gVbO2USTvSDh2utL9rO9AZbv13Qs=;
  b=PB7iI4Nj9U2Uzez9PSqvlCUxDfQYC6DBFsNGIIILGBva1ouB4sgvh3Fz
   6Uq+jvC2r8MfMAERLS36TCSBaIFjndWlUD3wDg9sGjDofkVWgs2YC03tj
   X+AHr/YfgBnRgJe2B9KzqtjtOKqujukP23zNPBrO7Xx6ICVlKXFQsSvRR
   uHnLecblLMV3d2jR1mYT9eFKxWgLNw6XkCTyvVdE2oleH/8w3Eh+0LriU
   zWodJsuARPbGwfuJLakQNeW9lCsc6AqcNp+7bMZ14D0B+ez5Ogz5TsXaC
   w8lwdgCeDammFTklLE3zVvrWCadwW6R8jrWypcYAlgeehqL0C3pg8qQl8
   g==;
X-CSE-ConnectionGUID: ji+YfodBTdeMisxRaAG84Q==
X-CSE-MsgGUID: zFtfWh9eSnGxsSBGjxQBpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="80966140"
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="80966140"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 17:21:27 -0700
X-CSE-ConnectionGUID: Xocof/kbQXik/Cob2CJbbg==
X-CSE-MsgGUID: hy3v8xBtSv2BtZdRRBzJCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="189681826"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 24 Oct 2025 17:21:23 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vCS24-000Ezp-1M;
	Sat, 25 Oct 2025 00:21:21 +0000
Date: Sat, 25 Oct 2025 08:21:13 +0800
From: kernel test robot <lkp@intel.com>
To: Charles Mirabile <cmirabil@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Zhang Xincheng <zhangxincheng@ultrarisc.com>,
	Lucas Zampieri <lzampier@redhat.com>
Subject: [tip:irq/drivers 23/23] drivers/irqchip/irq-sifive-plic.c:404:17:
 error: no member named 'enabled_save' in 'struct plic_handler'
Message-ID: <202510250838.m2InkkSl-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/drivers
head:   b5fa8915a50a44c01727ab5b60193188c88e4881
commit: b5fa8915a50a44c01727ab5b60193188c88e4881 [23/23] irqchip/sifive-plic: Add support for UltraRISC DP1000 PLIC
config: riscv-randconfig-002-20251025 (https://download.01.org/0day-ci/archive/20251025/202510250838.m2InkkSl-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project e1ae12640102fd2b05bc567243580f90acb1135f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251025/202510250838.m2InkkSl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510250838.m2InkkSl-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/irqchip/irq-sifive-plic.c:404:17: error: no member named 'enabled_save' in 'struct plic_handler'
     404 |                 if (!handler->enabled_save[i])
         |                      ~~~~~~~  ^
   drivers/irqchip/irq-sifive-plic.c:407:27: error: no member named 'enabled_save' in 'struct plic_handler'
     407 |                 pending_irqs = handler->enabled_save(i] & readl_relaxed(pending + i);
         |                                ~~~~~~~  ^
   drivers/irqchip/irq-sifive-plic.c:422:28: error: no member named 'enabled_save' in 'struct plic_handler'
     422 |                 if (new_mask != handler->enabled_save[j])
         |                                 ~~~~~~~  ^
   3 errors generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for ARCH_HAS_ELF_CORE_EFLAGS
   Depends on [n]: BINFMT_ELF [=y] && ELF_CORE [=n]
   Selected by [y]:
   - RISCV [=y]


vim +404 drivers/irqchip/irq-sifive-plic.c

   393	
   394	static u32 cp100_isolate_pending_irq(int nr_irq_groups, struct plic_handler *handler)
   395	{
   396		u32 __iomem *pending = handler->priv->regs + PENDING_BASE;
   397		u32 __iomem *enable = handler->enable_base;
   398		u32 pending_irqs = 0;
   399		int i, j;
   400	
   401		/* Look for first pending interrupt */
   402		for (i = 0; i < nr_irq_groups; i++) {
   403			/* Any pending interrupts would be annihilated, so skip checking them */
 > 404			if (!handler->enabled_save[i])
   405				continue;
   406	
   407			pending_irqs = handler->enabled_save(i] & readl_relaxed(pending + i);
   408			if (pending_irqs)
   409				break;
   410		}
   411	
   412		if (!pending_irqs)
   413			return 0;
   414	
   415		/* Isolate lowest set bit*/
   416		pending_irqs &= -pending_irqs;
   417	
   418		/* Disable all interrupts but the first pending one */
   419		for (j = 0; j < nr_irq_groups; j++) {
   420			u32 new_mask = j == i ? pending_irqs : 0;
   421	
   422			if (new_mask != handler->enabled_save[j])
   423				writel_relaxed(new_mask, enable + j);
   424		}
   425		return pending_irqs;
   426	}
   427	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


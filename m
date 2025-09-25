Return-Path: <linux-kernel+bounces-833440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0726BA1F6E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 01:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D34EE7B8CB8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6442ED153;
	Thu, 25 Sep 2025 23:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jEE7kUMD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D592EC54B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 23:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758842845; cv=none; b=O9esDmkG3vzpY6O6Qr7bKUEwss1Y0j6BeA7yq/rGOPsU7G3E+vstMnhH4Ta9RE3psupsfbVCNC9g3kJyh1ri5AOZ942K7XNGNRKKl1vIthimF9CBOYlQBYaugumF0jUaBfL1ivbok3UHhzzcBQ+laf85dy+kKV35/InkQy63HSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758842845; c=relaxed/simple;
	bh=drOGN/2SSppJuULVXhq8xBsiy4/uFibNLwTavAfIOWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PuZNZn5/ITF+D4cDx8B+azPCC+7riO1Mg0CBqOJ5AoyIK3irMtWMDqZ5f3W8glmVBM6zrHfeqNIqn/23HMDTNNXwRLPaQMiGBZ5tPvwS9fLLhH3P50P4OGAqsuYcR0gAgfr2NAOYmfhhmaAjI3cC7dxUuX1h4DxSXMB8n1D+2J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jEE7kUMD; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758842843; x=1790378843;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=drOGN/2SSppJuULVXhq8xBsiy4/uFibNLwTavAfIOWE=;
  b=jEE7kUMDwM7kuqdm5EO0jC5Jdn0D3nuca5ZxIHg/gIvX7oEz4ZyXlGKd
   02DgWMJ7MKiSfSSzHNOLBf04QWLBDf8cAfNoTdTzPt0J9Bz6QmmFF+8Bx
   n8McpGbhvWZGhatpij6mnBVOx5lrccJF5NSCkvu6dbhEpbSVbTZbMSC64
   r7hxWrtN3PbubYB0WJwowKfEaS/sIkrqYP0A0VaSlqUAwswXqo/0lCjQw
   BV8E0fK3c9EiRnQ2Q1gCmIEWsIGM/xmg6ZQztdIO2c7u7NOnmR1GmzdCJ
   MtNjfVjRyosp6WCRHrJTqABTS5etH8gpmPNL+sFQ4nbCrNcEu+5BasgRn
   A==;
X-CSE-ConnectionGUID: Hx6lc5UNTf64bINUkgjn9w==
X-CSE-MsgGUID: EFBBuYrnQBqjXGXDG3StJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="71793956"
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="71793956"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 16:27:23 -0700
X-CSE-ConnectionGUID: p+T+aV1+TjOS4Ucj/SAz7w==
X-CSE-MsgGUID: 490zB1/NTwyc/BGbckgXWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="177395951"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 25 Sep 2025 16:27:21 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v1vMs-0005jB-1l;
	Thu, 25 Sep 2025 23:27:18 +0000
Date: Fri, 26 Sep 2025 07:27:09 +0800
From: kernel test robot <lkp@intel.com>
To: Radu Rendec <rrendec@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>,
	Eric Chanudet <echanude@redhat.com>
Subject: Re: [PATCH 1/1] samples: Add irqchip test driver
Message-ID: <202509260730.o2TJUGJS-lkp@intel.com>
References: <20250923232905.1510547-2-rrendec@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923232905.1510547-2-rrendec@redhat.com>

Hi Radu,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.17-rc7 next-20250925]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Radu-Rendec/samples-Add-irqchip-test-driver/20250924-073245
base:   linus/master
patch link:    https://lore.kernel.org/r/20250923232905.1510547-2-rrendec%40redhat.com
patch subject: [PATCH 1/1] samples: Add irqchip test driver
config: i386-randconfig-015-20250926 (https://download.01.org/0day-ci/archive/20250926/202509260730.o2TJUGJS-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250926/202509260730.o2TJUGJS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509260730.o2TJUGJS-lkp@intel.com/

All errors (new ones prefixed by >>):

>> samples/irqchip/irqc_test.c:187:10: error: use of undeclared identifier 'irq_domain_free_irqs_common'; did you mean 'irq_domain_free_irqs'?
     187 |         .free = irq_domain_free_irqs_common,
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                 irq_domain_free_irqs
   include/linux/irqdomain.h:651:20: note: 'irq_domain_free_irqs' declared here
     651 | static inline void irq_domain_free_irqs(unsigned int virq, unsigned int nr_irqs) { }
         |                    ^
>> samples/irqchip/irqc_test.c:186:3: error: field designator 'alloc' does not refer to any field in type 'const struct irq_domain_ops'
     186 |         .alloc = root_alloc,
         |         ~^~~~~~~~~~~~~~~~~~
>> samples/irqchip/irqc_test.c:187:3: error: field designator 'free' does not refer to any field in type 'const struct irq_domain_ops'
     187 |         .free = irq_domain_free_irqs_common,
         |         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> samples/irqchip/irqc_test.c:188:3: error: field designator 'translate' does not refer to any field in type 'const struct irq_domain_ops'
     188 |         .translate = irq_domain_translate_onecell,
         |         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> samples/irqchip/irqc_test.c:198:13: error: use of undeclared identifier 'irq_chip_ack_parent'
     198 |         .irq_ack = irq_chip_ack_parent,
         |                    ^
>> samples/irqchip/irqc_test.c:199:22: error: use of undeclared identifier 'irq_chip_set_affinity_parent'; did you mean 'irq_set_affinity_hint'?
     199 |         .irq_set_affinity = irq_chip_set_affinity_parent,
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                             irq_set_affinity_hint
   include/linux/interrupt.h:404:19: note: 'irq_set_affinity_hint' declared here
     404 | static inline int irq_set_affinity_hint(unsigned int irq,
         |                   ^
>> samples/irqchip/irqc_test.c:219:19: error: no member named 'parent' in 'struct irq_domain'
     219 |                 .fwnode = irqd->parent->fwnode,
         |                           ~~~~  ^
>> samples/irqchip/irqc_test.c:236:20: error: no member named 'parent_data' in 'struct irq_data'
     236 |                         virq + i, d, d->parent_data);
         |                                      ~  ^
   include/linux/printk.h:587:34: note: expanded from macro 'pr_info'
     587 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |                                         ^~~~~~~~~~~
   include/linux/printk.h:514:60: note: expanded from macro 'printk'
     514 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                                                            ^~~~~~~~~~~
   include/linux/printk.h:486:19: note: expanded from macro 'printk_index_wrap'
     486 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
>> samples/irqchip/irqc_test.c:237:3: error: call to undeclared function 'irq_domain_set_hwirq_and_chip'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     237 |                 irq_domain_set_hwirq_and_chip(irqd, virq + i, hwirq + i,
         |                 ^
>> samples/irqchip/irqc_test.c:256:9: error: call to undeclared function 'irq_domain_alloc_irqs_parent'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     256 |         return irq_domain_alloc_irqs_parent(irqd, virq, nr_irqs, &parent_fwspec);
         |                ^
   samples/irqchip/irqc_test.c:256:9: note: did you mean 'irq_domain_alloc_irqs'?
   include/linux/irqdomain.h:645:19: note: 'irq_domain_alloc_irqs' declared here
     645 | static inline int irq_domain_alloc_irqs(struct irq_domain *domain, unsigned int nr_irqs,
         |                   ^
   samples/irqchip/irqc_test.c:269:10: error: use of undeclared identifier 'irq_domain_free_irqs_common'; did you mean 'irq_domain_free_irqs'?
     269 |         .free = irq_domain_free_irqs_common,
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                 irq_domain_free_irqs
   include/linux/irqdomain.h:651:20: note: 'irq_domain_free_irqs' declared here
     651 | static inline void irq_domain_free_irqs(unsigned int virq, unsigned int nr_irqs) { }
         |                    ^
   samples/irqchip/irqc_test.c:268:3: error: field designator 'alloc' does not refer to any field in type 'const struct irq_domain_ops'
     268 |         .alloc = hier_alloc,
         |         ~^~~~~~~~~~~~~~~~~~
   samples/irqchip/irqc_test.c:269:3: error: field designator 'free' does not refer to any field in type 'const struct irq_domain_ops'
     269 |         .free = irq_domain_free_irqs_common,
         |         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   samples/irqchip/irqc_test.c:270:3: error: field designator 'translate' does not refer to any field in type 'const struct irq_domain_ops'
     270 |         .translate = irq_domain_translate_onecell,
         |         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> samples/irqchip/irqc_test.c:438:14: error: call to undeclared function 'irq_domain_create_hierarchy'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     438 |         hier_irqd = irq_domain_create_hierarchy(root_irqd, 0, NUM_TOTAL_IRQS_HIER,
         |                     ^
   samples/irqchip/irqc_test.c:438:14: note: did you mean 'irq_domain_create_legacy'?
   include/linux/irqdomain.h:324:20: note: 'irq_domain_create_legacy' declared here
     324 | struct irq_domain *irq_domain_create_legacy(struct fwnode_handle *fwnode, unsigned int size,
         |                    ^
>> samples/irqchip/irqc_test.c:438:12: error: incompatible integer to pointer conversion assigning to 'struct irq_domain *' from 'int' [-Wint-conversion]
     438 |         hier_irqd = irq_domain_create_hierarchy(root_irqd, 0, NUM_TOTAL_IRQS_HIER,
         |                   ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     439 |                                                 hier_fwnode, &hier_ops, NULL);
         |                                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   16 errors generated.


vim +187 samples/irqchip/irqc_test.c

   166	
   167	/*
   168	 * Parent IRQ domains *must* use the new API (i.e. alloc/free vs. map) to
   169	 * support hierarchy, for the following reasons:
   170	 *   - The child .alloc() function calls irq_domain_alloc_irqs_parent().
   171	 *   - The irq_domain_alloc_irqs_hierarchy() is just a thin wrapper around
   172	 *     irq_domain_alloc_irqs_hierarchy().
   173	 *   - Finally, irq_domain_alloc_irqs_hierarchy() explicitly checks that
   174	 *     the (parent) domain implements the alloc() function and returns an
   175	 *     error otherwise.
   176	 *
   177	 * Furthermore, Documentation/core-api/irq/irq-domain.rst clearly states that
   178	 * the new API must be used for all domains to support hierarchy.
   179	 *
   180	 * Note: The .free() function is also part of the new API and is mandatory but
   181	 *       there is a default implementation that we can use. If we do not
   182	 *       implement this function and .alloc() fails for whatever reason, we get
   183	 *       an oops as the IRQ framework tries to rollback whatever has been done.
   184	 */
   185	static const struct irq_domain_ops root_ops = {
 > 186		.alloc = root_alloc,
 > 187		.free = irq_domain_free_irqs_common,
 > 188		.translate = irq_domain_translate_onecell,
   189	};
   190	
   191	/*
   192	 * Since hierarchical interrupts are mapped 1:1 in all domains along the path,
   193	 * CPU affinity is not shared with other interrupts. Use the parent handlers to
   194	 * set the affinity in the root domain.
   195	 */
   196	static const struct irq_chip hier_chip = {
   197		.name = "TEST-HIER-IC",
 > 198		.irq_ack = irq_chip_ack_parent,
 > 199		.irq_set_affinity = irq_chip_set_affinity_parent,
   200	};
   201	
   202	/*
   203	 * For a GPIO IRQ chip, this is gpiochip_hierarchy_irq_domain_alloc(), and the
   204	 * ops pointer is set in gpiochip_hierarchy_setup_domain_ops(), called from
   205	 * gpiochip_hierarchy_add_domain(). See full stack sample below in testirq_init().
   206	 *
   207	 * This function is called indirectly by irq_create_fwspec_mapping() through
   208	 * irq_domain_alloc_irqs_locked().
   209	 *
   210	 * How to search for other examples:
   211	 *   grep -rn '\.alloc\>' drivers/gpio/
   212	 *   grep -rn '\<irq_domain_alloc_irqs_parent\>' drivers/irqchip/
   213	 */
   214	static int hier_alloc(struct irq_domain *irqd, unsigned int virq,
   215			      unsigned int nr_irqs, void *data)
   216	{
   217		struct irq_fwspec *fwspec = data;
   218		struct irq_fwspec parent_fwspec = {
 > 219			.fwnode = irqd->parent->fwnode,
   220			.param_count = 1,
   221		};
   222		irq_hw_number_t hwirq;
   223		unsigned int type;
   224		int ret, i;
   225	
   226		pr_info("[%s] virq = %u, nr_irqs = %u\n", irqd->name, virq, nr_irqs);
   227	
   228		ret = irq_domain_translate_onecell(irqd, fwspec, &hwirq, &type);
   229		if (ret)
   230			return ret;
   231	
   232		for (i = 0; i < nr_irqs; i++) {
   233			struct irq_data *d = irq_get_irq_data(virq + i);
   234	
   235			pr_info("\tvirq = %u, data = %pS, parent = %pS\n",
 > 236				virq + i, d, d->parent_data);
 > 237			irq_domain_set_hwirq_and_chip(irqd, virq + i, hwirq + i,
   238						      &hier_chip, NULL);
   239		}
   240	
   241		/*
   242		 * We're not done yet, we still need to allocate interrupts in the
   243		 * parent domain. If we just "return 0" at this point, the upstream
   244		 * call to irq_create_fwspec_mapping() fails with -EINVAL.
   245		 *
   246		 * By now, the framework has already allocated a struct irq_data for
   247		 * each virq, for both our domain (hier) and the parent domain (root).
   248		 * So, irq_get_irq_data(virq) and irq_get_irq_data(virq)->parent_data
   249		 * are both non-null. The problem is that parent_data->chip is NULL,
   250		 * and this fails the sanity checks in irq_domain_trim_hierarchy()
   251		 * (called from irq_domain_alloc_irqs_locked()).
   252		 */
   253	
   254		parent_fwspec.param[0] = hwirq;
   255	
 > 256		return irq_domain_alloc_irqs_parent(irqd, virq, nr_irqs, &parent_fwspec);
   257	}
   258	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


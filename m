Return-Path: <linux-kernel+bounces-723099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3729DAFE2E1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C04C3B6208
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AA027E07F;
	Wed,  9 Jul 2025 08:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CBAfDrqg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5554327BF7E;
	Wed,  9 Jul 2025 08:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752050372; cv=none; b=DHezp1nRo1dytI1DW4hY28pv5MxEWJogWlQID18PNLcYORCPFec7g5pWQWvZ7KfUryhhAXxIAdcA2PHU1FdDoOhtZY9IEFwoCpwoIKVZOFY3oxioFleoh8lExRAjs31BIHHbNgfKNJIPKVAkGyr8YkcVi6acvuUCoOY9p+mmQm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752050372; c=relaxed/simple;
	bh=t5VSNcEehMTMmquqfqCWRO5GNuFwm77JFuq0jWmOL6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syJHBxl7LaKZefc3NzFiuTa0cY6Imjs8/OunYFAMtWONYfNv+cwQh8D6wptg1gnAX88ofZKZh0dyL9xH9f4K0FPINrSjDqtmrf9/7pa6LM79uwujz4aOKZeFflZWSX2PnVPf06IxHWP8o3DK0bR1MP0P4YTsGrhQdzYGdWFUtXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CBAfDrqg; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752050370; x=1783586370;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t5VSNcEehMTMmquqfqCWRO5GNuFwm77JFuq0jWmOL6s=;
  b=CBAfDrqggQ4aaV06iJJpmwtir5JGtrEpK3SrTqE32qyBTW6qzWeeU3Gr
   KaUQnjvo8+uRjxkbEMggVr/lzhC/y+UJxKZZubwPwiep2J4O5OHlJ0H1/
   9B73/hGqJM/eHNunDqcNaTBVr5uzThJaxpiVJi8WJ3GBZ360tydJcfGVS
   wS23lmzrypgkMyLinYweuZMuaRHc9BtPiW9Ahf5RfygFkQdIML8f1WnCI
   xf8aRv71pNlwdGvujxWGmFJeyrIivcF8OOIAO/avuNMhPrHq7SMXfpLiE
   b+GJECJik1UX9v0XuwmOeY104HuN4yzccUn+vXcfwPgZSbUbZiJZMit+3
   g==;
X-CSE-ConnectionGUID: EdKEeuRqS+ScoRnmkaKP4Q==
X-CSE-MsgGUID: Nt7oJiu2SY2AObq1cpRI4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="65757433"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="65757433"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 01:39:22 -0700
X-CSE-ConnectionGUID: PBDRceqkTPSbk+KI6/bZSQ==
X-CSE-MsgGUID: g0mu55mKQvKDPVjiEO9nuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="159755930"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 09 Jul 2025 01:39:07 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uZQKT-0003J5-29;
	Wed, 09 Jul 2025 08:39:01 +0000
Date: Wed, 9 Jul 2025 16:38:07 +0800
From: kernel test robot <lkp@intel.com>
To: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>,
	robh@kernel.org, m.szyprowski@samsung.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	saravanak@google.com, robin.murphy@arm.com,
	quic_obabatun@quicinc.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	william.zhang@broadcom.com, kernel@oss.qualcomm.com,
	will@kernel.org, djakov@kernel.org,
	Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
Subject: Re: [PATCH] of: reserved_mem: Restructure call site for
 dma_contiguous_early_fixup()
Message-ID: <202507091614.ZsQ9sH7n-lkp@intel.com>
References: <20250708165627.845295-1-oreoluwa.babatunde@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708165627.845295-1-oreoluwa.babatunde@oss.qualcomm.com>

Hi Oreoluwa,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.16-rc5 next-20250708]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oreoluwa-Babatunde/of-reserved_mem-Restructure-call-site-for-dma_contiguous_early_fixup/20250709-005858
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250708165627.845295-1-oreoluwa.babatunde%40oss.qualcomm.com
patch subject: [PATCH] of: reserved_mem: Restructure call site for dma_contiguous_early_fixup()
config: i386-buildonly-randconfig-003-20250709 (https://download.01.org/0day-ci/archive/20250709/202507091614.ZsQ9sH7n-lkp@intel.com/config)
compiler: clang version 20.1.7 (https://github.com/llvm/llvm-project 6146a88f60492b520a36f8f8f3231e15f3cc6082)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250709/202507091614.ZsQ9sH7n-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507091614.ZsQ9sH7n-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/of/of_reserved_mem.c:182:5: error: call to undeclared function 'dma_contiguous_early_fixup'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     182 |                                 dma_contiguous_early_fixup(base, size);
         |                                 ^
   drivers/of/of_reserved_mem.c:482:3: error: call to undeclared function 'dma_contiguous_early_fixup'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     482 |                 dma_contiguous_early_fixup(base, size);
         |                 ^
   2 errors generated.


vim +/dma_contiguous_early_fixup +182 drivers/of/of_reserved_mem.c

   150	
   151	/*
   152	 * __reserved_mem_reserve_reg() - reserve all memory described in 'reg' property
   153	 */
   154	static int __init __reserved_mem_reserve_reg(unsigned long node,
   155						     const char *uname)
   156	{
   157		int t_len = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
   158		phys_addr_t base, size;
   159		int len;
   160		const __be32 *prop;
   161		bool nomap;
   162	
   163		prop = of_get_flat_dt_prop(node, "reg", &len);
   164		if (!prop)
   165			return -ENOENT;
   166	
   167		if (len && len % t_len != 0) {
   168			pr_err("Reserved memory: invalid reg property in '%s', skipping node.\n",
   169			       uname);
   170			return -EINVAL;
   171		}
   172	
   173		nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
   174	
   175		while (len >= t_len) {
   176			base = dt_mem_next_cell(dt_root_addr_cells, &prop);
   177			size = dt_mem_next_cell(dt_root_size_cells, &prop);
   178	
   179			if (size && early_init_dt_reserve_memory(base, size, nomap) == 0) {
   180				/* Architecture specific contiguous memory fixup. */
   181				if (of_flat_dt_is_compatible(node, "shared-dma-pool"))
 > 182					dma_contiguous_early_fixup(base, size);
   183	
   184				pr_debug("Reserved memory: reserved region for node '%s': base %pa, size %lu MiB\n",
   185					uname, &base, (unsigned long)(size / SZ_1M));
   186			} else {
   187				pr_err("Reserved memory: failed to reserve memory for node '%s': base %pa, size %lu MiB\n",
   188				       uname, &base, (unsigned long)(size / SZ_1M));
   189			}
   190	
   191			len -= t_len;
   192		}
   193		return 0;
   194	}
   195	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


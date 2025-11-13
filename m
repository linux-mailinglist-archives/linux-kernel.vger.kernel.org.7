Return-Path: <linux-kernel+bounces-900076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 652E9C598F1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 19:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B0D8934DB4E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0268312803;
	Thu, 13 Nov 2025 18:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PR6xYFk6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3562C30FC15;
	Thu, 13 Nov 2025 18:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763059500; cv=none; b=M6vsqcDRuOTnXbRGb2pXJuldD8DpMXvtPC/m6d49gGLyikiXgsiikPYTejHCCmKjqvq4rE9C6WshJke/48JVXQJ+DHS02Ixt8z/w6mU4uEIz1CHn+adkYA5cg5tquXw377gQFub2/yA/cE6+L6bzHFHNdV01XcRnpK+KJyWUe2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763059500; c=relaxed/simple;
	bh=uJwfz7y+UOjyl3txMn7ctra7YU4BaP0tmmsat+CbBmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fph8YdAWS0m8sG2DZdwUGJi/h2fkzm6BxWvZ6B0gA9rHa1v3PYxF3iv2lS9ouoJmWMjnyCtrvNsk2S+0yO9Bo1zqROQvD1swEMN9ukXdIzqdyn1xoGsOhB6/5TSEDgW+sHTgL5bobip2uK99a8Bm1siKZbIBkFi3WWCh8M642cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PR6xYFk6; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763059498; x=1794595498;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uJwfz7y+UOjyl3txMn7ctra7YU4BaP0tmmsat+CbBmU=;
  b=PR6xYFk6qzUcxnEZIaVSpVaAt0c+LkEsHcif0As7UCSa0pSy2T41nHG7
   Q9QwUZ3pt+lA+rmvD7RSmUp8xmD8QUxpSPqf1yhjwPjtqRnvX/kM5yvF5
   E+kXmf+4v3tLfRLbMBQpsdIcqXkqGmMXW3jPIc0TTp18Dy3ezY+LVXkjX
   VjqfB/LjMLo7fm/QQ+S8Z4QMvcTHOhEe4ktAJ5wc4QmezKtRFcx0fqEAz
   Y7kwqFgRvuMzK9vzJt8KeORMwV6ZQKfChP+Z+Ro3pfDZ10vbSjdniyvf2
   XZWr+VrQQDe4VubCGGMx8V1j+FK3piuY2z/VL4xuL4BW4+yaNVmO8OWGy
   g==;
X-CSE-ConnectionGUID: 5iK8ftCjT0yY0GaecxRbSQ==
X-CSE-MsgGUID: JFw5oROvSrKyATRfmd1kVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="82782235"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="82782235"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 10:44:57 -0800
X-CSE-ConnectionGUID: pXRj2ntZQ4eRt1WRIuqYvA==
X-CSE-MsgGUID: ckktt7N/RVqHdg43JpF33A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="189835423"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 13 Nov 2025 10:44:53 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vJcJO-0005l9-2G;
	Thu, 13 Nov 2025 18:44:50 +0000
Date: Fri, 14 Nov 2025 02:43:53 +0800
From: kernel test robot <lkp@intel.com>
To: Yuntao Wang <yuntao.wang@linux.dev>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Catalin Marinas <catalin.marinas@arm.com>,
	James Morse <james.morse@arm.com>, Baoquan He <bhe@redhat.com>,
	Zhen Lei <thunder.leizhen@huawei.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Geoff Levand <geoff@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Alexander Graf <graf@amazon.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yuntao Wang <yuntao.wang@linux.dev>
Subject: Re: [PATCH v2 3/7] of/fdt: Fix the len check in
 early_init_dt_check_for_usable_mem_range()
Message-ID: <202511140236.zLyckeBA-lkp@intel.com>
References: <20251113155104.226617-4-yuntao.wang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113155104.226617-4-yuntao.wang@linux.dev>

Hi Yuntao,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.18-rc5 next-20251113]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yuntao-Wang/of-fdt-Consolidate-duplicate-code-into-helper-functions/20251114-004121
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20251113155104.226617-4-yuntao.wang%40linux.dev
patch subject: [PATCH v2 3/7] of/fdt: Fix the len check in early_init_dt_check_for_usable_mem_range()
config: arm-allnoconfig (https://download.01.org/0day-ci/archive/20251114/202511140236.zLyckeBA-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 0bba1e76581bad04e7d7f09f5115ae5e2989e0d9)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251114/202511140236.zLyckeBA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511140236.zLyckeBA-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/of/fdt.c:903:31: error: incompatible pointer types passing 'phys_addr_t *' (aka 'unsigned int *') to parameter of type 'u64 *' (aka 'unsigned long long *') [-Wincompatible-pointer-types]
     903 |                 of_fdt_read_addr_size(prop, &rgn[i].base, &rgn[i].size);
         |                                             ^~~~~~~~~~~~
   drivers/of/fdt.c:663:60: note: passing argument to parameter 'addr' here
     663 | void __init of_fdt_read_addr_size(const __be32 *prop, u64 *addr, u64 *size)
         |                                                            ^
   drivers/of/fdt.c:903:45: error: incompatible pointer types passing 'phys_addr_t *' (aka 'unsigned int *') to parameter of type 'u64 *' (aka 'unsigned long long *') [-Wincompatible-pointer-types]
     903 |                 of_fdt_read_addr_size(prop, &rgn[i].base, &rgn[i].size);
         |                                                           ^~~~~~~~~~~~
   drivers/of/fdt.c:663:71: note: passing argument to parameter 'size' here
     663 | void __init of_fdt_read_addr_size(const __be32 *prop, u64 *addr, u64 *size)
         |                                                                       ^
   2 errors generated.


vim +903 drivers/of/fdt.c

   879	
   880	/**
   881	 * early_init_dt_check_for_usable_mem_range - Decode usable memory range
   882	 * location from flat tree
   883	 */
   884	void __init early_init_dt_check_for_usable_mem_range(void)
   885	{
   886		struct memblock_region rgn[MAX_USABLE_RANGES] = {0};
   887		const __be32 *prop;
   888		int len, i;
   889		unsigned long node = chosen_node_offset;
   890	
   891		if ((long)node < 0)
   892			return;
   893	
   894		pr_debug("Looking for usable-memory-range property... ");
   895	
   896		prop = of_fdt_get_addr_size_prop(node, "linux,usable-memory-range", &len);
   897		if (!prop)
   898			return;
   899	
   900		len = min(len, MAX_USABLE_RANGES);
   901	
   902		for (i = 0; i < len; i++) {
 > 903			of_fdt_read_addr_size(prop, &rgn[i].base, &rgn[i].size);
   904	
   905			pr_debug("cap_mem_regions[%d]: base=%pa, size=%pa\n",
   906				 i, &rgn[i].base, &rgn[i].size);
   907		}
   908	
   909		memblock_cap_memory_range(rgn[0].base, rgn[0].size);
   910		for (i = 1; i < MAX_USABLE_RANGES && rgn[i].size; i++)
   911			memblock_add(rgn[i].base, rgn[i].size);
   912	}
   913	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


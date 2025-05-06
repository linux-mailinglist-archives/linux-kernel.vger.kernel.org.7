Return-Path: <linux-kernel+bounces-634987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F8BAAB82C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 08:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D43001C40747
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 06:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF273110E0;
	Tue,  6 May 2025 01:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ad+OBHlr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65210312827
	for <linux-kernel@vger.kernel.org>; Mon,  5 May 2025 23:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746489069; cv=none; b=CNGlJ4n8nS9UR4s+CcJK0f3iXLSBOfkGnIBZnX5/2YDRvYHzaGMYJnDh1nUxBqSjYkA/fLkXXNb/EuxNt9LwWpeVGsenmWLHcguWY1t1pmrIg/iJIvMuWC3mXsJ3siYUtJA9Ti9+hKTkQoT2Kqxb+3dKwrQ6lRjuB6Fuh60NxF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746489069; c=relaxed/simple;
	bh=0DSF7dHmV17QwKXNCFzP0+mA7qcPG4gxTwIbAzLc++c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3XGHNYjEiZpCTkOnQUa/xQs8TJpb3kiNS6ricBZEAgvGEcar8u4ISJ8N63yzaeE5aOGtvIWJGKd3SpxDHURG6ydRqJptmd4B3O+B34X/rAea2aGWoKCXfrxREyPswuCUfB0BseH7dQlCLq5LOt9o1izRNg/aWJQOvcIbpFL5nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ad+OBHlr; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746489068; x=1778025068;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0DSF7dHmV17QwKXNCFzP0+mA7qcPG4gxTwIbAzLc++c=;
  b=Ad+OBHlrXTzSfXW6E2CQKDKinCzWZDKtMKzMqGbVZAzqzNaun6SWPRjD
   gCqsJejkY1C0+eJDvHdQFSzUOk1zbzpPqEo4Iz5VV2eA8WhjnHptoHPTm
   1hnDPUDpWmyuGfENItSXcFnxdTrhf9nAids8lmzytIM3kyMPTwE4Tu8GV
   Aos+5yFAMOIFwrA1YnZcpVnT/ZL2M5NIamYPzBGcqnmDaFhPOzbhY10WD
   4PZ9HtUctPyaGT6YkJcUJXrHskzkUZI5OqsiCLvW4Wr0wYhQudIPyhGwG
   R4Ka79XpVwfev8IVxaQWBj2lYTB0YV4Hro7X35OiewAUJSp4ilqatrn/3
   Q==;
X-CSE-ConnectionGUID: 5NyW45pPQLuGYdGZ4FcW7g==
X-CSE-MsgGUID: XEfhBtocTPiEWxXujoh/gA==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="51939052"
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="51939052"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 16:51:06 -0700
X-CSE-ConnectionGUID: B9ereCXyRtKibr91GbHSFA==
X-CSE-MsgGUID: nRDOwKmBSD+5Q8l7GbvmPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="172617724"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 05 May 2025 16:51:04 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uC5aO-00068L-2k;
	Mon, 05 May 2025 23:51:00 +0000
Date: Tue, 6 May 2025 07:50:59 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb+git@google.com>,
	linux-arm-kernel@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
	Ard Biesheuvel <ardb@kernel.org>, Yeoreum Yun <yeoreum.yun@arm.com>
Subject: Re: [PATCH 1/3] arm64/boot: Move init_pgdir[] into __pi_ namespace
Message-ID: <202505060740.OIkWGFVZ-lkp@intel.com>
References: <20250503112137.1962910-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250503112137.1962910-6-ardb+git@google.com>

Hi Ard,

kernel test robot noticed the following build errors:

[auto build test ERROR on soc/for-next]
[also build test ERROR on arm/for-next arm/fixes linus/master v6.15-rc5 next-20250505]
[cannot apply to arm64/for-next/core kvmarm/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ard-Biesheuvel/arm64-boot-Move-init_pgdir-into-__pi_-namespace/20250503-192534
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20250503112137.1962910-6-ardb%2Bgit%40google.com
patch subject: [PATCH 1/3] arm64/boot: Move init_pgdir[] into __pi_ namespace
config: arm64-allnoconfig (https://download.01.org/0day-ci/archive/20250506/202505060740.OIkWGFVZ-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250506/202505060740.OIkWGFVZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505060740.OIkWGFVZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/arm64/kernel/pi/map_kernel.c: In function 'remap_idmap_for_lpa2':
>> arch/arm64/kernel/pi/map_kernel.c:191:37: error: 'init_pg_end' undeclared (first use in this function); did you mean 'init_pg_dir'?
     191 |         memset(init_pg_dir, 0, (u64)init_pg_end - (u64)init_pg_dir);
         |                                     ^~~~~~~~~~~
         |                                     init_pg_dir
   arch/arm64/kernel/pi/map_kernel.c:191:37: note: each undeclared identifier is reported only once for each function it appears in
   arch/arm64/kernel/pi/map_kernel.c: In function 'early_map_kernel':
   arch/arm64/kernel/pi/map_kernel.c:222:37: error: 'init_pg_end' undeclared (first use in this function); did you mean 'init_pg_dir'?
     222 |         memset(__bss_start, 0, (u64)init_pg_end - (u64)__bss_start);
         |                                     ^~~~~~~~~~~
         |                                     init_pg_dir


vim +191 arch/arm64/kernel/pi/map_kernel.c

9684ec186f8fad Ard Biesheuvel 2024-02-14  158  
9684ec186f8fad Ard Biesheuvel 2024-02-14  159  static void __init remap_idmap_for_lpa2(void)
9684ec186f8fad Ard Biesheuvel 2024-02-14  160  {
9684ec186f8fad Ard Biesheuvel 2024-02-14  161  	/* clear the bits that change meaning once LPA2 is turned on */
9684ec186f8fad Ard Biesheuvel 2024-02-14  162  	pteval_t mask = PTE_SHARED;
9684ec186f8fad Ard Biesheuvel 2024-02-14  163  
9684ec186f8fad Ard Biesheuvel 2024-02-14  164  	/*
9684ec186f8fad Ard Biesheuvel 2024-02-14  165  	 * We have to clear bits [9:8] in all block or page descriptors in the
9684ec186f8fad Ard Biesheuvel 2024-02-14  166  	 * initial ID map, as otherwise they will be (mis)interpreted as
9684ec186f8fad Ard Biesheuvel 2024-02-14  167  	 * physical address bits once we flick the LPA2 switch (TCR.DS). Since
9684ec186f8fad Ard Biesheuvel 2024-02-14  168  	 * we cannot manipulate live descriptors in that way without creating
9684ec186f8fad Ard Biesheuvel 2024-02-14  169  	 * potential TLB conflicts, let's create another temporary ID map in a
9684ec186f8fad Ard Biesheuvel 2024-02-14  170  	 * LPA2 compatible fashion, and update the initial ID map while running
9684ec186f8fad Ard Biesheuvel 2024-02-14  171  	 * from that.
9684ec186f8fad Ard Biesheuvel 2024-02-14  172  	 */
9684ec186f8fad Ard Biesheuvel 2024-02-14  173  	create_init_idmap(init_pg_dir, mask);
9684ec186f8fad Ard Biesheuvel 2024-02-14  174  	dsb(ishst);
9684ec186f8fad Ard Biesheuvel 2024-02-14  175  	set_ttbr0_for_lpa2((u64)init_pg_dir);
9684ec186f8fad Ard Biesheuvel 2024-02-14  176  
9684ec186f8fad Ard Biesheuvel 2024-02-14  177  	/*
9684ec186f8fad Ard Biesheuvel 2024-02-14  178  	 * Recreate the initial ID map with the same granularity as before.
9684ec186f8fad Ard Biesheuvel 2024-02-14  179  	 * Don't bother with the FDT, we no longer need it after this.
9684ec186f8fad Ard Biesheuvel 2024-02-14  180  	 */
9684ec186f8fad Ard Biesheuvel 2024-02-14  181  	memset(init_idmap_pg_dir, 0,
ecc54006f158ae Zenghui Yu     2024-06-21  182  	       (u64)init_idmap_pg_end - (u64)init_idmap_pg_dir);
9684ec186f8fad Ard Biesheuvel 2024-02-14  183  
9684ec186f8fad Ard Biesheuvel 2024-02-14  184  	create_init_idmap(init_idmap_pg_dir, mask);
9684ec186f8fad Ard Biesheuvel 2024-02-14  185  	dsb(ishst);
9684ec186f8fad Ard Biesheuvel 2024-02-14  186  
9684ec186f8fad Ard Biesheuvel 2024-02-14  187  	/* switch back to the updated initial ID map */
9684ec186f8fad Ard Biesheuvel 2024-02-14  188  	set_ttbr0_for_lpa2((u64)init_idmap_pg_dir);
9684ec186f8fad Ard Biesheuvel 2024-02-14  189  
9684ec186f8fad Ard Biesheuvel 2024-02-14  190  	/* wipe the temporary ID map from memory */
9684ec186f8fad Ard Biesheuvel 2024-02-14 @191  	memset(init_pg_dir, 0, (u64)init_pg_end - (u64)init_pg_dir);
9684ec186f8fad Ard Biesheuvel 2024-02-14  192  }
9684ec186f8fad Ard Biesheuvel 2024-02-14  193  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


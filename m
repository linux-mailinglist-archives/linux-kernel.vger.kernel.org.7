Return-Path: <linux-kernel+bounces-817957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3048FB589AF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C22693BF395
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 00:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C417535950;
	Tue, 16 Sep 2025 00:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JcCMqs0K"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888822032D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 00:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982947; cv=none; b=EigMSGgPdJXjhu7NkMXrfMmRz89AcJYmJjHGEWDNBbD5fhdjnnMJR9gq330RKHnS6tW34k7DvUbs/DFtaVDVGmw5HZP9PvXgmd+z9FFlx522OiH8atkDgKBMrz8YKiE6bgz4010QCuMThbWDlfkKTLOOp+ETVfutA3XJ2e2kJFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982947; c=relaxed/simple;
	bh=LmJHPD9NHoWsBXvcXhrQkihPJobp0T9K6gUq47vVjC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdHRtsdW/0XwaZ2AzubGQiSTpCliHNSz8JqChj5AXkHVJYCyqiWziAuhhufw3cC4pFE4yBzAR+p4SKQOI/KhOj2FpxXb/Bot53W4hitcaQ4DYP2S+gmi3qjzQvlP3QxLqtsRtr9pm9puMR4VyKLgg7l5Z0Yx2c+PSA7X3S+CXm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JcCMqs0K; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757982946; x=1789518946;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LmJHPD9NHoWsBXvcXhrQkihPJobp0T9K6gUq47vVjC8=;
  b=JcCMqs0KkCuO0XSzKxdOzodfWsyBcuvcKRB2qVct7AJNFVKFSJUR8P5X
   +SxhcqF3G/A04DsRnMnqeYbrEUUxiNYsDLhRbczzvzQt2Qz7szg7Znsu2
   ScOFHGmfwoYvi4iSJoXXD35R9jEUCGGfHwXBm8/M0EIxk6WiUAuf5YDiE
   6KClvzW29evtvnogMOHI5c8vje34lMoIR7wq88wYYzrkCb6AWdI+0AAxb
   DpL9cCXMCrEJ+1gj13ikC5GpA2ZFNIPmlb8cNq3tvZDTezQz/JKG0qe3k
   7XTS+jC4BA++kQbuSrYb8aiy4afa2Ms98WQUjD3NxxNwQC0He/Pv8sbNJ
   w==;
X-CSE-ConnectionGUID: NP3vUqLdTyesjnCdScNfrA==
X-CSE-MsgGUID: WePOyC2TTiCm3g0004YEEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="59950170"
X-IronPort-AV: E=Sophos;i="6.18,267,1751266800"; 
   d="scan'208";a="59950170"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 17:35:45 -0700
X-CSE-ConnectionGUID: TdDvCJkJRcqdFr636SwQ8w==
X-CSE-MsgGUID: TK3RuA7ETMiS+F2G8Urczw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,267,1751266800"; 
   d="scan'208";a="174607853"
Received: from lkp-server01.sh.intel.com (HELO 5b01dd97f97c) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 15 Sep 2025 17:35:43 -0700
Received: from kbuild by 5b01dd97f97c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uyJfY-0000qX-36;
	Tue, 16 Sep 2025 00:35:40 +0000
Date: Tue, 16 Sep 2025 08:34:46 +0800
From: kernel test robot <lkp@intel.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Michal Hocko <mhocko@kernel.org>, Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH v2 10/10] mm/vmalloc: Update __vmalloc_node_range()
 documentation
Message-ID: <202509160821.gR75Zhnh-lkp@intel.com>
References: <20250915134041.151462-11-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915134041.151462-11-urezki@gmail.com>

Hi Uladzislau,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.17-rc6 next-20250912]
[cannot apply to dennis-percpu/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Uladzislau-Rezki-Sony/lib-test_vmalloc-add-no_block_alloc_test-case/20250915-214352
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250915134041.151462-11-urezki%40gmail.com
patch subject: [PATCH v2 10/10] mm/vmalloc: Update __vmalloc_node_range() documentation
config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20250916/202509160821.gR75Zhnh-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250916/202509160821.gR75Zhnh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509160821.gR75Zhnh-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: mm/vmalloc.c:3889 bad line: 

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


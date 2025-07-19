Return-Path: <linux-kernel+bounces-737707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568D0B0AF99
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 13:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 971AF582A7C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 11:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC632236E0;
	Sat, 19 Jul 2025 11:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EKd0b2JQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF71D221278;
	Sat, 19 Jul 2025 11:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752924551; cv=none; b=TuBm1hFMFMJbL7+GVet2MzWV8glscr9j/z/ZGgwAA9b46vEM8dU+fAUidM9WEmNBMI4rixonZ40Uwfe+X4vlR8d/j/xm+ofagINCcHZUxLJJlaDKL6OlMydLEejp7S7JKx1ZkGADJoY/5EvDypLMFkrGwTlMc5z2riNAYwmlv3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752924551; c=relaxed/simple;
	bh=Cy9pjvo9o1sugb4I0cfDyzykkSUFG6R+svA2UCozKws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YliWtIUN+TJd4JEAb3T8Cjpfmpa9jlFa7xjnLweM2VbQG9YlkpmIzrQqO1MFcahdBwKMn9oXKc/qqcuLrthUgblVz2gmMRzgZXcu3pUr6+Lw/ViMXaN8efQAPtSoJL3CKC+MXh/yCKmleVQwBRsSGoA4uxknFsG8C+2ndbvjnsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EKd0b2JQ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752924550; x=1784460550;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Cy9pjvo9o1sugb4I0cfDyzykkSUFG6R+svA2UCozKws=;
  b=EKd0b2JQZfhI6CKzMe9UGgyMY/e7ei+WsK0UbfuqnD0QhtmReIW9LQyq
   OrCL3w8Ee9qgAuZSNQYIjGXsU/L5URd+DI0Ql8e0bJ2a5WrzzeJWVWNDR
   i3lKQH5eQ3zilcAnBYbhL7ocZ+i7XGnvDUVSEUwJHW1fLbNTLXH2Tqkcz
   bcSZydGOuW2dX/YZMWnnrfZ8ZMIzP4mmINQbk4jPClhCxJoGtvD58NWqC
   aG+9VcSvNgTT1qTsE3Eazxn2irVt9DjeuHzkZEOvPv4zvn3LktNomCgUo
   nnyQvXL4Y+uBHM94LZa8Cn6+Ql0TKAHXPqps6FRJFXvUtKZP/VeICmvoZ
   A==;
X-CSE-ConnectionGUID: hRBmqWLSTOyLHv2dBQnL8g==
X-CSE-MsgGUID: mAfbnlq7TQOpIbvGiC8D1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="55058401"
X-IronPort-AV: E=Sophos;i="6.16,324,1744095600"; 
   d="scan'208";a="55058401"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2025 04:29:09 -0700
X-CSE-ConnectionGUID: ZjNNKKktSRucpl6nlv0sWA==
X-CSE-MsgGUID: XKT4BK0RT6yU74MkNWddxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,324,1744095600"; 
   d="scan'208";a="158091958"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 19 Jul 2025 04:29:06 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ud5kV-000FSV-1N;
	Sat, 19 Jul 2025 11:29:03 +0000
Date: Sat, 19 Jul 2025 19:28:52 +0800
From: kernel test robot <lkp@intel.com>
To: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>,
	robh@kernel.org, m.szyprowski@samsung.com, robin.murphy@arm.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	saravanak@google.com, quic_obabatun@quicinc.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, william.zhang@broadcom.com,
	kernel@oss.qualcomm.com, will@kernel.org, djakov@kernel.org,
	Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
Subject: Re: [PATCH v2] of: reserved_mem: Restructure call site for
 dma_contiguous_early_fixup()
Message-ID: <202507191943.suIkiLRK-lkp@intel.com>
References: <20250718234504.2702128-1-oreoluwa.babatunde@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718234504.2702128-1-oreoluwa.babatunde@oss.qualcomm.com>

Hi Oreoluwa,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.16-rc6 next-20250718]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oreoluwa-Babatunde/of-reserved_mem-Restructure-call-site-for-dma_contiguous_early_fixup/20250719-074651
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250718234504.2702128-1-oreoluwa.babatunde%40oss.qualcomm.com
patch subject: [PATCH v2] of: reserved_mem: Restructure call site for dma_contiguous_early_fixup()
config: i386-buildonly-randconfig-005-20250719 (https://download.01.org/0day-ci/archive/20250719/202507191943.suIkiLRK-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250719/202507191943.suIkiLRK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507191943.suIkiLRK-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/of/of_reserved_mem.c:152:1: warning: no previous prototype for function 'dma_contiguous_early_fixup' [-Wmissing-prototypes]
     152 | dma_contiguous_early_fixup(phys_addr_t base, unsigned long size)
         | ^
   drivers/of/of_reserved_mem.c:151:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     151 | void __weak
         | ^
         | static 
   1 warning generated.


vim +/dma_contiguous_early_fixup +152 drivers/of/of_reserved_mem.c

   150	
   151	void __weak
 > 152	dma_contiguous_early_fixup(phys_addr_t base, unsigned long size)
   153	{
   154	}
   155	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


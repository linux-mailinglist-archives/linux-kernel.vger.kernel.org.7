Return-Path: <linux-kernel+bounces-746726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D92DB12A79
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 14:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0A1AAA477A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 12:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328AB245022;
	Sat, 26 Jul 2025 12:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cRDDVga0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7ED1519BC
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 12:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753532923; cv=none; b=cT80DxYfd6ZbXq2oZYRaqKH8tofoBi+WVVMAbPVD0jDTqyy0UB28cyAATTCJY8yr53a5rjZjjy+zPZMquj0ozlUTvwmTlL3ChXqOsOGTQGE/zXC/OvUYvJgMo19YEedJ8d6QlzQgZMo8rE8ssBM/gGVlY64yTCcvywfCSGnRWog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753532923; c=relaxed/simple;
	bh=YuehmxuRyrlOSFHFQ1Yaiwvs0V5J3xcKU5wtDYfuFD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCxD3bntuLm8oa8IqO29S71lCcO1p2nK1Y+kDoNxFWXNdXy+IIHtLmc3Tl+AJIR5LRYw6aoTZlfXrngVu0hzsBUlTLx2qke5QCkvWXTiY5d1E6sxU6mBVk18oz2x4Zce2M3xpVfQowCrj3PSTVDNWDgFEjAPKuGJCvdim5N86fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cRDDVga0; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753532922; x=1785068922;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YuehmxuRyrlOSFHFQ1Yaiwvs0V5J3xcKU5wtDYfuFD8=;
  b=cRDDVga0+ws+iHE8oXbt45lrhdK4kO3xwPYplUgEftc2gGSuLAPocoMe
   vsXT718dKN8zdV/iQ6IHDGadIjDvdBM/B9deeGLq64r0QFN/fvTgN8Q6d
   Z65vaQy1QY5fjXUIyByimipAzaSeDpTRR4Zt3WMODNAnOlP/EVnWwCjQe
   RAFDv1KMbDPDIbSdXEtb0shi82qBDdqQB1OycyySOJDmYtS5RGUBUKEiD
   z5QGPdwEcfFiAeCTjDZdg4BIVymWPbk4HWWBZ0ZJxPySbzWfZmpn2a5HA
   LZd3bk/Vc7tXwF+i6ypRXAC5Wj1x2G/kiAx20ptQ66oct5C7GZv9rNPKB
   Q==;
X-CSE-ConnectionGUID: 1Oc8E2CdRB2R3oLCtG+67w==
X-CSE-MsgGUID: AnsUx5aaTMCy9TvMddAPVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="55728707"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="55728707"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2025 05:28:42 -0700
X-CSE-ConnectionGUID: 5Uj/GCTgTZixDUFLlL6+dA==
X-CSE-MsgGUID: xm1IdLMtToyO/jjJ0uKqVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="185223609"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 26 Jul 2025 05:28:40 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ufe0z-000Lyx-1i;
	Sat, 26 Jul 2025 12:28:37 +0000
Date: Sat, 26 Jul 2025 20:27:51 +0800
From: kernel test robot <lkp@intel.com>
To: Jia He <justin.he@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jia He <justin.he@arm.com>
Subject: Re: [PATCH] mm: percpu: Introduce normalized CPU-to-NUMA node
 mapping to  reduce max_distance
Message-ID: <202507262015.sw4niVFQ-lkp@intel.com>
References: <20250722041418.2024870-1-justin.he@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722041418.2024870-1-justin.he@arm.com>

Hi Jia,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Jia-He/mm-percpu-Introduce-normalized-CPU-to-NUMA-node-mapping-to-reduce-max_distance/20250722-121559
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250722041418.2024870-1-justin.he%40arm.com
patch subject: [PATCH] mm: percpu: Introduce normalized CPU-to-NUMA node mapping to  reduce max_distance
config: arm64-randconfig-r113-20250725 (https://download.01.org/0day-ci/archive/20250726/202507262015.sw4niVFQ-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 10.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250726/202507262015.sw4niVFQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507262015.sw4niVFQ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/base/arch_numa.c:154:12: sparse: sparse: symbol 'early_cpu_to_norm_node' was not declared. Should it be static?

vim +/early_cpu_to_norm_node +154 drivers/base/arch_numa.c

   153	
 > 154	int __init early_cpu_to_norm_node(int cpu)
   155	{
   156		return cpu_to_norm_node_map[cpu];
   157	}
   158	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


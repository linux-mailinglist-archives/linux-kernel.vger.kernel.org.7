Return-Path: <linux-kernel+bounces-741552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBE0B0E5A9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 23:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94DD13B2160
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB222286429;
	Tue, 22 Jul 2025 21:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Op1G5WdA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D654028541F
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 21:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753220449; cv=none; b=B6bClvjB2omrouF+R97OYNaiM2VkMWgIRzMDBNrpu28s3hZXjU+4Q8hVW1v7i8AmBjhLD3O7GWojykiT32tIDC/f0PrjBvs0zFbIw2RVFcvZTMrWgAjcC1HQWYad3Ocl+F2Lq3/8PdtG5CgmJnkrEQgV4VLbvDv7QsXAXgaEV1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753220449; c=relaxed/simple;
	bh=qiReswE8/+4iVK+wineobsk/lyxBNtH9smHzwQ1PNpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tx+0k8+sZWHrdHkfXmM14CsmvlCpIK98w2QEl/ZaLr/JxF+ogUC2dVzeGMn9I3ElsWtxDlrBOZfrVGunVwz3sEPeT7zWq/g5CvSgpDeYheK+0e1xSWsTtmnEjl7taAhRGExkhMUOfLOZSsh9tyfGZorSAGpS/jmbUncIIQ8T+10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Op1G5WdA; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753220448; x=1784756448;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qiReswE8/+4iVK+wineobsk/lyxBNtH9smHzwQ1PNpQ=;
  b=Op1G5WdAMiVDNjBRQ69+346oEMexqt/pQfzVdXBRIiGFTGu7nboB8o9o
   UmlWLEoWRB/EMpamGrCMFKtJgyBXKR7NlyG4vfP3eqQ7TcVsCf5vjbRAR
   W//pRrYVP0ODGgJjU6QWqSwA6Mi48RpjiShDqdtLITjYjCHmMxa8H9sEs
   F9A9+q/jhD1V5tmn4E7qgUkPcPh6B1C2QS00MBYBcG+JTLc8WNfmT8VzH
   j01xrZQ3Ix1das7Vh8ii9GNA/RSQFIaSyJLlxxS719pc502dkQwMAzpkZ
   fDW9+jbIEbrKIKfbp88LrRStb2PFs39kCuuJvd9eLNePJZ8e+rPUes7xV
   Q==;
X-CSE-ConnectionGUID: tX+dW7psQeCl7+aLsrXJfg==
X-CSE-MsgGUID: rzkk6jX6R12AfTiEbCD3lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="66829971"
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="66829971"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 14:40:47 -0700
X-CSE-ConnectionGUID: IYD1rorpRraSq8kzCk+mCQ==
X-CSE-MsgGUID: k+VwqMUtSM6o59wVqaBPuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="196340436"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 22 Jul 2025 14:40:45 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ueKj4-000IjH-36;
	Tue, 22 Jul 2025 21:40:42 +0000
Date: Wed, 23 Jul 2025 05:40:04 +0800
From: kernel test robot <lkp@intel.com>
To: Jia He <justin.he@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Jia He <justin.he@arm.com>
Subject: Re: [PATCH] mm: percpu: Introduce normalized CPU-to-NUMA node
 mapping to  reduce max_distance
Message-ID: <202507230509.juShbryQ-lkp@intel.com>
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
config: arm64-randconfig-001-20250722 (https://download.01.org/0day-ci/archive/20250723/202507230509.juShbryQ-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 853c343b45b3e83cc5eeef5a52fc8cc9d8a09252)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250723/202507230509.juShbryQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507230509.juShbryQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/base/arch_numa.c:154:12: warning: no previous prototype for function 'early_cpu_to_norm_node' [-Wmissing-prototypes]
     154 | int __init early_cpu_to_norm_node(int cpu)
         |            ^
   drivers/base/arch_numa.c:154:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     154 | int __init early_cpu_to_norm_node(int cpu)
         | ^
         | static 
   1 warning generated.


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


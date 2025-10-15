Return-Path: <linux-kernel+bounces-853713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F49BDC64A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6756D404025
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 04:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2886A2DF139;
	Wed, 15 Oct 2025 04:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LfNDFY7k"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1052B1A23B9
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760500965; cv=none; b=NoLVtt1BywDXq5hp2CDrDODxCwKL/FSHxJAPDcfjUWJlkfU/HDGiupHJpHwtySS5b0LSnykZpcxwA0msWiz+qBjX4AzfBiZ6vr2umRMSr/JMj32RnKj5I+Cb9ZSp7kFw42o1uymWjd3lJMqQisgNd+tg1l14ksNmcvAXjLzHapw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760500965; c=relaxed/simple;
	bh=IPYoc3DHk1NL/YolvyR0cWS69iUjEEZ5j0JF14Po0+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dbniarbcu69ZXMyQ7n+coe96qarUveKv0o+MnvikFHq/4d6Z0cGRrGS7zpQD5n/I4lyClveCbjm3MHAsJYR+WgGPIBT94+f2AGNgqmtaLF6vVmnP8wgLun/1aoIzoGSxpaA35bs4sfoQJpWvsd3q9pAVgtlpfwTJMBORN9ggKj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LfNDFY7k; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760500964; x=1792036964;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IPYoc3DHk1NL/YolvyR0cWS69iUjEEZ5j0JF14Po0+4=;
  b=LfNDFY7k620FmB66lX03y/IdjLx7lvRoizhO21aQsjU+v4JpcBPJo1Nh
   nzBeSoXdwrgOKDK7snC2gh7cYHsih67GnX2v08jJNtipszbXQatCOLNay
   BgTMX1v+YTP0nTYn9DuDvJ3UyJSqX5CLvdDoZ5eY13HJfRmjINKc0JF1P
   t+7kh22Pf2qYX5l5KZz1N+LFgMT7d4AbsHnZhbQtYVxranylyGcnDeGEo
   PfwzVLd+Dql96wzwBPN5uIC/rYgObV5xJwK3+EEWlvm9z9P+AEcoHdxqN
   rjsc3AT8Qg8S9d+sO2fbeZGBNQwLJcx99WSn11fiD3g/1b1cJ+WMOIx4d
   w==;
X-CSE-ConnectionGUID: vYAXrV1uQQuHn4moBF4/JQ==
X-CSE-MsgGUID: xpn9RGRSSUu9QyIquREnZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="66318629"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="66318629"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 21:02:43 -0700
X-CSE-ConnectionGUID: NvEnqguAR3Kd7fzemWuaVg==
X-CSE-MsgGUID: CSuUhS57SgWXI2/is1sSHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="181733557"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 14 Oct 2025 21:02:40 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v8shN-0003QH-2q;
	Wed, 15 Oct 2025 04:01:40 +0000
Date: Wed, 15 Oct 2025 11:53:45 +0800
From: kernel test robot <lkp@intel.com>
To: Donet Tom <donettom@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Mike Rapoport <rppt@kernel.org>, Oscar Salvador <osalvador@suse.de>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org,
	Danilo Krummrich <dakr@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Donet Tom <donettom@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] drivers/base/node: Fold register_node() into
 register_one_node()
Message-ID: <202510151130.JYajIJuM-lkp@intel.com>
References: <910853c9dd61f7a2190a56cba101e73e9c6859be.1760097207.git.donettom@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <910853c9dd61f7a2190a56cba101e73e9c6859be.1760097207.git.donettom@linux.ibm.com>

Hi Donet,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on powerpc/fixes linus/master v6.18-rc1 next-20251014]
[cannot apply to driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus powerpc/next tip/x86/mm rppt-memblock/for-next rppt-memblock/fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Donet-Tom/drivers-base-node-Fold-register_node-into-register_one_node/20251015-000850
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/910853c9dd61f7a2190a56cba101e73e9c6859be.1760097207.git.donettom%40linux.ibm.com
patch subject: [PATCH v2 1/2] drivers/base/node: Fold register_node() into register_one_node()
config: s390-randconfig-001-20251015 (https://download.01.org/0day-ci/archive/20251015/202510151130.JYajIJuM-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251015/202510151130.JYajIJuM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510151130.JYajIJuM-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/base/node.c:889 function parameter 'nid' not described in 'register_node'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


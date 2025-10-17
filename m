Return-Path: <linux-kernel+bounces-857488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FC1BE6F01
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42B054ED49A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 07:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0231FE45D;
	Fri, 17 Oct 2025 07:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RhFD5Foi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94195186E2E
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 07:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760686216; cv=none; b=QS6EOgnzhunFUhiHWGmAh2au/a8lKaL3e07m8oVkrHPHlA7iHR/kR6nS4X5Sn9OcgpFXH+S0MKkQVmrR52Rj7ocEiHLOoJnSNW7tYWZ4bzOa7eOkIxqLPI09n3a12XFjA2sIF1EYRNsVm9Ktics7nzrDVMz0CZjh7ySJGRXP2SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760686216; c=relaxed/simple;
	bh=94q7hjUFhw+N6XCp7Xyj+iOAYOIaGt7n4W8/rmeaHOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgAdc8cxqIlz64ectXPiy/m8r89Wf56ZvxrWp2CHpIUrOuHp8pCdd8i3R8E0ZamorEnjGQvpDL1sFW4fdOTGdotewWZIkhPCwVG86GqstnMYuzFJxp+59Al351sRBWVwevn6nI4yJ9TWGUlSMvpsbh1nIxm4mKVRzYKyGMittwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RhFD5Foi; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760686215; x=1792222215;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=94q7hjUFhw+N6XCp7Xyj+iOAYOIaGt7n4W8/rmeaHOc=;
  b=RhFD5FoiXlMVZiRAg7szO9DCk8NkyyfyvxjAG/jKaVlKYE6LBjaP0Z39
   6qPC/Pf2CGqr1eZqCcPmEAH0jGGyKwIbvJ3yUH1MoAQgP4/C5uzxfTqrL
   mSAMb6bZ9ke5uDo2shy36AK7Ez4A/HuTLRqBrZKPMFbyviRzY1QFTcQJ8
   /DQxzjwJTgTGgD4wfCK3TJ/u2gr2IxnJdm9uY0spfVXpnLFxOEwT01C3c
   qWB5ie8AXkCiNKzSRsPmxEGIeNPzjbtCfvUeoZxi4sE8oz6fNBP6Qzatn
   NDgyUdjAtV4CoPboZrKk6JkKoea+K31cavcAeiJKrjy2UsB9JVZHYTg2p
   A==;
X-CSE-ConnectionGUID: UjKcKfe4TRK1is7x9vzMuw==
X-CSE-MsgGUID: h9S35Yf7RXazsEl0+RHpQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="62796115"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="62796115"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 00:30:14 -0700
X-CSE-ConnectionGUID: FjfG6+ENSBqjWfhcEE3+Tw==
X-CSE-MsgGUID: INzcuHrrSuyWuqA7vQsI+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="206378759"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 17 Oct 2025 00:30:12 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9eug-0005h3-1C;
	Fri, 17 Oct 2025 07:30:10 +0000
Date: Fri, 17 Oct 2025 15:28:41 +0800
From: kernel test robot <lkp@intel.com>
To: XueBing Chen <chenxb_99091@126.com>, akpm@linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	XueBing Chen <chenxb_99091@126.com>
Subject: Re: [PATCH] lib/bsearch: add mutex protection for thread-safe binary
 search
Message-ID: <202510171538.n1mAFlu0-lkp@intel.com>
References: <20251016090640.6331-1-chenxb_99091@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016090640.6331-1-chenxb_99091@126.com>

Hi XueBing,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-nonmm-unstable]
[also build test WARNING on akpm-mm/mm-everything linus/master v6.18-rc1 next-20251016]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/XueBing-Chen/lib-bsearch-add-mutex-protection-for-thread-safe-binary-search/20251016-171911
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-nonmm-unstable
patch link:    https://lore.kernel.org/r/20251016090640.6331-1-chenxb_99091%40126.com
patch subject: [PATCH] lib/bsearch: add mutex protection for thread-safe binary search
config: arm-randconfig-r121-20251017 (https://download.01.org/0day-ci/archive/20251017/202510171538.n1mAFlu0-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251017/202510171538.n1mAFlu0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510171538.n1mAFlu0-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> lib/bsearch.c:34:1: sparse: sparse: symbol 'cmp_mutex' was not declared. Should it be static?

vim +/cmp_mutex +34 lib/bsearch.c

    15	
    16	/*
    17	 * bsearch - binary search an array of elements
    18	 * @key: pointer to item being searched for
    19	 * @base: pointer to first element to search
    20	 * @num: number of elements
    21	 * @size: size of each element
    22	 * @cmp: pointer to comparison function
    23	 *
    24	 * This function does a binary search on the given array.  The
    25	 * contents of the array should already be in ascending sorted order
    26	 * under the provided comparison function.
    27	 *
    28	 * Note that the key need not have the same type as the elements in
    29	 * the array, e.g. key could be a string and the comparison function
    30	 * could compare the string with the struct's name field.  However, if
    31	 * the key and elements in the array are of the same type, you can use
    32	 * the same comparison function for both sort() and bsearch().
    33	 */
  > 34	DEFINE_MUTEX(cmp_mutex);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


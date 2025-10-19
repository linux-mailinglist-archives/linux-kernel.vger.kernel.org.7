Return-Path: <linux-kernel+bounces-859519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9453FBEDE25
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 06:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D033A4E28A1
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 04:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303C61F0E34;
	Sun, 19 Oct 2025 04:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pi8nvd+/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63211AF0AF
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 04:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760848168; cv=none; b=Bjl+AwZ78AmThlMbiWuP5zE7Snm6aQwrFXEYgTJ+qamtzOzr7ILBiHhBZ8JHwfc7qqreSDgct0qPxVpyR7Adn/vRZxIwSxxab+hpiafmjKviqbdyQ2kYLLCV4lE60GhHwk4OqB/LzpTIwewcuxhxx36Oi0Z60vfPfTe1dGYXF8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760848168; c=relaxed/simple;
	bh=C3wkNQ8aUiQFEYO6K96oVISdonY8e8WxgeJ+l1eJKG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FI5mRvc1SGR0a3x6zrae7pRC0r1wRpNVOk3fAkyssOr6s92qaV8baYu49Iw2Q73lJP0HWKQhpXpgReM3fdh7oOX0LZvfTCnpHgtzdWXzQOcie1jbTvAKAZ2hxhWAACqrAalXjGjIa5TMnm8UVSNIqZprSymXUZpkBtd1SFXjG8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pi8nvd+/; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760848167; x=1792384167;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C3wkNQ8aUiQFEYO6K96oVISdonY8e8WxgeJ+l1eJKG8=;
  b=Pi8nvd+/JGjYSpbIDuMClR6FlnzHdWhzyKyMhLrOZeeqXRhgXmGfNgbo
   IyvtUknncYuCDzneLIGa6y08f0/JHJB8q7VjcmqObxPYcAkd69BU8egH0
   5BTqu5S++UIvvTHzVspgOGemRiIuBRwaf+s0Sgv99eWXyB6Bwa01KxkJm
   fBsANKMtnifFoToamfM5q8jpIVOHQHbZJlWFQlJtSIsEBPFIOia7174fi
   Jlp7dvex0FzW8tvapd942uy1kYaDGDucstZRbmBVxGbaqiOtlQdX9tcag
   69VWXVOzM0q2Qpc4dBjBeKbHq7j0Tpaf3NSbeV7Is3EmCHivN+FHA9e+N
   g==;
X-CSE-ConnectionGUID: 4iFeDZMMS6uQ2BnMkwAXeQ==
X-CSE-MsgGUID: KAW0Zad/R4ujZ3pLkLboxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73292464"
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="73292464"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 21:29:26 -0700
X-CSE-ConnectionGUID: jv85oiWjSn6LROALMP62nA==
X-CSE-MsgGUID: YR+Am7CUSQuU+6q/H3HCuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="214030391"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 18 Oct 2025 21:29:24 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vAL2n-0008ph-2X;
	Sun, 19 Oct 2025 04:29:21 +0000
Date: Sun, 19 Oct 2025 12:28:56 +0800
From: kernel test robot <lkp@intel.com>
To: Qinxin Xia <xiaqinxin@huawei.com>, 21cnbao@gmail.com,
	m.szyprowski@samsung.com, robin.murphy@arm.com
Cc: oe-kbuild-all@lists.linux.dev, prime.zeng@huawei.com,
	fanghao11@huawei.com, linux-kernel@vger.kernel.org,
	linuxarm@huawei.com, xiaqinxin@huawei.com, wangzhou1@hisilicon.com
Subject: Re: [PATCH v2] tools/dma: move dma_map_benchmark from selftests to
 tools/dma
Message-ID: <202510191133.ThgrGhqL-lkp@intel.com>
References: <20251018101402.3079372-1-xiaqinxin@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018101402.3079372-1-xiaqinxin@huawei.com>

Hi Qinxin,

kernel test robot noticed the following build errors:

[auto build test ERROR on shuah-kselftest/next]
[also build test ERROR on shuah-kselftest/fixes linus/master v6.18-rc1 next-20251017]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qinxin-Xia/tools-dma-move-dma_map_benchmark-from-selftests-to-tools-dma/20251018-181628
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/20251018101402.3079372-1-xiaqinxin%40huawei.com
patch subject: [PATCH v2] tools/dma: move dma_map_benchmark from selftests to tools/dma
config: x86_64-buildonly-randconfig-002-20251019 (https://download.01.org/0day-ci/archive/20251019/202510191133.ThgrGhqL-lkp@intel.com/config)
compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251019/202510191133.ThgrGhqL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510191133.ThgrGhqL-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
>> ./usr/include/linux/map_benchmark.h:19:9: error: unknown type name '__u64'
      19 |         __u64 avg_map_100ns; /* average map latency in 100ns */
         |         ^~~~~
   ./usr/include/linux/map_benchmark.h:20:9: error: unknown type name '__u64'
      20 |         __u64 map_stddev; /* standard deviation of map latency */
         |         ^~~~~
   ./usr/include/linux/map_benchmark.h:21:9: error: unknown type name '__u64'
      21 |         __u64 avg_unmap_100ns; /* as above */
         |         ^~~~~
   ./usr/include/linux/map_benchmark.h:22:9: error: unknown type name '__u64'
      22 |         __u64 unmap_stddev;
         |         ^~~~~
>> ./usr/include/linux/map_benchmark.h:23:9: error: unknown type name '__u32'
      23 |         __u32 threads; /* how many threads will do map/unmap in parallel */
         |         ^~~~~
   ./usr/include/linux/map_benchmark.h:24:9: error: unknown type name '__u32'
      24 |         __u32 seconds; /* how long the test will last */
         |         ^~~~~
>> ./usr/include/linux/map_benchmark.h:25:9: error: unknown type name '__s32'
      25 |         __s32 node; /* which numa node this benchmark will run on */
         |         ^~~~~
   ./usr/include/linux/map_benchmark.h:26:9: error: unknown type name '__u32'
      26 |         __u32 dma_bits; /* DMA addressing capability */
         |         ^~~~~
   ./usr/include/linux/map_benchmark.h:27:9: error: unknown type name '__u32'
      27 |         __u32 dma_dir; /* DMA data direction */
         |         ^~~~~
   ./usr/include/linux/map_benchmark.h:28:9: error: unknown type name '__u32'
      28 |         __u32 dma_trans_ns; /* time for DMA transmission in ns */
         |         ^~~~~
   ./usr/include/linux/map_benchmark.h:29:9: error: unknown type name '__u32'
      29 |         __u32 granule;  /* how many PAGE_SIZE will do map/unmap once a time */
         |         ^~~~~
>> ./usr/include/linux/map_benchmark.h:30:9: error: unknown type name '__u8'
      30 |         __u8 expansion[76]; /* For future use */
         |         ^~~~

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


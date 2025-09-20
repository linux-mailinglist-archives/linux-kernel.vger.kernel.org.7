Return-Path: <linux-kernel+bounces-825663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 044CFB8C739
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 13:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4A551BC519B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 11:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DC42FFF85;
	Sat, 20 Sep 2025 11:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gtEQu+pY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7137D2FFDC1
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 11:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758369417; cv=none; b=hwRHkc+LoBc6W2OF4CnhbbLlMGDKid8WqFsr9YxMZFv5wRFpqxsYRELXwgVBm/D+uVWDjJTejSI26fDmdul00BN9+N3tePtBZEiRpneNKkfX4S37cm5/dTZULaOR/iHoF8evmxAgzJ4KW4LEV2+gUK8Z1tBOydp3qS755GbYpOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758369417; c=relaxed/simple;
	bh=8eIVJEoHUAIRvD1gg14WYcW9cJd5BsuqTZpTJujtgI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OW3UWa6s7wg21i16o5SDB+JB3OJBxe+D0fy4M1BD70xsfsqz9wOYJhQ5RegjyhmIvuScaF6TnGTMDtwdHSS3ERlufXAg9XNKUSP2iVK2Vb2I/ExxA0BxapODg4+zF5HrM4Eevu20vykZnUScBImBe/yf7g1Uo335fKiW6mt2pno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gtEQu+pY; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758369415; x=1789905415;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8eIVJEoHUAIRvD1gg14WYcW9cJd5BsuqTZpTJujtgI8=;
  b=gtEQu+pYu0IsAfXJ37pAigx5B4FPiP08hJQUwBkhiYT/zhfERwEtplCd
   FQR2d5Nf2H/QiuBcQ/UYTENh6HvyDJfGBihf5gEel8nEy11s3IMo+e0xk
   H6xmWybEwXi+//WUPO98UozHXeqLviXcpVINZTLYyPv+9JwrBOSIcrZIy
   B9ObdkDpFipSUHjbnBfPzoW9e/im0b7skeCti0fETukC8AY0fzz7+QFoV
   tKbfmgL9oUTsNb9Zd0vfivtNzbpxSm7TK1mCeXELxbO4D02vLvyfk3gS5
   +koamBD9MmxPDJ+xMUtYcf4BftbkRsn1L81ROAyileVN7kArcdAZ7NXzJ
   Q==;
X-CSE-ConnectionGUID: 5pDPtswUS6qPUQ0+0cvH2A==
X-CSE-MsgGUID: 9SrhpDloSzaGs43T0xsjVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="63328304"
X-IronPort-AV: E=Sophos;i="6.18,280,1751266800"; 
   d="scan'208";a="63328304"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2025 04:56:54 -0700
X-CSE-ConnectionGUID: GdGMHqegT/ekI/kvtyvU7Q==
X-CSE-MsgGUID: yhVq0D/mS1S/k52k8buX+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,280,1751266800"; 
   d="scan'208";a="176872093"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 20 Sep 2025 04:56:52 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uzwCw-0005J9-06;
	Sat, 20 Sep 2025 11:56:50 +0000
Date: Sat, 20 Sep 2025 19:55:57 +0800
From: kernel test robot <lkp@intel.com>
To: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, jgg@ziepe.ca, praan@google.com,
	Mostafa Saleh <smostafa@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 4/4] iommu/io-pgtable-arm-selftests: Use KUnit
Message-ID: <202509201953.E4CkTm6w-lkp@intel.com>
References: <20250919133316.2741279-5-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919133316.2741279-5-smostafa@google.com>

Hi Mostafa,

kernel test robot noticed the following build warnings:

[auto build test WARNING on soc/for-next]
[also build test WARNING on linus/master v6.17-rc6 next-20250919]
[cannot apply to joro-iommu/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mostafa-Saleh/iommu-io-pgtable-arm-Simplify-error-prints-for-selftests/20250919-213912
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20250919133316.2741279-5-smostafa%40google.com
patch subject: [PATCH v3 4/4] iommu/io-pgtable-arm-selftests: Use KUnit
config: xtensa-randconfig-002-20250920 (https://download.01.org/0day-ci/archive/20250920/202509201953.E4CkTm6w-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250920/202509201953.E4CkTm6w-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509201953.E4CkTm6w-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: drivers/iommu/io-pgtable-arm-selftests: section mismatch in reference: 0x84 (section: .text.unlikely) -> arm_lpae_dump_ops (section: .init.text)
>> WARNING: modpost: drivers/iommu/io-pgtable-arm-selftests: section mismatch in reference: arm_lpae_run_tests+0xa6 (section: .text.unlikely) -> arm_lpae_dump_ops (section: .init.text)
ERROR: modpost: "alloc_io_pgtable_ops" [drivers/iommu/io-pgtable-arm-selftests.ko] undefined!
ERROR: modpost: "free_io_pgtable_ops" [drivers/iommu/io-pgtable-arm-selftests.ko] undefined!

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for IOMMU_IO_PGTABLE_LPAE
   Depends on [n]: IOMMU_SUPPORT [=y] && (ARM || ARM64 || COMPILE_TEST [=y]) && !GENERIC_ATOMIC64 [=y]
   Selected by [m]:
   - IOMMU_IO_PGTABLE_LPAE_KUNIT_TEST [=m] && IOMMU_SUPPORT [=y] && KUNIT [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


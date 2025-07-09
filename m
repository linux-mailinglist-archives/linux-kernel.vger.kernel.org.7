Return-Path: <linux-kernel+bounces-722804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB052AFDF2E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 07:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0339C3A973D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 05:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD1326A1A4;
	Wed,  9 Jul 2025 05:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PJibutz8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBFE18A6AE;
	Wed,  9 Jul 2025 05:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752038401; cv=none; b=doC6MSM0dSr8K80a09vqwb4bsG7tjqjysoyqYLK1vdV3SmxvMERuXpihszzRrrcbEflZzFqcZg1nFiUqezvuCCNx80jGNyqUt2h+f2uXGIIBsRBzsxlztY1Y/qrMWj7JWuid9Ah4f0FykXeyStVORsDHiBYlVcvNJ/Z2VmV66nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752038401; c=relaxed/simple;
	bh=1HKYQB+6U3/FZmF5kwiWOis/cLTGRKWllXiKrhif0Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LE2zge96bJYg1qyCrcZk8cCOBHBJ3qIdZVQGti96dVzRThBoVKwblUAv+kDegjBDFB8hlKYxxpeFjQkh3ADPbs9UTCs3yrmw0sLkE/Q7vEyo5C7lyFyWS5oJ9rLUO2vIsgKn0XucK8x9RxwvzkgtOrhgbeHCI6gbLVUekledpKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PJibutz8; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752038400; x=1783574400;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1HKYQB+6U3/FZmF5kwiWOis/cLTGRKWllXiKrhif0Qw=;
  b=PJibutz8ik2fFkmQq4jG6GiZCr84V7Osqa67qvLbOA82sak43bzBsBRz
   pGH+8bniYKFY72pVFd8QxpIzCX3y0VdqXofDvP5KMj2h1rAtKm8oBTjMg
   oYmLigpn1+IT5hJqHzaV4n4TL+uwD6gcmwWPUrgF5FSdgGYeJruw6DPMI
   YmlBQ9lOBOwsgE0HUjAAoVsaGnsO5+ug61Ub/HmqACrB/315NpdXiPUpM
   4YHNYdwuOUc5mJkeBRQ7e7H2//kDPj1dK8dLUo6hk2pFIkq8NECeSYShl
   tJuM+FGlQrtdfbs/bMKLqissOFV//899n3L0VreNn/t4zXwaV8BaQndUn
   Q==;
X-CSE-ConnectionGUID: dicLeFJHR52O0Wx0BG0q5A==
X-CSE-MsgGUID: Gmu7FcAVTgKEkcK2S6mODg==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54260372"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54260372"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:07:45 -0700
X-CSE-ConnectionGUID: 8ZHutkv5QRSldcFywYFZPw==
X-CSE-MsgGUID: MkqBmEq1Sz2Chj2bZ5VnCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="159986231"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 08 Jul 2025 22:07:42 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uZN1v-00036x-1O;
	Wed, 09 Jul 2025 05:07:39 +0000
Date: Wed, 9 Jul 2025 13:07:25 +0800
From: kernel test robot <lkp@intel.com>
To: Yao Zi <ziyao@disroot.org>, Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
	Yangtao Li <frank.li@vivo.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yao Zi <ziyao@disroot.org>
Subject: Re: [PATCH] clk: thead: th1520-ap: Correctly refer the parent for
 c910 and osc_12m
Message-ID: <202507091214.BjAuy5rw-lkp@intel.com>
References: <20250705052028.24611-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250705052028.24611-1-ziyao@disroot.org>

Hi Yao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on linus/master v6.16-rc5 next-20250708]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yao-Zi/clk-thead-th1520-ap-Correctly-refer-the-parent-for-c910-and-osc_12m/20250705-132237
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20250705052028.24611-1-ziyao%40disroot.org
patch subject: [PATCH] clk: thead: th1520-ap: Correctly refer the parent for c910 and osc_12m
config: riscv-randconfig-r131-20250709 (https://download.01.org/0day-ci/archive/20250709/202507091214.BjAuy5rw-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 15.1.0
reproduce: (https://download.01.org/0day-ci/archive/20250709/202507091214.BjAuy5rw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507091214.BjAuy5rw-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   WARNING: invalid argument to '-march': '_zacas_zabha'
>> drivers/clk/thead/clk-th1520-ap.c:585:25: sparse: sparse: symbol 'osc12m_clk' was not declared. Should it be static?

vim +/osc12m_clk +585 drivers/clk/thead/clk-th1520-ap.c

   584	
 > 585	struct clk_fixed_factor osc12m_clk = {
   586		.div		= 2,
   587		.mult		= 1,
   588		.hw.init	= CLK_HW_INIT_PARENTS_DATA("osc_12m",
   589							   osc_24m_clk,
   590							   &clk_fixed_factor_ops,
   591							   0),
   592	};
   593	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


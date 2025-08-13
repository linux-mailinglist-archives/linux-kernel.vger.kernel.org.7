Return-Path: <linux-kernel+bounces-765835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6F8B23EEA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 05:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEB101A28615
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 03:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656DD2BDC32;
	Wed, 13 Aug 2025 03:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RwijmR8r"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241F529E101;
	Wed, 13 Aug 2025 03:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755055303; cv=none; b=tyOVR3bM+yP0DDvNt9TH17JQGX1z4AGRDpQQdDb75yAIEgJf71i54CbMU+Gd0WIhcizf7r3bShwypGKv7GaG8mtKBfvCyfVKfdcvXTv6R4Ne+pwvNnm3wTIhKNAv0FhUsdSv3xmXHvem+8hO96mcID6zxDoCJMzIOYaBjUaSlqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755055303; c=relaxed/simple;
	bh=FJ3uPrxwG00g76QIbGSTYDKnWQuCo1IHVqFcVwiujF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWPZFBm1SA6CS54Dm8BXbGoIIt565+bn7jeJxhMm3qAlK6A4mPYlayfwp5SSu58ocFuNfOsZNbFEqgFrGpHXYfgGEyTQZvs6/juh2iIMeshVx4BJOr4LE7kWgjb5exMXnaFZn4scYIeQvdoLxo0muTXjI0MMFUJ4P3G+uGGMNrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RwijmR8r; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755055302; x=1786591302;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FJ3uPrxwG00g76QIbGSTYDKnWQuCo1IHVqFcVwiujF0=;
  b=RwijmR8rQSza60KMbn3UCk3IKtdVBgUnobl6OAVah9czcLBgGmEPXlrb
   f8sjLLQDD4fQEhWy7prVEmg3/NuHbSxLJuRYOX2yjwlDNlB8YcAYgNQFK
   vBuo3DHhN8LFgMjy+JfnmjFEREFxLOLePgPEof6ANWDs6MnWCD50ZXwXW
   s2DzysBKa+pOyz5/hJL9neHctgEPMDnYVx4WesLbZx54MnpmuShhkU+mI
   QVUsxowWK7Q8imDrnpZsK4JpL2Rdc42eTHZtKAqhfBA82aPqgLiKwX3KQ
   JqdF5gflzVn4mx7zBAvNIHTFaxEKpoFvhvNxEWVzGwoQ3lqXL80pmtAxM
   w==;
X-CSE-ConnectionGUID: YLuAJ6c/TTSAgsRbuTfmWQ==
X-CSE-MsgGUID: pI8t850ITJexTtrjQVsKNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="74789381"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="74789381"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 20:21:42 -0700
X-CSE-ConnectionGUID: 84Cqx6gLT7a+m83CS2tacA==
X-CSE-MsgGUID: AYDpHQp6RoyvGKKPg8xa/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="170565614"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 12 Aug 2025 20:21:39 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1um23E-0009Ui-38;
	Wed, 13 Aug 2025 03:21:26 +0000
Date: Wed, 13 Aug 2025 11:21:05 +0800
From: kernel test robot <lkp@intel.com>
To: Chen-Yu Tsai <wenst@chromium.org>, Stephen Boyd <sboyd@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Chen-Yu Tsai <wenst@chromium.org>,
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] clk: Use hashtable for global clk lookups
Message-ID: <202508131125.ohtCwp4k-lkp@intel.com>
References: <20250812085328.3306705-2-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812085328.3306705-2-wenst@chromium.org>

Hi Chen-Yu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on linus/master v6.17-rc1 next-20250812]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chen-Yu-Tsai/clk-Use-hashtable-for-global-clk-lookups/20250812-171958
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20250812085328.3306705-2-wenst%40chromium.org
patch subject: [PATCH 2/2] clk: Use hashtable for global clk lookups
config: microblaze-randconfig-r131-20250813 (https://download.01.org/0day-ci/archive/20250813/202508131125.ohtCwp4k-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250813/202508131125.ohtCwp4k-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508131125.ohtCwp4k-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/clk/clk.c:40:1: sparse: sparse: symbol 'clk_hashtable' was not declared. Should it be static?

vim +/clk_hashtable +40 drivers/clk/clk.c

    38	
    39	#define CLK_HASH_BITS 9
  > 40	DEFINE_HASHTABLE(clk_hashtable, CLK_HASH_BITS);
    41	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


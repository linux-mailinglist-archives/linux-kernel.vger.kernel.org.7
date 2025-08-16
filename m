Return-Path: <linux-kernel+bounces-771615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B3AB2897E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 02:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B5D9AC727C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 00:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42A8770FE;
	Sat, 16 Aug 2025 00:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i6UxfmZ3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D3D9478
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 00:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755305869; cv=none; b=M/K1U+mmw+3WGF3VPtmQInQdTdq9fRCs0LvpbxY3ZxJneGu9/zxJiRBBOJ9wDT3fuuCVLeu8tnuVH3t/6J/EYCTXfHXMkZ4BUPFEmkLHResGKxfEcNk/NNj+Kt+D+3nT5K0/ztzxuFKuGoeDf8ks3aN5ym+XRtIcJ9x8gO2VJlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755305869; c=relaxed/simple;
	bh=4yRdPc9V0nuMMCwNQ2HPQxK9Z42aO6f3cMEDFSNO1+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQ3k5FV+vSqXDqhnj95aob9mzCyU4+0HDlTVHtmfmNqwLv2uFG6DZnbYZeZcB8AzETvxEFLvFIFVQB8us33e7sAmh6uk8ksasvVSxnMLvtpe4LAmHAS607oCjojkQEUo8HLBSlQd89KVXS+fVzDc933QqU5eixG+AeIpC5oGUlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i6UxfmZ3; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755305867; x=1786841867;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4yRdPc9V0nuMMCwNQ2HPQxK9Z42aO6f3cMEDFSNO1+Q=;
  b=i6UxfmZ3ogqFSFPUOTADbTjyoZzY9ISKm/+JQn8RXW6UGyoX0N6DmReX
   gzbpIByaQOtQzGqjoJHFB2pJF7+6rYxOGuIempoNl/goMtbqh/Mj7BL35
   F3BK75kyp5fO1MbUUR9CtfIh1zegw/Uxrww6WNXo/BfsH2zh8/CokQ5BM
   TwzzaKNpkcsjDIJ4NZMUBB9PIXeaoLUds11b02mMa/iXq86hDP8dH7rwn
   AgbxQHcYWXmnLScFTKBOgn7NTJETU1cTKNibqUmiBc+wTFg0GDte5i97M
   S5hGlLK0IMss2cIB29wc9NhBMPT36Ti9yddoO83ASRNAISIJup6yDzjrs
   Q==;
X-CSE-ConnectionGUID: Qna4op8mS16t88a2fxojlw==
X-CSE-MsgGUID: aIFG6c3FQSuxarHpJAU59Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="57536984"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="57536984"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 17:57:45 -0700
X-CSE-ConnectionGUID: ZNfZxbMcR1S4D5xE0QuGTg==
X-CSE-MsgGUID: 0OScScgjQIa7s+TsDBG+WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="197985617"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 15 Aug 2025 17:57:43 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1un5Er-000CSo-1V;
	Sat, 16 Aug 2025 00:57:41 +0000
Date: Sat, 16 Aug 2025 08:57:27 +0800
From: kernel test robot <lkp@intel.com>
To: Huacai Chen <chenhuacai@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Harry Yoo <harry.yoo@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/migrate: Fix NULL movable_ops if CONFIG_ZSMALLOC=m
Message-ID: <202508160823.9dRNF1Rc-lkp@intel.com>
References: <20250815090539.1578484-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815090539.1578484-1-chenhuacai@loongson.cn>

Hi Huacai,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Huacai-Chen/mm-migrate-Fix-NULL-movable_ops-if-CONFIG_ZSMALLOC-m/20250815-170745
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250815090539.1578484-1-chenhuacai%40loongson.cn
patch subject: [PATCH] mm/migrate: Fix NULL movable_ops if CONFIG_ZSMALLOC=m
config: sparc-randconfig-001-20250816 (https://download.01.org/0day-ci/archive/20250816/202508160823.9dRNF1Rc-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250816/202508160823.9dRNF1Rc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508160823.9dRNF1Rc-lkp@intel.com/

All errors (new ones prefixed by >>):

   sparc-linux-ld: mm/zsmalloc.o: in function `zs_init':
>> mm/zsmalloc.c:2250:(.init.text+0x8): undefined reference to `zsmalloc_mops'
>> sparc-linux-ld: mm/zsmalloc.c:2250:(.init.text+0xc): undefined reference to `zsmalloc_mops'


vim +2250 mm/zsmalloc.c

  2246	
  2247	static int __init zs_init(void)
  2248	{
  2249	#ifdef CONFIG_MIGRATION
> 2250		movable_ops[MOVABLE_ZSMALLOC] = &zsmalloc_mops;
  2251	#endif
  2252	#ifdef CONFIG_ZPOOL
  2253		zpool_register_driver(&zs_zpool_driver);
  2254	#endif
  2255		zs_stat_init();
  2256		return 0;
  2257	}
  2258	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


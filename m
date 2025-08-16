Return-Path: <linux-kernel+bounces-772209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBEFB28FEB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 19:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67ECF5A62EC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 17:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA512FE057;
	Sat, 16 Aug 2025 17:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O9wS06PJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB52328D841
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 17:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755366216; cv=none; b=mQvs1ym9qy4SPt175I/vos6IXCErInr90TIZM1kFzsD2xgt8McfaLQvashhQmBZXbI+jspuCCVRocfDHaOCByaa+/cYx7MLb8OfpeQ1eFcFa/5kM6RDsgX0hDfolF4CGeYB0QjluMZB9RQlurDonyzrgOd5oJLp02GSKU5nRotU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755366216; c=relaxed/simple;
	bh=Y4+5jv9bJIBFZQ94IeivVBSbqAYFaK3hmZElluVcB6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYp+tGRjxntRbkYNAGylPAK1f8C2rI6ebb9uw2syOCz4Vu9nVk8QccBou0r76E4afphakR0tVKXlvW8oIax34OXjTb2jKQ2toASbpemqBvqmfS//UFd6CLUW4HP++18OtbjqSyQdax7gbRXQkCLxsOxwhYsajpKaa0bYw8lfxPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O9wS06PJ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755366214; x=1786902214;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y4+5jv9bJIBFZQ94IeivVBSbqAYFaK3hmZElluVcB6I=;
  b=O9wS06PJDYTtStLWB6b+FbXhSUcfg8vcaVbXC4aWITU5nCHt3Zc0A5GJ
   zu18m85ZgJym1KLIH3eFty6MrXmhG2yju4FCd7SFc6Fmp1YxTCeP8aO9t
   xlzI/7SV/k2sqa/GnLKWlWmRGnijoAO5k+ZCcWO437X2ptyvNG47u0gel
   pAWyw6Tg8fREql0lFeuuWSIQlgaGKBCHCM6jCGzPaqA20MlygG/Qk7s/M
   Wz6xUOEPG51KcGNDC77nGVSXaFOQSFzn8xugqVAIjjfebrTsehkNoE7f6
   09GIzal6G1r/0d9lWYNOjogmmoETj0tYNpPcCoLGlMsbGrQkfVrdSESDq
   A==;
X-CSE-ConnectionGUID: PrBFU6uPQomyMcihsDGd0g==
X-CSE-MsgGUID: DUzhg5BhSUybQJv1z32xrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="57729986"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="57729986"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2025 10:43:34 -0700
X-CSE-ConnectionGUID: u5fyoiCRSxqNtJTZgcMK7g==
X-CSE-MsgGUID: +IACfkfOQvyRdCq6GHi/iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="167621159"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 16 Aug 2025 10:43:31 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1unKvy-000D3o-2K;
	Sat, 16 Aug 2025 17:43:20 +0000
Date: Sun, 17 Aug 2025 01:42:33 +0800
From: kernel test robot <lkp@intel.com>
To: Huacai Chen <chenhuacai@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Harry Yoo <harry.yoo@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mm/migrate: Fix NULL movable_ops if CONFIG_ZSMALLOC=m
Message-ID: <202508170118.0VFEAq7Q-lkp@intel.com>
References: <20250816072149.1952348-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816072149.1952348-1-chenhuacai@loongson.cn>

Hi Huacai,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Huacai-Chen/mm-migrate-Fix-NULL-movable_ops-if-CONFIG_ZSMALLOC-m/20250816-152326
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250816072149.1952348-1-chenhuacai%40loongson.cn
patch subject: [PATCH V2] mm/migrate: Fix NULL movable_ops if CONFIG_ZSMALLOC=m
config: arm-randconfig-003-20250817 (https://download.01.org/0day-ci/archive/20250817/202508170118.0VFEAq7Q-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 93d24b6b7b148c47a2fa228a4ef31524fa1d9f3f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250817/202508170118.0VFEAq7Q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508170118.0VFEAq7Q-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/migrate.c:58:42: error: too few arguments provided to function-like macro invocation
      58 | EXPORT_SYMBOL_GPL_FOR_MODULES(movable_ops);
         |                                          ^
   include/linux/export.h:94:9: note: macro 'EXPORT_SYMBOL_GPL_FOR_MODULES' defined here
      94 | #define EXPORT_SYMBOL_GPL_FOR_MODULES(sym, mods) __EXPORT_SYMBOL(sym, "GPL", "module:" mods)
         |         ^
>> mm/migrate.c:58:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
      58 | EXPORT_SYMBOL_GPL_FOR_MODULES(movable_ops);
         | ^
         | int
   2 errors generated.


vim +58 mm/migrate.c

    57	
  > 58	EXPORT_SYMBOL_GPL_FOR_MODULES(movable_ops);
    59	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


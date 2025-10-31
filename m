Return-Path: <linux-kernel+bounces-880784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 404C1C268D3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 19:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 158F74E218C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66819351FC9;
	Fri, 31 Oct 2025 18:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cbx2sc0b"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016FE277013
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 18:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761935081; cv=none; b=XTHJwAwrhuV7sF2S7fNXfmiRjOLd5EVbFnVd4Pq3fqyAJ8fRHNLD3/R1wXTIBu8JjW3UMwKJZZwA0+IP6HB/yAaHfMbSg3A+hnZk6S2s7fxvua+pkiRMVF51jBRnVsyCDOEGyi04WOFVjusAYoJ3/F9p7Wb2AYd9nbSi4Q/mJ6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761935081; c=relaxed/simple;
	bh=2espfBKaEXR9ooZJUhynsBbxbOlStZ/Y6Q0tHqQ8/gE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BUPoPSIYsF3zlQlaxRjITy68p1CN7aBPui7oOK+rXyi9WBw8lQtU+ehTmgz8ClX0NnKBnhMQ64hs+YQCnV05/BjPjN4E/Q+z41EsVb1IHuIhGI+XKDUHwshCzDfCSBe75Kijm/+JsYkIWUTdPNybaoYu2ViD6wxRDIdO4kTgFHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cbx2sc0b; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761935080; x=1793471080;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2espfBKaEXR9ooZJUhynsBbxbOlStZ/Y6Q0tHqQ8/gE=;
  b=Cbx2sc0bWvQLzFxfUgMjsrK6ItkEHiMZj4sRjxRWMHJdAgzPIS9QJjtj
   b0qYcn4NGPY0m5AErhMnBDyxK3Epru27XMMoPQWLBPI0zOJZ72gTxc6qT
   0SG/mjwVs9TkZuzjhVhui2KO6wgGMBHeHigvGAy754y/0OowQoURw5jqP
   OfcYntGcPC9o0VVOoVkc4OqS0jW/N26lah5HhbfojvaJX+3amqZw5ec0B
   EBZMokabfncs0r+OSk0VAnqIvdmuMH7wuY7p6YLCqSg4yix+thLbO5tU/
   fRpLwje35NHiG/c3tVejuyOHzFTBUZRlhjeZwtkoIW/T111VHbNWdkLGe
   w==;
X-CSE-ConnectionGUID: wNs2jm7CRf+Fncz78JxFZw==
X-CSE-MsgGUID: +vZ+qbsGR+eT5vYX6wo9Vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="81731997"
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="81731997"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 11:24:39 -0700
X-CSE-ConnectionGUID: KvGSivJ/THu0a+YqiyR5sQ==
X-CSE-MsgGUID: yHB7rlV4TfCiUP/04vgoCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="185986972"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 31 Oct 2025 11:24:38 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vEtnf-000NYW-2a;
	Fri, 31 Oct 2025 18:24:35 +0000
Date: Sat, 1 Nov 2025 02:24:24 +0800
From: kernel test robot <lkp@intel.com>
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: arch/um/include/asm/kasan.h:29:2: error: #error UML does not work in
 KASAN_INLINE mode with STATIC_LINK enabled!
Message-ID: <202511010249.7L7FB7IA-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b909d77359b82821e1c6b6a3a8a51b355b06fdb5
commit: 1e338f4d99e6814ede16bad1db1cc463aad8032c kasan: introduce ARCH_DEFER_KASAN and unify static key across modes
date:   6 weeks ago
config: um-randconfig-r052-20251101 (https://download.01.org/0day-ci/archive/20251101/202511010249.7L7FB7IA-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251101/202511010249.7L7FB7IA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511010249.7L7FB7IA-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/kasan.h:21,
                    from include/linux/slab.h:260,
                    from include/linux/crypto.h:18,
                    from arch/x86/um/shared/sysdep/kernel-offsets.h:5,
                    from arch/um/kernel/asm-offsets.c:1:
>> arch/um/include/asm/kasan.h:29:2: error: #error UML does not work in KASAN_INLINE mode with STATIC_LINK enabled!
      29 | #error UML does not work in KASAN_INLINE mode with STATIC_LINK enabled!
         |  ^~~~~
   make[3]: *** [scripts/Makefile.build:182: arch/um/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1282: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +29 arch/um/include/asm/kasan.h

    27	
    28	#if defined(CONFIG_STATIC_LINK) && defined(CONFIG_KASAN_INLINE)
  > 29	#error UML does not work in KASAN_INLINE mode with STATIC_LINK enabled!
    30	#endif
    31	#else
    32	static inline void kasan_init(void) { }
    33	#endif /* CONFIG_KASAN */
    34	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


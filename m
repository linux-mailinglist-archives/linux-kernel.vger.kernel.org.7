Return-Path: <linux-kernel+bounces-750107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 665DCB1575E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 04:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85AEA561439
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 02:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA38918A93C;
	Wed, 30 Jul 2025 02:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MNe8rdnD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A45EED7
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 02:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753840971; cv=none; b=M08EwuR/pE8uyq1B0byngZiNEclcDTreQA+CqkMIh/YsTQczd+5OhsqZKOlkeGcof+w/hEs6k5Lvz8BiUUUR1M8brznfKR8UlOzTTa/rWknKpNJhKyMQgjAbxypl2uhHTyOPsKg8EiMLhnQeFg0xJvzqfOc3/x6sNLGuzp5Nc0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753840971; c=relaxed/simple;
	bh=E85IkhXBpgXIamGr8PggEgYjw9F7Qq0GsZrvNSgrNG4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tpJ/NbfjSLJJ73jfUA4WEtEtqUVctvoBUUClJdCGO1dwgo4fHDptCiwfJq64tcXQiH+RwUUgQCCmjWPNY1w1J3UXSY8cupEwsXGD68DDLWtDb9eEIDkp1Ft1uqu1dTx/NPbbGPgzA/QFQMI7dyXkNUoddeGNJoQe+V30BXwAx0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MNe8rdnD; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753840969; x=1785376969;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=E85IkhXBpgXIamGr8PggEgYjw9F7Qq0GsZrvNSgrNG4=;
  b=MNe8rdnDxnMATPdzWQ3ghqBgoLFb+/D8KcSirQe0zzMLYYvrk57Gj9oi
   A6/8lA6MZUFgYGDMERwkUcvaNHVLUTocpy7//9yyId+BK2v2pqUa7iXdq
   X4kEftvC08jksOsQavjd6LI5PB0aKuOFQTJLY07ElyOTpoWOYUwiWH7I7
   25Z+x6xiY6vOUq/s3vlKOGo7xFL1r+5G8wUpOxaN/b6EtxqOauRSWdalb
   xlYcTxvnzX5lTWHyoNzw+fhCClLPFXHvZDAKMP1Gvkb3uIEnmTFGQBY9F
   xglurBV7OE625qRVcH119YBqQQdHRr/Mxq10s/Gz74Vby8lU2BzvhdCYN
   A==;
X-CSE-ConnectionGUID: lBkfOOlaRNSgqplFq3HuZw==
X-CSE-MsgGUID: yaln6cgMQWC0LYCW0VbVfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="56276527"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="56276527"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 19:02:49 -0700
X-CSE-ConnectionGUID: vV/8I8DwR7y6hzfpdqlVxg==
X-CSE-MsgGUID: D/bzK4w/T5yuR2Bc2xEntw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="193709174"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 29 Jul 2025 19:02:47 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ugw9U-0001sJ-36;
	Wed, 30 Jul 2025 02:02:44 +0000
Date: Wed, 30 Jul 2025 10:01:54 +0800
From: kernel test robot <lkp@intel.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Alexander Potapenko <glider@google.com>
Subject: mm/kmsan/hooks.c:269:14: sparse: sparse: cast removes address space
 '__user' of expression
Message-ID: <202507300944.NePjNXZ2-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   14bed9bc81bae64db98349319f367bfc7dab0afd
commit: 3a8f6f3b469b4075919a3613e182f9a70df92d46 kmsan: enable on s390
date:   1 year, 1 month ago
config: s390-randconfig-r111-20250730 (https://download.01.org/0day-ci/archive/20250730/202507300944.NePjNXZ2-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project bcd0d972247154336dd1321f1fded818e46671d1)
reproduce: (https://download.01.org/0day-ci/archive/20250730/202507300944.NePjNXZ2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507300944.NePjNXZ2-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> mm/kmsan/hooks.c:269:14: sparse: sparse: cast removes address space '__user' of expression
   mm/kmsan/hooks.c:271:75: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void const *user_addr @@     got void [noderef] __user *to @@
   mm/kmsan/hooks.c:271:75: sparse:     expected void const *user_addr
   mm/kmsan/hooks.c:271:75: sparse:     got void [noderef] __user *to
   mm/kmsan/hooks.c:280:50: sparse: sparse: cast removes address space '__user' of expression
   mm/kmsan/hooks.c:306:59: sparse: sparse: Using plain integer as NULL pointer
   mm/kmsan/hooks.c:319:79: sparse: sparse: Using plain integer as NULL pointer
   mm/kmsan/hooks.c:325:79: sparse: sparse: Using plain integer as NULL pointer
   mm/kmsan/hooks.c:421:78: sparse: sparse: Using plain integer as NULL pointer

vim +/__user +269 mm/kmsan/hooks.c

b073d7f8aee4eb Alexander Potapenko 2022-09-15  247  
75cf0290271bf6 Alexander Potapenko 2022-09-15  248  void kmsan_copy_to_user(void __user *to, const void *from, size_t to_copy,
75cf0290271bf6 Alexander Potapenko 2022-09-15  249  			size_t left)
75cf0290271bf6 Alexander Potapenko 2022-09-15  250  {
75cf0290271bf6 Alexander Potapenko 2022-09-15  251  	unsigned long ua_flags;
75cf0290271bf6 Alexander Potapenko 2022-09-15  252  
75cf0290271bf6 Alexander Potapenko 2022-09-15  253  	if (!kmsan_enabled || kmsan_in_runtime())
75cf0290271bf6 Alexander Potapenko 2022-09-15  254  		return;
75cf0290271bf6 Alexander Potapenko 2022-09-15  255  	/*
75cf0290271bf6 Alexander Potapenko 2022-09-15  256  	 * At this point we've copied the memory already. It's hard to check it
75cf0290271bf6 Alexander Potapenko 2022-09-15  257  	 * before copying, as the size of actually copied buffer is unknown.
75cf0290271bf6 Alexander Potapenko 2022-09-15  258  	 */
75cf0290271bf6 Alexander Potapenko 2022-09-15  259  
75cf0290271bf6 Alexander Potapenko 2022-09-15  260  	/* copy_to_user() may copy zero bytes. No need to check. */
75cf0290271bf6 Alexander Potapenko 2022-09-15  261  	if (!to_copy)
75cf0290271bf6 Alexander Potapenko 2022-09-15  262  		return;
75cf0290271bf6 Alexander Potapenko 2022-09-15  263  	/* Or maybe copy_to_user() failed to copy anything. */
75cf0290271bf6 Alexander Potapenko 2022-09-15  264  	if (to_copy <= left)
75cf0290271bf6 Alexander Potapenko 2022-09-15  265  		return;
75cf0290271bf6 Alexander Potapenko 2022-09-15  266  
75cf0290271bf6 Alexander Potapenko 2022-09-15  267  	ua_flags = user_access_save();
f926e9326f3a79 Ilya Leoshkevich    2024-06-21  268  	if (!IS_ENABLED(CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE) ||
f926e9326f3a79 Ilya Leoshkevich    2024-06-21 @269  	    (u64)to < TASK_SIZE) {
75cf0290271bf6 Alexander Potapenko 2022-09-15  270  		/* This is a user memory access, check it. */
75cf0290271bf6 Alexander Potapenko 2022-09-15  271  		kmsan_internal_check_memory((void *)from, to_copy - left, to,
75cf0290271bf6 Alexander Potapenko 2022-09-15  272  					    REASON_COPY_TO_USER);
75cf0290271bf6 Alexander Potapenko 2022-09-15  273  	} else {
75cf0290271bf6 Alexander Potapenko 2022-09-15  274  		/* Otherwise this is a kernel memory access. This happens when a
75cf0290271bf6 Alexander Potapenko 2022-09-15  275  		 * compat syscall passes an argument allocated on the kernel
75cf0290271bf6 Alexander Potapenko 2022-09-15  276  		 * stack to a real syscall.
75cf0290271bf6 Alexander Potapenko 2022-09-15  277  		 * Don't check anything, just copy the shadow of the copied
75cf0290271bf6 Alexander Potapenko 2022-09-15  278  		 * bytes.
75cf0290271bf6 Alexander Potapenko 2022-09-15  279  		 */
75cf0290271bf6 Alexander Potapenko 2022-09-15  280  		kmsan_internal_memmove_metadata((void *)to, (void *)from,
75cf0290271bf6 Alexander Potapenko 2022-09-15  281  						to_copy - left);
75cf0290271bf6 Alexander Potapenko 2022-09-15  282  	}
75cf0290271bf6 Alexander Potapenko 2022-09-15  283  	user_access_restore(ua_flags);
75cf0290271bf6 Alexander Potapenko 2022-09-15  284  }
75cf0290271bf6 Alexander Potapenko 2022-09-15  285  EXPORT_SYMBOL(kmsan_copy_to_user);
75cf0290271bf6 Alexander Potapenko 2022-09-15  286  

:::::: The code at line 269 was first introduced by commit
:::::: f926e9326f3a79f7e01ac790e2361f44d8ca8320 kmsan: fix kmsan_copy_to_user() on arches with overlapping address spaces

:::::: TO: Ilya Leoshkevich <iii@linux.ibm.com>
:::::: CC: Andrew Morton <akpm@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


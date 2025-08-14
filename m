Return-Path: <linux-kernel+bounces-767969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F0AB25B5E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5E655C37D1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 05:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559B92264B9;
	Thu, 14 Aug 2025 05:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YI2ZVXwW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C46C21FF5C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 05:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755150888; cv=none; b=VURTUZeJ4H6Jqq47oMhgCvaP8xbvwaGYdVKISbM4oTTwbzVZ3zZ+A7h+BKpOq/dK7tSJb4qKeAW7SD1LtxZkjJffVNbBfYQljcHjKeoeTjwgU9/MwKozUuDhQaDEh1JwjGwkt8lFJEXtwx0ggcAVEcnIqN/gtUenfjLbmJZcRx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755150888; c=relaxed/simple;
	bh=IUQjwySLKtgI283QdrZy3Fjrl64HA008Tr53jmlsDmo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=b4WyriJNsbtw1itcq4FEH/xgKUdMq2xl3vRL5eTwC6uLCKLECx+u308+lcv6sayoATD2CvU/7QVG6jraexRnt7Wlp1morthDfxqJa+Qk1JEqo2rUJCKgKB+tj7k7p8OILa7GSfrRoZ/vJQIPcVS5CwzMtuXeHMk5ErUC4iCY7pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YI2ZVXwW; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755150887; x=1786686887;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IUQjwySLKtgI283QdrZy3Fjrl64HA008Tr53jmlsDmo=;
  b=YI2ZVXwW8A/T7AudpfsOckif1Cl96xErpTJARCfwSmFbG3AhsknPN+ID
   Kx+K9fW6Pzo0qMi12kG2eyv8lUEtG5ZG1gEy781HbpIUCAZrsL24GUm0r
   Af1oTVujStAt0ffRCal7jWWOoUYNooB5j9i/cmKZWdcYGqdnkPoMbH28F
   mDJr7X0zpT870g5Okc/WGSP8yeHUkl6tQ1Amrd4irwpz3MlsZS9s6jRCf
   hBubve5Ar1gVehPsHWIDyBZEilzH3L7kCzhvhhjYyNzfDs1uCD0+VVD+D
   qPkmv4C2/erdi/PDyFp8EDopEMbmrkxtGRw6jFGEGdRBTvyyv6qkFLJ6a
   w==;
X-CSE-ConnectionGUID: zrsFX2sNSRCNfjkS4dfIdw==
X-CSE-MsgGUID: v7wx+BKSRlqgwDC18uWlqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57175775"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="57175775"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 22:54:46 -0700
X-CSE-ConnectionGUID: 3H221HYwRqqbQz5Y6yEySQ==
X-CSE-MsgGUID: Kcya5KEuTFKx83ZWru4Rew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="171134485"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 13 Aug 2025 22:54:46 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umQvD-000AdL-0Q;
	Thu, 14 Aug 2025 05:54:43 +0000
Date: Thu, 14 Aug 2025 13:54:05 +0800
From: kernel test robot <lkp@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: ld.lld: error: Function Import: link error: linking module flags
 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 729676)'
 and 'vmlinux.a(build_policy.o at 732976)'
Message-ID: <202508141341.Kqi1HOSv-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0cc53520e68bea7fb80fdc6bdf8d226d1b6a98d9
commit: 8f2146159b3a24d4fde0479c5e19f31908419004 Merge branch 'tip/sched/urgent'
date:   4 weeks ago
config: riscv-randconfig-r064-20250813 (https://download.01.org/0day-ci/archive/20250814/202508141341.Kqi1HOSv-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250814/202508141341.Kqi1HOSv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508141341.Kqi1HOSv-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 729676)' and 'vmlinux.a(security.o at 770236)'
>> ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 729676)' and 'vmlinux.a(build_policy.o at 732976)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 729676)' and 'vmlinux.a(memory.o at 744976)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 729676)' and 'vmlinux.a(send.o at 765796)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 729676)' and 'vmlinux.a(btf.o at 741556)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 729676)' and 'vmlinux.a(testmgr.o at 773716)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 729676)' and 'vmlinux.a(binder.o at 904276)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 729676)' and 'vmlinux.a(inode.o at 764116)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 729676)' and 'vmlinux.a(volumes.o at 764656)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 729676)' and 'vmlinux.a(hugetlb.o at 746596)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 729676)' and 'vmlinux.a(segment.o at 767896)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 729676)' and 'vmlinux.a(ctree.o at 763576)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 729676)' and 'vmlinux.a(file.o at 767296)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 729676)' and 'vmlinux.a(page_alloc.o at 745936)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 729676)' and 'vmlinux.a(namespace.o at 750256)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 729676)' and 'vmlinux.a(node.o at 767836)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 729676)' and 'vmlinux.a(vmscan.o at 743776)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 729676)' and 'vmlinux.a(pci.o at 810796)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 729676)' and 'vmlinux.a(data.o at 767776)'
   ld.lld: error: Function Import: link error: linking module flags 'Code Model': IDs have conflicting values in 'vmlinux.a(init.o at 729676)' and 'vmlinux.a(syscall.o at 739936)'
   ld.lld: error: too many errors emitted, stopping now (use --error-limit=0 to see all errors)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


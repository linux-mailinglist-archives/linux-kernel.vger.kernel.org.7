Return-Path: <linux-kernel+bounces-792179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C8EB3C11C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2B577C5E7D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09FB326D44;
	Fri, 29 Aug 2025 16:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aW0VhVY0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BD4288DA
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 16:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756485937; cv=none; b=Cusr5yHKBaYRxnNmke0LZJpbdr5r2tZ/wO8o6gqwhQK4/HR8YH717qPY5snu9AdaZovgoljivODzNwVj1SZAfGSexwx5y0P5ci09tmOJhvEBmsEoaThSW7R4QieKgv+dTfrxetaOoPxJ2BMIMfJhm+otv4HwQVgfJ8meitMDQGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756485937; c=relaxed/simple;
	bh=DjwNFVlfFpWaaMuuDAlGX96zypGhw+xXQeXQ2Nf29WE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=j8bpL8NJnw+Vmm2Bdy+FzWi3S7UEPE4dj8w7MbbEs4yt/3vLaAcPthfJhngUfmjX6gdWzbSwKTuZXZ07yedDws6nhbOlJP5j7aH3h4WRNxLRvKWVJzXktW39YtGqinN0PhcmtswyYhjtloC5XK2gB+NtfnUtgNhMltafKEAvW0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aW0VhVY0; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756485936; x=1788021936;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DjwNFVlfFpWaaMuuDAlGX96zypGhw+xXQeXQ2Nf29WE=;
  b=aW0VhVY03iy/qT612ctHvUamQs5eiUOT9woXnK2LjP76k/026I39+39t
   koyIe/7oFE+9CezhFmZ48uyn9+DtXmt+bqF5qbporZgZNOFd/9zJLaFEp
   1n7JpnC0jAX7Va1Z+jOIvNfIBjlIeiuoLi3W66oo9Y2jN8BZO59GJRr7S
   Pk8QTCmdfz45K29/WGtBSsq3tgyxI+dNzw8QfYv0kVHYDOpp/Edpumzgz
   xZekiSp1+wG+SblEwJVeKDnibJASins8sXwNwUPlrsynBKgN+ueCrvYG/
   zSHvAbPUrdaD8hwdtkV+qAh/PK+DjmKg/fz36sb/Gc0RUPVxSFZbGS0fy
   Q==;
X-CSE-ConnectionGUID: OgEbxcnTT9OqJXlvKtVCSg==
X-CSE-MsgGUID: Sho2Cbb+RYOcRUehvEWVsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11537"; a="70147725"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="70147725"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 09:45:35 -0700
X-CSE-ConnectionGUID: PU89eEOaQzWYloouVnTp0A==
X-CSE-MsgGUID: pp2xb+WnQfiRQLv4HKnDwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="174593940"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 29 Aug 2025 09:45:34 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1us2EF-000Um3-1F;
	Fri, 29 Aug 2025 16:45:31 +0000
Date: Sat, 30 Aug 2025 00:45:16 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Brauner <brauner@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: include/linux/rbtree.h:74:9: sparse: sparse: incompatible types in
 comparison expression (different address spaces):
Message-ID: <202508300010.SwYrxEC0-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   07d9df80082b8d1f37e05658371b087cb6738770
commit: 16ecd47cb0cd895c7c2f5dd5db50f6c005c51639 pidfs: lookup pid through rbtree
date:   9 months ago
config: x86_64-randconfig-121-20250829 (https://download.01.org/0day-ci/archive/20250830/202508300010.SwYrxEC0-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250830/202508300010.SwYrxEC0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508300010.SwYrxEC0-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   fs/pidfs.c: note: in included file (through include/linux/mm_types.h, include/linux/mmzone.h, include/linux/gfp.h, ...):
>> include/linux/rbtree.h:74:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rbtree.h:74:9: sparse:    struct rb_node [noderef] __rcu *
   include/linux/rbtree.h:74:9: sparse:    struct rb_node *

vim +74 include/linux/rbtree.h

^1da177e4c3f41 Linus Torvalds 2005-04-16  67  
d72da4a4d973d8 Peter Zijlstra 2015-05-27  68  static inline void rb_link_node_rcu(struct rb_node *node, struct rb_node *parent,
d72da4a4d973d8 Peter Zijlstra 2015-05-27  69  				    struct rb_node **rb_link)
d72da4a4d973d8 Peter Zijlstra 2015-05-27  70  {
d72da4a4d973d8 Peter Zijlstra 2015-05-27  71  	node->__rb_parent_color = (unsigned long)parent;
d72da4a4d973d8 Peter Zijlstra 2015-05-27  72  	node->rb_left = node->rb_right = NULL;
d72da4a4d973d8 Peter Zijlstra 2015-05-27  73  
d72da4a4d973d8 Peter Zijlstra 2015-05-27 @74  	rcu_assign_pointer(*rb_link, node);
d72da4a4d973d8 Peter Zijlstra 2015-05-27  75  }
d72da4a4d973d8 Peter Zijlstra 2015-05-27  76  

:::::: The code at line 74 was first introduced by commit
:::::: d72da4a4d973d8a0a0d3c97e7cdebf287fbe3a99 rbtree: Make lockless searches non-fatal

:::::: TO: Peter Zijlstra <peterz@infradead.org>
:::::: CC: Rusty Russell <rusty@rustcorp.com.au>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


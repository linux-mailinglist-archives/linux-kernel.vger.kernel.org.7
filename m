Return-Path: <linux-kernel+bounces-768597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F211B262FF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56A4756040A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872A22EA742;
	Thu, 14 Aug 2025 10:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IGYZR0db"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D322D7383
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 10:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755168021; cv=none; b=YjstJ4pJA4QEN9aN4gIL/yZ1lou5j/3uYe05XANi5CEZYRH/3LNv2Qjc/LvD8v9G3KsF5SPwGm4SfaSGItOPbE+jRj+1Hwi3pdPkUXnCgfwQvr022lp2n1G46WmNjEgEBoheZlfS+JbmmSehNdKf1Imj5hKIu9Er+7nUpFWedI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755168021; c=relaxed/simple;
	bh=qgfwGSZfEbkniLqHKgCT8fgNudcnf/OobMNwSIUdZLE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sYBCAGLil6LQsmJ6/wV8VS0zLgSW0jx7mdhp3RfnkAUx7pCcftuZvZRHbZ1JO8/XKwR+l/NXvti9FzyiR7mN8bH08XtNJA6tkbTttFF7U75mXPDSADvj1mxFTu1saJRxdT4rSVPS2ZCSPPM9aD2q7keOSlcOUx4XThyFv2O3vPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IGYZR0db; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755168020; x=1786704020;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qgfwGSZfEbkniLqHKgCT8fgNudcnf/OobMNwSIUdZLE=;
  b=IGYZR0dbLmFgtDeo1H00F5uLD6UQZ9Hihp/HQg6Wd05oebBlcILvTu4n
   gqfUpxDOzqkpwxAcOiV8QF0rZCa5BqISa9QOjHq2r7ErCSj35YBV/hrLR
   Daebx6Dz8tkXctU572+HQQpvMzARbV39LpbIQ31ThofoE/yDHPeTTlYu3
   03PaSg+cclv59pZMyWG0TA1KMPzhS78AdSgHylmRkM0PUqH0+/6mWpkDz
   mGCSxXMIWFj5PKo000pa6rlJjKKusgOzh8wyyTmta1P4r95wWaTCtFuNm
   VGjHItUmSf4aVyRAHHBOVhggBaDhc01mVnrOlRoXC14oLOReUolz8qg/V
   g==;
X-CSE-ConnectionGUID: w5DpgixiQ5Oo6oAWUP1kzA==
X-CSE-MsgGUID: kIezentyTeucw6gIMQAMjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57383964"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="57383964"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 03:40:20 -0700
X-CSE-ConnectionGUID: 23PtKySTRtWxjmbbTauNRA==
X-CSE-MsgGUID: ywXMU6qyR52yYxydnP2uFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="197719795"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 14 Aug 2025 03:40:17 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umVNX-000ArQ-1j;
	Thu, 14 Aug 2025 10:40:15 +0000
Date: Thu, 14 Aug 2025 18:39:17 +0800
From: kernel test robot <lkp@intel.com>
To: Raul E Rangel <rrangel@chromium.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>
Subject: init/main.c:753:(.init.text+0x7e): relocation truncated to fit:
 R_ARC_S25W_PCREL against symbol `__st_r13_to_r16' defined in .text section
 in ../lib/gcc/arc-linux/8.5.0/libgcc.a(_millicodethunk_st.o)
Message-ID: <202508141854.NCR7LIB7-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Raul,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0cc53520e68bea7fb80fdc6bdf8d226d1b6a98d9
commit: 17b655759e83fd5e28931a0ece96fa9c2ab718e7 init: Don't proxy `console=` to earlycon
date:   11 months ago
config: arc-randconfig-r113-20250814 (https://download.01.org/0day-ci/archive/20250814/202508141854.NCR7LIB7-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 8.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250814/202508141854.NCR7LIB7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508141854.NCR7LIB7-lkp@intel.com/

All errors (new ones prefixed by >>):

   init/main.o: in function `do_early_param':
>> init/main.c:753:(.init.text+0x7e): relocation truncated to fit: R_ARC_S25W_PCREL against symbol `__st_r13_to_r16' defined in .text section in ../lib/gcc/arc-linux/8.5.0/libgcc.a(_millicodethunk_st.o)


vim +753 init/main.c

^1da177e4c3f41 Linus Torvalds    2005-04-16  749  
^1da177e4c3f41 Linus Torvalds    2005-04-16  750  /* Check for early params. */
ecc8617053e0a9 Luis R. Rodriguez 2015-03-30  751  static int __init do_early_param(char *param, char *val,
ecc8617053e0a9 Luis R. Rodriguez 2015-03-30  752  				 const char *unused, void *arg)
^1da177e4c3f41 Linus Torvalds    2005-04-16 @753  {
914dcaa84c53f2 Rusty Russell     2010-08-11  754  	const struct obs_kernel_param *p;
^1da177e4c3f41 Linus Torvalds    2005-04-16  755  
^1da177e4c3f41 Linus Torvalds    2005-04-16  756  	for (p = __setup_start; p < __setup_end; p++) {
17b655759e83fd Raul E Rangel     2024-09-11  757  		if (p->early && parameq(param, p->str)) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  758  			if (p->setup_func(val) != 0)
ea676e846a8171 Andrew Morton     2013-04-29  759  				pr_warn("Malformed early option '%s'\n", param);
^1da177e4c3f41 Linus Torvalds    2005-04-16  760  		}
^1da177e4c3f41 Linus Torvalds    2005-04-16  761  	}
^1da177e4c3f41 Linus Torvalds    2005-04-16  762  	/* We accept everything at this stage. */
^1da177e4c3f41 Linus Torvalds    2005-04-16  763  	return 0;
^1da177e4c3f41 Linus Torvalds    2005-04-16  764  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  765  

:::::: The code at line 753 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-kernel+bounces-826366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76817B8E537
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 22:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3127B3BE6B9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 20:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA5B28CF52;
	Sun, 21 Sep 2025 20:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hhv8vZEJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F117328C011
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 20:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758486300; cv=none; b=QAX964gxC43tsaKzFK6XksNMLj367ab3EqrthrxwdVcknAlgkTWEJeJpXcLm6lX87JxxkMJd3l2ce2Js8NMhFElHtpby83Akat+t/xGnNa6Ocp+i+JayHiu+Xrcmk0XM1VJ7fupAVHnNbiM8boYRLRYEf8k5+RbgOPhQKCsoMh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758486300; c=relaxed/simple;
	bh=IWLbWL8ZdcQC+LWDhGMbLVcV/365JJcichmz9Ov97kk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jG6OBdENft02ffnKvrxk9rHBCzW0P5LWYLbWUdgJ6W6/VUETLhqmPPSGLUKFH8uCNwH/hswomj9R90tZH+D/E0LX16vtMsNXSlKC3RnrS1HwuMqKcEXpWGZU9aGBDI43eJRylU/c9qb3ZeoZ4tPdRdD0nryHnwtWoc8+cWWethI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hhv8vZEJ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758486298; x=1790022298;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IWLbWL8ZdcQC+LWDhGMbLVcV/365JJcichmz9Ov97kk=;
  b=hhv8vZEJc1bBl7IG4Jj6/sHPsSPOlnlrLFtoehn+mP8wTeEJdKH2G9xy
   NYd5sCvNd9RUSiydEpJ1f9k9zlyF7P+MxkkF+iK+0TGHzIXPS1bwlHdDB
   N+eBY3tbUZ/KBh24iWI5xi6sieLl3MUpsXGt62DEzWKkn3CwcRyHoIHUp
   L3d5TlSQRhvXL1o0ajdh37Dycehy5NyzCmp2cdFNXcZ/bIIN8c+5K2hOx
   lEFjMEiHvXiX8LbahGlQhCXcaslpYDYsy2hikJ42Ll/+haJ8p3UsvTKU4
   4R62L/9sPLVltfB51FJ6pmO7aUNvYqdE+KZ3xBMXb17nm1uJl+eQp3xJ4
   w==;
X-CSE-ConnectionGUID: 5MZkiGKnSzmPp9qoMXdIKA==
X-CSE-MsgGUID: 4V1GiozMSGSfKsB8BVH6Lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60669279"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60669279"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2025 13:24:57 -0700
X-CSE-ConnectionGUID: qwusCQW6SpqsalagREnpSQ==
X-CSE-MsgGUID: OG2BFrtbT9aad0xj5oLojw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,283,1751266800"; 
   d="scan'208";a="200030231"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 21 Sep 2025 13:24:56 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v0Qc9-0000zR-1a;
	Sun, 21 Sep 2025 20:24:53 +0000
Date: Mon, 22 Sep 2025 04:24:31 +0800
From: kernel test robot <lkp@intel.com>
To: Raul E Rangel <rrangel@chromium.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>
Subject: init/main.c:753:(.init.text+0x78): relocation truncated to fit:
 R_ARC_S25W_PCREL against symbol `__st_r13_to_r16' defined in .text section
 in ../lib/gcc/arc-linux/9.5.0/arc700/libgcc.a(_millicodethunk_st.o)
Message-ID: <202509220409.xHZ7aNRX-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2d5bd41a45050d9bcd2de9c049beaf7dc5c45aa6
commit: 17b655759e83fd5e28931a0ece96fa9c2ab718e7 init: Don't proxy `console=` to earlycon
date:   12 months ago
config: arc-randconfig-002-20250922 (https://download.01.org/0day-ci/archive/20250922/202509220409.xHZ7aNRX-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 9.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250922/202509220409.xHZ7aNRX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509220409.xHZ7aNRX-lkp@intel.com/

All errors (new ones prefixed by >>):

   init/main.o: in function `do_early_param':
>> init/main.c:753:(.init.text+0x78): relocation truncated to fit: R_ARC_S25W_PCREL against symbol `__st_r13_to_r16' defined in .text section in ../lib/gcc/arc-linux/9.5.0/arc700/libgcc.a(_millicodethunk_st.o)


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


Return-Path: <linux-kernel+bounces-826213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EA0B8DDB6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 17:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F34DF188EAE1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 15:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F358D202987;
	Sun, 21 Sep 2025 15:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AOCMQn3f"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978DA1A7264
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 15:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758470091; cv=none; b=tfgIPP8rfvfQP9Hmk+laO8rzHGzkmahHAWlZ9sfvjwm9N0GW2fyYALRpRJyAOmEFIIMxW91eDiwazfWzznLMFgThAUrCTaBHhD2Hb78ojCy3lBGTO8c3yaXMowq/+f2FsnBwqo8epjThg+hVkP8d2zkbX5fTO8+JKQCivPZQNUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758470091; c=relaxed/simple;
	bh=hdYxpzmIqmFR29Nz/t5tOX9nYOCvZnrcLn3k1UTVoiU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Eusfeg0Pkc2xLzuKXL80LcISz02jJyfjV2Pjn3c4tnbKgepDlHfxDPDoALx3mPvPq/b7mMiQ2VTclfGr7NhYqUguoUdAm9ZhKFihK9BFV3aysnkT7CsAJl3CYkRzP2lZNShmJJda6Zb7upje3At029Dkf2nYyKFMuKyGMMJtJPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AOCMQn3f; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758470089; x=1790006089;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hdYxpzmIqmFR29Nz/t5tOX9nYOCvZnrcLn3k1UTVoiU=;
  b=AOCMQn3fsoAAW+8DMZMRdzPlZr8kp9fUekUDj9oti8jEatII6Os9sprR
   8gWa1UDAcmR9Z6RByPb1wv6LPNMT+Suq4vPLd52ReHyyVs8bN+1HqFV+8
   NgOdhNqUWMa4VMhl50f1Xmq0mD2WcYFtn5HuqPCfg2mh0CB1Ifmb5byS2
   lw7/b8VSOGOjVQcho5c4fcTRoBe0/S2D6tBEPnLbKplndeuQy4bB4uJWy
   k/GXYfPY6AZmzW26r8aQepG31FshsbcD96ZI8Vqp6MwaRtbkxZppn6/1Q
   kZ8+Q0FyzSwIyfys30Jf7xJgZlZvnRcL09tTCBCsdetSe6fbPVbgPRYsI
   A==;
X-CSE-ConnectionGUID: w7hLJBMBQTetjObDN74s8A==
X-CSE-MsgGUID: e+JCUiirS1K2rA4KyStDUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11560"; a="60675656"
X-IronPort-AV: E=Sophos;i="6.18,283,1751266800"; 
   d="scan'208";a="60675656"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2025 08:54:46 -0700
X-CSE-ConnectionGUID: WmTwX7ZCQeGtsj5QllX2bg==
X-CSE-MsgGUID: VDet6q7FSmKwZTWsKkzvTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,283,1751266800"; 
   d="scan'208";a="177084496"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 21 Sep 2025 08:54:45 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v0MOh-0000q9-04;
	Sun, 21 Sep 2025 15:54:43 +0000
Date: Sun, 21 Sep 2025 23:54:32 +0800
From: kernel test robot <lkp@intel.com>
To: Wolfram Sang <wsa-dev@sang-engineering.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: drivers/i3c/internals.h:54:9: error: passing 'const void *' to
 parameter of type 'void *' discards qualifiers
Message-ID: <202509212320.yCuqvnVn-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Wolfram,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f975f08c2e899ae2484407d7bba6bb7f8b6d9d40
commit: 3b661ca549b9e5bb11d0bc97ada6110aac3282d2 i3c: add missing include to internal header
date:   8 weeks ago
config: sparc64-randconfig-001-20250921 (https://download.01.org/0day-ci/archive/20250921/202509212320.yCuqvnVn-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 7c861bcedf61607b6c087380ac711eb7ff918ca6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250921/202509212320.yCuqvnVn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509212320.yCuqvnVn-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/i3c/master.c:21:
>> drivers/i3c/internals.h:54:9: error: passing 'const void *' to parameter of type 'void *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
      54 |         readsl(addr, buf, nbytes / 4);
         |                ^~~~
   arch/sparc/include/asm/io_64.h:265:41: note: passing argument to parameter 'port' here
     265 | static inline void readsl(void __iomem *port, void *buf, unsigned long count)
         |                                         ^
   1 error generated.


vim +54 drivers/i3c/internals.h

733b439375b494 Jorge Marques 2025-06-24  44  
733b439375b494 Jorge Marques 2025-06-24  45  /**
733b439375b494 Jorge Marques 2025-06-24  46   * i3c_readl_fifo - Read data buffer from 32bit FIFO
733b439375b494 Jorge Marques 2025-06-24  47   * @addr: FIFO Address to read from
733b439375b494 Jorge Marques 2025-06-24  48   * @buf: Pointer to the buffer to store read bytes
733b439375b494 Jorge Marques 2025-06-24  49   * @nbytes: Number of bytes to read
733b439375b494 Jorge Marques 2025-06-24  50   */
733b439375b494 Jorge Marques 2025-06-24  51  static inline void i3c_readl_fifo(const void __iomem *addr, void *buf,
733b439375b494 Jorge Marques 2025-06-24  52  				  int nbytes)
733b439375b494 Jorge Marques 2025-06-24  53  {
733b439375b494 Jorge Marques 2025-06-24 @54  	readsl(addr, buf, nbytes / 4);
733b439375b494 Jorge Marques 2025-06-24  55  	if (nbytes & 3) {
733b439375b494 Jorge Marques 2025-06-24  56  		u32 tmp;
733b439375b494 Jorge Marques 2025-06-24  57  
733b439375b494 Jorge Marques 2025-06-24  58  		tmp = readl(addr);
733b439375b494 Jorge Marques 2025-06-24  59  		memcpy(buf + (nbytes & ~3), &tmp, nbytes & 3);
733b439375b494 Jorge Marques 2025-06-24  60  	}
733b439375b494 Jorge Marques 2025-06-24  61  }
733b439375b494 Jorge Marques 2025-06-24  62  

:::::: The code at line 54 was first introduced by commit
:::::: 733b439375b494e8a6950ab47d18a4b615b73cb3 i3c: master: Add inline i3c_readl_fifo() and i3c_writel_fifo()

:::::: TO: Jorge Marques <jorge.marques@analog.com>
:::::: CC: Alexandre Belloni <alexandre.belloni@bootlin.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


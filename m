Return-Path: <linux-kernel+bounces-758352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB004B1CDF2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C80A93B0F2D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5D52BD034;
	Wed,  6 Aug 2025 20:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="edeT33nW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037472BFC7B
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 20:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754512876; cv=none; b=bXhAc6PHQYeSBjNXL4qUC86yb8t81gTzvo8DZMQ3/fnUc2VjhGbzBH6LgndkHqxm7lHOV/D33VX+PtQBpr/yRJpkGG7BKb4tVkK2edjOBCJd4fPMYx2TCGZrfsBTqg4uuexkcacx428qaqr/DaMf6yIkMVj2/SAhuuWizwye/Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754512876; c=relaxed/simple;
	bh=wZbTDzkOqW/92oBJK8cSh6J/AqE96Ei6sg1Ax0dDMck=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MUXZkKpz+ZjArqezwZ4BB2nhFltYpEiDZytniYaZZgkEpa1uPMbEyRjw1k3yqNkK2DTenUQlqOf5g6sJwqikgifYY6aujvyqMQa7fEeCnrkgr2tb5ezL37ExvaOJvWMGqzxqMNcExgLDmQFG4V++zbuD5GZQ7KfNmBQj6dvVqho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=edeT33nW; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754512874; x=1786048874;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wZbTDzkOqW/92oBJK8cSh6J/AqE96Ei6sg1Ax0dDMck=;
  b=edeT33nW8K5jS9CBffnDFEnaxlS+HZl4QgF5Lt4w9kIdNSFyR3CeCmOw
   0iP7/NefRSfFDJUYVdpm2fTom4T2EcCF+QebgxQHENX22jDyOzvM5bhEz
   +5dXtQ9aQJpaLo0/Uh5DHklwV9MvjOsy9dCh09XG7btThWe5UrGsNEhp4
   aptKBFTRhTQYcfl1GBBk1iVflIE8hXo0q8fflTD1dT+GeHwI7lv4mOsz6
   12FgOxeaQeqROsxRPlGQ8abNpqgeUEoo/oIBaC33Kipv2bIpcZKijQyPd
   1JlO/bFYHwlCB5t4TVS3Br+Eu66YDzcRC5pYXQDXZ1yb+qyAI6sh8hE+t
   A==;
X-CSE-ConnectionGUID: AAR3YoyoRh+eM8z9AK4q9w==
X-CSE-MsgGUID: ViFePlxdQbKWpbClbDlBLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="74303192"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="74303192"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 13:41:14 -0700
X-CSE-ConnectionGUID: Hmvv45UKSxeoU/41Pd4siw==
X-CSE-MsgGUID: 3dkWgvXPR36gHiWsrv/m3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="164389462"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 06 Aug 2025 13:41:11 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ujkwd-00024x-1K;
	Wed, 06 Aug 2025 20:41:07 +0000
Date: Thu, 7 Aug 2025 04:40:17 +0800
From: kernel test robot <lkp@intel.com>
To: Wolfram Sang <wsa-dev@sang-engineering.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: drivers/i3c/internals.h:54:9: error: passing 'const void *' to
 parameter of type 'void *' discards qualifiers
Message-ID: <202508070438.TZZA3f2S-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cca7a0aae8958c9b1cd14116cb8b2f22ace2205e
commit: 3b661ca549b9e5bb11d0bc97ada6110aac3282d2 i3c: add missing include to internal header
date:   7 days ago
config: sparc64-randconfig-002-20250807 (https://download.01.org/0day-ci/archive/20250807/202508070438.TZZA3f2S-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 7b8dea265e72c3037b6b1e54d5ab51b7e14f328b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250807/202508070438.TZZA3f2S-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508070438.TZZA3f2S-lkp@intel.com/

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


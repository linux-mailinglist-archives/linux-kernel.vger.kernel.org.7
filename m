Return-Path: <linux-kernel+bounces-757975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7034FB1C934
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F1837252CD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906B4299AA0;
	Wed,  6 Aug 2025 15:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EVkyBRS9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C2F294A1B
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 15:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754495066; cv=none; b=DfMlFN/4YPG6UMmL1zFvi/S4N2kNehj/4AkitJPcMoIGvCc6bwbl4CpRqZPNP+ui74O4x1FMge8s5C0r+ZJmnBB2xHJux5gt/5Opttg9Br6sXvkdWi+d5mX0zRvl+rYQLrmJFXajjBJCkb+fcUPutsGdH8QOdaTJlGPub2A54wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754495066; c=relaxed/simple;
	bh=tSR9xwfKiHqyt7Vh5FCTU67Ydz1kZXM72qUvReVb4SE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jnntJr6iIr/IUm6k6+QdkgXqREgxHdawnPOVfBuwabLQCrOCwbOms6UBub5Z2l89jhj0HPYxMLCC4+rcA4zOgPssJKb8ah7sN9RwgTm1SCjyorJAnQ9zs6XBLIEZClhK0vlPqtSNy12Xu9wXx5bZZd14tAux0Kc6ZirvH62ysq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EVkyBRS9; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754495064; x=1786031064;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tSR9xwfKiHqyt7Vh5FCTU67Ydz1kZXM72qUvReVb4SE=;
  b=EVkyBRS9c1C/2L9S+LhbThOk02hNmnM2WcrGE6oS6NoGCik9vBnqoqEv
   X7pPCHKPUL4TUrkWkNdgxN3JEOhAS3edvd1OVONEHa+6SIyTcuJX5/2Yf
   6kvlx3MuNJ/I1g3tPvIJeUG6+05dm6OsWbTPfjQKFDX+rlAuOG1K1Ba8w
   KiRcBOnMEn4Z04iRwrmfGIYgn5wkDWW1dM+XHTyU5dRJeVlqnmE1BL3E8
   PxJkwPSRCiqA/NIqfI+1NNXRGz9svdhgkRQqXfn4TFWNO0H+DphDvTBq3
   aF5xGL4Qb3GMfo9PQ4GrAsBi0UZpmMT3tssTpMjvGbV1tlmRRlZTmdyl1
   w==;
X-CSE-ConnectionGUID: ecRpvV8NSWC55n82OAkH6Q==
X-CSE-MsgGUID: pNJrIhNtSMmvzfyyCcRUcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="44408596"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="44408596"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 08:44:22 -0700
X-CSE-ConnectionGUID: oTeNE9IXQyiBF57qC51Sdg==
X-CSE-MsgGUID: 57s/xDonSmmFrwwNf+MJmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="164018155"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 06 Aug 2025 08:44:21 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ujgJO-0001pO-07;
	Wed, 06 Aug 2025 15:44:18 +0000
Date: Wed, 6 Aug 2025 23:43:58 +0800
From: kernel test robot <lkp@intel.com>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Cyril Bur <cyrilbur@tenstorrent.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: block/ioctl.c:72:39: sparse: sparse: Using plain integer as NULL
 pointer
Message-ID: <202508062321.gHv4kvuY-lkp@intel.com>
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
commit: f6bff7827a48e59cff1ef98aae72452d65174e0c riscv: uaccess: use 'asm_goto_output' for get_user()
date:   3 months ago
config: riscv-randconfig-r133-20250806 (https://download.01.org/0day-ci/archive/20250806/202508062321.gHv4kvuY-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250806/202508062321.gHv4kvuY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508062321.gHv4kvuY-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   WARNING: invalid argument to '-march': '_zacas_zabha'
>> block/ioctl.c:72:39: sparse: sparse: Using plain integer as NULL pointer

vim +72 block/ioctl.c

^1da177e4c3f41 drivers/block/ioctl.c Linus Torvalds 2005-04-16  65  
5fb889f587fa2a block/ioctl.c         Arnd Bergmann  2019-11-28  66  static int blkpg_ioctl(struct block_device *bdev,
5fb889f587fa2a block/ioctl.c         Arnd Bergmann  2019-11-28  67  		       struct blkpg_ioctl_arg __user *arg)
5fb889f587fa2a block/ioctl.c         Arnd Bergmann  2019-11-28  68  {
5fb889f587fa2a block/ioctl.c         Arnd Bergmann  2019-11-28  69  	struct blkpg_partition __user *udata;
5fb889f587fa2a block/ioctl.c         Arnd Bergmann  2019-11-28  70  	int op;
5fb889f587fa2a block/ioctl.c         Arnd Bergmann  2019-11-28  71  
5fb889f587fa2a block/ioctl.c         Arnd Bergmann  2019-11-28 @72  	if (get_user(op, &arg->op) || get_user(udata, &arg->data))
5fb889f587fa2a block/ioctl.c         Arnd Bergmann  2019-11-28  73  		return -EFAULT;
5fb889f587fa2a block/ioctl.c         Arnd Bergmann  2019-11-28  74  
5fb889f587fa2a block/ioctl.c         Arnd Bergmann  2019-11-28  75  	return blkpg_do_ioctl(bdev, udata, op);
5fb889f587fa2a block/ioctl.c         Arnd Bergmann  2019-11-28  76  }
5fb889f587fa2a block/ioctl.c         Arnd Bergmann  2019-11-28  77  

:::::: The code at line 72 was first introduced by commit
:::::: 5fb889f587fa2ae486e067d8a00df955ae6492b3 compat_ioctl: block: simplify compat_blkpg_ioctl()

:::::: TO: Arnd Bergmann <arnd@arndb.de>
:::::: CC: Arnd Bergmann <arnd@arndb.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


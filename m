Return-Path: <linux-kernel+bounces-828133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7342B9402A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 04:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F8892E08C4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 02:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B060270572;
	Tue, 23 Sep 2025 02:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JAFgLpih"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE4D2472B1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 02:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758594770; cv=none; b=cn3iUFK9xlCstPB8CXdPbBa8GMIkZGWtqmt1MBbDvYxTZAY5/Q3Fp6SSesygu8pxPQCJUs//9dq5CJ7rlbQbs9Hgpf4y+U3qD1AfAfwkqHn6VB/tBwa6WWXIHOGM3awRV06DfdOBjqr0UTMl59Npg+3ViXUEEYWq1U6ED5ZlkxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758594770; c=relaxed/simple;
	bh=s6xE7TdEQAnRwaTxux4s/PGfcxwqJAxkDLccQUgUC3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxYS4fM6W1RB/EAoxk0OtUeHuoxlqM9IrBsNVWIVxjMPzf6AFkwA+B7dFNJqgrTcuHt3MzMesAPunJmCKBJ+6gAJZunW+UdHiXb511gymeSSmo81DR6CdLvf4nTuY+RwKWIaUqwhA1nue3hEhVyeo/8HJilQyPsgbrpkTx02gTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JAFgLpih; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758594769; x=1790130769;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s6xE7TdEQAnRwaTxux4s/PGfcxwqJAxkDLccQUgUC3s=;
  b=JAFgLpihh4G2aOte4dpPPoYsXXDvp6jNigJYIS8rndfhi21TCWSmGU9f
   Q8qDnjKFvbMtRC1V0CG12bvgT4ZsOfo3XR2f6aaQ8hj3/fZaS+mFhv41s
   IWoI3P5vm3xObMQJrIUagnMwkFC4//PiySugC37uIu0h4knPz3rY08fYQ
   s6XidxVjswB2dqgi0iTqYBpdDlbkmLaVmD2rxLmh9AhJzv0Uw+78X5/I8
   dIXPBPgjU4fM9WE7FwNsv63xuxl/2GlA5UFURgMbEhnxzkW+R4LUYBa/b
   1/uZtuCbZnyvcLxxG3FliIaw2ZS6OO0BrvfJ8lVFvrZItG6zXFh0gBZEp
   Q==;
X-CSE-ConnectionGUID: xOZviHy6Rua7oznXsSUvQA==
X-CSE-MsgGUID: AZVYUOcIS/+nt7r3w+623w==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="86303371"
X-IronPort-AV: E=Sophos;i="6.18,286,1751266800"; 
   d="scan'208";a="86303371"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 19:32:48 -0700
X-CSE-ConnectionGUID: nZ5wvhotQ66/ujLtceuvMw==
X-CSE-MsgGUID: MLzt1+KRTpyAz8r4CNGICQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,286,1751266800"; 
   d="scan'208";a="175919634"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 22 Sep 2025 19:32:44 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v0spd-0002g7-0u;
	Tue, 23 Sep 2025 02:32:41 +0000
Date: Tue, 23 Sep 2025 10:32:05 +0800
From: kernel test robot <lkp@intel.com>
To: Bo Liu <liubo03@inspur.com>, xiang@kernel.org, chao@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Bo Liu <liubo03@inspur.com>
Subject: Re: [PATCH v4] erofs: Add support for FS_IOC_GETFSLABEL
Message-ID: <202509231033.ADjNYvqL-lkp@intel.com>
References: <20250922092937.2055-1-liubo03@inspur.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922092937.2055-1-liubo03@inspur.com>

Hi Bo,

kernel test robot noticed the following build errors:

[auto build test ERROR on xiang-erofs/dev-test]
[also build test ERROR on xiang-erofs/dev xiang-erofs/fixes linus/master v6.17-rc7 next-20250922]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bo-Liu/erofs-Add-support-for-FS_IOC_GETFSLABEL/20250922-173127
base:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
patch link:    https://lore.kernel.org/r/20250922092937.2055-1-liubo03%40inspur.com
patch subject: [PATCH v4] erofs: Add support for FS_IOC_GETFSLABEL
config: sparc64-randconfig-001-20250923 (https://download.01.org/0day-ci/archive/20250923/202509231033.ADjNYvqL-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project cafc064fc7a96b3979a023ddae1da2b499d6c954)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250923/202509231033.ADjNYvqL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509231033.ADjNYvqL-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/erofs/inode.c:372:47: error: call to undeclared function 'compat_ptr'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     372 |         return erofs_ioctl(filp, cmd, (unsigned long)compat_ptr(arg));
         |                                                      ^
   1 error generated.


vim +/compat_ptr +372 fs/erofs/inode.c

   367	
   368	#ifdef CONFIG_COMPAT
   369	long erofs_compat_ioctl(struct file *filp, unsigned int cmd,
   370				unsigned long arg)
   371	{
 > 372		return erofs_ioctl(filp, cmd, (unsigned long)compat_ptr(arg));
   373	}
   374	#endif
   375	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


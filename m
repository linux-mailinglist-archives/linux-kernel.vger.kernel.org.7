Return-Path: <linux-kernel+bounces-728562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC9EB02A01
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 10:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 689B1177766
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 08:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8709B26B76B;
	Sat, 12 Jul 2025 08:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eU+7ZhVI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A371C4A11
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 08:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752308359; cv=none; b=i6szLlzY5r21DJrh+Y3HhMKs1/3WjWDc40E14wqjN7P9tpX6klmiX5LPCOWzr2PmRhsnh/Axmnkpdiji0LKsVR7Yvmp/2RrxB9kayIZIMnStNYeVHW6+xb4EwqVGx6e18nE0G8EijYPG4xjFwArNuMuYqduVMnkNDzOHDi+b2J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752308359; c=relaxed/simple;
	bh=eB+ThotSsopGkHavSJDY+uYX/rQcwLk88dMHc6rUuHY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Pn5KqunTECmy9liH71iBvM2tykiX5fZxJfl341T7YtFaLh9lrpSoSegAt4swtnTZg98Icoblav/ywRr0gjVrf7SbQGeoYxLEVy/SGDaRpouQEbsIx/uGyikVxF27Lr7f7F6HSti8sJngphRvGElqrFcxfERJVI+cEjje84vAka0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eU+7ZhVI; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752308358; x=1783844358;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eB+ThotSsopGkHavSJDY+uYX/rQcwLk88dMHc6rUuHY=;
  b=eU+7ZhVIiDFeyeuVnIu50vxbwEGqwYUMoKuiX5FXNueurNG/y62IsCO4
   KR7vt7cdp88llgnderjxxQGOI0utElMNwv67+LueGe+8JnSsD8Vn1IHrW
   AMyBsBxMILK86qsyJz2RhD05j0F1iOb6RqyH2c4FFsGBnv/Z+iW9muUSw
   t7ACEEzqS1PKWdoxiloPBhEptotVpnwYkklITyiDsUjb8oK+cVNTRSfk0
   ZfCFByjxWarsgSSkW1bWw9rc65wuX09duktwtCHqMLJq/0eNFenhmGc/e
   s6wee2qSHJ3tFfHprsTkd2U9sLbJcvL+0wIKdRY2lO89SWI/wMR493/wO
   g==;
X-CSE-ConnectionGUID: XQvOT00kQAOxhHVnyhONLQ==
X-CSE-MsgGUID: YwlfNggITTG+xPKvVx5s4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54717572"
X-IronPort-AV: E=Sophos;i="6.16,306,1744095600"; 
   d="scan'208";a="54717572"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2025 01:19:17 -0700
X-CSE-ConnectionGUID: WaCQ6rAZRxWceQbBQ/i4Dg==
X-CSE-MsgGUID: xkTF5SDLS/q98Fs9vp2mwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,306,1744095600"; 
   d="scan'208";a="156156584"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 12 Jul 2025 01:19:15 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uaVRx-0007B1-0N;
	Sat, 12 Jul 2025 08:19:13 +0000
Date: Sat, 12 Jul 2025 16:18:45 +0800
From: kernel test robot <lkp@intel.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andi Shyti <andi@smida.it>
Subject: drivers/i2c/busses/i2c-xgene-slimpro.c:183:18: sparse: sparse:
 dereference of noderef expression
Message-ID: <202507121605.dG75O5HN-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   379f604cc3dc2c865dc2b13d81faa166b6df59ec
commit: 7b174126124560f15e392fe5767face99e61ddb1 i2c: xgene-slimpro: Simplify PCC shared memory region handling
date:   8 weeks ago
config: arm64-randconfig-r123-20250712 (https://download.01.org/0day-ci/archive/20250712/202507121605.dG75O5HN-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 01c97b4953e87ae455bd4c41e3de3f0f0f29c61c)
reproduce: (https://download.01.org/0day-ci/archive/20250712/202507121605.dG75O5HN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507121605.dG75O5HN-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/i2c/busses/i2c-xgene-slimpro.c:121:15: sparse: sparse: cast to restricted __le16
   drivers/i2c/busses/i2c-xgene-slimpro.c:124:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short volatile @@     got restricted __le16 [usertype] @@
   drivers/i2c/busses/i2c-xgene-slimpro.c:124:9: sparse:     expected unsigned short volatile
   drivers/i2c/busses/i2c-xgene-slimpro.c:124:9: sparse:     got restricted __le16 [usertype]
   drivers/i2c/busses/i2c-xgene-slimpro.c:153:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short [usertype] *addr @@     got unsigned short [noderef] __iomem * @@
   drivers/i2c/busses/i2c-xgene-slimpro.c:153:38: sparse:     expected unsigned short [usertype] *addr
   drivers/i2c/busses/i2c-xgene-slimpro.c:153:38: sparse:     got unsigned short [noderef] __iomem *
   drivers/i2c/busses/i2c-xgene-slimpro.c:157:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short [usertype] *addr @@     got unsigned short [noderef] __iomem * @@
   drivers/i2c/busses/i2c-xgene-slimpro.c:157:37: sparse:     expected unsigned short [usertype] *addr
   drivers/i2c/busses/i2c-xgene-slimpro.c:157:37: sparse:     got unsigned short [noderef] __iomem *
   drivers/i2c/busses/i2c-xgene-slimpro.c:159:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *msg @@     got struct acpi_pcct_shared_memory [noderef] __iomem * @@
   drivers/i2c/busses/i2c-xgene-slimpro.c:159:21: sparse:     expected void *msg
   drivers/i2c/busses/i2c-xgene-slimpro.c:159:21: sparse:     got struct acpi_pcct_shared_memory [noderef] __iomem *
   drivers/i2c/busses/i2c-xgene-slimpro.c:173:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i2c/busses/i2c-xgene-slimpro.c:177:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i2c/busses/i2c-xgene-slimpro.c:177:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int volatile @@     got restricted __le32 [usertype] @@
   drivers/i2c/busses/i2c-xgene-slimpro.c:177:9: sparse:     expected unsigned int volatile
   drivers/i2c/busses/i2c-xgene-slimpro.c:177:9: sparse:     got restricted __le32 [usertype]
   drivers/i2c/busses/i2c-xgene-slimpro.c:180:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i2c/busses/i2c-xgene-slimpro.c:180:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short volatile @@     got restricted __le16 [usertype] @@
   drivers/i2c/busses/i2c-xgene-slimpro.c:180:9: sparse:     expected unsigned short volatile
   drivers/i2c/busses/i2c-xgene-slimpro.c:180:9: sparse:     got restricted __le16 [usertype]
   drivers/i2c/busses/i2c-xgene-slimpro.c:183:18: sparse: sparse: cast to restricted __le16
   drivers/i2c/busses/i2c-xgene-slimpro.c:185:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i2c/busses/i2c-xgene-slimpro.c:185:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short volatile @@     got restricted __le16 [usertype] @@
   drivers/i2c/busses/i2c-xgene-slimpro.c:185:9: sparse:     expected unsigned short volatile
   drivers/i2c/busses/i2c-xgene-slimpro.c:185:9: sparse:     got restricted __le16 [usertype]
   drivers/i2c/busses/i2c-xgene-slimpro.c:189:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int volatile @@     got restricted __le32 [usertype] @@
   drivers/i2c/busses/i2c-xgene-slimpro.c:189:17: sparse:     expected unsigned int volatile
   drivers/i2c/busses/i2c-xgene-slimpro.c:189:17: sparse:     got restricted __le32 [usertype]
>> drivers/i2c/busses/i2c-xgene-slimpro.c:183:18: sparse: sparse: dereference of noderef expression

vim +183 drivers/i2c/busses/i2c-xgene-slimpro.c

df5da47fe722e3 Hoan Tran    2017-04-24  168  
df5da47fe722e3 Hoan Tran    2017-04-24  169  static void slimpro_i2c_pcc_tx_prepare(struct slimpro_i2c_dev *ctx, u32 *msg)
df5da47fe722e3 Hoan Tran    2017-04-24  170  {
7b174126124560 Sudeep Holla 2025-04-11  171  	struct acpi_pcct_shared_memory __iomem *generic_comm_base =
7b174126124560 Sudeep Holla 2025-04-11  172  							ctx->pcc_chan->shmem;
df5da47fe722e3 Hoan Tran    2017-04-24  173  	u32 *ptr = (void *)(generic_comm_base + 1);
df5da47fe722e3 Hoan Tran    2017-04-24  174  	u16 status;
df5da47fe722e3 Hoan Tran    2017-04-24  175  	int i;
df5da47fe722e3 Hoan Tran    2017-04-24  176  
df5da47fe722e3 Hoan Tran    2017-04-24  177  	WRITE_ONCE(generic_comm_base->signature,
df5da47fe722e3 Hoan Tran    2017-04-24  178  		   cpu_to_le32(PCC_SIGNATURE | ctx->mbox_idx));
df5da47fe722e3 Hoan Tran    2017-04-24  179  
df5da47fe722e3 Hoan Tran    2017-04-24  180  	WRITE_ONCE(generic_comm_base->command,
89a4ad1f437c04 Sudeep Holla 2023-09-27  181  		   cpu_to_le16(SLIMPRO_MSG_TYPE(msg[0]) | PCC_CMD_GENERATE_DB_INTR));
df5da47fe722e3 Hoan Tran    2017-04-24  182  
df5da47fe722e3 Hoan Tran    2017-04-24 @183  	status = le16_to_cpu(READ_ONCE(generic_comm_base->status));
89a4ad1f437c04 Sudeep Holla 2023-09-27  184  	status &= ~PCC_STATUS_CMD_COMPLETE;
df5da47fe722e3 Hoan Tran    2017-04-24  185  	WRITE_ONCE(generic_comm_base->status, cpu_to_le16(status));
df5da47fe722e3 Hoan Tran    2017-04-24  186  
df5da47fe722e3 Hoan Tran    2017-04-24  187  	/* Copy the message to the PCC comm space */
df5da47fe722e3 Hoan Tran    2017-04-24  188  	for (i = 0; i < SLIMPRO_IIC_MSG_DWORD_COUNT; i++)
df5da47fe722e3 Hoan Tran    2017-04-24  189  		WRITE_ONCE(ptr[i], cpu_to_le32(msg[i]));
df5da47fe722e3 Hoan Tran    2017-04-24  190  }
df5da47fe722e3 Hoan Tran    2017-04-24  191  

:::::: The code at line 183 was first introduced by commit
:::::: df5da47fe722e36055b97134e6bb9df58c12495c i2c: xgene-slimpro: Add ACPI support by using PCC mailbox

:::::: TO: Hoan Tran <hotran@apm.com>
:::::: CC: Wolfram Sang <wsa@the-dreams.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


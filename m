Return-Path: <linux-kernel+bounces-728436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDF6B0281B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 02:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 276D43BCD3C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 23:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B248C223DEF;
	Fri, 11 Jul 2025 23:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JYU6GIGs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266DC226CF0
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 23:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752278255; cv=none; b=e/x6FOb4ntRsiR0ANTCw9C4ivPuWUm3JK5y0WKRRlGtmYUTqj7wkB+HMOlVMFZ8L2LFx1UXDZFSjB2f5E9bUKgmE7xRauCjCUUgjS2PcfjX5EoTf1oTZX5tHhms2s4VlkHkM/5T5E4wc0fxUhzB3v/geklVrEuQrgbCk9cNW9Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752278255; c=relaxed/simple;
	bh=WDSSstMBcFrfIiS/oWUN2ir3J5cSocIjNKKxiYRTKjI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=L5QWUUEFlxYaOLOJnJxnEMUpKDLXDJbjhggCfXHu2SiddY0iLEBsheFMSQzrR0FLSLpQB2/ct9nfsD0yu7KZ2+w09C9ayiY5q5G7DZ4tmzksJGFMg6ju1k1MceYVhKKrZmkd0YOp9eU+EMXBOjWjVtEB7jXrmo/+c6aGQrxAYec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JYU6GIGs; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752278254; x=1783814254;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WDSSstMBcFrfIiS/oWUN2ir3J5cSocIjNKKxiYRTKjI=;
  b=JYU6GIGsGNRAZrHxuo4uxLDs/OzhcQlgINuJYHB/DoeIAsEZxabz7OR6
   iFQ86U4Y4DZhfDjduX4T20GtB8lc+HDJjZiHlQZqski1ISO0WkUYVtf40
   8+cSlcee+JOpQmz0iGoFW4orXyvE7dEH8f4j5JrKPgo4amTruEHYETIuh
   7J85a4IaLX1ExsQEhSUEs83kXO9vwnG1+haVmVQ6qS5BD1zG1b3g2qmCw
   lVChDXmuaQ9n4b8Sh4ms3IPbPtPciXFH4SyEPtcSLEVK9C1Oemdt1xFCL
   yZ80bPY6j8ElNKPHMj1gykr3usfG6lBmmAHFITbUohdIuNlUjjGBUL4xM
   A==;
X-CSE-ConnectionGUID: IrQIoq7uTv2KHbTz1qGIuw==
X-CSE-MsgGUID: siyP2Gv6RpaW8eVwIt9nLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54436373"
X-IronPort-AV: E=Sophos;i="6.16,305,1744095600"; 
   d="scan'208";a="54436373"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 16:57:33 -0700
X-CSE-ConnectionGUID: A5djyFOXREiGRhcHrgRiCA==
X-CSE-MsgGUID: LmOfXDbyQ0SspLZ/DUqgtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,305,1744095600"; 
   d="scan'208";a="156572849"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 11 Jul 2025 16:57:32 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uaNcQ-0006uZ-01;
	Fri, 11 Jul 2025 23:57:30 +0000
Date: Sat, 12 Jul 2025 07:57:01 +0800
From: kernel test robot <lkp@intel.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: drivers/hwmon/xgene-hwmon.c:145:15: sparse: sparse: dereference of
 noderef expression
Message-ID: <202507120757.OQ27yP2N-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   40f92e79b0aabbf3575e371f9054657a421a3e79
commit: 80fcd1e7f5c7009fa1c64737df100cc304c19c1f hwmon: (xgene-hwmon) Simplify PCC shared memory region handling
date:   3 months ago
config: arm64-randconfig-r113-20250711 (https://download.01.org/0day-ci/archive/20250712/202507120757.OQ27yP2N-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 01c97b4953e87ae455bd4c41e3de3f0f0f29c61c)
reproduce: (https://download.01.org/0day-ci/archive/20250712/202507120757.OQ27yP2N-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507120757.OQ27yP2N-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/hwmon/xgene-hwmon.c:116:15: sparse: sparse: cast to restricted __le16
   drivers/hwmon/xgene-hwmon.c:119:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short volatile @@     got restricted __le16 [usertype] @@
   drivers/hwmon/xgene-hwmon.c:119:9: sparse:     expected unsigned short volatile
   drivers/hwmon/xgene-hwmon.c:119:9: sparse:     got restricted __le16 [usertype]
   drivers/hwmon/xgene-hwmon.c:128:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/xgene-hwmon.c:137:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/xgene-hwmon.c:137:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int volatile @@     got restricted __le32 [usertype] @@
   drivers/hwmon/xgene-hwmon.c:137:9: sparse:     expected unsigned int volatile
   drivers/hwmon/xgene-hwmon.c:137:9: sparse:     got restricted __le32 [usertype]
   drivers/hwmon/xgene-hwmon.c:141:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/xgene-hwmon.c:141:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short volatile @@     got restricted __le16 [usertype] @@
   drivers/hwmon/xgene-hwmon.c:141:9: sparse:     expected unsigned short volatile
   drivers/hwmon/xgene-hwmon.c:141:9: sparse:     got restricted __le16 [usertype]
   drivers/hwmon/xgene-hwmon.c:145:15: sparse: sparse: cast to restricted __le16
   drivers/hwmon/xgene-hwmon.c:147:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/xgene-hwmon.c:147:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short volatile @@     got restricted __le16 [usertype] @@
   drivers/hwmon/xgene-hwmon.c:147:9: sparse:     expected unsigned short volatile
   drivers/hwmon/xgene-hwmon.c:147:9: sparse:     got restricted __le16 [usertype]
   drivers/hwmon/xgene-hwmon.c:151:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int volatile @@     got restricted __le32 [usertype] @@
   drivers/hwmon/xgene-hwmon.c:151:17: sparse:     expected unsigned int volatile
   drivers/hwmon/xgene-hwmon.c:151:17: sparse:     got restricted __le32 [usertype]
   drivers/hwmon/xgene-hwmon.c:538:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *msg @@     got struct acpi_pcct_shared_memory [noderef] __iomem * @@
   drivers/hwmon/xgene-hwmon.c:538:13: sparse:     expected void *msg
   drivers/hwmon/xgene-hwmon.c:538:13: sparse:     got struct acpi_pcct_shared_memory [noderef] __iomem *
   drivers/hwmon/xgene-hwmon.c:540:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short [usertype] *addr @@     got unsigned short [noderef] __iomem * @@
   drivers/hwmon/xgene-hwmon.c:540:38: sparse:     expected unsigned short [usertype] *addr
   drivers/hwmon/xgene-hwmon.c:540:38: sparse:     got unsigned short [noderef] __iomem *
   drivers/hwmon/xgene-hwmon.c:562:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short [usertype] *addr @@     got unsigned short [noderef] __iomem * @@
   drivers/hwmon/xgene-hwmon.c:562:45: sparse:     expected unsigned short [usertype] *addr
   drivers/hwmon/xgene-hwmon.c:562:45: sparse:     got unsigned short [noderef] __iomem *
>> drivers/hwmon/xgene-hwmon.c:145:15: sparse: sparse: dereference of noderef expression

vim +145 drivers/hwmon/xgene-hwmon.c

ed42cfa881e1d8 hotran        2016-07-21  123  
ed42cfa881e1d8 hotran        2016-07-21  124  static int xgene_hwmon_pcc_rd(struct xgene_hwmon_dev *ctx, u32 *msg)
ed42cfa881e1d8 hotran        2016-07-21  125  {
80fcd1e7f5c700 Sudeep Holla  2025-04-11  126  	struct acpi_pcct_shared_memory __iomem *generic_comm_base =
80fcd1e7f5c700 Sudeep Holla  2025-04-11  127  							ctx->pcc_chan->shmem;
c7cefce03e6912 Arnd Bergmann 2016-09-09  128  	u32 *ptr = (void *)(generic_comm_base + 1);
ed42cfa881e1d8 hotran        2016-07-21  129  	int rc, i;
ed42cfa881e1d8 hotran        2016-07-21  130  	u16 val;
ed42cfa881e1d8 hotran        2016-07-21  131  
ed42cfa881e1d8 hotran        2016-07-21  132  	mutex_lock(&ctx->rd_mutex);
ed42cfa881e1d8 hotran        2016-07-21  133  	init_completion(&ctx->rd_complete);
ed42cfa881e1d8 hotran        2016-07-21  134  	ctx->resp_pending = true;
ed42cfa881e1d8 hotran        2016-07-21  135  
ed42cfa881e1d8 hotran        2016-07-21  136  	/* Write signature for subspace */
c7cefce03e6912 Arnd Bergmann 2016-09-09  137  	WRITE_ONCE(generic_comm_base->signature,
2cf39b806be746 Sudeep Holla  2023-09-27  138  		   cpu_to_le32(PCC_SIGNATURE | ctx->mbox_idx));
ed42cfa881e1d8 hotran        2016-07-21  139  
ed42cfa881e1d8 hotran        2016-07-21  140  	/* Write to the shared command region */
c7cefce03e6912 Arnd Bergmann 2016-09-09  141  	WRITE_ONCE(generic_comm_base->command,
2cf39b806be746 Sudeep Holla  2023-09-27  142  		   cpu_to_le16(MSG_TYPE(msg[0]) | PCC_CMD_GENERATE_DB_INTR));
ed42cfa881e1d8 hotran        2016-07-21  143  
ed42cfa881e1d8 hotran        2016-07-21  144  	/* Flip CMD COMPLETE bit */
c7cefce03e6912 Arnd Bergmann 2016-09-09 @145  	val = le16_to_cpu(READ_ONCE(generic_comm_base->status));
2cf39b806be746 Sudeep Holla  2023-09-27  146  	val &= ~PCC_STATUS_CMD_COMPLETE;
c7cefce03e6912 Arnd Bergmann 2016-09-09  147  	WRITE_ONCE(generic_comm_base->status, cpu_to_le16(val));
ed42cfa881e1d8 hotran        2016-07-21  148  
ed42cfa881e1d8 hotran        2016-07-21  149  	/* Copy the message to the PCC comm space */
ed42cfa881e1d8 hotran        2016-07-21  150  	for (i = 0; i < sizeof(struct slimpro_resp_msg) / 4; i++)
c7cefce03e6912 Arnd Bergmann 2016-09-09  151  		WRITE_ONCE(ptr[i], cpu_to_le32(msg[i]));
ed42cfa881e1d8 hotran        2016-07-21  152  
ed42cfa881e1d8 hotran        2016-07-21  153  	/* Ring the doorbell */
ed42cfa881e1d8 hotran        2016-07-21  154  	rc = mbox_send_message(ctx->mbox_chan, msg);
ed42cfa881e1d8 hotran        2016-07-21  155  	if (rc < 0) {
ed42cfa881e1d8 hotran        2016-07-21  156  		dev_err(ctx->dev, "Mailbox send error %d\n", rc);
ed42cfa881e1d8 hotran        2016-07-21  157  		goto err;
ed42cfa881e1d8 hotran        2016-07-21  158  	}
ed42cfa881e1d8 hotran        2016-07-21  159  	if (!wait_for_completion_timeout(&ctx->rd_complete,
ed42cfa881e1d8 hotran        2016-07-21  160  					 usecs_to_jiffies(ctx->usecs_lat))) {
ed42cfa881e1d8 hotran        2016-07-21  161  		dev_err(ctx->dev, "Mailbox operation timed out\n");
ed42cfa881e1d8 hotran        2016-07-21  162  		rc = -ETIMEDOUT;
ed42cfa881e1d8 hotran        2016-07-21  163  		goto err;
ed42cfa881e1d8 hotran        2016-07-21  164  	}
ed42cfa881e1d8 hotran        2016-07-21  165  
ed42cfa881e1d8 hotran        2016-07-21  166  	/* Check for error message */
ed42cfa881e1d8 hotran        2016-07-21  167  	if (MSG_TYPE(ctx->sync_msg.msg) == MSG_TYPE_ERR) {
ed42cfa881e1d8 hotran        2016-07-21  168  		rc = -EINVAL;
ed42cfa881e1d8 hotran        2016-07-21  169  		goto err;
ed42cfa881e1d8 hotran        2016-07-21  170  	}
ed42cfa881e1d8 hotran        2016-07-21  171  
ed42cfa881e1d8 hotran        2016-07-21  172  	msg[0] = ctx->sync_msg.msg;
ed42cfa881e1d8 hotran        2016-07-21  173  	msg[1] = ctx->sync_msg.param1;
ed42cfa881e1d8 hotran        2016-07-21  174  	msg[2] = ctx->sync_msg.param2;
ed42cfa881e1d8 hotran        2016-07-21  175  
ed42cfa881e1d8 hotran        2016-07-21  176  err:
ed42cfa881e1d8 hotran        2016-07-21  177  	mbox_chan_txdone(ctx->mbox_chan, 0);
ed42cfa881e1d8 hotran        2016-07-21  178  	ctx->resp_pending = false;
ed42cfa881e1d8 hotran        2016-07-21  179  	mutex_unlock(&ctx->rd_mutex);
ed42cfa881e1d8 hotran        2016-07-21  180  	return rc;
ed42cfa881e1d8 hotran        2016-07-21  181  }
ed42cfa881e1d8 hotran        2016-07-21  182  

:::::: The code at line 145 was first introduced by commit
:::::: c7cefce03e691270c0e5e117248e14661e9c9cad hwmon: (xgene) access mailbox as RAM

:::::: TO: Arnd Bergmann <arnd@arndb.de>
:::::: CC: Guenter Roeck <linux@roeck-us.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


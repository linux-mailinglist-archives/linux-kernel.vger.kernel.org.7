Return-Path: <linux-kernel+bounces-812994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98718B53F6B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 02:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB6AE1CC0CAA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 00:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167A079CD;
	Fri, 12 Sep 2025 00:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NPcHy8dV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EB32030A;
	Fri, 12 Sep 2025 00:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757635711; cv=none; b=QtbMK1S+B9hGz7QRzm2jjSkrbS6kaRhipcCYHXGzYXwKs1dCsHkNmmvtL9aoVuTyGtOCPLgXjPHoY///EFV+mwqsWkr0MyORy04JB8LKmhmVxqjBeD84w4lfF9MqCV8PHLmZ840l/uKQAG58zpNEDowSPW6qtvR60imIvfF1F3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757635711; c=relaxed/simple;
	bh=UxcuXC6sExcpG8BeW6MP7jgxfMtnH1Fa8tN/NA404Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bV1LhvnOLznGIJdl7tBbnDwFeY8UgDPgfEBKV/PT0GLX2QSlD31ZunRWAZkU1OdjxgblQWq7rs/fi+I7gRixoB03+4OqeIcBGuoIINk4/J525RbV66bnYDnBJF1oCVxlUD8pJ81wLv45JXq38ar7EQq7J2R/bVwKBXWx1tduOMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NPcHy8dV; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757635710; x=1789171710;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UxcuXC6sExcpG8BeW6MP7jgxfMtnH1Fa8tN/NA404Fg=;
  b=NPcHy8dVB0iuvC5pQB64RBtcao1jIpE4xNT+WfIoc/WSsQ75R+37P58c
   j3IIdXvUFDH8lYPJDBAJ5lLBJJ83lmlCDV5m5T4W9XzedVbOHPbeL8njA
   bw8DaUSrV1jEnmw9ExrNVk4SfQSBjqoWx7zyiB5Xr6pYxMMXHuMDuvrWf
   84bWNdm6L2ukojSLkBe2dh48i/1Ku4AgbuRIVv7s1CglNKSN0D/NK7iMH
   iRFLL8UxUlW8OUNsLt4H3VYcZBmS8jhNpfOuyQuY9f5vFcfKtbTEJ6osK
   iEf3tP4b8a3x7ziE6tg33BdIsf4IVRDl03pUOyFBHvCyP3VENFyOgCVYi
   Q==;
X-CSE-ConnectionGUID: N8Lk2SD5QfGkbwWhHQEdfw==
X-CSE-MsgGUID: GcGo7dUlS8Svg/+494UhKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60040653"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60040653"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 17:08:29 -0700
X-CSE-ConnectionGUID: JkE15ZKyT4Wcs/nc8sjVrw==
X-CSE-MsgGUID: jm0+/LUrS322nD6lO7OCzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,258,1751266800"; 
   d="scan'208";a="178163399"
Received: from lkp-server02.sh.intel.com (HELO eb5fdfb2a9b7) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 11 Sep 2025 17:08:26 -0700
Received: from kbuild by eb5fdfb2a9b7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uwrKx-0000iO-2Z;
	Fri, 12 Sep 2025 00:08:23 +0000
Date: Fri, 12 Sep 2025 08:08:15 +0800
From: kernel test robot <lkp@intel.com>
To: Peng Fan <peng.fan@nxp.com>, Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	arm-scmi@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 2/2] firmware: imx: sm-misc: Dump syslog info
Message-ID: <202509120758.omltrDMi-lkp@intel.com>
References: <20250910-sm-syslog-v1-2-5b36f8f21da6@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-sm-syslog-v1-2-5b36f8f21da6@nxp.com>

Hi Peng,

kernel test robot noticed the following build errors:

[auto build test ERROR on 65dd046ef55861190ecde44c6d9fcde54b9fb77d]

url:    https://github.com/intel-lab-lkp/linux/commits/Peng-Fan/firmware-arm_scmi-imx-Support-getting-syslog-of-MISC-protocol/20250910-223316
base:   65dd046ef55861190ecde44c6d9fcde54b9fb77d
patch link:    https://lore.kernel.org/r/20250910-sm-syslog-v1-2-5b36f8f21da6%40nxp.com
patch subject: [PATCH 2/2] firmware: imx: sm-misc: Dump syslog info
config: i386-buildonly-randconfig-004-20250912 (https://download.01.org/0day-ci/archive/20250912/202509120758.omltrDMi-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250912/202509120758.omltrDMi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509120758.omltrDMi-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/firmware/imx/sm-misc.c:54:39: error: use of undeclared identifier 'SZ_4K'
      54 |         void *syslog __free(kfree) = kmalloc(SZ_4K, GFP_KERNEL);
         |                                              ^
>> drivers/firmware/imx/sm-misc.c:54:39: error: use of undeclared identifier 'SZ_4K'
>> drivers/firmware/imx/sm-misc.c:54:39: error: use of undeclared identifier 'SZ_4K'
   drivers/firmware/imx/sm-misc.c:56:13: error: use of undeclared identifier 'SZ_4K'
      56 |         u16 size = SZ_4K / 4;
         |                    ^
   drivers/firmware/imx/sm-misc.c:64:14: error: use of undeclared identifier 'SZ_4K'
      64 |                 if (size > SZ_4K / 4) {
         |                            ^
   drivers/firmware/imx/sm-misc.c:64:14: error: use of undeclared identifier 'SZ_4K'
   drivers/firmware/imx/sm-misc.c:64:14: error: use of undeclared identifier 'SZ_4K'
   7 errors generated.


vim +/SZ_4K +54 drivers/firmware/imx/sm-misc.c

    49	
    50	static int syslog_show(struct seq_file *file, void *priv)
    51	{
    52		struct device *dev = file->private;
    53		/* 4KB is large enough for syslog */
  > 54		void *syslog __free(kfree) = kmalloc(SZ_4K, GFP_KERNEL);
    55		/* syslog API use num words, not num bytes */
    56		u16 size = SZ_4K / 4;
    57		int ret;
    58	
    59		if (!ph)
    60			return -ENODEV;
    61	
    62		ret = imx_misc_ctrl_ops->misc_syslog(ph, &size, syslog);
    63		if (ret) {
    64			if (size > SZ_4K / 4) {
    65				dev_err(dev, "syslog size is larger than 4KB, please enlarge\n");
    66				return ret;
    67			}
    68		}
    69	
    70		seq_hex_dump(file, " ", DUMP_PREFIX_NONE, 16, sizeof(u32), syslog, size * 4, false);
    71		seq_putc(file, '\n');
    72	
    73		return 0;
    74	}
    75	DEFINE_SHOW_ATTRIBUTE(syslog);
    76	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


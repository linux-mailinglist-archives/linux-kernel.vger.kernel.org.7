Return-Path: <linux-kernel+bounces-867923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F646C03EF1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 02:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BD846359CBC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 00:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06086FC3;
	Fri, 24 Oct 2025 00:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pub6kend"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F93A10E0
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761264376; cv=none; b=WNHICjmSLC+rGuJ25/mBQ4W9XSrBw36VS8xmz77eKZIKWplxQFijyzC7dL4FrPsBjn/s/qpTouBmSC7WVihgsnS50jxgBNpAD+eNyfg9t5Qxf2lJqIKH8IIPXFspV0e7gr9WHEk4qa9Eopo/bKVWbIrLZjmId/QABVtgdZJEznY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761264376; c=relaxed/simple;
	bh=oK3psvgn3E7pcp9NnICDp2jA26t10vNikxpNBuK+hTU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sJ7WG5bbmCL2DgIWHy5LijF1JU5Db5Z4jMWK91lQF/TfEDpJb7ryIeb2PYlT1LEbJqt85ZktcMHwZ++hYP+4sY4/7kIB8J1ke7mBg/P2nxIkg1Wt3Qe8BQsrPBrW6lojDhhz7R0Sc3VYLNln81iX8WFDpuYXPJX1cVFErWBM6b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pub6kend; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761264374; x=1792800374;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oK3psvgn3E7pcp9NnICDp2jA26t10vNikxpNBuK+hTU=;
  b=Pub6kendMAaDb7MOD8JkgDDuwiJsh1wEAx3SKAe+gd34rBJ5KRjIHOLe
   8RVHt8Ikw26gvVhks9jTNEQqHJnFkkSWT48UCMnwcSn7n1nVGlMtHKmfN
   hRZNPCF6rV4Uo3bJa+Q+KRwvncyZ93eniXgGspCmwB7dYC542NuEjTG5X
   cQ3ApvHAwwFkIiG0iHgh9WenLKHuWHQtn0VF6dDRpFmNpgzNxBMPb/h/N
   diOujeKY44aEWJb3Jpzin41ZHOGryugedzo9hG331gikRjq/ydoQTPV27
   JX1Idu+CYBMLvJJg46OkLAT08lrc39KxRjnhOsEKp08HdBV7pAsLwBr71
   g==;
X-CSE-ConnectionGUID: L/vJhPKNRQ+r0nfLWq7p9A==
X-CSE-MsgGUID: VKxgU+/OTbCLCfO7UGqjUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67313353"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="67313353"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 17:06:13 -0700
X-CSE-ConnectionGUID: Obau92r9Qcy4oNMETRI5hQ==
X-CSE-MsgGUID: cE0AYQczSGSFgc1f6+vadA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="184003209"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 23 Oct 2025 17:06:13 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vC5Jq-000E09-2t;
	Fri, 24 Oct 2025 00:06:10 +0000
Date: Fri, 24 Oct 2025 08:05:27 +0800
From: kernel test robot <lkp@intel.com>
To: Cryolitia PukNgae <cryolitia@uniontech.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: drivers/hwmon/gpd-fan.c:231:9: error: implicit declaration of
 function 'outb'
Message-ID: <202510240817.vt3eQ3qL-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Cryolitia,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   266ee584e55eed108583ab4f45b5de734522502d
commit: 0ab88e2394392f475b8857ac82c0c987841217f8 hwmon: add GPD devices sensor driver
date:   6 weeks ago
config: i386-buildonly-randconfig-002-20251024 (https://download.01.org/0day-ci/archive/20251024/202510240817.vt3eQ3qL-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251024/202510240817.vt3eQ3qL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510240817.vt3eQ3qL-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/hwmon/gpd-fan.c: In function 'gpd_ecram_read':
>> drivers/hwmon/gpd-fan.c:231:9: error: implicit declaration of function 'outb' [-Wimplicit-function-declaration]
     231 |         outb(0x2E, addr_port);
         |         ^~~~
>> drivers/hwmon/gpd-fan.c:244:16: error: implicit declaration of function 'inb' [-Wimplicit-function-declaration]
     244 |         *val = inb(data_port);
         |                ^~~


vim +/outb +231 drivers/hwmon/gpd-fan.c

   224	
   225	// Helper functions to handle EC read/write
   226	static void gpd_ecram_read(u16 offset, u8 *val)
   227	{
   228		u16 addr_port = gpd_driver_priv.drvdata->addr_port;
   229		u16 data_port = gpd_driver_priv.drvdata->data_port;
   230	
 > 231		outb(0x2E, addr_port);
   232		outb(0x11, data_port);
   233		outb(0x2F, addr_port);
   234		outb((u8)((offset >> 8) & 0xFF), data_port);
   235	
   236		outb(0x2E, addr_port);
   237		outb(0x10, data_port);
   238		outb(0x2F, addr_port);
   239		outb((u8)(offset & 0xFF), data_port);
   240	
   241		outb(0x2E, addr_port);
   242		outb(0x12, data_port);
   243		outb(0x2F, addr_port);
 > 244		*val = inb(data_port);
   245	}
   246	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


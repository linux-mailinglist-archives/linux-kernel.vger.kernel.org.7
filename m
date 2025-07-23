Return-Path: <linux-kernel+bounces-743067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A9DB0FA21
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 20:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FB52580C77
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 18:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47198228C9D;
	Wed, 23 Jul 2025 18:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WhY9A7em"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C5B218584
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 18:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753294734; cv=none; b=U0xWQD8xx48Ci62dkkgZnxlnyh/Nn9fpMxzFBmIk/8/6HGKOwScrJKqeccPFFax47kLbDcJvTm31QcRccXd+z8oJNS7RfKSJ4WnQ2MBKEVxffWotjWUP26R5GiyHGmuYdDo2Qt1JBIbmmmAu4smZb1H6yN1YRouRzpWQiQEwVNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753294734; c=relaxed/simple;
	bh=ea97RbKqqqhOvAPLdIIsZmefZy32CMZIYXKm105GNys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNxcx85R7aVH5v+D4O1M4kF0gvVXfcle4LhQ8wI8eCnwSoRebe4LoqolYBVrAaEQA6dwAz2FnQ9wrxaR4q0aBMicZHBG6geNrV8E/knmE/oMdSRezNqqdUViJbF3AsxGtEIq7GjZ4u7yBgVzPPtuH0Xwunwm+RIqe45bICXM1Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WhY9A7em; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753294733; x=1784830733;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ea97RbKqqqhOvAPLdIIsZmefZy32CMZIYXKm105GNys=;
  b=WhY9A7emigBtyM3CONaeI8rAh3Ky1Fq4WkgNIF8AEF4HxSdi7J8AVurZ
   RWRQtYlhY9v3xZpaCIYstAk5MxsdlkmkNtRHCM07qLiEOl/JdIe6V4OyZ
   dbupnKE2vxzqn3JJr2hIjcYwRZxho3GRXWbaoO9joxFflIkTAhKFkGteA
   rx7imKFxjkqkIEkZuoPSbe7B39G0qsUf1ZhKLUdyk1jT8ULceArpwL1h/
   Ul288fpWcVtGeXzX8aGPVdE2t6GAvSFkqKf+HGmNn/mnFuHDaVXOAbt90
   QT5QIEleuqu8heQpKvVA4HIHliKBtCtjDfQSAT740FkS7uPasjrS7g69E
   Q==;
X-CSE-ConnectionGUID: YbMwsLMjTHGOYDJAWiH4Ag==
X-CSE-MsgGUID: HvwitE4mQiGQ0bYHuC4S2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55737699"
X-IronPort-AV: E=Sophos;i="6.16,335,1744095600"; 
   d="scan'208";a="55737699"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 11:18:52 -0700
X-CSE-ConnectionGUID: lVwVXVxUQVquUtvAZ9/OWg==
X-CSE-MsgGUID: 41nWruodScyeeaIfeOni6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,335,1744095600"; 
   d="scan'208";a="163904488"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 23 Jul 2025 11:18:50 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uee3D-000Jff-1y;
	Wed, 23 Jul 2025 18:18:47 +0000
Date: Thu, 24 Jul 2025 02:18:26 +0800
From: kernel test robot <lkp@intel.com>
To: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>, suzuki.poulose@arm.com,
	mike.leach@linaro.org, alexander.shishkin@linux.intel.com,
	alexandre.torgue@foss.st.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	james.clark@linaro.org, mcoquelin.stm32@gmail.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Subject: Re: [PATCH v5] coresight: Replace scnprintf/sprintf with
 sysfs_emit()/sysfs_emit_at()
Message-ID: <202507240249.8WCThmh3-lkp@intel.com>
References: <20250722184106.3290455-1-chelsyratnawat2001@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722184106.3290455-1-chelsyratnawat2001@gmail.com>

Hi Chelsy,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20250722]
[cannot apply to atorgue-stm32/stm32-next soc/for-next linus/master v6.16-rc7 v6.16-rc6 v6.16-rc5 v6.16-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chelsy-Ratnawat/coresight-Replace-scnprintf-sprintf-with-sysfs_emit-sysfs_emit_at/20250723-024400
base:   next-20250722
patch link:    https://lore.kernel.org/r/20250722184106.3290455-1-chelsyratnawat2001%40gmail.com
patch subject: [PATCH v5] coresight: Replace scnprintf/sprintf with sysfs_emit()/sysfs_emit_at()
config: arm64-randconfig-001-20250723 (https://download.01.org/0day-ci/archive/20250724/202507240249.8WCThmh3-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 853c343b45b3e83cc5eeef5a52fc8cc9d8a09252)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250724/202507240249.8WCThmh3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507240249.8WCThmh3-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/hwtracing/coresight/coresight-etm4x-sysfs.c:127:20: error: use of undeclared identifier 'bu'
     127 |         return sysfs_emit(bu, "%#lx\n", val);
         |                           ^~
>> drivers/hwtracing/coresight/coresight-etm4x-sysfs.c:1336:26: error: incompatible integer to pointer conversion passing 'int' to parameter of type 'const char *' [-Wint-conversion]
    1336 |                 size = sysfs_emit(buf, size, "addr_cmp[%i] unused\n", idx);
         |                                        ^~~~
   include/linux/sysfs.h:492:39: note: passing argument to parameter 'fmt' here
     492 | int sysfs_emit(char *buf, const char *fmt, ...);
         |                                       ^
   2 errors generated.


vim +/bu +127 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c

   118	
   119	static ssize_t numvmidc_show(struct device *dev,
   120				     struct device_attribute *attr,
   121				     char *buf)
   122	{
   123		unsigned long val;
   124		struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
   125	
   126		val = drvdata->numvmidc;
 > 127		return sysfs_emit(bu, "%#lx\n", val);
   128	}
   129	static DEVICE_ATTR_RO(numvmidc);
   130	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


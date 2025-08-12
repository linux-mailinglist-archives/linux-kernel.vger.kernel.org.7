Return-Path: <linux-kernel+bounces-763831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22768B21AC6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 04:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF8C94265D0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 02:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EDE2E0B6D;
	Tue, 12 Aug 2025 02:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UU0YxQK6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD8328505D;
	Tue, 12 Aug 2025 02:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754965706; cv=none; b=S+hr0CtftNWxAEnOWMAry0KborTmpdSfbm21PzjeFpifEwvOlsDFlDWS3qb4mZJTRL06Kd5Z/jecK5gYEMTFbIComP9e6vq71HNbV7TnTYDsc1OH1GbYvw7yvMAMw4sh1ardju8+kXdDhCan1ezYiHS04W0qN29W2HXboAJ2QvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754965706; c=relaxed/simple;
	bh=ERDc6HgIPWc+c9h6aqBfiaCNSHpUTxXrrgyXl87fFVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+3EyL/g5IKm/56cLbyjrKT0ZUAWfgeyiD5LbSZU6RKPAGu3RPG1c7W/WHh6JBxdZ3M484xBgMi9FkE4K02z4f+orq6bYrPHugjQSLELsCAph1kSjl6x93ijZGdakas8Y24gudNCc2Qwc1qlJJVfmYm5OwROlLvHTNUCaIB6Jnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UU0YxQK6; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754965706; x=1786501706;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ERDc6HgIPWc+c9h6aqBfiaCNSHpUTxXrrgyXl87fFVs=;
  b=UU0YxQK6UYTOWGaYKgnnFEwo0csFOTZz6H5XuedpXda+ERICqekbR+zl
   msvzu7CbKvCPtZDg8QDDShZFkrWVXl7VdWs2AGK1TKaY1i8hXzZxA6/Fe
   TB58fcUJh2cvnyRk24QZBi72VP1Y97y90ySNvc3Hm09SaYI1rVr6jiI74
   Kxg99qFM6Dss588r6DOGLKxQQVP0gtaML6lGxDXSESCqGCO3nW+wRLABD
   u7FDjV/EsV9aEIWOK5IQQDoEyX+1LnvjNnP0ZJHAktBNrgbMKUCImBIER
   dSWNPpZc4U13XpF9O5cWMWVDHlZR3v2QvuJiti6j8qzCHRvnMIFlxe5bU
   Q==;
X-CSE-ConnectionGUID: IhS/fBSiT4S5t8T/702fEQ==
X-CSE-MsgGUID: je0ZndqKSVi5Ii2yX0sZew==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57375892"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="57375892"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 19:28:25 -0700
X-CSE-ConnectionGUID: VPWNMlEPSEaCSYEKI8RCXQ==
X-CSE-MsgGUID: TUbvzhJGSkep8kTC2w5UbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="165958752"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 11 Aug 2025 19:28:22 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ulekO-0006MS-01;
	Tue, 12 Aug 2025 02:28:20 +0000
Date: Tue, 12 Aug 2025 10:27:38 +0800
From: kernel test robot <lkp@intel.com>
To: James Clark <james.clark@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>, Leo Yan <leo.yan@arm.com>
Cc: oe-kbuild-all@lists.linux.dev, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, James Clark <james.clark@linaro.org>
Subject: Re: [PATCH 5/6] coresight: Add format attribute for setting the
 timestamp interval
Message-ID: <202508121018.1l0grTw7-lkp@intel.com>
References: <20250811-james-cs-syncfreq-v1-5-b001cd6e3404@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811-james-cs-syncfreq-v1-5-b001cd6e3404@linaro.org>

Hi James,

kernel test robot noticed the following build errors:

[auto build test ERROR on a80198ba650f50d266d7fc4a6c5262df9970f9f2]

url:    https://github.com/intel-lab-lkp/linux/commits/James-Clark/coresight-Change-syncfreq-to-be-a-u8/20250811-174256
base:   a80198ba650f50d266d7fc4a6c5262df9970f9f2
patch link:    https://lore.kernel.org/r/20250811-james-cs-syncfreq-v1-5-b001cd6e3404%40linaro.org
patch subject: [PATCH 5/6] coresight: Add format attribute for setting the timestamp interval
config: arm-randconfig-003-20250812 (https://download.01.org/0day-ci/archive/20250812/202508121018.1l0grTw7-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250812/202508121018.1l0grTw7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508121018.1l0grTw7-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/hwtracing/coresight/coresight-etm-perf.c:25:
>> drivers/hwtracing/coresight/coresight-etm4x.h:247:10: fatal error: asm/sysreg.h: No such file or directory
     247 | #include <asm/sysreg.h>
         |          ^~~~~~~~~~~~~~
   compilation terminated.


vim +247 drivers/hwtracing/coresight/coresight-etm4x.h

03336d0f4d0d74 Suzuki K Poulose 2021-02-01  246  
03336d0f4d0d74 Suzuki K Poulose 2021-02-01 @247  #include <asm/sysreg.h>
03336d0f4d0d74 Suzuki K Poulose 2021-02-01  248  #define ETM4x_REG_NUM_TO_SYSREG(n)				\
03336d0f4d0d74 Suzuki K Poulose 2021-02-01  249  	sys_reg(2, 1, ETM4x_CRn(n), ETM4x_CRm(n), ETM4x_Op2(n))
03336d0f4d0d74 Suzuki K Poulose 2021-02-01  250  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


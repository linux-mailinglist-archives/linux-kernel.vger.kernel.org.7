Return-Path: <linux-kernel+bounces-896472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2ED3C5076C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 04:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F300A3ACF8B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 03:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB002C326D;
	Wed, 12 Nov 2025 03:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YiE5vxAD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0542C11DB;
	Wed, 12 Nov 2025 03:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762919945; cv=none; b=Yb/HI6hwIqUorqWfzacujX/iN+srqlJU7Nhy4hBultB//ZH3f4m3xTG9QvtPu/N5/7Y0Ov9IPE9eAKX3iLxwqNjoXd4DxRLdEcIfIBmkZxSWO8koJS1ob0tYJFnEAM0bcew8AA30CkNzdYMou5oyr02YyIXJqa+YpmMubtLd/xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762919945; c=relaxed/simple;
	bh=+hU18LbqN5Fk06aApVZJ6gtGyvZdRIpdeVXRqSgHe5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPnAq3na6U/ndPJ3o56Sh2j8668JLKcoaEBzmvqtCwIVcVJ2wGoZ4zTuiCc1sl89quEZOyANDBhdkfM9jkRoyzs9J6SETz/+LO1y+ESkYSfz5XD1I6T9/B7zFaeUVqxaUFRnwp4jJxrwTrk2UgJHwu+pvDIwP+tr3A6uFyIgu78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YiE5vxAD; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762919943; x=1794455943;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+hU18LbqN5Fk06aApVZJ6gtGyvZdRIpdeVXRqSgHe5o=;
  b=YiE5vxADYFsKiSO55gINX7f1GsVsJs5I3hFXPtBXXb06rqUw7/9q5WUp
   lbStk7uAdT3c2oN9EyAm3BAdEvfdr40yw+Pf6zg0NjtUUrJT6muiITMlf
   q6S2EiXnysUCboVINYRZhb33EOocHyYwHknkmz8nQE/1MCVmp+Tt0hti+
   0qiRJDrir7P7gZTVj/zozTB9ecqV8gBn9MEYReAeok2tqrXOTcf6u1W6H
   TxKOwAnlxmeM7nFLwIAnVcR5IXEE+Cy/iGfsoR3XHWGXUaeeLhOCAMoUi
   Uf9goftUQb0tiIxSLzYG676c30wXyGH3FikdyyFQCRRwYxzzMtpNdgXrt
   w==;
X-CSE-ConnectionGUID: frIyX1d7Shi1a7rLshYZrQ==
X-CSE-MsgGUID: p5opxVYIQwWidTjAi9BEDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="65013842"
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="65013842"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 19:59:02 -0800
X-CSE-ConnectionGUID: WCDQM6SrRzCLiiD4wFTboQ==
X-CSE-MsgGUID: wIhFiwMnTZqw0/sFviRZrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="189277778"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 11 Nov 2025 19:58:59 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vJ20W-0003o3-2X;
	Wed, 12 Nov 2025 03:58:56 +0000
Date: Wed, 12 Nov 2025 11:58:31 +0800
From: kernel test robot <lkp@intel.com>
To: Wenliang Yan <wenliang202407@163.com>, linux@roeck-us.net,
	Jean Delvare <jdelvare@suse.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	christophe.jaillet@wanadoo.fr, conor+dt@kernel.org, corbet@lwn.net,
	devicetree@vger.kernel.org, krzk+dt@kernel.org,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	robh@kernel.org, wenliang202407@163.com
Subject: Re: [PATCH 6/8] hwmon:(ina3221)Modify read/write functions for 'in'
 attribute
Message-ID: <202511121034.856ivnlW-lkp@intel.com>
References: <20251111080546.32421-7-wenliang202407@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111080546.32421-7-wenliang202407@163.com>

Hi Wenliang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on groeck-staging/hwmon-next]
[also build test WARNING on linus/master v6.18-rc5 next-20251111]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wenliang-Yan/dt-binding-ti-ina3221-Add-SQ52210/20251111-161425
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20251111080546.32421-7-wenliang202407%40163.com
patch subject: [PATCH 6/8] hwmon:(ina3221)Modify read/write functions for 'in' attribute
config: i386-randconfig-013-20251112 (https://download.01.org/0day-ci/archive/20251112/202511121034.856ivnlW-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251112/202511121034.856ivnlW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511121034.856ivnlW-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/hwmon/ina3221.c:563:21: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
     563 |         [hwmon_in_lcrit] = { BIT(9), BIT(8), BIT(7) },
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hwmon/ina3221.c:561:23: note: previous initialization is here
     561 |         [hwmon_curr_lcrit] = { BIT(15), BIT(14), BIT(13) },
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/hwmon/ina3221.c:589:2: warning: variable 'alert_group' is used uninitialized whenever switch default is taken [-Wsometimes-uninitialized]
     589 |         default:
         |         ^~~~~~~
   drivers/hwmon/ina3221.c:598:5: note: uninitialized use occurs here
     598 |                                 alert_group, 0);
         |                                 ^~~~~~~~~~~
   drivers/hwmon/ina3221.c:571:17: note: initialize the variable 'alert_group' to silence this warning
     571 |         u32 alert_group;
         |                        ^
         |                         = 0
   2 warnings generated.


vim +/alert_group +589 drivers/hwmon/ina3221.c

   559	
   560	static const u32 sq52210_alert_mask[][INA3221_NUM_CHANNELS] = {
   561		[hwmon_curr_lcrit] = { BIT(15), BIT(14), BIT(13) },
   562		[hwmon_in_crit] = { BIT(12), BIT(11), BIT(10) },
 > 563		[hwmon_in_lcrit] = { BIT(9), BIT(8), BIT(7) },
   564		[hwmon_power_crit] = { BIT(6), BIT(5), BIT(4) },
   565	};
   566	
   567	static int sq52210_alert_limit_write(struct ina3221_data *ina, u32 attr, int channel, long val)
   568	{
   569		struct regmap *regmap = ina->regmap;
   570		int ret, limit_reg, item;
   571		u32 alert_group;
   572	
   573		if (val < 0)
   574			return -EINVAL;
   575		item = channel % INA3221_NUM_CHANNELS;
   576		switch (item) {
   577		case 0:
   578			alert_group = SQ52210_MASK_ALERT_CHANNEL1;
   579			limit_reg = SQ52210_ALERT_LIMIT1;
   580			break;
   581		case 1:
   582			alert_group = SQ52210_MASK_ALERT_CHANNEL2;
   583			limit_reg = SQ52210_ALERT_LIMIT2;
   584			break;
   585		case 2:
   586			alert_group = SQ52210_MASK_ALERT_CHANNEL3;
   587			limit_reg = SQ52210_ALERT_LIMIT3;
   588			break;
 > 589		default:
   590			break;
   591		}
   592		/*
   593		 * Clear all alerts first to avoid accidentally triggering ALERT pin
   594		 * due to register write sequence. Then, only enable the alert
   595		 * if the value is non-zero.
   596		 */
   597		ret = regmap_update_bits(regmap, SQ52210_ALERT_CONFIG,
   598					alert_group, 0);
   599		if (ret < 0)
   600			return ret;
   601		ret = regmap_write(regmap, limit_reg,
   602				sq52210_alert_to_reg(ina, ina3221_curr_reg[attr][item], val));
   603		if (ret < 0)
   604			return ret;
   605	
   606		if (val)
   607			return regmap_update_bits(regmap, SQ52210_ALERT_CONFIG,
   608						alert_group, sq52210_alert_mask[attr][item]);
   609		return 0;
   610	}
   611	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


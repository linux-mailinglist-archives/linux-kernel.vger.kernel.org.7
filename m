Return-Path: <linux-kernel+bounces-758205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E75FB1CC72
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 21:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F03F5649EB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 19:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB7D29E0F2;
	Wed,  6 Aug 2025 19:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R4PQ/vT5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0D6215F6C;
	Wed,  6 Aug 2025 19:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754508105; cv=none; b=o8CEb5soQjVqYDR+DjIGeSZfJL660mXYH3ibpxu2M4OhNdtc3BvDVmF1qD/VgKRRyBXIQjBTOicj7vQReN8v/RbT/joHYZsYkAWOo0KNNRNm0PenQldAq6oxr7OJtn6MA+ZTuhF/VkKx/quVsP3Smk52Akd7paJCKrPOB1/9feQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754508105; c=relaxed/simple;
	bh=VfzJFYG0I6fueKmtnfKXQH8Nl+odnLVfzpNrbWBlEbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QsYBwkxH1jIThy8jN/q6SUZZVaRYcHFkNJIuW3mTWquNtFmY9Gwfz6oYwSR/PTd9HbOTsSMyM3hvt8UGzqPJJ15zmVNkK13Gbt9/0IMCw1NgvOHDxTRTty7bn7je5/B1TvsHxzbWFoa7Voxc9UMv0C+JNrxK5g0P7x/4HcRZFFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R4PQ/vT5; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754508100; x=1786044100;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VfzJFYG0I6fueKmtnfKXQH8Nl+odnLVfzpNrbWBlEbU=;
  b=R4PQ/vT5AsKvni4FQErDp0fLKPbPbSrePT8bh8zXtPeOTRavVGqAV/Xa
   AxmKC11yHEvnso96eeIIun6wnnKG+JlU+LyrqTtDHqfdP2maCPhLM+hT8
   ZaRFbn8muykp4pMk04e1wUkHB9UupFqbiKuZO/7cmQzecIq4IvonOUyg4
   Z5+zhXPND0cHdJAMKeYwQFxJwxkLgl+erbZVicmlztJeS3IrT66BdzGNa
   9qfQPY+hWlPnTjr9aDW6GYTKhnBu/mA8lcWYmltnAEmOi7RE/SbsNzFEy
   Uf+TyZKhMRcRtras8LV8Pz7pM5fGNdRWs0wYx9htevpVJk7QTfRQIy/6p
   w==;
X-CSE-ConnectionGUID: Kj07cUgnRRq/R2Ci523Prw==
X-CSE-MsgGUID: pIXsAx4qSvmpiUzXw8PW4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="55873386"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="55873386"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 12:21:39 -0700
X-CSE-ConnectionGUID: CiIBJemYQAKeE8htM1CPDg==
X-CSE-MsgGUID: BHAGgQ0LQJm7nBXeAiKfqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="165194039"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 06 Aug 2025 12:21:37 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ujjhe-00020k-2E;
	Wed, 06 Aug 2025 19:21:34 +0000
Date: Thu, 7 Aug 2025 03:21:33 +0800
From: kernel test robot <lkp@intel.com>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>, jdelvare@suse.com,
	linux@roeck-us.net, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: Re: [PATCH 2/2] hwmon: (ina780) Add driver for TI INA780
Message-ID: <202508070319.QMV6021c-lkp@intel.com>
References: <20250806005127.542298-2-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806005127.542298-2-chris.packham@alliedtelesis.co.nz>

Hi Chris,

kernel test robot noticed the following build warnings:

[auto build test WARNING on groeck-staging/hwmon-next]
[also build test WARNING on linus/master v6.16 next-20250806]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chris-Packham/hwmon-ina780-Add-driver-for-TI-INA780/20250806-115131
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20250806005127.542298-2-chris.packham%40alliedtelesis.co.nz
patch subject: [PATCH 2/2] hwmon: (ina780) Add driver for TI INA780
config: x86_64-randconfig-072-20250807 (https://download.01.org/0day-ci/archive/20250807/202508070319.QMV6021c-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250807/202508070319.QMV6021c-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508070319.QMV6021c-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/hwmon/ina780.c: In function 'ina780_read_temp':
>> drivers/hwmon/ina780.c:293:18: warning: variable 'mask' set but not used [-Wunused-but-set-variable]
     293 |         int reg, mask;
         |                  ^~~~


vim +/mask +293 drivers/hwmon/ina780.c

   289	
   290	static int ina780_read_temp(struct device *dev, u32 attr, long *val)
   291	{
   292		struct ina780_data *data = dev_get_drvdata(dev);
 > 293		int reg, mask;
   294		int regval;
   295		int err;
   296	
   297		switch (attr) {
   298		case hwmon_temp_input:
   299			reg = INA780_DIETEMP;
   300			break;
   301		case hwmon_temp_max:
   302			reg = INA780_TEMP_LIMIT;
   303			break;
   304		case hwmon_temp_max_alarm:
   305			reg = INA780_DIAG_ALRT;
   306			mask = INA780_DIAG_ALRT_TMPOL;
   307			break;
   308		default:
   309			return -EOPNOTSUPP;
   310		}
   311	
   312		switch (attr) {
   313		case hwmon_temp_input:
   314		case hwmon_temp_max:
   315			err = regmap_read(data->regmap, reg, &regval);
   316			if (err)
   317				return err;
   318			*val = div_s64(((s64)((s16)regval) >> 4) * INA780_TEMP_LSB, 1000);
   319			break;
   320		case hwmon_temp_max_alarm:
   321			err = regmap_read(data->regmap, INA780_DIAG_ALRT, &regval);
   322			*val = !!(regval & INA780_DIAG_ALRT_TMPOL);
   323			break;
   324		}
   325	
   326		return 0;
   327	}
   328	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


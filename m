Return-Path: <linux-kernel+bounces-757927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA935B1C868
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98EE03AEFB3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A985928FA84;
	Wed,  6 Aug 2025 15:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NuCx0J6E"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E033AC1C;
	Wed,  6 Aug 2025 15:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754493140; cv=none; b=LAjIMOcPMO/5K8YEhPIB1xFh+ECl/hIrjWzrUQVLoKXwomrBalqC2S8WofKN96Q6nIgf3jG8HKdoTAnODzHZBOh2BUD4cooZzSqV6iikLfP1KmZV22jP3mACw9zOT4hEkI2fwWFaaqZn36Aqah1hdANKziTV/mFA2RaVq+AuyLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754493140; c=relaxed/simple;
	bh=lRBTQ2sbJ+Nz/6xVV+Aj8nlYxa+/Em/Tzewzgn5Cdwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LuD70yQ5ARP+RTbd/WCvA3+TYBgFdQCrorvPp/ZyCdVv9h1Sv7yDQpPJS08tzppiCaR7fCtBZUQa1OT/ZHccO6DWb0IHXQ7aTcpuctS4ZBFwqnR54ZjE99pKyq4gbOWMNfb9oNyv8imN0cGZn7HBecBKjIef4+1279+ZZnznyH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NuCx0J6E; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754493137; x=1786029137;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lRBTQ2sbJ+Nz/6xVV+Aj8nlYxa+/Em/Tzewzgn5Cdwc=;
  b=NuCx0J6E5d9zJlAGYl4Pv8kl6lF+3C77jYYwFe5c4YxuMS7eO+xZR8rm
   s2Tah43H/SKtQvUj4h1Y2VRJOi4XEIBkF4AuqIaPEWf9FmiVbVhww2APo
   cnkpLVNpMRL1iZt8x0jBvoz1QdvRoRY1QzWR7OnyJkItmteA3lSJCtugm
   DT+J8kX0TLuYoK/E7AzYrE117jsTl71soYerDBkd8tPS6wEL73wTHqNQY
   6j5V/NrlZgpDotFCodzxGamLZ4Me6dhjHUGFjDj2GH212Lz9G/tSPdtqj
   vPB7nTVusZVTvLV60o7lG/vRkfaFSsYxWflN2lX+qlGSHN1eQurssKwlU
   A==;
X-CSE-ConnectionGUID: XtY8mxB3T4ejvbOmAm6k/Q==
X-CSE-MsgGUID: iixb1WhZSQ+SALm7lN2Gnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="67510052"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="67510052"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 08:12:16 -0700
X-CSE-ConnectionGUID: GHwkRMBmT5C0VJIjP7MXEg==
X-CSE-MsgGUID: u7AAnbzWQRqWomDHpkSwAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="170172564"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 06 Aug 2025 08:12:14 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ujfoI-0001oM-2l;
	Wed, 06 Aug 2025 15:12:10 +0000
Date: Wed, 6 Aug 2025 23:12:01 +0800
From: kernel test robot <lkp@intel.com>
To: "a.shimko" <artyom.shimko@gmail.com>, linux-hwmon@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, "a.shimko" <artyom.shimko@gmail.com>,
	linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
	cristian.marussi@arm.com, jdelvare@suse.com,
	guenter.roeck@linux.com
Subject: Re: [PATCH 1/3] hwmon: scmi: Add default case with debug output
Message-ID: <202508062201.bWDZGD03-lkp@intel.com>
References: <20250805125003.12573-2-artyom.shimko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805125003.12573-2-artyom.shimko@gmail.com>

Hi a.shimko,

kernel test robot noticed the following build errors:

[auto build test ERROR on groeck-staging/hwmon-next]
[also build test ERROR on linus/master v6.16 next-20250806]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/a-shimko/hwmon-scmi-Add-default-case-with-debug-output/20250806-122638
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20250805125003.12573-2-artyom.shimko%40gmail.com
patch subject: [PATCH 1/3] hwmon: scmi: Add default case with debug output
config: arc-randconfig-001-20250806 (https://download.01.org/0day-ci/archive/20250806/202508062201.bWDZGD03-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 12.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250806/202508062201.bWDZGD03-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508062201.bWDZGD03-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/hwmon/scmi-hwmon.c: In function 'scmi_hwmon_probe':
>> drivers/hwmon/scmi-hwmon.c:278:17: error: 'default' label not within a switch statement
     278 |                 default:
         |                 ^~~~~~~


vim +/default +278 drivers/hwmon/scmi-hwmon.c

   228	
   229	static int scmi_hwmon_probe(struct scmi_device *sdev)
   230	{
   231		int i, idx;
   232		u16 nr_sensors;
   233		enum hwmon_sensor_types type;
   234		struct scmi_sensors *scmi_sensors;
   235		const struct scmi_sensor_info *sensor;
   236		int nr_count[hwmon_max] = {0}, nr_types = 0, nr_count_temp = 0;
   237		const struct hwmon_chip_info *chip_info;
   238		struct device *hwdev, *dev = &sdev->dev;
   239		struct hwmon_channel_info *scmi_hwmon_chan;
   240		const struct hwmon_channel_info **ptr_scmi_ci;
   241		const struct scmi_handle *handle = sdev->handle;
   242		struct scmi_protocol_handle *ph;
   243	
   244		if (!handle)
   245			return -ENODEV;
   246	
   247		sensor_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_SENSOR, &ph);
   248		if (IS_ERR(sensor_ops))
   249			return PTR_ERR(sensor_ops);
   250	
   251		nr_sensors = sensor_ops->count_get(ph);
   252		if (!nr_sensors)
   253			return -EIO;
   254	
   255		scmi_sensors = devm_kzalloc(dev, sizeof(*scmi_sensors), GFP_KERNEL);
   256		if (!scmi_sensors)
   257			return -ENOMEM;
   258	
   259		scmi_sensors->ph = ph;
   260	
   261		for (i = 0; i < nr_sensors; i++) {
   262			sensor = sensor_ops->info_get(ph, i);
   263			if (!sensor)
   264				return -EINVAL;
   265	
   266			switch (sensor->type) {
   267			case TEMPERATURE_C:
   268			case VOLTAGE:
   269			case CURRENT:
   270			case POWER:
   271			case ENERGY:
   272				type = scmi_types[sensor->type];
   273				if (!nr_count[type])
   274					nr_types++;
   275				nr_count[type]++;
   276				break;
   277			}
 > 278			default:
   279				dev_dbg(dev, "Skipping unsupported sensor ID:%d Type:%d (%s)\n",
   280					i, sensor->type, sensor->name ? sensor->name : "unnamed");
   281				continue;
   282		}
   283	
   284		if (nr_count[hwmon_temp])
   285			nr_count_temp = nr_count[hwmon_temp];
   286	
   287		scmi_hwmon_chan = devm_kcalloc(dev, nr_types, sizeof(*scmi_hwmon_chan),
   288					       GFP_KERNEL);
   289		if (!scmi_hwmon_chan)
   290			return -ENOMEM;
   291	
   292		ptr_scmi_ci = devm_kcalloc(dev, nr_types + 1, sizeof(*ptr_scmi_ci),
   293					   GFP_KERNEL);
   294		if (!ptr_scmi_ci)
   295			return -ENOMEM;
   296	
   297		scmi_chip_info.info = ptr_scmi_ci;
   298		chip_info = &scmi_chip_info;
   299	
   300		for (type = 0; type < hwmon_max; type++) {
   301			if (!nr_count[type])
   302				continue;
   303	
   304			scmi_hwmon_add_chan_info(scmi_hwmon_chan, dev, nr_count[type],
   305						 type, hwmon_attributes[type]);
   306			*ptr_scmi_ci++ = scmi_hwmon_chan++;
   307	
   308			scmi_sensors->info[type] =
   309				devm_kcalloc(dev, nr_count[type],
   310					     sizeof(*scmi_sensors->info), GFP_KERNEL);
   311			if (!scmi_sensors->info[type])
   312				return -ENOMEM;
   313		}
   314	
   315		for (i = nr_sensors - 1; i >= 0 ; i--) {
   316			sensor = sensor_ops->info_get(ph, i);
   317			if (!sensor)
   318				continue;
   319	
   320			switch (sensor->type) {
   321			case TEMPERATURE_C:
   322			case VOLTAGE:
   323			case CURRENT:
   324			case POWER:
   325			case ENERGY:
   326				type = scmi_types[sensor->type];
   327				idx = --nr_count[type];
   328				*(scmi_sensors->info[type] + idx) = sensor;
   329				break;
   330			default:
   331				dev_dbg(dev, "Skipping unsupported sensor ID:%d Type:%d (%s)\n",
   332					i, sensor->type, sensor->name ? sensor->name : "unnamed");
   333				continue;
   334			}
   335		}
   336	
   337		hwdev = devm_hwmon_device_register_with_info(dev, "scmi_sensors",
   338							     scmi_sensors, chip_info,
   339							     NULL);
   340		if (IS_ERR(hwdev))
   341			return PTR_ERR(hwdev);
   342	
   343		for (i = 0; i < nr_count_temp; i++) {
   344			int ret;
   345	
   346			sensor = *(scmi_sensors->info[hwmon_temp] + i);
   347			if (!sensor)
   348				continue;
   349	
   350			/*
   351			 * Warn on any misconfiguration related to thermal zones but
   352			 * bail out of probing only on memory errors.
   353			 */
   354			ret = scmi_thermal_sensor_register(dev, ph, sensor);
   355			if (ret) {
   356				if (ret == -ENOMEM)
   357					return ret;
   358				dev_warn(dev,
   359					 "Thermal zone misconfigured for %s. err=%d\n",
   360					 sensor->name, ret);
   361			}
   362		}
   363	
   364		return 0;
   365	}
   366	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


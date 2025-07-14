Return-Path: <linux-kernel+bounces-730855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 885F9B04B06
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 00:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C36443B7275
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 22:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C6E233712;
	Mon, 14 Jul 2025 22:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hc4iOhSQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F66822F152
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 22:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752533375; cv=none; b=DjK0nWqTBit+hL1y84phqmQZljZrSvFyPboMH30MggRDF5PRy0r1EgZFE8pt77Z0aSkE12RYB9YW2krF0X9gjH1oZcCg6U3rZtq4EiYgjfda/I9nt0gjlJI0eJq3Sg5MqksSirXgjWE+6BCEJe4CGFH/+gY4sZ9lpx4QPpWi668=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752533375; c=relaxed/simple;
	bh=sdrtmEaKjUsyBMg5s3VhIz8zPd0e41+pq19DXeFUsmA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fZGHwa+Plc2TT5b6ujhuQamuZncZY1QrFBGyvSxvnvc61gW4OlUWdEHSJLup59PEXfhjWHe0tVP/zvvhxEKhlh2tBxfkAdBOWgeXM7DL1rqApsxuUZf0z3HM2+tuYxrTz3qNQwWsblPejw0sxJdzhbAhPuGAfhLRfGxO4lnKbe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hc4iOhSQ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752533373; x=1784069373;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sdrtmEaKjUsyBMg5s3VhIz8zPd0e41+pq19DXeFUsmA=;
  b=hc4iOhSQmo91v0iP+FgGinSwgXfgm89pVDd4c7BZQB81ADz/ffkgbf/F
   /EX9tz9XDFf9EpSacFDgLywRNRO/s3Dd+kK5OLli1j/U4wTOnQ/0BUOAd
   ps1DdRnVxlPGWta3ACvexgsxJJ6zUfTlRXCI9LKpUtJyl4Pz4mPMJzet9
   csoBQWq7IqaG43VJHqOLizVPAiaDaJIgfImhwxlB7H1eeDPCqLfnG49R8
   igK58y/6/0Krc+c/JX1BQ9L+f+z8Ve0LsK/13DRpGxG7hYvhXOoxm2/Lp
   ya8BcDNu/wSsNj09xKb2BywtS3r3nEIvWBT6GRYjKbMrsp6hT+CpL3zUl
   A==;
X-CSE-ConnectionGUID: Zxq+MShNShKWeH7BWty4RA==
X-CSE-MsgGUID: 6yfCi4LpTsOw4X752bqvCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54711054"
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="54711054"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 15:49:33 -0700
X-CSE-ConnectionGUID: +JzEyOlGSTWFSv0grsrfIA==
X-CSE-MsgGUID: 93haTxWbROaKu5KhBJtSAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="157602070"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 14 Jul 2025 15:49:31 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ubRzF-0009Q7-1T;
	Mon, 14 Jul 2025 22:49:29 +0000
Date: Tue, 15 Jul 2025 06:48:59 +0800
From: kernel test robot <lkp@intel.com>
To: Asad Kamal <asad.kamal@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>
Subject: drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c:273:5-8:
 Unneeded variable: "ret". Return "0" on line 329
Message-ID: <202507150618.WOfvWsQF-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   347e9f5043c89695b01e66b3ed111755afcf1911
commit: 0b4119d54b17618c2ddb04a2af5bf5ebe24121e3 drm/amd/pm: Use separate metrics table for smu_v13_0_12
date:   5 months ago
config: arm-randconfig-r064-20250714 (https://download.01.org/0day-ci/archive/20250715/202507150618.WOfvWsQF-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 01c97b4953e87ae455bd4c41e3de3f0f0f29c61c)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507150618.WOfvWsQF-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c:273:5-8: Unneeded variable: "ret". Return "0" on line 329

vim +273 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c

   265	
   266	int smu_v13_0_12_get_smu_metrics_data(struct smu_context *smu,
   267					      MetricsMember_t member,
   268					      uint32_t *value)
   269	{
   270		struct smu_table_context *smu_table = &smu->smu_table;
   271		MetricsTable_t *metrics = (MetricsTable_t *)smu_table->metrics_table;
   272		struct amdgpu_device *adev = smu->adev;
 > 273		int ret = 0;
   274		int xcc_id;
   275	
   276		/* For clocks with multiple instances, only report the first one */
   277		switch (member) {
   278		case METRICS_CURR_GFXCLK:
   279		case METRICS_AVERAGE_GFXCLK:
   280			xcc_id = GET_INST(GC, 0);
   281			*value = SMUQ10_ROUND(metrics->GfxclkFrequency[xcc_id]);
   282			break;
   283		case METRICS_CURR_SOCCLK:
   284		case METRICS_AVERAGE_SOCCLK:
   285			*value = SMUQ10_ROUND(metrics->SocclkFrequency[0]);
   286			break;
   287		case METRICS_CURR_UCLK:
   288		case METRICS_AVERAGE_UCLK:
   289			*value = SMUQ10_ROUND(metrics->UclkFrequency);
   290			break;
   291		case METRICS_CURR_VCLK:
   292			*value = SMUQ10_ROUND(metrics->VclkFrequency[0]);
   293			break;
   294		case METRICS_CURR_DCLK:
   295			*value = SMUQ10_ROUND(metrics->DclkFrequency[0]);
   296			break;
   297		case METRICS_CURR_FCLK:
   298			*value = SMUQ10_ROUND(metrics->FclkFrequency);
   299			break;
   300		case METRICS_AVERAGE_GFXACTIVITY:
   301			*value = SMUQ10_ROUND(metrics->SocketGfxBusy);
   302			break;
   303		case METRICS_AVERAGE_MEMACTIVITY:
   304			*value = SMUQ10_ROUND(metrics->DramBandwidthUtilization);
   305			break;
   306		case METRICS_CURR_SOCKETPOWER:
   307			*value = SMUQ10_ROUND(metrics->SocketPower) << 8;
   308			break;
   309		case METRICS_TEMPERATURE_HOTSPOT:
   310			*value = SMUQ10_ROUND(metrics->MaxSocketTemperature) *
   311				 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
   312			break;
   313		case METRICS_TEMPERATURE_MEM:
   314			*value = SMUQ10_ROUND(metrics->MaxHbmTemperature) *
   315				 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
   316			break;
   317		/* This is the max of all VRs and not just SOC VR.
   318		 * No need to define another data type for the same.
   319		 */
   320		case METRICS_TEMPERATURE_VRSOC:
   321			*value = SMUQ10_ROUND(metrics->MaxVrTemperature) *
   322				 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
   323			break;
   324		default:
   325			*value = UINT_MAX;
   326			break;
   327		}
   328	
 > 329		return ret;
   330	}
   331	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


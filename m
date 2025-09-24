Return-Path: <linux-kernel+bounces-830200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF09B990A4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA0D219C4A6E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFD82D5920;
	Wed, 24 Sep 2025 09:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K1313W5G"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DCC28136C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758704932; cv=none; b=arovsUqo5jlUu/3yu0Cv33TDBN3XDQFKB+3zOSLrJ8OGpKssi44syYjg5VtXJ9tA9Q+U8xSGJ3jHUdZJTMEYGbrzD8S8u+SFSb9/OCg05IbxVlW6Bs9wFS+rM9A5JbRqhu/UQkTJFcj9oY/8l5BaL3AsGxtRbdxZm7pqHmxiUM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758704932; c=relaxed/simple;
	bh=1MgvMv9h0OriM8gy/nKKNmpK7QrgpGGKXgdUP3eVUDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzRI+oXOLW4UzxsKYy5n4kocJv9k0HfzbS4qCdiVdkRPa8Q4kU/SdwADBYNtB4K4V0rWvZ046RUI96vnelJ4sfPWMG7+B2xKazncKteIK89m1zBVgsVbyeQ6XQtsGE/DtFYbTceLi8FXHjWLyJc6EvgOnezLx9pd38l2krNxID0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K1313W5G; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758704930; x=1790240930;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1MgvMv9h0OriM8gy/nKKNmpK7QrgpGGKXgdUP3eVUDc=;
  b=K1313W5GT+BAR4kGlbj5nn4z/0SocqPe0rZgehkZx64WLdDRigH0WUWH
   WReTE7jIq3w2+GYoKuKcIMPpV/q9dOXK+/KYMc7xMsR5pV9u3XcpbNAW8
   TwNAJUTXNz9bmhpE9nLWODg+eVVbDQmoyXSy0FtqWdbUi56fC1Snm/8X3
   /gwXLaoiTWmHMDN30Yu1Wlxvm26FyDDAQLOK3g0F1O7J8QuMOoF2bc/1z
   RJBmWfFF9rUPgxh4DoGHIk6MPfTLuJRklJ+xCq+pUIxWKWNpaK3IznsNQ
   Vh/71pgjJgklXdXRfxIOi2F8XyQ5jTvtYB1SOI/K5mXaw/LNO/Gq1NMmQ
   Q==;
X-CSE-ConnectionGUID: aqJQGeciQPqP9UsDtdcDYA==
X-CSE-MsgGUID: r2Q/6aLvQZyoL38dPuesgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61049644"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61049644"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 02:08:50 -0700
X-CSE-ConnectionGUID: gSc+gX5rSHiKkn8wJCBsQg==
X-CSE-MsgGUID: flb32M3vRO6n+Dq+IpWMGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="182266182"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 24 Sep 2025 02:08:45 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v1LUR-0003y9-1T;
	Wed, 24 Sep 2025 09:08:43 +0000
Date: Wed, 24 Sep 2025 17:08:23 +0800
From: kernel test robot <lkp@intel.com>
To: Yongbang Shi <shiyongbang@huawei.com>, xinliang.liu@linaro.org,
	tiantao6@hisilicon.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	daniel@ffwll.ch, kong.kongxinwei@hisilicon.com,
	dmitry.baryshkov@oss.qualcomm.com
Cc: oe-kbuild-all@lists.linux.dev, liangjian010@huawei.com,
	chenjianmin@huawei.com, fengsheng5@huawei.com,
	shiyongbang@huawei.com, libaihan@huawei.com, shenjian15@huawei.com,
	shaojijie@huawei.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 drm-dp 1/4] drm/hisilicon/hibmc: fix dp
 probabilistical detect errors after HPD irq
Message-ID: <202509241625.o4mNleVb-lkp@intel.com>
References: <20250923130411.2522339-2-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923130411.2522339-2-shiyongbang@huawei.com>

Hi Yongbang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on linus/master v6.17-rc7 next-20250923]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yongbang-Shi/drm-hisilicon-hibmc-fix-dp-probabilistical-detect-errors-after-HPD-irq/20250923-211652
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20250923130411.2522339-2-shiyongbang%40huawei.com
patch subject: [PATCH v7 drm-dp 1/4] drm/hisilicon/hibmc: fix dp probabilistical detect errors after HPD irq
config: s390-randconfig-001-20250924 (https://download.01.org/0day-ci/archive/20250924/202509241625.o4mNleVb-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250924/202509241625.o4mNleVb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509241625.o4mNleVb-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c: In function 'hibmc_dp_detect':
>> drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c:61:18: warning: array subscript 128 is above array bounds of 'u8[15]' {aka 'unsigned char[15]'} [-Warray-bounds]
         dp_dev->dpcd[DP_DOWNSTREAM_PORT_0] & DP_DS_PORT_HPD) {
         ~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~


vim +61 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c

    34	
    35	static int hibmc_dp_detect(struct drm_connector *connector,
    36				   struct drm_modeset_acquire_ctx *ctx, bool force)
    37	{
    38		struct hibmc_dp *dp = to_hibmc_dp(connector);
    39		struct hibmc_dp_dev *dp_dev = dp->dp_dev;
    40		int ret;
    41	
    42		if (dp->irq_status) {
    43			if (dp_dev->hpd_status != HIBMC_HPD_IN)
    44				return connector_status_disconnected;
    45		}
    46	
    47		ret = drm_dp_read_dpcd_caps(dp_dev->aux, dp_dev->dpcd);
    48		if (ret)
    49			return connector_status_disconnected;
    50	
    51		dp_dev->is_branch = drm_dp_is_branch(dp_dev->dpcd);
    52	
    53		ret = drm_dp_read_desc(dp_dev->aux, &dp_dev->desc, dp_dev->is_branch);
    54		if (ret)
    55			return connector_status_disconnected;
    56	
    57		if (!dp_dev->is_branch)
    58			return connector_status_connected;
    59	
    60		if (drm_dp_read_sink_count_cap(connector, dp_dev->dpcd, &dp_dev->desc) &&
  > 61		    dp_dev->dpcd[DP_DOWNSTREAM_PORT_0] & DP_DS_PORT_HPD) {
    62			ret = drm_dp_read_sink_count(dp_dev->aux);
    63			if (ret > 0)
    64				return connector_status_connected;
    65		}
    66	
    67		return connector_status_disconnected;
    68	}
    69	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


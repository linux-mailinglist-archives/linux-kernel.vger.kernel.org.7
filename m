Return-Path: <linux-kernel+bounces-761961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79888B20071
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F9EC1892666
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FA02D97B7;
	Mon, 11 Aug 2025 07:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GsqCdSh+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB3C18CC13
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754897897; cv=none; b=GgdBZ0s7CDuwQvlbnpF1CZUwgYCpOxXhdyWG3AWA4oDFFIzZbb7Nmz87cSiAfOpvMZnV0iTihKSsSrnwKzk/hQ2j2DjzMrstEe0HsvwCjegDcb35MZMA9iL1x4/5oiFZMz0jfZELr1098iOETtORm1/LukNTt2YXqhJxOu6fZco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754897897; c=relaxed/simple;
	bh=3JpJ6Jalyc/Z75TZtTL2bSln3Lv3ACasAx22cTuSofY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MqZ2vv1lqn+ZhAJOkyMZHis8hEdHgzqHgsZP7Wo/PckBSVoz6vk+8zNJN4/JRrdXOYfi3vnrv2wLtnmM7lxyDnDu49VTcR9OIufOwDZ8YAIMSzCRH/ysbaLPcX/lWWsv5fbroIT5tWqAqHOdXr8Eq0cUDBtaBiHZ8b3Onn+NjYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GsqCdSh+; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754897896; x=1786433896;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3JpJ6Jalyc/Z75TZtTL2bSln3Lv3ACasAx22cTuSofY=;
  b=GsqCdSh+svwUN7QBeqnc7mAMSSATtrXFtDIr41WoP2kw2xrfAxRUZxuI
   /r0X9gWtUDju39+oG1ABni7ZD0VzfKmKpGtCQsovI+sGm6enMghYWlkGf
   OmWebDDRTEHJ5pY2o8FLPFYn7vP3ASnmLSwaRnPz6q9m9YqOykc/RUKbj
   1m2gUiGfHXksc5KAyrCs7cUFG6Lws+W4LwwLvDC8c3VzWR2m0aFuBln/V
   K+TSgND+duQIdBhkpd3HpxvgFS9NHlpr+CivE+vqPWV/XQpdBt3cuaJQN
   1Yp8nxxUbqgIwUtyaJHM4Svrt5cSVrhojHl04WTrZLPpYPGH5NqoWfhdL
   w==;
X-CSE-ConnectionGUID: DJ1N/ZFrSCegfQTjOFa2gg==
X-CSE-MsgGUID: 83PtJDQwSga156pgmOIdCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="56174423"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="56174423"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 00:38:16 -0700
X-CSE-ConnectionGUID: zvVXOCzmRUWLs8w+p1Ksyg==
X-CSE-MsgGUID: o3W9HkPuSKiKNQUtk/wF6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="170285304"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 11 Aug 2025 00:38:13 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ulN6W-0005dU-37;
	Mon, 11 Aug 2025 07:38:10 +0000
Date: Mon, 11 Aug 2025 15:36:33 +0800
From: kernel test robot <lkp@intel.com>
To: Rahul Kumar <rk0006818@gmail.com>, liviu.dudau@arm.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org, rk0006818@gmail.com
Subject: Re: [PATCH] drm/komeda: Convert logging in komeda_crtc.c to drm_*
 with drm_device parameter
Message-ID: <202508111503.saEElm01-lkp@intel.com>
References: <20250811054459.15851-1-rk0006818@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811054459.15851-1-rk0006818@gmail.com>

Hi Rahul,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.17-rc1 next-20250808]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rahul-Kumar/drm-komeda-Convert-logging-in-komeda_crtc-c-to-drm_-with-drm_device-parameter/20250811-134646
base:   linus/master
patch link:    https://lore.kernel.org/r/20250811054459.15851-1-rk0006818%40gmail.com
patch subject: [PATCH] drm/komeda: Convert logging in komeda_crtc.c to drm_* with drm_device parameter
config: riscv-randconfig-001-20250811 (https://download.01.org/0day-ci/archive/20250811/202508111503.saEElm01-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250811/202508111503.saEElm01-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508111503.saEElm01-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/arm/display/komeda/komeda_crtc.c: In function 'komeda_attach_bridge':
>> drivers/gpu/drm/arm/display/komeda/komeda_crtc.c:619:37: error: 'struct komeda_dev' has no member named 'drm'
     struct drm_device *drm = pipe->mdev->drm;
                                        ^~


vim +619 drivers/gpu/drm/arm/display/komeda/komeda_crtc.c

   615	
   616	static int komeda_attach_bridge(struct komeda_pipeline *pipe,
   617					struct drm_encoder *encoder)
   618	{
 > 619		struct drm_device *drm = pipe->mdev->drm;
   620		struct device *dev = drm->dev;
   621		struct drm_bridge *bridge;
   622		int err;
   623	
   624		bridge = devm_drm_of_get_bridge(dev, pipe->of_node,
   625						KOMEDA_OF_PORT_OUTPUT, 0);
   626		if (IS_ERR(bridge))
   627			return dev_err_probe(dev, PTR_ERR(bridge), "remote bridge not found for pipe: %s\n",
   628					     of_node_full_name(pipe->of_node));
   629	
   630		err = drm_bridge_attach(encoder, bridge, NULL, 0);
   631		if (err)
   632			drm_err(drm, "bridge_attach() failed for pipe: %s\n",
   633				of_node_full_name(pipe->of_node));
   634	
   635		return err;
   636	}
   637	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


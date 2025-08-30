Return-Path: <linux-kernel+bounces-792942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CABF4B3CABA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 14:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E843E7AB13E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 12:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DDA279DA3;
	Sat, 30 Aug 2025 12:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RCeHN1Pz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368FE271457
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 12:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756555777; cv=none; b=h/Vyq0s5IytqkGEOOXwXw10c6tnhEW3iHu4kiGB1xsiCasa/wEUYmq4hi1sqZrXAlYYw+GHuqgAkdKMIqDxUuV50oY3UuPQeb7iUo9I2YQQTkrEbrCCNt7foAZ5Szv7A4CBW9my8exmyBeNC1s5JbdFeX2yAPAyjmjTul6vSeTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756555777; c=relaxed/simple;
	bh=8P4WrA/SJEy/L79/DSQB7imWaic2ObRv8kUO/ujofXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZdTH5mY/wnooajljR7u9qQZot8H708khSNYmLTOxftSg+KEiE5ZbjqwePKFf4rKP0uVfzaLlf5ibOvfiZWkg75wfvaSIxb3GpKmSHhVOpNJ+Ra4xh6bvMcS2BXubzFdgacxiE+UIDG0zdd2mkA8a00lJDzLooNwWOGmdOy4Xxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RCeHN1Pz; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756555776; x=1788091776;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8P4WrA/SJEy/L79/DSQB7imWaic2ObRv8kUO/ujofXI=;
  b=RCeHN1PzFD25Q2pUhJVnUNPXTowML2pGksAOhwS/9cG6T5Nm0aoFnwou
   O7L8w3W82NlI1IL9/mKjGaLz7wbL92VbO1XmAwgovH4rbg/aBWcVFtTcN
   xj5SM0uMwVGLQ5Yh/eujbRepfziBk4eA6flnfj1+xH81bPrMkFpDffNls
   KH5TjKzuKbylNTRYSpfYQ4Q58xnCOmx8qOjGtARVsoxKs4Y1vxrEYkswe
   ZOxZzP+0iipPhD2r5e47eiM2pN5HkVXOADaWuScabA18EWaAHZ8+alBxj
   cs0GSPRPQKQ+k0OqB70FyjNAG/USG3EclR7eVDff0ksHwoc/HBobVkPGg
   w==;
X-CSE-ConnectionGUID: PTUtPPuBQJKLPe02o+oMJA==
X-CSE-MsgGUID: s44nPd9WSDamRD+ebI6X2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11537"; a="58020644"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="58020644"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2025 05:09:36 -0700
X-CSE-ConnectionGUID: cxMSSuYbTdiZoHRafIE+eQ==
X-CSE-MsgGUID: yliCIGqCQUeXg95YXH3hEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="170151300"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 30 Aug 2025 05:09:28 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1usKON-000VLN-2J;
	Sat, 30 Aug 2025 12:09:13 +0000
Date: Sat, 30 Aug 2025 20:08:13 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Baryshkov <lumag@kernel.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Sandy Huang <hjc@rock-chips.com>,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>, Chen-Yu Tsai <wens@csie.org>,
	Samuel Holland <samuel@sholland.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Liu Ying <victor.liu@nxp.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 07/11] drm/rockchip: rk3066: declare supported
 infoframes
Message-ID: <202508301909.DvZIl8j0-lkp@intel.com>
References: <20250830-drm-limit-infoframes-v3-7-32fcbec4634e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250830-drm-limit-infoframes-v3-7-32fcbec4634e@oss.qualcomm.com>

Hi Dmitry,

kernel test robot noticed the following build errors:

[auto build test ERROR on f4028ef65dc4fe9010bcc017597fe0fea6479097]

url:    https://github.com/intel-lab-lkp/linux/commits/Dmitry-Baryshkov/drm-connector-let-drivers-declare-infoframes-as-unsupported/20250830-082533
base:   f4028ef65dc4fe9010bcc017597fe0fea6479097
patch link:    https://lore.kernel.org/r/20250830-drm-limit-infoframes-v3-7-32fcbec4634e%40oss.qualcomm.com
patch subject: [PATCH v3 07/11] drm/rockchip: rk3066: declare supported infoframes
config: i386-buildonly-randconfig-002-20250830 (https://download.01.org/0day-ci/archive/20250830/202508301909.DvZIl8j0-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250830/202508301909.DvZIl8j0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508301909.DvZIl8j0-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/rockchip/rk3066_hdmi.c:699:15: error: no member named 'supported_infoframes' in 'struct drm_bridge'; did you mean 'supported_formats'?
     699 |         hdmi->bridge.supported_infoframes = DRM_CONNECTOR_INFOFRAME_AVI;
         |                      ^~~~~~~~~~~~~~~~~~~~
         |                      supported_formats
   include/drm/drm_bridge.h:1199:15: note: 'supported_formats' declared here
    1199 |         unsigned int supported_formats;
         |                      ^
   1 error generated.


vim +699 drivers/gpu/drm/rockchip/rk3066_hdmi.c

   666	
   667	static int
   668	rk3066_hdmi_register(struct drm_device *drm, struct rk3066_hdmi *hdmi)
   669	{
   670		struct drm_encoder *encoder = &hdmi->encoder.encoder;
   671		struct device *dev = hdmi->dev;
   672		int ret;
   673	
   674		encoder->possible_crtcs =
   675			drm_of_find_possible_crtcs(drm, dev->of_node);
   676	
   677		/*
   678		 * If we failed to find the CRTC(s) which this encoder is
   679		 * supposed to be connected to, it's because the CRTC has
   680		 * not been registered yet.  Defer probing, and hope that
   681		 * the required CRTC is added later.
   682		 */
   683		if (encoder->possible_crtcs == 0)
   684			return -EPROBE_DEFER;
   685	
   686		drm_encoder_helper_add(encoder, &rk3066_hdmi_encoder_helper_funcs);
   687		drm_simple_encoder_init(drm, encoder, DRM_MODE_ENCODER_TMDS);
   688	
   689		hdmi->bridge.driver_private = hdmi;
   690		hdmi->bridge.funcs = &rk3066_hdmi_bridge_funcs;
   691		hdmi->bridge.ops = DRM_BRIDGE_OP_DETECT |
   692				   DRM_BRIDGE_OP_EDID |
   693				   DRM_BRIDGE_OP_HDMI |
   694				   DRM_BRIDGE_OP_HPD;
   695		hdmi->bridge.of_node = hdmi->dev->of_node;
   696		hdmi->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
   697		hdmi->bridge.vendor = "Rockchip";
   698		hdmi->bridge.product = "RK3066 HDMI";
 > 699		hdmi->bridge.supported_infoframes = DRM_CONNECTOR_INFOFRAME_AVI;
   700	
   701		hdmi->bridge.ddc = rk3066_hdmi_i2c_adapter(hdmi);
   702		if (IS_ERR(hdmi->bridge.ddc))
   703			return PTR_ERR(hdmi->bridge.ddc);
   704	
   705		if (IS_ERR(hdmi->bridge.ddc))
   706			return PTR_ERR(hdmi->bridge.ddc);
   707	
   708		ret = devm_drm_bridge_add(dev, &hdmi->bridge);
   709		if (ret)
   710			return ret;
   711	
   712		ret = drm_bridge_attach(encoder, &hdmi->bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
   713		if (ret)
   714			return ret;
   715	
   716		hdmi->connector = drm_bridge_connector_init(drm, encoder);
   717		if (IS_ERR(hdmi->connector)) {
   718			ret = PTR_ERR(hdmi->connector);
   719			dev_err(hdmi->dev, "failed to init bridge connector: %d\n", ret);
   720			return ret;
   721		}
   722	
   723		drm_connector_attach_encoder(hdmi->connector, encoder);
   724	
   725		return 0;
   726	}
   727	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


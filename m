Return-Path: <linux-kernel+bounces-893181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F45C46B89
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 138E03AB82C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C5230F946;
	Mon, 10 Nov 2025 12:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GZZ4Kj8L"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1907528B415
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762779288; cv=none; b=rZ7gYdPxXXxtdJBh89bsCSObKIMBtH95Dy1saRn40czu/iymeMZuEyDgOAHFwvpVamxznB2ugoY8WouxaBPPTRR4n+FvY26ZfFUnVGIp3Dlq9iJFXv2iTOBfD1M9kJ2M7SlTfG9NQH6/YnFb/jmKUf5BDw0KWGN6gP/9AsFaIpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762779288; c=relaxed/simple;
	bh=LceTUXC28nXD3e8rEzN7LaIgUS9MezvhavZ1gZPgnJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/KU8BY8FuuHfUtTJZuv9VYf7pdNLfT95tUWI+8S1QpjIVKiYhbhi7CQDTKekdTWskiqAt6QYOmllJraF8+esfhpjRTwDaCfx88zp/d1ifGYI6UG0rVac3slalzJp7wVbOdvn+gN4hmYQiAE95P0FPsEuN/b22hj20jPMYCwdZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GZZ4Kj8L; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762779287; x=1794315287;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LceTUXC28nXD3e8rEzN7LaIgUS9MezvhavZ1gZPgnJ0=;
  b=GZZ4Kj8LpVlCq4QpxdAtzQEr4rW62dznmEfm51EPowXusAFO7o18/iBs
   sAWzXaK95NdLfSAoEmuQVCb2tIZrxlKuOfaUJSZXUCxAdbDLQ9SpAyYkf
   0kksmzJmAk27KinUd/D2J5yjlgM4IA49jTsyj+lBBxpUQRXKbBg2R8Wlv
   jQ71ZeIcYdPUtxFV3KnNmZftBlP3XTvHtufPIGhJxdmvHhQ7iaD6f0U11
   cWkDWUVzaqgcKvgtdBIVF/EqfoCb2Y3Kl6RKYeMmoaEu3x992MzzGaxVC
   YSLvNLzMGO9Q0zuIrXeyjx9LxSXRMHGrlJ4eu11ce3y3ZlUMdoFV7dFMP
   Q==;
X-CSE-ConnectionGUID: Ej3Wl/qwRMynaGXFX1gEbw==
X-CSE-MsgGUID: aEbor5B6Q866ZnmQEy0FfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="75120665"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="75120665"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 04:54:47 -0800
X-CSE-ConnectionGUID: kijYiySdT2+h9WcO4OFcjA==
X-CSE-MsgGUID: fgKP6SGoTC2ERuKHImaqSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="219393118"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 10 Nov 2025 04:54:44 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vIRPt-0000RH-2l;
	Mon, 10 Nov 2025 12:54:41 +0000
Date: Mon, 10 Nov 2025 20:54:19 +0800
From: kernel test robot <lkp@intel.com>
To: oushixiong1025@163.com,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Shixiong Ou <oushixiong@kylinos.cn>, Tiger Liu <liuyihu@kylinos.cn>
Subject: Re: [PATCH] drm/fb-helper: add fbdev screen expended mode display
 support
Message-ID: <202511102026.2kvJOVYL-lkp@intel.com>
References: <20251107092641.111431-1-oushixiong1025@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107092641.111431-1-oushixiong1025@163.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on linus/master v6.18-rc5 next-20251110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/oushixiong1025-163-com/drm-fb-helper-add-fbdev-screen-expended-mode-display-support/20251107-172927
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20251107092641.111431-1-oushixiong1025%40163.com
patch subject: [PATCH] drm/fb-helper: add fbdev screen expended mode display support
config: arm-randconfig-003-20251110 (https://download.01.org/0day-ci/archive/20251110/202511102026.2kvJOVYL-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251110/202511102026.2kvJOVYL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511102026.2kvJOVYL-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/drm_fb_helper.c:1509:3: warning: variable 'crtc_count' is uninitialized when used here [-Wuninitialized]
                   crtc_count++;
                   ^~~~~~~~~~
   drivers/gpu/drm/drm_fb_helper.c:1506:16: note: initialize the variable 'crtc_count' to silence this warning
           u32 crtc_count;
                         ^
                          = 0
   1 warning generated.


vim +/crtc_count +1509 drivers/gpu/drm/drm_fb_helper.c

  1492	
  1493	/*
  1494	 * Check if the device supports extended mode
  1495	 *
  1496	 * return true if the device supports extended mode,
  1497	 * otherwise return false.
  1498	 */
  1499	static bool drm_fb_helper_validate_extended_mode(struct drm_fb_helper *fb_helper,
  1500							 struct drm_fb_helper_surface_size *sizes)
  1501	{
  1502		struct drm_client_dev *client = &fb_helper->client;
  1503		struct drm_device *dev = fb_helper->dev;
  1504		struct drm_mode_config *config = &dev->mode_config;
  1505		struct drm_mode_set *mode_set;
  1506		u32 crtc_count;
  1507	
  1508		drm_client_for_each_modeset(mode_set, client) {
> 1509			crtc_count++;
  1510	
  1511			for (int j = 0; j < mode_set->num_connectors; j++) {
  1512				struct drm_connector *connector = mode_set->connectors[j];
  1513	
  1514				if (connector->has_tile) {
  1515					drm_dbg_kms(client->dev,
  1516						    "Don't support extended with tile mode connector yet\n");
  1517					return false;
  1518				}
  1519			}
  1520		}
  1521	
  1522		if (crtc_count < 2) {
  1523			drm_dbg_kms(client->dev,
  1524				    "Only support extended mode when device have mult-crtcs\n");
  1525			return false;
  1526		}
  1527	
  1528		if (drm_fbdev_screen_mode == SCREEN_EXPAND_HORIZONTAL) {
  1529			u32 x = 0;
  1530	
  1531			drm_client_for_each_modeset(mode_set, client) {
  1532				struct drm_display_mode *desired_mode;
  1533	
  1534				desired_mode = mode_set->mode;
  1535				x = mode_set->x;
  1536				sizes->fb_width = sizes->surface_width  += desired_mode->hdisplay;
  1537				sizes->surface_height =
  1538					min_t(u32, desired_mode->vdisplay + mode_set->y,
  1539					      sizes->surface_height);
  1540				sizes->fb_height = min_t(u32, desired_mode->vdisplay + mode_set->y,
  1541							 sizes->fb_height);
  1542			}
  1543			sizes->fb_width = sizes->surface_width += x;
  1544	
  1545			if (sizes->fb_width > config->max_width) {
  1546				drm_dbg_kms(client->dev,
  1547					    "screen_buffer total width %d > config width %d\n",
  1548					    sizes->fb_width, config->max_width);
  1549				return false;
  1550			}
  1551		} else if (drm_fbdev_screen_mode == SCREEN_EXPAND_VERTICAL) {
  1552			u32 y = 0;
  1553	
  1554			drm_client_for_each_modeset(mode_set, client) {
  1555				struct drm_display_mode *desired_mode;
  1556	
  1557				desired_mode = mode_set->mode;
  1558				y = mode_set->y;
  1559				sizes->fb_height = sizes->surface_height += desired_mode->vdisplay;
  1560				sizes->surface_width =
  1561					min_t(u32, desired_mode->hdisplay + mode_set->x,
  1562					      sizes->surface_width);
  1563				sizes->fb_width = min_t(u32, desired_mode->hdisplay + mode_set->x,
  1564							sizes->fb_width);
  1565			}
  1566			sizes->fb_height = sizes->surface_height += y;
  1567	
  1568			if (sizes->fb_height > config->max_height) {
  1569				drm_dbg_kms(client->dev,
  1570					    "screen_buffer_total_height %d > config height %d\n",
  1571					    sizes->fb_height, config->max_height);
  1572				return false;
  1573			}
  1574		} else {
  1575			return false;
  1576		}
  1577	
  1578		return true;
  1579	}
  1580	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-kernel+bounces-825140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4122CB8B19E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 21:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9EBC3B73E8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E774288530;
	Fri, 19 Sep 2025 19:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K/1XrRAe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE41A1E5B63;
	Fri, 19 Sep 2025 19:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758310772; cv=none; b=DXEFQ/TPsX7mWzj50JrQ3vUFwi3xFMGp89kg7GNiLSih4Pxzfd4OI1wW3b2ZnP0/0IfSTxofTyFXZo4RZtBfUB4Yi+1Jj1Eaqz6qjBkwMze8oi/wXY/WmyS02/rswUfka+FrocuwKMhIYOSEZ/dbDt9pEGtnOIP4M7ebRoaMx20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758310772; c=relaxed/simple;
	bh=pfrlJV7xT9mCTFBKlTyzmehnciaaG4sFS0+gOJkLiU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYu4dCWsf9/Vy/cnX597WSjy9P+zPo8LfeLeS/Ulxe1/izdlne6GBuOErupzohrtq0h8PzTMb+fmehmji4oNWpVQ+CXV3Whawn+zWsqJIEM5SpmjxWt3N2ceK3vUAiXYyc7BgZuS3vWWFeJQY5Pi55AuVrzwnF3y7jS9nprxcy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K/1XrRAe; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758310771; x=1789846771;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pfrlJV7xT9mCTFBKlTyzmehnciaaG4sFS0+gOJkLiU8=;
  b=K/1XrRAeUj4h01+D0mmxvPSUrPdhV6GDSSyCUxqzipVoYyZTjajnMStw
   zfnIU9kbWTWNrhJIMtisdR10ISDzHBXn6UEUrMONSaiFCi/oG6WafQaKU
   Nz83AW/Xd+J9naaL09dUc9NMyR2FLYw4ovDlN0bU8eptz+u1r+wtzX6uK
   kunYyXQsvMec/MmIXrQWr7uWBQpvy37JWS3i9bg05Z8yEu54Q02qtf2Zw
   E0W1bP7LjdkyzBe7VYEOft+zjGPumhuIKoUK6tOUXMakeg55qOpB/4g7/
   HEJks/oOO94HMeRqXdxzjva0CZgJ0HmL7c1l4UBCAsO1A1zPHLyXFqp8r
   Q==;
X-CSE-ConnectionGUID: w1mfhkUFRyuEXh/WOrF3YQ==
X-CSE-MsgGUID: EL/EEtEMSeGmGfYlBE3EcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64465234"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64465234"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 12:39:31 -0700
X-CSE-ConnectionGUID: NGydXMcGToenjZurbbPepw==
X-CSE-MsgGUID: SonlgQ+oRPexgrdvb3MD8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="175717300"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 19 Sep 2025 12:39:21 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uzgww-0004kd-1C;
	Fri, 19 Sep 2025 19:39:18 +0000
Date: Sat, 20 Sep 2025 03:38:35 +0800
From: kernel test robot <lkp@intel.com>
To: Harikrishna Shenoy <h-shenoy@ti.com>, andrzej.hajda@intel.com,
	neil.armstrong@linaro.org, rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, airlied@gmail.com, simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, sjakhade@cadence.com, yamonkar@cadence.com,
	lumag@kernel.org, dianders@chromium.org, jani.nikula@intel.com,
	luca.ceresoli@bootlin.com, andy.yan@rock-chips.com,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, devarsht@ti.com, u-kumar1@ti.com,
	s-jain1@ti.com, tomi.valkeinen@ideasonboard.com
Cc: oe-kbuild-all@lists.linux.dev, h-shenoy@ti.com
Subject: Re: [PATCH v5 2/2] drm: bridge: cdns-mhdp8546: Add support for DSC
 and FEC
Message-ID: <202509200323.OEAahLBT-lkp@intel.com>
References: <20250915103041.3891448-3-h-shenoy@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915103041.3891448-3-h-shenoy@ti.com>

Hi Harikrishna,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on drm-misc/drm-misc-next linus/master v6.17-rc6 next-20250919]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Harikrishna-Shenoy/dt-bindings-drm-bridge-MHDP8546-bridge-binding-changes-for-DSC/20250915-183321
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250915103041.3891448-3-h-shenoy%40ti.com
patch subject: [PATCH v5 2/2] drm: bridge: cdns-mhdp8546: Add support for DSC and FEC
config: arm64-randconfig-002-20250919 (https://download.01.org/0day-ci/archive/20250920/202509200323.OEAahLBT-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250920/202509200323.OEAahLBT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509200323.OEAahLBT-lkp@intel.com/

All errors (new ones prefixed by >>):

   aarch64-linux-ld: Unexpected GOT/PLT entries detected!
   aarch64-linux-ld: Unexpected run-time procedure linkages detected!
   aarch64-linux-ld: drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-dsc.o: in function `cdns_mhdp_dsc_write_enc_config':
>> cdns-mhdp8546-dsc.c:(.text+0x2f0): undefined reference to `drm_dsc_flatness_det_thresh'
   aarch64-linux-ld: drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-dsc.o: in function `cdns_mhdp_compute_dsc_params':
>> cdns-mhdp8546-dsc.c:(.text+0x91c): undefined reference to `drm_dsc_set_const_params'
>> aarch64-linux-ld: cdns-mhdp8546-dsc.c:(.text+0x924): undefined reference to `drm_dsc_set_rc_buf_thresh'
>> aarch64-linux-ld: cdns-mhdp8546-dsc.c:(.text+0x930): undefined reference to `drm_dsc_setup_rc_params'
>> aarch64-linux-ld: cdns-mhdp8546-dsc.c:(.text+0x940): undefined reference to `drm_dsc_initial_scale_value'
>> aarch64-linux-ld: cdns-mhdp8546-dsc.c:(.text+0x954): undefined reference to `drm_dsc_compute_rc_parameters'
   aarch64-linux-ld: drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-dsc.o: in function `cdns_mhdp_dsc_send_pps_sdp':
>> cdns-mhdp8546-dsc.c:(.text+0xa44): undefined reference to `drm_dsc_dp_pps_header_init'
>> aarch64-linux-ld: cdns-mhdp8546-dsc.c:(.text+0xa54): undefined reference to `drm_dsc_pps_payload_pack'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


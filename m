Return-Path: <linux-kernel+bounces-891309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9993FC4267C
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 05:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F8F53BA7DC
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 04:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110822D7DFF;
	Sat,  8 Nov 2025 04:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U/4WVwBW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD747D098;
	Sat,  8 Nov 2025 04:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762575195; cv=none; b=D2K+Y1BNQQXXol8DD1J2GiOAaKaR9Vy+8VJVR1LUiqYT+xAXX1DAMqKzklCT0LnHZc9LIs65yAcEjfyNMaNU3JDOhK5PEEdWV7JaR1qlOlwexrN06+uGn9EESMPYMSbAhA1XV/OV1W/qHiP9j13w0nWUnfDZWgqzr6jYICCLfUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762575195; c=relaxed/simple;
	bh=Chbc1OyTI8Ct9a3uY+DcWiIf+X6KyQ9qPPr/UEG1dxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGB8gj4uFmVCNLFVdkQGoVZ6/8yarrTiOLsoqN5KfzB2Nege7vnnVBJjlXh5ZbHoWEcI+pW2BZ+o0NSPZy7kQdbu5aAKdzc5f2jGx4JSQgpvuue10wLq/qgomW/sVoXBlb0HMwgnLil3C+j55ZOT4W4YmMSfLVKpdH5+pCTc9W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U/4WVwBW; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762575194; x=1794111194;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Chbc1OyTI8Ct9a3uY+DcWiIf+X6KyQ9qPPr/UEG1dxo=;
  b=U/4WVwBWRc/WIZXrMg9R4jgSZ5qkW4bTippFyWxRI2CKN9BfeLyIW87l
   JhjwG2/SRA7TerVRwm7+jB0vQ4A+kRYaZAAyW6GgPlVaNdGJU++TbVvud
   4hS1gdKPHSzdJ2y9YVe1NNZp2wRMD3B3eXXgNMLkM3UCBmh8t5efS3ldA
   MydNEPMDGOkPS898mVI1bIpwJR3zdEmj2cyFlQ5j0k9ZLTLP077IIEvjz
   5GOrwtZmTVVsdRdyAlUHjWJgdfuESvoU5xl52cAyGjxnCLw4wibT3ND4L
   etrdWIXJ5+7fE5GeiO3Ohq7tAHj7bNlLA7Zv2lZNrUQcJIfDwys2Jsdyu
   w==;
X-CSE-ConnectionGUID: aJMwzJ0RT5OsxizkELSuYw==
X-CSE-MsgGUID: 6AFvggL+Tcuz727ZJ+itUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="75834110"
X-IronPort-AV: E=Sophos;i="6.19,288,1754982000"; 
   d="scan'208";a="75834110"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 20:13:13 -0800
X-CSE-ConnectionGUID: a/SCoH5pTGazUgKz1IUMmQ==
X-CSE-MsgGUID: yvD98d3LTP+rGCENt+8esw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,288,1754982000"; 
   d="scan'208";a="187454883"
Received: from lkp-server01.sh.intel.com (HELO 6ef82f2de774) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 07 Nov 2025 20:13:07 -0800
Received: from kbuild by 6ef82f2de774 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vHaK1-0000id-0U;
	Sat, 08 Nov 2025 04:13:05 +0000
Date: Sat, 8 Nov 2025 12:12:05 +0800
From: kernel test robot <lkp@intel.com>
To: Nilesh Laad <nilesh.laad@oss.qualcomm.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nilesh Laad <nilesh.laad@oss.qualcomm.com>,
	venkata.valluru@oss.qualcomm.com, jessica.zhang@oss.qualcomm.com,
	Yi Zhang <zhanyi@qti.qualcomm.com>,
	Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/2] drm/bridge: add support for lontium lt9211c bridge
Message-ID: <202511081122.TMw7Wy9r-lkp@intel.com>
References: <20251107-add-lt9211c-bridge-v2-2-b0616e23407c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107-add-lt9211c-bridge-v2-2-b0616e23407c@oss.qualcomm.com>

Hi Nilesh,

kernel test robot noticed the following build errors:

[auto build test ERROR on f50b969bafafb2810a07f376387350c4c0d72a21]

url:    https://github.com/intel-lab-lkp/linux/commits/Nilesh-Laad/dt-bindings-bridge-lt9211c-Add-bindings/20251107-210546
base:   f50b969bafafb2810a07f376387350c4c0d72a21
patch link:    https://lore.kernel.org/r/20251107-add-lt9211c-bridge-v2-2-b0616e23407c%40oss.qualcomm.com
patch subject: [PATCH v2 2/2] drm/bridge: add support for lontium lt9211c bridge
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20251108/202511081122.TMw7Wy9r-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251108/202511081122.TMw7Wy9r-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511081122.TMw7Wy9r-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/gpu/drm/bridge/lontium-lt9211c.c:207:48: warning: '&' within '|' [-Wbitwise-op-parentheses]
     207 |         ret = regmap_write(ctx->regmap, 0x8180, (pval & 0xfc | 0x03));
         |                                                  ~~~~~^~~~~~ ~
   drivers/gpu/drm/bridge/lontium-lt9211c.c:207:48: note: place parentheses around the '&' expression to silence this warning
     207 |         ret = regmap_write(ctx->regmap, 0x8180, (pval & 0xfc | 0x03));
         |                                                       ^
         |                                                  (          )
   drivers/gpu/drm/bridge/lontium-lt9211c.c:227:48: warning: '&' within '|' [-Wbitwise-op-parentheses]
     227 |         ret = regmap_write(ctx->regmap, 0x8530, (pval & 0xf8 | 0x11));
         |                                                  ~~~~~^~~~~~ ~
   drivers/gpu/drm/bridge/lontium-lt9211c.c:227:48: note: place parentheses around the '&' expression to silence this warning
     227 |         ret = regmap_write(ctx->regmap, 0x8530, (pval & 0xf8 | 0x11));
         |                                                       ^
         |                                                  (          )
   drivers/gpu/drm/bridge/lontium-lt9211c.c:253:5: warning: unused variable 'bc' [-Wunused-variable]
     253 |         u8 bc[3];
         |            ^~
   drivers/gpu/drm/bridge/lontium-lt9211c.c:619:48: warning: '&' within '|' [-Wbitwise-op-parentheses]
     619 |         ret = regmap_write(ctx->regmap, 0x8530, (pval & 0x3f | 0x40));
         |                                                  ~~~~~^~~~~~ ~
   drivers/gpu/drm/bridge/lontium-lt9211c.c:619:48: note: place parentheses around the '&' expression to silence this warning
     619 |         ret = regmap_write(ctx->regmap, 0x8530, (pval & 0x3f | 0x40));
         |                                                       ^
         |                                                  (          )
>> drivers/gpu/drm/bridge/lontium-lt9211c.c:918:14: error: incompatible function pointer types initializing 'int (*)(struct drm_bridge *, struct drm_encoder *, enum drm_bridge_attach_flags)' with an expression of type 'int (struct drm_bridge *, enum drm_bridge_attach_flags)' [-Wincompatible-function-pointer-types]
     918 |         .attach                 = lt9211c_attach,
         |                                   ^~~~~~~~~~~~~~
>> drivers/gpu/drm/bridge/lontium-lt9211c.c:920:20: error: incompatible function pointer types initializing 'void (*)(struct drm_bridge *, struct drm_atomic_state *)' with an expression of type 'void (struct drm_bridge *, struct drm_bridge_state *)' [-Wincompatible-function-pointer-types]
     920 |         .atomic_enable          = lt9211c_atomic_enable,
         |                                   ^~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/bridge/lontium-lt9211c.c:921:21: error: incompatible function pointer types initializing 'void (*)(struct drm_bridge *, struct drm_atomic_state *)' with an expression of type 'void (struct drm_bridge *, struct drm_bridge_state *)' [-Wincompatible-function-pointer-types]
     921 |         .atomic_disable         = lt9211c_atomic_disable,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~
   4 warnings and 3 errors generated.


vim +918 drivers/gpu/drm/bridge/lontium-lt9211c.c

   916	
   917	static const struct drm_bridge_funcs lt9211c_funcs = {
 > 918		.attach			= lt9211c_attach,
   919		.mode_valid		= lt9211c_mode_valid,
 > 920		.atomic_enable		= lt9211c_atomic_enable,
   921		.atomic_disable		= lt9211c_atomic_disable,
   922		.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
   923		.atomic_destroy_state	= drm_atomic_helper_bridge_destroy_state,
   924		.atomic_get_input_bus_fmts = lt9211c_atomic_get_input_bus_fmts,
   925		.atomic_reset		= drm_atomic_helper_bridge_reset,
   926	};
   927	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


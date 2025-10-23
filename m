Return-Path: <linux-kernel+bounces-866523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE97BFFFF1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 444084FB08B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D20E302171;
	Thu, 23 Oct 2025 08:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fx/E6O7D"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0F726E146;
	Thu, 23 Oct 2025 08:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761209142; cv=none; b=piGH7FTGmuKRdxVNUINxyBtzaC4SdS7dtufyE+f0j/VgYla5jmAWYO0PscO6UfdLGMEz2Q3KceIq5Luthhbrtz/D8gc5tS4MfUTW1QPuheyMkpui+sijqTtQXOvcozfz8Yfh9g8gA1oMjjaLwgFKSS27eDZiaA+Kfqn43x8FCBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761209142; c=relaxed/simple;
	bh=mska27xKT3EyztX10JDYKLSZS1LLb/NIROqYMNvXfP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQSWwOXV81R3xz7ir6lx03iVJejQT6oevE+NXerSer5SmV6zz1ghTNYquCndXlVIuavkTv/U8QDFahronqjZVZoIKnu+SMeVgL8hGjCvrT63B3ieaXbvJyWRX9SPHLZP08Ch2gr6lY0RRCq9qaE/U2k278CSS1ktZ65TIWoTx+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fx/E6O7D; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761209141; x=1792745141;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mska27xKT3EyztX10JDYKLSZS1LLb/NIROqYMNvXfP4=;
  b=fx/E6O7DwTsa7kkOQKUHkKZYcmfeyB4u9tqVRoLZUSFdokAb+RvsjAfA
   n1UPtnQ82PLf2WFeKyqKFpMfC0uYrjzZkMfMPY8UTRRePMadUzEbWsdUK
   bPX2YDV009lXLLT1Fdyxwzpmci/5ikoiezi/P4l7lEOBu6rvKhuXx1YC8
   ZNaH5Ta1vlvUygboqFZY8z2Clgiq3OylYm43AHtEbLPmJN5OAAhEx641K
   kk0MD4FFqkv2RVLNhMJ+l92NjDx2DMbCfpkz4Wh++uGJSThLXWyWiG8tG
   vO6Muf6mrIpUx+Pcdh+Yh1D5doDU0T86EqAEzJgljZniSjU1rNIsnX68h
   Q==;
X-CSE-ConnectionGUID: 2hJkV6P6Rxy6mLke//OzRw==
X-CSE-MsgGUID: iwppBcb7TU+8j1M2rR0DHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63411697"
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="63411697"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 01:45:40 -0700
X-CSE-ConnectionGUID: Ucc0EPCqSiCBkTSZJ6NNCw==
X-CSE-MsgGUID: M6DulzDDRF26JDQ0xCqgcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="183995303"
Received: from bkammerd-mobl.amr.corp.intel.com (HELO kuha.fi.intel.com) ([10.124.221.165])
  by orviesa007.jf.intel.com with SMTP; 23 Oct 2025 01:45:30 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 23 Oct 2025 11:45:29 +0300
Date: Thu, 23 Oct 2025 11:45:28 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Chaoyi Chen <kernel@airkyi.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Yubing Zhang <yubing.zhang@rock-chips.com>,
	Frank Wang <frank.wang@rock-chips.com>,
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
	Amit Sunil Dhamne <amitsd@google.com>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Dragan Simic <dsimic@manjaro.org>, Johan Jonker <jbx6244@gmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Peter Robinson <pbrobinson@gmail.com>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v7 2/9] drm/bridge: Implement generic USB Type-C DP HPD
 bridge
Message-ID: <aPnrKFWTvpuRTyhI@kuha.fi.intel.com>
References: <20251023033009.90-1-kernel@airkyi.com>
 <20251023033009.90-3-kernel@airkyi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023033009.90-3-kernel@airkyi.com>

On Thu, Oct 23, 2025 at 11:30:02AM +0800, Chaoyi Chen wrote:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> 
> Several USB-C controller drivers have already implemented the DP HPD
> bridge function provided by aux-hpd-bridge.c, but there are still
> some USB-C controller driver that have not yet implemented it.
> 
> This patch implements a generic DP HPD bridge based on aux-hpd-bridge.c,
> so that other USB-C controller drivers don't need to implement it again.
> 
> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> ---
>  drivers/gpu/drm/bridge/Kconfig                | 11 ++++
>  drivers/gpu/drm/bridge/Makefile               |  1 +
>  .../gpu/drm/bridge/aux-hpd-typec-dp-bridge.c  | 51 +++++++++++++++++++
>  3 files changed, 63 insertions(+)
>  create mode 100644 drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index b9e0ca85226a..9f31540d3ad8 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -33,6 +33,17 @@ config DRM_AUX_HPD_BRIDGE
>  menu "Display Interface Bridges"
>  	depends on DRM && DRM_BRIDGE
>  
> +config DRM_AUX_TYPEC_DP_HPD_BRIDGE
> +	tristate "TypeC DP HPD bridge"
> +	depends on DRM_BRIDGE && OF && TYPEC
> +	select DRM_AUX_HPD_BRIDGE
> +	help
> +	  Simple USB Type-C DP bridge that terminates the bridge chain and
> +	  provides HPD support.
> +
> +	  If the USB-C controller driver has not implemented this and you need
> +	  the DP HPD support, say "Y" or "m" here.

You don't need to depend on DRM_BRIDGE separately, but do you really
need a separate module for this in the first place?

>  config DRM_CHIPONE_ICN6211
>  	tristate "Chipone ICN6211 MIPI-DSI/RGB Converter bridge"
>  	depends on OF
> diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
> index 245e8a27e3fc..e91736829167 100644
> --- a/drivers/gpu/drm/bridge/Makefile
> +++ b/drivers/gpu/drm/bridge/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_DRM_AUX_BRIDGE) += aux-bridge.o
>  obj-$(CONFIG_DRM_AUX_HPD_BRIDGE) += aux-hpd-bridge.o
> +obj-$(CONFIG_DRM_AUX_TYPEC_DP_HPD_BRIDGE) += aux-hpd-typec-dp-bridge.o

Instead, why not just make that a part of aux-hpd-bridge
conditionally:

ifneq ($(CONFIG_TYPEC),)
        aux-hpd-bridge-y        += aux-hpd-typec-dp-bridge.o
endif


thanks,

-- 
heikki


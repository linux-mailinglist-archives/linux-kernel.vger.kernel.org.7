Return-Path: <linux-kernel+bounces-860543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FEDBF05DB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 94AC64E3A4F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084902F1FE5;
	Mon, 20 Oct 2025 10:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R/LWpNQW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBC01FDA92;
	Mon, 20 Oct 2025 10:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760954532; cv=none; b=D5TD0PLjxW0ZwvlAL9ALyXIsqWuvYeBr1cm61O55y1kEni1dJNTtwLUiXs36AocC/kO6Kb5DtiFtM6lYzDFg5TmJsWsar8C9PgcGnLU8pz5UTMqo1Z4jmn747h9jjLZb9KegW69GeJ3+o4IVGfFqUdmlbnWz6WbRq/vqCZT/nxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760954532; c=relaxed/simple;
	bh=7OgHgc7V9jCA/aH/wZmpPfoG6Zo6Xb08lXUbbydETp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DezsMH/jOW5itxFF7sWfdIbtk51IvMp0OLHo2lnz3CaXgYSqc1tjrj4esUfQJHdmIS5Z7zU08CERHXlkMbDdypSV2mdqoJ91DSebqblafW0+e4w1J0eEwAlWGZXgKjZM9eien6NPCIZ0SVji+RKwImTqcvYk6Oy46C05AV8L4WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R/LWpNQW; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760954530; x=1792490530;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7OgHgc7V9jCA/aH/wZmpPfoG6Zo6Xb08lXUbbydETp4=;
  b=R/LWpNQWWM3L/XZmBjliJSsO0Y2An53b0bOdONEg7N9VGNJFYSWDt23e
   AsmhspAJFEUbQjJVVft4XzkgKgeXGXDBq9KITZ3DPvzNi8pHZ1wF1UBG8
   x+MGxlflHLObPtaRN3ws+W3MOVurm1yub6CUBnH/FO8TUnL6e6XzbPI6C
   ODBwbfbEo/JbH63LyDK4IKDoFl9MhdcLx55zURZuY3wWh2iQ+chRHEnK0
   njSS37aoEigSFiA05dkn0zIsaUQV7d/jdxsfVPyVOD4akZ1MSu0EQyXb6
   VMOAKJzlkCoc1y8er3EAM6j1GyCylAtpxZXAtUIpkifQ9HFPoKmUvl7UT
   A==;
X-CSE-ConnectionGUID: WoL9UeLSQ3uvZldMQlrgAQ==
X-CSE-MsgGUID: 3bEYd26bQx+rHZnMmagMuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11587"; a="80506993"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="80506993"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 03:02:10 -0700
X-CSE-ConnectionGUID: Rbwng+eMQgabSBT8iqlHxg==
X-CSE-MsgGUID: 5PEY46adTHK0yIfKFWIaWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="183308787"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO kuha.fi.intel.com) ([10.124.220.112])
  by orviesa008.jf.intel.com with SMTP; 20 Oct 2025 03:02:01 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 20 Oct 2025 13:02:00 +0300
Date: Mon, 20 Oct 2025 13:02:00 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Chaoyi Chen <kernel@airkyi.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Yubing Zhang <yubing.zhang@rock-chips.com>,
	Frank Wang <frank.wang@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Amit Sunil Dhamne <amitsd@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Dragan Simic <dsimic@manjaro.org>, Johan Jonker <jbx6244@gmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Peter Robinson <pbrobinson@gmail.com>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v6 1/8] usb: typec: Add default HPD device when register
 DisplayPort altmode
Message-ID: <aPYImGmesrZWwyqh@kuha.fi.intel.com>
References: <20251016022741.91-1-kernel@airkyi.com>
 <20251016022741.91-2-kernel@airkyi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016022741.91-2-kernel@airkyi.com>

On Thu, Oct 16, 2025 at 10:27:34AM +0800, Chaoyi Chen wrote:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> 
> Add default DRM AUX HPD bridge device when register DisplayPort
> altmode. That makes it redundant for each Type-C driver to implement
> a similar registration process in embedded scenarios.
> 
> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> ---
> 
> Changes in v6:
> - Fix depend in Kconfig.
> 
> Changes in v5:
> - Remove the calls related to `drm_aux_hpd_bridge_notify()`.
> - Place the helper functions in the same compilation unit.
> - Add more comments about parent device.
> 
>  drivers/usb/typec/Kconfig         |  2 ++
>  drivers/usb/typec/class.c         | 26 ++++++++++++++++++++++++++
>  include/linux/usb/typec_altmode.h |  2 ++
>  3 files changed, 30 insertions(+)
> 
> diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
> index 2f80c2792dbd..a6730fbb576b 100644
> --- a/drivers/usb/typec/Kconfig
> +++ b/drivers/usb/typec/Kconfig
> @@ -2,6 +2,8 @@
>  
>  menuconfig TYPEC
>  	tristate "USB Type-C Support"
> +	depends on DRM || DRM=n
> +	select DRM_AUX_HPD_BRIDGE if DRM_BRIDGE && OF

This is wrong. DRM should not dictate how this entire subsystem core
is configured. The dependency needs to be on the DRM bridge side.

You can for example use the bus notification there to see when a new
alternate mode is being registered, or use some other notification
mechanism.

thanks,

>  	help
>  	  USB Type-C Specification defines a cable and connector for USB where
>  	  only one type of plug is supported on both ends, i.e. there will not
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 67a533e35150..e9d7772d1a8f 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -8,14 +8,18 @@
>  
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/of.h>
>  #include <linux/property.h>
>  #include <linux/slab.h>
>  #include <linux/string_choices.h>
>  #include <linux/usb/pd_vdo.h>
> +#include <linux/usb/typec_dp.h>
>  #include <linux/usb/typec_mux.h>
>  #include <linux/usb/typec_retimer.h>
>  #include <linux/usb.h>
>  
> +#include <drm/bridge/aux-bridge.h>
> +
>  #include "bus.h"
>  #include "class.h"
>  #include "pd.h"
> @@ -538,6 +542,21 @@ const struct device_type typec_altmode_dev_type = {
>  	.release = typec_altmode_release,
>  };
>  
> +static void dp_altmode_hpd_device_register(struct typec_altmode *alt)
> +{
> +	if (alt->svid != USB_TYPEC_DP_SID)
> +		return;
> +
> +	/*
> +	 * alt->dev.parent->parent : USB-C controller device
> +	 * alt->dev.parent         : USB-C connector device
> +	 */
> +	alt->hpd_dev = drm_dp_hpd_bridge_register(alt->dev.parent->parent,
> +						  to_of_node(alt->dev.parent->fwnode));
> +	if (IS_ERR(alt->hpd_dev))
> +		alt->hpd_dev = NULL;
> +}
> +
>  static struct typec_altmode *
>  typec_register_altmode(struct device *parent,
>  		       const struct typec_altmode_desc *desc)
> @@ -600,6 +619,13 @@ typec_register_altmode(struct device *parent,
>  		return ERR_PTR(ret);
>  	}
>  
> +	/*
> +	 * It is too late to register the HPD device when the DisplayPort
> +	 * altmode device becomes ready. If the current altmode is DP,
> +	 * register a static HPD device.
> +	 */
> +	dp_altmode_hpd_device_register(&alt->adev);
> +
>  	return &alt->adev;
>  }
>  
> diff --git a/include/linux/usb/typec_altmode.h b/include/linux/usb/typec_altmode.h
> index b3c0866ea70f..acb0af1b9d5d 100644
> --- a/include/linux/usb/typec_altmode.h
> +++ b/include/linux/usb/typec_altmode.h
> @@ -21,6 +21,7 @@ struct typec_altmode_ops;
>   * @desc: Optional human readable description of the mode
>   * @ops: Operations vector from the driver
>   * @cable_ops: Cable operations vector from the driver.
> + * @hpd_dev: HPD device for DisplayPort
>   */
>  struct typec_altmode {
>  	struct device			dev;
> @@ -32,6 +33,7 @@ struct typec_altmode {
>  	char				*desc;
>  	const struct typec_altmode_ops	*ops;
>  	const struct typec_cable_ops	*cable_ops;
> +	struct device			*hpd_dev;
>  };
>  
>  #define to_typec_altmode(d) container_of(d, struct typec_altmode, dev)
> -- 
> 2.49.0

-- 
heikki


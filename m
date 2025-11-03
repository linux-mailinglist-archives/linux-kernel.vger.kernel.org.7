Return-Path: <linux-kernel+bounces-883007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 37169C2C3E4
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 14:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9DB353497C6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 13:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11119274B2B;
	Mon,  3 Nov 2025 13:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PfKEM+nu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE7C1B85F8;
	Mon,  3 Nov 2025 13:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762177711; cv=none; b=aAFcvbPjo8c+3uW6SLV1PAAG26NMY2DcQQqlOKzBDsvnwp+847+mMaYOwED5+dkX47WJPqgzdO+31EXI01hVr3WXNw1OGVLPWVZ2jlbYdIbmfpyfQaBWU8jU6+C4zYefr5kgTytND3hJ2tCJEXeArgEVZcs91zSEDWz/0caiEe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762177711; c=relaxed/simple;
	bh=/eMBTgNJH8/Xgm8LgLzir6GKHePQ75zTAgJlicmNsfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HO+YHf9yxgBc4CFzuWDNasie7TJcia+89cBdVIUi3yGVPeBWc2ElQGSOIIZVMSrQR4rEaNRlEM2+6XsvCZXFHJmWKWvs1TQ0dLL9SzLuWVSivxwoTQuFG30YSBGhNMezbBOntfORanSRSceqkdVWcfb6XXU0UMoWZliVyd5qwWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PfKEM+nu; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762177710; x=1793713710;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/eMBTgNJH8/Xgm8LgLzir6GKHePQ75zTAgJlicmNsfQ=;
  b=PfKEM+nu+M8xX0XhsZTDlirRsJ/b98gD+zl4l4Ua2LqOy4FMbStJVhi1
   hNsfrvBk3Db0FgIdqnwy7/ZiIj/cPwNs+mTfnfOnEPv5Ur1tj5xdO4z1E
   W+ioF8MPbtYHSUJplv4esVl+6358Pp5s/ZP4IZ3gYY3AQWIRbu2ZbndBZ
   VbHUGdLjiobwByI25VIvV6n6rLVF6bEVJqsXX9TudQQhXvwa3XL3W2Jb5
   AUE4o5qptrkE+jhjQ7Vq2Lo9pkJbfq4qX10vmmn4oghnBhKQyDClxNaDx
   DOsvDoGZZMwJo3BtMNDB89/DB01YhXUF1t8Sqfk3ocTlKs/rzlTx3eXxj
   Q==;
X-CSE-ConnectionGUID: Z7PcJOtYSheuPUmLhHKO7A==
X-CSE-MsgGUID: fA9Dm99cRbSTIqjgaicLEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="75699958"
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="75699958"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 05:48:29 -0800
X-CSE-ConnectionGUID: JFm5J5b9STC09kNJqEZ1eA==
X-CSE-MsgGUID: J32ocSpgR2yn1eLsQx1Tpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="186110382"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO kuha.fi.intel.com) ([10.124.220.222])
  by orviesa006.jf.intel.com with SMTP; 03 Nov 2025 05:48:11 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 03 Nov 2025 15:48:09 +0200
Date: Mon, 3 Nov 2025 15:48:09 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Chaoyi Chen <kernel@airkyi.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
	Dragan Simic <dsimic@manjaro.org>, Johan Jonker <jbx6244@gmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Peter Robinson <pbrobinson@gmail.com>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v8 03/10] drm/bridge: Implement generic USB Type-C DP HPD
 bridge
Message-ID: <aQiymTFVU7UpcJ1p@kuha.fi.intel.com>
References: <20251029071435.88-1-kernel@airkyi.com>
 <20251029071435.88-4-kernel@airkyi.com>
 <rzozpbqmymdczerh3iijxxtz3xnsznoku7w2mquikwv6u5osvo@7h43hwc2fpzm>
 <eca9d5bd-23bd-4c1d-b2f2-c0c32f14177f@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eca9d5bd-23bd-4c1d-b2f2-c0c32f14177f@rock-chips.com>

> > > diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> > > index a250afd8d662..17257b223a28 100644
> > > --- a/drivers/gpu/drm/bridge/Kconfig
> > > +++ b/drivers/gpu/drm/bridge/Kconfig
> > > @@ -23,13 +23,16 @@ config DRM_AUX_BRIDGE
> > >   	  build bridges chain.
> > >   config DRM_AUX_HPD_BRIDGE
> > > -	tristate
> > > +	tristate "AUX HPD bridge support"
> > Why? No, this is supposed to be selected by other drivers. Users don't
> > know an wouldn't know what is this.
> 
> In v7, I implemented an additional module for selecting this option. But
> Heikki believes that it would be better to merge the two modules into one.

Like I said before, I was merely curious why not just squash the
support into that AUX_PD_HPD_BRIDGE. If that does not make sense, then
so be it - make it a "Display Interface Bridge" driver like you
originally proposed.

> > >   	depends on DRM_BRIDGE && OF
> > >   	select AUXILIARY_BUS
> > >   	help
> > >   	  Simple bridge that terminates the bridge chain and provides HPD
> > >   	  support.
> > > +	  Specifically, if you want a default Type-C DisplayPort HPD bridge for
> > > +	  each port of the Type-C controller, say Y here.
> > > +
> > >   menu "Display Interface Bridges"
> > >   	depends on DRM && DRM_BRIDGE
> > > diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
> > > index c7dc03182e59..2998937444bc 100644
> > > --- a/drivers/gpu/drm/bridge/Makefile
> > > +++ b/drivers/gpu/drm/bridge/Makefile
> > > @@ -1,6 +1,12 @@
> > >   # SPDX-License-Identifier: GPL-2.0
> > >   obj-$(CONFIG_DRM_AUX_BRIDGE) += aux-bridge.o
> > > -obj-$(CONFIG_DRM_AUX_HPD_BRIDGE) += aux-hpd-bridge.o
> > > +
> > > +hpd-bridge-y := aux-hpd-bridge.o
> > > +ifneq ($(CONFIG_TYPEC),)
> > > +hpd-bridge-y += aux-hpd-typec-dp-bridge.o
> > > +endif
> > > +obj-$(CONFIG_DRM_AUX_HPD_BRIDGE) += hpd-bridge.o
> > > +
> > >   obj-$(CONFIG_DRM_CHIPONE_ICN6211) += chipone-icn6211.o
> > >   obj-$(CONFIG_DRM_CHRONTEL_CH7033) += chrontel-ch7033.o
> > >   obj-$(CONFIG_DRM_CROS_EC_ANX7688) += cros-ec-anx7688.o
> > > diff --git a/drivers/gpu/drm/bridge/aux-hpd-bridge.c b/drivers/gpu/drm/bridge/aux-hpd-bridge.c
> > > index 2e9c702c7087..11ad6dc776c7 100644
> > > --- a/drivers/gpu/drm/bridge/aux-hpd-bridge.c
> > > +++ b/drivers/gpu/drm/bridge/aux-hpd-bridge.c
> > > @@ -12,6 +12,8 @@
> > >   #include <drm/drm_bridge.h>
> > >   #include <drm/bridge/aux-bridge.h>
> > > +#include "aux-hpd-bridge.h"
> > > +
> > >   static DEFINE_IDA(drm_aux_hpd_bridge_ida);
> > >   struct drm_aux_hpd_bridge_data {
> > > @@ -204,7 +206,26 @@ static struct auxiliary_driver drm_aux_hpd_bridge_drv = {
> > >   	.id_table = drm_aux_hpd_bridge_table,
> > >   	.probe = drm_aux_hpd_bridge_probe,
> > >   };
> > > -module_auxiliary_driver(drm_aux_hpd_bridge_drv);
> > > +
> > > +static int drm_aux_hpd_bridge_mod_init(void)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = auxiliary_driver_register(&drm_aux_hpd_bridge_drv);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	return drm_aux_hpd_typec_dp_bridge_init();
> > > +}
> > > +
> > > +static void drm_aux_hpd_bridge_mod_exit(void)
> > > +{
> > > +	drm_aux_hpd_typec_dp_bridge_exit();
> > > +	auxiliary_driver_unregister(&drm_aux_hpd_bridge_drv);
> > > +}
> > > +
> > > +module_init(drm_aux_hpd_bridge_mod_init);
> > > +module_exit(drm_aux_hpd_bridge_mod_exit);
> > >   MODULE_AUTHOR("Dmitry Baryshkov <dmitry.baryshkov@linaro.org>");
> > >   MODULE_DESCRIPTION("DRM HPD bridge");
> > > diff --git a/drivers/gpu/drm/bridge/aux-hpd-bridge.h b/drivers/gpu/drm/bridge/aux-hpd-bridge.h
> > > new file mode 100644
> > > index 000000000000..69364731c2f1
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/bridge/aux-hpd-bridge.h
> > > @@ -0,0 +1,13 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > +#ifndef AUX_HPD_BRIDGE_H
> > > +#define AUX_HPD_BRIDGE_H
> > > +
> > > +#if IS_REACHABLE(CONFIG_TYPEC)
> > > +int drm_aux_hpd_typec_dp_bridge_init(void);
> > > +void drm_aux_hpd_typec_dp_bridge_exit(void);
> > > +#else
> > > +static inline int drm_aux_hpd_typec_dp_bridge_init(void) { return 0; }
> > > +static inline void drm_aux_hpd_typec_dp_bridge_exit(void) { }
> > > +#endif /* IS_REACHABLE(CONFIG_TYPEC) */
> > > +
> > > +#endif /* AUX_HPD_BRIDGE_H */
> > > diff --git a/drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c b/drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c
> > > new file mode 100644
> > > index 000000000000..6f2a1fca0fc5
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c
> > > @@ -0,0 +1,47 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +#include <linux/of.h>
> > > +#include <linux/usb/typec_altmode.h>
> > > +#include <linux/usb/typec_dp.h>
> > > +#include <linux/usb/typec_notify.h>
> > > +
> > > +#include <drm/bridge/aux-bridge.h>
> > > +
> > > +#include "aux-hpd-bridge.h"
> > > +
> > > +#if IS_REACHABLE(CONFIG_TYPEC)
> > > +static int drm_typec_bus_event(struct notifier_block *nb,
> > > +			       unsigned long action, void *data)
> > > +{
> > This feels like this should be a part of the Type-C subsystem rather
> > than DRM.
> 
> In v7, this used to be a part of the Type-C subsystem. I'm not sure what
> Heikki thinks about this.

Your original proposal of making the entire TYPEC subsystem depend on
DRM is _not_ going to happen. In general, if I've now understood this
correctly, this thing probable should be a "display interface bridge
driver", similar to what you proposed in the previous version.

Note also that you could make it selected automatically, so there is
no need for user selectable option if that's the preference. Kconfig
and Makefile gives you options on how to do that. For example, maybe
this Kconfig works (or does not, but something like it will):

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index a250afd8d662..7487024ba2ce 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -30,6 +30,15 @@ config DRM_AUX_HPD_BRIDGE
          Simple bridge that terminates the bridge chain and provides HPD
          support.
 
+if DRM_AUX_HPD_BRIDGE
+
+config DRM_AUX_HPD_TYPEC_BRIDGE
+       tristate
+       depends on TYPEC || !TYPEC
+       default TYPEC
+
+endif /* DRM_AUX_HPD_BRIDGE */
+
 menu "Display Interface Bridges"
        depends on DRM && DRM_BRIDGE
 


thanks,

-- 
heikki


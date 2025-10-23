Return-Path: <linux-kernel+bounces-866897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 662E7C00F95
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F160561A84
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FF730F805;
	Thu, 23 Oct 2025 12:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aFVLfFI3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A37E26F28A;
	Thu, 23 Oct 2025 12:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761221010; cv=none; b=mIA1wdhpSFd/QeW2aS8NNXDyY3zjiuni5aJH1tTeKxLzoZvWyUD5CE10duX3Cn0EH6bnMkOGn6Y8Cr+iYjVvPQufP02O7j+ttcPkWwbs0tyybwaAEh6AMcH8goqXNNlWpR3r9UUDLxp08MQFc4zCdWv9dDExrqtaC9UYy9oSFMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761221010; c=relaxed/simple;
	bh=erXucVQ3CkO8W6iJDjYjGvHlpSCK37tkrL/+XPfgexM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UI5LSF/dfqYfvH8w2ax4zaX3lr5cId/i5rA9SqCBv4J6adQbckRjmk8C6DtUtJ+916W3s0xvmwTTbrvaRz1FbHHg0OlEwZWDxPhjm3JTxibE1BjEMC3In4f426UIDvtW1OtOtRoMc9lMrAkC5vItmc79LefQEfNQLGH8iY6dGQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aFVLfFI3; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761221008; x=1792757008;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=erXucVQ3CkO8W6iJDjYjGvHlpSCK37tkrL/+XPfgexM=;
  b=aFVLfFI3ZdbePPH1Un1UL0a3xd5Vw2hEqQhL3ClV5DhfQ+JisxU19QzP
   Hxc77rTLTR3mEUxhi5YVOMnLMBimW6El2qycKylPYwYlhi6osgd+xvcLe
   yTLQ5vm0CXCZsHpv8o+3Cl+QhcqSiXW7xeY1rX0m06K/qkAqfKv8Z4HcD
   8kO1uwbR8t5sGeO73RDls3MHFSSQC3GHPSckolChkQzGvhN0IXwp4HJUi
   rCCAs7GNC9mnSWp39ssYW7dQTk/9GriIUx+8ckO2vCEUa+vrowGw05QN9
   swgPf/hBnfqL2Y7xs9lyygKq0tbIMc8dPbSoGl8Xxs+U9xWQdqA6vBh3+
   g==;
X-CSE-ConnectionGUID: SKyZ0sx6RXqdqgGwMsv/kw==
X-CSE-MsgGUID: 8uXUBSGXSaWt1be4SA991w==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="81013293"
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="81013293"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 05:03:28 -0700
X-CSE-ConnectionGUID: 7DIzW9o6S2WE7ZvtBcvVQQ==
X-CSE-MsgGUID: uCa4JL9CTiShx2sG80Yh6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="184033253"
Received: from bkammerd-mobl.amr.corp.intel.com (HELO kuha.fi.intel.com) ([10.124.221.165])
  by orviesa007.jf.intel.com with SMTP; 23 Oct 2025 05:03:17 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 23 Oct 2025 15:03:16 +0300
Date: Thu, 23 Oct 2025 15:03:16 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>
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
	Dragan Simic <dsimic@manjaro.org>, Johan Jonker <jbx6244@gmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Peter Robinson <pbrobinson@gmail.com>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v7 2/9] drm/bridge: Implement generic USB Type-C DP HPD
 bridge
Message-ID: <aPoZhBdc1M6Qgfae@kuha.fi.intel.com>
References: <20251023033009.90-1-kernel@airkyi.com>
 <20251023033009.90-3-kernel@airkyi.com>
 <aPnrKFWTvpuRTyhI@kuha.fi.intel.com>
 <14b8ac71-489b-4192-92d6-5f228ff3881d@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14b8ac71-489b-4192-92d6-5f228ff3881d@rock-chips.com>

> > > diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
> > > index 245e8a27e3fc..e91736829167 100644
> > > --- a/drivers/gpu/drm/bridge/Makefile
> > > +++ b/drivers/gpu/drm/bridge/Makefile
> > > @@ -1,6 +1,7 @@
> > >   # SPDX-License-Identifier: GPL-2.0
> > >   obj-$(CONFIG_DRM_AUX_BRIDGE) += aux-bridge.o
> > >   obj-$(CONFIG_DRM_AUX_HPD_BRIDGE) += aux-hpd-bridge.o
> > > +obj-$(CONFIG_DRM_AUX_TYPEC_DP_HPD_BRIDGE) += aux-hpd-typec-dp-bridge.o
> > Instead, why not just make that a part of aux-hpd-bridge
> > conditionally:
> > 
> > ifneq ($(CONFIG_TYPEC),)
> >          aux-hpd-bridge-y        += aux-hpd-typec-dp-bridge.o
> > endif
> 
> Oh, I did consider that! But I noticed that aux-hpd-bridge.c contains the
> following statement module_auxiliary_driver(drm_aux_hpd_bridge_drv), which
> already includes a module_init. In the newly added file, in order to call the
> register function, another module_init was also added. If the two files are
> each made into a module separately, would there be a problem?

You would not call module_init() from the new file. Instead you would
call drm_aux_hpd_typec_dp_bridge_init() and what ever directly from
aux-hpd-bridge.c:

diff --git a/drivers/gpu/drm/bridge/aux-bridge.h b/drivers/gpu/drm/bridge/aux-bridge.h
new file mode 100644
index 000000000000..ae689a7778fa
--- /dev/null
+++ b/drivers/gpu/drm/bridge/aux-hpd-bridge.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef AUX_HPD_BRIDGE_H
+#define AUX_HPD_BRIDGE_H
+
+#if IS_ENABLED(CONFIG_TYPEC)
+int drm_aux_hpd_typec_dp_bridge_init(void);
+void drm_aux_hpd_typec_dp_bridge_exit(void);
+#else
+static inline int drm_aux_hpd_typec_dp_bridge_init(void) { return 0; }
+static inline void drm_aux_hpd_typec_dp_bridge_exit(void) { }
+#endif /* IS_ENABLED(CONFIG_TYPEC) */
+
+#endif /* AUX_HPD_BRIDGE_H */
diff --git a/drivers/gpu/drm/bridge/aux-hpd-bridge.c b/drivers/gpu/drm/bridge/aux-hpd-bridge.c
index 2e9c702c7087..3578df1df78a 100644
--- a/drivers/gpu/drm/bridge/aux-hpd-bridge.c
+++ b/drivers/gpu/drm/bridge/aux-hpd-bridge.c
@@ -12,6 +12,8 @@
 #include <drm/drm_bridge.h>
 #include <drm/bridge/aux-bridge.h>
 
+#include "aux-hpd-bridge.h"
+
 static DEFINE_IDA(drm_aux_hpd_bridge_ida);
 
 struct drm_aux_hpd_bridge_data {
@@ -190,9 +192,16 @@ static int drm_aux_hpd_bridge_probe(struct auxiliary_device *auxdev,
 
        auxiliary_set_drvdata(auxdev, data);
 
+       drm_aux_hpd_typec_dp_bridge_init();
+
        return devm_drm_bridge_add(data->dev, &data->bridge);
 }
 
+static void drm_aux_hpd_bridge_remove(struct auxiliary_device *auxdev)
+{
+       drm_aux_hpd_typec_dp_bridge_exit();
+}
+
 static const struct auxiliary_device_id drm_aux_hpd_bridge_table[] = {
        { .name = KBUILD_MODNAME ".dp_hpd_bridge", .driver_data = DRM_MODE_CONNECTOR_DisplayPort, },
        {},
@@ -203,6 +212,7 @@ static struct auxiliary_driver drm_aux_hpd_bridge_drv = {
        .name = "aux_hpd_bridge",
        .id_table = drm_aux_hpd_bridge_table,
        .probe = drm_aux_hpd_bridge_probe,
+       .remove = drm_aux_hpd_bridge_remove,
 };
 module_auxiliary_driver(drm_aux_hpd_bridge_drv);


-- 
heikki


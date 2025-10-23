Return-Path: <linux-kernel+bounces-866567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCFEC0019E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4CEB4F90EC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A8A2FB612;
	Thu, 23 Oct 2025 09:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eWwvmgK5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B9C2FBDE3;
	Thu, 23 Oct 2025 09:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761210287; cv=none; b=DeGh056mgXtmQ5MeyTPtrZNB5xz9tEunqU6KNX4gjMoIHcXtvtzGz3ZhD3PlsgtcWQrNaaHePpvyasmZ772rqRNUQgANed9j7X2j3eO9IC1nf0bECHKF8kjfh7WshtlDVI1p1DgV3UifL0ZBr0/aBd1La/ivHFPd0lH+HAJOfh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761210287; c=relaxed/simple;
	bh=q0bSQQY5SwYrEmcp4I13QmQfjO3pwF0ctbdE1M1LmXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLEjH+RXJo5XMtSSlZlbOxIPFMmQ9HZ/oRl2VrvCcycCZcaB0dYmFMNGSlwoE2mVmhkwl85Bgcn6Dx29kmnprmECgPcPLtcUxbDW7GOK3mDYrUfYHxiCHgYaZi4lU7EZNjM92nPTrxtDXwL5gkaWgHtF2Mo8zkhP4SgpUIzbG7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eWwvmgK5; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761210286; x=1792746286;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q0bSQQY5SwYrEmcp4I13QmQfjO3pwF0ctbdE1M1LmXE=;
  b=eWwvmgK5LU2/rg0D3yog5uukWCuErWeTiR/5cYVPv5niB35kAvek1QT+
   F8wl1JlfudxA30eOiE5MqaoEeHLzZuV0waut3q5wtGlN81F9ctf3cH6eh
   gTwtjZ1m89VrSAL+mcWTBQDZbiWcrNdRGt1XIt9ivkaPKNHeqXRiQqrb1
   Hk291tCs3dG5RpggRmoP4+hbm3SIok/MrXGUx/uFSBbTrt6QgxpesqgSg
   SLvFHyC9dOAYg7N842yIRF6sJ1hICS3C8ZRuS0RYNRitP2o7twlBS3CwM
   oGNRE/VBx4yilQ37Z/ilwR+NkUKgWwzv5bsgjdGRjiDSK0u3smIGN55Zz
   g==;
X-CSE-ConnectionGUID: nQ1+OnXNSoindKc63gtKzQ==
X-CSE-MsgGUID: dIzp4uGGQSWrSkStRaLU6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67211263"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="67211263"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 02:04:45 -0700
X-CSE-ConnectionGUID: XCuwvFI+SqK9YXh418DnrA==
X-CSE-MsgGUID: +Dw2Sy/hQ4+K8k1hORJSyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="183709423"
Received: from bkammerd-mobl.amr.corp.intel.com (HELO kuha.fi.intel.com) ([10.124.221.165])
  by orviesa009.jf.intel.com with SMTP; 23 Oct 2025 02:04:35 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 23 Oct 2025 12:04:33 +0300
Date: Thu, 23 Oct 2025 12:04:33 +0300
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
Subject: Re: [PATCH v7 1/9] usb: typec: Add notifier functions
Message-ID: <aPnvoSRJefwDlpNO@kuha.fi.intel.com>
References: <20251023033009.90-1-kernel@airkyi.com>
 <20251023033009.90-2-kernel@airkyi.com>
 <aPni4AeDaem_rfZH@kuha.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPni4AeDaem_rfZH@kuha.fi.intel.com>

On Thu, Oct 23, 2025 at 11:10:20AM +0300, Heikki Krogerus wrote:
> Hi,
> 
> > diff --git a/include/linux/usb/typec_notify.h b/include/linux/usb/typec_notify.h
> > new file mode 100644
> > index 000000000000..a3f1f3b3ae47
> > --- /dev/null
> > +++ b/include/linux/usb/typec_notify.h
> > @@ -0,0 +1,17 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef __USB_TYPEC_NOTIFY
> > +#define __USB_TYPEC_NOTIFY
> > +
> > +#include <linux/notifier.h>
> > +
> > +enum usb_typec_event {
> > +	TYPEC_ALTMODE_REGISTERED
> > +};
> 
> Don't you need to know when the altmode is removed?

I noticed that you don't because drm_dp_hpd_bridge_register() is
always resource managed. But I think you could still send an event
also when the altmode is removed already now. That way it does not
need to be separately added if and when it is needed.

thanks,

-- 
heikki


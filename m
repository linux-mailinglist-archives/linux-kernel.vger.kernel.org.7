Return-Path: <linux-kernel+bounces-862460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC730BF55B4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668C94221AF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0391D328B4B;
	Tue, 21 Oct 2025 08:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aeGO1Ufi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37653303A15;
	Tue, 21 Oct 2025 08:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761036538; cv=none; b=dq5Vym8NRqd32wy1LhLd0qwLyLQtCt/JfO5mBOj4pjmBvzG7GfKsJT6SnpfIygW8FJ1wBjYTPZ8PjQp3qNm7PXAZc/YtXncbSRwqLXzAeNnvab/8auqyc/TqF50FScOGxpJj4Z0LaHfk3ZRCeJTkWmOtNnP0JrK2jrBXfX/LxdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761036538; c=relaxed/simple;
	bh=ixN0SnuQ8N2jtGJB1Dvgz9zJy2AHG8oUKIXx/yt/S8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CijaUcrY/RLO5P96oNEQq8bgxODn7YZIgRyQcahdkHF7hBZJBLiaUdO7n6igsWf4JaOt8quaEfYQb/dgnsAKMXymU/AldQwz8iJ0QYgPubvVKdMkI6JtzUXY3EnSgCxC+P8IeeA9MHkjvZ/8bx3q189+giwn1N62jGLzIRX/75s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aeGO1Ufi; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761036537; x=1792572537;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ixN0SnuQ8N2jtGJB1Dvgz9zJy2AHG8oUKIXx/yt/S8w=;
  b=aeGO1UfizO148v/f+76FotvAGhQrrCYY/x9BmoQxP+A2pkxG7iUmtZkz
   Iyna+f4PRrKpSWdiOsCCw3DQikrZhazqHP06b7HwH4FPdp5Gc9GIEwW81
   rhay9GR8u85mzEdVMOZGfyp7oOSIp5Lxq2h1EhC7Z+Qio6ROUcrRTz1bT
   qrTSDT64RGzM4u3T3tTx10SYX4wytVdiPDP0V7zCXctc1H4YqXzLrViiL
   MEK7fV8TZ1N8h5w8Bc5Nf1lGkEeA33SLG17mv9hlDOgnLHYrnTPn+QpOB
   Fi8OSNgkNYpy4XqELmlq3UG9n3LM6kNCrEL8FzkFpK+pMn0Lqx3tpLvuT
   Q==;
X-CSE-ConnectionGUID: DqATerEoTruQWsG2SbBjxw==
X-CSE-MsgGUID: rs5hlnUrQ+eyND0IVqHu7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="50732125"
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="50732125"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 01:48:56 -0700
X-CSE-ConnectionGUID: eCD/H1/RSIKfOQZXnX6Vww==
X-CSE-MsgGUID: 5oEWrWiFR5aYJfjpPgNG5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="183099996"
Received: from mgerlach-mobl1.amr.corp.intel.com (HELO kuha.fi.intel.com) ([10.124.220.224])
  by orviesa009.jf.intel.com with SMTP; 21 Oct 2025 01:48:47 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 21 Oct 2025 11:48:45 +0300
Date: Tue, 21 Oct 2025 11:48:45 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: Chaoyi Chen <kernel@airkyi.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
	Dragan Simic <dsimic@manjaro.org>, Johan Jonker <jbx6244@gmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Peter Robinson <pbrobinson@gmail.com>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v6 1/8] usb: typec: Add default HPD device when register
 DisplayPort altmode
Message-ID: <aPdI7Vb_djrfCfbT@kuha.fi.intel.com>
References: <20251016022741.91-1-kernel@airkyi.com>
 <20251016022741.91-2-kernel@airkyi.com>
 <aPYImGmesrZWwyqh@kuha.fi.intel.com>
 <954a67d1-1759-4e18-8eef-3fa14fb3cef5@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <954a67d1-1759-4e18-8eef-3fa14fb3cef5@rock-chips.com>

Hi,

On Mon, Oct 20, 2025 at 07:07:46PM +0800, Chaoyi Chen wrote:
> Hi Heikki,
> 
> On 10/20/2025 6:02 PM, Heikki Krogerus wrote:
> > On Thu, Oct 16, 2025 at 10:27:34AM +0800, Chaoyi Chen wrote:
> > > From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> > > 
> > > Add default DRM AUX HPD bridge device when register DisplayPort
> > > altmode. That makes it redundant for each Type-C driver to implement
> > > a similar registration process in embedded scenarios.
> > > 
> > > Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> > > ---
> > > 
> > > Changes in v6:
> > > - Fix depend in Kconfig.
> > > 
> > > Changes in v5:
> > > - Remove the calls related to `drm_aux_hpd_bridge_notify()`.
> > > - Place the helper functions in the same compilation unit.
> > > - Add more comments about parent device.
> > > 
> > >   drivers/usb/typec/Kconfig         |  2 ++
> > >   drivers/usb/typec/class.c         | 26 ++++++++++++++++++++++++++
> > >   include/linux/usb/typec_altmode.h |  2 ++
> > >   3 files changed, 30 insertions(+)
> > > 
> > > diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
> > > index 2f80c2792dbd..a6730fbb576b 100644
> > > --- a/drivers/usb/typec/Kconfig
> > > +++ b/drivers/usb/typec/Kconfig
> > > @@ -2,6 +2,8 @@
> > >   menuconfig TYPEC
> > >   	tristate "USB Type-C Support"
> > > +	depends on DRM || DRM=n
> > > +	select DRM_AUX_HPD_BRIDGE if DRM_BRIDGE && OF
> > This is wrong. DRM should not dictate how this entire subsystem core
> > is configured. The dependency needs to be on the DRM bridge side.
> > 
> > You can for example use the bus notification there to see when a new
> > alternate mode is being registered, or use some other notification
> > mechanism.
> 
> Is it a good idea to implement notification functions like
> drivers/usb/core/notify.c in TCPM, and then let other subsystems (such as DRM)
> listen to these notifications?

Don't limit this to tcpm only. I would suggest something similar what
we have for usb bus: drivers/usb/core/notify.c

So that, but for the typec bus. Then in DRM bridge code you just use
typec_register/unregister_notify().

thanks,

-- 
heikki


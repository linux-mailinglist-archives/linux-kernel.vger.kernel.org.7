Return-Path: <linux-kernel+bounces-866827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8359BC00C2A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62BD33AF343
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E17030F92B;
	Thu, 23 Oct 2025 11:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IvhdcHew"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBAC30C62E;
	Thu, 23 Oct 2025 11:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761219008; cv=none; b=P9pZFEoG/5/nL5GGATnukkz7bIAx79tZMhTBGl0QYdB7G2JhON4umCiSWZ56qDdPJV4WznwMTlM1PwP5LZAAycQgZDDdRF/GAKtyCSypZjXBy0dLfMSQ5ExK/hNyVyuD8UZsJZLrjmgWtoNPb09soAcFjwy7oBVwuoTNXVbttME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761219008; c=relaxed/simple;
	bh=XLkysNfegUvwyIevl1eKm/wT3mO3tDZSFi6ARpRRGTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8T0moe5bLKgtigc7+YZruE1M5Y0hh37aGkLMFdM4AWFVhMjlIGrfvpWJPQ2aaBO+hDQXff2twpt0FWxvC2rcFQ3IDfTXXWc/nTTWM4MNkXXqRBoNdn0hGzT7qfJY2mowW6Pe4vfe4A52l1ldgOrN9gWb02unNba5LeBt4i5Pzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IvhdcHew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513DEC4CEFF;
	Thu, 23 Oct 2025 11:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761219005;
	bh=XLkysNfegUvwyIevl1eKm/wT3mO3tDZSFi6ARpRRGTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IvhdcHewmfHAjgrwZglSVd155WrxiM4g73D6cbuvPY3vsvdnXN/GwE22hcg1dgSUO
	 qAme1OOliteiwXZvpnXyYvTrfNY/wdnvvQGBd00WxFrDDlL+QyLaVIqWgYWo5LujOT
	 aHqV/8zJm7ZSt8TCRKT9z8UFhoNeAC6JKxf2hhcE=
Date: Thu, 23 Oct 2025 13:29:58 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
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
Subject: Re: [PATCH v7 1/9] usb: typec: Add notifier functions
Message-ID: <2025102308-glorified-greedy-e41c@gregkh>
References: <20251023033009.90-1-kernel@airkyi.com>
 <20251023033009.90-2-kernel@airkyi.com>
 <aPni4AeDaem_rfZH@kuha.fi.intel.com>
 <aPnvoSRJefwDlpNO@kuha.fi.intel.com>
 <aPn4-S7upPOOtenr@kuha.fi.intel.com>
 <9c52db41-14f3-41a8-9423-3efe604361aa@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c52db41-14f3-41a8-9423-3efe604361aa@rock-chips.com>

On Thu, Oct 23, 2025 at 07:21:31PM +0800, Chaoyi Chen wrote:
> Hi Heikki,
> 
> On 10/23/2025 5:44 PM, Heikki Krogerus wrote:
> > On Thu, Oct 23, 2025 at 12:04:44PM +0300, Heikki Krogerus wrote:
> > > On Thu, Oct 23, 2025 at 11:10:20AM +0300, Heikki Krogerus wrote:
> > > > Hi,
> > > > 
> > > > > diff --git a/include/linux/usb/typec_notify.h b/include/linux/usb/typec_notify.h
> > > > > new file mode 100644
> > > > > index 000000000000..a3f1f3b3ae47
> > > > > --- /dev/null
> > > > > +++ b/include/linux/usb/typec_notify.h
> > > > > @@ -0,0 +1,17 @@
> > > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > > +
> > > > > +#ifndef __USB_TYPEC_NOTIFY
> > > > > +#define __USB_TYPEC_NOTIFY
> > > > > +
> > > > > +#include <linux/notifier.h>
> > > > > +
> > > > > +enum usb_typec_event {
> > > > > +	TYPEC_ALTMODE_REGISTERED
> > > > > +};
> > > > Don't you need to know when the altmode is removed?
> > > I noticed that you don't because drm_dp_hpd_bridge_register() is
> > > always resource managed. But I think you could still send an event
> > > also when the altmode is removed already now. That way it does not
> > > need to be separately added if and when it is needed.
> > Hold on! Every bus has already a notifier chain. That's the one that
> > we should also use. Sorry for not noticing that earlier.
> > 
> > So let's just export the bus type in this patch - you can then use
> > bus_register_notifier() in your driver:
> > 
> > diff --git a/drivers/usb/typec/bus.c b/drivers/usb/typec/bus.c
> > index a884cec9ab7e..65ded9e3cdaa 100644
> > --- a/drivers/usb/typec/bus.c
> > +++ b/drivers/usb/typec/bus.c
> > @@ -547,3 +547,4 @@ const struct bus_type typec_bus = {
> >          .probe = typec_probe,
> >          .remove = typec_remove,
> >   };
> > +EXPORT_SYMBOL_GPL(typec_bus);
> > diff --git a/drivers/usb/typec/bus.h b/drivers/usb/typec/bus.h
> > index 643b8c81786d..af9edb3db9d0 100644
> > --- a/drivers/usb/typec/bus.h
> > +++ b/drivers/usb/typec/bus.h
> > @@ -5,7 +5,6 @@
> >   #include <linux/usb/typec_altmode.h>
> > -struct bus_type;
> >   struct typec_mux;
> >   struct typec_retimer;
> > @@ -28,7 +27,6 @@ struct altmode {
> >   #define to_altmode(d) container_of(d, struct altmode, adev)
> > -extern const struct bus_type typec_bus;
> >   extern const struct device_type typec_altmode_dev_type;
> >   #define is_typec_altmode(_dev_) (_dev_->type == &typec_altmode_dev_type)
> > diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
> > index 309251572e2e..c6fd46902fce 100644
> > --- a/include/linux/usb/typec.h
> > +++ b/include/linux/usb/typec.h
> > @@ -20,12 +20,15 @@ struct typec_port;
> >   struct typec_altmode_ops;
> >   struct typec_cable_ops;
> > +struct bus_type;
> >   struct fwnode_handle;
> >   struct device;
> >   struct usb_power_delivery;
> >   struct usb_power_delivery_desc;
> > +extern const struct bus_type typec_bus;
> > +
> >   enum typec_port_type {
> >          TYPEC_PORT_SRC,
> >          TYPEC_PORT_SNK,
> 
> Thank you for your detailed explanation. I noticed that there is a device_register() action in typec_register_altmode(), so we can just take advantage of this.
> 
> 
> Another thing is that we need to distinguish between different devices in the notifier callback, as typec_register_altmode()/typec_register_partner()/typec_register_plug()/typec_register_cable() may all register devices. Since the data passed in bus_notify() is struct device *dev, I think we can distinguish them through `dev->type.name`? We may already have such names, "typec_alternate_mode", "typec_partner", "typec_plug" in class.c . And then extract these names as macros and put them in the typec header file.
> 
> 
> Or do you have any better ideas? Thank you.

Check based on the type itself, NOT on the type name, as all device
types on a bus should be unique.  If the structure for that is not
properly exported for you to use, just export it.

thanks,

greg k-h


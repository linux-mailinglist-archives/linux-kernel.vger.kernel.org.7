Return-Path: <linux-kernel+bounces-808555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD7CB5017C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 670EB1899808
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8F8352FC2;
	Tue,  9 Sep 2025 15:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iOqXUbnG"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C75352FCE;
	Tue,  9 Sep 2025 15:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757431772; cv=none; b=NOqrqS8aCAkfhF2Bqswtzej/y5RJjbanMmdXf385vdD2rXh6JQRDNFnYGxesR7ivf86Nj8Np8dC/CL7CLHD+2uwsfoZGKQeB5KPL6ur7GqTqvO5lPTT3L9jJCLXp69abJzwF1mE6caeEfUY6qdXEJnryojhVd47dIoDIKc2cvuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757431772; c=relaxed/simple;
	bh=bGjGxIlRC+fCTTLrnsB+Rh8PRvu9oTgi4VBagg69BU0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cn3oab8ynQVpPYyeCTvSpfyigrFfn1V1eWAvWv/VFoQqQa530i9oq0D/iNgJJOOVGxp/LSpmbqDLFulN3Wf/H/Ji40D+QXegFUsHnvlyMfrRKySW4f5/dsJ+MeP0oXgAHn0Y9W1cbf/DF0Ysqf0yVk9TkVBW/Z49YmwVu/ZeaMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iOqXUbnG; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 815804E408EC;
	Tue,  9 Sep 2025 15:29:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 556BB60630;
	Tue,  9 Sep 2025 15:29:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7CCB6102F2894;
	Tue,  9 Sep 2025 17:29:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757431765; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=cEGgAxe+mYxpfziOqV0lwFRaYNwTx1csOZYBNgQcagA=;
	b=iOqXUbnGQubKBEz7X7HOvP75z7ndj8gwiExwyw/YL+JVyXvR2tcik8PDSaZdgC4OctdQpc
	o/gEKj1IEo6QhEXAV24aCYOHvZ7BUpovxWanyoR/LWgaoh5WLiT1GA5vVtEr6dgN0EbMYs
	Zj3OO/dwT5WOWMef/CPo+v2+gMhxfhsrS/z1rAFSxChT0dufcsmNS552arlWDb1cQfiiAy
	qXd068xkP+r3TSMnyQICyf/VKPQFkvtTcZxeysEnVgXBz3MYsj1fAq+7yqUPj4mYxVDG15
	6lP0E072cKpjhjdbaRqqKF7FK49NN6AmRi3cZ4ttVaCRlt580x7fJOi27+6POQ==
Date: Tue, 9 Sep 2025 17:29:07 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Maxime Ripard
 <mripard@kernel.org>
Cc: Simona Vetter <simona@ffwll.ch>, Inki Dae <inki.dae@samsung.com>, Jagan
 Teki <jagan@amarulasolutions.com>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Daniel Thompson <danielt@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Paul Kocialkowski <contact@paulk.fr>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, =?UTF-8?B?SGVy?=
 =?UTF-8?B?dsOp?= Codina <herve.codina@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, Paul
 Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v5 10/10] drm/bridge: hotplug-bridge: add driver to
 support hot-pluggable DSI bridges
Message-ID: <20250909172907.09157d70@booty>
In-Reply-To: <20250102130140.59363125@booty>
References: <20241231-hotplug-drm-bridge-v5-0-173065a1ece1@bootlin.com>
	<20241231-hotplug-drm-bridge-v5-10-173065a1ece1@bootlin.com>
	<ourjepuvkhzpemhak3t6do3or6shrj4cq2plhii4afgej4qhkk@p6tvptupr3ey>
	<20250102130140.59363125@booty>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hello Dmitry, Maxime, DRM maintainers,

On Thu, 2 Jan 2025 13:01:40 +0100
Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:

> Hi Dmitry,
> 
> On Tue, 31 Dec 2024 17:29:52 +0200
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
> 
> > On Tue, Dec 31, 2024 at 11:40:04AM +0100, Luca Ceresoli wrote:  
> > > This driver implements the point of a DRM pipeline where a connector allows
> > > removal of all the following bridges up to the panel.
> > > 
> > > The DRM subsystem currently allows hotplug of the monitor but not preceding
> > > components. However there are embedded devices where the "tail" of the DRM
> > > pipeline, including one or more bridges, can be physically removed:
> > > 
> > >  .------------------------.
> > >  |   DISPLAY CONTROLLER   |
> > >  | .---------.   .------. |
> > >  | | ENCODER |<--| CRTC | |
> > >  | '---------'   '------' |
> > >  '------|-----------------'
> > >         |
> > >         |               HOTPLUG
> > >         V              CONNECTOR
> > >    .---------.        .--.    .-.        .---------.         .-------.
> > >    | 0 to N  |        | _|   _| |        | 1 to N  |         |       |
> > >    | BRIDGES |--DSI-->||_   |_  |--DSI-->| BRIDGES |--LVDS-->| PANEL |
> > >    |         |        |  |    | |        |         |         |       |
> > >    '---------'        '--'    '-'        '---------'         '-------'
> > > 
> > >  [--- fixed components --]  [----------- removable add-on -----------]
> > > 
> > > This driver supports such a device, where the final segment of a MIPI DSI
> > > bus, including one or more bridges, can be physically disconnected and
> > > reconnected at runtime, possibly with a different model.
> > > 
> > > The add-on supported by this driver has a MIPI DSI bus traversing the
> > > hotplug connector and a DSI to LVDS bridge and an LVDS panel on the add-on.
> > > Hovever this driver is designed to be as far as possible generic and
> > > extendable to other busses that have no native hotplug and model ID
> > > discovery.
> > > 
> > > This driver does not itself add and remove the bridges or panel on the
> > > add-on: this needs to be done by other means, e.g. device tree overlay
> > > runtime insertion and removal. The hotplug-bridge gets notified by the DRM
> > > bridge core after a removable bridge gets added or before it is removed.
> > > 
> > > The hotplug-bridge role is to implement the "hot-pluggable connector" in
> > > the bridge chain. In this position, what the hotplug-bridge should ideally
> > > do is:
> > > 
> > >  * communicate with the previous component (bridge or encoder) so that it
> > >    believes it always has a connected bridge following it and the DRM card
> > >    is always present
> > >  * be notified of the addition and removal of the following bridge and
> > >    attach/detach to/from it
> > >  * communicate with the following bridge so that it will attach and detach
> > >    using the normal procedure (as if the entire pipeline were being created
> > >    or destroyed, not only the tail)
> > >  * instantiate two DRM connectors (similarly to what the DisplayPort MST
> > >    code does):
> > >    - a DSI connector representing the video lines of the hotplug connector;
> > >      the status is always "disconnected" (no panel is ever attached
> > >      directly to it)
> > >    - an LSVD connector representing the classic connection to the panel;
> > >      this gets added/removed whenever the add-on gets
> > >      connected/disconnected; the status is always "connected" as the panel
> > >      is always connected to the preceding bridge    
> > 
> > I'd rather have just a single connector. MST connectors can be added and
> > gone as there is fit, so should be your LVDS panel-related connector.  
> 
> The plan we discussed at LPC 2024 is to eventually get rid of the first
> connector (see "Roadmap and current status" in the cover letter), so
> you can consider this legacy code. However the current implementation
> won't work without this connector, so it is still there for the time
> being. Pointing this out in a note in the commit message of this patch
> would probably be useful to avoid future misunderstanding, so I'm
> adding one for v6.

Reviving this old thread for a specific question I need to clarify.
Before starting a work that I consider far from trivial I'd like to
make sure the requirement is clear.

There was a precise request by both Dmitry and (IIRC) Maxime to remove
the "always present, never connected" DSI connector.

[Recap of previous discussion: skip if unneeded]

The current status is that the hotplug-bridge, which can start without
an add-on plugged, adds a DSI connector unconditionally:

  # modetest -c  | grep -i '^[a-z0-9]'
  Connectors:
  id    encoder status          name        size (mm)     modes   encoders
  38    0       disconnected    DSI-1       0x0           0       37

That DSI connector status is always "unconnected" (in my implementation
at least) because it does never a panel _directly_ attached, only a
further bridge.

Then when the add-on is plugged, which contains a DSI-to-LVDS bridge, a
new LVDS connector is added:

  # modetest -c  | grep -i '^[a-z0-9]'
  Connectors:
  id    encoder status          name        size (mm)     modes   encoders
  38    0       disconnected    DSI-1       0x0           0       37
  39    0       connected       LVDS-1      344x194       1       37

The LVDS connector has a panel attached and provides the modes, so it
is "the connector" in the DRM logic. It is always in "connected" status
because it drives a panel that is always tied to the DSI-to-LVDS bridge.
It is removed when the add-on is removed and so the removable bridge(s)
disappear(s).

The request is to get rid of the DSI connector, because it is not a DRM
connector in the classic DRM sense (DRM connector ~= a modes +
connection status provider). That would mean without addon plugged
there is no DRM connector at all.

However for user space to be able to always have a card we need the
card to be populated even before the addon is plugged and to persist
after its removal. So, a card without any connectors.

[End of recap of previous discussion]

Now comes the question!

Based on the above, I understand that:

 * Current DRM code won't populate a card without at least a DRM
   connector
 * We now need to change the DRM code to allow populating a card,
   and expose it to user space, without a DRM connector
 * The previous bullet is a prerequisite to get rid of DSI connector as
   requested

Is my understanding correct?

Best regards,
Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


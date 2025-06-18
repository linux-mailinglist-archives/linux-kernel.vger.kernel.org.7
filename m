Return-Path: <linux-kernel+bounces-691558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BB5ADE617
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 10:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41E1D3A2B24
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 08:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3558C27E072;
	Wed, 18 Jun 2025 08:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ai/3P3mI"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9194A35963
	for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 08:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750236726; cv=none; b=HH1/ORX1oCN0gf0pAHPyh4X72wHcoX/KHE8fpK/7iScY2qNy7Jqgw+zermNyYZpR0p2nAgyFD5coo0iUxm788APUS8k5ElcvaLUVtTWZwU27sUnVBiKmbYOub1In+Qx1uxwn8/rE1repz28VSles0s1FdFxCsHxpPQNVdBVd8Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750236726; c=relaxed/simple;
	bh=ZeCteARbFVkoB5kqEFjOv9C7j84UpKJS8G6698+QVsM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CGfky3DNhD8wE3DilZXDcL+eH4wFy6EwVlqRGOc8JQWNYNhiXxwFhwgiHa/uPkzfWiu0/fd0uzKFt6ZHo+KU/AAXH6eW4APqmD26P1rqEnkI3X65xzeEsO3fOHYVngP3xI4+wQkdiMn4If5oSUl6xcR1vQbssQ4b7ZYxzkaMx8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ai/3P3mI; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EF86E442A1;
	Wed, 18 Jun 2025 08:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750236722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l4hm8DAzRZ2eqN+qHSZp27aNSEI1HsmdDE6YkIdlTp8=;
	b=ai/3P3mImKWBMJZSbUDwdB30HFMvQRAe8D3SDHtU4rPOSz9mySfOiOnuZTKMShOqNxQrU+
	sez8fNnTeATEU7PS0dbMp6n8wsbMxwEu5COspteTyNNoCu6u/8gJQLmxsLnFz2FanBQ/Ea
	BhVpX91+RXMXOp0/za7Dj43U8TE4hTQUx6+QlArCDCVVpTme2v2/4AzJkqngnRaqiEnF8a
	Zny+fiPyNkDLpaS5ehHb7YG0iGEOQVRlge7I0EDAXCC8nNStfSo86/OZtEkN3D3QlzapZR
	8C/kxWkBr+CE8Dd7a7+7q8ZV5bXsWElk9HgnuS7Vu68IqZeLcgJEYM4ejeK5TA==
Date: Wed, 18 Jun 2025 10:51:58 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Anusha Srivatsa <asrivats@redhat.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, Maxime Ripard
 <mripard@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, Jessica
 Zhang <quic_jesszhan@quicinc.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: drm/panel/panel-simple v6.16-rc1 WARNING regression
Message-ID: <20250618105158.06e42668@booty>
In-Reply-To: <CAN9Xe3RFEXZuWTZB5E1tJdjXc9o_hB1ArgA5SvqbDUBkwYea8w@mail.gmail.com>
References: <20250612081834.GA248237@francesco-nb>
	<CAN9Xe3RFEXZuWTZB5E1tJdjXc9o_hB1ArgA5SvqbDUBkwYea8w@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephfetudeugfehheeliefhjeejuddvledtuddttdevledthfehgeeugfetheekgfffnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgdphhgvlhhopegsohhothihpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddvpdhrtghpthhtoheprghsrhhivhgrthhssehrvgguhhgrthdrtghomhdprhgtphhtthhopehfrhgrnhgtvghstghoseguohhltghinhhirdhithdprhgtphhtthhopehmrhhiphgrrhgusehkvghrnhgvlhdrohhrghdprhgtphhtt
 hhopehnvghilhdrrghrmhhsthhrohhngheslhhinhgrrhhordhorhhgpdhrtghpthhtohepqhhuihgtpghjvghsshiihhgrnhesqhhuihgtihhntgdrtghomhdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrshhtsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepthiiihhmmhgvrhhmrghnnhesshhushgvrdguvgdprhgtphhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhm
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Anusha, Francesco,

On Tue, 17 Jun 2025 11:17:20 -0500
Anusha Srivatsa <asrivats@redhat.com> wrote:

> On Thu, Jun 12, 2025 at 3:24=E2=80=AFAM Francesco Dolcini <francesco@dolc=
ini.it>
> wrote:
>=20
> > Hello all,
> >
> > Commit de04bb0089a9 ("drm/panel/panel-simple: Use the new allocation in
> > place of devm_kzalloc()")
> > from 6.16-rc1 introduced a regression with this warning during probe
> > with panel dpi described in the DT.
> >
> > A revert solves the issue.
> >
> > The issue is that connector_type is set to DRM_MODE_CONNECTOR_DPI in
> > panel_dpi_probe() that after that change is called after
> > devm_drm_panel_alloc().
> >
> > I am not sure if there are other implication for this change in the call
> > ordering, apart the one that triggers this warning.
> >
> > [   12.089274] ------------[ cut here ]------------
> > [   12.089303] WARNING: CPU: 0 PID: 96 at
> > drivers/gpu/drm/bridge/panel.c:377 devm_drm_of_get_bridge+0xac/0xb8
> > [   12.130808] Modules linked in: v4l2_jpeg pwm_imx27(+) imx_vdoa
> > gpu_sched panel_simple imx6_media(C) imx_media_common
> > (C) videobuf2_dma_contig pwm_bl gpio_keys v4l2_mem2mem fuse ipv6 autofs4
> > [   12.147774] CPU: 0 UID: 0 PID: 96 Comm: kworker/u8:3 Tainted: G
> >  C          6.16.0-rc1+ #1 PREEMPT
> > [   12.157446] Tainted: [C]=3DCRAP
> > [   12.160418] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tre=
e)
> > [   12.166953] Workqueue: events_unbound deferred_probe_work_func
> > [   12.172805] Call trace:
> > [   12.172815]  unwind_backtrace from show_stack+0x10/0x14
> > [   12.180598]  show_stack from dump_stack_lvl+0x68/0x74
> > [   12.185674]  dump_stack_lvl from __warn+0x7c/0xe0
> > [   12.190407]  __warn from warn_slowpath_fmt+0x1b8/0x1c0
> > [   12.195567]  warn_slowpath_fmt from devm_drm_of_get_bridge+0xac/0xb8
> > [   12.201949]  devm_drm_of_get_bridge from imx_pd_probe+0x58/0x164
> > [   12.207976]  imx_pd_probe from platform_probe+0x5c/0xb0
> > [   12.213220]  platform_probe from really_probe+0xd0/0x3a4
> > [   12.218551]  really_probe from __driver_probe_device+0x8c/0x1d4
> > [   12.224486]  __driver_probe_device from driver_probe_device+0x30/0xc0
> > [   12.230942]  driver_probe_device from __device_attach_driver+0x98/0x=
10c
> > [   12.237572]  __device_attach_driver from bus_for_each_drv+0x90/0xe4
> > [   12.243854]  bus_for_each_drv from __device_attach+0xa8/0x1c8
> > [   12.249614]  __device_attach from bus_probe_device+0x88/0x8c
> > [   12.255285]  bus_probe_device from deferred_probe_work_func+0x8c/0xcc
> > [   12.261739]  deferred_probe_work_func from process_one_work+0x154/0x=
2dc
> > [   12.268371]  process_one_work from worker_thread+0x250/0x3f0
> > [   12.274043]  worker_thread from kthread+0x12c/0x24c
> > [   12.278940]  kthread from ret_from_fork+0x14/0x28
> > [   12.283660] Exception stack(0xd0be9fb0 to 0xd0be9ff8)
> > [   12.288720] 9fa0:                                     00000000 00000=
000
> > 00000000 00000000
> > [   12.296906] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000=
000
> > 00000000 00000000
> > [   12.305089] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000=
000
> > [   12.312050] ---[ end trace 0000000000000000 ]---
> >
> > #regzbot ^introduced: de04bb0089a96cc00d13b12cbf66a088befe3057
> >
> > Any advise?
> >
> > Hey Francesco! =20
>=20
> This mail reached my spam and I hadn't realised till today. Thanks for
> bringing this to attention.
>
> Thinking out loud here: If we called dpi_probe() before allocating the
> panel using devm_drm_panel_alloc()
> then we would have the connector type. But  dpi_probe() needs the panel to
> be allocated....

Reading the panel-simple.c code, the handling of the panel_dsi
descriptor feels a bit hacky, and the recent change to
devm_drm_panel_alloc() breaks it easily. Perhaps it would be cleaner to
assess the whole descriptor before ding any allocation/init.

You're right tat panel_dpi_probe() needs the panel, but it's only at the
very end, to assign the descriptor:

  panel->desc =3D desc;

I think a good fix would be to clean it up by having:

 * panel_dpi_probe() not take a panel pointer but rather returning a
   filled descriptor
 * panel_simple_probe() call panel_dpi_probe() early [before
   devm_drm_panel_alloc()] and get the filled descriptor
 * call devm_drm_panel_alloc() with that descriptor in the panel-dsi
   case, or with the good old descriptor otherwise

As a good side effect, it would get rid of a case where
devm_drm_panel_alloc() is called with a Unknown connector type.

Anusha, does it look like a good plan?

Luca

--=20
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


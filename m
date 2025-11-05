Return-Path: <linux-kernel+bounces-885876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A471BC34196
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 07:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 599C64F0903
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 06:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099872C15A2;
	Wed,  5 Nov 2025 06:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="g3IvUDxE"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CB82C11E8;
	Wed,  5 Nov 2025 06:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762325494; cv=none; b=Nd23lz/27nhvBNJsEx08aR4m/yCG3kTjjop99QzWvmEsvmBl9zmWFxcGQCr+heKZHkjLoEaopJmVoOlNSpGep21oRo+XgOYYMCxsRGfYNS775odn8vpTAg5TJh4lVWGPTWmlBtBpqHM9OzKS98uF/o6QSBPfDmdiXsV1Jfvdoqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762325494; c=relaxed/simple;
	bh=28fwD/DeHigm3/oxHExJ1zgx8z4FLlzDSl8G0AySjY8=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=QpCWj0nkcljiPgEVNulvoSfm+cNjSUaaap+d9sc/7kf/z+Vs2J04fYdLDaO37S0SIH/UgRQ1Ko5rl0KKK5B0dQ4JuAdkoTPJ/ZUmCOyGS8U/QPyrsQgiGwXPRq70qB8/RRHwDMrxQvofmkri5Um/iuSG28h8RI1Y1AOlhISZaPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=g3IvUDxE; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from mail.ideasonboard.com (unknown [IPv6:2401:4900:1c67:1e6b:c21c:d386:b74e:e876])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 53DE3446;
	Wed,  5 Nov 2025 07:49:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762325374;
	bh=28fwD/DeHigm3/oxHExJ1zgx8z4FLlzDSl8G0AySjY8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=g3IvUDxEb1PbSXQm9Kgk3dE8t7oCPugrK4wVg5SS6cq3hvKwwKBC38U4eBt9Fudyk
	 7QAfPQLJhV0UOKe31uBeAA9TYfbqnPavatyZ+hX2p+zHde9qD9R/8q6zCK45+BnFCp
	 eOx5AB2sJHzV8t0yb1haLYa5Hr+4HW5V9iRfHXMc=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3e538ec1-37f6-416c-bc04-6f21a4d31748@broadcom.com>
References: <20251028-rpi-isp-clk-v1-1-2a54fecb495c@ideasonboard.com> <3e538ec1-37f6-416c-bc04-6f21a4d31748@broadcom.com>
Subject: Re: [PATCH] clk: bcm: rpi: Mark ISP clock as critical
From: Jai Luthra <jai.luthra@ideasonboard.com>
Cc: linux-clk@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Florian Fainelli <florian.fainelli@broadcom.com>, =?utf-8?q?Ma=C3=ADra?= Canal <mcanal@igalia.com>, Michael Turquette <mturquette@baylibre.com>, Stefan Wahren <wahrenst@gmx.net>, Stephen Boyd <sboyd@kernel.org>
Date: Wed, 05 Nov 2025 12:21:23 +0530
Message-ID: <176232548379.1167490.1126479868042439951@freya>
User-Agent: alot/0.12.dev28+gd2c823fe

Hi Florian,

Quoting Florian Fainelli (2025-11-05 03:50:23)
> On 10/28/25 04:46, Jai Luthra wrote:
> > The ISP clock should also be marked critical to prevent the clock
> > framework from disabling it on boot, which can lead to bus lockups when
> > the kernel tries to submit buffers to the VC4 ISP firmware.
>=20
> The commit message suggests that the driver that interfaces with the VC4 =

> ISP firmware is not ensuring that the clock remains enabled for the=20
> duration of the transactions. That would be a driver bug, would not it?
>=20

Yes, from https://github.com/raspberrypi/linux/issues/7100#issuecomment-346=
7699055
the VC4 firmware should be responsible for stopping and starting that clock
when necessary.

The downstream bcm2835-isp linux driver currently does not consume this
clock at all, so I'm not sure if the cleaner solution is to drop this
altogether from linux, or mark it as a consumer, along with fixing the
firmware driver.

> >=20
> > Link: https://github.com/raspberrypi/linux/issues/7100
> > Fixes: 919d6924ae9b ("clk: bcm: rpi: Turn firmware clock on/off when pr=
eparing/unpreparing")
> > Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
> > ---
> >   drivers/clk/bcm/clk-raspberrypi.c | 1 +
> >   1 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-ra=
spberrypi.c
> > index 1a9162f0ae31e330c46f6eafdd00350599b0eede..dcc3ae5fb91650b042d52f0=
2499922786b43afde 100644
> > --- a/drivers/clk/bcm/clk-raspberrypi.c
> > +++ b/drivers/clk/bcm/clk-raspberrypi.c
> > @@ -151,6 +151,7 @@ raspberrypi_clk_variants[RPI_FIRMWARE_NUM_CLK_ID] =
=3D {
> >       [RPI_FIRMWARE_ISP_CLK_ID] =3D {
> >               .export =3D true,
> >               .minimize =3D true,
> > +             .flags =3D CLK_IS_CRITICAL,
> >       },
> >       [RPI_FIRMWARE_PIXEL_BVB_CLK_ID] =3D {
> >               .export =3D true,
> >=20
> > ---
> > base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> > change-id: 20251028-rpi-isp-clk-eb5c48346e51
> >=20
> > Best regards,
>=20
>=20
> --=20
> Florian

Thanks,
Jai


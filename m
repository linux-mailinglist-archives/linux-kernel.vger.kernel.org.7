Return-Path: <linux-kernel+bounces-882968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CF3C2C128
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 14:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AC1E3A9804
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 13:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE80253F13;
	Mon,  3 Nov 2025 13:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="iv063utx"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A5121CC58
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 13:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762176160; cv=none; b=DiWIWxM7YdNwVwSxUPhAfFRWMXyVBaGAzPVQ0jilwp1Jx6s3aYap/1sfll7ja25boGJhb9Qg/rw0YlXreJZ/6XsEslR5Q4E+WQp6o3c7UahounDG4jlfbxiQ20iDVLCkaSjru8KWzerWXSq4TohIt/elzcpPnGgaZDWCzmnU+vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762176160; c=relaxed/simple;
	bh=KTavCG9dcnWlWcBPGQuxuWsWD5GhGldfM+WDzWPZ6GI=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=Oy8KBX4bqfU7QkKiWCmsgWgbKLOFx1VHATHb+NvgWQbljFo5PudzzGA9TIlxlvz4uC6XN5UEzRnGikAwDD7qWV8981qwg38vdy4Z4sfs1Xe4xm+CCRQVI44h09qSwFrspU//BQDODJM0TAqDAMA9dvYIUuUAGWz74yP84BD/9wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=iv063utx; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from mail.ideasonboard.com (unknown [IPv6:2401:4900:1c69:314e:ee86:ae6e:30:9d13])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id CF32A1C6;
	Mon,  3 Nov 2025 14:20:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762176043;
	bh=KTavCG9dcnWlWcBPGQuxuWsWD5GhGldfM+WDzWPZ6GI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=iv063utxxGJrjSsQdhzhMkYbb4c7mqvhCvHFYX5mFqB163XF/lIg27csr2uOGGwZh
	 xQvfOu8pl5k5R14V96mdxS784NcgMEbKVC4GSiEMlkIwv8h7hUYCi/XCVDYNMuNcmG
	 jK2IGrdMjLpzDeDAcmrgh8rXHpxLmouFCW01bu4s=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e3b8e670-313d-44b0-b026-f92252d71662@amd.com>
References: <20251031-b4-vc-sm-cma-v1-0-0dd5c0ec3f5c@ideasonboard.com> <20251031-b4-vc-sm-cma-v1-1-0dd5c0ec3f5c@ideasonboard.com> <e3b8e670-313d-44b0-b026-f92252d71662@amd.com>
Subject: Re: [PATCH 01/13] platform/raspberrypi: vchiq-mmal: Avoid use of bool in structures
From: Jai Luthra <jai.luthra@ideasonboard.com>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>, Phil Elwell <phil@raspberrypi.com>, Stefan Wahren <wahrenst@gmx.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, Sumit Semwal <sumit.semwal@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Dave Stevenson <dave.stevenson@raspberrypi.org>
To: Christian =?utf-8?q?K=C3=B6nig?= <christian.koenig@amd.com>, Krzysztof Kozlowski <krzk@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, bcm-kernel-feedback-list@broadcom.com
Date: Mon, 03 Nov 2025 18:52:30 +0530
Message-ID: <176217615029.8690.11618877016123000092@freya>
User-Agent: alot/0.12.dev28+gd2c823fe

Hi Christian, Krzyztof,

Quoting Christian K=C3=B6nig (2025-11-03 16:39:15)
> On 10/31/25 18:27, Jai Luthra wrote:
> > From: Dave Stevenson <dave.stevenson@raspberrypi.org>
> >=20
> > Fixes up a checkpatch error "Avoid using bool structure members
> > because of possible alignment issues".
>=20
> Mhm, at least of hand that doesn't looks correct to me.
>=20
> What exactly is the checkpatch.pl error or warning message you get?

My bad, commit 640e77466e69 ("staging: mmal-vchiq: Avoid use of bool in
structures") that had switched vchiq_mmal_component.enabled from a bool to
1-bit bitfield has already been reverted in mainline.. this stray change
seems to have persisted in RPi's downstream kernel.

I'll drop this and other irrelevant changes in the next revision of this
series.

>=20
> Regards,
> Christian.
>=20
> >=20
> > Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.org>
> > Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
> > ---
> >  drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c b/dri=
vers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c
> > index cd073ed3ea2dd9c45b137f1a32e236e520b7b320..82c2c261fd9cf0669cbd2ca=
7c814e0703317885a 100644
> > --- a/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c
> > +++ b/drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c
> > @@ -1776,7 +1776,7 @@ int vchiq_mmal_component_enable(struct vchiq_mmal=
_instance *instance,
> > =20
> >       ret =3D enable_component(instance, component);
> >       if (ret =3D=3D 0)
> > -             component->enabled =3D true;
> > +             component->enabled =3D 1;
> > =20
> >       mutex_unlock(&instance->vchiq_mutex);
> > =20
> >=20
>=20

Thanks,
Jai


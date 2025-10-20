Return-Path: <linux-kernel+bounces-860366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1745DBEFF6A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF4C14E3D70
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B871E29ACC5;
	Mon, 20 Oct 2025 08:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="mPDgNYmB"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5FC2153FB;
	Mon, 20 Oct 2025 08:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760949120; cv=none; b=IFNvWUY2nMUaZyRt/gmUHdLpXNFDyKaqM05oAEbhCm1vmSExC9EOWgP8RdmTiok9U5Kn1w42a13OD74oS/MNgpF/hZcQqwDg3gaF2q7k+IzRTApKym1byksyjdlkbP/SokrvvF05lw77wg02+uC5YvfOi6Bss6yKnUmOio4zLtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760949120; c=relaxed/simple;
	bh=nW+5kA6uUzCaSA9DzZnF8B9Sku564AsvXK0wLxgURvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s55+Z0tFaIirsypYLeCapYIeBHhY3iwt1aZRrpkEbbdNkvvCz7z0wlkOYwEJTrt7U/ZY4P6wtwL0pftZWxYcv7x9QrYsd/YSet2hMkF40b8Lk9PQV7Vb+bCMHT1VRQl2ReXFHsyy45KzrGxymm70Kx5w5AIToCQIZS509BrMiFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=mPDgNYmB; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=xZ91Gwi5gifJjpKKisGxIOuvBzMpfG2m0X4OcVippnU=; b=mPDgNYmBcwiY902BXGH+5TCCcB
	5zONyq1MWAa8X2urnLL60sGhBpmiWQriEPjndquGrDH9sR7EIIwJFpbyFfRnZ1m1Zdfkrb4SXN2SP
	8ODciQWSVOYgmjZm4qcsUiw8ZFf1kzDuyZscjXj/8mLqh+YAHfgOXt7aBiohFFGHWT8xVr7a0WKxa
	qykeuoyBnvJ4ntaiGa1CwD6yEwtkGym3u4SqTHUmyR9rgfWb1Oxb0Dt5Aqc8Vq9KlwOTQzVBi3HZd
	ffYWNR7JzDZ5kR9uoh7VUfxOBwDH4cmDVEyjRJ16xPeewI/PxzDDQwAX67X+grdRGu353fN+3m9rn
	A/WKdVwA==;
Received: from [141.76.253.240] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vAlJ3-0007Cv-TS; Mon, 20 Oct 2025 10:31:53 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Alexey Charkov <alchark@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add DSI LCD display on rk3576-evb1
Date: Mon, 20 Oct 2025 10:31:53 +0200
Message-ID: <5143458.iZASKD2KPV@phil>
In-Reply-To:
 <CABjd4YwVfrzxYKM4cAG=-fMbw9OcQGZD20CVCG8FvC8phDsw+Q@mail.gmail.com>
References:
 <20250925-rk3576-evb1-dsi-v1-1-c76fc3740abc@gmail.com>
 <CABjd4YwVfrzxYKM4cAG=-fMbw9OcQGZD20CVCG8FvC8phDsw+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Montag, 20. Oktober 2025, 10:19:51 Mitteleurop=C3=A4ische Sommerzeit sch=
rieb Alexey Charkov:
> On Thu, Sep 25, 2025 at 12:38=E2=80=AFAM Alexey Charkov <alchark@gmail.co=
m> wrote:
> >
> > Add support for the Rockchip W552793DBA-V10 LCD+touchscreen assembly wh=
ich
> > comes physically attached to Rockchip RK3576 EVB1 boards.
> >
> > The display part is driven by the on-chip MIPI DSI controller, and the
> > touchscreen is connected over I2C.
> >
> > Signed-off-by: Alexey Charkov <alchark@gmail.com>
> > ---
> > Note that backlight support is left out for now, as it depends on PWM
> > support [0] which has not yet been merged.
> >
> > A workaround is simply `gpioset -c 0 13=3D1` to set the respective GPIO
> > pin high and thus to light up the display unconditionally.
> >
> > [0] https://lore.kernel.org/lkml/20250602-rk3576-pwm-v2-0-a6434b0ce60c@=
collabora.com/
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts | 89 ++++++++++++++++=
++++++++
> >  1 file changed, 89 insertions(+)
>=20
> Hi Heiko,
>=20
> Any thoughts about this one? Can we perhaps get it merged for -next?

Does the gpio-backlight work on that device?
That would make the gpioset hack unnecessary.


Heiko




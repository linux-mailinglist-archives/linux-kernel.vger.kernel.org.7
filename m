Return-Path: <linux-kernel+bounces-811656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123FBB52C2C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D76953B3697
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69B72E54D3;
	Thu, 11 Sep 2025 08:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Y2dX9Cpz"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6732BCF43;
	Thu, 11 Sep 2025 08:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757580513; cv=none; b=nygDSqr7G35HXlCw/HGCeochx2CAmZprZB44dYcJi3CDjTei+lwqvIVc/JExzYR5t03xbZE9pwgYht+PIbuKXjk8FFDv8QmUTh8BwN1uhUQrBl2ol6zyvDgYoZuxUi3GMaSAFC/2zBKWpdE5DdrBddotVcqwcXgAbS9AixqDajo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757580513; c=relaxed/simple;
	bh=Ds8BlXfgI8bVbt4+3FkQ4VyJ3zNdY0T+TrEfbY1k9HQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kNm2WV/0f9QGvY5KquWMRXGPI0FkNUYsfq7j/brLz5+Seis5+4kTt7fl7M1gYzC1U12OiY9Mo2kfONJq/ndWEw1oXMVdO5hk4Ec2c5B2VobiHnxB2fWFph2jrigGrU5uAZdRYIptRVdox9TKjRGXbens9NfUi+AC9jvs/hLGkq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Y2dX9Cpz; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=zhx45ShbB/QPou0yiuhgDtnnTKKcIbOFazmtLWZzM94=; b=Y2dX9CpzR90Ul+yJ3csJVI7AOY
	YhefiRAgKoMFGxSrLRLgJPbDyB9p5d7hyCglCcVupfoK/X7xOYL1MSXH0zgol4x5Wy4laCKuRqmWS
	Xo1qrfg3Bh5wL7tWb+GgCcESPYVSp9PywjNXp0V0nQe1Do+WsOsCDVWxtz6UB2o8Jqg+3rkCiUSwR
	YTlYI5Wy30zD1bUcsExzESyS7QO5yyx3ha74sA5OXlIxF5HukzTMC5us6YxN2hE+VOTpT9U66WYKf
	yoTXS/0Ez8zETAVLj7rTYzGHnObKuoasbhWWneoJ+X0AT9d0g0oPcfvZ5IFnVbhIjDXGboxQI83zx
	qa88n9YQ==;
Received: from i53875b0e.versanet.de ([83.135.91.14] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uwcyi-0008Q9-CY; Thu, 11 Sep 2025 10:48:28 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Srinivas Kandagatla <srini@kernel.org>, Lee Jones <lee@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 2/2] nvmem: add driver for the eeprom in qnap-mcu controllers
Date: Thu, 11 Sep 2025 10:48:27 +0200
Message-ID: <2273730.1BCLMh4Saa@diego>
In-Reply-To: <20250911084119.GF9224@google.com>
References:
 <20250730172248.1875122-1-heiko@sntech.de>
 <8721df1d-d8db-4b05-b450-107d936d8715@kernel.org>
 <20250911084119.GF9224@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Lee,

Am Donnerstag, 11. September 2025, 10:41:19 Mitteleurop=C3=A4ische Sommerze=
it schrieb Lee Jones:
> On Tue, 09 Sep 2025, Srinivas Kandagatla wrote:
> > On 7/30/25 6:22 PM, Heiko Stuebner wrote:
> > > The qnap-mcu also has an eeprom connected to it, that contains some
> > > specific product-information like the mac addresses for the network
> > > interfaces.
> > >=20
> > > Add a nvmem driver for it.
> > >=20
> > > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > > ---
> > >  drivers/mfd/qnap-mcu.c          |   1 +
> > >  drivers/nvmem/Kconfig           |   9 +++
> > >  drivers/nvmem/Makefile          |   2 +
> > >  drivers/nvmem/qnap-mcu-eeprom.c | 110 ++++++++++++++++++++++++++++++=
++
> > >  4 files changed, 122 insertions(+)
> > >  create mode 100644 drivers/nvmem/qnap-mcu-eeprom.c
> > >=20
> > In case Lee you want to take this via MFD,
> >=20
> > Acked-by: Srinivas Kandagatla <srini@kernel.org>
>=20
> Actually this patch should be split up.
>=20
> I'll take the MFD part, you can take the NVMEM part.

(1) the original problem was, that this patch essentially requires
  "mfd: qnap-mcu: Include linux/types.h in qnap-mcu.h shared header" [0]
to not break builds, hence was "supposed" go into the mfd tree after [0]
got applied.

But as we're close to -rc6 anyway, we can also just move things after the
next merge-window if that is better.

(2) For the splitting part, just to make sure I understand correctly, you'd
like the part of

@@ -346,6 +346,7 @@ static const struct qnap_mcu_variant qnap_ts433_mcu =3D=
 {
 };
=20
 static struct mfd_cell qnap_mcu_cells[] =3D {
+       { .name =3D "qnap-mcu-eeprom", },
        { .name =3D "qnap-mcu-input", },
        { .name =3D "qnap-mcu-leds", },
        { .name =3D "qnap-mcu-hwmon", }

to be its own patch for the mfd subsystem?

Thanks
Heiko



[0] https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/commit/?h=
=3Dfor-mfd-next&id=3De379ee309fcfa70fca4d3b03815159397e1b0551




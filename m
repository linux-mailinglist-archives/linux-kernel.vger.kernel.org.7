Return-Path: <linux-kernel+bounces-842989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E44AEBBE24A
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 15:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BB023A6ECC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 13:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6133E298CD7;
	Mon,  6 Oct 2025 13:09:46 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E74C28DB56
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 13:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759756186; cv=none; b=BD+O1TEKNtmkEkyYFgC6UGtiGC/tGUbxJ8SluPn/htcrSEl5MuDPQq/RoXYq2lGtDvE5MImugofT9V+LhGdlJfkvoj8ebfvlbJNEup81cyX1tsaRxJjldH/5jmrqtqlBEkR1yeyF5tPgsgF0WBfOXhih1+sLzsLRnJArAwjbsDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759756186; c=relaxed/simple;
	bh=V1jL8Cp578efegsvBAdKZXpkptOyBF9OHb3REHf49JI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mjuXLAH2eLyJGS3ofTB9w42/8/L7k/EoaK9k0znnsroJmtanhqIt5U4pujHS9eNJxL3YFKQF55tZ45BC3MVnbswZNVDeouKIxOYqAzgzQgiCKjMRrFZDEbQIQcUbxhKuasdMO/GR5Jm635AvGPFaW4FODBxvsOoe4c6V6NYmWuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1v5ky3-0006IW-7H; Mon, 06 Oct 2025 15:09:31 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1v5ky0-002Eb3-38;
	Mon, 06 Oct 2025 15:09:28 +0200
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1v5kxv-000000009q1-3bRt;
	Mon, 06 Oct 2025 15:09:23 +0200
Message-ID: <bf3de9ecf10a3f6a63a6f2e235369519cb2f63e8.camel@pengutronix.de>
Subject: Re: [PATCH] reset: core: reset-gpio: Suppress registration error
 for optional resets
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Andre Przywara <andre.przywara@arm.com>, Krzysztof Kozlowski
	 <krzysztof.kozlowski@linaro.org>
Cc: linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Date: Mon, 06 Oct 2025 15:09:23 +0200
In-Reply-To: <20251002222826.16516-1-andre.przywara@arm.com>
References: <20251002222826.16516-1-andre.przywara@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Andre,

On Do, 2025-10-02 at 23:28 +0100, Andre Przywara wrote:
> For reset controllers that are marked as optional, we should skip errors
> during probing and return NULL, to avoid unnecessary failures. The
> reset-gpio controller does this mostly, but returns the true error in
> case the __reset_add_reset_gpio_device() call fails. Treat this call the
> same as the other registration errors, and consider the optional flag.
>=20
> One could argue that at this point it's a proper error that should not
> be ignored anymore, but in case of the reset-gpio controller this is not
> entirely true, since the code at the moment does not support GPIO
> controllers with three #gpio-cells - there is a TODO comment about this
> in that said function. So to avoid unnecessary probe fails for devices
> using reset-gpios (it's an optional reset after all), let's treat an
> error as still optional at this point.
>=20
> This fixes operation of WiFi chips on Allwinner boards, where some use
> reset-gpios, and which currently fail because all Allwinner SoCs use
> GPIO controllers with 3 cells.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/reset/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index 22f67fc77ae53..c2ccd08fb36e1 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
> @@ -1044,7 +1044,7 @@ __of_reset_control_get(struct device_node *node, co=
nst char *id, int index,
> =20
>  		ret =3D __reset_add_reset_gpio_device(&args);
>  		if (ret) {
> -			rstc =3D ERR_PTR(ret);
> +			rstc =3D optional ? NULL : ERR_PTR(ret);

Please move this into __reset_add_reset_gpio_device() and pass flags
into it. Only the -ENOENT return value mentioned in the commit
description should be suppressed by the optional flag, not any -ENOMEM.
And especially not the return value of __reset_add_reset_gpio_lookup(),
which may be -EPROBE_DEFER.

regards
Philipp


Return-Path: <linux-kernel+bounces-854668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF28BDF0CB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E37C34EC111
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD932D0627;
	Wed, 15 Oct 2025 14:30:27 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CAE288514
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760538626; cv=none; b=M141MEUNOU/Agxf5NUunpnopWb5xoqp6B7pepdcA9Wn8MtbwMdsr/cd3KRLFW9K8IuR0HTA/6fSUtG3c2WrDRRlB62Fpo5z4xYbvaBmrM+CcIlp/L3Gc0LcghuyAcDaCitw188ceIDIn1DgBWjDOhoqugETKlLWaiqIKABMiJcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760538626; c=relaxed/simple;
	bh=K1Tvo+DSqF9WNYYWJ+n9c3j2ga4uXkmmj4T88S0x2LA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M5oYq0YD27Ypbhgk56LUYiBl9uaGScQQSbBkboESmT954JK9Fwf6cuezE8S/9VKjyjvBGKQr4iyBEkPPcvL4DT1zTxmoqOrW2HFPqiu8VABqC8zJA3bI41Fc4Vu6DJSS7otUhGXBMOnryGdfO6p4kPPbkrffLWuJa7fPzk167w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1v92W2-0007UK-Qi; Wed, 15 Oct 2025 16:30:10 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1v92W2-003jpM-04;
	Wed, 15 Oct 2025 16:30:10 +0200
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1v92W1-00000000BcA-3x2x;
	Wed, 15 Oct 2025 16:30:09 +0200
Message-ID: <c4996204c8b72f10324af87516b92a3a2819091c.camel@pengutronix.de>
Subject: Re: [RFC PATCH] reset: always bail out on missing RESET_GPIO driver
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-renesas-soc@vger.kernel.org
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Krzysztof
 Kozlowski	 <krzysztof.kozlowski@linaro.org>, linux-kernel@vger.kernel.org
Date: Wed, 15 Oct 2025 16:30:09 +0200
In-Reply-To: <20251015112921.19535-2-wsa+renesas@sang-engineering.com>
References: <20251015112921.19535-2-wsa+renesas@sang-engineering.com>
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

Hi Wolfram,

On Mi, 2025-10-15 at 13:28 +0200, Wolfram Sang wrote:
> Optional GPIOs mean they can be omitted. If they are described, a
> failure in acquiring them still needs to be reported. When the
> RESET_GPIO is not enabled so the reset core cannot provide its assumed
> fallback, the user should be informed about it. So, not only bail out
> but also give a hint how to fix the situation.
>=20
> Reported-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Closes: https://lore.kernel.org/r/87a51um1y1.wl-kuninori.morimoto.gx@rene=
sas.com
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>=20
> This happened because of this (in general) nice cleanup patch for the
> pca954x driver (690de2902dca ("i2c: muxes: pca954x: Use reset controller
> only")). Our .config didn't have the RESET_GPIO enabled before, so sound
> regressed on some boards.

Ouf, I should have noticed and asked if RESET_GPIO is enabled on all
affected platforms when that patch was proposed.

> Actually, my preferred solution would be to make the reset-gpio driver
> 'obj-y' but I guess its dependency on GPIOLIB makes this a no-go?

I think so, yes. Also it's only needed in (currently) a very small
number of cases.

> On the other hand, the fallback is a really nice feature which could
> remove duplicated code. But if the fallback is not present by default,
> it makes it cumbersome to use IMO.

And it's not easy to automatically determine whether RESET_GPIO is
actually required, because that depends on both device tree and
individual drivers.

> Has this been discussed before? I couldn't find any pointers...

I don't remember this being discussed before.

> Happy hacking, everyone!
>=20
>=20
>  drivers/reset/core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index 22f67fc77ae5..8a0f41963f6b 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
> @@ -1028,8 +1028,10 @@ __of_reset_control_get(struct device_node *node, c=
onst char *id, int index,
>  	if (ret =3D=3D -EINVAL)
>  		return ERR_PTR(ret);
>  	if (ret) {
> -		if (!IS_ENABLED(CONFIG_RESET_GPIO))
> -			return optional ? NULL : ERR_PTR(ret);
> +		if (!IS_ENABLED(CONFIG_RESET_GPIO)) {
> +			pr_warn("%s(): RESET_GPIO driver not enabled, cannot fall back\n", __=
func__);
> +			return ERR_PTR(ret);
> +		}
> =20
>  		/*
>  		 * There can be only one reset-gpio for regular devices, so

The reset-gpios phandle check should be done first, then. The warning
only makes sense if that property exist, and returning -ENOENT for an
optional reset is wrong if neither phandle property exists in the DT.

I think putting the IS_ENABLED check first was intended to save an
unnecessary "reset-gpios" phandle lookup on kernels with
CONFIG_RESET_GPIO=3Dn.

In short, if both of_parse_phandle_with_args() return -ENOENT, we
should continue to silently return (optional ? NULL : -ENOENT), even if
CONFIG_RESET_GPIO=3Dn.

I think the message should be pr_err() level if we return an error that
will cause the consumer driver probe to fail.

regards
Philipp


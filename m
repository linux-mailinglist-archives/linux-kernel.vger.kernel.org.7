Return-Path: <linux-kernel+bounces-791949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A5FB3BE93
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1346D1899A3F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFEE321427;
	Fri, 29 Aug 2025 14:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wkhBkg+A"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E8531CA77
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 14:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756479209; cv=none; b=LS3ZueO4LNj8iTaMj6YolUaiRf0llhVQ0JJkIMg0p+yKCZT9urPaTEOEKLCS2IOdh87kQ9IDP9cXR6yr9XhdNOyjox5fkqOJmKhhU4B8+O4rd3OHuChApZ8ItN2z2gCcHP+MhzwK5NlDd9SEFpP77j4I5HLu0RXBQAnQrZJFB2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756479209; c=relaxed/simple;
	bh=kBmhdY41MuuGaErU9JOcCvqTMBfBCKMYKyDrfB8dQvE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ifl2Np8rSCciBmHe+oz9AOJsC1hA64jEdm02zhhNwFJfOb4pNzs2jxoyBaF56x9a4B4ZZuHJehKrWLfKGFXPlJ2rezwxl39eJI51FXT1c2881TeY6ZlzmZDONENv8B/7/qdBLFaCr8H31qya7yzFhPV3ezr8eeQsq9douuEB5Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wkhBkg+A; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3D0361A0E42;
	Fri, 29 Aug 2025 14:53:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 143EE605F1;
	Fri, 29 Aug 2025 14:53:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BC74D1C22D7F6;
	Fri, 29 Aug 2025 16:53:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756479202; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4ckzePFQYp/N4R7lFdjnp5WArUDphEJKP4hsZQnN0IY=;
	b=wkhBkg+AG4oSLegWFI1ccpS8UjAid+4QPBuZQb/T7MxcTtIrdaFKiXGWgkVF1APhb365H6
	r8x704yeFX5la1/WFPXq0PigKF//1A0loE4JlCJaMFaM5D1iApbJrBbnaN82oqlK8jaPfH
	y4ouRHsCpzjPri/34rNmuRv8fckvKzRko8WlD6u8nvGo0VuhaCf9Yzita0fF5xV01yHEMW
	GcaQ3Pf64xZwrYB4N+LmMDrOolgbCdXuL/lwWskRhOhw4T1c7O6oLYmlt2VIz+qOnQMy7t
	SbAHMZhMTbCrStdGsIyZZFK2xb+AZH/wodikL+B/5C474jqRVTdcV1fcKKXNpQ==
Date: Fri, 29 Aug 2025 16:53:10 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <richardcochran@gmail.com>,
 <Parthiban.Veerasooran@microchip.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 2/2] net: phy: micrel: Add PTP support for
 lan8842
Message-ID: <20250829165310.2b97569b@kmaincent-XPS-13-7390>
In-Reply-To: <20250829134836.1024588-3-horatiu.vultur@microchip.com>
References: <20250829134836.1024588-1-horatiu.vultur@microchip.com>
	<20250829134836.1024588-3-horatiu.vultur@microchip.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Fri, 29 Aug 2025 15:48:36 +0200
Horatiu Vultur <horatiu.vultur@microchip.com> wrote:

> It has the same PTP IP block as lan8814, only the number of GPIOs is
> different, all the other functionality is the same. So reuse the same
> functions as lan8814 for lan8842.
> There is a revision of lan8842 called lan8832 which doesn't have the PTP
> IP block. So make sure in that case the PTP is not initialized.

...
=20
> @@ -5817,6 +5831,43 @@ static int lan8842_probe(struct phy_device *phydev)
>  	if (ret < 0)
>  		return ret;
> =20
> +	/* Revision lan8832 doesn't have support for PTP, therefore don't add
> +	 * any PTP clocks
> +	 */
> +	ret =3D lanphy_read_page_reg(phydev, LAN8814_PAGE_COMMON_REGS,
> +				   LAN8842_SKU_REG);
> +	if (ret < 0)
> +		return ret;
> +
> +	priv->rev =3D ret;
> +	if (priv->rev =3D=3D 0x8832)
> +		return 0;

Is the lan8832 PHY ID the same as the lan8842? This would be surprising.
If they have different PHY ID, it will never enter the lan8842 probe functi=
on as
it is not added to mdio_device_id.
Also you should add a define instead of using several time 0x8832.

...

> @@ -5912,6 +5989,26 @@ static irqreturn_t lan8842_handle_interrupt(struct
> phy_device *phydev) ret =3D IRQ_HANDLED;
>  	}
> =20
> +	/* Phy revision lan8832 doesn't have support for PTP threrefore

nitpick: therefore

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


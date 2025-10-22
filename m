Return-Path: <linux-kernel+bounces-865271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A7EBFCA61
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46E6219A2ABC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A7B34B41B;
	Wed, 22 Oct 2025 14:45:47 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B990A944
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761144346; cv=none; b=iJkBosAFmmwla9C7RQJtD87K4IvJsXgrpTyYLBxfWXQgjNWGbBpFep9pIOlw96cP3ORNOlUzs42jeb9gWulap+VDMHAufLdUMZECjN0iSMag6O5P5KZaCWc2RAE415Hif9+ZedvRVRCY2XpMKH/Pag8KRa+7JTyF6WYtWkqFDtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761144346; c=relaxed/simple;
	bh=l3yECMFBS5GtPu7WxGB9i4GfkdHrGiUKLZ40MWr/sOM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QyIoAa0N6JP2EhfyGo3Xja1+cP04Q3QIfEM+IObUfeDN+LrxweHo4iQlClWgdyPwVn44hH0Vhf4flJ+BGWx7zZidD2uDwjlzJH7bQqIkuMTw6L/BXWEfVV+gvs+4mo9wK8bN1O4855Xz460MsL+/no1387gyrmXTIT1j5oYfTOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vBa5k-00089X-9I; Wed, 22 Oct 2025 16:45:32 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vBa5j-004uL3-2v;
	Wed, 22 Oct 2025 16:45:31 +0200
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vBa5j-00000000BDk-3Sv3;
	Wed, 22 Oct 2025 16:45:31 +0200
Message-ID: <afdcde3c2ce49f42740e3e436d78d2796bead3ad.camel@pengutronix.de>
Subject: Re: [PATCH v2 7/9] reset: make the provider of reset-gpios the
 parent of the reset device
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij	
 <linus.walleij@linaro.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>,  Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus	
 <sakari.ailus@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  "Rafael J. Wysocki"	 <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Krzysztof Kozlowski	 <krzk@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>
Date: Wed, 22 Oct 2025 16:45:31 +0200
In-Reply-To: <20251022-reset-gpios-swnodes-v2-7-69088530291b@linaro.org>
References: <20251022-reset-gpios-swnodes-v2-0-69088530291b@linaro.org>
	 <20251022-reset-gpios-swnodes-v2-7-69088530291b@linaro.org>
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

On Mi, 2025-10-22 at 15:41 +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>=20
> Auxiliary devices really do need a parent so ahead of converting the
> reset-gpios driver to registering on the auxiliary bus, make the GPIO
> device that provides the reset GPIO the parent of the reset-gpio device.
> To that end move the lookup of the GPIO device by fwnode to the
> beginning of __reset_add_reset_gpio_device() which has the added benefor

Still typo: benefit.

> of bailing out earlier, before allocating resources for the virtual
> device, if the chip is not up yet.
>=20
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/reset/core.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index 5a696e2dbcc224a633e2b321da53b7bc699cb5f3..ad85ddc8dd9fcf8b512cb0916=
8586e0afca257f1 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
[...]
> @@ -919,6 +915,11 @@ static int __reset_add_reset_gpio_device(const struc=
t of_phandle_args *args)
>  	if (args->args_count !=3D 2)
>  		return -ENOENT;
> =20
> +	struct gpio_device *gdev __free(gpio_device_put) =3D
> +		gpio_device_find_by_fwnode(of_fwnode_handle(args->np));
> +	if (!gdev)
> +		return -EPROBE_DEFER;
> +
>  	/*
>  	 * Registering reset-gpio device might cause immediate
>  	 * bind, resulting in its probe() registering new reset controller thus

Please move this after the lockdep_assert_not_held(), as discussed.

With that change,

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp


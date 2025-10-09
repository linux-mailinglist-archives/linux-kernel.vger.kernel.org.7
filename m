Return-Path: <linux-kernel+bounces-847372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 46691BCAAA4
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 21:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB07E4ED2CD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 19:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DDB25742C;
	Thu,  9 Oct 2025 19:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1ErGPZ7H"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2E22566E2
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 19:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760037222; cv=none; b=RvupJBkxgSh5h6u4O++oZeiY5oMKAORt2gE6MQ6euvza4U8AWiHSjGfMv9JYUErbkOEl4wcfOurY3Pjoi0UuJEnxuGg07kILEVkiijrzKO0YuKz0IroZs+unVLLhTf7Y8IPMKhX6+xFe4cJYzpb97JGQWKpMmlweZ5gTyVbWR+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760037222; c=relaxed/simple;
	bh=DrVzT4qQlnwhzZJ7Zk7bJ5ieuCE6DLcCPb5WQwSENjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5J7YKM/ekSW9RxqiuBxuUGwR5IvQDboYR4rhLuFC3oJgZobN/NaPJFEW352EuD+MTDMekJAJbWYkUqPt+sYJh7YEfifvpOv754HtFt47bQ6dK+O/XPSnXFkb/5U8SLgG2r22KNS5C9tzOyyyX973cC5hCEtl0ep2b3RBYdS58o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1ErGPZ7H; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-794e300e20dso1075743b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 12:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760037216; x=1760642016; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iOSCy56bqYjv1nF3mp941PWU8Gn0Ei1sbikd3uwYoDs=;
        b=1ErGPZ7HAg9wi4J1+zW45+hVOgeY7VL1MSCP0ihu4hQpdhpz/Q+hpNh3gmlzqDDbyF
         tnAgdi6gQWFZG7eGOS2YC/eNItoiRYk8RWcjvZ/TAFzTxzmJ/5tT8jaJbq9DMXW5ulvB
         bl6HY+VDyUWJ8Snmw5XOZ9Vcxpi1w80G+sjrA4/IRs4ZLtSTNK9EGh+3GdUpI0D/G9Wi
         nc1UDWLwIdFMrts9T/+xvp+zEWMbF4FjyWXlLuC6ygCHkjfJnfjcUkqjUDlROKYKIhJi
         f6mempYY2L58d91WLbQd7AQK3cpTdbwXDCtpHodxOfzY8LEG0ilul5VHLp0xR3F7W5oE
         ZblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760037216; x=1760642016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOSCy56bqYjv1nF3mp941PWU8Gn0Ei1sbikd3uwYoDs=;
        b=Rjy8ixCeWmYbSeretLXq9Yb6s+85dY/rpnZ/kxhyL2SKYeVMPbbdlV2ftwEbeOGhvs
         YWZiXHp84P931O68fgFDECa7N1aQ0kv7A1zcHyQQCar/2jPB2QngyW3HxQwNBaIYa4Zj
         QU6Jq960mLFrQ9sPzR9ty23ixk6UsVjaH73EB/ucmdZUrui3xPh9PCGENxIN4ZHN1L7Y
         D4bqtw5nk6IGNrLfF3qWUeESqTLglX/APTsYBJv08uZoMxTVC+ybq6i2z9jgLs1Pyhe5
         f0cHJvGB4KCdAaun3MrOnhrJIJlSoGP50g/KQtTkFJ+1J+ST/CycaO5kkAd9mPF93S1c
         Ddaw==
X-Forwarded-Encrypted: i=1; AJvYcCUOJl/Sx3iUqfRA0Vy7z2lUmd92jlHi/AaSGrwcafLEHsNqyNkJcWp51rx4YDpzDeT43QIu4yFQRrold3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YypAmUq7feqXaIJOJc8FmaKFf+oEnaAAJu01WqulyR6nS8OGv+I
	ikposEhPT28D9d13iavS3fBpMdJHKxRpDigyaa+YvcQFUdFbfgxgie8zp0wSVRGACQ==
X-Gm-Gg: ASbGncvaf0RFSfVe/UB+SqZ3khcFZy5Dgbi3MBKO1SWGgo8V/DhGGyIx68mAyDhTWSC
	AMSWxX4ScyCp8m/5KSNJ9JPcjxMdG/oFDSFbVXOoYdkj1XHlgiepqwrpT1Dq7U6QxrydunGPBqJ
	I7rYCS8C8qGedHqVSl5IwfHGZyKnp0KwYKUIRSUEt/KRcZPpfc+sphglk9bCUuugzgzIioKxE0+
	KFJHDrju+3zX0YCR13FBuCxDPGwFli2gRWPKxFGwsxhAQQKTM1XG9TisuWxc9bxrrTh7nJmTM3S
	fOhCQjUVKMr/iO+bGJ0Ip5QEBCwIfe5ic+LrLYl7MUhK5kjqB9Y3i7kVIVVo/9/mwq8EPDTIdqU
	g8adB1E2Hguq+ARal+tuv1I2CYC/YewQvv9ZXQPdUdS8nqUtC+ayrca/hYDDQVSxBAwk4dZ8lGL
	pjFtVFRCnkKA==
X-Google-Smtp-Source: AGHT+IEEnUYCsb1ig8WOq5UjpbnlJYhdXQVdJ1T9XijXib3yOVoxgg9VmVsHFrdAuk8oT5KR1DKNRA==
X-Received: by 2002:a05:6a20:6a22:b0:246:3a6:3e47 with SMTP id adf61e73a8af0-32da8e2ba5cmr10180448637.12.1760037216071;
        Thu, 09 Oct 2025 12:13:36 -0700 (PDT)
Received: from google.com (232.92.83.34.bc.googleusercontent.com. [34.83.92.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992dd7ee5bsm455211b3a.85.2025.10.09.12.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 12:13:34 -0700 (PDT)
Date: Thu, 9 Oct 2025 19:13:31 +0000
From: Benson Leung <bleung@google.com>
To: Jameson Thies <jthies@google.com>
Cc: akuchynski@chromium.org, abhishekpandit@chromium.org,
	krzk+dt@kernel.org, robh@kernel.org, bleung@chromium.org,
	heikki.krogerus@linux.intel.com, ukaszb@chromium.org,
	tzungbi@kernel.org, devicetree@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] mfd: cros_ec: Don't add cros_ec_ucsi if it is
 defined in OF or ACPI
Message-ID: <aOgJW2gOuwulIMny@google.com>
References: <20251009010312.2203812-1-jthies@google.com>
 <20251009010312.2203812-4-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gdyhNSmhYhPSv1Bb"
Content-Disposition: inline
In-Reply-To: <20251009010312.2203812-4-jthies@google.com>


--gdyhNSmhYhPSv1Bb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2025 at 01:03:08AM +0000, Jameson Thies wrote:
> On devices with a UCSI PPM in the EC, check for cros_ec_ucsi to be
> defined in the OF device tree or an ACPI node. If it is defined by
> either OF or ACPI, it does not need to be added as a subdevice of
> cros_ec_dev.
>=20
> Signed-off-by: Jameson Thies <jthies@google.com>

Reviewed-by: Benson Leung <bleung@chromium.org>


> ---
>  drivers/mfd/cros_ec_dev.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index dc80a272726b..1928c2ea2b8f 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -5,6 +5,7 @@
>   * Copyright (C) 2014 Google, Inc.
>   */
> =20
> +#include <linux/acpi.h>
>  #include <linux/dmi.h>
>  #include <linux/kconfig.h>
>  #include <linux/mfd/core.h>
> @@ -131,11 +132,6 @@ static const struct cros_feature_to_cells cros_subde=
vices[] =3D {
>  		.mfd_cells	=3D cros_ec_rtc_cells,
>  		.num_cells	=3D ARRAY_SIZE(cros_ec_rtc_cells),
>  	},
> -	{
> -		.id		=3D EC_FEATURE_UCSI_PPM,
> -		.mfd_cells	=3D cros_ec_ucsi_cells,
> -		.num_cells	=3D ARRAY_SIZE(cros_ec_ucsi_cells),
> -	},
>  	{
>  		.id		=3D EC_FEATURE_HANG_DETECT,
>  		.mfd_cells	=3D cros_ec_wdt_cells,
> @@ -264,6 +260,23 @@ static int ec_device_probe(struct platform_device *p=
dev)
>  		}
>  	}
> =20
> +	/*
> +	 * FW nodes can load cros_ec_ucsi, but early PDC devices did not define
> +	 * the required nodes. On PDC systems without FW nodes for cros_ec_ucsi,
> +	 * the driver should be added as an mfd subdevice.
> +	 */
> +	if (cros_ec_check_features(ec, EC_FEATURE_USB_PD) &&
> +	    cros_ec_check_features(ec, EC_FEATURE_UCSI_PPM) &&
> +	    !acpi_dev_found("GOOG0021") &&
> +	    !of_find_compatible_node(NULL, NULL, "google,cros-ec-ucsi")) {
> +		retval =3D mfd_add_hotplug_devices(ec->dev,
> +						 cros_ec_ucsi_cells,
> +						 ARRAY_SIZE(cros_ec_ucsi_cells));
> +
> +		if (retval)
> +			dev_warn(ec->dev, "failed to add cros_ec_ucsi: %d\n", retval);
> +	}
> +
>  	/*
>  	 * UCSI provides power supply information so we don't need to separately
>  	 * load the cros_usbpd_charger driver.
> --=20
> 2.51.0.710.ga91ca5db03-goog
>=20

--gdyhNSmhYhPSv1Bb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCaOgJWwAKCRBzbaomhzOw
wpmvAP9BRKC8tzJCIcuD4p8sAtDTojfzvAT7272ct6sdoX/8gQD/U725yeINVisu
v5I0X5yXr45fO2RNjUgA0hRB+v4oWgQ=
=DzaU
-----END PGP SIGNATURE-----

--gdyhNSmhYhPSv1Bb--


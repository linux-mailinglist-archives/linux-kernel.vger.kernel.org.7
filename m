Return-Path: <linux-kernel+bounces-879081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F10C22399
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4992A4F4797
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 20:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B4833555E;
	Thu, 30 Oct 2025 20:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C3jcCa53"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEA7329E7C
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 20:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761855471; cv=none; b=dSGWCV0SfOXT14gPzysuu7M4BGXaBxfunAWyEB6yRR9vJ93za3LN4zMAgiGn9TynATlY+Lr/ZzwhjU4Q3JD0OFct1iODBo4pSAkAz8TuuddDWSvS/sL4iiT2qaBrmM5EMnWhGZCXtVZTlF2DgkVU3wsMtRYhrDy4il0iIZn5qJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761855471; c=relaxed/simple;
	bh=9kRtTIBc07WnTizjvaJzLZPcLgBCogzq2Ghqk4DD7Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7TIkd/tjRGFA4JZrNWXZ/eo0rDiUdcU1BYPeX3O/+1LZshcdpV0k751t7311chprOODno9kkNI7VK5QELy5meuV75pzZAywL0VRQkFDlDy5i1qzYlecfa8l9YObx/VRQ+JTz54MCQNKDUi72vSQbfMar/jWgLc0BYF5TJo+6vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C3jcCa53; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34029a194bcso1748935a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761855469; x=1762460269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=151EPhAD4JHY/5K1q8Ff6wP++DpVmKl/O93jobS2q2s=;
        b=C3jcCa53Bycsgc1njjjrSJ+agX06YDRPsF43oLg/sIqKMmo0Z1eKtwKj8IGhN4ev+j
         XTQRdp+rcs376fuWih93rzL67rSGFFjYgRp2y7yuAJbetxUKNJcEvGN/eVKf/h3LNV+1
         vlo5YoVc+V2X2IR81jRR4plHg+b8ok6FGebYJIDVP7zDdeYhT4Vz/xaBtsMmo45f3PFE
         NSnEkNYK8BqqxxIvfRytHWB0+Ed2Qfd/PM41lSkr5iOLMs43ktLIe+NHpVVehtg8QLHh
         TMTe1gPUj7WPRziVvkivJFfwPGJlEYf6NtgEJq4llyPFSEBzm3LLYjDzpg8dqGOexRCR
         DE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761855469; x=1762460269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=151EPhAD4JHY/5K1q8Ff6wP++DpVmKl/O93jobS2q2s=;
        b=J+nmuFmsucFKq1n/aqtB52K1J/5VAAJ9sb/KXq14Ld38lYW0qtYAtCtIMppLXQ0+8s
         ELsJQQJyC2rUuwGostiMWnohcxADZcmdPzAxv9gRfIOzE6J6zEzXhtEn0a8fbfVYoe/0
         lCqtrt5RHffOdWs8QOyTatiVAltoN9lkLCzFoKps8ZNWEYYrr4HobYRUglM+uPG17KKg
         VZ2AI1kDemS6xj1RpWFmVVQWLR0EbGcBmOEG9abDOiWbsU5rmwi43iu2ZuosW8T4OQar
         ZqarU3qtZxU9j4qUdNUbzr0V2mmPgyvhepN4sodDS7K03kJkL3PN2Vo0FfZkPIXdcvi5
         7k9w==
X-Forwarded-Encrypted: i=1; AJvYcCVsy5yTWuq/oGTnE2NwSFBLtIBBcxAlPgGXDVmG5tQHx+Cz1UujDxqDaid23IKNDYoiel1CA25/zUpU2i0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX/o11P2nRg8B1NAwLyg8gE4HRbFBeTLev1GEhiZk05vkJ5prb
	iqZxRnSNSS3GJTY+HGfo5V7i8oBg6CDKhNX/P6Eb7xR3gVm+QIbvYb6CY2i304NGzQ==
X-Gm-Gg: ASbGncv6hdmpnthdRRzYdPFM+4Ajt1SMhkmp19BeBJWHm/0THQ/MuqvWFkWmRdH/KIU
	uLSnWQExpcebwKaLfqWneGVKF2ADrlgKW/yANMbEEeflERJpZz/ZqK/vyvGwMsGpB7v9Ybn6nX3
	dJQh6JiUMW7gbBVrKfaJi8/d5YghvjdqSh4skX+xvbMv2sNfCUmJ+qR6+wDdL2vbKUXIK3qbeWg
	6JljYLua/GlRgch0nOKQcJKfHcQPiHYVfudM3uDxh/GE295yAfQTM7mjdyJkm6WGxO5T6SoDp+7
	TQa3bU3SjC/hu1XFO5Y/ZgX9rzZ6MMnR9UIgzh/j0VjrQ86GXRqyUjLlSHPA6m0Qb5sKjeUDCPG
	ki6I27UEo9h661hZJBAo1q1mqkCwoSkivoNJNuKmqv1O/GrUgiYqg6wph2J75tyikus/673ZRQ/
	9MCglZpEstOgrVCIZSRRocE/92n8aTi10G
X-Google-Smtp-Source: AGHT+IH6AU4NoorV5ouyjbLnksFBmEWlixg+IUFM1/RrhbDecyv2diBUOjwkESjNW4zqwzRv5X8ETA==
X-Received: by 2002:a17:903:32c8:b0:28e:a70f:e879 with SMTP id d9443c01a7336-2951a36c289mr14370265ad.1.1761855468555;
        Thu, 30 Oct 2025 13:17:48 -0700 (PDT)
Received: from google.com (232.92.83.34.bc.googleusercontent.com. [34.83.92.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf49easm199598005ad.9.2025.10.30.13.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 13:17:47 -0700 (PDT)
Date: Thu, 30 Oct 2025 20:17:43 +0000
From: Benson Leung <bleung@google.com>
To: Brady Norander <bradynorander@gmail.com>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH] platform/chrome: cros_ec_lightbar: Check if ec supports
 suspend commands
Message-ID: <aQPH5_gLKFbVDeSH@google.com>
References: <20251023234239.23882-2-bradynorander@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="G7TLzwSYCEpVDVLw"
Content-Disposition: inline
In-Reply-To: <20251023234239.23882-2-bradynorander@gmail.com>


--G7TLzwSYCEpVDVLw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 07:42:40PM -0400, Brady Norander wrote:
> The Chromebook Pixel 2013 (Link)'s ec does not support the lightbar manua=
l suspend commands.
> As a result, attempting to suspend the device fails and prints the follow=
ing error:
>=20
>     cros-ec-lightbar cros-ec-lightbar.3.auto: PM: dpm_run_callback(): pla=
tform_pm_suspend returns -22
>     cros-ec-lightbar cros-ec-lightbar.3.auto: PM: failed to suspend: erro=
r -22
>     PM: Some devices failed to suspend, or early wake event detected
>=20
> Check the return value of lb_manual_suspend_ctrl in cros_ec_lightbar_prob=
e and disable manual
> suspend control if an error is returned.
>=20
> Signed-off-by: Brady Norander <bradynorander@gmail.com>

Reviewed-by: Benson Leung <bleung@chromium.org>

>=20
> diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platfor=
m/chrome/cros_ec_lightbar.c
> index 87634f6921b7..1b7e4c4e18bc 100644
> --- a/drivers/platform/chrome/cros_ec_lightbar.c
> +++ b/drivers/platform/chrome/cros_ec_lightbar.c
> @@ -30,6 +30,13 @@ static unsigned long lb_interval_jiffies =3D 50 * HZ /=
 1000;
>   */
>  static bool userspace_control;
> =20
> +/*
> + * Whether or not the lightbar supports the manual suspend commands.
> + * The Pixel 2013 (Link) does not while all other devices with a
> + * lightbar do.
> +*/
> +static bool has_manual_suspend;
> +
>  static ssize_t interval_msec_show(struct device *dev,
>  				  struct device_attribute *attr, char *buf)
>  {
> @@ -550,7 +557,7 @@ static int cros_ec_lightbar_probe(struct platform_dev=
ice *pd)
>  		return -ENODEV;
> =20
>  	/* Take control of the lightbar from the EC. */
> -	lb_manual_suspend_ctrl(ec_dev, 1);
> +	has_manual_suspend =3D (lb_manual_suspend_ctrl(ec_dev, 1) >=3D 0);
> =20
>  	ret =3D sysfs_create_group(&ec_dev->class_dev.kobj,
>  				 &cros_ec_lightbar_attr_group);
> @@ -569,14 +576,15 @@ static void cros_ec_lightbar_remove(struct platform=
_device *pd)
>  			   &cros_ec_lightbar_attr_group);
> =20
>  	/* Let the EC take over the lightbar again. */
> -	lb_manual_suspend_ctrl(ec_dev, 0);
> +	if (has_manual_suspend)
> +		lb_manual_suspend_ctrl(ec_dev, 0);
>  }
> =20
>  static int __maybe_unused cros_ec_lightbar_resume(struct device *dev)
>  {
>  	struct cros_ec_dev *ec_dev =3D dev_get_drvdata(dev->parent);
> =20
> -	if (userspace_control)
> +	if (userspace_control || !has_manual_suspend)
>  		return 0;
> =20
>  	return lb_send_empty_cmd(ec_dev, LIGHTBAR_CMD_RESUME);
> @@ -586,7 +594,7 @@ static int __maybe_unused cros_ec_lightbar_suspend(st=
ruct device *dev)
>  {
>  	struct cros_ec_dev *ec_dev =3D dev_get_drvdata(dev->parent);
> =20
> -	if (userspace_control)
> +	if (userspace_control || !has_manual_suspend)
>  		return 0;
> =20
>  	return lb_send_empty_cmd(ec_dev, LIGHTBAR_CMD_SUSPEND);
> --=20
> 2.51.0
>=20

--G7TLzwSYCEpVDVLw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCaQPH5wAKCRBzbaomhzOw
wnilAPsFQWOTspSuE+PX5XiXmMjyns4hNOhg0x58FJLn58jiJwEAsI1jRBUsHJT+
JIDeSbVH1XoEGPGuD70T0bjJxKLb6AA=
=1HoK
-----END PGP SIGNATURE-----

--G7TLzwSYCEpVDVLw--

